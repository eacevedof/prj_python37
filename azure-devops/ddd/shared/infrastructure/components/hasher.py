import hashlib
import secrets
import string
from typing import final, Self

from argon2 import PasswordHasher
from argon2.profiles import RFC_9106_LOW_MEMORY
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend
from nacl import pwhash


@final
class Hasher:
    _ENCRYPT_SALT: str = "a1b;2c3-d4e,5f6g7h81."
    _INITIALIZATION_VECTOR: str = "cdf86fc413278d46"
    _IV_LENGTH: int = 16

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_encrypted_data(self, plaintext: str) -> str:
        salt_in_md5 = hashlib.md5(self._ENCRYPT_SALT.encode()).hexdigest()
        iv = self._get_initial_vector()

        cipher = Cipher(
            algorithms.AES(salt_in_md5.encode("utf-8")),
            modes.CBC(iv.encode("utf-8")),
            backend=default_backend()
        )
        encryptor = cipher.encryptor()

        # PKCS7 padding
        block_size = 16
        padding_length = block_size - (len(plaintext) % block_size)
        padded_plaintext = plaintext + chr(padding_length) * padding_length

        encrypted = encryptor.update(padded_plaintext.encode("utf-8")) + encryptor.finalize()
        return encrypted.hex()

    def get_decrypted_data(self, encrypted_hex: str) -> str:
        salt_in_md5 = hashlib.md5(self._ENCRYPT_SALT.encode()).hexdigest()
        iv = self._get_initial_vector()

        cipher = Cipher(
            algorithms.AES(salt_in_md5.encode("utf-8")),
            modes.CBC(iv.encode("utf-8")),
            backend=default_backend()
        )
        decryptor = cipher.decryptor()

        encrypted_bytes = bytes.fromhex(encrypted_hex)
        decrypted = decryptor.update(encrypted_bytes) + decryptor.finalize()

        # Remove PKCS7 padding
        padding_length = decrypted[-1]
        return decrypted[:-padding_length].decode("utf-8")

    def _get_initial_vector(self) -> str:
        iv_md5 = hashlib.md5(self._INITIALIZATION_VECTOR.encode()).hexdigest()
        return iv_md5[:self._IV_LENGTH]

    def does_password_match(self, hashed_password: str, plain_password: str) -> bool:
        return pwhash.verify(hashed_password.encode("utf-8"), plain_password.encode("utf-8"))

    def get_random_string_by_length(self, length: int = 12) -> str:
        charset = string.ascii_uppercase + string.digits
        return "".join(secrets.choice(charset) for _ in range(length))

    def get_password_hashed(self, plain: str) -> str:
        """Hash a plain text value using Argon2id.

        Uses the RFC_9106_LOW_MEMORY profile, compatible with PHP's
        sodium_crypto_pwhash_str (OPSLIMIT/MEMLIMIT_INTERACTIVE).
        """
        password_hasher = PasswordHasher.from_parameters(RFC_9106_LOW_MEMORY)
        return password_hasher.hash(plain)

    def verify_password(self, hashed: str, plain: str) -> bool:
        """Verify a plain text value against an Argon2id hash.

        Lets argon2's VerifyMismatchError (and other exceptions) propagate.
        """
        password_hasher = PasswordHasher.from_parameters(RFC_9106_LOW_MEMORY)
        return password_hasher.verify(hashed, plain)

    def get_sodium_crypto_hashed(self, plain_text: str) -> str:
        return pwhash.str(
            plain_text.encode("utf-8"),
            opslimit=pwhash.OPSLIMIT_INTERACTIVE,
            memlimit=pwhash.MEMLIMIT_INTERACTIVE
        ).decode("utf-8")

    def get_md5_hash(self, text: str) -> str:
        return hashlib.md5(text.encode("utf-8")).hexdigest()

    def get_sha256_hash(self, text: str) -> str:
        return hashlib.sha256(text.encode("utf-8")).hexdigest()
