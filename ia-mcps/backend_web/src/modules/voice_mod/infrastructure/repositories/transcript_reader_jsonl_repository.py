from pathlib import Path
from typing import Self, final

from src.modules.voice_mod.domain.enums import VoiceMessageEnum
from src.modules.voice_mod.domain.exceptions.voice_exception import VoiceException


@final
class TranscriptReaderJsonlRepository:
    """Lectura del transcript de una sesión de Claude Code (datasource: `.jsonl`).

    Devuelve las líneas en crudo, con su `\\n`: decidir qué línea vale (la última
    puede estar a medio escribir) es cosa del caso de uso, no del repositorio.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_lines(self, transcript_path: str) -> list[str]:
        """
        Raises:
            VoiceException: si el fichero no existe.
        """
        transcript_file_path = Path(transcript_path).expanduser()
        if not transcript_file_path.is_file():
            VoiceException.bad_request_custom(f"{VoiceMessageEnum.TRANSCRIPT_NOT_FOUND}: {transcript_path}")

        with transcript_file_path.open(encoding="utf-8") as transcript_file:
            return transcript_file.readlines()
