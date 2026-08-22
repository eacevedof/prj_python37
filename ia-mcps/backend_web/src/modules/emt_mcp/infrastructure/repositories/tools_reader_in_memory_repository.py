from typing import Any, Self, final

from src.modules.shared.domain.enums.json_schema_key_enum import JsonSchemaKeyEnum
from src.modules.shared.domain.enums.json_schema_type_enum import JsonSchemaTypeEnum
from src.modules.shared.infrastructure.repositories.abstract_tools_reader_in_memory_repository import (
    AbstractToolsReaderInMemoryRepository,
)
from src.modules.emt_mcp.domain.enums.tool_name_enum import ToolNameEnum


@final
class ToolsReaderInMemoryRepository(AbstractToolsReaderInMemoryRepository):
    """Fuente de los inputSchema (JSON Schema) de las tools de EMT."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all(self) -> list[dict[str, Any]]:
        return [
            self.__get_stop_arrivals_schema(),
            self.__get_lines_info_schema(),
            self.__get_stops_around_schema(),
            self.__get_stop_detail_schema(),
            self.__add_favorite_stop_schema(),
            self.__get_favorite_stops_schema(),
            self.__update_favorite_stop_schema(),
            self.__delete_favorite_stop_schema(),
            self.__get_users_schema(),
        ]

    def __get_stop_arrivals_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.GET_STOP_ARRIVALS.value,
            JsonSchemaKeyEnum.DESCRIPTION: (
                "llegadas de autobús en tiempo real a una parada de la EMT de Madrid"
            ),
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "stop_id": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "id de la parada (p. ej. '72', '1234')",
                    },
                    "line_ids": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: (
                            "ids de línea separados por coma para filtrar (opcional, p. ej. '001,002,C1')"
                        ),
                    },
                },
                JsonSchemaKeyEnum.REQUIRED: ["stop_id"],
            },
        }

    def __get_lines_info_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.GET_LINES_INFO.value,
            JsonSchemaKeyEnum.DESCRIPTION: "información de una línea de autobús de la EMT de Madrid",
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "line_id": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "id de la línea (p. ej. '105', 'C1')",
                    },
                    "date": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "fecha en formato YYYYMMDD (opcional, por defecto hoy)",
                    },
                },
                JsonSchemaKeyEnum.REQUIRED: ["line_id"],
            },
        }

    def __get_stops_around_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.GET_STOPS_AROUND.value,
            JsonSchemaKeyEnum.DESCRIPTION: (
                "paradas de la EMT de Madrid alrededor de unas coordenadas"
            ),
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "latitude": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.NUMBER,
                        JsonSchemaKeyEnum.DESCRIPTION: "latitud (p. ej. 40.4168)",
                    },
                    "longitude": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.NUMBER,
                        JsonSchemaKeyEnum.DESCRIPTION: "longitud (p. ej. -3.7038)",
                    },
                    "radius": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.INTEGER,
                        JsonSchemaKeyEnum.DESCRIPTION: "radio de búsqueda en metros (por defecto 500, máx. 1000)",
                        JsonSchemaKeyEnum.DEFAULT: 500,
                    },
                },
                JsonSchemaKeyEnum.REQUIRED: ["latitude", "longitude"],
            },
        }

    def __get_stop_detail_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.GET_STOP_DETAIL.value,
            JsonSchemaKeyEnum.DESCRIPTION: "detalle de una parada de la EMT de Madrid",
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "stop_id": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "id de la parada (p. ej. '72', '1234')",
                    },
                },
                JsonSchemaKeyEnum.REQUIRED: ["stop_id"],
            },
        }

    def __get_user_property_schemas(self) -> dict[str, Any]:
        """Los tres campos que llevan todas las tools con dueño.

        Se declaran una sola vez: son el contrato de acceso, y si en una tool
        quedara distinto el modelo mandaría cosas distintas según la tool.
        """
        return {
            "user_tg_id": {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                JsonSchemaKeyEnum.DESCRIPTION: "id de telegram de quien hace la petición",
            },
            "password": {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                JsonSchemaKeyEnum.DESCRIPTION: (
                    "contraseña del usuario; solo hace falta cuando la respuesta anterior la"
                    " ha pedido (la validación caduca a los 7 días)"
                ),
            },
            "target_user_tg_id": {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                JsonSchemaKeyEnum.DESCRIPTION: (
                    "id de telegram de OTRO usuario sobre el que operar; solo para"
                    " administradores, omitir para trabajar sobre las paradas propias"
                ),
            },
        }

    def __add_favorite_stop_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.ADD_FAVORITE_STOP.value,
            JsonSchemaKeyEnum.DESCRIPTION: (
                "guarda una parada de la EMT en las favoritas del usuario"
            ),
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    **self.__get_user_property_schemas(),
                    "stop_nr": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "número de la parada (p. ej. '72', '1234')",
                    },
                    "stop_description": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: (
                            "cómo llama el usuario a esa parada (p. ej. 'casa', 'oficina')"
                        ),
                    },
                },
                JsonSchemaKeyEnum.REQUIRED: ["user_tg_id", "stop_nr"],
            },
        }

    def __get_favorite_stops_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.GET_FAVORITE_STOPS.value,
            JsonSchemaKeyEnum.DESCRIPTION: "las paradas favoritas guardadas por el usuario",
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: self.__get_user_property_schemas(),
                JsonSchemaKeyEnum.REQUIRED: ["user_tg_id"],
            },
        }

    def __update_favorite_stop_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.UPDATE_FAVORITE_STOP.value,
            JsonSchemaKeyEnum.DESCRIPTION: (
                "cambia la descripción de una parada favorita del usuario"
            ),
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    **self.__get_user_property_schemas(),
                    "stop_nr": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "número de la parada ya guardada",
                    },
                    "stop_description": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "nueva descripción de la parada",
                    },
                },
                JsonSchemaKeyEnum.REQUIRED: ["user_tg_id", "stop_nr", "stop_description"],
            },
        }

    def __delete_favorite_stop_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.DELETE_FAVORITE_STOP.value,
            JsonSchemaKeyEnum.DESCRIPTION: "quita una parada de las favoritas del usuario",
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    **self.__get_user_property_schemas(),
                    "stop_nr": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "número de la parada a quitar",
                    },
                },
                JsonSchemaKeyEnum.REQUIRED: ["user_tg_id", "stop_nr"],
            },
        }

    def __get_users_schema(self) -> dict[str, Any]:
        user_property_schemas = self.__get_user_property_schemas()
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.GET_USERS.value,
            JsonSchemaKeyEnum.DESCRIPTION: (
                "los usuarios dados de alta; SOLO para administradores"
            ),
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "user_tg_id": user_property_schemas["user_tg_id"],
                    "password": user_property_schemas["password"],
                },
                JsonSchemaKeyEnum.REQUIRED: ["user_tg_id"],
            },
        }
