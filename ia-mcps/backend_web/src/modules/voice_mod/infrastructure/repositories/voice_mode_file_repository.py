from pathlib import Path
from typing import Self, final


@final
class VoiceModeFileRepository:
    """Si el modo voz está activo (datasource: un fichero bandera).

    Lo enciende `/voz` y lo apaga decir «fin voz». Vive en `storage/cache` porque
    es estado efímero de esta máquina. Es uno para todas las sesiones: con dos
    Claude Code abiertos en el proyecto, los dos escucharían.
    """

    _flag_file_path: Path

    def __init__(self, flag_file_path: Path | None = None) -> None:
        self._flag_file_path = flag_file_path or (
            Path(__file__).resolve().parents[5] / "storage" / "cache" / "voice" / "voice-mode.on"
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def is_voice_mode_on(self) -> bool:
        return self._flag_file_path.is_file()

    def turn_voice_mode_on(self) -> None:
        self._flag_file_path.parent.mkdir(parents=True, exist_ok=True)
        self._flag_file_path.touch()

    def turn_voice_mode_off(self) -> None:
        self._flag_file_path.unlink(missing_ok=True)
