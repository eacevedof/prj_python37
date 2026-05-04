import hashlib
import os
from datetime import datetime
from pathlib import Path
from typing import Any, final, Self
import glob as glob_module

import chromadb
from chromadb.config import Settings
from sentence_transformers import SentenceTransformer

from ddd.ia_memory.domain.enums import MemoryTypeEnum
from ddd.ia_memory.domain.exceptions import MemoryException


@final
class VectorDbRepository:
    """Repository for ChromaDB vector database operations."""

    _instance: "VectorDbRepository | None" = None
    _embedding_model: SentenceTransformer | None = None
    _client: chromadb.PersistentClient | None = None

    def __init__(self) -> None:
        self._data_path = os.getenv(
            "MEMORY_CHROMA_PATH",
            str(Path(__file__).parent.parent.parent.parent.parent / "data" / "chroma")
        )
        self._model_name = os.getenv("MEMORY_EMBEDDING_MODEL", "all-MiniLM-L6-v2")

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def _get_client(self) -> chromadb.PersistentClient:
        if self._client is None:
            Path(self._data_path).mkdir(parents=True, exist_ok=True)
            self._client = chromadb.PersistentClient(
                path=self._data_path,
                settings=Settings(anonymized_telemetry=False)
            )
        return self._client

    def _get_embedding_model(self) -> SentenceTransformer:
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
        try:
            model = self._get_embedding_model()
            embedding = model.encode(text, convert_to_numpy=True)
            return embedding.tolist()
        except Exception as e:
            raise MemoryException.embedding_failed(str(e))

    def _calculate_content_hash(self, paths: list[str]) -> str:
        try:
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
        except Exception as e:
            raise MemoryException.hash_calculation_error(paths, str(e))

    def store(
        self,
        project: str,
        memory_type: MemoryTypeEnum,
        content: str,
        paths: list[str] | None = None,
        metadata: dict[str, Any] | None = None,
    ) -> dict[str, Any]:
        try:
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
        except MemoryException:
            raise
        except Exception as e:
            raise MemoryException.storage_error(str(e))

    def search(
        self,
        project: str,
        query: str,
        limit: int = 5,
        memory_type: MemoryTypeEnum | None = None,
    ) -> dict[str, Any]:
        try:
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
        except Exception as e:
            raise MemoryException.storage_error(str(e))


    def check_freshness(self, project: str) -> dict[str, Any]:
        try:
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
        except Exception as e:
            raise MemoryException.storage_error(str(e))

    def update(
        self,
        chunk_id: str,
        project: str,
        content: str | None = None,
        paths: list[str] | None = None,
        metadata: dict[str, Any] | None = None,
    ) -> dict[str, Any]:
        try:
            collection = self._get_collection(project)
            existing = collection.get(ids=[chunk_id], include=["documents", "metadatas"])
            if not existing["ids"]:
                raise MemoryException.chunk_not_found(chunk_id)
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
        except MemoryException:
            raise
        except Exception as e:
            raise MemoryException.storage_error(str(e))

