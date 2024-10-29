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