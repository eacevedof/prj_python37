from typing import Self, final

from src.modules.emt_mod.application.update_favorite_stop.update_favorite_stop_dto import (
    UpdateFavoriteStopDto,
)
from src.modules.emt_mod.application.update_favorite_stop.update_favorite_stop_result_dto import (
    UpdateFavoriteStopResultDto,
)
from src.modules.emt_mod.domain.enums.favorite_stop_key_enum import FavoriteStopKeyEnum
from src.modules.emt_mod.domain.enums.favorite_stop_message_enum import FavoriteStopMessageEnum
from src.modules.emt_mod.domain.exceptions.emt_exception import EmtException
from src.modules.emt_mod.infrastructure.repositories.favorite_stops_writer_sqlite_repository import (
    FavoriteStopsWriterSqliteRepository,
)
from src.modules.users_mod.application.authorize_user.authorize_user_dto import AuthorizeUserDto
from src.modules.users_mod.application.authorize_user.authorize_user_service import (
    AuthorizeUserService,
)

_MAX_STOP_DESCRIPTION_LENGTH = 120


@final
class UpdateFavoriteStopService:
    """Caso de uso: cambiar la descripción de una parada favorita.

    El UPDATE ya lleva el `user_id` en el WHERE, así que las filas afectadas
    son la respuesta a las dos preguntas a la vez: si son 0, o esa parada no
    está en favoritos o no es de este dueño — y las dos se cuentan igual, para
    no confirmar que la parada existe en la lista de otro.
    """

    _authorize_user_service: AuthorizeUserService
    _favorite_stops_writer_sqlite_repository: FavoriteStopsWriterSqliteRepository

    _update_favorite_stop_dto: UpdateFavoriteStopDto

    def __init__(self) -> None:
        self._authorize_user_service = AuthorizeUserService.get_instance()
        self._favorite_stops_writer_sqlite_repository = (
            FavoriteStopsWriterSqliteRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, update_favorite_stop_dto: UpdateFavoriteStopDto
    ) -> UpdateFavoriteStopResultDto:
        """Caso de uso: UpdateFavoriteStop.

        Returns:
            UpdateFavoriteStopResultDto: la parada ya editada.

        Raises:
            UsersException: la del guardarraíl.
            EmtException: 400 si la entrada no vale o esa parada no está en los
                favoritos del dueño.
        """
        self._update_favorite_stop_dto = update_favorite_stop_dto
        self._fail_if_wrong_input()

        authorize_user_result_dto = await self._authorize_user_service(
            AuthorizeUserDto(
                user_tg_id=self._update_favorite_stop_dto.user_tg_id,
                password=self._update_favorite_stop_dto.password,
                target_user_tg_id=self._update_favorite_stop_dto.target_user_tg_id,
            )
        )

        updated_rows = self._favorite_stops_writer_sqlite_repository.update_favorite_stop(
            authorize_user_result_dto.owner_user_id,
            self._update_favorite_stop_dto.stop_nr,
            self._update_favorite_stop_dto.stop_description,
        )
        if not updated_rows:
            EmtException.not_found_custom(FavoriteStopMessageEnum.STOP_NOT_IN_FAVORITES)

        owner_user_tg_id = authorize_user_result_dto.owner_user_tg_id
        return UpdateFavoriteStopResultDto.from_primitives({
            FavoriteStopKeyEnum.STOP_NR: self._update_favorite_stop_dto.stop_nr,
            FavoriteStopKeyEnum.STOP_DESCRIPTION: self._update_favorite_stop_dto.stop_description,
            FavoriteStopKeyEnum.OWNER_USER_TG_ID: owner_user_tg_id,
            FavoriteStopKeyEnum.IS_OTHER_USER: (
                owner_user_tg_id != authorize_user_result_dto.user_tg_id
            ),
        })

    def _fail_if_wrong_input(self) -> None:
        if not self._update_favorite_stop_dto.stop_nr:
            EmtException.bad_request_custom(FavoriteStopMessageEnum.STOP_NR_REQUIRED)
        if not self._update_favorite_stop_dto.stop_description:
            EmtException.bad_request_custom(FavoriteStopMessageEnum.STOP_DESCRIPTION_REQUIRED)
        if len(self._update_favorite_stop_dto.stop_description) > _MAX_STOP_DESCRIPTION_LENGTH:
            EmtException.bad_request_custom(FavoriteStopMessageEnum.STOP_DESCRIPTION_TOO_LONG)
