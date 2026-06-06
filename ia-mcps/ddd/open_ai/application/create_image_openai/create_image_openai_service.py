"""Servicio para crear imágenes con OpenAI Images API."""

from typing import Self, final

from ddd.open_ai.application.create_image_openai.create_image_openai_dto import CreateImageOpenaiDto
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class CreateImageOpenaiService(AbstractOpenAIApiRepository):
    """Caso de uso para generar imágenes con OpenAI Images API."""

    _create_image_openai_dto: CreateImageOpenaiDto

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, create_image_openai_dto: CreateImageOpenaiDto) -> dict:
        """
        Genera imágenes con OpenAI según parámetros del DTO.

        Returns:
            dict con estructura:
            {
                "images": [{"b64_json": str, "revised_prompt": str | None}, ...],
                "prompt_used": str,
                "model": str,
                "size": str,
                "quality": str,
                "n": int,
            }

        Raises:
            OpenAIException: Si falla la generación o validación
        """
        self._create_image_openai_dto = create_image_openai_dto

        try:
            api_params = self._get_api_params()
            response = self._open_ai_client.images.generate(**api_params)

            if not response.data:
                raise OpenAIException.unexpected_custom(
                    "CreateImageOpenaiService: No se recibieron imágenes en la respuesta"
                )

            images = self._get_processed_images(response.data)

            return {
                "images": images,
                "prompt_used": self._create_image_openai_dto.prompt.strip(),
                "model": self._create_image_openai_dto.model,
                "size": self._create_image_openai_dto.size,
                "quality": self._create_image_openai_dto.quality,
                "n": self._create_image_openai_dto.n,
            }

        except OpenAIException:
            raise
        except Exception as e:
            raise OpenAIException.unexpected_custom(
                f"CreateImageOpenaiService: Error al generar imagen(es): {str(e)}"
            )

    def _get_api_params(self) -> dict:
        api_params = {
            "model": self._create_image_openai_dto.model,
            "prompt": self._create_image_openai_dto.prompt.strip(),
            "n": self._create_image_openai_dto.n,
            "size": self._create_image_openai_dto.size,
            "quality": self._create_image_openai_dto.quality,
            "response_format": "b64_json",
        }

        if self._create_image_openai_dto.model == "dall-e-3" and self._create_image_openai_dto.style:
            api_params["style"] = self._create_image_openai_dto.style

        return api_params

    def _get_processed_images(self, images_data: list) -> list[dict]:
        images = []
        for img_data in images_data:
            image_b64 = img_data.b64_json or ""
            if not image_b64:
                raise OpenAIException.unexpected_custom(
                    "CreateImageOpenaiService: Una de las imágenes no contiene b64_json"
                )

            image_dict = {
                "b64_json": image_b64,
                "revised_prompt": img_data.revised_prompt if hasattr(img_data, "revised_prompt") else None,
            }
            images.append(image_dict)

        return images
