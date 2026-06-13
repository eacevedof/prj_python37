from typing import final, Self

from ddd.ia_memory.application.store_file.store_file_dto import StoreFileDto
from ddd.ia_memory.application.store_file.store_file_result_dto import StoreFileResultDto
from ddd.ia_memory.infrastructure.repositories import VectorDbWriterRepository, FileProcessorRepository


@final
class StoreFileService:
    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: StoreFileDto) -> StoreFileResultDto:
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
