import json
from pathlib import Path
from typing import Any, Self, final

from src.modules.voice_mod.domain.exceptions.voice_exception import VoiceException


@final
class TranscriptReaderJsonlRepository:
    """Lectura del transcript de una sesión de Claude Code (datasource: `.jsonl`).

    Una línea = un objeto JSON. Una línea que no se pueda parsear (el fichero se
    está escribiendo mientras se lee) se salta en vez de tumbar la lectura.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_entries(self, transcript_path: str) -> list[dict[str, Any]]:
        """
        Raises:
            VoiceException: si el fichero no existe.
        """
        transcript_file_path = Path(transcript_path).expanduser()
        if not transcript_file_path.is_file():
            VoiceException.bad_request_custom(f"transcript not found: {transcript_path}")

        transcript_entries: list[dict[str, Any]] = []
        with transcript_file_path.open(encoding="utf-8") as transcript_file:
            for transcript_line in transcript_file:
                try:
                    transcript_entry = json.loads(transcript_line)
                except json.JSONDecodeError:
                    continue
                if isinstance(transcript_entry, dict):
                    transcript_entries.append(transcript_entry)
        return transcript_entries
