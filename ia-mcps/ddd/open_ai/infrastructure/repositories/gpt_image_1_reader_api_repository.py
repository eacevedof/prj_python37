"""Repositorio para generar imágenes con OpenAI Images API."""

from typing import Self, final

from ddd.open_ai.domain.enums import OpenaiImageResponseFormatEnum
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class GptImage1ReaderApiRepository(AbstractOpenAIApiRepository):
    """Repositorio para generación de imágenes usando OpenAI Images API."""

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
        response_format: str,
        style: str | None = None,
    ) -> list[dict]:
        """
        Genera imágenes usando OpenAI Images API.

        Args:
            openai_model: Modelo a usar (gpt-image-1.5, dall-e-3, dall-e-2)
            prompt: Descripción de la imagen
            result_number: Número de imágenes a generar
            size: Tamaño (256x256, 512x512, 1024x1024, etc.)
            quality: Calidad (low, high)
            response_format: Formato de respuesta (b64_json, url)
            style: Estilo (vivid, natural) - opcional

        Returns:
            list[dict]: Lista de imágenes, cada una con estructura:
            {"b64_json": str, "revised_prompt": str | None}

        Raises:
            OpenAIException: Si falla la generación
        """
        api_params = {
            "model": openai_model,
            "prompt": prompt,
            "n": result_number,
            "size": size,
            "quality": quality,
            "response_format": response_format,
        }

        if style:
            api_params["style"] = style

        image_response = self._open_ai_client.images.generate(**api_params)

        if not image_response.data:
            raise OpenAIException.unexpected_custom(
                "GptImage1ReaderApiRepository: No image data received from OpenAI API"
            )

        return [
            {
                OpenaiImageResponseFormatEnum.B64_JSON.value: img_data.b64_json or "",
                "revised_prompt": img_data.revised_prompt if hasattr(img_data, "revised_prompt") else None,
            }
            for img_data in image_response.data
        ]
