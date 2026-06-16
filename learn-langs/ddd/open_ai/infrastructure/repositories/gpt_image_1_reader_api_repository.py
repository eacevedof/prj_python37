"""Repositorio para generar imágenes con OpenAI Images API (gpt-image-1.5)."""

from typing import final, Self

from ddd.open_ai.domain.enums import (
    OpenaiImageModelEnum,
    OpenaiImageResponseFormatEnum,
)
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class GptImage1ReaderApiRepository(AbstractOpenAIApiRepository):
    """Repositorio para generación de imágenes usando gpt-image-1.5."""

    _instance: "GptImage1ReaderApiRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        """Retorna la instancia singleton."""
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_base64_images_from_text(
        self,
        openai_model: str,
        prompt: str,
        result_number: int,
        size: str,
        quality: str,
    ) -> list[dict]:
        """Generates images using OpenAI Images API. Input is validated upstream."""
        image_params = {
            "model": openai_model,
            "prompt": prompt,
            "n": result_number,
            "size": size,
        }

        if openai_model == OpenaiImageModelEnum.DALL_E_3.value:
            image_params["quality"] = quality

        image_response = self._open_ai_client.images.generate(**image_params)

        if not image_response.data:
            OpenAIException.unexpected_custom(
                "GptImage1ReaderApiRepository: No image data received from OpenAI API"
            )

        return [
            {
                OpenaiImageResponseFormatEnum.B64_JSON: img_data.b64_json or "",
                "revised_prompt": img_data.revised_prompt if hasattr(img_data, "revised_prompt") else None,
            }
            for img_data in image_response.data
        ]
