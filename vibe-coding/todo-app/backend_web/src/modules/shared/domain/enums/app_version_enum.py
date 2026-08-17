from enum import Enum


class AppVersionEnum(str, Enum):
    """Version de la app (semver). INCREMENTAR en cada cambio que se despliegue.

    Esta a mano y no leida de git a proposito: `/health-check` la devuelve, asi que
    con un `curl` sabes que version esta corriendo un entorno sin entrar en el
    servidor. Es la forma mas barata de responder a "¿esta desplegado mi cambio?".
    """

    CURRENT = "0.1.0"
