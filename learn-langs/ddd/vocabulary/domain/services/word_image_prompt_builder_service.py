from typing import Self, final

from ddd.vocabulary.domain.enums.word_image_prompt_enum import WordImagePromptEnum


@final
class WordImagePromptBuilderService:
    """Servicio de dominio: construye el prompt para la imagen educativa de una palabra."""

    _BASE_TEMPLATE: str = WordImagePromptEnum.BASE_TEMPLATE.value
    _CONTEXT_TEMPLATE: str = WordImagePromptEnum.CONTEXT_TEMPLATE.value
    _STYLE: str = WordImagePromptEnum.STYLE.value

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_prompt(self, word_es: str, context: str | None = None) -> str:
        """Devuelve el prompt cartoon educativo (sin texto en la imagen)."""
        base_prompt = self._BASE_TEMPLATE.format(word_es=word_es)
        if context:
            base_prompt += self._CONTEXT_TEMPLATE.format(context=context)
        return f"{base_prompt}. {self._STYLE}"
