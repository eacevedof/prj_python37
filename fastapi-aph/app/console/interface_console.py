from abc import ABC, abstractmethod
from typing import Optional

from app.shared.infrastructure.components.cli.lz_cli_args import LzCliArgs


class InterfaceConsole(ABC):
    """Interface for console commands"""
    
    @abstractmethod
    async def invoke(self, lz_cli_args: Optional[LzCliArgs] = None) -> None:
        """Execute the console command"""
        pass