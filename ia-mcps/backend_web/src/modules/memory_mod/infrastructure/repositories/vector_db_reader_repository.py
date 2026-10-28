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
class VectorDbReaderRepository:
    """Reader for ChromaDB vector database operations (search, list, check freshness)."""

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

    def search(
        self,
        project: str,
        query: str,
        limit: int = 5,
        memory_type: MemoryTypeEnum | None = None,
    ) -> dict[str, Any]:
        collection = self._get_collection(project)
        query_embedding = self._generate_embedding(query)
        where_filter = None
        if memory_type:
            where_filter = {"type": memory_type.value}
        results = collection.query(
            query_embeddings=[query_embedding],
            n_results=limit,
            where=where_filter,
            include=["documents", "metadatas", "distances"]
        )
        chunks = []
        if results["ids"] and results["ids"][0]:
            for i, chunk_id in enumerate(results["ids"][0]):
                chunk = {
                    "id": chunk_id,
                    "content": results["documents"][0][i] if results["documents"] else "",
                    "metadata": results["metadatas"][0][i] if results["metadatas"] else {},
                    "similarity": 1 - (results["distances"][0][i] if results["distances"] else 0),
                }
                chunks.append(chunk)
        return {
            "source": "chromadb",
            "project": project,
            "query": query,
            "chunks_found": len(chunks),
            "results": chunks,
        }

    def check_freshness(self, project: str) -> dict[str, Any]:
        collection = self._get_collection(project)
        all_data = collection.get(include=["documents", "metadatas"])
        results = []
        fresh_count = 0
        stale_count = 0
        unknown_count = 0
        if all_data["ids"]:
            for i, chunk_id in enumerate(all_data["ids"]):
                metadata = all_data["metadatas"][i] if all_data["metadatas"] else {}
                content = all_data["documents"][i] if all_data["documents"] else ""
                paths_str = metadata.get("paths", "")
                stored_hash = metadata.get("content_hash", "")
                if not paths_str or not stored_hash:
                    status = "unknown"
                    unknown_count += 1
                else:
                    paths = paths_str.split(",")
                    try:
                        current_hash = self._calculate_content_hash(paths)
                        if current_hash == stored_hash:
                            status = "fresh"
                            fresh_count += 1
                        else:
                            status = "stale"
                            stale_count += 1
                    except Exception:
                        status = "error"
                        unknown_count += 1
                results.append({
                    "id": chunk_id,
                    "type": metadata.get("type", ""),
                    "status": status,
                    "content_preview": content[:100] + "..." if len(content) > 100 else content,
                    "paths": paths_str,
                    "updated_at": metadata.get("updated_at", ""),
                })
        return {
            "source": "chromadb",
            "project": project,
            "total_chunks": len(results),
            "fresh": fresh_count,
            "stale": stale_count,
            "unknown": unknown_count,
            "chunks": results,
        }

    def list_chunks(
        self,
        project: str,
        memory_type: MemoryTypeEnum | None = None,
        stale_only: bool = False,
    ) -> dict[str, Any]:
        collection = self._get_collection(project)
        where_filter = None
        if memory_type:
            where_filter = {"type": memory_type.value}
        all_data = collection.get(
            where=where_filter,
            include=["documents", "metadatas"]
        )
        chunks = []
        if all_data["ids"]:
            for i, chunk_id in enumerate(all_data["ids"]):
                metadata = all_data["metadatas"][i] if all_data["metadatas"] else {}
                content = all_data["documents"][i] if all_data["documents"] else ""
                if stale_only:
                    paths_str = metadata.get("paths", "")
                    stored_hash = metadata.get("content_hash", "")
                    if paths_str and stored_hash:
                        paths = paths_str.split(",")
                        try:
                            current_hash = self._calculate_content_hash(paths)
                            if current_hash == stored_hash:
                                continue
                        except Exception:
                            pass
                chunks.append({
                    "id": chunk_id,
                    "type": metadata.get("type", ""),
                    "content_preview": content[:100] + "..." if len(content) > 100 else content,
                    "paths": metadata.get("paths", ""),
                    "created_at": metadata.get("created_at", ""),
                    "updated_at": metadata.get("updated_at", ""),
                })
        return {
            "source": "chromadb",
            "project": project,
            "total_chunks": len(chunks),
            "chunks": chunks,
        }
