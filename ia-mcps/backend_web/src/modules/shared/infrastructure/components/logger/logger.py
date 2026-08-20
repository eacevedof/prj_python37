import json
import traceback
from datetime import datetime
from pathlib import Path
from typing import Any, Self, final

from src.modules.shared.domain.enums.env_var_enum import EnvVarEnum
from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)


@final
class Logger:
    """Log a fichero, uno por día y por nivel, bajo `backend_web/storage/logs`.

    La carpeta se puede mover con `APP_LOG_PATH`.
    """

    # .../backend_web/src/modules/shared/infrastructure/components/logger/logger.py
    #      parents[6] = backend_web
    _DEFAULT_LOG_PATH: str = str(Path(__file__).resolve().parents[6] / "storage" / "logs")
    _instance: "Logger | None" = None

    _environment_reader_raw_repository: EnvironmentReaderRawRepository

    def __init__(self) -> None:
        self._environment_reader_raw_repository = EnvironmentReaderRawRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def log_info(self, module: str, message: str) -> None:
        self.__write_log("info.log", f"[INFO] {module}: {message}")

    def log_debug(self, module: str, message: str, data: dict | None = None) -> None:
        log_content = f"[DEBUG] {module}: {message}"
        if data:
            log_content += f"\nData: {data}"
        self.__write_log("debug.log", log_content)

    def log_error(self, module: str, message: str, context: dict | None = None) -> None:
        log_content = f"[ERROR] {module}: {message}"
        if context:
            log_content += f"\nContext: {context}"
        self.__write_log("error.log", log_content)

    def log_exception(self, exception: BaseException, title: str = "") -> None:
        """Excepción con traza completa. `title` sitúa dónde ocurrió."""
        log_content = "[EXCEPTION]"
        if title:
            log_content += f" {title}"
        log_content += f"\n{type(exception).__name__}: {exception}"

        if exception.__traceback__:
            traceback_lines = traceback.format_exception(
                type(exception), exception, exception.__traceback__
            )
            log_content += f"\n\nTraceback:\n{''.join(traceback_lines)}"

        self.__write_log("error.log", log_content)

    def log_payload_error(self, any_obj: Any, title: str = "") -> None:
        """Payload que acompañaba a un fallo, para poder reproducirlo."""
        log_content = "[PAYLOAD]"
        if title:
            log_content += f" {title}"

        try:
            payload_str = json.dumps(
                any_obj,
                indent=2,
                ensure_ascii=False,
                default=lambda obj: obj.__dict__ if hasattr(obj, "__dict__") else str(obj),
            )
        except Exception:
            payload_str = str(any_obj)

        log_content += f"\n{payload_str}"
        self.__write_log("error.log", log_content)

    def __write_log(self, file_name: str, content: str) -> None:
        logs_folder_path = Path(
            self._environment_reader_raw_repository.get_log_path(self._DEFAULT_LOG_PATH)
        ).resolve()
        logs_folder_path.mkdir(parents=True, exist_ok=True)

        today = datetime.now().strftime("%Y-%m-%d")
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        log_file_path = logs_folder_path / f"{today}-{file_name}"

        with open(log_file_path, "a", encoding="utf-8") as log_file:
            log_file.write(f"\n[{now}]\n{content.strip()}")
