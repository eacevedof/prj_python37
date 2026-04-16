from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetHashedPasswordsDto:
    """Input DTO for getting hashed passwords."""

    passwords: str
    separator: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            passwords=str(primitives.get("passwords", "")).strip(),
            separator=str(primitives.get("separator", "")).strip(),
        )

    def get_password_list(self) -> list[str]:
        """Parse passwords string into a list.

        Returns:
            List of individual passwords (trimmed, non-empty).
        """
        if self.separator:
            return [
                p.strip() for p in self.passwords.split(self.separator) if p.strip()
            ]
        return [self.passwords.strip()] if self.passwords.strip() else []
