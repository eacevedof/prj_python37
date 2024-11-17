from typing import final
import hashlib
import base64
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad
import nacl.pwhash

@final
class Hasher:

    ENCRYPT_SALT = "GAHo|89_ijaB%10@kOYu-92>"
    ENCRYPT_ALGORITHM = "AES-256-CBC"
    INITIALIZATION_VECTOR = "cdf86fc413278d46"

    @staticmethod
    def get_instance():
        return Hasher()

    def get_encrypted_data(self, plaintext: str) -> str:
        salt_in_md5 = hashlib.md5(self.ENCRYPT_SALT.encode()).hexdigest()
        ini_vector = self.get_initial_vector()
        cipher = AES.new(salt_in_md5.encode(), AES.MODE_CBC, ini_vector.encode())
        encrypted_data = cipher.encrypt(pad(plaintext.encode(), AES.block_size))
        return base64.b64encode(encrypted_data).decode()

    def get_decrypted_data(self, encrypted_text: str) -> str:
        salt_in_md5 = hashlib.md5(self.ENCRYPT_SALT.encode()).hexdigest()
        ini_vector = self.get_initial_vector()
        encrypted_data = base64.b64decode(encrypted_text)
        cipher = AES.new(salt_in_md5.encode(), AES.MODE_CBC, ini_vector.encode())
        decrypted_data = unpad(cipher.decrypt(encrypted_data), AES.block_size)
        return decrypted_data.decode()

    def get_initial_vector(self) -> str:
        ini_vector = hashlib.md5(self.INITIALIZATION_VECTOR.encode()).hexdigest()
        return ini_vector[:16]

    def does_password_match(self, hashed_password: str, plain_password: str) -> bool:
        return nacl.pwhash.verify(hashed_password.encode(), plain_password.encode())