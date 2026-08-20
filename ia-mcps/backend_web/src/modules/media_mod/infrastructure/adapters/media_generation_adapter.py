import asyncio
from typing import Any, Self, final

from src.modules.media_mod.application.generate_audio.generate_audio_dto import GenerateAudioDto
from src.modules.media_mod.application.generate_audio.generate_audio_service import (
    GenerateAudioService,
)
from src.modules.media_mod.application.generate_image.generate_image_dto import GenerateImageDto
from src.modules.media_mod.application.generate_image.generate_image_service import (
    GenerateImageService,
)


@final
class MediaGenerationAdapter:
    """Implementación del puerto `MediaGeneration` (media_mcp/domain).

    Única puerta de este módulo hacia la fachada MCP: primitivos dentro,
    primitivos fuera.

    Los casos de uso son SÍNCRONOS (el cliente de OpenAI lo es) y generar una
    imagen tarda segundos: se ejecutan con `asyncio.to_thread` para no bloquear
    el bucle de eventos de uvicorn mientras tanto — el resto de peticiones al
    servidor MCP seguirían muertas si no.
    """

    _generate_image_service: GenerateImageService
    _generate_audio_service: GenerateAudioService

    def __init__(self) -> None:
        self._generate_image_service = GenerateImageService.get_instance()
        self._generate_audio_service = GenerateAudioService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def generate_image(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await asyncio.to_thread(
            self._generate_image_service, GenerateImageDto.from_primitives(primitives)
        )
        return result_dto.to_dict()

    async def generate_audio(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await asyncio.to_thread(
            self._generate_audio_service, GenerateAudioDto.from_primitives(primitives)
        )
        return result_dto.to_dict()
