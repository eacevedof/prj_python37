import os
from dataclasses import dataclass
from typing import final

from config.paths import PATH_DATABASE_FOLDER

from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.date_timer import DateTimer
from modules.shared.infrastructure.repositories.abstract_postgres_repository import AbstractPostgresRepository

@final
@dataclass(frozen=True)
class UsersPostgresRepository(AbstractPostgresRepository):

    __date_timer: DateTimer
    @staticmethod
    def get_instance() -> "UsersPostgresRepository":
        return UsersPostgresRepository(
            DateTimer.get_instance()
        )

    def create_user(self, user_name: str, user_password: str, user_email: str, user_code: str = None) -> None:
        sql = f"""
        INSERT INTO users (user_name, user_password, user_email, user_code)
        VALUES ('{user_name}', '{user_password}', '{user_email}', '{user_code}')
        """
        self._execute(sql)