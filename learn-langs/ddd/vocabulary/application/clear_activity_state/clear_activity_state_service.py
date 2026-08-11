"""Servicio para borrar el estado de una actividad (sesión completada)."""

from typing import final, Self

from ddd.vocabulary.application.clear_activity_state.clear_activity_state_dto import (
    ClearActivityStateDto,
)
from ddd.vocabulary.application.clear_activity_state.clear_activity_state_result_dto import (
    ClearActivityStateResultDto,
)
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.repositories import (
    ActivityStatesWriterSqliteRepository,
)


@final
class ClearActivityStateService:
    """Borra el estado guardado de una actividad (ya no hay nada que retomar)."""

    _activity_states_writer_sqlite_repository: ActivityStatesWriterSqliteRepository

    def __init__(self) -> None:
        self._activity_states_writer_sqlite_repository = (
            ActivityStatesWriterSqliteRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, clear_activity_state_dto: ClearActivityStateDto
    ) -> ClearActivityStateResultDto:
        """
        Borra el estado de la actividad.

        Raises:
            VocabularyException: Si el DTO no es válido.
        """
        errors = clear_activity_state_dto.validate()
        if errors:
            VocabularyException.bad_request_custom(", ".join(errors))

        # Soft-clear: no borramos la fila, solo la marcamos no-retomable (posición a 0)
        # conservando group_id/lang/tags → el Home recuerda el último grupo practicado.
        cleared_rows = await self._activity_states_writer_sqlite_repository.soft_clear_activity_state(
            activity=clear_activity_state_dto.activity,
        )

        return ClearActivityStateResultDto.from_primitives({
            "activity": clear_activity_state_dto.activity,
            "is_cleared": cleared_rows > 0,
        })
