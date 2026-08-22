from typing import Self, final

from src.modules.emt_mod.application.add_favorite_stop.add_favorite_stop_dto import (
    AddFavoriteStopDto,
)
from src.modules.emt_mod.application.add_favorite_stop.add_favorite_stop_result_dto import (
    AddFavoriteStopResultDto,
)
from src.modules.emt_mod.domain.enums.favorite_stop_key_enum import FavoriteStopKeyEnum
from src.modules.emt_mod.domain.enums.favorite_stop_message_enum import FavoriteStopMessageEnum
from src.modules.emt_mod.domain.exceptions.emt_exception import EmtException
from src.modules.emt_mod.domain.ports.user_authorizer_port import UserAuthorizerPort
from src.modules.emt_mod.infrastructure.repositories.favorite_stops_reader_sqlite_repository import (
    FavoriteStopsReaderSqliteRepository,
)
from src.modules.emt_mod.infrastructure.repositories.favorite_stops_writer_sqlite_repository import (
    FavoriteStopsWriterSqliteRepository,
)
from src.modules.users_mod.domain.enums.user_key_enum import UserKeyEnum
from src.modules.users_mod.infrastructure.adapters.user_authorizer_adapter import (
    UserAuthorizerAdapter,
)

# Un id de parada de la EMT son 3-5 dígitos; el tope está puesto para que no
# entre una cadena arbitraria, no para validar el catálogo.
_MAX_STOP_NR_LENGTH = 10
_MAX_STOP_DESCRIPTION_LENGTH = 120


@final
class AddFavoriteStopService:
    """Caso de uso: guardar una parada en los favoritos de un usuario.

    El orden importa: primero se valida la entrada, después se pregunta al
    guardarraíl QUIÉN es el dueño, y solo entonces se escribe. El id del dueño
    lo devuelve `users_mod`; este módulo nunca lo deduce del payload, que es lo
    que impide que alguien escriba en la lista de otro pasando un id ajeno.
    """

    _user_authorizer_port: UserAuthorizerPort
    _favorite_stops_reader_sqlite_repository: FavoriteStopsReaderSqliteRepository
    _favorite_stops_writer_sqlite_repository: FavoriteStopsWriterSqliteRepository

    _add_favorite_stop_dto: AddFavoriteStopDto

    def __init__(self) -> None:
        self._user_authorizer_port: UserAuthorizerPort = UserAuthorizerAdapter.get_instance()
        self._favorite_stops_reader_sqlite_repository = (
            FavoriteStopsReaderSqliteRepository.get_instance()
        )
        self._favorite_stops_writer_sqlite_repository = (
            FavoriteStopsWriterSqliteRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, add_favorite_stop_dto: AddFavoriteStopDto
    ) -> AddFavoriteStopResultDto:
        """Caso de uso: AddFavoriteStop.

        Returns:
            AddFavoriteStopResultDto: la parada guardada y su dueño.

        Raises:
            UsersException: si quien llama no puede (deshabilitado, contraseña
                caducada, o pretende escribir en la lista de otro sin ser admin).
            EmtException: 400 si la entrada no vale; 409 si esa parada ya estaba
                en favoritos.
        """
        self._add_favorite_stop_dto = add_favorite_stop_dto
        self._fail_if_wrong_input()

        authorized_user = await self._user_authorizer_port.get_authorized_user({
            UserKeyEnum.USER_TG_ID: self._add_favorite_stop_dto.user_tg_id,
            UserKeyEnum.PASSWORD: self._add_favorite_stop_dto.password,
            UserKeyEnum.TARGET_USER_TG_ID: self._add_favorite_stop_dto.target_user_tg_id,
        })
        owner_user_id = int(authorized_user[UserKeyEnum.OWNER_USER_ID])

        if self._favorite_stops_reader_sqlite_repository.has_favorite_stop(
            owner_user_id, self._add_favorite_stop_dto.stop_nr
        ):
            EmtException.bad_request_custom(FavoriteStopMessageEnum.STOP_ALREADY_IN_FAVORITES)

        self._favorite_stops_writer_sqlite_repository.create_favorite_stop(
            owner_user_id,
            self._add_favorite_stop_dto.stop_nr,
            self._add_favorite_stop_dto.stop_description,
        )

        owner_user_tg_id = str(authorized_user[UserKeyEnum.OWNER_USER_TG_ID])
        return AddFavoriteStopResultDto.from_primitives({
            FavoriteStopKeyEnum.STOP_NR: self._add_favorite_stop_dto.stop_nr,
            FavoriteStopKeyEnum.STOP_DESCRIPTION: self._add_favorite_stop_dto.stop_description,
            FavoriteStopKeyEnum.OWNER_USER_TG_ID: owner_user_tg_id,
            FavoriteStopKeyEnum.IS_OTHER_USER: (
                owner_user_tg_id != str(authorized_user[UserKeyEnum.USER_TG_ID])
            ),
        })

    def _fail_if_wrong_input(self) -> None:
        if not self._add_favorite_stop_dto.stop_nr:
            EmtException.bad_request_custom(FavoriteStopMessageEnum.STOP_NR_REQUIRED)
        if len(self._add_favorite_stop_dto.stop_nr) > _MAX_STOP_NR_LENGTH:
            EmtException.bad_request_custom(FavoriteStopMessageEnum.STOP_NR_TOO_LONG)
        if len(self._add_favorite_stop_dto.stop_description) > _MAX_STOP_DESCRIPTION_LENGTH:
            EmtException.bad_request_custom(FavoriteStopMessageEnum.STOP_DESCRIPTION_TOO_LONG)
