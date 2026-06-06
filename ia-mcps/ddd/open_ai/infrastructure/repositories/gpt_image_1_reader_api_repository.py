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
        style: str | None = None,
    ) -> list[dict]:
        """
        Generates images using OpenAI Images API.

        Args:
            openai_model: Model to use (dall-e-3, dall-e-2)
            prompt: Image description
            result_number: Number of images to generate (1-10 for dall-e-2, only 1 for dall-e-3)
            size: Size (256x256, 512x512, 1024x1024 for dall-e-2; 1024x1024, 1024x1792, 1792x1024 for dall-e-3)
            quality: Quality (standard, hd) - only for dall-e-3
            style: Style (vivid, natural) - only for dall-e-3

        Returns:
            list[dict]: List of images, each with structure:
            {"b64_json": str, "revised_prompt": str | None}

        Raises:
            OpenAIException: If generation fails
        """
        image_params = {
            "model": openai_model,
            "prompt": prompt,
            "size": size,
            "response_format": "b64_json",
        }

        # Only add n parameter for dall-e-2 (dall-e-3 only supports n=1)
        if openai_model == "dall-e-2":
            image_params["n"] = result_number

        # Only add quality and style for dall-e-3
        if openai_model == "dall-e-3":
            image_params["quality"] = quality
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
