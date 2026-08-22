from typing import Self, final

from src.modules.users_mod.application.authorize_user.authorize_user_dto import AuthorizeUserDto
from src.modules.users_mod.application.authorize_user.authorize_user_service import (
    AuthorizeUserService,
)
from src.modules.users_mod.application.get_users.get_users_dto import GetUsersDto
from src.modules.users_mod.application.get_users.get_users_result_dto import GetUsersResultDto
from src.modules.users_mod.domain.enums.user_key_enum import UserKeyEnum
from src.modules.users_mod.domain.enums.user_message_enum import UserMessageEnum
from src.modules.users_mod.domain.exceptions.users_exception import UsersException
from src.modules.users_mod.infrastructure.repositories.users_reader_sqlite_repository import (
    UsersReaderSqliteRepository,
)


@final
class GetUsersService:
    """Caso de uso: listar los usuarios dados de alta. SOLO ADMIN.

    Un usuario normal no puede ni enumerarlos: su tool devuelve 403 antes de
    leer nada. El listado no incluye el hash de la contraseña porque el
    repositorio ni siquiera lo selecciona.
    """

    _authorize_user_service: AuthorizeUserService
    _users_reader_sqlite_repository: UsersReaderSqliteRepository

    def __init__(self) -> None:
        self._authorize_user_service = AuthorizeUserService.get_instance()
        self._users_reader_sqlite_repository = UsersReaderSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, get_users_dto: GetUsersDto) -> GetUsersResultDto:
        """Caso de uso: GetUsers.

        Returns:
            GetUsersResultDto: los usuarios, sin contraseñas.

        Raises:
            UsersException: la del guardarraíl, o 403 si quien pide no es admin.
        """
        authorize_user_result_dto = await self._authorize_user_service(
            AuthorizeUserDto.from_primitives({
                UserKeyEnum.USER_TG_ID: get_users_dto.user_tg_id,
                UserKeyEnum.PASSWORD: get_users_dto.password,
            })
        )
        if not authorize_user_result_dto.is_admin:
            UsersException.forbidden_custom(UserMessageEnum.ADMIN_ONLY)

        users = self._users_reader_sqlite_repository.get_users()
        return GetUsersResultDto.from_primitives({
            UserKeyEnum.USERS: users,
            UserKeyEnum.TOTAL: len(users),
        })
