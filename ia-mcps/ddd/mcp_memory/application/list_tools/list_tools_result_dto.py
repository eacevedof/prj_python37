from dataclasses import dataclass
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class ListToolsResultDto:
	"""Result DTO for listing tools."""
	tools: list[dict]

	@classmethod
	def from_primitives(cls, primitives: dict[str, Any]) -> Self:
		return cls(tools=primitives.get("tools", []))

	def to_dict(self) -> dict[str, Any]:
		return {"tools": self.tools}

	def to_primitives(self) -> dict[str, Any]:
		return self.to_dict()
