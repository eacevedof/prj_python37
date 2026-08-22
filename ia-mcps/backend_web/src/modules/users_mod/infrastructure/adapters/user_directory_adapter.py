from typing import Any, Self, final

from src.modules.users_mod.application.get_users.get_users_dto import GetUsersDto
from src.modules.users_mod.application.get_users.get_users_service import GetUsersService


@final
class UserDirectoryAdapter:
    """Implementación del puerto `UserDirectoryPort` (emt_mcp/domain/ports).

    Lo consume la fachada MCP para la tool de admin que lista usuarios. El
    control de acceso NO está aquí: lo hace el caso de uso, así que este
    adaptador no puede saltárselo.
    """

    _get_users_service: GetUsersService

    def __init__(self) -> None:
        self._get_users_service = GetUsersService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_users(self, primitives: dict[str, Any]) -> dict[str, Any]:
        get_users_result_dto = await self._get_users_service(
            GetUsersDto.from_primitives(primitives)
        )
        return get_users_result_dto.to_dict()
