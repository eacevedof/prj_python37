"""Service for creating images with OpenAI Images API."""

from typing import Self, final

from ddd.open_ai.domain.enums import (
    OpenaiImageNumberEnum,
    OpenaiImageModelEnum,
    OpenaiImageQualityEnum,
    OpenaiImageResponseFormatEnum,
    OpenaiImageSizeEnum,
)
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.gpt_image_1_reader_api_repository import GptImage1ReaderApiRepository
from ddd.open_ai.application.create_image_openai.create_image_openai_dto import CreateImageOpenaiDto
from ddd.open_ai.application.create_image_openai.create_image_openai_result_dto import CreateImageOpenaiResultDto


@final
class CreateImageOpenaiService:
    """Use case to generate images with OpenAI Images API."""

    _create_image_openai_dto: CreateImageOpenaiDto
    _gpt_image_1_reader_api_repository: GptImage1ReaderApiRepository

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __init__(self) -> None:
        self._gpt_image_1_reader_api_repository = GptImage1ReaderApiRepository.get_instance()

    def __call__(
        self,
        create_image_openai_dto: CreateImageOpenaiDto,
    ) -> CreateImageOpenaiResultDto:
        self._create_image_openai_dto = create_image_openai_dto

        self._fail_if_wrong_input()

        base64_images = self._get_valid_base64_images()
        if not base64_images:
            OpenAIException.unexpected_custom(
                "Failed to generate images: No valid base64 image strings returned from OpenAI API"
            )

        return CreateImageOpenaiResultDto.from_primitives({
            "images": base64_images,
            "prompt_used": self._create_image_openai_dto.prompt.strip(),
            "model": self._create_image_openai_dto.openai_model,
            "size": self._create_image_openai_dto.size,
            "quality": self._create_image_openai_dto.quality,
            "number_of_images": self._create_image_openai_dto.number_of_images,
        })

    def _fail_if_wrong_input(self) -> None:
        if not self._create_image_openai_dto.prompt.strip():
            OpenAIException.bad_request("prompt cannot be empty")

        min_images = OpenaiImageNumberEnum.MIN_NUMBER_OF_IMAGES.value
        max_images = OpenaiImageNumberEnum.MAX_NUMBER_OF_IMAGES.value
        if not min_images <= self._create_image_openai_dto.number_of_images <= max_images:
            OpenAIException.bad_request(
                f"number_of_images must be between {min_images} and {max_images}"
            )

        valid_models = list(OpenaiImageModelEnum)
        if self._create_image_openai_dto.openai_model not in valid_models:
            OpenAIException.bad_request(
                f"Invalid image_model: {self._create_image_openai_dto.openai_model}. "
                f"Allowed values: {', '.join(valid_models)}"
            )

        valid_sizes = list(OpenaiImageSizeEnum)
        if self._create_image_openai_dto.size not in valid_sizes:
            OpenAIException.bad_request(
                f"Invalid size: {self._create_image_openai_dto.size}. "
                f"Allowed values: {', '.join(valid_sizes)}"
            )

        valid_qualities = list(OpenaiImageQualityEnum)
        if self._create_image_openai_dto.quality not in valid_qualities:
            OpenAIException.bad_request(
                f"Invalid quality: {self._create_image_openai_dto.quality}. "
                f"Allowed values: {', '.join(valid_qualities)}"
            )

        if self._create_image_openai_dto.openai_model == OpenaiImageModelEnum.DALL_E_3 and \
           self._create_image_openai_dto.size in [OpenaiImageSizeEnum.SIZE_256, OpenaiImageSizeEnum.SIZE_512]:
            OpenAIException.bad_request("dall-e-3 does not support 256x256 or 512x512 sizes")

        if self._create_image_openai_dto.openai_model == OpenaiImageModelEnum.DALL_E_2 and \
           self._create_image_openai_dto.size in [
               OpenaiImageSizeEnum.SIZE_1024_1792,
               OpenaiImageSizeEnum.SIZE_1792_1024,
           ]:
            OpenAIException.bad_request(
                f"{self._create_image_openai_dto.openai_model} does not support 1024x1792 or 1792x1024 sizes"
            )

    def _get_valid_base64_images(self) -> list[dict]:
        base64_images = self._gpt_image_1_reader_api_repository.get_base64_images_from_text(
            openai_model=self._create_image_openai_dto.openai_model,
            prompt=self._create_image_openai_dto.prompt.strip(),
            result_number=self._create_image_openai_dto.number_of_images,
            size=self._create_image_openai_dto.size,
            quality=self._create_image_openai_dto.quality,
        )

        return [
            image
            for image in base64_images
            if image.get(OpenaiImageResponseFormatEnum.B64_JSON, "")
        ]
