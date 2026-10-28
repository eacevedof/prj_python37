from typing import Any, Self, final

from src.modules.shared.domain.enums.json_schema_key_enum import JsonSchemaKeyEnum
from src.modules.shared.domain.enums.json_schema_type_enum import JsonSchemaTypeEnum
from src.modules.shared.infrastructure.repositories.abstract_tools_reader_in_memory_repository import (
    AbstractToolsReaderInMemoryRepository,
)
from src.modules.pdf_mcp.domain.enums.tool_name_enum import ToolNameEnum


@final
class ToolsReaderInMemoryRepository(AbstractToolsReaderInMemoryRepository):
    """Fuente de los inputSchema (JSON Schema) de las tools de pdf."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all(self) -> list[dict[str, Any]]:
        return [
            self.__get_convert_md_to_pdf_schema(),
        ]

    def __get_convert_md_to_pdf_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.CONVERT_MD_TO_PDF.value,
            JsonSchemaKeyEnum.DESCRIPTION: (
                "convierte un fichero Markdown local a PDF; el PDF se guarda en la misma carpeta"
                " y con el mismo nombre"
            ),
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "md_file_path": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: (
                            "ruta absoluta del fichero Markdown (p. ej. 'C:/projects/docs/guia.md')"
                        ),
                    },
                },
                JsonSchemaKeyEnum.REQUIRED: ["md_file_path"],
            },
        }
