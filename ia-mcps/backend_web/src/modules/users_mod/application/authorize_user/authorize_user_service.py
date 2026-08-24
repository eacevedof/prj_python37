from typing import Any, Self, final

from src.modules.shared.infrastructure.components.hasher.hasher import Hasher

from src.modules.users_mod.application.authorize_user.authorize_user_dto import AuthorizeUserDto
from src.modules.users_mod.application.authorize_user.authorize_user_result_dto import (
    AuthorizeUserResultDto,
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

# Cada cuánto hay que volver a teclear la contraseña. Es la REGLA DE NEGOCIO: el
# repositorio solo hace la resta, el plazo se decide aquí.
_PASSWORD_TTL_DAYS = 7


@final
class AuthorizeUserService:
    """Caso de uso: dejar pasar (o no) a quien llama, y decir sobre quién opera.

    Es el guardarraíl que TODO caso de uso con datos de usuario invoca antes de
    tocar nada. En orden:

    1. el id de telegram tiene que corresponder a un usuario dado de alta,
    2. `is_enabled` tiene que estar a 1,
    3. si el usuario tiene contraseña, o llega correcta en esta llamada o la
       última validación tiene menos de 7 días,
    4. operar sobre OTRO usuario exige ser admin.

    Los mensajes de error son genéricos a propósito (ver `UserMessageEnum`): un
    id desconocido y uno deshabilitado no se distinguen desde fuera.
    """

    _hasher: Hasher
    _users_reader_sqlite_repository: UsersReaderSqliteRepository
    _users_writer_sqlite_repository: UsersWriterSqliteRepository

    _authorize_user_dto: AuthorizeUserDto

    def __init__(self) -> None:
        self._hasher = Hasher.get_instance()
        self._users_reader_sqlite_repository = UsersReaderSqliteRepository.get_instance()
        self._users_writer_sqlite_repository = UsersWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, authorize_user_dto: AuthorizeUserDto) -> AuthorizeUserResultDto:
        """Caso de uso: AuthorizeUser.

        Returns:
            AuthorizeUserResultDto: quien llama y el dueño de los datos.

        Raises:
            UsersException: 401 si no se le reconoce o la contraseña falta o no
                vale; 403 si está deshabilitado o pretende operar sobre otro sin
                ser admin.
        """
        self._authorize_user_dto = authorize_user_dto
        self._fail_if_wrong_input()

        user_row = self._users_reader_sqlite_repository.get_user_by_tg_id(
            self._authorize_user_dto.user_tg_id, _PASSWORD_TTL_DAYS
        )
        self.__fail_if_user_cannot_enter(user_row)
        self.__fail_if_password_does_not_open_the_window(user_row)

        is_admin = int(user_row[UserKeyEnum.USER_ROLE_ID]) == UserRoleEnum.ADMIN
        return AuthorizeUserResultDto.from_primitives({
            UserKeyEnum.USER_ID: user_row[UserKeyEnum.USER_ID],
            UserKeyEnum.USER_UUID: user_row[UserKeyEnum.USER_UUID],
            UserKeyEnum.USER_TG_ID: user_row[UserKeyEnum.USER_TG_ID],
            UserKeyEnum.USER_NAME: user_row[UserKeyEnum.USER_NAME],
            UserKeyEnum.USER_ROLE_ID: user_row[UserKeyEnum.USER_ROLE_ID],
            UserKeyEnum.IS_ADMIN: is_admin,
            UserKeyEnum.OWNER_USER_ID: self.__get_owner_user_id(user_row, is_admin),
            UserKeyEnum.OWNER_USER_TG_ID: self.__get_owner_user_tg_id(user_row),
        })

    def _fail_if_wrong_input(self) -> None:
        if not self._authorize_user_dto.user_tg_id:
            UsersException.bad_request_custom(UserMessageEnum.USER_TG_ID_REQUIRED)

    def __fail_if_user_cannot_enter(self, user_row: dict[str, Any]) -> None:
        if not user_row:
            UsersException.unauthorized_custom(UserMessageEnum.USER_NOT_AUTHORIZED)
        if not int(user_row[UserKeyEnum.IS_ENABLED]):
            UsersException.forbidden_custom(UserMessageEnum.USER_DISABLED)

    def __fail_if_password_does_not_open_the_window(self, user_row: dict[str, Any]) -> None:
        """Un usuario sin contraseña guardada entra sin más; con contraseña, o
        la manda ahora o le vale la ventana de 7 días de la última vez.

        Acertar la contraseña REABRE la ventana, así que el bot solo tiene que
        pedirla cuando la llamada anterior devolvió `PASSWORD_REQUIRED`.
        """
        stored_password_hash = str(user_row[UserKeyEnum.USER_PWD])
        if not stored_password_hash:
            return

        submitted_password = self._authorize_user_dto.password
        if not submitted_password:
            if int(user_row[UserKeyEnum.IS_PASSWORD_FRESH]):
                return
            UsersException.unauthorized_custom(UserMessageEnum.PASSWORD_REQUIRED)

        if not self._hasher.is_password_valid(submitted_password, stored_password_hash):
            UsersException.unauthorized_custom(UserMessageEnum.PASSWORD_WRONG)

        self._users_writer_sqlite_repository.update_authenticated_at(
            int(user_row[UserKeyEnum.USER_ID])
        )

    def __get_owner_user_id(self, user_row: dict[str, Any], is_admin: bool) -> int:
        """El id del usuario cuyos datos se van a tocar.

        Sin `target_user_tg_id` es el propio que llama: un usuario normal no
        puede ni nombrar a otro, y por eso el caso de uso de negocio recibe
        SIEMPRE un id ya resuelto y no un id de telegram que tendría que volver
        a validar.
        """
        target_user_tg_id = self._authorize_user_dto.target_user_tg_id
        if not target_user_tg_id or target_user_tg_id == self._authorize_user_dto.user_tg_id:
            return int(user_row[UserKeyEnum.USER_ID])

        if not is_admin:
            UsersException.forbidden_custom(UserMessageEnum.ADMIN_ONLY)

        target_user_id = self._users_reader_sqlite_repository.get_user_id_by_tg_id(
            target_user_tg_id
        )
        if not target_user_id:
            UsersException.bad_request_custom(UserMessageEnum.USER_NOT_FOUND)
        return target_user_id

    def __get_owner_user_tg_id(self, user_row: dict[str, Any]) -> str:
        target_user_tg_id = self._authorize_user_dto.target_user_tg_id
        if not target_user_tg_id:
            return str(user_row[UserKeyEnum.USER_TG_ID])
        return target_user_tg_id
