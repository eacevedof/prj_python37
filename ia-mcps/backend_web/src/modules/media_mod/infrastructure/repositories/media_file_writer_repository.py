import base64
import os
from pathlib import Path
from typing import Self, final

from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)

from src.modules.media_mod.domain.exceptions.open_ai_exception import OpenAIException


@final
class MediaFileWriterRepository:
    """Persistencia en disco de lo que genera OpenAI (datasource: filesystem).

    Antes esto vivía dentro del servidor MCP: decodificaba el base64 y escribía
    el fichero. Guardar es infraestructura del dominio, no cosa de la fachada,
    así que se queda en el módulo de negocio.

    La carpeta destino sale de `MEDIA_OUTPUT_DIR`; sin ella no se puede escribir
    y se falla explícito en vez de dejar el fichero en un sitio inesperado.
    """

    _environment_reader_raw_repository: EnvironmentReaderRawRepository

    def __init__(self) -> None:
        self._environment_reader_raw_repository = EnvironmentReaderRawRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_written_file_path(self, file_name: str, content_b64: str) -> str:
        """Escribe el contenido base64 y devuelve la ruta final."""
        output_dir_path = self.__get_output_dir_path()
        file_path = os.path.join(output_dir_path, file_name)
        with open(file_path, "wb") as media_file:
            media_file.write(base64.b64decode(content_b64))
        return file_path

    def __get_output_dir_path(self) -> str:
        output_dir = self._environment_reader_raw_repository.get_media_output_dir()
        if not output_dir:
            OpenAIException.unexpected_custom("MEDIA_OUTPUT_DIR is not configured")
        Path(output_dir).mkdir(parents=True, exist_ok=True)
        return output_dir
