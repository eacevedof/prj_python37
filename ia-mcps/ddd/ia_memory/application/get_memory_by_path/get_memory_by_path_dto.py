from dataclasses import dataclass


@dataclass(frozen=True, slots=True)
class GetMemoryByPathDto:
    project: str
    file_path: str
