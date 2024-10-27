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
        text_encode = text.encode("utf-8")
        hashed_password = bcrypt.hashpw(text_encode, self.__SALT)
        return hashed_password.decode("utf-8")