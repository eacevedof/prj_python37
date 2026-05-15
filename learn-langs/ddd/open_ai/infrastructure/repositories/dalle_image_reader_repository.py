"""Repositorio para generar imágenes con OpenAI Images API (gpt-image-1.5)."""

from typing import final, Self

from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class DalleImageReaderRepository(AbstractOpenAIApiRepository):
    """Repositorio para generación de imágenes usando gpt-image-1.5."""

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
        size: str = "1024x1024",
    ) -> dict:
        """
        Genera una imagen para una palabra educativa usando gpt-image-1.5.
        El prompt se construye internamente y está oculto.

        Args:
            word_es: Palabra, frase u oración en español
            word_lang: Traducción en idioma destino
            size: Tamaño (256x256, 512x512, 1024x1024)

        Returns:
            dict con estructura:
            {
                "url": str,           # URL temporal de la imagen generada
                "prompt_used": str    # Prompt construido internamente
            }

        Raises:
            Exception: Si falla la generación
        """
        # Construir prompt internamente (oculto para el caller)
        image_prompt = self.__get_image_prompt(
            word_es=word_es,
            word_lang=word_lang,
        )

        # Generar imagen con gpt-image-1.5
        return self.__send_prompt_to_open_ai(
            image_prompt=image_prompt,
            size=size,
        )

    def __get_image_prompt(
        self,
        word_es: str,
        word_lang: str,
    ) -> str:
        """
        Construye prompt para generar imagen educativa estilo cartoon.
        Método privado - los prompts están ocultos.

        Args:
            word_es: Palabra, frase u oración en español
            word_lang: Traducción en idioma destino

        Returns:
            Prompt optimizado para generación de imágenes
        """
        # Usar estilo default
        style = self.__get_default_image_style()

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
        size: str = "1024x1024",
    ) -> dict:
        """
        Genera una imagen usando gpt-image-1.5.

        Args:
            image_prompt: Descripción de la imagen a generar
            size: Tamaño (256x256, 512x512, 1024x1024)

        Returns:
            dict con estructura:
            {
                "url": str,           # URL temporal de la imagen generada
                "prompt_used": str    # Prompt usado
            }

        Raises:
            Exception: Si falla la generación
        """

        # Llamar a OpenAI Images API con gpt-image-1.5
        open_ai_response = self._open_ai_client.images.generate(
            model="gpt-image-1.5",
            prompt=image_prompt,
            n=1,
            size=size,
            quality="low"
        )

        # Extraer URL de la imagen generada
        image_url = open_ai_response.data[0].url if open_ai_response.data else ""

        if not image_url:
            raise Exception("No se generó ninguna imagen en la respuesta")

        return {
            "url": image_url,
            "prompt_used": image_prompt,
        }


