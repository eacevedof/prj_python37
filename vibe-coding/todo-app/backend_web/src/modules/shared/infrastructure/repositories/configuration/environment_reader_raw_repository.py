from typing import Self, final

from src.core.boot.env import get
from src.modules.shared.domain.enums.app_version_enum import AppVersionEnum
from src.modules.shared.domain.enums.boolean_input_enum import BooleanInputEnum
from src.modules.shared.domain.enums.env_default_enum import EnvDefaultEnum
from src.modules.shared.domain.enums.env_var_enum import EnvVarEnum
from src.modules.shared.domain.enums.environment_enum import EnvironmentEnum


@final
class EnvironmentReaderRawRepository:
    """Lectura de la configuracion de entorno (datasource: raw / variables de entorno).

    **Un getter tipado por cada variable.** Nadie fuera de esta clase escribe el
    nombre de una variable de entorno ni llama a `get()`. Tres razones:

      1. De un vistazo se ve QUE necesita un `.env` completo: son los metodos de
         esta clase.
      2. La conversion de tipo y el valor por defecto ocurren una vez y en un
         sitio (`is_debug` devuelve bool, no la cadena "1").
      3. El dia que la configuracion venga de otro sitio (Vault, un fichero
         json), se cambia aqui y el resto de la app no se entera.

    Los valores por defecto viven en `EnvDefaultEnum`, no escritos aqui en linea:
    asi se pueden leer todos juntos y preguntarse que pasa si falta cada uno.

    (Unica excepcion documentada: `Logger` lee `APP_LOG_PATH` directamente,
    porque es un componente y no puede depender de codigo de la aplicacion.)

    Se llama `RawRepository` porque su datasource es "raw" (el entorno del
    proceso), igual que otros son `SqliteRepository` o `ApiRepository`.
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
        """El entorno actual. Si no esta definido: production (ver EnvDefaultEnum)."""
        return get(EnvVarEnum.APP_ENV, EnvDefaultEnum.ENVIRONMENT)

    def get_db_path(self) -> str:
        return get(EnvVarEnum.APP_DB_PATH, EnvDefaultEnum.DB_PATH)

    def get_log_path(self) -> str:
        return get(EnvVarEnum.APP_LOG_PATH, EnvDefaultEnum.LOG_PATH)

    def get_time_zone(self) -> str:
        return get(EnvVarEnum.APP_TIME_ZONE, EnvDefaultEnum.TIME_ZONE)

    def get_api_key(self) -> str:
        return get(EnvVarEnum.APP_API_KEY, EnvDefaultEnum.API_KEY)

    def is_local(self) -> bool:
        return self.get_environment() == EnvironmentEnum.LOCAL.value

    def is_develop(self) -> bool:
        return self.get_environment() == EnvironmentEnum.DEVELOP.value

    def is_production(self) -> bool:
        return self.get_environment() == EnvironmentEnum.PRODUCTION.value

    def is_debug(self) -> bool:
        """El modo depuracion depende del ENTORNO y de la variable, en ese orden.

            production   NUNCA. Da igual lo que ponga APP_DEBUG.
            develop      apagado por defecto; se enciende con APP_DEBUG=1.
            local        encendido por defecto; se apaga con APP_DEBUG=0.

        Lo que cambia entre local y develop es **el valor por defecto cuando la
        variable no esta definida**. Si la defines, en los dos se respeta lo que
        digas. Production es el unico que no la mira.

        Y como `APP_ENV` sin definir vale `production`, un `.env` vacio del todo
        deja la depuracion apagada: dos capas que fallan hacia el lado seguro.

        Por que production no la mira: un `APP_DEBUG=1` olvidado en un `.env` de
        produccion es de las cosas que pasan de verdad, y expondria trazas y
        datos internos a cualquiera.

        Por que en local viene encendida: si estas desarrollando, lo normal es
        querer ver el error entero. Pero se puede apagar, y a veces interesa:
        para comprobar que lo que ve un cliente cuando algo revienta es el
        mensaje generico y no la traza.
        """
        if self.is_production():
            return False
        raw_app_debug = get(EnvVarEnum.APP_DEBUG, "")
        if not raw_app_debug:
            # Sin definir: cada entorno tiene su valor por defecto.
            return self.is_local()
        return raw_app_debug in BooleanInputEnum.TRUTHY_VALUES
