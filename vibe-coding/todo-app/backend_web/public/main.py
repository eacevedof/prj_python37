"""Front controller de la API. UNICO punto de entrada HTTP.

Este fichero es la excepcion a la regla "un fichero, una clase": aqui viven varias
funciones sueltas y ninguna clase. Es deliberado y esta permitido explicitamente en
el test de convencion. La razon: `app` tiene que ser una variable de modulo para
que uvicorn la encuentre (`public.main:app`), y todo el borde de autenticacion vive
junto para que se pueda auditar de un vistazo en un solo sitio.

No hay APIRouter ni decoradores `@app.post(...)` repartidos por el codigo. Las
rutas se declaran en `src/core/routes/routes.py` y se registran aqui en un bucle.
Ventaja: la lista completa de endpoints de la API cabe en una pantalla.
"""

from contextlib import asynccontextmanager
from pathlib import Path
from typing import Any, AsyncIterator, Callable

from fastapi import FastAPI, Request
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse

from src.core.config.database import init_db
from src.core.routes.routes import Routes
from src.modules.devops_mod.application.run_migrations.run_migrations_dto import RunMigrationsDto
from src.modules.devops_mod.application.run_migrations.run_migrations_service import RunMigrationsService
from src.modules.devops_mod.domain.enums.migration_result_enum import MigrationResultEnum
from src.modules.shared.domain.enums.auth_enum import AuthEnum
from src.modules.shared.domain.enums.auth_scope_enum import AuthScopeEnum
from src.modules.shared.domain.enums.request_key_enum import RequestKeyEnum
from src.modules.shared.domain.enums.response_code_enum import ResponseCodeEnum
from src.modules.shared.domain.enums.response_key_enum import ResponseKeyEnum
from src.modules.shared.domain.enums.response_message_enum import ResponseMessageEnum
from src.modules.shared.infrastructure.components.tokener.tokener import Tokener
from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)


def _run_migrations() -> None:
    """Aplica las migraciones pendientes. Se llama en cada arranque.

    Es idempotente: las que ya estan aplicadas se saltan. Por eso desplegar es
    simplemente levantar la app, y no hay ningun paso manual que se pueda olvidar.
    """
    # parents[1]: public -> backend_web
    migrations_path = Path(__file__).resolve().parents[1] / "database" / "migrations"
    run_migrations_result_dto = RunMigrationsService.get_instance()(
        RunMigrationsDto.from_primitives({MigrationResultEnum.MIGRATIONS_PATH: migrations_path})
    )
    print(
        f"[migraciones] aplicadas={run_migrations_result_dto.applied_count}"
        f" saltadas={run_migrations_result_dto.skipped_count}"
        f" fallidas={run_migrations_result_dto.failed_count}"
    )
    if run_migrations_result_dto.has_failures():
        # Arrancar con el esquema a medias solo mueve el fallo a la primera
        # peticion, donde es mucho mas dificil de diagnosticar.
        raise RuntimeError(f"migraciones fallidas: {run_migrations_result_dto.migrations}")


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncIterator[None]:
    """Lo que ocurre ANTES de servir la primera peticion y al apagar.

    Abre la conexion a la base de datos y aplica las migraciones pendientes. Ese
    orden importa: sin conexion no hay a que migrar.

    Que las migraciones corran en el arranque (y no con un comando aparte) es una
    decision del kit: desplegar es levantar la app, y no hay forma de olvidarse un
    paso. Son idempotentes, asi que arrancar mil veces no hace nada mil veces.
    """
    init_db()
    _run_migrations()
    yield


app = FastAPI(title="todo-app", lifespan=lifespan)


@app.get("/health-check")
def health() -> dict[str, Any]:
    """Comprobacion de vida. NO pide credencial: un monitor tiene que poder
    llamarla sin llave, y no revela nada sensible.

    Devuelve la version para poder responder a "¿esta desplegado mi cambio?" con
    un curl, sin entrar en el servidor.
    """
    environment_reader_raw_repository = EnvironmentReaderRawRepository.get_instance()
    return {
        ResponseKeyEnum.STATUS: ResponseMessageEnum.HEALTH_OK,
        RequestKeyEnum.VERSION: environment_reader_raw_repository.get_app_version(),
        RequestKeyEnum.ENVIRONMENT: environment_reader_raw_repository.get_environment(),
    }


def _is_auth_required(path: str) -> bool:
    """Toda ruta bajo /api/ pide credencial. El health-check no."""
    if path in AuthScopeEnum.EXEMPT_PATHS:
        return False
    return path.startswith(AuthEnum.API_PREFIX.value)


def _is_authorized(request: Request) -> bool:
    """Compara la cabecera X-Api-Key con la clave configurada en el `.env`.

    **Si la clave configurada esta vacia, deniega siempre.** Es la decision mas
    importante de esta funcion: sin ella, un `.env` a medio rellenar dejaria la
    API abierta a cualquiera y no habria ninguna senal de que eso ha pasado. Es
    preferible que no funcione nada -y se note- a que funcione todo para todos.
    """
    configured_api_key = EnvironmentReaderRawRepository.get_instance().get_api_key()
    if not configured_api_key:
        return False
    return Tokener.get_instance().is_same_secret(
        request.headers.get(AuthEnum.APIKEY_HEADER.value, ""), configured_api_key
    )


def _get_unauthorized_response() -> JSONResponse:
    status_code = int(ResponseCodeEnum.UNAUTHORIZED)
    return JSONResponse(
        status_code=status_code,
        content={
            ResponseKeyEnum.STATUS: status_code,
            ResponseKeyEnum.ERROR: ResponseMessageEnum.UNAUTHORIZED,
        },
    )


def _get_handler(
    controller_callable: Callable[[dict[str, Any]], dict[str, Any]],
) -> Callable[[Request], Any]:
    """Construye el handler generico de UNA entrada de la tabla de rutas.

    Es el mismo handler para todos los endpoints. Hace cuatro cosas y ninguna mas:

      1. Fusiona todas las entradas de la peticion en UN diccionario `body`.
      2. Llama al controller con ese diccionario.
      3. Lee `result["status"]` y lo usa como codigo HTTP.
      4. Serializa la respuesta.

    Todo lo demas -validar, decidir, consultar- es del controller hacia dentro.
    """

    async def handler(request: Request) -> JSONResponse:
        # Lo PRIMERO, antes incluso de leer el cuerpo: si no hay credencial
        # valida, la peticion no llega a tocar nada.
        if _is_auth_required(request.url.path) and not _is_authorized(request):
            return _get_unauthorized_response()

        body: dict[str, Any] = {}

        # 1) Cuerpo JSON. Puede no venir (GET, DELETE) o venir vacio: no es un
        # error, simplemente no aporta claves.
        try:
            json_body = await request.json()
            if isinstance(json_body, dict):
                body.update(json_body)
        except Exception:
            pass

        # 2) Query params (?is_done=1). Pisan al cuerpo.
        body.update(dict(request.query_params))

        # 3) Parametros de ruta ({id}). Maxima precedencia: el id de la URL manda
        # siempre sobre lo que venga en el cuerpo, que es lo que impide que un
        # cliente mande un id distinto del que pidio en la URL.
        body.update(request.path_params)

        result: dict[str, Any] = controller_callable(body)

        # `status` es un ResponseCodeEnum (IntEnum). Se convierte a int para el
        # codigo HTTP y tambien dentro del cuerpo, para que se serialice como
        # numero y no como "ResponseCodeEnum.OK".
        status_code = int(result.get(ResponseKeyEnum.STATUS, ResponseCodeEnum.OK))
        content = jsonable_encoder({**result, ResponseKeyEnum.STATUS: status_code})
        return JSONResponse(status_code=status_code, content=content)

    return handler


def _register_routes() -> None:
    """Recorre la tabla de rutas y da de alta cada una en FastAPI."""
    for route_key, controller_callable in Routes.BY_PATH.items():
        http_method, path = route_key.split(" ", 1)
        app.add_api_route(path, _get_handler(controller_callable), methods=[http_method])


_register_routes()
