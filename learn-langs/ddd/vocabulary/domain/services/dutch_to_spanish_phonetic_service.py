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
        ("ui", "eu"),  # /œy/ NO es "au": ese es el de "ou". muis -> meus
        ("ou", "au"),
        ("au", "au"),
        ("eu", "e"),
        ("ng", "ng"),  # antes que la "g": es /ŋ/, honger -> honger y no "onjer"
        # Letras sueltas
        ("g", "j"),   # g neerlandesa (gutural) ~ jota española
        ("v", "f"),
        ("w", "u"),
        ("z", "s"),
        ("j", "y"),   # j neerlandesa ~ y española
    )

    # La h neerlandesa SÍ se pronuncia (aspirada suave), al revés que la española.
    # Solo se desvanece en las átonas de dentro de la frase, y la sistemática es "het".
    _UNSTRESSED_WORDS: dict[str, str] = {"het": "et"}

    # Toda oclusiva final se ensordece: heb -> hep, hond -> hont, goed -> jut.
    _FINAL_DEVOICING: dict[str, str] = {"b": "p", "d": "t"}

    # Puntuación que puede cerrar una palabra y no debe estorbar al ensordecimiento.
    _TRAILING_PUNCTUATION: str = ".,;:!?)»\"'"

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def transcribe(self, dutch_text: str) -> str:
        """Devuelve la lectura aproximada en español del texto neerlandés."""
        if not dutch_text:
            return ""

        return " ".join(self._transcribe_word(word) for word in dutch_text.split())

    def _transcribe_word(self, word: str) -> str:
        """Transcribe una palabra preservando si empezaba en mayúscula.

        La puntuación se aparta antes de transcribir para que el ensordecimiento
        final mire la última letra de verdad («goed.» sigue siendo «jut.»).
        """
        is_capitalized = word[:1].isupper()
        core, punctuation = self._get_core_and_punctuation(word.lower())

        if core in self._UNSTRESSED_WORDS:
            transcribed_core = self._UNSTRESSED_WORDS[core]
        else:
            transcribed_core = self._get_devoiced(self._get_mapped(core))

        transcribed_word = transcribed_core + punctuation
        return transcribed_word.capitalize() if is_capitalized else transcribed_word

    def _get_core_and_punctuation(self, word: str) -> tuple[str, str]:
        """Parte la palabra en su núcleo alfabético y la puntuación que la cierra."""
        core = word.rstrip(self._TRAILING_PUNCTUATION)
        return core, word[len(core):]

    def _get_mapped(self, text: str) -> str:
        """Aplica las reglas de grafía en una sola pasada de izquierda a derecha."""
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

        return "".join(transcribed_chars)

    def _get_devoiced(self, text: str) -> str:
        """Ensordece la oclusiva final, que en neerlandés es sistemático."""
        if not text:
            return text
        return text[:-1] + self._FINAL_DEVOICING.get(text[-1], text[-1])
