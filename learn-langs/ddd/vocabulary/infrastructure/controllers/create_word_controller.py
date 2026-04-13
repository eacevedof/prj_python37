"""Controlador para creación de palabras."""

from typing import final, Self

from ddd.vocabulary.application.create_word import CreateWordDto, CreateWordService
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.controllers.create_word_view_dto import CreateWordViewDto


@final
class CreateWordController:
    """Controlador que gestiona la creación de palabras."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(
        self,
        text: str,
        word_type: str,
        tags: list[str],
        translations: dict[str, str],
        image_path: str = "",
        notes: str = "",
    ) -> CreateWordViewDto:
        """
        Crea una palabra y retorna el resultado para la vista.

        Args:
            text: Texto de la palabra en español.
            word_type: Tipo de palabra (WORD, PHRASE, SENTENCE).
            tags: Lista de nombres de tags.
            translations: Diccionario lang_code -> texto traducido.
            image_path: Ruta de imagen opcional.
            notes: Notas opcionales.

        Returns:
            CreateWordViewDto con el resultado (éxito o error).
        """
        try:
            create_word_dto = CreateWordDto.from_primitives({
                "text": text,
                "word_type": word_type,
                "tags": tags,
                "translations": translations,
                "image_path": image_path,
                "notes": notes,
            })

            service = CreateWordService.get_instance()
            result = await service(create_word_dto)

            return CreateWordViewDto.ok(
                word_id=result.id,
                text=result.text,
                word_type=result.word_type,
                tags=result.tags,
                translations=result.translations,
            )

        except VocabularyException as e:
            return CreateWordViewDto.error(
                message=e.message,
                code=e.code,
            )

        except Exception as e:
            return CreateWordViewDto.error(
                message=f"Error inesperado: {e}",
                code=500,
            )
