import hashlib
import hmac
import secrets
import string
from typing import Self, final

# Formato almacenado: `pbkdf2_sha256$<iteraciones>$<salt_hex>$<clave_hex>`. Es
# autodescriptivo a propósito: subir el coste mañana no invalida lo ya guardado,
# porque cada hash lleva escrito con cuántas iteraciones se generó.
_ALGORITHM_NAME = "pbkdf2_sha256"
_HASH_ALGORITHM = "sha256"
_ITERATIONS = 600_000
_SALT_BYTES = 16
_FIELD_SEPARATOR = "$"
_FIELD_COUNT = 4
_HEX_DIGITS = frozenset(string.hexdigits)


@final
class Hasher:
    """Hash y verificación de contraseñas con PBKDF2-HMAC-SHA256 (solo stdlib).

    Es un COMPONENTE: depende únicamente del core del lenguaje, no captura
    excepciones de nadie y no loguea. La contraseña en claro no sale de aquí y
    NUNCA se guarda: lo que se persiste es el resultado de `get_password_hash`.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_password_hash(self, plain_password: str) -> str:
        salt_bytes = secrets.token_bytes(_SALT_BYTES)
        return _FIELD_SEPARATOR.join(
            [
                _ALGORITHM_NAME,
                str(_ITERATIONS),
                salt_bytes.hex(),
                self.__get_derived_key_hex(plain_password, salt_bytes, _ITERATIONS),
            ]
        )

    def is_password_valid(self, plain_password: str, password_hash: str) -> bool:
        """Comparación en tiempo constante contra el hash guardado.

        Un hash vacío o con formato desconocido no valida y no lanza: lo que
        llega viene de la base de datos, así que "no coincide" es una respuesta
        de negocio, no un fallo del código.
        """
        password_hash_fields = password_hash.split(_FIELD_SEPARATOR)
        if len(password_hash_fields) != _FIELD_COUNT:
            return False

        algorithm_name, iterations_text, salt_hex, derived_key_hex = password_hash_fields
        if algorithm_name != _ALGORITHM_NAME or not iterations_text.isdigit():
            return False
        if not self.__has_only_hex_digits(salt_hex) or not self.__has_only_hex_digits(derived_key_hex):
            return False

        return hmac.compare_digest(
            self.__get_derived_key_hex(plain_password, bytes.fromhex(salt_hex), int(iterations_text)),
            derived_key_hex,
        )

    def __get_derived_key_hex(self, plain_password: str, salt_bytes: bytes, iterations: int) -> str:
        return hashlib.pbkdf2_hmac(
            _HASH_ALGORITHM, plain_password.encode("utf-8"), salt_bytes, iterations
        ).hex()

    def __has_only_hex_digits(self, text: str) -> bool:
        return bool(text) and len(text) % 2 == 0 and set(text) <= _HEX_DIGITS
