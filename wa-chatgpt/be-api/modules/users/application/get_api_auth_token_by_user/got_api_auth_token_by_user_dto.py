from typing import final
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class GotApiAuthTokenByUserDto:

    id: int
    user_uuid: str
    user_name: str
    user_login: str
    user_password: str
    user_email: str
    user_code: str
    created_at: str

    @staticmethod
    def from_primitives(
        id: int,
        user_uuid: str,
        user_name: str,
        user_login: str,
        user_email: str,
        user_code: str,
        created_at: str
    ) -> 'GotApiAuthTokenByUserDto':

        user_name = str(user_name).strip()
        user_email = str(user_email).strip()
        user_code = str(user_code).strip()

        return GotApiAuthTokenByUserDto(
            id=id,
            user_uuid=user_uuid,
            user_name=user_name,
            user_login=user_login,
            user_password="****",
            user_email=user_email,
            user_code=user_code,
            created_at=created_at
        )
