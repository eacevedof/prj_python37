import asyncio
from ddd.mcp_memory.infrastructure.controllers.mcp_memory_controller import McpMemoryController


def main() -> None:
    controller = McpMemoryController.get_instance()
    asyncio.run(controller.run())


if __name__ == "__main__":
    main()
