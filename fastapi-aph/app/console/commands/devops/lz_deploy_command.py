from typing import Optional, final

from app.console.commands.abstract_command import AbstractCommand
from app.console.interface_console import InterfaceConsole
from app.shared.infrastructure.components.cli.lz_cli_args import LzCliArgs
from application.run_migrations.run_migrations_service import RunMigrationsService


@final
class LzDeployCommand(AbstractCommand, InterfaceConsole):
    """Deploy command that runs migrations"""
    
    def __init__(self):
        super().__init__()
        self.run_migrations_service = RunMigrationsService.get_instance()
    
    @classmethod
    def get_instance(cls) -> 'LzDeployCommand':
        return cls()
    
    async def invoke(self, lz_cli_args: Optional[LzCliArgs] = None) -> None:
        """Execute the deploy command"""
        self._echo_start("LzDeployCommand")
        
        await self.run_migrations_service.invoke()
        
        self._echo_end("LzDeployCommand")