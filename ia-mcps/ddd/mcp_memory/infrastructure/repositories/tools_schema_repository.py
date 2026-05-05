from typing import Any, final, Self

from ddd.mcp_memory.domain.enums import ToolNameEnum


@final
class ToolsSchemaRepository:
    _instance: "ToolsSchemaRepository | None" = None

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_tools(self) -> list[dict[str, Any]]:
        return [
            {
                "name": ToolNameEnum.MEMORY_STORE.value,
                "description": "Store a memory chunk in ChromaDB for long-term project context",
                "inputSchema": {
                    "type": "object",
                    "properties": {
                        "project": {"type": "string", "description": "Project name (collection)"},
                        "type": {
                            "type": "string",
                            "enum": ["module", "application", "domain", "infrastructure", "persistence", "documentation"],
                            "description": "Type of memory"
                        },
                        "content": {"type": "string", "description": "Content to store"},
                        "paths": {
                            "type": "array",
                            "items": {"type": "string"},
                            "description": "File paths for freshness tracking (optional)"
                        },
                    },
                    "required": ["project", "type", "content"]
                }
            },
            {
                "name": ToolNameEnum.MEMORY_SEARCH.value,
                "description": "Search memory chunks by semantic similarity",
                "inputSchema": {
                    "type": "object",
                    "properties": {
                        "project": {"type": "string", "description": "Project name"},
                        "query": {"type": "string", "description": "Search query"},
                        "limit": {"type": "integer", "default": 5, "description": "Max results"},
                        "type": {
                            "type": "string",
                            "enum": ["module", "application", "domain", "infrastructure", "persistence", "documentation"],
                            "description": "Filter by type (optional)"
                        },
                    },
                    "required": ["project", "query"]
                }
            },
            {
                "name": ToolNameEnum.MEMORY_CHECK_FRESHNESS.value,
                "description": "Check if memory chunks are still fresh (files unchanged)",
                "inputSchema": {
                    "type": "object",
                    "properties": {
                        "project": {"type": "string", "description": "Project name"},
                    },
                    "required": ["project"]
                }
            },
            {
                "name": ToolNameEnum.MEMORY_LIST.value,
                "description": "List all memory chunks in a project",
                "inputSchema": {
                    "type": "object",
                    "properties": {
                        "project": {"type": "string", "description": "Project name"},
                        "type": {
                            "type": "string",
                            "enum": ["module", "application", "domain", "infrastructure", "persistence", "documentation"],
                            "description": "Filter by type (optional)"
                        },
                        "stale_only": {"type": "boolean", "default": False, "description": "Only show stale chunks"},
                    },
                    "required": ["project"]
                }
            },
            {
                "name": ToolNameEnum.MEMORY_DELETE.value,
                "description": "Delete a memory chunk by ID",
                "inputSchema": {
                    "type": "object",
                    "properties": {
                        "project": {"type": "string", "description": "Project name"},
                        "chunk_id": {"type": "string", "description": "Chunk ID to delete"},
                    },
                    "required": ["project", "chunk_id"]
                }
            },
            {
                "name": ToolNameEnum.MEMORY_UPDATE.value,
                "description": "Update an existing memory chunk",
                "inputSchema": {
                    "type": "object",
                    "properties": {
                        "project": {"type": "string", "description": "Project name"},
                        "chunk_id": {"type": "string", "description": "Chunk ID to update"},
                        "content": {"type": "string", "description": "New content (optional)"},
                        "paths": {
                            "type": "array",
                            "items": {"type": "string"},
                            "description": "New paths (optional)"
                        },
                    },
                    "required": ["project", "chunk_id"]
                }
            },
            {
                "name": ToolNameEnum.MEMORY_STORE_FILE.value,
                "description": "Process and store a file (PDF, image, audio, Word, Excel) in memory",
                "inputSchema": {
                    "type": "object",
                    "properties": {
                        "project": {"type": "string", "description": "Project name"},
                        "file_path": {"type": "string", "description": "Path to file"},
                        "type": {
                            "type": "string",
                            "enum": ["module", "application", "domain", "infrastructure", "persistence", "documentation"],
                            "default": "documentation",
                            "description": "Memory type"
                        },
                    },
                    "required": ["project", "file_path"]
                }
            },
        ]
