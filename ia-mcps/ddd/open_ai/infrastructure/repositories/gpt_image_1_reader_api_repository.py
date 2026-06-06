"""Repository for generating images with OpenAI Images API."""

from typing import Self, final

from ddd.open_ai.domain.enums import OpenaiImageResponseFormatEnum
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class GptImage1ReaderApiRepository(AbstractOpenAIApiRepository):
    """Repository for image generation using OpenAI Images API."""

    _instance: "GptImage1ReaderApiRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        """Returns the singleton instance."""
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
        response_format: str,
        style: str | None = None,
    ) -> list[dict]:
        """
        Generates images using OpenAI Images API.

        Args:
            openai_model: Model to use (gpt-image-1.5, dall-e-3, dall-e-2)
            prompt: Image description
            result_number: Number of images to generate
            size: Size (256x256, 512x512, 1024x1024, etc.)
            quality: Quality (low, high)
            response_format: Response format (b64_json, url)
            style: Style (vivid, natural) - optional

        Returns:
            list[dict]: List of images, each with structure:
            {"b64_json": str, "revised_prompt": str | None}

        Raises:
            OpenAIException: If generation fails
        """
        image_params = {
            "model": openai_model,
            "prompt": prompt,
            "n": result_number,
            "size": size,
            "quality": quality,
            "response_format": response_format,
        }

        if style:
            image_params["style"] = style

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
