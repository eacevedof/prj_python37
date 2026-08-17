from typing import final


@final
class EnvVarEnum:
    """Nombres de las variables de entorno del `.env`.

    Existe para que el nombre de una variable se escriba UNA vez. Quien las lee es
    EnvironmentReaderRawRepository, que tiene un getter tipado por cada una: si
    alguien escribe "API_KEY" mal en un sitio, falla ahi y solo ahi, y encontrarlo
    cuesta una tarde.

    Esta lista y `.env.example` tienen que decir lo mismo. Si anades una variable,
    tocas tres sitios: aqui, el getter del repositorio y `.env.example`.
    """

    APP_ENV = "APP_ENV"
    APP_DEBUG = "APP_DEBUG"
    APP_LOG_PATH = "APP_LOG_PATH"
    DB_PATH = "DB_PATH"
    API_KEY = "API_KEY"
    TIME_ZONE = "TIME_ZONE"
