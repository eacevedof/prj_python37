from dataclasses import dataclass, field
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class GetToolSchemasResultDto:
    """Salida del caso de uso: el catálogo de tools del módulo.

    `tool_schemas` es una lista de dicts (JSON Schema), no de DTOs: es el
    contrato que el SDK de MCP publica tal cual en `tools/list`, y la regla de
    DTOs planos pide primitivos.
    """

    tool_schemas: list[dict[str, Any]] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        tool_schemas = primitives.get("tool_schemas", [])
        return cls(
            tool_schemas=tool_schemas if isinstance(tool_schemas, list) else [],
            total=int(primitives.get("total", 0)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {"tool_schemas": self.tool_schemas, "total": self.total}
