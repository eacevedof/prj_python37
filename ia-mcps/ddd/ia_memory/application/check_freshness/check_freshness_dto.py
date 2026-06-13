from dataclasses import dataclass


@dataclass(frozen=True, slots=True)
class CheckFreshnessDto:
    project: str
