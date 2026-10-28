from typing import final


@final
class EnvVarEnum:
    """Nombres de las variables de entorno del `.env`.

    **TODAS empiezan por `APP_`, sin excepcion.** No es cosmetico: el proceso
    hereda las variables de la maquina, del contenedor y del sistema de
    despliegue, y ahi ya hay cientos con nombres genericos. Una variable tuya
    llamada `DB_PATH` o `API_KEY` puede chocar con la de otra cosa, y el fallo
    resultante es de los peores: no revienta, coge el valor equivocado.

    Con el prefijo tambien se ve de un vistazo, en cualquier panel de despliegue,
    cuales son las de esta aplicacion.

    Existe para que el nombre de una variable se escriba UNA vez. Quien las lee
    es EnvironmentReaderRawRepository, que tiene un getter tipado por cada una.

    Esta lista y `.env.example` tienen que decir lo mismo. Si anades una
    variable, tocas tres sitios: aqui, el getter del repositorio y
    `.env.example`.
    """

    APP_ENV = "APP_ENV"
    APP_DEBUG = "APP_DEBUG"
    APP_LOG_PATH = "APP_LOG_PATH"
    APP_DB_PATH = "APP_DB_PATH"
    APP_API_KEY = "APP_API_KEY"
    APP_TIME_ZONE = "APP_TIME_ZONE"
