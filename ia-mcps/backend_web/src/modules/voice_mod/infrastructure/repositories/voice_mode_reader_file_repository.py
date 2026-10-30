from pathlib import Path
from typing import Self, final

# Lo comparten el Reader y el Writer. Vive en `storage/cache` porque es estado
# efímero de esta máquina: parents[5] = backend_web.
VOICE_MODE_FLAG_FILE_PATH = (
    Path(__file__).resolve().parents[5] / "storage" / "cache" / "voice" / "voice-mode.on"
)


@final
class VoiceModeReaderFileRepository:
    """Si el modo voz está activo (datasource: un fichero bandera).

    Lo enciende `/voz` y lo apaga decir «fin voz» (`VoiceModeWriterFileRepository`).
    Es uno para todas las sesiones: con dos Claude Code abiertos en el proyecto,
    los dos escucharían.
    """

    _flag_file_path: Path

    def __init__(self, flag_file_path: Path | None = None) -> None:
        self._flag_file_path = flag_file_path or VOICE_MODE_FLAG_FILE_PATH

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def is_voice_mode_on(self) -> bool:
        return self._flag_file_path.is_file()
