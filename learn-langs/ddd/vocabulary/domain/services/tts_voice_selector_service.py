from typing import Self, final

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
    _DEFAULT_VOICE: str = OpenaiTtsVoiceEnum.ALLOY.value

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_voice(self, lang_code: str) -> str:
        """Devuelve la voz para el idioma dado (ALLOY por defecto)."""
        return self._VOICE_BY_LANG.get(lang_code, self._DEFAULT_VOICE)
