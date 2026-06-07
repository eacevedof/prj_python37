"""Repositorio para generar audio (TTS) con OpenAI Audio API (tts-1)."""

import base64
from typing import final, Self

from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class GptTts1ReaderApiRepository(AbstractOpenAIApiRepository):
    """Repositorio para generación de audio/pronunciación usando tts-1."""

    _instance: "GptTts1ReaderApiRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        """Retorna la instancia singleton."""
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_audio_bytes_from_text(
        self,
        model: str,
        voice: str,
        input_text: str,
        speed: float,
        response_format: str,
    ) -> bytes:
        """
        Generates audio using OpenAI Audio API.

        Args:
            model: Text-to-speech model (tts-1, tts-1-hd)
            voice: Voice (alloy, echo, fable, onyx, nova, shimmer)
            input_text: Text to convert
            speed: Speed (0.25 to 4.0)
            response_format: Format (mp3, opus, aac, flac, wav, pcm)

        Returns:
            bytes: Audio in bytes format

        Raises:
            OpenAIException: If generation fails
        """
        audio_response = self._open_ai_client.audio.speech.create(
            model=model,
            voice=voice,
            input=input_text,
            speed=speed,
            response_format=response_format,
        )

        audio_bytes = audio_response.content
        if not audio_bytes:
            OpenAIException.unexpected_custom(
                "GptTts1ReaderApiRepository: No audio data received from OpenAI API"
            )

        return audio_bytes

    def get_audio_pronunciation_by_text(
        self,
        text: str,
        lang_code: str = "nl_NL",
        voice: str | None = None,
        speed: float = 1.0,
    ) -> dict:
        """
        Genera audio MP3 con pronunciación nativa para un texto usando tts-1.

        Args:
            text: Texto a convertir en audio
            lang_code: Código de idioma (nl_NL, en_US, de_DE, fr_FR, etc.)
            voice: Voz específica (alloy, echo, fable, onyx, nova, shimmer).
                   Si es None, se selecciona automáticamente por idioma.
            speed: Velocidad del audio (0.25 a 4.0, default 1.0)

        Returns:
            dict con estructura:
            {
                "audio_b64": str,        # Audio MP3 en base64
                "mime_type": str,        # "audio/mpeg"
                "voice_used": str,       # Voz utilizada
                "text": str,             # Texto original
                "lang_code": str,        # Código de idioma
                "model": str,            # "tts-1"
            }

        Raises:
            OpenAIException: Si falla la generación
        """
        # Validar texto
        if not text or not text.strip():
            raise OpenAIException.unexpected_custom(
                "GptTts1ReaderRepository: El texto no puede estar vacío"
            )

        # Seleccionar voz automáticamente si no se especifica
        selected_voice = voice or self.__get_voice_by_lang(lang_code)

        # Validar velocidad
        if not 0.25 <= speed <= 4.0:
            speed = 1.0

        # Generar audio con tts-1
        return self.__send_text_to_open_ai(
            text=text.strip(),
            voice=selected_voice,
            speed=speed,
            lang_code=lang_code,
        )

    def __get_voice_by_lang(self, lang_code: str) -> str:
        """
        Selecciona la mejor voz según el idioma.
        Método privado - mapeo de voces oculto.

        Voces disponibles:
        - alloy: Neutral, versátil
        - echo: Masculina, clara
        - fable: Británica, expresiva
        - onyx: Masculina, profunda
        - nova: Femenina, energética
        - shimmer: Femenina, suave

        Args:
            lang_code: Código de idioma (nl_NL, en_US, etc.)

        Returns:
            Nombre de la voz optimizada para ese idioma
        """
        # Mapeo de idiomas a voces
        voice_map = {
            "nl_NL": "nova",      # Holandés: voz femenina clara
            "nl_BE": "nova",      # Flamenco: voz femenina clara
            "en_US": "alloy",     # Inglés US: neutral versátil
            "en_GB": "fable",     # Inglés UK: británica expresiva
            "de_DE": "echo",      # Alemán: masculina clara
            "fr_FR": "shimmer",   # Francés: femenina suave
            "pt_BR": "nova",      # Portugués: femenina energética
            "it_IT": "shimmer",   # Italiano: femenina suave
            "es_ES": "alloy",     # Español: neutral versátil
        }

        return voice_map.get(lang_code, "alloy")

    def __send_text_to_open_ai(
        self,
        text: str,
        voice: str,
        speed: float,
        lang_code: str,
    ) -> dict:
        """
        Genera audio usando tts-1.

        Args:
            text: Texto a convertir
            voice: Voz a usar
            speed: Velocidad del audio
            lang_code: Código de idioma

        Returns:
            dict con estructura:
            {
                "audio_b64": str,
                "mime_type": str,
                "voice_used": str,
                "text": str,
                "lang_code": str,
                "model": str,
            }

        Raises:
            OpenAIException: Si falla la generación
        """
        try:
            # Generar audio con OpenAI API
            response = self._open_ai_client.audio.speech.create(
                model="tts-1",  # tts-1 es más rápido, tts-1-hd es más calidad
                voice=voice,
                input=text,
                speed=speed,
                response_format="mp3",
            )

            # Convertir bytes a base64
            audio_bytes = response.content
            if not audio_bytes:
                raise OpenAIException.unexpected_custom(
                    "GptTts1ReaderRepository: No se recibió audio en la respuesta de OpenAI"
                )

            audio_b64 = base64.b64encode(audio_bytes).decode("utf-8")

            return {
                "audio_b64": audio_b64,
                "mime_type": "audio/mpeg",
                "voice_used": voice,
                "text": text,
                "lang_code": lang_code,
                "model": "tts-1",
            }

        except Exception as e:
            raise OpenAIException.unexpected_custom(
                f"GptTts1ReaderRepository: Error al generar audio: {str(e)}"
            )
