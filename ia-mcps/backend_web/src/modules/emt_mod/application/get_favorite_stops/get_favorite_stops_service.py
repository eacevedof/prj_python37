from typing import Self, final

from src.modules.emt_mod.application.get_favorite_stops.get_favorite_stops_dto import (
    GetFavoriteStopsDto,
)
from src.modules.emt_mod.application.get_favorite_stops.get_favorite_stops_result_dto import (
    GetFavoriteStopsResultDto,
)
from src.modules.emt_mod.domain.enums.favorite_stop_key_enum import FavoriteStopKeyEnum
from src.modules.emt_mod.infrastructure.repositories.favorite_stops_reader_sqlite_repository import (
    FavoriteStopsReaderSqliteRepository,
)
from src.modules.users_mod.application.authorize_user.authorize_user_dto import AuthorizeUserDto
from src.modules.users_mod.application.authorize_user.authorize_user_service import (
    AuthorizeUserService,
)


@final
class GetFavoriteStopsService:
    """Caso de uso: listar las paradas favoritas de un usuario.

    La consulta se hace SIEMPRE con el id del dueño que devuelve el
    guardarraíl, así que un usuario normal no tiene forma de pedir las de otro:
    no existe un camino en el que el id de la consulta salga del payload.
    """

    _authorize_user_service: AuthorizeUserService
    _favorite_stops_reader_sqlite_repository: FavoriteStopsReaderSqliteRepository

    def __init__(self) -> None:
        self._authorize_user_service = AuthorizeUserService.get_instance()
        self._favorite_stops_reader_sqlite_repository = (
            FavoriteStopsReaderSqliteRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, get_favorite_stops_dto: GetFavoriteStopsDto
    ) -> GetFavoriteStopsResultDto:
        """Caso de uso: GetFavoriteStops.

        Returns:
            GetFavoriteStopsResultDto: las paradas del dueño resuelto.

        Raises:
            UsersException: la del guardarraíl.
        """
        authorize_user_result_dto = await self._authorize_user_service(
            AuthorizeUserDto(
                user_tg_id=get_favorite_stops_dto.user_tg_id,
                password=get_favorite_stops_dto.password,
                target_user_tg_id=get_favorite_stops_dto.target_user_tg_id,
            )
        )

        favorite_stops = self._favorite_stops_reader_sqlite_repository.get_favorite_stops_by_user_id(
            authorize_user_result_dto.owner_user_id
        )
        owner_user_tg_id = authorize_user_result_dto.owner_user_tg_id

        return GetFavoriteStopsResultDto.from_primitives({
            FavoriteStopKeyEnum.OWNER_USER_TG_ID: owner_user_tg_id,
            FavoriteStopKeyEnum.FAVORITE_STOPS: favorite_stops,
            FavoriteStopKeyEnum.TOTAL: len(favorite_stops),
            FavoriteStopKeyEnum.IS_OTHER_USER: (
                owner_user_tg_id != authorize_user_result_dto.user_tg_id
            ),
        })
