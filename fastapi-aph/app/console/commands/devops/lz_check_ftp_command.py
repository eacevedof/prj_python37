from typing import Optional

from app.console.commands.abstract_command import AbstractCommand
from app.console.interface_console import InterfaceConsole
from app.shared.infrastructure.components.cli.lz_cli_args import LzCliArgs


class LzCheckFtpCommand(AbstractCommand, InterfaceConsole):
    """FTP connection check command"""
    
    def __init__(self):
        super().__init__()
    
    @classmethod
    def get_instance(cls) -> 'LzCheckFtpCommand':
        return cls()
    
    async def invoke(self, lz_cli_args: Optional[LzCliArgs] = None) -> None:
        """Execute the FTP check command"""
        self.echo_start("LzCheckFtpCommand")
        
        # Implementation would test FTP connectivity
        self.echo_step("FTP check - implementation pending")
        
        self.echo_end("LzCheckFtpCommand")