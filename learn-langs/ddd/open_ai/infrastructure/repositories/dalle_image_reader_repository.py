"""Repositorio para generar imágenes con OpenAI Extended Inference."""

import base64
from typing import final, Self

from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class DalleImageReaderRepository(AbstractOpenAIApiRepository):
    """Repositorio para generación de imágenes usando OpenAI Extended Inference."""

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
    ) -> dict:
        """
        Genera una imagen para una palabra educativa usando Extended Inference.
        El prompt se construye internamente y está oculto.

        Args:
            word_es: Palabra, frase u oración en español
            word_lang: Traducción en idioma destino

        Returns:
            dict con estructura:
            {
                "image_base64": str,  # Imagen en base64
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

        # Generar imagen con Extended Inference
        return self.__send_prompt_to_open_ai(image_prompt=image_prompt)

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
        return f"Generate an image of: {word_lang} ({word_es}). {style}"

    def __get_default_image_style(self) -> str:
        """
        Retorna el estilo por defecto: kawaii/cartoon educativo.
        Método privado - el estilo está oculto.

        Returns:
            Descripción de estilo optimizada para imágenes educativas
        """
        return (
            "Style: Simple cute cartoon illustration, kawaii style, "
            "flat colors, minimalist, educational, "
            "clean white background, vector art style, "
            "friendly and approachable, "
            "perfect for language learning flashcards"
        )

    def __send_prompt_to_open_ai(self, image_prompt: str) -> dict:
        """
        Genera una imagen usando OpenAI Extended Inference (responses.create).

        Args:
            image_prompt: Descripción de la imagen a generar

        Returns:
            dict con estructura:
            {
                "image_base64": str,  # Imagen en base64
                "prompt_used": str    # Prompt usado
            }

        Raises:
            Exception: Si falla la generación
        """
        try:
            # Llamar a Extended Inference con herramienta de image_generation
            response = self._client.responses.create(
                model="gpt-4.1-mini",
                input=image_prompt,
                tools=[{"type": "image_generation"}],
            )

            # Extraer datos de imagen desde la respuesta
            image_data = [
                output.result
                for output in response.output
                if output.type == "image_generation_call"
            ]

            if not image_data:
                raise Exception("No se generó ninguna imagen en la respuesta")

            image_base64 = image_data[0]

            self._log_openai_success(
                "extended_inference_image_generation",
                {
                    "model": "gpt-4.1-mini",
                    "prompt": image_prompt[:200],
                    "image_size_bytes": len(image_base64),
                },
            )

            return {
                "image_base64": image_base64,
                "prompt_used": image_prompt,
            }

        except Exception as e:
            error_msg = f"Error en Extended Inference: {str(e)}"
            self._log_openai_error(error_msg, {
                "prompt": image_prompt,
                "error": str(e),
            })
            raise Exception(error_msg)
