from typing import Self, final

from src.core.boot.env import get
from src.modules.shared.domain.enums.app_version_enum import AppVersionEnum
from src.modules.shared.domain.enums.boolean_input_enum import BooleanInputEnum
from src.modules.shared.domain.enums.env_var_enum import EnvVarEnum
from src.modules.shared.domain.enums.environment_enum import EnvironmentEnum


@final
class EnvironmentReaderRawRepository:
    """Lectura de la configuracion de entorno (datasource: raw / variables de entorno).

    **Un getter tipado por cada variable.** Nadie fuera de esta clase escribe el
    nombre de una variable de entorno ni llama a `get()`. Tres razones:

      1. De un vistazo se ve QUE necesita un `.env` completo: son los metodos de
         esta clase.
      2. La conversion de tipo ocurre una vez y en un sitio (`is_debug` devuelve
         bool, no la cadena "1").
      3. El dia que la configuracion venga de otro sitio (Vault, un fichero json),
         se cambia aqui y el resto de la app no se entera.

    Se llama `RawRepository` porque su datasource es "raw" (el entorno del
    proceso), igual que otros son `SqliteRepository` o `ApiRepository`. El segmento
    del datasource en el nombre es obligatorio en este proyecto.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_app_version(self) -> str:
        # Anotado como str a proposito: sin la anotacion, los IDE infieren el tipo
        # de `AppVersionEnum.CURRENT.value` como una funcion, no como una cadena.
        app_version: str = AppVersionEnum.CURRENT.value
        return app_version

    def get_environment(self) -> str:
        return get(EnvVarEnum.APP_ENV)

    def get_db_path(self) -> str:
        return get(EnvVarEnum.DB_PATH, "storage/database/todo_app.db")

    def get_log_path(self) -> str:
        return get(EnvVarEnum.APP_LOG_PATH, "storage/logs")

    def get_api_key(self) -> str:
        return get(EnvVarEnum.API_KEY)

    def is_local(self) -> bool:
        return self.get_environment() == EnvironmentEnum.LOCAL.value

    def is_develop(self) -> bool:
        return self.get_environment() == EnvironmentEnum.DEVELOP.value

    def is_production(self) -> bool:
        return self.get_environment() == EnvironmentEnum.PRODUCTION.value

    def is_debug(self) -> bool:
        return get(EnvVarEnum.APP_DEBUG, "") in BooleanInputEnum.TRUTHY_VALUES
