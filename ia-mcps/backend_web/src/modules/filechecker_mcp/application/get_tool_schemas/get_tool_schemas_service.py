from typing import Self, final

from src.modules.filechecker_mcp.application.get_tool_schemas.get_tool_schemas_result_dto import (
    GetToolSchemasResultDto,
)
from src.modules.filechecker_mcp.infrastructure.repositories.tools_reader_in_memory_repository import (
    ToolsReaderInMemoryRepository,
)


@final
class GetToolSchemasService:
    """Caso de uso de la fachada MCP: publicar el catálogo de tools (`tools/list`).

    Hermano de `VerifyFileService` (`tools/call`): las dos operaciones del protocolo son
    dos casos de uso, y el controller no habla con el repositorio ni para una ni
    para otra.

    Síncrono a propósito: el catálogo es CÓDIGO (se declara en el repositorio en
    memoria), así que no hay E/S que esperar y el handler del SDK lo pide sin
    await.
    """

    _tools_reader_in_memory_repository: ToolsReaderInMemoryRepository

    def __init__(self) -> None:
        self._tools_reader_in_memory_repository = ToolsReaderInMemoryRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self) -> GetToolSchemasResultDto:
        """Caso de uso: GetToolSchemas.

        Returns:
            GetToolSchemasResultDto: el catálogo tal cual se publica.
        """
        tool_schemas = self._tools_reader_in_memory_repository.get_all()
        return GetToolSchemasResultDto.from_primitives({
            "tool_schemas": tool_schemas,
            "total": len(tool_schemas),
        })
