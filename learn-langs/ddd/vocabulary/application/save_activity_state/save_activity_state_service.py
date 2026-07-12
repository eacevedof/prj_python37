"""Servicio para guardar el estado de una actividad (retomar sesión)."""

from typing import final, Self

from ddd.vocabulary.application.save_activity_state.save_activity_state_dto import (
    SaveActivityStateDto,
)
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.repositories import (
    ActivityStatesWriterSqliteRepository,
)


@final
class SaveActivityStateService:
    """Guarda (upsert) lo último que se estaba haciendo en una actividad."""

    _activity_states_writer_sqlite_repository: ActivityStatesWriterSqliteRepository

    def __init__(self) -> None:
        self._activity_states_writer_sqlite_repository = (
            ActivityStatesWriterSqliteRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, save_activity_state_dto: SaveActivityStateDto) -> None:
        """
        Guarda el estado de la actividad (una fila por actividad).

        Raises:
            VocabularyException: Si el DTO no es válido.
        """
        errors = save_activity_state_dto.validate()
        if errors:
            VocabularyException.bad_request_custom(", ".join(errors))

        await self._activity_states_writer_sqlite_repository.upsert_activity_state(
            activity=save_activity_state_dto.activity,
            lang_code=save_activity_state_dto.lang_code,
            tags=save_activity_state_dto.tags,
            group_id=save_activity_state_dto.group_id,
            word_es_id=save_activity_state_dto.word_es_id,
            word_index=save_activity_state_dto.word_index,
            total_words=save_activity_state_dto.total_words,
            is_random_order=save_activity_state_dto.is_random_order,
        )
