from typing import final

from src.modules.shared.domain.enums.auth_enum import AuthEnum


@final
class AuthScopeEnum:
    """Rutas que NO piden credencial.

    Esta lista es la respuesta a "¿que se puede llamar sin autenticarse?", y por
    eso vive en un sitio con nombre en vez de suelta dentro de un `if` del front
    controller: cuando alguien audite la API, mira aqui.

    Solo esta el health-check, y por una razon concreta: un monitor de
    disponibilidad tiene que poder comprobar que la app vive sin tener la llave, y
    lo que devuelve (version y entorno) no es sensible.

    No hay login ni logout que eximir porque no hay sesiones: la credencial no se
    obtiene llamando a la API, se reparte fuera de banda.
    """

    EXEMPT_PATHS: frozenset[str] = frozenset({AuthEnum.HEALTH_PATH.value})
