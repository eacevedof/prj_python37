from typing import final


@final
class MediaResultKeyEnum:
    """Claves de los `to_dict()` de los casos de uso de media_mod.

    Las claves del `to_dict()`, que es lo que serializaría un `api_controller`.
    """

    FILES = "files"
    MODEL = "model"
    SIZE = "size"
    QUALITY = "quality"
    VOICE = "voice"
    SPEED = "speed"
    FORMAT = "format"
