"""Servicio de dominio: aproxima la pronunciación neerlandesa para hispanohablantes."""

from typing import final, Self


@final
class DutchToSpanishPhoneticService:
    """Transcribe un texto neerlandés a una lectura aproximada en español.

    Heurística (NO fonética exacta): mapea las grafías neerlandesas más comunes
    a cómo las leería un hispanohablante, para apoyar la pronunciación del slider.
    Ejemplo: "bedoelt het goed" -> "bedult et jud".
    """

    # Reglas ordenadas de más largas a más cortas. Se aplican en una sola pasada
    # de izquierda a derecha, así la salida NO se vuelve a procesar (p. ej. la "j"
    # que produce la "g" no se convierte luego en "y").
    _RULES: tuple[tuple[str, str], ...] = (
        # Trígrafos / dígrafos
        ("sch", "sj"),
        ("ch", "j"),
        ("oe", "u"),
        ("oo", "o"),
        ("aa", "a"),
        ("ee", "e"),
        ("uu", "u"),
        ("ie", "i"),
        ("ij", "ei"),
        ("ei", "ei"),
        ("ui", "au"),
        ("ou", "au"),
        ("au", "au"),
        ("eu", "e"),
        # Letras sueltas
        ("g", "j"),   # g neerlandesa (gutural) ~ jota española
        ("v", "f"),
        ("w", "u"),
        ("z", "s"),
        ("j", "y"),   # j neerlandesa ~ y española
        ("h", ""),    # h española muda
    )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def transcribe(self, dutch_text: str) -> str:
        """Devuelve la lectura aproximada en español del texto neerlandés."""
        if not dutch_text:
            return ""

        return " ".join(self._transcribe_word(word) for word in dutch_text.split())

    def _transcribe_word(self, word: str) -> str:
        """Transcribe una palabra preservando si empezaba en mayúscula."""
        is_capitalized = word[:1].isupper()
        text = word.lower()

        transcribed_chars: list[str] = []
        index = 0
        text_length = len(text)
        while index < text_length:
            matched_rule = False
            for dutch_grapheme, spanish_grapheme in self._RULES:
                if text.startswith(dutch_grapheme, index):
                    transcribed_chars.append(spanish_grapheme)
                    index += len(dutch_grapheme)
                    matched_rule = True
                    break
            if not matched_rule:
                transcribed_chars.append(text[index])
                index += 1

        transcribed_word = "".join(transcribed_chars)
        return transcribed_word.capitalize() if is_capitalized else transcribed_word
