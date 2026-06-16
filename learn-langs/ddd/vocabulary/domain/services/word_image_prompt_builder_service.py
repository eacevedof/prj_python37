from typing import final


@final
class WordImagePromptBuilderService:
    """Servicio de dominio: construye el prompt para la imagen educativa de una palabra."""

    _STYLE = (
        "Kawaii style, flat colors, minimalist, educational, "
        "clean white background, vector art style, "
        "friendly and approachable, "
        "NO TEXT, NO WORDS, NO LETTERS in the image, "
        "only visual representation, "
        "DO NOT add faces, eyes or expressions to inanimate objects or body parts, "
        "NO anthropomorphization, keep objects realistic in their nature, "
        "perfect for language learning flashcards"
    )

    @staticmethod
    def build(word_es: str, context: str | None = None) -> str:
        """Construye el prompt cartoon educativo (sin texto en la imagen)."""
        base_prompt = f"A cute cartoon illustration of a {word_es}"
        if context:
            base_prompt += f" ({context})"
        return f"{base_prompt}. {WordImagePromptBuilderService._STYLE}"
