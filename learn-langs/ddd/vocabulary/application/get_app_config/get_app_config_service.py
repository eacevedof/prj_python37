"""Servicio para obtener la configuracion de la aplicacion."""

from typing import final, Self

from ddd.vocabulary.application.get_app_config.get_app_config_result_dto import (
    GetAppConfigResultDto,
)
from ddd.vocabulary.infrastructure.repositories import AppConfigReaderRawRepository


@final
class GetAppConfigService:
    """Servicio para obtener la configuracion de la aplicacion."""

    __instance: "GetAppConfigService | None" = None
    _cached_config: GetAppConfigResultDto | None = None
    _app_config_reader_raw_repository: AppConfigReaderRawRepository

    def __init__(self) -> None:
        self._app_config_reader_raw_repository = AppConfigReaderRawRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls.__instance is None:
            cls.__instance = cls()
        return cls.__instance

    def __call__(self) -> GetAppConfigResultDto:
        """
        Obtiene la configuracion de la aplicacion.

        Returns:
            GetAppConfigResultDto con toda la configuracion.
        """
        # Cache para evitar lecturas repetidas
        if self._cached_config is not None:
            return self._cached_config

        config_data = self._app_config_reader_raw_repository.get_all()

        self._cached_config = GetAppConfigResultDto.from_primitives(config_data)
        return self._cached_config

    @classmethod
    def clear_cache(cls) -> None:
        """Limpia la cache de configuracion."""
        if cls.__instance:
            cls.__instance._cached_config = None
