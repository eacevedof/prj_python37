from dataclasses import dataclass


@dataclass(frozen=True)
class CheckFreshnessDto:
    project: str
