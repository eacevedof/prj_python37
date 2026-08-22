from typing import Self, final

from src.modules.emt_mod.application.get_favorite_stops.get_favorite_stops_dto import (
    GetFavoriteStopsDto,
)
from src.modules.emt_mod.application.get_favorite_stops.get_favorite_stops_result_dto import (
    GetFavoriteStopsResultDto,
)
from src.modules.emt_mod.domain.enums.favorite_stop_key_enum import FavoriteStopKeyEnum
from src.modules.emt_mod.domain.ports.user_authorizer_port import UserAuthorizerPort
from src.modules.emt_mod.infrastructure.repositories.favorite_stops_reader_sqlite_repository import (
    FavoriteStopsReaderSqliteRepository,
)
from src.modules.users_mod.domain.enums.user_key_enum import UserKeyEnum
from src.modules.users_mod.infrastructure.adapters.user_authorizer_adapter import (
    UserAuthorizerAdapter,
)


@final
class GetFavoriteStopsService:
    """Caso de uso: listar las paradas favoritas de un usuario.

    La consulta se hace SIEMPRE con el id del dueño que devuelve el
    guardarraíl, así que un usuario normal no tiene forma de pedir las de otro:
    no existe un camino en el que el id de la consulta salga del payload.
    """

    _user_authorizer_port: UserAuthorizerPort
    _favorite_stops_reader_sqlite_repository: FavoriteStopsReaderSqliteRepository

    def __init__(self) -> None:
        self._user_authorizer_port: UserAuthorizerPort = UserAuthorizerAdapter.get_instance()
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
        authorized_user = await self._user_authorizer_port.get_authorized_user({
            UserKeyEnum.USER_TG_ID: get_favorite_stops_dto.user_tg_id,
            UserKeyEnum.PASSWORD: get_favorite_stops_dto.password,
            UserKeyEnum.TARGET_USER_TG_ID: get_favorite_stops_dto.target_user_tg_id,
        })

        favorite_stops = self._favorite_stops_reader_sqlite_repository.get_favorite_stops_by_user_id(
            int(authorized_user[UserKeyEnum.OWNER_USER_ID])
        )
        owner_user_tg_id = str(authorized_user[UserKeyEnum.OWNER_USER_TG_ID])

        return GetFavoriteStopsResultDto.from_primitives({
            FavoriteStopKeyEnum.OWNER_USER_TG_ID: owner_user_tg_id,
            FavoriteStopKeyEnum.FAVORITE_STOPS: favorite_stops,
            FavoriteStopKeyEnum.TOTAL: len(favorite_stops),
            FavoriteStopKeyEnum.IS_OTHER_USER: (
                owner_user_tg_id != str(authorized_user[UserKeyEnum.USER_TG_ID])
            ),
        })
