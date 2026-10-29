from enum import StrEnum
from typing import final


@final
class FishAudioVoiceEnum(StrEnum):
    """Voces de Fish Audio: CÓMO SUENA el audio (timbre, género, acento).

    Se manda como `reference_id` en `POST /v1/tts`: el modelo imita esa voz al
    leer el texto. Sin `reference_id` usa la voz por defecto del modelo, que
    puede no ser española. El id es el de la URL de la voz en la biblioteca
    (`fish.audio/m/<id>`) o el de una voz clonada propia; no es secreto.

    Lista sacada de `GET /model` (las más usadas por idioma, 2026-10-29), sin las
    que imitan a personas reales o a personajes con derechos. Para añadir una,
    un miembro más. La que se usa la elige `SpeakTextService`. Base del futuro
    «pon la voz X» (ver ia-mcps-to-do §voice_mod).
    """

    # español
    VERITY_ES = "692eb1e1023242219dc8caae8c56fb12"  # mujer, amigable y enérgica, para asistentes
    CHICA_ES = "35929683c49c4ec0bf779dc07d22620b"  # mujer joven, enérgica y clara
    MUJER_ES = "5e816f5a0658460b960881a24733c418"  # mujer joven, amigable, acento latino
    COLOMBIANA_ES = "e296306da5d449999f6e35c2b9f60aea"  # mujer, cálida y tranquila, acento colombiano
    NAGI_ES = "70fb19852a484f3eb1d040423e2a8be7"  # mujer, segura y clara, tono de anuncio
    REZE_ES = "3f56a67897df4d218eac6494ff88337f"  # mujer joven, suave y cercana
    ADAM_ES = "9deec9a061894a93a133d2bf45d2e4c0"  # hombre, profesional y con energía
    ELITE_ES = "dc0746cd45dd40deb6bca32dc87fd7f5"  # hombre, grave y pausado, narración
    SABIO_ES = "60a33602dacc4d899cb671b024e66d8c"  # hombre mayor, cálido y tranquilo, voz en off
    VALENTINO_ES = "a1fe2e1b6f324e27929d5088f2d09be3"  # hombre mayor, grave y suave, locución
    LOCUTOR_ES = "3f45a7fd7a614655a61eb7027b955783"  # hombre, grave y serio, locutor

    # inglés
    SARAH_EN = "933563129e564b19a115bedd57b7406a"  # mujer joven, suave y conversacional
    SELENE_EN = "b347db033a6549378b48d00acb0d06cd"  # mujer, tranquila, tono de meditación
    ETHAN_EN = "536d3a5e000945adb7038665781a4aca"  # hombre, claro, para explicar
    ADRIAN_EN = "bf322df2096a46f18c579d0baa36f41d"  # hombre, grave y pausado, narrador

    # neerlandés
    RUSTIG_NL = "add4d395494c4ed0ba2018e77b39ea54"  # hombre, calmado y claro
    DEMO_NL = "3c1b7fc528b74a2b97d01e637642233d"  # hombre, cálido y conversacional
