from typing import Any, Self, final

from src.modules.memory_mod.domain.enums import MemoryTypeEnum
from src.modules.memory_mod.application.check_freshness.check_freshness_dto import CheckFreshnessDto
from src.modules.memory_mod.application.check_freshness.check_freshness_service import (
    CheckFreshnessService,
)
from src.modules.memory_mod.application.delete_memory.delete_memory_dto import DeleteMemoryDto
from src.modules.memory_mod.application.delete_memory.delete_memory_service import (
    DeleteMemoryService,
)
from src.modules.memory_mod.application.list_memories.list_memories_dto import ListMemoriesDto
from src.modules.memory_mod.application.list_memories.list_memories_service import (
    ListMemoriesService,
)
from src.modules.memory_mod.application.search_memory.search_memory_dto import SearchMemoryDto
from src.modules.memory_mod.application.search_memory.search_memory_service import (
    SearchMemoryService,
)
from src.modules.memory_mod.application.store_file.store_file_dto import StoreFileDto
from src.modules.memory_mod.application.store_file.store_file_service import StoreFileService
from src.modules.memory_mod.application.store_memory.store_memory_dto import StoreMemoryDto
from src.modules.memory_mod.application.store_memory.store_memory_service import StoreMemoryService
from src.modules.memory_mod.application.update_memory.update_memory_dto import UpdateMemoryDto
from src.modules.memory_mod.application.update_memory.update_memory_service import (
    UpdateMemoryService,
)

_DEFAULT_SEARCH_LIMIT = 5
_DEFAULT_FILE_MEMORY_TYPE = "documentation"


@final
class MemoryStoreAdapter:
    """Implementación del puerto `MemoryStore` (memory_mcp/domain).

    Única puerta de este módulo hacia la fachada MCP. Aquí es donde el `type`
    que manda el agente (una cadena) se convierte en `MemoryTypeEnum`: la fachada
    no debe conocer los enums del dominio, y el dominio no debe recibir cadenas
    sueltas.

    Los casos de uso ya son async (así nacieron), así que no hace falta
    `asyncio.to_thread` como en media o pdf.
    """

    _store_memory_service: StoreMemoryService
    _search_memory_service: SearchMemoryService
    _check_freshness_service: CheckFreshnessService
    _list_memories_service: ListMemoriesService
    _delete_memory_service: DeleteMemoryService
    _update_memory_service: UpdateMemoryService
    _store_file_service: StoreFileService

    def __init__(self) -> None:
        self._store_memory_service = StoreMemoryService.get_instance()
        self._search_memory_service = SearchMemoryService.get_instance()
        self._check_freshness_service = CheckFreshnessService.get_instance()
        self._list_memories_service = ListMemoriesService.get_instance()
        self._delete_memory_service = DeleteMemoryService.get_instance()
        self._update_memory_service = UpdateMemoryService.get_instance()
        self._store_file_service = StoreFileService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def store_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await self._store_memory_service(
            StoreMemoryDto(
                project=primitives["project"],
                memory_type=MemoryTypeEnum(primitives["type"]),
                content=primitives["content"],
                paths=primitives.get("paths"),
                metadata=primitives.get("metadata"),
            )
        )
        return result_dto.to_primitives()

    async def search_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await self._search_memory_service(
            SearchMemoryDto(
                project=primitives["project"],
                query=primitives["query"],
                limit=primitives.get("limit", _DEFAULT_SEARCH_LIMIT),
                memory_type=self.__get_memory_type_or_none(primitives),
            )
        )
        return result_dto.to_primitives()

    async def check_freshness(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await self._check_freshness_service(
            CheckFreshnessDto(project=primitives["project"])
        )
        return result_dto.to_primitives()

    async def list_memories(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await self._list_memories_service(
            ListMemoriesDto(
                project=primitives["project"],
                memory_type=self.__get_memory_type_or_none(primitives),
                stale_only=primitives.get("stale_only", False),
            )
        )
        return result_dto.to_primitives()

    async def delete_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await self._delete_memory_service(
            DeleteMemoryDto(
                chunk_id=primitives["chunk_id"],
                project=primitives["project"],
            )
        )
        return result_dto.to_primitives()

    async def update_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await self._update_memory_service(
            UpdateMemoryDto(
                chunk_id=primitives["chunk_id"],
                project=primitives["project"],
                content=primitives.get("content"),
                paths=primitives.get("paths"),
                metadata=primitives.get("metadata"),
            )
        )
        return result_dto.to_primitives()

    async def store_file(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await self._store_file_service(
            StoreFileDto(
                project=primitives["project"],
                file_path=primitives["file_path"],
                memory_type=MemoryTypeEnum(primitives.get("type", _DEFAULT_FILE_MEMORY_TYPE)),
            )
        )
        return result_dto.to_primitives()

    def __get_memory_type_or_none(self, primitives: dict[str, Any]) -> MemoryTypeEnum | None:
        """`type` es opcional en varias tools: sin él, no se filtra."""
        memory_type = primitives.get("type")
        return MemoryTypeEnum(memory_type) if memory_type else None
