"""Controlador para eliminacion de palabras."""

from typing import final, Self

from ddd.vocabulary.application.delete_word import DeleteWordDto, DeleteWordService
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.controllers.delete_word_view_dto import DeleteWordViewDto


@final
class DeleteWordController:
    """Controlador que gestiona la eliminacion de palabras."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def delete(self, word_id: int) -> DeleteWordViewDto:
        """
        Elimina una palabra y retorna el resultado para la vista.

        Args:
            word_id: ID de la palabra a eliminar.

        Returns:
            DeleteWordViewDto con el resultado (exito o error).
        """
        try:
            dto = DeleteWordDto.from_primitives({
                "word_id": word_id,
            })

            service = DeleteWordService.get_instance()
            result = await service(dto)

            return DeleteWordViewDto.ok(
                word_id=result.word_id,
                text=result.text,
                images_deleted=result.images_deleted,
                translations_deleted=result.translations_deleted,
            )

        except VocabularyException as e:
            return DeleteWordViewDto.error(
                message=e.message,
                code=e.code,
            )

        except Exception as e:
            return DeleteWordViewDto.error(
                message=f"Error inesperado: {e}",
                code=500,
            )
