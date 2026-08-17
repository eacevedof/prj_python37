from enum import Enum


class EnvironmentEnum(str, Enum):
    """Entornos en los que corre la app (valor de APP_ENV en el `.env`).

    Es `str, Enum` y no una clase de constantes porque estos valores se COMPARAN
    contra lo que llega del entorno (`get(APP_ENV) == EnvironmentEnum.LOCAL.value`),
    y tenerlos como Enum permite recorrerlos si algun dia hace falta validar que
    APP_ENV trae algo reconocible.

    Recuerda: siempre `.value` al usarlos. Un `str, Enum` NO es intercambiable con
    un str en una comparacion `is`, y olvidar el `.value` en un `==` da False
    silenciosamente.
    """

    LOCAL = "local"
    DEVELOP = "develop"
    PRODUCTION = "production"
