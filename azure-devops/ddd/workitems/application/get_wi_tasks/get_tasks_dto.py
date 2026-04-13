from dataclasses import dataclass
from typing import Self, Any

from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import EnvironmentReaderRawRepository
from ddd.workitems.domain.enums.work_item_state_enum import WorkItemStateEnum


# Valid states from enum for validation
_VALID_STATES = {state.value.lower(): state.value for state in WorkItemStateEnum}


@dataclass(frozen=True, slots=True)
class GetTasksDto:
    """Input DTO for querying work items with filters."""

    project: str
    epic_id: int | None = None
    states: list[str] | None = None
    assigned_to: str | None = None
    work_item_type: str | None = None
    limit: int = 50

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        project = str(primitives.get("project", "")).strip()
        if not project:
            project = EnvironmentReaderRawRepository.get_instance().get_app_default_project()

        epic_id = primitives.get("epic_id")
        states = cls._parse_and_validate_states(primitives.get("state"))

        return cls(
            project=project,
            epic_id=int(epic_id) if epic_id else None,
            states=states,
            assigned_to=primitives.get("assigned_to"),
            work_item_type=primitives.get("work_item_type"),
            limit=int(primitives.get("limit", 50)),
        )

    @staticmethod
    def _parse_and_validate_states(state_input: str | list[str] | None) -> list[str] | None:
        """Parse and validate state input against WorkItemStateEnum.

        Accepts:
        - None -> None
        - "active" -> ["Active"]
        - "new,active" -> ["New", "Active"]
        - ["new", "active"] -> ["New", "Active"]

        Invalid states are ignored. If all states are invalid, returns None.
        """
        if state_input is None:
            return None

        if isinstance(state_input, list):
            raw_states = [s.strip().lower() for s in state_input if s.strip()]
        else:
            raw_states = [s.strip().lower() for s in str(state_input).split(",") if s.strip()]

        # Validate against enum and get proper casing
        valid_states = [
            _VALID_STATES[state]
            for state in raw_states
            if state in _VALID_STATES
        ]

        return valid_states if valid_states else None

    @staticmethod
    def get_valid_states() -> list[str]:
        """Return list of valid state values."""
        return list(_VALID_STATES.values())
