import base64
import os
from pathlib import Path
from typing import final, Self, Any

from mcp.types import TextContent

from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.components.slugger import Slugger
from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)
from ddd.mcp_media.domain.enums import ToolNameEnum
from ddd.mcp_media.application.call_tool.call_tool_dto import CallToolDto
from ddd.mcp_media.application.call_tool.call_tool_result_dto import CallToolResultDto
from ddd.open_ai.application.create_image_openai.create_image_openai_dto import (
    CreateImageOpenaiDto,
)
from ddd.open_ai.application.create_image_openai.create_image_openai_service import (
    CreateImageOpenaiService,
)
from ddd.open_ai.application.create_mp3_openai.create_mp3_openai_dto import (
    CreateMp3OpenaiDto,
)
from ddd.open_ai.application.create_mp3_openai.create_mp3_openai_service import (
    CreateMp3OpenaiService,
)
from ddd.open_ai.domain.enums import (
    OpenaiImageModelEnum,
    OpenaiImageQualityEnum,
    OpenaiImageResponseFormatEnum,
    OpenaiImageSizeEnum,
    OpenaiTtsFormatEnum,
    OpenaiTtsModelEnum,
    OpenaiTtsVoiceEnum,
)


@final
class CallToolService:
    """Service that routes MCP tool calls to Media operations."""

    _logger: Logger
    _slugger: Slugger
    _env_reader: EnvironmentReaderRawRepository
    _payload_dict: dict[str, Any]
    _output_dir: str

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._slugger = Slugger.get_instance()
        self._env_reader = EnvironmentReaderRawRepository.get_instance()
        self._payload_dict = {}
        self._output_dir = ""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, call_tool_dto: CallToolDto) -> CallToolResultDto:
        self._payload_dict = call_tool_dto.payload_dict
        self._output_dir = self._env_reader.get_media_output_dir()

        try:
            if call_tool_dto.event_name == ToolNameEnum.CREATE_IMAGE:
                text_contents = await self.__create_image_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.CREATE_AUDIO:
                text_contents = await self.__create_audio_text_content()

            else:
                text_contents = [
                    TextContent(
                        type="text", text=f"unknown tool: {call_tool_dto.event_name}"
                    )
                ]

        except Exception as e:
            self._logger.log_error(
                module="CallToolService.__call__",
                message=str(e),
                context={
                    "tool": call_tool_dto.event_name,
                    "payload": self._payload_dict,
                },
            )
            text_contents = [TextContent(type="text", text=f"error: {str(e)}")]

        return CallToolResultDto.from_primitives({"contents": text_contents})

    async def __create_image_text_content(self) -> list[TextContent]:
        # Create DTO from payload
        dto_dict = {
            "prompt": self._payload_dict.get("prompt", ""),
            "image_model": self._payload_dict.get("model", OpenaiImageModelEnum.GPT_IMAGE_1_5),
            "size": self._payload_dict.get("size", OpenaiImageSizeEnum.SIZE_1024),
            "quality": self._payload_dict.get("quality", OpenaiImageQualityEnum.LOW),
            "style": self._payload_dict.get("style"),
            "number_of_images": self._payload_dict.get("n", 1),
        }

        # Generate images
        result = CreateImageOpenaiService.get_instance()(
            CreateImageOpenaiDto.from_primitives(dto_dict)
        )

        # Generate filename
        base_filename = self._payload_dict.get("filename")
        if not base_filename:
            base_filename = self._slugger.slugify_with_timestamp(result.prompt_used)

        # Ensure output directory exists
        Path(self._output_dir).mkdir(parents=True, exist_ok=True)

        # Save images
        saved_files = []
        for idx, img_data in enumerate(result.images):
            b64_data = img_data.get(OpenaiImageResponseFormatEnum.B64_JSON, "")
            if not b64_data:
                continue

            # Add index suffix if multiple images
            if result.number_of_images > 1:
                filename = f"{base_filename}_{idx + 1}.png"
            else:
                filename = f"{base_filename}.png"

            file_path = os.path.join(self._output_dir, filename)

            # Decode and save
            image_bytes = base64.b64decode(b64_data)
            with open(file_path, "wb") as f:
                f.write(image_bytes)

            saved_files.append(file_path)

        if not saved_files:
            return [TextContent(type="text", text="no images were generated")]

        files_list = "\n".join([f"- {f}" for f in saved_files])
        return [
            TextContent(
                type="text",
                text=(
                    f"generated {len(saved_files)} image(s):\n"
                    f"{files_list}\n\n"
                    f"model: {result.model}\n"
                    f"size: {result.size}\n"
                    f"quality: {result.quality}"
                ),
            )
        ]

    async def __create_audio_text_content(self) -> list[TextContent]:
        # Create DTO from payload
        dto_dict = {
            "text": self._payload_dict.get("text", ""),
            "voice": self._payload_dict.get("voice", OpenaiTtsVoiceEnum.ALLOY),
            "tts_model": self._payload_dict.get("model", OpenaiTtsModelEnum.TTS_1),
            "speed": self._payload_dict.get("speed", 1.0),
            "response_format": self._payload_dict.get("response_format", OpenaiTtsFormatEnum.MP3),
        }

        # Generate audio
        result = CreateMp3OpenaiService.get_instance()(
            CreateMp3OpenaiDto.from_primitives(dto_dict)
        )

        # Generate filename
        base_filename = self._payload_dict.get("filename")
        if not base_filename:
            base_filename = self._slugger.slugify_with_timestamp(result.text)

        # Ensure output directory exists
        Path(self._output_dir).mkdir(parents=True, exist_ok=True)

        # Save audio
        filename = f"{base_filename}.{result.format}"
        file_path = os.path.join(self._output_dir, filename)

        # Decode and save
        audio_bytes = base64.b64decode(result.audio_b64)
        with open(file_path, "wb") as f:
            f.write(audio_bytes)

        return [
            TextContent(
                type="text",
                text=(
                    f"generated audio file:\n"
                    f"- {file_path}\n\n"
                    f"model: {result.model}\n"
                    f"voice: {result.voice}\n"
                    f"speed: {result.speed}\n"
                    f"format: {result.format}"
                ),
            )
        ]
