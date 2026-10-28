"""Raw repository para leer configuracion de la aplicacion."""

import os
from pathlib import Path
from typing import final, Self

from ddd.vocabulary.domain.enums.app_config_default_enum import AppConfigDefaultEnum


@final
class AppConfigReaderRawRepository:
    """Repository para leer configuracion de la aplicacion desde env o defaults."""

    __instance: "AppConfigReaderRawRepository | None" = None

    # Defaults (enumerados en el dominio; aquí solo se tipan para el type-checker)
    _DEFAULT_APP_TITLE: str = AppConfigDefaultEnum.APP_TITLE.value

    _DEFAULT_WINDOW_WIDTH: int = AppConfigDefaultEnum.WINDOW_WIDTH.value
    _DEFAULT_WINDOW_HEIGHT: int = AppConfigDefaultEnum.WINDOW_HEIGHT.value

    _DEFAULT_WINDOW_MIN_WIDTH: int = AppConfigDefaultEnum.WINDOW_MIN_WIDTH.value
    _DEFAULT_WINDOW_MIN_HEIGHT: int = AppConfigDefaultEnum.WINDOW_MIN_HEIGHT.value

    def __init__(self) -> None:
        self._base_path = Path(__file__).parent.parent.parent.parent.parent

    @classmethod
    def get_instance(cls) -> Self:
        if cls.__instance is None:
            cls.__instance = cls()
        return cls.__instance

    def get_app_title(self) -> str:
        return os.getenv("APP_TITLE", self._DEFAULT_APP_TITLE)

    def get_window_width(self) -> int:
        return int(os.getenv("APP_WINDOW_WIDTH", self._DEFAULT_WINDOW_WIDTH))

    def get_window_height(self) -> int:
        return int(os.getenv("APP_WINDOW_HEIGHT", self._DEFAULT_WINDOW_HEIGHT))

    def get_window_min_width(self) -> int:
        return int(os.getenv("APP_WINDOW_MIN_WIDTH", self._DEFAULT_WINDOW_MIN_WIDTH))

    def get_window_min_height(self) -> int:
        return int(os.getenv("APP_WINDOW_MIN_HEIGHT", self._DEFAULT_WINDOW_MIN_HEIGHT))

    def get_migrations_path(self) -> str:
        default = str(
            self._base_path / "ddd" / "vocabulary" / "infrastructure" / "persistence" / "migrations"
        )
        return os.getenv("APP_MIGRATIONS_PATH", default)

    def get_db_path(self) -> str:
        default = str(self._base_path / "data" / "learn_lang.db")
        return os.getenv("APP_DB_PATH", default)

    def get_all(self) -> dict:
        """Retorna toda la configuracion como diccionario."""
        return {
            "app_title": self.get_app_title(),
            "window_width": self.get_window_width(),
            "window_height": self.get_window_height(),
            "window_min_width": self.get_window_min_width(),
            "window_min_height": self.get_window_min_height(),
            "migrations_path": self.get_migrations_path(),
            "db_path": self.get_db_path(),
        }
