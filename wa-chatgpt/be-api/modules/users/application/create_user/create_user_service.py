from typing import final
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class CreateUserDto:
    user_name: str
    user_password: str
    user_email: str
    user_code: str = None

    @staticmethod
    def from_primitives(
        user_name: str,
        user_password: str,
        user_email: str,
        user_code: str = None
    ) -> 'CreateUserDto':

        user_name = str(user_name).strip()
        user_password = str(user_password).strip()
        user_email = str(user_email).strip()
        user_code = str(user_code).strip()
        return CreateUserDto(
            user_name=user_name,
            user_password=user_password,
            user_email=user_email,
            user_code=user_code
        )
