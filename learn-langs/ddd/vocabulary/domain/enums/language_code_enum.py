"""Enumerado de codigos de idioma."""

from enum import StrEnum


class LanguageCodeEnum(StrEnum):
    """Codigos de idioma soportados (ISO 639-1 + pais)."""

    # Principal
    NL_NL = "nl_NL"  # Dutch (Netherlands)

    # Otros idiomas
    NL_BE = "nl_BE"  # Flemish (Belgium)
    EN_US = "en_US"  # English (US)
    EN_GB = "en_GB"  # English (UK)
    DE_DE = "de_DE"  # German
    FR_FR = "fr_FR"  # French
    PT_BR = "pt_BR"  # Portuguese (Brazil)
    IT_IT = "it_IT"  # Italian

    @classmethod
    def default(cls) -> "LanguageCodeEnum":
        """Idioma por defecto."""
        return cls.NL_NL
