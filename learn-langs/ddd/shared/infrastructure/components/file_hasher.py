"""Componente: calcula digests del contenido de un fichero (envuelve hashlib)."""

import hashlib
from pathlib import Path
from typing import Self, final


@final
class FileHasher:
    """Hashes del contenido de un fichero. Wrapper de la stdlib (hashlib), sin
    dependencias externas: se usa para detectar si un recurso local cambio
    (regeneracion) y decidir si re-subirlo al CDN.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_md5(self, file_path: str) -> str:
        return hashlib.md5(Path(file_path).read_bytes()).hexdigest()
