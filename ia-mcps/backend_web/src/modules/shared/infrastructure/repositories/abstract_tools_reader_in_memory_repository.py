from abc import ABC, abstractmethod
from typing import Any


class AbstractToolsReaderInMemoryRepository(ABC):
    """Base de los repos de schemas de tools, uno por módulo `xxx_mcp`.

    El "data source" es el propio código: los schemas son declarativos y se
    versionan con el módulo, no viven en BD ni en fichero. Cada concreto declara
    su catálogo en `get_all()`; la búsqueda por nombre es idéntica en todos y
    vive aquí.
    """

    @abstractmethod
    def get_all(self) -> list[dict[str, Any]]:
        """Catálogo completo de tools del módulo."""

    def get_input_schema_by_tool_name(self, tool_name: str) -> dict[str, Any]:
        """inputSchema de una tool, o {} si el módulo no la expone.

        Devolver {} en vez de fallar es deliberado: quien decide qué hacer con
        una tool desconocida es el service (que la rechaza al enrutar), no este
        repo.
        """
        for tool_schema in self.get_all():
            if tool_schema["name"] == tool_name:
                return tool_schema["inputSchema"]
        return {}
