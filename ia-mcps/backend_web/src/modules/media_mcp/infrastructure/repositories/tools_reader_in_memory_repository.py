from typing import Any, Self, final

from src.modules.shared.domain.enums.json_schema_key_enum import JsonSchemaKeyEnum
from src.modules.shared.domain.enums.json_schema_type_enum import JsonSchemaTypeEnum
from src.modules.shared.infrastructure.repositories.abstract_tools_reader_in_memory_repository import (
    AbstractToolsReaderInMemoryRepository,
)
from src.modules.media_mcp.domain.enums.tool_name_enum import ToolNameEnum


@final
class ToolsReaderInMemoryRepository(AbstractToolsReaderInMemoryRepository):
    """Fuente de los inputSchema (JSON Schema) de las tools de media."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all(self) -> list[dict[str, Any]]:
        return [
            self.__get_create_image_schema(),
            self.__get_create_audio_schema(),
        ]

    def __get_create_image_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.CREATE_IMAGE.value,
            JsonSchemaKeyEnum.DESCRIPTION: (
                "genera una imagen a partir de un texto con OpenAI y la guarda en disco"
            ),
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "prompt": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "descripción de la imagen a generar",
                    },
                    "model": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "modelo (gpt-image-1.5, gpt-image-2, dall-e-3, dall-e-2)",
                        JsonSchemaKeyEnum.DEFAULT: "gpt-image-1.5",
                    },
                    "size": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: (
                            "tamaño (256x256, 512x512, 1024x1024, 1024x1792, 1792x1024)"
                        ),
                        JsonSchemaKeyEnum.DEFAULT: "1024x1024",
                    },
                    "quality": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "calidad (standard, hd) — solo dall-e-3",
                        JsonSchemaKeyEnum.DEFAULT: "standard",
                    },
                    "n": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.INTEGER,
                        JsonSchemaKeyEnum.DESCRIPTION: "número de imágenes (1-10)",
                        JsonSchemaKeyEnum.DEFAULT: 1,
                    },
                    "filename": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: (
                            "nombre de fichero sin extensión (opcional; por defecto se genera del prompt)"
                        ),
                    },
                },
                JsonSchemaKeyEnum.REQUIRED: ["prompt"],
            },
        }

    def __get_create_audio_schema(self) -> dict[str, Any]:
        return {
            JsonSchemaKeyEnum.NAME: ToolNameEnum.CREATE_AUDIO.value,
            JsonSchemaKeyEnum.DESCRIPTION: (
                "genera audio a partir de un texto con OpenAI (TTS) y lo guarda en disco"
            ),
            JsonSchemaKeyEnum.INPUT_SCHEMA: {
                JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.OBJECT,
                JsonSchemaKeyEnum.ADDITIONAL_PROPERTIES: False,
                JsonSchemaKeyEnum.PROPERTIES: {
                    "text": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "texto a convertir en voz (máx. 4096 caracteres)",
                    },
                    "voice": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "voz (alloy, echo, fable, onyx, nova, shimmer)",
                        JsonSchemaKeyEnum.DEFAULT: "alloy",
                    },
                    "model": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "modelo (tts-1, tts-1-hd)",
                        JsonSchemaKeyEnum.DEFAULT: "tts-1",
                    },
                    "speed": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.NUMBER,
                        JsonSchemaKeyEnum.DESCRIPTION: "velocidad de reproducción (0.25 a 4.0)",
                        JsonSchemaKeyEnum.DEFAULT: 1.0,
                    },
                    "response_format": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: "formato (mp3, opus, aac, flac, wav, pcm)",
                        JsonSchemaKeyEnum.DEFAULT: "mp3",
                    },
                    "filename": {
                        JsonSchemaKeyEnum.TYPE: JsonSchemaTypeEnum.STRING,
                        JsonSchemaKeyEnum.DESCRIPTION: (
                            "nombre de fichero sin extensión (opcional; por defecto se genera del texto)"
                        ),
                    },
                },
                JsonSchemaKeyEnum.REQUIRED: ["text"],
            },
        }
