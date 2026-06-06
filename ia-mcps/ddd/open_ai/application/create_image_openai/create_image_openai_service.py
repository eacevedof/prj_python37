"""Servicio para crear imágenes con OpenAI Images API."""

from typing import Self, final

from ddd.open_ai.application.create_image_openai.create_image_openai_dto import CreateImageOpenaiDto
from ddd.open_ai.application.create_image_openai.created_image_openai_dto import (
    CreatedImageOpenaiDto,
    ImageDataDto,
)
from ddd.open_ai.domain.enums import (
    OpenaiImageModelEnum,
    OpenaiImageQualityEnum,
    OpenaiImageSizeEnum,
    OpenaiImageStyleEnum,
)
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class CreateImageOpenaiService(AbstractOpenAIApiRepository):
    """Use case to generate images with OpenAI Images API."""

    MIN_NUMBER_OF_IMAGES: int = 1
    MAX_NUMBER_OF_IMAGES: int = 10

    _create_image_openai_dto: CreateImageOpenaiDto

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, create_image_openai_dto: CreateImageOpenaiDto) -> CreatedImageOpenaiDto:
        """
        Generates images with OpenAI according to DTO parameters.

        Returns:
            CreatedImageOpenaiDto: Result DTO with generated images

        Raises:
            OpenAIException: If parameter validation or generation fails
        """
        self._create_image_openai_dto = create_image_openai_dto
        self._fail_if_wrong_input()

        api_params = self._get_api_params()
        response = self._open_ai_client.images.generate(**api_params)

        if not response.data:
            raise OpenAIException.unexpected_custom("No image data received from OpenAI API")

        images = self._get_processed_images(response.data)

        return CreatedImageOpenaiDto(
            images=images,
            prompt_used=self._create_image_openai_dto.prompt.strip(),
            model=self._create_image_openai_dto.image_model,
            size=self._create_image_openai_dto.size,
            quality=self._create_image_openai_dto.quality,
            number_of_images=self._create_image_openai_dto.number_of_images,
        )

    def _fail_if_wrong_input(self) -> None:
        if self._create_image_openai_dto.number_of_images < self.MIN_NUMBER_OF_IMAGES or \
           self._create_image_openai_dto.number_of_images > self.MAX_NUMBER_OF_IMAGES:
            raise OpenAIException.unexpected_custom(
                f"number_of_images must be between {self.MIN_NUMBER_OF_IMAGES} and {self.MAX_NUMBER_OF_IMAGES}"
            )

        valid_models = [e.value for e in OpenaiImageModelEnum]
        if self._create_image_openai_dto.image_model not in valid_models:
            raise OpenAIException.unexpected_custom(
                f"Invalid image_model: {self._create_image_openai_dto.image_model}. "
                f"Allowed values: {', '.join(valid_models)}"
            )

        valid_sizes = [e.value for e in OpenaiImageSizeEnum]
        if self._create_image_openai_dto.size not in valid_sizes:
            raise OpenAIException.unexpected_custom(
                f"Invalid size: {self._create_image_openai_dto.size}. Allowed values: {', '.join(valid_sizes)}"
            )

        valid_qualities = [e.value for e in OpenaiImageQualityEnum]
        if self._create_image_openai_dto.quality not in valid_qualities:
            raise OpenAIException.unexpected_custom(
                f"Invalid quality: {self._create_image_openai_dto.quality}. "
                f"Allowed values: {', '.join(valid_qualities)}"
            )

        if self._create_image_openai_dto.style is not None:
            valid_styles = [e.value for e in OpenaiImageStyleEnum]
            if self._create_image_openai_dto.style not in valid_styles:
                raise OpenAIException.unexpected_custom(
                    f"Invalid style: {self._create_image_openai_dto.style}. "
                    f"Allowed values: {', '.join(valid_styles)}"
                )

        if self._create_image_openai_dto.image_model == OpenaiImageModelEnum.DALL_E_3.value and \
           self._create_image_openai_dto.size in [OpenaiImageSizeEnum.SIZE_256.value, OpenaiImageSizeEnum.SIZE_512.value]:
            raise OpenAIException.unexpected_custom("dall-e-3 does not support 256x256 or 512x512 sizes")

        if self._create_image_openai_dto.image_model in [
            OpenaiImageModelEnum.DALL_E_2.value,
            OpenaiImageModelEnum.GPT_IMAGE_1_5.value
        ] and self._create_image_openai_dto.size in [
            OpenaiImageSizeEnum.SIZE_1024_1792.value,
            OpenaiImageSizeEnum.SIZE_1792_1024.value
        ]:
            raise OpenAIException.unexpected_custom(
                f"{self._create_image_openai_dto.image_model} does not support 1024x1792 or 1792x1024 sizes"
            )

    def _get_api_params(self) -> dict:
        api_params = {
            "model": self._create_image_openai_dto.image_model,
            "prompt": self._create_image_openai_dto.prompt.strip(),
            "n": self._create_image_openai_dto.number_of_images,
            "size": self._create_image_openai_dto.size,
            "quality": self._create_image_openai_dto.quality,
            "response_format": "b64_json",
        }

        if self._create_image_openai_dto.style:
            api_params["style"] = self._create_image_openai_dto.style

        return api_params

    def _get_processed_images(self, images_data: list) -> list[ImageDataDto]:
        images = []
        for img_data in images_data:
            image_b64 = img_data.b64_json or ""
            if not image_b64:
                raise OpenAIException.unexpected_custom("Image data does not contain b64_json")

            image_dto = ImageDataDto(
                b64_json=image_b64,
                revised_prompt=img_data.revised_prompt if hasattr(img_data, "revised_prompt") else None,
            )
            images.append(image_dto)

        return images
