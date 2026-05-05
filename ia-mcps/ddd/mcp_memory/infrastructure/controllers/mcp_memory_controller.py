import json
from typing import Any, final, Self

from mcp.server import Server
from mcp.server.stdio import stdio_server
from mcp.types import Tool, TextContent

from ddd.mcp_memory.domain.enums import ToolNameEnum
from ddd.mcp_memory.infrastructure.repositories import ToolsSchemaRepository
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
class McpMemoryController:
    _instance: "McpMemoryController | None" = None

    def __init__(self) -> None:
        self._server = Server("mcp-memory")
        self._tools_repo = ToolsSchemaRepository.get_instance()
        self._setup_handlers()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def _setup_handlers(self) -> None:
        @self._server.list_tools()
        async def list_tools() -> list[Tool]:
            tools_data = self._tools_repo.get_tools()
            return [Tool(**tool) for tool in tools_data]

        @self._server.call_tool()
        async def call_tool(name: str, arguments: dict[str, Any]) -> list[TextContent]:
            result = await self._handle_tool(name, arguments)
            return [TextContent(type="text", text=json.dumps(result, indent=2))]

    async def _handle_tool(self, name: str, args: dict[str, Any]) -> dict[str, Any]:
        try:
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
                return {"error": f"Unknown tool: {name}"}
        except Exception as e:
            return {"error": str(e)}

    async def _store_memory(self, args: dict[str, Any]) -> dict[str, Any]:
        dto = StoreMemoryDto(
            project=args["project"],
            memory_type=MemoryTypeEnum(args["type"]),
            content=args["content"],
            paths=args.get("paths"),
            metadata=args.get("metadata"),
        )
        service = StoreMemoryService.get_instance()
        return await service(dto)

    async def _search_memory(self, args: dict[str, Any]) -> dict[str, Any]:
        memory_type = MemoryTypeEnum(args["type"]) if args.get("type") else None
        dto = SearchMemoryDto(
            project=args["project"],
            query=args["query"],
            limit=args.get("limit", 5),
            memory_type=memory_type,
        )
        service = SearchMemoryService.get_instance()
        return await service(dto)

    async def _check_freshness(self, args: dict[str, Any]) -> dict[str, Any]:
        dto = CheckFreshnessDto(project=args["project"])
        service = CheckFreshnessService.get_instance()
        return await service(dto)

    async def _list_memories(self, args: dict[str, Any]) -> dict[str, Any]:
        memory_type = MemoryTypeEnum(args["type"]) if args.get("type") else None
        dto = ListMemoriesDto(
            project=args["project"],
            memory_type=memory_type,
            stale_only=args.get("stale_only", False),
        )
        service = ListMemoriesService.get_instance()
        return await service(dto)

    async def _delete_memory(self, args: dict[str, Any]) -> dict[str, Any]:
        dto = DeleteMemoryDto(
            chunk_id=args["chunk_id"],
            project=args["project"],
        )
        service = DeleteMemoryService.get_instance()
        return await service(dto)

    async def _update_memory(self, args: dict[str, Any]) -> dict[str, Any]:
        dto = UpdateMemoryDto(
            chunk_id=args["chunk_id"],
            project=args["project"],
            content=args.get("content"),
            paths=args.get("paths"),
            metadata=args.get("metadata"),
        )
        service = UpdateMemoryService.get_instance()
        return await service(dto)

    async def _store_file(self, args: dict[str, Any]) -> dict[str, Any]:
        memory_type = MemoryTypeEnum(args.get("type", "documentation"))
        dto = StoreFileDto(
            project=args["project"],
            file_path=args["file_path"],
            memory_type=memory_type,
        )
        service = StoreFileService.get_instance()
        return await service(dto)

    async def run(self) -> None:
        async with stdio_server() as (read_stream, write_stream):
            await self._server.run(read_stream, write_stream, self._server.create_initialization_options())
