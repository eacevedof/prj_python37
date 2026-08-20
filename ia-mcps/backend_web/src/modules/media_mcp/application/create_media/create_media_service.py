from typing import Self, final

from src.modules.shared.domain.enums.validation_message_enum import ValidationMessageEnum
from src.modules.shared.infrastructure.components.schema_validator.schema_validator import SchemaValidator

from src.modules.media_mod.domain.enums.media_result_key_enum import MediaResultKeyEnum
from src.modules.media_mod.infrastructure.adapters.media_generation_adapter import (
    MediaGenerationAdapter,
)

from src.modules.media_mcp.domain.enums.tool_name_enum import ToolNameEnum
from src.modules.media_mcp.domain.exceptions.media_mcp_exception import MediaMcpException
from src.modules.media_mcp.domain.ports.media_generation import MediaGeneration
from src.modules.media_mcp.infrastructure.repositories.tools_reader_in_memory_repository import (
    ToolsReaderInMemoryRepository,
)
from src.modules.media_mcp.application.create_media.create_media_dto import CreateMediaDto
from src.modules.media_mcp.application.create_media.create_media_result_dto import (
    CreateMediaResultDto,
)


@final
class CreateMediaService:
    """Caso de uso de la fachada MCP: ejecutar una tool del servidor de media.

    NO tiene lógica de negocio: valida el payload contra el schema publicado,
    enruta al caso de uso de `media_mod` a través del puerto y redacta el
    resultado como texto para el agente.
    """

    _schema_validator: SchemaValidator
    _tools_reader_in_memory_repository: ToolsReaderInMemoryRepository
    _media_generation: MediaGeneration

    _create_media_dto: CreateMediaDto

    def __init__(self) -> None:
        self._schema_validator = SchemaValidator.get_instance()
        self._tools_reader_in_memory_repository = ToolsReaderInMemoryRepository.get_instance()
        self._media_generation: MediaGeneration = MediaGenerationAdapter.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, create_media_dto: CreateMediaDto) -> CreateMediaResultDto:
        """Caso de uso: CreateMedia.

        Returns:
            CreateMediaResultDto: texto de respuesta para el agente.

        Raises:
            MediaMcpException: si la tool no existe o el payload no cumple el
                inputSchema publicado.
            OpenAIException: la que propague el caso de uso de media_mod.
        """
        self._create_media_dto = create_media_dto
        self._fail_if_wrong_input()

        if self._create_media_dto.tool_name == ToolNameEnum.CREATE_IMAGE.value:
            text = await self.__get_created_image_text()
        elif self._create_media_dto.tool_name == ToolNameEnum.CREATE_AUDIO.value:
            text = await self.__get_created_audio_text()
        else:
            MediaMcpException.bad_request(f"unknown tool: {self._create_media_dto.tool_name}")

        return CreateMediaResultDto.from_primitives({
            "tool_name": self._create_media_dto.tool_name,
            "text": text,
        })

    def _fail_if_wrong_input(self) -> None:
        if not self._create_media_dto.tool_name:
            MediaMcpException.bad_request(ValidationMessageEnum.TOOL_NAME_REQUIRED)
        self.__fail_if_payload_breaks_the_published_schema()

    def __fail_if_payload_breaks_the_published_schema(self) -> None:
        input_schema = self._tools_reader_in_memory_repository.get_input_schema_by_tool_name(
            self._create_media_dto.tool_name
        )
        if not input_schema:
            return
        first_error_message = self._schema_validator.get_first_error_message(
            self._create_media_dto.payload_dict, input_schema
        )
        if first_error_message:
            MediaMcpException.bad_request(first_error_message)

    async def __get_created_image_text(self) -> str:
        result = await self._media_generation.generate_image(self._create_media_dto.payload_dict)
        file_paths = result[MediaResultKeyEnum.FILES]
        files_text = "\n".join(f"- {file_path}" for file_path in file_paths)
        return (
            f"generadas {len(file_paths)} imagen(es):\n"
            f"{files_text}\n\n"
            f"modelo: {result[MediaResultKeyEnum.MODEL]}\n"
            f"tamaño: {result[MediaResultKeyEnum.SIZE]}\n"
            f"calidad: {result[MediaResultKeyEnum.QUALITY]}"
        )

    async def __get_created_audio_text(self) -> str:
        result = await self._media_generation.generate_audio(self._create_media_dto.payload_dict)
        file_paths = result[MediaResultKeyEnum.FILES]
        files_text = "\n".join(f"- {file_path}" for file_path in file_paths)
        return (
            f"generado el audio:\n"
            f"{files_text}\n\n"
            f"modelo: {result[MediaResultKeyEnum.MODEL]}\n"
            f"voz: {result[MediaResultKeyEnum.VOICE]}\n"
            f"velocidad: {result[MediaResultKeyEnum.SPEED]}\n"
            f"formato: {result[MediaResultKeyEnum.FORMAT]}"
        )
