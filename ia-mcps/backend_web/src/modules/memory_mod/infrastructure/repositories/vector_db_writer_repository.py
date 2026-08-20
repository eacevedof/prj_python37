from __future__ import annotations

import glob as glob_module
import hashlib
import os
from datetime import datetime
from pathlib import Path
from typing import Any, TYPE_CHECKING, final, Self

from src.modules.shared.infrastructure.components.logger.logger import Logger
from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)
from src.modules.memory_mod.domain.enums import MemoryTypeEnum
from src.modules.memory_mod.domain.exceptions import MemoryException

# chromadb y sentence-transformers se importan DENTRO de los métodos, no arriba:
# entre los dos arrastran torch y varios cientos de MB, y con el import a nivel
# de módulo levantar la app (o correr los tests de cualquier otro módulo) exigía
# tenerlos instalados. `from __future__ import annotations` deja las anotaciones
# como texto, así que los tipos de abajo no se evalúan en tiempo de ejecución.
if TYPE_CHECKING:
    import chromadb
    from sentence_transformers import SentenceTransformer


@final
class VectorDbWriterRepository:
    """Writer for ChromaDB vector database operations (store, update, delete)."""

    _logger: Logger
    _embedding_model: SentenceTransformer | None = None
    _client: Any = None
    _data_path: str
    _model_name: str

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        environment_reader_raw_repository = EnvironmentReaderRawRepository.get_instance()
        # .../backend_web/src/modules/memory_mod/infrastructure/repositories/x.py
        #      parents[5] = backend_web
        self._data_path = environment_reader_raw_repository.get_memory_chroma_path(
            str(Path(__file__).resolve().parents[5] / "storage" / "cache" / "chroma")
        )
        self._model_name = environment_reader_raw_repository.get_memory_embedding_model()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def _get_client(self) -> chromadb.PersistentClient:
        import chromadb
        from chromadb.config import Settings

        if self._client is None:
            Path(self._data_path).mkdir(parents=True, exist_ok=True)
            self._client = chromadb.PersistentClient(
                path=self._data_path,
                settings=Settings(anonymized_telemetry=False)
            )
        return self._client

    def _get_embedding_model(self) -> SentenceTransformer:
        from sentence_transformers import SentenceTransformer

        if self._embedding_model is None:
            self._embedding_model = SentenceTransformer(self._model_name)
        return self._embedding_model

    def _get_collection(self, project: str) -> chromadb.Collection:
        client = self._get_client()
        return client.get_or_create_collection(
            name=project,
            metadata={"description": f"Memory for project {project}"}
        )

    def _generate_embedding(self, text: str) -> list[float]:
        model = self._get_embedding_model()
        embedding = model.encode(text, convert_to_numpy=True)
        return embedding.tolist()

    def _calculate_content_hash(self, paths: list[str]) -> str:
        hasher = hashlib.sha256()
        all_files: list[str] = []
        for pattern in paths:
            if "*" in pattern or "?" in pattern:
                matched = glob_module.glob(pattern, recursive=True)
                all_files.extend(sorted(matched))
            else:
                if os.path.exists(pattern):
                    all_files.append(pattern)
        for file_path in sorted(set(all_files)):
            if os.path.isfile(file_path):
                with open(file_path, "rb") as f:
                    hasher.update(f.read())
        return f"sha256:{hasher.hexdigest()}"

    def store(
        self,
        project: str,
        memory_type: MemoryTypeEnum,
        content: str,
        paths: list[str] | None = None,
        metadata: dict[str, Any] | None = None,
    ) -> dict[str, Any]:
        collection = self._get_collection(project)
        embedding = self._generate_embedding(content)
        chunk_id = hashlib.sha256(
            f"{project}:{content}:{datetime.now().isoformat()}".encode()
        ).hexdigest()[:16]
        now = datetime.now().isoformat()
        chunk_metadata: dict[str, Any] = {
            "type": memory_type.value,
            "created_at": now,
            "updated_at": now,
        }
        if paths:
            chunk_metadata["paths"] = ",".join(paths)
            chunk_metadata["content_hash"] = self._calculate_content_hash(paths)
        if metadata:
            for key, value in metadata.items():
                if isinstance(value, (str, int, float, bool)):
                    chunk_metadata[key] = value
        collection.add(
            ids=[chunk_id],
            embeddings=[embedding],
            documents=[content],
            metadatas=[chunk_metadata]
        )
        return {
            "id": chunk_id,
            "project": project,
            "type": memory_type.value,
            "content": content,
            "metadata": chunk_metadata,
            "source": "chromadb",
        }

    def update(
        self,
        chunk_id: str,
        project: str,
        content: str | None = None,
        paths: list[str] | None = None,
        metadata: dict[str, Any] | None = None,
    ) -> dict[str, Any]:
        collection = self._get_collection(project)
        existing = collection.get(ids=[chunk_id], include=["documents", "metadatas"])
        if not existing["ids"]:
            MemoryException.not_found_custom(f"Memory chunk not found: {chunk_id}")
        current_content = existing["documents"][0] if existing["documents"] else ""
        current_metadata = existing["metadatas"][0] if existing["metadatas"] else {}
        new_content = content if content is not None else current_content
        new_metadata = dict(current_metadata)
        new_metadata["updated_at"] = datetime.now().isoformat()
        if paths:
            new_metadata["paths"] = ",".join(paths)
            new_metadata["content_hash"] = self._calculate_content_hash(paths)
        if metadata:
            for key, value in metadata.items():
                if isinstance(value, (str, int, float, bool)):
                    new_metadata[key] = value
        new_embedding = self._generate_embedding(new_content)
        collection.update(
            ids=[chunk_id],
            embeddings=[new_embedding],
            documents=[new_content],
            metadatas=[new_metadata]
        )
        return {
            "id": chunk_id,
            "project": project,
            "content": new_content,
            "metadata": new_metadata,
            "source": "chromadb",
        }

    def delete(self, chunk_id: str, project: str) -> dict[str, Any]:
        collection = self._get_collection(project)
        existing = collection.get(ids=[chunk_id])
        if not existing["ids"]:
            MemoryException.not_found_custom(f"Memory chunk not found: {chunk_id}")
        collection.delete(ids=[chunk_id])
        return {
            "id": chunk_id,
            "project": project,
            "deleted": True,
            "source": "chromadb",
        }
