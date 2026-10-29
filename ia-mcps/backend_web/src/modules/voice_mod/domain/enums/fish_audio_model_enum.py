from enum import StrEnum
from typing import final


@final
class FishAudioModelEnum(StrEnum):
    """Modelos TTS de Fish Audio: el MOTOR que genera el audio.

    Se manda en la cabecera `model` de `POST /v1/tts`. Decide la calidad, la
    latencia, los idiomas y el PRECIO; no decide cómo suena la voz (eso es
    `FishAudioVoiceEnum`). Cualquier voz funciona con cualquier modelo.

    Un valor desconocido NO falla: la API cae a `s2.1-pro` y lo cobra. Por eso el
    que se usa va explícito en `SpeakTextService`. Para añadir uno, un miembro más.
    """

    S2_1_PRO_FREE = "s2.1-pro-free"  # gratis hasta 2026-11-30 (free tier), sin garantías de latencia
    S2_1_PRO = "s2.1-pro"  # de pago: el mismo modelo con latencia garantizada
    S2_PRO = "s2-pro"  # de pago: la generación anterior de S2
    S1 = "s1"  # de pago: generación antigua, sin diálogo entre varias voces
    DRAMA_3 = "drama-3"  # de pago: pensado para diálogo y voces de personaje
