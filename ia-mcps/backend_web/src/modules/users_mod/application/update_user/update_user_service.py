from typing import Any, Self, final

from src.modules.shared.infrastructure.components.hasher.hasher import Hasher

from src.modules.users_mod.application.update_user.update_user_dto import UpdateUserDto
from src.modules.users_mod.application.update_user.update_user_result_dto import (
    UpdateUserResultDto,
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


@final
class UpdateUserService:
    """Caso de uso: editar un usuario de los servidores MCP.

    Hermano de `CreateUserService`, y por lo mismo NO se expone como tool: aquí
    se cambian el rol y el `is_enabled`, así que una tool sería el camino corto
    para que un agente se ascienda a admin. Se hace por consola
    (`public/main_user_update.py`).

    La actualización es PARCIAL, pero el UPDATE es completo: el service lee la
    fila, fusiona lo que llega con lo que ya había y escribe todos los campos.
    Así no hay SQL construido a trozos según lo que venga.
    """

    _hasher: Hasher
    _users_reader_sqlite_repository: UsersReaderSqliteRepository
    _users_writer_sqlite_repository: UsersWriterSqliteRepository

    _update_user_dto: UpdateUserDto

    def __init__(self) -> None:
        self._hasher = Hasher.get_instance()
        self._users_reader_sqlite_repository = UsersReaderSqliteRepository.get_instance()
        self._users_writer_sqlite_repository = UsersWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, update_user_dto: UpdateUserDto) -> UpdateUserResultDto:
        """Caso de uso: UpdateUser.

        Returns:
            UpdateUserResultDto: el usuario tal y como queda.

        Raises:
            UsersException: 400 si la entrada no vale, si no llega ningún cambio
                o si ese id de telegram no está dado de alta.
        """
        self._update_user_dto = update_user_dto
        self._fail_if_wrong_input()

        user_row = self._users_reader_sqlite_repository.get_user_profile_by_tg_id(
            self._update_user_dto.user_tg_id
        )
        if not user_row:
            UsersException.bad_request_custom(UserMessageEnum.USER_NOT_FOUND)

        user_name = self.__get_merged_user_name(user_row)
        user_role_id = self.__get_merged_user_role_id(user_row)
        is_enabled = self.__get_merged_is_enabled(user_row)
        is_password_changed = self._update_user_dto.plain_password is not None

        self._users_writer_sqlite_repository.update_user({
            UserKeyEnum.USER_ID: int(user_row[UserKeyEnum.USER_ID]),
            UserKeyEnum.USER_NAME: user_name,
            UserKeyEnum.USER_ROLE_ID: user_role_id,
            UserKeyEnum.IS_ENABLED: int(is_enabled),
            UserKeyEnum.USER_PWD: self.__get_stored_password(user_row),
            # Cambiarle la contraseña CIERRA la ventana de 7 días: la nueva hay
            # que teclearla, si no un `authenticated_at` fresco dejaría entrar
            # sin haberla visto nunca.
            UserKeyEnum.AUTHENTICATED_AT: (
                "" if is_password_changed else str(user_row[UserKeyEnum.AUTHENTICATED_AT])
            ),
        })

        return UpdateUserResultDto.from_primitives({
            UserKeyEnum.USER_ID: user_row[UserKeyEnum.USER_ID],
            UserKeyEnum.USER_UUID: user_row[UserKeyEnum.USER_UUID],
            UserKeyEnum.USER_TG_ID: user_row[UserKeyEnum.USER_TG_ID],
            UserKeyEnum.USER_NAME: user_name,
            UserKeyEnum.USER_ROLE_ID: user_role_id,
            UserKeyEnum.IS_ENABLED: is_enabled,
            UserKeyEnum.IS_PASSWORD_CHANGED: is_password_changed,
        })

    def _fail_if_wrong_input(self) -> None:
        if not self._update_user_dto.user_tg_id:
            UsersException.bad_request_custom(UserMessageEnum.USER_TG_ID_REQUIRED)
        if not self.__has_any_change():
            UsersException.bad_request_custom(UserMessageEnum.NOTHING_TO_UPDATE)
        if self._update_user_dto.user_name is not None and not self._update_user_dto.user_name:
            UsersException.bad_request_custom(UserMessageEnum.USER_NAME_REQUIRED)
        if self._update_user_dto.user_role_id is not None and self._update_user_dto.user_role_id not in [
            int(role) for role in UserRoleEnum
        ]:
            UsersException.bad_request_custom(UserMessageEnum.UNKNOWN_ROLE)

    def __has_any_change(self) -> bool:
        return any(
            value is not None
            for value in [
                self._update_user_dto.user_name,
                self._update_user_dto.user_role_id,
                self._update_user_dto.is_enabled,
                self._update_user_dto.plain_password,
            ]
        )

    def __get_merged_user_name(self, user_row: dict[str, Any]) -> str:
        if self._update_user_dto.user_name is None:
            return str(user_row[UserKeyEnum.USER_NAME])
        return self._update_user_dto.user_name

    def __get_merged_user_role_id(self, user_row: dict[str, Any]) -> int:
        if self._update_user_dto.user_role_id is None:
            return int(user_row[UserKeyEnum.USER_ROLE_ID])
        return self._update_user_dto.user_role_id

    def __get_merged_is_enabled(self, user_row: dict[str, Any]) -> bool:
        if self._update_user_dto.is_enabled is None:
            return bool(user_row[UserKeyEnum.IS_ENABLED])
        return self._update_user_dto.is_enabled

    def __get_stored_password(self, user_row: dict[str, Any]) -> str:
        """Los tres estados de `plain_password`: no tocar, quitar, poner."""
        plain_password = self._update_user_dto.plain_password
        if plain_password is None:
            return str(user_row[UserKeyEnum.USER_PWD])
        if not plain_password:
            return ""
        return self._hasher.get_password_hash(plain_password)
