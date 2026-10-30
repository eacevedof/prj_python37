import re
from typing import Self, final

from src.modules.voice_mod.application.get_speech_text.get_speech_text_dto import (
    GetSpeechTextDto,
)
from src.modules.voice_mod.application.get_speech_text.get_speech_text_result_dto import (
    GetSpeechTextResultDto,
)
from src.modules.voice_mod.domain.enums import VoiceResultKeyEnum

# Los patrones de línea usan `[ \t]*` y no `\s*`: con MULTILINE, `\s*` se come
# también los saltos de línea de antes y pega párrafos que iban separados.
_FENCED_CODE_PATTERN = re.compile(r"```.*?(?:```|$)", re.DOTALL)
_TABLE_LINE_PATTERN = re.compile(r"^[ \t]*\|.*$", re.MULTILINE)
_HORIZONTAL_RULE_PATTERN = re.compile(r"^[ \t]*(?:-{3,}|\*{3,}|_{3,})[ \t]*$", re.MULTILINE)
_HEADING_MARK_PATTERN = re.compile(r"^[ \t]*#{1,6}[ \t]+", re.MULTILINE)
_LIST_MARK_PATTERN = re.compile(r"^[ \t]*(?:[-*+]|\d+\.)[ \t]+(?:\[[ xX]\][ \t]+)?", re.MULTILINE)
_QUOTE_MARK_PATTERN = re.compile(r"^[ \t]*>[ \t]?", re.MULTILINE)
_LINK_PATTERN = re.compile(r"\[([^\]]+)\]\([^)]*\)")
_URL_PATTERN = re.compile(r"https?://\S+")
_INLINE_CODE_PATTERN = re.compile(r"`([^`]*)`")
_EMPHASIS_PATTERN = re.compile(r"\*\*|__|~~|\*")
_BLANK_LINES_PATTERN = re.compile(r"\n{3,}")
_SENTENCE_END_PATTERN = re.compile(r"[.!?:](?=\s)|\n")


@final
class GetSpeechTextService:
    """Caso de uso: convertir el markdown de una respuesta en texto para leer.

    Se quita lo que no se puede leer en alto (bloques de código, tablas, URL,
    marcas de formato) y se corta en el último final de frase antes del límite,
    para no dejar una palabra a medias.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, get_speech_text_dto: GetSpeechTextDto) -> GetSpeechTextResultDto:
        speech_text = self.__get_plain_text(get_speech_text_dto.text)
        speech_text = self.__get_truncated_text(speech_text, get_speech_text_dto.max_chars)
        return GetSpeechTextResultDto.from_primitives({VoiceResultKeyEnum.SPEECH_TEXT: speech_text})

    def __get_plain_text(self, markdown_text: str) -> str:
        plain_text = _FENCED_CODE_PATTERN.sub("", markdown_text)
        plain_text = _TABLE_LINE_PATTERN.sub("", plain_text)
        plain_text = _HORIZONTAL_RULE_PATTERN.sub("", plain_text)
        plain_text = _HEADING_MARK_PATTERN.sub("", plain_text)
        plain_text = _LIST_MARK_PATTERN.sub("", plain_text)
        plain_text = _QUOTE_MARK_PATTERN.sub("", plain_text)
        plain_text = _LINK_PATTERN.sub(r"\1", plain_text)
        plain_text = _URL_PATTERN.sub("", plain_text)
        plain_text = _INLINE_CODE_PATTERN.sub(r"\1", plain_text)
        plain_text = _EMPHASIS_PATTERN.sub("", plain_text)
        plain_text = "\n".join(text_line.strip() for text_line in plain_text.splitlines())
        return _BLANK_LINES_PATTERN.sub("\n\n", plain_text).strip()

    def __get_truncated_text(self, speech_text: str, max_chars: int) -> str:
        if len(speech_text) <= max_chars:
            return speech_text

        head_text = speech_text[:max_chars]
        sentence_ends = list(_SENTENCE_END_PATTERN.finditer(head_text))
        if sentence_ends:
            return head_text[: sentence_ends[-1].start() + 1].strip()

        return head_text.rsplit(" ", 1)[0].strip()
