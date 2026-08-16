"""Enumerado de codigos de idioma."""

from enum import StrEnum


class LanguageCodeEnum(StrEnum):
    """Codigos de idioma soportados (ISO 639-1 + pais)."""

    # Origen (idioma fuente del vocabulario; no es destino seleccionable)
    ES_ES = "es_ES"  # Spanish (Spain) - source language

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

    @property
    def display_name(self) -> str:
        """Nombre para mostrar en UI."""
        names = {
            self.ES_ES: "Español",
            self.NL_NL: "Nederlands",
            self.NL_BE: "Vlaams",
            self.EN_US: "English (US)",
            self.EN_GB: "English (UK)",
            self.DE_DE: "Deutsch",
            self.FR_FR: "Français",
            self.PT_BR: "Português",
            self.IT_IT: "Italiano",
        }
        return names.get(self, self.value)

    @classmethod
    def ui_options(cls) -> list["LanguageCodeEnum"]:
        """Idiomas disponibles para la UI (excluyendo variantes poco usadas)."""
        return [
            cls.NL_NL,
            cls.EN_US,
            cls.EN_GB,
            cls.DE_DE,
            cls.FR_FR,
        ]
