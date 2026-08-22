from typing import final


@final
class MediaResultKeyEnum:
    """Claves de los `to_dict()` de los casos de uso de media_mod.

    Son el contrato que cruza el puerto `MediaGenerationPort` hacia `media_mcp`.
    """

    FILES = "files"
    MODEL = "model"
    SIZE = "size"
    QUALITY = "quality"
    VOICE = "voice"
    SPEED = "speed"
    FORMAT = "format"
