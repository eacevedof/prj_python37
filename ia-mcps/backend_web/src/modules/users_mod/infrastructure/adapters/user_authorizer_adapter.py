from typing import Any, Self, final

from src.modules.users_mod.application.authorize_user.authorize_user_dto import AuthorizeUserDto
from src.modules.users_mod.application.authorize_user.authorize_user_service import (
    AuthorizeUserService,
)


@final
class UserAuthorizerAdapter:
    """Implementación del puerto `UserAuthorizerPort` (emt_mod/domain/ports).

    Puerta de `users_mod` hacia cualquier módulo que necesite saber quién llama
    y sobre quién puede operar. Cruzan primitivos, nunca DTOs: al otro lado del
    puerto no se sabe que existe un `AuthorizeUserResultDto` ni una base de
    datos.
    """

    _authorize_user_service: AuthorizeUserService

    def __init__(self) -> None:
        self._authorize_user_service = AuthorizeUserService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_authorized_user(self, primitives: dict[str, Any]) -> dict[str, Any]:
        authorize_user_result_dto = await self._authorize_user_service(
            AuthorizeUserDto.from_primitives(primitives)
        )
        return authorize_user_result_dto.to_dict()
