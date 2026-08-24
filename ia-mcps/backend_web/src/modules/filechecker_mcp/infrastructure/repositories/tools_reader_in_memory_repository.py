from typing import Any, Self, final

from src.modules.shared.domain.enums.json_schema_key_enum import JsonSchemaKeyEnum
from src.modules.shared.domain.enums.json_schema_type_enum import JsonSchemaTypeEnum
from src.modules.shared.infrastructure.repositories.abstract_tools_reader_in_memory_repository import (
    AbstractToolsReaderInMemoryRepository,
)
from src.modules.filechecker_mcp.domain.enums.tool_name_enum import ToolNameEnum


@final
class ToolsReaderInMemoryRepository(AbstractToolsReaderInMemoryRepository):
    """Fuente de los inputSchema (JSON Schema) de las tools de file_checker."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all(self) -> list[dict[str, Any]]:
        return [
            self.__get_verify_file_signature_schema(),
        ]

    def __get_verify_file_signature_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.VERIFY_FILE_SIGNATURE.value,
            JsonSchemaKeyEnum.DESCRIPTION: (
                "verifica un fichero LOCAL: calcula su hash, extrae metadatos, detecta el formato"
                " ejecutable y comprueba la firma digital. La descarga desde URL está desactivada"
                " (APP_FILE_CHECKER_ALLOW_URL_DOWNLOAD): hay que pasar una ruta local"
            ),
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "file_path_or_url": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: (
                            "ruta local del fichero (p. ej. '/ruta/fichero.exe'). Las URL http/https"
                            " se rechazan mientras la descarga esté desactivada"
                        ),
                    },
                    "algorithm": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "algoritmo de hash (por defecto sha256)",
                        JsonSchemaKeyEnum.ENUM: ["md5", "sha1", "sha256", "sha512"],
                        JsonSchemaKeyEnum.DEFAULT: "sha256",
                    },
                },
                JsonSchemaKeyEnum.REQUIRED: ["file_path_or_url"],
            },
        }
