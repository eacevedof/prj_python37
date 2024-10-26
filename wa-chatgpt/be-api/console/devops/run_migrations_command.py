import os
from dataclasses import dataclass
from typing import final

from modules.devops.application.run_migrations.run_migrations_service import RunMigrationsService

@final
@dataclass(frozen=True)
class RunMigrationsCommand:

    @staticmethod
    def get_instance() -> "RunMigrationsCommand":
        return RunMigrationsCommand()

    def invoke(self) -> None:
        RunMigrationsService.get_instance().invoke()


if __name__ == "__main__":
    RunMigrationsCommand.get_instance().invoke()
