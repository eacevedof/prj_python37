"""Servicio para obtener el último estado de actividad guardado."""

from typing import final, Self

from ddd.vocabulary.application.get_last_activity_state.get_last_activity_state_result_dto import (
    GetLastActivityStateResultDto,
)
from ddd.vocabulary.infrastructure.repositories import (
    ActivityStatesReaderSqliteRepository,
)


@final
class GetLastActivityStateService:
    """Obtiene lo último que se estaba haciendo (o None si no hay nada que retomar)."""

    _activity_states_reader_sqlite_repository: ActivityStatesReaderSqliteRepository

    def __init__(self) -> None:
        self._activity_states_reader_sqlite_repository = (
            ActivityStatesReaderSqliteRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self) -> GetLastActivityStateResultDto:
        """Retorna el estado más reciente; has_state=False si no hay nada que retomar."""
        state = await self._activity_states_reader_sqlite_repository.get_last_activity_state()

        if not state:
            return GetLastActivityStateResultDto.from_primitives({"has_state": False})

        return GetLastActivityStateResultDto.from_primitives({**state, "has_state": True})
