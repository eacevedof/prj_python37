from pathlib import Path
from typing import Self, final

from src.modules.voice_mod.infrastructure.repositories.voice_mode_reader_file_repository import (
    VOICE_MODE_FLAG_FILE_PATH,
)


@final
class VoiceModeWriterFileRepository:
    """Enciende y apaga el modo voz (datasource: un fichero bandera).

    Encender = crear el fichero; apagar = borrarlo. Quien lo lee es
    `VoiceModeReaderFileRepository`.
    """

    _flag_file_path: Path

    def __init__(self, flag_file_path: Path | None = None) -> None:
        self._flag_file_path = flag_file_path or VOICE_MODE_FLAG_FILE_PATH

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def turn_voice_mode_on(self) -> None:
        self._flag_file_path.parent.mkdir(parents=True, exist_ok=True)
        self._flag_file_path.touch()

    def turn_voice_mode_off(self) -> None:
        self._flag_file_path.unlink(missing_ok=True)
