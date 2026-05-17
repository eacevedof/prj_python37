"""Repositorio para generar imágenes con OpenAI Images API (gpt-image-1.5)."""

from typing import final, Self

from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class GptImage1ReaderRepository(AbstractOpenAIApiRepository):
    """Repositorio para generación de imágenes usando gpt-image-1.5."""

    _instance: "GptImage1ReaderRepository | None" = None


    @classmethod
    def get_instance(cls) -> Self:
        """Retorna la instancia singleton."""
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_ai_image_by_word(
        self,
        word_es: str,
        context: str | None = None,
        size: str = "1024x1024",
    ) -> dict:
        """
        Genera una imagen para una palabra educativa usando gpt-image-1.5.
        El prompt se construye internamente y está oculto.

        Args:
            word_es: Palabra, frase u oración en español
            size: Tamaño (256x256, 512x512, 1024x1024)

        Returns:
            dict con estructura:
            {
                "b64_json": str,      # Imagen en base64
                "prompt_used": str    # Prompt construido internamente
            }

        Raises:
            Exception: Si falla la generación
        """
        # Construir prompt internamente (oculto para el caller)
        image_prompt = self.__get_image_prompt(
            word_es=word_es,
            context=context,
        )

        # Generar imagen con gpt-image-1.5
        return self.__send_prompt_to_open_ai(
            image_prompt=image_prompt,
            size=size,
        )

    def __get_image_prompt(
        self,
        word_es: str,
        context: str | None = None,
    ) -> str:
        """
        Construye prompt para generar imagen educativa estilo cartoon.
        Método privado - los prompts están ocultos.

        Args:
            word_es: Palabra, frase u oración en español
            context: Información adicional (tags, notas) para mejor contexto

        Returns:
            Prompt optimizado para generación de imágenes
        """
        # Usar estilo default
        img_style_prompt = self.__get_image_prompt_style()
        # Construir prompt descriptivo SIN incluir texto en la imagen
        base_prompt = f"A cute cartoon illustration of a {word_es}"

        # Agregar contexto si existe (tags y notas)
        if context:
            base_prompt += f" ({context})"

        return f"{base_prompt}. {img_style_prompt}"


    def __get_image_prompt_style(self) -> str:
        """
        Retorna el estilo por defecto: kawaii/cartoon educativo.
        Método privado - el estilo está oculto.

        Returns:
            Descripción de estilo optimizada para imágenes educativas
        """
        return (
            "Kawaii style, flat colors, minimalist, educational, "
            "clean white background, vector art style, "
            "friendly and approachable, "
            "NO TEXT, NO WORDS, NO LETTERS in the image, "
            "only visual representation, "
            "DO NOT add faces, eyes or expressions to inanimate objects or body parts, "
            "NO anthropomorphization, keep objects realistic in their nature, "
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
                "b64_json": str,      # Imagen en base64
                "prompt_used": str    # Prompt usado
            }

        Raises:
            Exception: Si falla la generación

        {
            "created": 1778866934,
            "background": "opaque",
            "data": [
                {
                    "b64_json": "image-inb64-json...hFuUDyje2tdlgAAAABJRU5ErkJggg=="
                }
            ],
            "output_format": "png",
            "quality": "high",
            "size": "1024x1024",
            "usage": {
                "input_tokens": 12,
                "input_tokens_details": {
                    "image_tokens": 0,
                    "text_tokens": 12
                },
                "output_tokens": 4501,
                "output_tokens_details": {
                    "image_tokens": 4160,
                    "text_tokens": 341
                },
                "total_tokens": 4513
            }
        }
        """
        open_ai_response = self._open_ai_client.images.generate(
            model="gpt-image-1.5",
            prompt=image_prompt,
            n=1,
            size=size,
            quality="low"
        )

        image_b64 = open_ai_response.data[0].b64_json if open_ai_response.data else ""
        if not image_b64:
            OpenAIException.unexpected_custom(
                "GptImage1ReaderRepository: No se recibió b64 en imagen en la respuesta de OpenAI"
            )

        return {
            "b64_json": image_b64,
            "prompt_used": image_prompt,
        }


