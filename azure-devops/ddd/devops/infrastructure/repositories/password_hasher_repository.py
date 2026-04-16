from typing import final, Self

from argon2 import PasswordHasher
from argon2.profiles import RFC_9106_LOW_MEMORY


@final
class PasswordHasherRepository:
    """Repository for password hashing using Argon2id.

    Uses settings compatible with PHP's sodium_crypto_pwhash_str
    (SODIUM_CRYPTO_PWHASH_OPSLIMIT_INTERACTIVE, SODIUM_CRYPTO_PWHASH_MEMLIMIT_INTERACTIVE).
    """

    def __init__(self) -> None:
        # PHP SODIUM_CRYPTO_PWHASH_OPSLIMIT_INTERACTIVE = 2
        # PHP SODIUM_CRYPTO_PWHASH_MEMLIMIT_INTERACTIVE = 67108864 (64MB)
        # Using RFC_9106_LOW_MEMORY profile which is similar
        self._hasher = PasswordHasher.from_parameters(RFC_9106_LOW_MEMORY)

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def hash_password(self, password: str) -> str:
        """Hash a single password using Argon2id.

        Args:
            password: Plain text password to hash.

        Returns:
            Hashed password string.
        """
        return self._hasher.hash(password)
