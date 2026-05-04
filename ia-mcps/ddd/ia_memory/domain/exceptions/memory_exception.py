from typing import final


@final
class MemoryException(Exception):
    """Exception for memory operations."""

    def __init__(self, message: str) -> None:
        self.message = message
        super().__init__(self.message)

    @classmethod
    def project_not_found(cls, project: str) -> "MemoryException":
        return cls(f"Project not found: {project}")

    @classmethod
    def chunk_not_found(cls, chunk_id: str) -> "MemoryException":
        return cls(f"Memory chunk not found: {chunk_id}")

    @classmethod
    def invalid_memory_type(cls, memory_type: str) -> "MemoryException":
        return cls(f"Invalid memory type: {memory_type}")

    @classmethod
    def embedding_failed(cls, detail: str = "") -> "MemoryException":
        msg = "Failed to generate embedding"
        if detail:
            msg = f"{msg}: {detail}"
        return cls(msg)

    @classmethod
    def storage_error(cls, detail: str = "") -> "MemoryException":
        msg = "ChromaDB storage error"
        if detail:
            msg = f"{msg}: {detail}"
        return cls(msg)

    @classmethod
    def file_not_found(cls, path: str) -> "MemoryException":
        return cls(f"File not found: {path}")

    @classmethod
    def unsupported_file_type(cls, extension: str) -> "MemoryException":
        return cls(f"Unsupported file type: {extension}")

    @classmethod
    def file_processing_error(cls, path: str, detail: str = "") -> "MemoryException":
        msg = f"Failed to process file: {path}"
        if detail:
            msg = f"{msg}: {detail}"
        return cls(msg)

    @classmethod
    def hash_calculation_error(cls, paths: list[str], detail: str = "") -> "MemoryException":
        msg = f"Failed to calculate content hash for paths: {paths}"
        if detail:
            msg = f"{msg}: {detail}"
        return cls(msg)
