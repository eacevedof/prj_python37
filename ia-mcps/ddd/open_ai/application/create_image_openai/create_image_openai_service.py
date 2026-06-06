"""Service for creating images with OpenAI Images API."""

from typing import Self, final

from ddd.open_ai.application.create_image_openai.create_image_openai_dto import CreateImageOpenaiDto
from ddd.open_ai.application.create_image_openai.create_image_openai_result_dto import CreateImageOpenaiResultDto
from ddd.open_ai.domain.enums import (
    OpenaiImageModelEnum,
    OpenaiImageQualityEnum,
    OpenaiImageResponseFormatEnum,
    OpenaiImageSizeEnum,
)
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.gpt_image_1_reader_api_repository import GptImage1ReaderApiRepository


@final
class CreateImageOpenaiService:
    """Use case to generate images with OpenAI Images API."""

    MIN_NUMBER_OF_IMAGES: int = 1
    MAX_NUMBER_OF_IMAGES: int = 10

    _create_image_openai_dto: CreateImageOpenaiDto
    _gpt_image1_reader_api_repository: GptImage1ReaderApiRepository

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __init__(self) -> None:
        self._gpt_image1_reader_api_repository = GptImage1ReaderApiRepository.get_instance()

    def __call__(
        self,
        create_image_openai_dto: CreateImageOpenaiDto
    ) -> CreateImageOpenaiResultDto:
        """
        Generates images with OpenAI according to DTO parameters.

        Returns:
            CreateImageOpenaiResultDto: Result DTO with generated images

        Raises:
            OpenAIException: If parameter validation or generation fails
        """
        self._create_image_openai_dto = create_image_openai_dto

        self._fail_if_wrong_input()

        openai_images = self._gpt_image1_reader_api_repository.get_base64_images_from_text(
            openai_model=self._create_image_openai_dto.openai_model,
            prompt=self._create_image_openai_dto.prompt.strip(),
            result_number=self._create_image_openai_dto.number_of_images,
            size=self._create_image_openai_dto.size,
            quality=self._create_image_openai_dto.quality,
        )

        base64_img_strings = self._get_valid_base64_strings(openai_images)
        if not base64_img_strings:
            OpenAIException.unexpected_custom(
                "Failed to generate images: No valid base64 image strings returned from OpenAI API"
            )

        return CreateImageOpenaiResultDto.from_primitives({
            "images": base64_img_strings,
            "prompt_used": self._create_image_openai_dto.prompt.strip(),
            "model": self._create_image_openai_dto.openai_model,
            "size": self._create_image_openai_dto.size,
            "quality": self._create_image_openai_dto.quality,
            "number_of_images": self._create_image_openai_dto.number_of_images,
        })


    def _fail_if_wrong_input(self) -> None:
        if self._create_image_openai_dto.number_of_images < self.MIN_NUMBER_OF_IMAGES or \
           self._create_image_openai_dto.number_of_images > self.MAX_NUMBER_OF_IMAGES:
            OpenAIException.unexpected_custom(
                f"number_of_images must be between {self.MIN_NUMBER_OF_IMAGES} and {self.MAX_NUMBER_OF_IMAGES}"
            )

        valid_models = list(OpenaiImageModelEnum)
        if self._create_image_openai_dto.openai_model not in valid_models:
            OpenAIException.unexpected_custom(
                f"Invalid image_model: {self._create_image_openai_dto.openai_model}. "
                f"Allowed values: {", ".join(valid_models)}"
            )

        valid_sizes = list(OpenaiImageSizeEnum)
        if self._create_image_openai_dto.size not in valid_sizes:
            OpenAIException.unexpected_custom(
                f"Invalid size: {self._create_image_openai_dto.size}. Allowed values: {", ".join(valid_sizes)}"
            )

        valid_qualities = list(OpenaiImageQualityEnum)
        if self._create_image_openai_dto.quality not in valid_qualities:
            OpenAIException.unexpected_custom(
                f"Invalid quality: {self._create_image_openai_dto.quality}. "
                f"Allowed values: {", ".join(valid_qualities)}"
            )

        if self._create_image_openai_dto.openai_model == OpenaiImageModelEnum.DALL_E_3 and \
           self._create_image_openai_dto.size in [OpenaiImageSizeEnum.SIZE_256, OpenaiImageSizeEnum.SIZE_512]:
            OpenAIException.unexpected_custom("dall-e-3 does not support 256x256 or 512x512 sizes")

        if self._create_image_openai_dto.openai_model == OpenaiImageModelEnum.DALL_E_2 and \
           self._create_image_openai_dto.size in [
            OpenaiImageSizeEnum.SIZE_1024_1792,
            OpenaiImageSizeEnum.SIZE_1792_1024
        ]:
            OpenAIException.unexpected_custom(
                f"{self._create_image_openai_dto.openai_model} does not support 1024x1792 or 1792x1024 sizes"
            )

    def _get_valid_base64_strings(self, base64_images: list[dict]) -> list[dict]:
        images = []
        for img_data in base64_images:
            image_b64 = img_data.get(OpenaiImageResponseFormatEnum.B64_JSON, "")
            if not image_b64:
                continue
            images.append(img_data)
        return images
