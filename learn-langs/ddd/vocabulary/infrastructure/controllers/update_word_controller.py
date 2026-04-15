"""Controlador para actualizacion de palabras."""

from typing import final, Self

from ddd.vocabulary.application.update_word import UpdateWordDto, UpdateWordService
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.controllers.update_word_view_dto import UpdateWordViewDto


@final
class UpdateWordController:
    """Controlador que gestiona la actualizacion de palabras."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def update(
        self,
        word_id: int,
        text: str,
        word_type: str,
        tags: list[str],
        translations: dict[str, str],
        notes: str = "",
    ) -> UpdateWordViewDto:
        """
        Actualiza una palabra y retorna el resultado para la vista.

        Args:
            word_id: ID de la palabra a actualizar.
            text: Texto de la palabra en espanol.
            word_type: Tipo de palabra (WORD, PHRASE, SENTENCE).
            tags: Lista de nombres de tags.
            translations: Diccionario lang_code -> texto traducido.
            notes: Notas opcionales.

        Returns:
            UpdateWordViewDto con el resultado (exito o error).
        """
        try:
            update_word_dto = UpdateWordDto.from_primitives({
                "word_id": word_id,
                "text": text,
                "word_type": word_type,
                "tags": tags,
                "translations": translations,
                "notes": notes,
            })

            service = UpdateWordService.get_instance()
            result = await service(update_word_dto)

            return UpdateWordViewDto.ok(
                word_id=result.id,
                text=result.text,
                word_type=result.word_type,
                notes=result.notes,
                tags=result.tags,
                translations=result.translations,
            )

        except VocabularyException as e:
            return UpdateWordViewDto.error(
                message=e.message,
                code=e.code,
            )

        except Exception as e:
            return UpdateWordViewDto.error(
                message=f"Error inesperado: {e}",
                code=500,
            )
