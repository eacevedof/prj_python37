from typing import final, Self

from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)

from src.modules.memory_mod.application.store_file.store_file_dto import StoreFileDto
from src.modules.memory_mod.application.store_file.store_file_result_dto import StoreFileResultDto
from src.modules.memory_mod.domain.exceptions import MemoryException
from src.modules.memory_mod.infrastructure.repositories import VectorDbWriterRepository, FileProcessorRepository


@final
class StoreFileService:
    _environment_reader_raw_repository: EnvironmentReaderRawRepository

    def __init__(self) -> None:
        self._environment_reader_raw_repository = EnvironmentReaderRawRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: StoreFileDto) -> StoreFileResultDto:
        """
        Raises:
            MemoryException: si la tool está desactivada (por defecto lo está).
        """
        # Interruptor: la ruta la elige un modelo y lo que se guarda vuelve luego
        # como TEXTO por `memory_search`. Es lectura de fichero arbitraria +
        # exfiltración en dos pasos (p. ej. leer el .env y buscarlo después).
        # Hasta que las rutas estén confinadas (ver to-do de prompt injection),
        # viene apagada de fábrica.
        if not self._environment_reader_raw_repository.is_memory_store_file_allowed():
            MemoryException.bad_request_custom(
                "StoreFileService: memory_store_file is disabled; "
                "store the content with memory_store instead"
            )

        file_processor = FileProcessorRepository.get_instance()
        vector_db = VectorDbWriterRepository.get_instance()

        chunks = file_processor.process_file(dto.file_path)
        stored = []

        for chunk in chunks:
            result = vector_db.store(
                project=dto.project,
                memory_type=dto.memory_type,
                content=chunk["content"],
                paths=[dto.file_path],
                metadata=chunk.get("metadata"),
            )
            stored.append(result)

        return StoreFileResultDto.from_primitives({
            "source": "chromadb",
            "project": dto.project,
            "file": dto.file_path,
            "chunks_stored": len(stored),
            "chunks": stored,
        })
