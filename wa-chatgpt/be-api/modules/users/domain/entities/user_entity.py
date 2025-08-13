from typing import final
from dataclasses import dataclass
from typing import Dict

@final
@dataclass(frozen=False)
class UserEntity:

    id: int|None
    user_uuid: str|None
    user_name: str|None
    user_login: str|None
    user_password: str|None
    user_email: str|None
    user_code: str|None
    created_at: str|None

    @staticmethod
    def from_primitives(
        id: int|None,
        user_uuid: str,
        user_name: str,
        user_login: str,
        user_password: str,
        user_email: str,
        user_code: str,
        created_at: str
    ) -> 'UserEntity':
        user_uuid = str(user_uuid).strip()
        user_name = str(user_name).strip()
        user_login = str(user_login).strip()
        user_password = str(user_password).strip()
        user_email = str(user_email).strip()
        user_code = str(user_code).strip()
        return UserEntity(
            id=id,
            user_uuid=user_uuid,
            user_name=user_name,
            user_login=user_login,
            user_password=user_password,
            user_email=user_email,
            user_code=user_code,
            created_at=created_at
        )

    @staticmethod
    def from_primitives_dic(primitives: Dict[str, str]) -> 'UserEntity':
        user_uuid = str(primitives.get("user_uuid", "")).strip()
        user_name = str(primitives.get("user_name", "")).strip()
        user_login = str(primitives.get("user_login", "")).strip()
        user_password = str(primitives.get("user_password", "")).strip()
        user_email = str(primitives.get("user_email", "")).strip()
        user_code = str(primitives.get("user_code", "")).strip()
        created_at = str(primitives.get("created_at", "")).strip()
        return UserEntity(
            id=primitives.get("id", None),
            user_uuid=user_uuid,
            user_name=user_name,
            user_login=user_login,
            user_password=user_password,
            user_email=user_email,
            user_code=user_code,
            created_at=created_at
        )

    def login_with_email(self) -> None:
        self.user_login = self.user_email
