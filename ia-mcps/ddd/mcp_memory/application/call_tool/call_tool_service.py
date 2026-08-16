from typing import Any, final, Self

from ddd.mcp_memory.domain.enums import ToolNameEnum
from ddd.mcp_memory.application.call_tool.call_tool_dto import CallToolDto
from ddd.mcp_memory.application.call_tool.call_tool_result_dto import CallToolResultDto
from ddd.ia_memory.domain.enums import MemoryTypeEnum
from ddd.ia_memory.application import (
	StoreMemoryDto, StoreMemoryService,
	SearchMemoryDto, SearchMemoryService,
	CheckFreshnessDto, CheckFreshnessService,
	ListMemoriesDto, ListMemoriesService,
	DeleteMemoryDto, DeleteMemoryService,
	UpdateMemoryDto, UpdateMemoryService,
	StoreFileDto, StoreFileService,
)


@final
class CallToolService:
	"""Executes a tool by name and arguments."""

	def __init__(self) -> None:
		pass

	@classmethod
	def get_instance(cls) -> Self:
		return cls()

	async def __call__(self, dto: CallToolDto) -> dict[str, Any]:
		result = await self._execute_tool(dto.tool_name, dto.tool_arguments)
		return result

	async def _execute_tool(self, name: str, args: dict[str, Any]) -> dict[str, Any]:
		if name == ToolNameEnum.MEMORY_STORE.value:
			return await self._store_memory(args)
		elif name == ToolNameEnum.MEMORY_SEARCH.value:
			return await self._search_memory(args)
		elif name == ToolNameEnum.MEMORY_CHECK_FRESHNESS.value:
			return await self._check_freshness(args)
		elif name == ToolNameEnum.MEMORY_LIST.value:
			return await self._list_memories(args)
		elif name == ToolNameEnum.MEMORY_DELETE.value:
			return await self._delete_memory(args)
		elif name == ToolNameEnum.MEMORY_UPDATE.value:
			return await self._update_memory(args)
		elif name == ToolNameEnum.MEMORY_STORE_FILE.value:
			return await self._store_file(args)
		else:
			raise ValueError(f"Unknown tool: {name}")

	async def _store_memory(self, args: dict[str, Any]) -> dict[str, Any]:
		dto = StoreMemoryDto(
			project=args["project"],
			memory_type=MemoryTypeEnum(args["type"]),
			content=args["content"],
			paths=args.get("paths"),
			metadata=args.get("metadata"),
		)
		service = StoreMemoryService.get_instance()
		result_dto = await service(dto)
		return result_dto.to_primitives()

	async def _search_memory(self, args: dict[str, Any]) -> dict[str, Any]:
		memory_type = MemoryTypeEnum(args["type"]) if args.get("type") else None
		dto = SearchMemoryDto(
			project=args["project"],
			query=args["query"],
			limit=args.get("limit", 5),
			memory_type=memory_type,
		)
		service = SearchMemoryService.get_instance()
		result_dto = await service(dto)
		return result_dto.to_primitives()

	async def _check_freshness(self, args: dict[str, Any]) -> dict[str, Any]:
		dto = CheckFreshnessDto(project=args["project"])
		service = CheckFreshnessService.get_instance()
		result_dto = await service(dto)
		return result_dto.to_primitives()

	async def _list_memories(self, args: dict[str, Any]) -> dict[str, Any]:
		memory_type = MemoryTypeEnum(args["type"]) if args.get("type") else None
		dto = ListMemoriesDto(
			project=args["project"],
			memory_type=memory_type,
			stale_only=args.get("stale_only", False),
		)
		service = ListMemoriesService.get_instance()
		result_dto = await service(dto)
		return result_dto.to_primitives()

	async def _delete_memory(self, args: dict[str, Any]) -> dict[str, Any]:
		dto = DeleteMemoryDto(
			chunk_id=args["chunk_id"],
			project=args["project"],
		)
		service = DeleteMemoryService.get_instance()
		result_dto = await service(dto)
		return result_dto.to_primitives()

	async def _update_memory(self, args: dict[str, Any]) -> dict[str, Any]:
		dto = UpdateMemoryDto(
			chunk_id=args["chunk_id"],
			project=args["project"],
			content=args.get("content"),
			paths=args.get("paths"),
			metadata=args.get("metadata"),
		)
		service = UpdateMemoryService.get_instance()
		result_dto = await service(dto)
		return result_dto.to_primitives()

	async def _store_file(self, args: dict[str, Any]) -> dict[str, Any]:
		memory_type = MemoryTypeEnum(args.get("type", "documentation"))
		dto = StoreFileDto(
			project=args["project"],
			file_path=args["file_path"],
			memory_type=memory_type,
		)
		service = StoreFileService.get_instance()
		result_dto = await service(dto)
		return result_dto.to_primitives()
