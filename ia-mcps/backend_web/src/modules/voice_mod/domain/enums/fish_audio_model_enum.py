from enum import StrEnum
from typing import final


@final
class FishAudioModelEnum(StrEnum):
    """Modelos TTS de Fish Audio (cabecera `model` de `POST /v1/tts`).

    Un valor desconocido NO falla: la API cae a `s2.1-pro` y lo cobra. Por eso el
    por defecto es explícito y es el gratuito.
    """

    S2_1_PRO_FREE = "s2.1-pro-free"  # gratis, sin garantías de latencia (free temporal)
    S2_1_PRO = "s2.1-pro"
    S2_PRO = "s2-pro"
