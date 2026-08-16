from typing import final
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class GetApiAuthTokenByUserDto:
    user_name: str
    user_password: str

    @staticmethod
    def from_primitives(
        user_name: str,
        user_password: str,
    ) -> 'GetApiAuthTokenByUserDto':

        user_name = str(user_name).strip()
        user_password = str(user_password).strip()
        return GetApiAuthTokenByUserDto(
            user_name=user_name,
            user_password=user_password,
        )
