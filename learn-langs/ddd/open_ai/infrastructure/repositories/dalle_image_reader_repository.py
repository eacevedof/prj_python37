"""Repositorio para generar imágenes con DALL-E API."""

from typing import final, Self

from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class DalleImageReaderRepository(AbstractOpenAIApiRepository):
    """Repositorio para comunicación con DALL-E API."""

    _instance: "DalleImageReaderRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        """Retorna la instancia singleton."""
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_ai_image_by_word(
        self,
        word_es: str,
        word_lang: str,
        size: str = "512x512",
    ) -> dict:
        """
        Genera una imagen para una palabra educativa.
        El prompt se construye internamente y está oculto.

        Args:
            word_es: Palabra, frase u oración en español
            word_lang: Traducción en idioma destino
            size: Tamaño para DALL-E 2 (256x256, 512x512, 1024x1024)

        Returns:
            dict con estructura:
            {
                "url": str,  # URL temporal de la imagen generada
                "revised_prompt": str  # Prompt revisado por DALL-E
            }

        Raises:
            Exception: Si falla la generación
        """
        # Construir prompt internamente (oculto para el caller)
        image_prompt = self.__get_image_prompt(
            word_es=word_es,
            word_lang=word_lang,
            style_override=None,
        )

        # Generar imagen con el prompt construido
        return self.__send_prompt_to_open_ai(
            image_prompt=image_prompt,
            size=size,
        )

    def __get_image_prompt(
        self,
        word_es: str,
        word_lang: str,
        style_override: str | None = None,
    ) -> str:
        """
        Construye prompt para generar imagen educativa estilo cartoon.
        Método privado - los prompts están ocultos.

        Args:
            word_es: Palabra, frase u oración en español
            word_lang: Traducción en idioma destino
            style_override: Override del estilo (opcional)

        Returns:
            Prompt optimizado para DALL-E 3
        """
        # Usar estilo custom o el default
        style = style_override or self.__get_default_image_style()

        # Construir prompt simple
        return f"{word_lang} ({word_es}). {style}"


    def __get_default_image_style(self) -> str:
        """
        Retorna el estilo por defecto: kawaii/cartoon educativo.
        Método privado - el estilo está oculto.

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

    def __send_prompt_to_open_ai(
        self,
        image_prompt: str,
        size: str = "512x512",
    ) -> dict:
        """
        Genera una imagen usando DALL-E 2.

        Args:
            image_prompt: Descripción de la imagen a generar
            size: Tamaño (256x256, 512x512, 1024x1024)

        Returns:
            dict con estructura:
            {
                "url": str,  # URL temporal de la imagen generada
                "revised_prompt": str  # Prompt revisado (solo en DALL-E 3)
            }

        Raises:
            Exception: Si falla la generación
        """
        open_ai_response = self._post_http_request(
            "images/generations",
            {
                "model": "dall-e-2",
                "prompt": image_prompt,
                "n": 1,
                "size": size,
            }
        )

        # Extraer datos relevantes de la respuesta
        image_data = open_ai_response.get("data", [{}])[0]
        return {
            "url": image_data.get("url", ""),
            "revised_prompt": image_data.get("revised_prompt", image_prompt),
        }
