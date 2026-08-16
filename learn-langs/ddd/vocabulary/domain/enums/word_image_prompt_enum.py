"""Piezas del prompt con el que se genera la imagen educativa de una palabra."""

from enum import Enum


class WordImagePromptEnum(str, Enum):
    """Plantilla base y estilo fijo del prompt de imagen (sin texto en la imagen)."""

    BASE_TEMPLATE = "A cute cartoon illustration of a {word_es}"
    CONTEXT_TEMPLATE = " ({context})"
    STYLE = (
        "Kawaii style, flat colors, minimalist, educational, "
        "clean white background, vector art style, "
        "friendly and approachable, "
        "NO TEXT, NO WORDS, NO LETTERS in the image, "
        "only visual representation, "
        "DO NOT add faces, eyes or expressions to inanimate objects or body parts, "
        "NO anthropomorphization, keep objects realistic in their nature, "
        "perfect for language learning flashcards"
    )
