from typing import final

from ddd.open_ai.domain.enums import OpenaiTtsVoiceEnum
from ddd.vocabulary.domain.enums.language_code_enum import LanguageCodeEnum


@final
class TtsVoiceSelectorService:
    """Servicio de dominio: selecciona la voz TTS óptima según el idioma."""

    _VOICE_BY_LANG: dict[str, str] = {
        LanguageCodeEnum.NL_NL.value: OpenaiTtsVoiceEnum.NOVA.value,
        LanguageCodeEnum.NL_BE.value: OpenaiTtsVoiceEnum.NOVA.value,
        LanguageCodeEnum.EN_US.value: OpenaiTtsVoiceEnum.ALLOY.value,
        LanguageCodeEnum.EN_GB.value: OpenaiTtsVoiceEnum.FABLE.value,
        LanguageCodeEnum.DE_DE.value: OpenaiTtsVoiceEnum.ECHO.value,
        LanguageCodeEnum.FR_FR.value: OpenaiTtsVoiceEnum.SHIMMER.value,
        LanguageCodeEnum.PT_BR.value: OpenaiTtsVoiceEnum.NOVA.value,
        LanguageCodeEnum.IT_IT.value: OpenaiTtsVoiceEnum.SHIMMER.value,
    }

    @staticmethod
    def select(lang_code: str) -> str:
        """Devuelve la voz para el idioma dado (ALLOY por defecto)."""
        return TtsVoiceSelectorService._VOICE_BY_LANG.get(
            lang_code,
            OpenaiTtsVoiceEnum.ALLOY.value
        )
