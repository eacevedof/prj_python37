from dataclasses import dataclass
from typing import Any


@dataclass(frozen=True, slots=True)
class CallToolDto:
	"""Input DTO for calling a tool."""
	tool_name: str
	tool_arguments: dict[str, Any]
