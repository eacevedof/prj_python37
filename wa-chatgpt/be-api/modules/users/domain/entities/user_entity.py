from typing import final
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class UserEntity:
    user_uuid: str
    user_name: str
    user_password: str
    user_email: str
    user_code: str

    @staticmethod
    def from_primitives(
        user_uuid: str,
        user_name: str,
        user_password: str,
        user_email: str,
        user_code: str = None
    ) -> 'UserEntity':
        user_uuid = str(user_uuid).strip()
        user_name = str(user_name).strip()
        user_password = str(user_password).strip()
        user_email = str(user_email).strip()
        user_code = str(user_code).strip()
        return UserEntity(
            user_uuid=user_uuid,
            user_name=user_name,
            user_password=user_password,
            user_email=user_email,
            user_code=user_code
        )
