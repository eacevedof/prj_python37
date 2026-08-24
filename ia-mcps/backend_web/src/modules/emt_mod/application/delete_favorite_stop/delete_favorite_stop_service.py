from typing import Self, final

from src.modules.emt_mod.application.delete_favorite_stop.delete_favorite_stop_dto import (
    DeleteFavoriteStopDto,
)
from src.modules.emt_mod.application.delete_favorite_stop.delete_favorite_stop_result_dto import (
    DeleteFavoriteStopResultDto,
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


@final
class DeleteFavoriteStopService:
    """Caso de uso: quitar una parada de los favoritos de un usuario.

    Mismo razonamiento que en la edición: el DELETE lleva el `user_id` en el
    WHERE, así que borrar la parada de otro no es un caso a comprobar, es un
    caso que no puede ocurrir.
    """

    _authorize_user_service: AuthorizeUserService
    _favorite_stops_writer_sqlite_repository: FavoriteStopsWriterSqliteRepository

    _delete_favorite_stop_dto: DeleteFavoriteStopDto

    def __init__(self) -> None:
        self._authorize_user_service = AuthorizeUserService.get_instance()
        self._favorite_stops_writer_sqlite_repository = (
            FavoriteStopsWriterSqliteRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, delete_favorite_stop_dto: DeleteFavoriteStopDto
    ) -> DeleteFavoriteStopResultDto:
        """Caso de uso: DeleteFavoriteStop.

        Returns:
            DeleteFavoriteStopResultDto: la parada quitada y su dueño.

        Raises:
            UsersException: la del guardarraíl.
            EmtException: 400 si falta el número de parada; 404 si esa parada no
                estaba en los favoritos del dueño.
        """
        self._delete_favorite_stop_dto = delete_favorite_stop_dto
        self._fail_if_wrong_input()

        authorize_user_result_dto = await self._authorize_user_service(
            AuthorizeUserDto(
                user_tg_id=self._delete_favorite_stop_dto.user_tg_id,
                password=self._delete_favorite_stop_dto.password,
                target_user_tg_id=self._delete_favorite_stop_dto.target_user_tg_id,
            )
        )

        deleted_rows = self._favorite_stops_writer_sqlite_repository.delete_favorite_stop(
            authorize_user_result_dto.owner_user_id,
            self._delete_favorite_stop_dto.stop_nr,
        )
        if not deleted_rows:
            EmtException.not_found_custom(FavoriteStopMessageEnum.STOP_NOT_IN_FAVORITES)

        owner_user_tg_id = authorize_user_result_dto.owner_user_tg_id
        return DeleteFavoriteStopResultDto.from_primitives({
            FavoriteStopKeyEnum.STOP_NR: self._delete_favorite_stop_dto.stop_nr,
            FavoriteStopKeyEnum.OWNER_USER_TG_ID: owner_user_tg_id,
            FavoriteStopKeyEnum.IS_OTHER_USER: (
                owner_user_tg_id != authorize_user_result_dto.user_tg_id
            ),
        })

    def _fail_if_wrong_input(self) -> None:
        if not self._delete_favorite_stop_dto.stop_nr:
            EmtException.bad_request_custom(FavoriteStopMessageEnum.STOP_NR_REQUIRED)
