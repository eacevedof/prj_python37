from typing import final, Self

from ddd.shared.infrastructure.components.hasher import Hasher
from ddd.devops.application.get_hashed_passwords.get_hashed_passwords_dto import (
    GetHashedPasswordsDto,
)
from ddd.devops.application.get_hashed_passwords.get_hashed_passwords_result_dto import (
    GetHashedPasswordsResultDto,
)
from ddd.devops.domain.exceptions.devops_exception import DevOpsException


@final
class GetHashedPasswordsService:
    """Service for hashing one or multiple passwords."""

    _hasher: Hasher

    def __init__(self) -> None:
        self._hasher = Hasher.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, get_hashed_passwords_dto: GetHashedPasswordsDto
    ) -> GetHashedPasswordsResultDto:
        """Hash one or multiple passwords.

        Args:
            get_hashed_passwords_dto: Input DTO with passwords and optional separator.

        Returns:
            GetHashedPasswordsResultDto with hashed password items.

        Raises:
            DevOpsException: If no valid passwords provided.
        """
        password_list = get_hashed_passwords_dto.get_password_list()

        if not password_list:
            raise DevOpsException.empty_password()

        items = []
        for password in password_list:
            hashed = self._hasher.get_password_hashed(password)
            items.append(
                {
                    "password": password,
                    "hashed_password": hashed,
                }
            )

        return GetHashedPasswordsResultDto.from_primitives(
            {
                "items": items,
                "total": len(items),
            }
        )
