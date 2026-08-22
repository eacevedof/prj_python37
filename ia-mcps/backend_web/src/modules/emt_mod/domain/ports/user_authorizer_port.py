from typing import Any, Protocol


# Puerto: lo declara `emt_mod` (quien lo necesita) y lo cumple, sin saberlo, el
# adaptador de `users_mod`. No lleva @final por ser un port.
class UserAuthorizerPort(Protocol):
    """Puerto (dominio de emt_mod): el guardarraíl de acceso a los favoritos.

    Los favoritos son de alguien, así que todo caso de uso que los toque empieza
    preguntando aquí. Este módulo no sabe qué es un rol, ni cuánto dura una
    contraseña, ni dónde viven los usuarios: solo que le devuelven el id del
    DUEÑO sobre el que puede operar, o una excepción.

    Entra y sale en primitivos: es un borde.

    Entrada:  user_tg_id, password (opcional), target_user_tg_id (opcional, admin)
    Salida:   user_id, user_tg_id, user_name, is_admin, owner_user_id, owner_user_tg_id
    """

    async def get_authorized_user(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...
