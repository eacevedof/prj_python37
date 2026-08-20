from typing import Self, final

from src.modules.shared.infrastructure.components.slugger.slugger import Slugger

from src.modules.media_mod.domain.enums import OpenaiImageResponseFormatEnum
from src.modules.media_mod.domain.exceptions.open_ai_exception import OpenAIException
from src.modules.media_mod.infrastructure.repositories.media_file_writer_repository import (
    MediaFileWriterRepository,
)
from src.modules.media_mod.application.create_image_openai.create_image_openai_dto import (
    CreateImageOpenaiDto,
)
from src.modules.media_mod.application.create_image_openai.create_image_openai_service import (
    CreateImageOpenaiService,
)
from src.modules.media_mod.application.generate_image.generate_image_dto import GenerateImageDto
from src.modules.media_mod.application.generate_image.generate_image_result_dto import (
    GenerateImageResultDto,
)

_IMAGE_EXTENSION = "png"


@final
class GenerateImageService:
    """Caso de uso: pedir las imágenes a OpenAI y dejarlas escritas en disco.

    Es el caso de uso COMPLETO que consume la fachada MCP. `CreateImageOpenai`
    sigue siendo el paso que habla con OpenAI (devuelve base64); aquí se le
    añade el nombre de fichero y la escritura, que antes estaban sueltos dentro
    del servidor MCP.
    """

    _slugger: Slugger
    _create_image_openai_service: CreateImageOpenaiService
    _media_file_writer_repository: MediaFileWriterRepository

    def __init__(self) -> None:
        self._slugger = Slugger.get_instance()
        self._create_image_openai_service = CreateImageOpenaiService.get_instance()
        self._media_file_writer_repository = MediaFileWriterRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, generate_image_dto: GenerateImageDto) -> GenerateImageResultDto:
        """
        Returns:
            GenerateImageResultDto: rutas escritas y parámetros usados.

        Raises:
            OpenAIException: si los parámetros no valen, si OpenAI no devuelve
                imágenes o si no hay carpeta de salida configurada.
        """
        create_image_openai_result_dto = self._create_image_openai_service(
            CreateImageOpenaiDto.from_primitives({
                "prompt": generate_image_dto.prompt,
                "image_model": generate_image_dto.image_model,
                "size": generate_image_dto.size,
                "quality": generate_image_dto.quality,
                "number_of_images": generate_image_dto.number_of_images,
            })
        )

        base_file_name = generate_image_dto.file_name or self._slugger.slugify_with_timestamp(
            create_image_openai_result_dto.prompt_used
        )

        file_paths: list[str] = []
        for image_index, image_dict in enumerate(create_image_openai_result_dto.images):
            content_b64 = image_dict.get(OpenaiImageResponseFormatEnum.B64_JSON, "")
            if not content_b64:
                continue
            # El sufijo solo aparece cuando hay más de una: con una sola imagen
            # el nombre pedido se respeta tal cual.
            file_name = f"{base_file_name}.{_IMAGE_EXTENSION}"
            if create_image_openai_result_dto.number_of_images > 1:
                file_name = f"{base_file_name}_{image_index + 1}.{_IMAGE_EXTENSION}"
            file_paths.append(
                self._media_file_writer_repository.get_written_file_path(file_name, content_b64)
            )

        if not file_paths:
            OpenAIException.unexpected_custom("no images were generated")

        return GenerateImageResultDto.from_primitives({
            "files": file_paths,
            "model": create_image_openai_result_dto.model,
            "size": create_image_openai_result_dto.size,
            "quality": create_image_openai_result_dto.quality,
        })
