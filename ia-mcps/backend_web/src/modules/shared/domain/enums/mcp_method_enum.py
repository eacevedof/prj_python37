from enum import Enum


class McpMethodEnum(str, Enum):
    """Métodos del protocolo MCP que atienden los servidores `xxx_mcp`.

    Los registra `AbstractMcpController` en el `Server` del SDK. Van aquí y no
    en cada módulo porque son vocabulario del protocolo, común a todos.
    """

    LIST_TOOLS = "tools/list"
    CALL_TOOL = "tools/call"
