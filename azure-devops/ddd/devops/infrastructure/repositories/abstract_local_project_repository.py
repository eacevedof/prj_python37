from abc import ABC
from typing import Self

from ddd.shared.infrastructure.components.logger import Logger


class AbstractLocalProjectRepository(ABC):
    """Base repository with common plumbing for local project setup operations."""

    _logger: Logger

    def __init__(self) -> None:
        self._logger = Logger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()
