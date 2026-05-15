"""Repositorio para generar imágenes con DALL-E API."""

from typing import final, Self

from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class DalleImageGeneratorRepository(AbstractOpenAIApiRepository):
    """Repositorio para comunicación con DALL-E API."""

    _instance: "DalleImageGeneratorRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        """Retorna la instancia singleton."""
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def generate_image_by_word(
        self,
        word_es: str,
        word_lang: str,
        context: str | None = None,
        size: str = "1024x1024",
        quality: str = "standard",
        style: str = "vivid",
    ) -> dict:
        """
        Genera una imagen para una palabra educativa.
        El prompt se construye internamente y está oculto.

        Args:
            word_es: Palabra en español
            word_lang: Traducción en idioma destino
            context: Contexto o frase ejemplo (opcional)
            size: Tamaño (1024x1024, 1792x1024, 1024x1792)
            quality: Calidad (standard, hd)
            style: Estilo (vivid, natural)

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
            context=context,
            style_override=None,
        )

        # Generar imagen con el prompt construido
        return self.__generate_image(
            prompt=image_prompt,
            size=size,
            quality=quality,
            style=style,
        )

    def __generate_image(
        self,
        prompt: str,
        size: str = "1024x1024",
        quality: str = "standard",
        style: str = "vivid",
    ) -> dict:
        """
        Genera una imagen usando DALL-E 3.

        Args:
            prompt: Descripción de la imagen a generar
            size: Tamaño (1024x1024, 1792x1024, 1024x1792)
            quality: Calidad (standard, hd)
            style: Estilo (vivid, natural)

        Returns:
            dict con estructura:
            {
                "url": str,  # URL temporal de la imagen generada
                "revised_prompt": str  # Prompt revisado por DALL-E
            }

        Raises:
            Exception: Si falla la generación
        """
        payload = {
            "model": "dall-e-3",
            "prompt": prompt,
            "n": 1,
            "size": size,
            "quality": quality,
            "style": style,
        }

        response = self._post_http_request("images/generations", payload)

        # Extraer datos relevantes de la respuesta
        image_data = response.get("data", [{}])[0]
        return {
            "url": image_data.get("url", ""),
            "revised_prompt": image_data.get("revised_prompt", prompt),
        }

    def __get_image_prompt(
        self,
        word_es: str,
        word_lang: str,
        lang_code: str,
        context: str | None = None,
        style_override: str | None = None,
    ) -> str:
        """
        Construye prompt para generar imagen educativa estilo cartoon.
        Método privado - los prompts están ocultos.

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
        style = style_override or self.__get_default_style()

        # Construir prompt base
        if context:
            prompt = f"{word_lang} ({word_es}): {context}. {style}"
        else:
            prompt = f"{word_lang} ({word_es}). {style}"

        return prompt

    def __get_default_style(self) -> str:
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

    def generate_variation(
        self,
        image_file_path: str,
        n: int = 1,
        size: str = "1024x1024",
    ) -> list[dict]:
        """
        Genera variaciones de una imagen existente.

        Args:
            image_file_path: Ruta al archivo de imagen
            n: Número de variaciones (1-10)
            size: Tamaño de las variaciones

        Returns:
            list[dict]: Lista de URLs de imágenes generadas

        Raises:
            Exception: Si falla la generación
        """
        # TODO: Implementar cuando se necesite
        # Requiere multipart/form-data para subir imagen
        raise NotImplementedError("Variaciones de imagen no implementadas aún")
