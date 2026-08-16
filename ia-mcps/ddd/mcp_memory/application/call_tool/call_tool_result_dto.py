from dataclasses import dataclass
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class CallToolResultDto:
	"""Result DTO for tool execution."""
	result: dict[str, Any]

	@classmethod
	def from_primitives(cls, primitives: dict[str, Any]) -> Self:
		return cls(result=primitives.get("result", {}))

	def to_dict(self) -> dict[str, Any]:
		return self.result

	def to_primitives(self) -> dict[str, Any]:
		return self.to_dict()
