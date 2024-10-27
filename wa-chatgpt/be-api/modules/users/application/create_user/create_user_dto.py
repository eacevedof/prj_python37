from typing import final
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class CreateUserDto:
    user_name: str
    user_password: str
    user_email: str

    @staticmethod
    def from_primitives(user_name: str) -> 'CreateUserDto':
        user_name = str(user_name).strip()
        return CreateUserDto(
            user_name=user_name
        )
