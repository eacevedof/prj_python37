"""Controlador para listado de palabras."""

from typing import final, Self

from ddd.vocabulary.application.list_words import ListWordsDto, ListWordsService
from ddd.vocabulary.infrastructure.controllers.list_words_view_dto import (
    ListWordsViewDto,
    WordListItemViewDto,
)


@final
class ListWordsController:
    """Controlador que gestiona el listado de palabras."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def list_words(
        self,
        search: str = "",
        word_type: str | None = None,
        tags: list[str] | None = None,
        limit: int = 100,
        offset: int = 0,
    ) -> ListWordsViewDto:
        """
        Lista palabras con filtros opcionales.

        Args:
            search: Texto de busqueda.
            word_type: Filtrar por tipo (WORD, PHRASE, SENTENCE).
            tags: Filtrar por tags.
            limit: Maximo de resultados.
            offset: Desplazamiento para paginacion.

        Returns:
            ListWordsViewDto con las palabras encontradas.
        """
        try:
            dto = ListWordsDto.from_primitives({
                "search": search,
                "word_type": word_type,
                "tags": tags or [],
                "limit": limit,
                "offset": offset,
            })

            service = ListWordsService.get_instance()
            result = await service(dto)

            # Convertir a DTOs de vista
            words_view = [
                WordListItemViewDto.from_primitives({
                    "id": w.id,
                    "text": w.text,
                    "word_type": w.word_type,
                    "notes": w.notes,
                    "created_at": w.created_at,
                    "image_count": w.image_count,
                    "tags": w.tags,
                    "translations": w.translations,
                })
                for w in result.words
            ]

            return ListWordsViewDto.ok(
                words=words_view,
                total_count=result.total_count,
                has_more=result.has_more,
            )

        except Exception as e:
            return ListWordsViewDto.error(
                message=f"Error al listar palabras: {e}",
            )
