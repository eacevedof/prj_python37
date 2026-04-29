"""Raw repository para leer configuracion de la aplicacion."""

import os
from pathlib import Path
from typing import final, Self


@final
class AppConfigReaderRawRepository:
    """Repository para leer configuracion de la aplicacion desde env o defaults."""

    _instance: "AppConfigReaderRawRepository | None" = None

    # Defaults
    _DEFAULT_APP_TITLE = "Learn Languages"

    _DEFAULT_WINDOW_WIDTH = 600
    _DEFAULT_WINDOW_HEIGHT = 900

    _DEFAULT_WINDOW_MIN_WIDTH = 600
    _DEFAULT_WINDOW_MIN_HEIGHT = 900

    def __init__(self) -> None:
        self._base_path = Path(__file__).parent.parent.parent.parent.parent

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

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
