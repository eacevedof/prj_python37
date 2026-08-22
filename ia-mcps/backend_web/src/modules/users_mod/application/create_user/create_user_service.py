from uuid import uuid4
from typing import Self, final

from src.modules.shared.infrastructure.components.hasher.hasher import Hasher

from src.modules.users_mod.application.create_user.create_user_dto import CreateUserDto
from src.modules.users_mod.application.create_user.create_user_result_dto import (
    CreateUserResultDto,
)
from src.modules.users_mod.domain.enums.user_key_enum import UserKeyEnum
from src.modules.users_mod.domain.enums.user_message_enum import UserMessageEnum
from src.modules.users_mod.domain.enums.user_role_enum import UserRoleEnum
from src.modules.users_mod.domain.exceptions.users_exception import UsersException
from src.modules.users_mod.infrastructure.repositories.users_reader_sqlite_repository import (
    UsersReaderSqliteRepository,
)
from src.modules.users_mod.infrastructure.repositories.users_writer_sqlite_repository import (
    UsersWriterSqliteRepository,
)

# usr-<12 hex>: identificador público del usuario, estable aunque el id interno
# cambie de máquina o de base.
_USER_UUID_PREFIX = "usr-"
_USER_UUID_LENGTH = 12


@final
class CreateUserService:
    """Caso de uso: dar de alta un usuario de los servidores MCP.

    NO se expone como tool: el alta la hace un humano por consola
    (`public/main_user_add.py`). Un agente no debe poder fabricarse un admin, y
    la contraseña no tiene por qué pasar por el historial de una conversación.
    """

    _hasher: Hasher
    _users_reader_sqlite_repository: UsersReaderSqliteRepository
    _users_writer_sqlite_repository: UsersWriterSqliteRepository

    _create_user_dto: CreateUserDto

    def __init__(self) -> None:
        self._hasher = Hasher.get_instance()
        self._users_reader_sqlite_repository = UsersReaderSqliteRepository.get_instance()
        self._users_writer_sqlite_repository = UsersWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, create_user_dto: CreateUserDto) -> CreateUserResultDto:
        """Caso de uso: CreateUser.

        Returns:
            CreateUserResultDto: el usuario creado.

        Raises:
            UsersException: 400 si faltan datos o el rol no existe; 409 si ese
                id de telegram ya está dado de alta.
        """
        self._create_user_dto = create_user_dto
        self._fail_if_wrong_input()

        user_uuid = f"{_USER_UUID_PREFIX}{uuid4().hex[:_USER_UUID_LENGTH]}"
        user_id = self._users_writer_sqlite_repository.create_user({
            UserKeyEnum.USER_UUID: user_uuid,
            UserKeyEnum.USER_ROLE_ID: self._create_user_dto.user_role_id,
            UserKeyEnum.USER_TG_ID: self._create_user_dto.user_tg_id,
            UserKeyEnum.USER_NAME: self._create_user_dto.user_name,
            UserKeyEnum.USER_PWD: self.__get_stored_password(),
            UserKeyEnum.IS_ENABLED: int(self._create_user_dto.is_enabled),
        })

        return CreateUserResultDto.from_primitives({
            UserKeyEnum.USER_ID: user_id,
            UserKeyEnum.USER_UUID: user_uuid,
            UserKeyEnum.USER_TG_ID: self._create_user_dto.user_tg_id,
            UserKeyEnum.USER_NAME: self._create_user_dto.user_name,
            UserKeyEnum.USER_ROLE_ID: self._create_user_dto.user_role_id,
            UserKeyEnum.IS_ENABLED: self._create_user_dto.is_enabled,
        })

    def _fail_if_wrong_input(self) -> None:
        if not self._create_user_dto.user_tg_id:
            UsersException.bad_request_custom(UserMessageEnum.USER_TG_ID_REQUIRED)
        if not self._create_user_dto.user_name:
            UsersException.bad_request_custom(UserMessageEnum.USER_NAME_REQUIRED)
        if self._create_user_dto.user_role_id not in [int(role) for role in UserRoleEnum]:
            UsersException.bad_request_custom(UserMessageEnum.UNKNOWN_ROLE)
        if self._users_reader_sqlite_repository.has_user_by_tg_id(self._create_user_dto.user_tg_id):
            UsersException.conflict_custom(UserMessageEnum.USER_ALREADY_EXISTS)

    def __get_stored_password(self) -> str:
        """Sin contraseña se guarda cadena vacía: es el usuario al que nunca se
        le va a pedir, no un hash de la cadena vacía (que sí validaría)."""
        if not self._create_user_dto.plain_password:
            return ""
        return self._hasher.get_password_hash(self._create_user_dto.plain_password)
