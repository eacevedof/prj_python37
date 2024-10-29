from dataclasses import dataclass
from typing import final
import bcrypt
from config.config import ENCRYPT_SALT

@final
@dataclass(frozen=True)
class Encrypter:

    __SALT = ENCRYPT_SALT

    @staticmethod
    def get_instance() -> "Encrypter":
        return Encrypter()

    def get_encrypted(self, text: str) -> str:
        text_encode = str.encode(text)
        salt_encode = str.encode(self.__SALT)
        hashed_password = bcrypt.hashpw(text_encode, salt_encode)
        return hashed_password.decode("utf-8")

    def does_password_match(self, text: str, hashed_password: str) -> bool:
        text_encode = text.encode("utf-8")
        hashed_password_encode = hashed_password.encode("utf-8")
        return bcrypt.checkpw(text_encode, hashed_password_encode)