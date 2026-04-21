"""Controller para eliminacion de palabras."""

from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.delete_word import DeleteWordDto, DeleteWordService
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.ui.views.delete_word_view_dto import DeleteWordViewDto


@final
class DeleteWordController:
    """
    Controller para eliminacion de palabras.

    Nota: Este controller es usado internamente por ListWordsController,
    no tiene vista propia.
    """

    _instance: "DeleteWordController | None" = None

    def __init__(self) -> None:
        self._delete_service = DeleteWordService.get_instance()
        self._logger = Logger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def delete(self, word_id: int) -> DeleteWordViewDto:
        """
        Elimina una palabra y retorna el resultado.

        Args:
            word_id: ID de la palabra a eliminar.

        Returns:
            DeleteWordViewDto con el resultado.
        """
        try:
            dto = DeleteWordDto.from_primitives({
                "word_id": word_id,
            })

            result = await self._delete_service(dto)

            return DeleteWordViewDto.ok(
                word_id=result.word_id,
                text=result.text,
                images_deleted=result.images_deleted,
                translations_deleted=result.translations_deleted,
            )

        except VocabularyException as e:
            self._logger.write_error(
                "DeleteWordController",
                f"Error de vocabulario: {e.message}",
                {"word_id": word_id, "code": e.code},
            )
            return DeleteWordViewDto.error(
                message=e.message,
                code=e.code,
            )

        except Exception as e:
            self._logger.write_error(
                "DeleteWordController",
                f"Error inesperado: {e}",
                {"word_id": word_id},
            )
            return DeleteWordViewDto.error(
                message=f"Error inesperado: {e}",
                code=500,
            )
