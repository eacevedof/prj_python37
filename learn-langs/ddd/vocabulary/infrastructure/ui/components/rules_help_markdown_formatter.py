"""Componente: convierte el texto de `rules_help` en markdown para el modal de ayuda."""

import re
import unicodedata
from typing import Self

from ddd.vocabulary.infrastructure.ui.enums.rules_help_block_enum import (
    RulesHelpBlockEnum,
)
from ddd.vocabulary.infrastructure.ui.enums.rules_help_markdown_enum import (
    RulesHelpMarkdownEnum,
)
from ddd.vocabulary.infrastructure.ui.enums.rules_help_marker_enum import (
    RulesHelpMarkerEnum,
)

# (tipo de bloque, texto markdown)
_Block = tuple[RulesHelpBlockEnum, str]


class RulesHelpMarkdownFormatter:
    """
    Traduce a markdown la ayuda gramatical de una palabra.

    Las tarjetas ya escritas guardan la ayuda como TEXTO PLANO con una
    estructura implícita muy regular:

        <regla principal>                      <- primer párrafo, lo importante
        📐 Estructura: sujeto + werd + ...     <- sección encabezada por emoji
        OTROS «poner» que NO son zetten:       <- subsección (acaba en dos puntos)
        • zetten = poner de pie                <- ítem de lista
        ⚠️ No lo mezcles con opstaan...        <- aviso

    Esa estructura se traduce a markdown (encabezados, listas, citas) para que
    `ft.Markdown` la pinte jerarquizada en vez de un muro de líneas apiladas. Si
    la ayuda YA viene escrita en markdown (encabezados `#`, tablas...) se respeta
    tal cual: así las tarjetas nuevas se pueden redactar directamente en markdown.

    NO decide qué se ve: solo transforma texto. El estilo vive en
    `RulesHelpDialogComp`.
    """

    # Un solo `_` ya es cursiva en markdown y los ejercicios están llenos de
    # huecos («Ik ___ wakker»), así que se escapan antes de nada.
    _ESCAPE_PATTERN = re.compile(r"([_*])")

    # La ayuda ya viene en markdown: encabezado ATX o tabla al inicio de línea
    _MARKDOWN_PATTERN = re.compile(r"^\s*(#{1,4}\s|\|)", re.MULTILINE)

    _BULLET_PATTERN = re.compile(r"^[•‣▪·]+\s*|^[-*]\s+")
    _ORDERED_PATTERN = re.compile(r"^(\d{1,2})[)\.]\s+(.*)$")

    # «Regla: ...», «Truco mental: ...» → el rótulo en negrita para poder saltar
    # de uno a otro sin leer.
    _LABEL_PATTERN = re.compile(r"^([A-ZÁÉÍÓÚÑ¿][^:]{2,34}):\s+(?=\S)")

    # Definiciones dentro de un ítem: «zetten = poner de pie» / «neerzetten — dejar»
    _DEFINITION_PATTERN = re.compile(r"^([^=—:]{2,40}?)\s*([=—])\s+(.*)$", re.DOTALL)

    _EMOJI_CATEGORY: str = RulesHelpMarkerEnum.EMOJI_CATEGORY.value
    _CALLOUT_EMOJIS: tuple[str, ...] = (
        RulesHelpMarkerEnum.CALLOUT_WARNING.value,
        RulesHelpMarkerEnum.CALLOUT_POINTER.value,
        RulesHelpMarkerEnum.CALLOUT_IDEA.value,
        RulesHelpMarkerEnum.CALLOUT_ALERT.value,
        RulesHelpMarkerEnum.CALLOUT_SIREN.value,
    )
    _HEADING_MAX_LENGTH: int = RulesHelpMarkdownEnum.HEADING_MAX_LENGTH.value
    _LABEL_MAX_WORDS: int = RulesHelpMarkdownEnum.LABEL_MAX_WORDS.value

    @classmethod
    def get_instance(cls) -> Self:
        """Factoría — devuelve una instancia nueva."""
        return cls()

    def get_rules_help_as_markdown(self, rules_help: str) -> str:
        """Devuelve la ayuda lista para `ft.Markdown` (cadena vacía si no hay)."""
        rules_text = (rules_help or "").strip()
        if not rules_text:
            return ""

        if self._MARKDOWN_PATTERN.search(rules_text):
            return rules_text

        blocks: list[_Block] = []
        is_first_block = True
        for raw_line in rules_text.splitlines():
            line = self._get_escaped(raw_line.strip())
            if not line:
                blocks.append((RulesHelpBlockEnum.BLANK, ""))
                continue

            blocks.extend(self._get_line_blocks(line, is_first_block))
            is_first_block = False

        return self._get_joined(blocks)

    def _get_line_blocks(self, line: str, is_first_block: bool) -> list[_Block]:
        """Traduce una línea de texto plano a uno o más bloques markdown."""
        if self._is_section_line(line):
            return self._get_section_blocks(line)

        if self._BULLET_PATTERN.match(line):
            return [(RulesHelpBlockEnum.ITEM, self._get_list_item(line))]

        ordered_match = self._ORDERED_PATTERN.match(line)
        if ordered_match:
            ordered_item = (
                f"{ordered_match.group(1)}. {self._get_emphasized(ordered_match.group(2))}"
            )
            return [(RulesHelpBlockEnum.ITEM, ordered_item)]

        if is_first_block:
            # La regla de la tarjeta: destacada como cita, es lo que hay que leer
            return [(RulesHelpBlockEnum.QUOTE, f"> {self._get_emphasized(line)}")]

        if self._is_subsection_line(line):
            return [(RulesHelpBlockEnum.HEADING, f"#### {line[:-1].rstrip()}")]

        return [(RulesHelpBlockEnum.PARAGRAPH, self._get_emphasized(line))]

    def _get_section_blocks(self, line: str) -> list[_Block]:
        """Convierte una línea encabezada por emoji en encabezado, cita o párrafo."""
        if line.startswith(self._CALLOUT_EMOJIS) and not line.endswith(":"):
            return [(RulesHelpBlockEnum.QUOTE, f"> {self._get_emphasized(line)}")]

        if line.endswith(":"):
            return [(RulesHelpBlockEnum.HEADING, f"### {line[:-1].rstrip()}")]

        heading, separator, rest = line.partition(":")
        if separator and len(heading) <= self._HEADING_MAX_LENGTH and rest.strip():
            return [
                (RulesHelpBlockEnum.HEADING, f"### {heading.rstrip()}"),
                (RulesHelpBlockEnum.PARAGRAPH, rest.strip()),
            ]

        if len(line) <= self._HEADING_MAX_LENGTH:
            return [(RulesHelpBlockEnum.HEADING, f"### {line}")]

        return [(RulesHelpBlockEnum.PARAGRAPH, self._get_emphasized(line))]

    def _get_joined(self, blocks: list[_Block]) -> str:
        """Une los bloques separando con línea en blanco los de distinto tipo."""
        lines: list[str] = []
        previous_kind = RulesHelpBlockEnum.BLANK
        for block_kind, block_text in blocks:
            if self._has_to_separate(previous_kind, block_kind):
                lines.append("")
            lines.append(block_text)
            previous_kind = block_kind
        return "\n".join(lines).strip()

    def _has_to_separate(
        self, previous_kind: RulesHelpBlockEnum, block_kind: RulesHelpBlockEnum
    ) -> bool:
        """True si hay que meter línea en blanco entre dos bloques consecutivos.

        Sin ella markdown se «come» el párrafo que sigue a una lista (lo trata
        como continuación del último ítem) y el encabezado deja de serlo.
        """
        if RulesHelpBlockEnum.BLANK in (previous_kind, block_kind):
            return False
        return block_kind != previous_kind or block_kind == RulesHelpBlockEnum.HEADING

    def _get_escaped(self, line: str) -> str:
        """Neutraliza los caracteres que markdown interpretaría (`_`, `*`)."""
        return self._ESCAPE_PATTERN.sub(r"\\\1", line)

    def _is_section_line(self, line: str) -> bool:
        """True si la línea empieza por un emoji (📐, 🧭, ⚠️...) → es una sección."""
        return bool(line) and unicodedata.category(line[0]) == self._EMOJI_CATEGORY

    def _is_subsection_line(self, line: str) -> bool:
        """True si la línea es un rótulo que presenta lo que viene después («...:»)."""
        return line.endswith(":") and len(line) <= self._HEADING_MAX_LENGTH

    def _get_list_item(self, line: str) -> str:
        """Convierte un ítem (`•`, `-`) en ítem markdown con el término en negrita."""
        item_text = self._BULLET_PATTERN.sub("", line, count=1).strip()
        definition_match = self._DEFINITION_PATTERN.match(item_text)
        if not definition_match:
            return f"- {self._get_emphasized(item_text)}"

        term, symbol, meaning = definition_match.groups()
        return f"- **{term.strip()}** {symbol} {meaning.strip()}"

    def _get_emphasized(self, line: str) -> str:
        """Pone en negrita el rótulo inicial («Regla:», «Truco mental:»...)."""
        label_match = self._LABEL_PATTERN.match(line)
        if not label_match or len(label_match.group(1).split()) > self._LABEL_MAX_WORDS:
            return line
        return f"**{label_match.group(1)}:** {line[label_match.end():]}"
