"""Repositorio de escritura de audios mp3 de palabras (datasource: file)."""

import time
from pathlib import Path
from typing import final, Self

from ddd.vocabulary.domain.services.tts_audio_filename_service import TtsAudioFilenameService


@final
class WordAudiosWriterFileRepository:
    """Escritura/borrado de los mp3 de pronunciación en data/audio (datasource: file)."""

    _AUDIO_DIR = Path("data/audio")
    # En Windows un mp3 recién reproducido puede seguir con handle abierto un instante;
    # reintentamos la operación de fichero con un pequeño backoff antes de rendirnos.
    _FILE_OP_RETRIES = 5
    _FILE_OP_BACKOFF_SECONDS = 0.15

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def save_temp_audio(self, word_id: int, lang_code: str, audio_bytes: bytes) -> str:
        """Guarda la propuesta temporal y devuelve su ruta."""
        self._AUDIO_DIR.mkdir(parents=True, exist_ok=True)
        temp_path = self._AUDIO_DIR / TtsAudioFilenameService.get_temp_filename(word_id, lang_code)
        temp_path.write_bytes(audio_bytes)
        return str(temp_path)

    def delete_audio(self, word_id: int, lang_code: str) -> None:
        audio_path = self._AUDIO_DIR / TtsAudioFilenameService.get_filename(word_id, lang_code)
        self._unlink_with_retry(audio_path)

    def delete_temp_audio(self, word_id: int, lang_code: str) -> None:
        temp_path = self._AUDIO_DIR / TtsAudioFilenameService.get_temp_filename(word_id, lang_code)
        self._unlink_with_retry(temp_path)

    def promote_temp_audio(self, word_id: int, lang_code: str) -> str:
        """Convierte la propuesta temporal en el audio definitivo y devuelve su ruta.

        En Windows os.replace falla con WinError 5 si el destino (o el origen) sigue
        con un handle abierto (p.ej. el reproductor). Reintentamos con backoff y, si
        aun así persiste, hacemos fallback a copiar los bytes y borrar el temporal.
        """
        temp_path = self._AUDIO_DIR / TtsAudioFilenameService.get_temp_filename(word_id, lang_code)
        audio_path = self._AUDIO_DIR / TtsAudioFilenameService.get_filename(word_id, lang_code)

        last_error: OSError | None = None
        for attempt in range(self._FILE_OP_RETRIES):
            try:
                temp_path.replace(audio_path)
                return str(audio_path)
            except OSError as error:
                last_error = error
                time.sleep(self._FILE_OP_BACKOFF_SECONDS * (attempt + 1))

        # Fallback: copiar los bytes al definitivo y borrar el temporal.
        try:
            audio_path.write_bytes(temp_path.read_bytes())
            self._unlink_with_retry(temp_path)
            return str(audio_path)
        except OSError:
            if last_error is not None:
                raise last_error
            raise

    def _unlink_with_retry(self, path: Path) -> None:
        """Borra un fichero tolerando un lock transitorio (Windows); no falla si no existe."""
        for attempt in range(self._FILE_OP_RETRIES):
            try:
                path.unlink(missing_ok=True)
                return
            except OSError:
                time.sleep(self._FILE_OP_BACKOFF_SECONDS * (attempt + 1))
        # Último intento sin capturar: si el fichero sigue bloqueado, que se propague.
        path.unlink(missing_ok=True)
