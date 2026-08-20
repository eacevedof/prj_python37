from contextlib import AsyncExitStack, asynccontextmanager
from typing import Any, AsyncIterator, Callable

from fastapi import FastAPI
from fastapi.responses import JSONResponse
from starlette.routing import Route

from src.core.routes.mcp_routes import McpRoutes
from src.modules.shared.domain.enums.asgi_key_enum import AsgiKeyEnum
from src.modules.shared.domain.enums.auth_enum import AuthEnum
from src.modules.shared.domain.enums.request_key_enum import RequestKeyEnum
from src.modules.shared.domain.enums.response_code_enum import ResponseCodeEnum
from src.modules.shared.domain.enums.response_key_enum import ResponseKeyEnum
from src.modules.shared.domain.enums.response_message_enum import ResponseMessageEnum
from src.modules.shared.infrastructure.authenticators.apikey_authenticator import ApikeyAuthenticator
from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncIterator[None]:
    """Lifespan de la app (reemplaza al obsoleto on_event('startup')). Antes de
    servir, arranca los servidores MCP.

    Los MCP se montan como handler ASGI pelado (no como sub-app Starlette),
    porque FastAPI no propaga el lifespan de una app montada y sin él el session
    manager del SDK se queda sin task group. Se arrancan aquí, y el ExitStack
    los cierra en orden inverso al apagar."""
    async with AsyncExitStack() as mcp_exit_stack:
        for mcp_controller_factory in McpRoutes.BY_PATH.values():
            await mcp_exit_stack.enter_async_context(mcp_controller_factory().get_session_runner())
        yield


app = FastAPI(title="ia-mcps", lifespan=lifespan)


@app.get(AuthEnum.HEALTH_PATH.value)
def health() -> dict:
    environment_reader_raw_repository = EnvironmentReaderRawRepository.get_instance()
    return {
        ResponseKeyEnum.STATUS: ResponseMessageEnum.HEALTH_OK,
        RequestKeyEnum.VERSION: environment_reader_raw_repository.get_app_version(),
        RequestKeyEnum.ENVIRONMENT: environment_reader_raw_repository.get_environment(),
    }


def _get_unauthorized_response() -> JSONResponse:
    status_code = int(ResponseCodeEnum.UNAUTHORIZED)
    return JSONResponse(
        status_code=status_code,
        content={
            ResponseKeyEnum.STATUS: status_code,
            ResponseKeyEnum.ERROR: ResponseMessageEnum.UNAUTHORIZED,
        },
    )


def _get_header_value(scope: dict[str, Any], header_name: str) -> str:
    """Lee una cabecera del scope ASGI pelado (pares de bytes latin-1 en minúsculas)."""
    raw_header_name = header_name.encode("latin-1")
    for raw_key, raw_value in scope.get(AsgiKeyEnum.HEADERS, []):
        if raw_key == raw_header_name:
            return raw_value.decode("latin-1")
    return ""


async def _get_buffered_body(receive: Callable) -> bytes:
    """Vacía el cuerpo de la petición para poder devolvérselo al servidor MCP.

    El borde de auth no lo necesita (la apikey va en cabecera), pero sí hace
    falta drenarlo y reponerlo cuando se responde 401 sin llegar al SDK: si no,
    el cliente se queda esperando a que alguien lea su cuerpo.
    """
    body_chunks: list[bytes] = []
    is_more_body = True
    while is_more_body:
        message = await receive()
        if message[AsgiKeyEnum.TYPE] != AsgiKeyEnum.HTTP_REQUEST:
            break
        body_chunks.append(message.get(AsgiKeyEnum.BODY, b""))
        is_more_body = bool(message.get(AsgiKeyEnum.MORE_BODY, False))
    return b"".join(body_chunks)


def _get_replayed_receive(raw_body: bytes) -> Callable:
    """Devuelve el cuerpo ya drenado a quien venga detrás, una sola vez."""
    is_delivered = False

    async def replayed_receive() -> dict[str, Any]:
        nonlocal is_delivered
        if is_delivered:
            return {AsgiKeyEnum.TYPE: AsgiKeyEnum.HTTP_DISCONNECT}
        is_delivered = True
        return {
            AsgiKeyEnum.TYPE: AsgiKeyEnum.HTTP_REQUEST,
            AsgiKeyEnum.BODY: raw_body,
            AsgiKeyEnum.MORE_BODY: False,
        }

    return replayed_receive


class McpAsgiEndpoint:
    """Endpoint ASGI de una entrada de MCP_ROUTES, detrás del borde de auth.

    Es una CLASE y no una función a propósito: Starlette trata un endpoint
    función como `func(request) -> response`, y solo lo trata como app ASGI si
    NO es función ni método. Registrarlo como Route (en vez de mount) hace que la
    ruta exacta responda sin redirigir.

    El controller se resuelve por petición (su `get_instance()` cachea, así que
    se construye una vez) para no cablear nada en tiempo de import.
    """

    _apikey_authenticator: ApikeyAuthenticator
    _mcp_controller_factory: Callable[[], Any]

    def __init__(self, mcp_controller_factory: Callable[[], Any]) -> None:
        self._apikey_authenticator = ApikeyAuthenticator.get_instance()
        self._mcp_controller_factory = mcp_controller_factory

    async def __call__(self, scope: dict[str, Any], receive: Callable, send: Callable) -> None:
        raw_body = await _get_buffered_body(receive)
        if not self._apikey_authenticator.has_service_access(
            _get_header_value(scope, AuthEnum.APIKEY_HEADER.value)
        ):
            await _get_unauthorized_response()(scope, _get_replayed_receive(raw_body), send)
            return
        await self._mcp_controller_factory().get_asgi_app()(
            scope, _get_replayed_receive(raw_body), send
        )


def _register_mcp_routes() -> None:
    """Registra cada endpoint MCP con y sin barra final.

    Con `app.mount()` la ruta EXACTA no casa y el router responde 307 hacia la
    versión con barra. Un 307 conserva método y cuerpo, así que muchos clientes
    lo siguen y parece que funciona — pero la Location la construye Starlette a
    partir de la petición, y detrás de un proxy puede salir apuntando al host
    interno. Registrando las dos formas no hay redirección que seguir.
    """
    for path, mcp_controller_factory in McpRoutes.BY_PATH.items():
        mcp_asgi_endpoint = McpAsgiEndpoint(mcp_controller_factory)
        app.router.routes.append(Route(path, endpoint=mcp_asgi_endpoint))
        app.router.routes.append(Route(f"{path}/", endpoint=mcp_asgi_endpoint))


_register_mcp_routes()
