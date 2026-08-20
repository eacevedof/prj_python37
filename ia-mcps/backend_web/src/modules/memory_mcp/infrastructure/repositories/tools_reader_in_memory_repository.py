from typing import Any, Self, final

from src.modules.shared.domain.enums.json_schema_key_enum import JsonSchemaKeyEnum
from src.modules.shared.domain.enums.json_schema_type_enum import JsonSchemaTypeEnum
from src.modules.shared.infrastructure.repositories.abstract_tools_reader_in_memory_repository import (
    AbstractToolsReaderInMemoryRepository,
)
from src.modules.memory_mcp.domain.enums.tool_name_enum import ToolNameEnum

# Los tipos de memoria son los de `MemoryTypeEnum` (memory_mod). Se listan aquí
# como literales a propósito: el inputSchema es el contrato PUBLICADO al modelo y
# no debe cambiar solo porque el dominio añada un tipo interno.
_MEMORY_TYPES = [
    "module",
    "application",
    "domain",
    "infrastructure",
    "persistence",
    "documentation",
]
_DEFAULT_SEARCH_LIMIT = 5


@final
class ToolsReaderInMemoryRepository(AbstractToolsReaderInMemoryRepository):
    """Fuente de los inputSchema (JSON Schema) de las tools de memory."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all(self) -> list[dict[str, Any]]:
        return [
            self.__get_store_schema(),
            self.__get_search_schema(),
            self.__get_check_freshness_schema(),
            self.__get_list_schema(),
            self.__get_delete_schema(),
            self.__get_update_schema(),
            self.__get_store_file_schema(),
        ]

    def __get_project_property(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
            JsonSchemaKeyEnum.DESCRIPTION: "nombre del proyecto (colección)",
        }

    def __get_memory_type_property(self, description: str) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
            JsonSchemaKeyEnum.ENUM: _MEMORY_TYPES,
            JsonSchemaKeyEnum.DESCRIPTION: description,
        }

    def __get_paths_property(self, description: str) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.ARRAY,
            JsonSchemaKeyEnum.ITEMS: {JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING},
            JsonSchemaKeyEnum.DESCRIPTION: description,
        }

    def __get_store_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.STORE.value,
            JsonSchemaKeyEnum.DESCRIPTION: (
                "guarda un fragmento de memoria en ChromaDB como contexto de proyecto a largo plazo"
            ),
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "project": self.__get_project_property(),
                    "type": self.__get_memory_type_property("tipo de memoria"),
                    "content": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "contenido a guardar",
                    },
                    "paths": self.__get_paths_property(
                        "rutas de fichero para el control de frescura (opcional)"
                    ),
                },
                JsonSchemaKeyEnum.REQUIRED: ["project", "type", "content"],
            },
        }

    def __get_search_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.SEARCH.value,
            JsonSchemaKeyEnum.DESCRIPTION: "busca fragmentos de memoria por similitud semántica",
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "project": self.__get_project_property(),
                    "query": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "texto de búsqueda",
                    },
                    "limit": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.INTEGER,
                        JsonSchemaKeyEnum.DEFAULT: _DEFAULT_SEARCH_LIMIT,
                        JsonSchemaKeyEnum.DESCRIPTION: "máximo de resultados",
                    },
                    "type": self.__get_memory_type_property("filtrar por tipo (opcional)"),
                },
                JsonSchemaKeyEnum.REQUIRED: ["project", "query"],
            },
        }

    def __get_check_freshness_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.CHECK_FRESHNESS.value,
            JsonSchemaKeyEnum.DESCRIPTION: (
                "comprueba si los fragmentos siguen frescos (ficheros sin cambios)"
            ),
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {"project": self.__get_project_property()},
                JsonSchemaKeyEnum.REQUIRED: ["project"],
            },
        }

    def __get_list_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.LIST.value,
            JsonSchemaKeyEnum.DESCRIPTION: "lista los fragmentos de memoria de un proyecto",
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "project": self.__get_project_property(),
                    "type": self.__get_memory_type_property("filtrar por tipo (opcional)"),
                    "stale_only": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.BOOLEAN,
                        JsonSchemaKeyEnum.DEFAULT: False,
                        JsonSchemaKeyEnum.DESCRIPTION: "solo los fragmentos caducados",
                    },
                },
                JsonSchemaKeyEnum.REQUIRED: ["project"],
            },
        }

    def __get_delete_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.DELETE.value,
            JsonSchemaKeyEnum.DESCRIPTION: "borra un fragmento de memoria por su id",
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "project": self.__get_project_property(),
                    "chunk_id": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "id del fragmento a borrar",
                    },
                },
                JsonSchemaKeyEnum.REQUIRED: ["project", "chunk_id"],
            },
        }

    def __get_update_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.UPDATE.value,
            JsonSchemaKeyEnum.DESCRIPTION: "actualiza un fragmento de memoria existente",
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "project": self.__get_project_property(),
                    "chunk_id": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "id del fragmento a actualizar",
                    },
                    "content": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "nuevo contenido (opcional)",
                    },
                    "paths": self.__get_paths_property("nuevas rutas (opcional)"),
                },
                JsonSchemaKeyEnum.REQUIRED: ["project", "chunk_id"],
            },
        }

    def __get_store_file_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.STORE_FILE.value,
            JsonSchemaKeyEnum.DESCRIPTION: (
                "procesa y guarda un fichero (PDF, imagen, audio, Word, Excel) en la memoria."
                " DESACTIVADA por defecto (MEMORY_ALLOW_STORE_FILE): usa memory_store pasando el"
                " contenido en vez de una ruta"
            ),
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "project": self.__get_project_property(),
                    "file_path": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "ruta del fichero",
                    },
                    "type": {
                        **self.__get_memory_type_property("tipo de memoria"),
                        JsonSchemaKeyEnum.DEFAULT: "documentation",
                    },
                },
                JsonSchemaKeyEnum.REQUIRED: ["project", "file_path"],
            },
        }
