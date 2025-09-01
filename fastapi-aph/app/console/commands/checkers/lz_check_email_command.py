from typing import Optional, final

from app.console.commands.abstract_command import AbstractCommand
from app.console.interface_console import InterfaceConsole
from app.shared.infrastructure.components.cli.lz_cli_args import LzCliArgs


@final
class LzCheckEmailCommand(AbstractCommand, InterfaceConsole):
    """Email system check command"""
    
    def __init__(self):
        super().__init__()
    
    @classmethod
    def get_instance(cls) -> 'LzCheckEmailCommand':
        return cls()
    
    async def invoke(self, lz_cli_args: Optional[LzCliArgs] = None) -> None:
        """Execute the email check command"""
        self._echo_start("LzCheckEmailCommand")
        
        # Implementation would depend on mailing module
        self._echo_step("Email check - implementation pending")
        
        self._echo_end("LzCheckEmailCommand")