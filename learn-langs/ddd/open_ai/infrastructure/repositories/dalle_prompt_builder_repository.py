"""Repositorio para construcción de prompts optimizados para DALL-E."""

from typing import final, Self

from ddd.open_ai.infrastructure.repositories.abstract_prompt_builder_repository import AbstractPromptBuilderRepository


@final
class DallePromptBuilderRepository(AbstractPromptBuilderRepository):
    """Construye prompts optimizados para DALL-E con estilo educativo cartoon."""

    _instance: "DallePromptBuilderRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        """Retorna la instancia singleton."""
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_image_prompt(
        self,
        word_es: str,
        word_lang: str,
        lang_code: str,
        context: str | None = None,
        style_override: str | None = None,
    ) -> str:
        """
        Construye prompt para generar imagen educativa estilo cartoon.

        Args:
            word_es: Palabra en español
            word_lang: Traducción en idioma destino
            lang_code: Código del idioma
            context: Contexto adicional (opcional)
            style_override: Override del estilo (opcional)

        Returns:
            Prompt optimizado para DALL-E 3
        """
        # Usar estilo custom o el default
        style = style_override or self.get_default_style()

        # Construir prompt base
        if context:
            prompt = f"{word_lang} ({word_es}): {context}. {style}"
        else:
            prompt = f"{word_lang} ({word_es}). {style}"

        return prompt

    def get_default_style(self) -> str:
        """
        Retorna el estilo por defecto: kawaii/cartoon educativo.

        Returns:
            Descripción de estilo optimizada para imágenes educativas
        """
        return (
            "Simple cute cartoon illustration, kawaii style, "
            "flat colors, minimalist, educational, "
            "clean white background, vector art style, "
            "friendly and approachable, "
            "perfect for language learning flashcards"
        )
