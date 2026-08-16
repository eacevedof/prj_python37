"""Componente: mover/borrar ficheros tolerando locks transitorios (Windows)."""

import time
from pathlib import Path
from typing import Self

from ddd.shared.domain.enums.file_move_retry_enum import FileMoveRetryEnum


class RetryingFileMover:
    """Renombra/borra ficheros reintentando ante locks transitorios (Windows).

    En Windows un fichero recién usado (p.ej. un mp3 recién reproducido) puede
    seguir con un handle abierto un instante y os.replace/unlink fallar con
    WinError 5. Se reintenta con backoff. Si tras los reintentos sigue fallando,
    el error se PROPAGA (no se traga): el reintento es robustez de plataforma,
    no ocultación de fallos.
    """

    _RETRIES: int = FileMoveRetryEnum.RETRIES.value
    _BACKOFF_SECONDS: float = FileMoveRetryEnum.BACKOFF_SECONDS.value

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def replace(self, source: Path, target: Path) -> None:
        """Renombra source -> target reintentando; si persiste, copia bytes y borra el origen."""
        last_error: OSError | None = None
        for attempt in range(self._RETRIES):
            try:
                source.replace(target)
                return
            except OSError as error:
                last_error = error
                time.sleep(self._BACKOFF_SECONDS * (attempt + 1))

        # Fallback: copiar los bytes al destino y borrar el origen.
        try:
            target.write_bytes(source.read_bytes())
            self.remove(source)
            return
        except OSError:
            if last_error is not None:
                raise last_error
            raise

    def remove(self, path: Path) -> None:
        """Borra un fichero (no falla si no existe) tolerando un lock transitorio."""
        for attempt in range(self._RETRIES):
            try:
                path.unlink(missing_ok=True)
                return
            except OSError:
                time.sleep(self._BACKOFF_SECONDS * (attempt + 1))
        # Último intento sin capturar: si sigue bloqueado, que propague.
        path.unlink(missing_ok=True)
