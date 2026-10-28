from enum import Enum


class AuthEnum(str, Enum):
    """Constantes del borde de autenticación por apikey (X-Api-Key).

    A diferencia de ocr-documents, aquí la apikey NO resuelve una persona: estos
    servidores no operan "en nombre de" nadie, no hay BD ni usuarios. La clave
    autoriza a consumir el servicio y se acabó.
    """

    APIKEY_HEADER = "x-api-key"
    HEALTH_PATH = "/health-check"
    MCP_PREFIX = "/mcp/"
