import hmac
from typing import Self, final

from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)


@final
class ApikeyAuthenticator:
    """Borde de auth de /mcp/*: ¿puede este cliente consumir el servicio?

    A diferencia de ocr-documents (apikeys en BD, una por integración), aquí la
    clave es una sola y vive en `APP_MCP_API_KEY` del `.env`: este repo no tiene BD
    ni usuarios, y la apikey autoriza, no identifica.

    Con `APP_MCP_API_KEY` vacía NADIE pasa: un despliegue al que se le olvidó la
    variable tiene que quedarse cerrado, no abierto.
    """

    _environment_reader_raw_repository: EnvironmentReaderRawRepository

    def __init__(self) -> None:
        self._environment_reader_raw_repository = EnvironmentReaderRawRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def has_service_access(self, apikey: str) -> bool:
        expected_apikey = self._environment_reader_raw_repository.get_mcp_api_key()
        if not expected_apikey or not apikey:
            return False
        # compare_digest: comparar en tiempo constante para no filtrar la clave
        # por el tiempo de respuesta.
        return hmac.compare_digest(apikey, expected_apikey)
