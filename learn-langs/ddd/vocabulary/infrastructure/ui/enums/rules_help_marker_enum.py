"""Enumerado de marcas de texto que estructuran la ayuda (`rules_help`)."""

from enum import Enum


class RulesHelpMarkerEnum(str, Enum):
    """Marcas con las que están escritas las ayudas y que dan la jerarquía.

    Los valores NO son lowercase a propósito: son datos técnicos (una categoría
    unicode y los emojis literales con los que Eduardo escribe las tarjetas).
    """

    EMOJI_CATEGORY = "So"  # categoría unicode «Symbol, other»: 📐, 🧭, ⚠️...

    # Emojis de aviso: si no encabezan sección (no acaban en «:») van como cita
    CALLOUT_WARNING = "⚠"
    CALLOUT_POINTER = "👉"
    CALLOUT_IDEA = "💡"
    CALLOUT_ALERT = "❗"
    CALLOUT_SIREN = "🚨"
