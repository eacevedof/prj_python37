"""Enum para tipos de fuente de imagen."""

from enum import StrEnum


class ImageSourceEnum(StrEnum):
    """Tipos de fuente de imagen."""

    SCREENSHOT = "SCREENSHOT"    # Captura de pantalla
    CLIPBOARD = "CLIPBOARD"      # Copiado del portapapeles
    CAMERA = "CAMERA"            # Captura de camara
    URL = "URL"                  # Descargada de internet
    LOCAL = "LOCAL"              # Archivo local
    VECTORIAL = "VECTORIAL"      # SVG u otro formato vectorial
