from typing import Self, final

from src.modules.shared.infrastructure.components.slugger.slugger import Slugger

from src.modules.media_mod.infrastructure.repositories.media_file_writer_repository import (
    MediaFileWriterRepository,
)
from src.modules.media_mod.application.create_mp3_openai.create_mp3_openai_dto import (
    CreateMp3OpenaiDto,
)
from src.modules.media_mod.application.create_mp3_openai.create_mp3_openai_service import (
    CreateMp3OpenaiService,
)
from src.modules.media_mod.application.generate_audio.generate_audio_dto import GenerateAudioDto
from src.modules.media_mod.application.generate_audio.generate_audio_result_dto import (
    GenerateAudioResultDto,
)


@final
class GenerateAudioService:
    """Caso de uso: pedir el audio TTS a OpenAI y dejarlo escrito en disco.

    Mismo reparto que en imágenes: `CreateMp3Openai` habla con OpenAI y devuelve
    base64; aquí se nombra el fichero y se escribe.
    """

    _slugger: Slugger
    _create_mp3_openai_service: CreateMp3OpenaiService
    _media_file_writer_repository: MediaFileWriterRepository

    def __init__(self) -> None:
        self._slugger = Slugger.get_instance()
        self._create_mp3_openai_service = CreateMp3OpenaiService.get_instance()
        self._media_file_writer_repository = MediaFileWriterRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, generate_audio_dto: GenerateAudioDto) -> GenerateAudioResultDto:
        """
        Returns:
            GenerateAudioResultDto: ruta escrita y parámetros usados.

        Raises:
            OpenAIException: si el texto o los parámetros no valen, o si no hay
                carpeta de salida configurada.
        """
        create_mp3_openai_result_dto = self._create_mp3_openai_service(
            CreateMp3OpenaiDto.from_primitives({
                "text": generate_audio_dto.text,
                "voice": generate_audio_dto.voice,
                "tts_model": generate_audio_dto.tts_model,
                "speed": generate_audio_dto.speed,
                "response_format": generate_audio_dto.response_format,
            })
        )

        base_file_name = generate_audio_dto.file_name or self._slugger.slugify_with_timestamp(
            create_mp3_openai_result_dto.text
        )
        file_path = self._media_file_writer_repository.get_written_file_path(
            f"{base_file_name}.{create_mp3_openai_result_dto.format}",
            create_mp3_openai_result_dto.audio_b64,
        )

        return GenerateAudioResultDto.from_primitives({
            "files": [file_path],
            "model": create_mp3_openai_result_dto.model,
            "voice": create_mp3_openai_result_dto.voice,
            "speed": create_mp3_openai_result_dto.speed,
            "format": create_mp3_openai_result_dto.format,
        })
