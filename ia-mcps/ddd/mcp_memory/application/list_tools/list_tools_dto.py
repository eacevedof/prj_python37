from dataclasses import dataclass
from typing import Any


@dataclass(frozen=True, slots=True)
class ListToolsDto:
	"""Input DTO for listing available tools."""
	pass
