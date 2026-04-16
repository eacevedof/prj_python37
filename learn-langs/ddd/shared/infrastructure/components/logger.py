import os
import re
from datetime import datetime
from pathlib import Path
from typing import final, Self

from ddd.shared.domain.enums.envvars_keys_enum import EnvvarsKeysEnum


@final
class Logger:
    """Simple file-based logger for application events and errors."""

    _DEFAULT_LOG_PATH: str = str(Path(__file__).resolve().parents[4] / "logs")

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def write_log(self, file_path: str, content: str) -> None:
        environ_path_folder = os.getenv(EnvvarsKeysEnum.APP_LOG_PATH, self._DEFAULT_LOG_PATH)
        logs_folder_path = Path(environ_path_folder).resolve()
        today = datetime.now().strftime("%Y-%m-%d")

        log_file_path = logs_folder_path / file_path
        final_dir = log_file_path.parent

        if not final_dir.exists():
            final_dir.mkdir(parents=True, exist_ok=True)

        file_name = log_file_path.stem
        ext = log_file_path.suffix.lstrip(".") or "log"

        if "sql" in file_path:
            ext = "sql"

        file_name = f"{today}-{file_name}"
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        final_log_path = final_dir / f"{file_name}.{ext}"
        content = content.strip()

        if ext == "sql":
            content = self.__get_normalized_margin_for_sql(content)

        log_entry = f"\n[{now}]\n{content}"

        with open(final_log_path, "a", encoding="utf-8") as f:
            f.write(log_entry)


    def __get_normalized_margin_for_sql(self, content: str) -> str:
        content = f"{content}\n"
        return re.sub(r"^ {8}", "", content, flags=re.MULTILINE)


    def write_error(self, module: str, message: str, context: dict | None = None) -> None:
        log_content = f"[ERROR] {module}: {message}"
        if context:
            log_content += f"\nContext: {context}"
        self.write_log("errors/error.log", log_content)


    def write_info(self, module: str, message: str) -> None:
        log_content = f"[INFO] {module}: {message}"
        self.write_log("info/info.log", log_content)


    def write_debug(self, module: str, message: str, data: dict | None = None) -> None:
        log_content = f"[DEBUG] {module}: {message}"
        if data:
            log_content += f"\nData: {data}"
        self.write_log("debug/debug.log", log_content)

    # Shortcuts for repository logging
    def sql(self, query: str) -> None:
        """Log SQL query."""
        self.write_log("sql/queries.sql", query)

    def error(self, message: str, context: dict | None = None) -> None:
        """Log error message."""
        self.write_error("Repository", message, context)
