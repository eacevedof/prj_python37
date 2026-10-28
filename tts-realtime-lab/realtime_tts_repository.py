"""TTS con la Realtime API (gpt-realtime-2.1-mini): sustituto de audio.speech.

Misma firma que GptTts1ReaderApiRepository.get_audio_bytes_from_text de learn-langs
para que, si el laboratorio sale bien, el port sea cambiar la clase y poco más.

Diferencias con audio.speech que hay que tener presentes:
- Es un modelo CONVERSACIONAL: si no se le ata corto, puede "contestar" al texto
  en vez de leerlo. Por eso las instrucciones de sistema le obligan a leer literal
  y se devuelve también la transcripción, para comprobar que leyó lo que debía.
- Solo devuelve PCM 16-bit mono 24 kHz (o G.711): el mp3 se codifica aquí.
- 'speed' e 'instructions' ya NO son excluyentes: van los dos en la sesión.
- ⚠️ Va con AsyncOpenAI a propósito: el cliente WebSocket SÍNCRONO
  (websockets.sync, el de OpenAI().realtime.connect) muere en el handshake en
  Windows ("did not receive a valid HTTP response"); el asyncio conecta bien.
"""

import asyncio
import base64
import time
from dataclasses import dataclass
from typing import Any, final

from openai import AsyncOpenAI

from audio_encoder import AudioEncoder

_READ_VERBATIM = (
    "You are a text-to-speech engine, not an assistant. "
    "Read the user's text aloud EXACTLY as written, word for word, in the language "
    "it is written in. Do not answer it, translate it, explain it, greet, or add or "
    "omit any word. If the text is a question, read the question; do not answer it. "
    "Output nothing but the spoken text."
)


@dataclass(frozen=True)
class RealtimeTtsResult:
    audio_bytes: bytes
    transcript: str
    elapsed_s: float
    usage: dict[str, Any]


@final
class RealtimeTtsRepository:
    """Genera audio leyendo un texto con un modelo de la Realtime API."""

    def __init__(self, client: AsyncOpenAI) -> None:
        self._client = client

    def get_audio_bytes_from_text(
        self,
        model: str,
        voice: str,
        input_text: str,
        speed: float,
        response_format: str,
        instructions: str = "",
    ) -> bytes:
        """Equivalente directo al método de learn-langs: solo los bytes.

        asyncio.run NO vale dentro de un loop ya en marcha (Flet): allí habrá que
        llamar a synthesize_async con await o desde un hilo.
        """
        result = asyncio.run(
            self.synthesize_async(model, voice, input_text, speed, response_format, instructions)
        )
        return result.audio_bytes

    async def synthesize_async(
        self,
        model: str,
        voice: str,
        input_text: str,
        speed: float,
        response_format: str,
        instructions: str = "",
    ) -> RealtimeTtsResult:
        system_prompt = _READ_VERBATIM
        if instructions:
            system_prompt += f"\n\nAccent and style: {instructions}"

        pcm_chunks: list[bytes] = []
        transcript_parts: list[str] = []
        usage: dict[str, Any] = {}
        started = time.monotonic()

        async with self._client.realtime.connect(model=model) as connection:
            # Sin VAD ni turnos: la sesión solo existe para una respuesta.
            await connection.session.update(
                session={
                    "type": "realtime",
                    "output_modalities": ["audio"],
                    "instructions": system_prompt,
                    "audio": {
                        "input": {"turn_detection": None},
                        "output": {
                            "format": {"type": "audio/pcm", "rate": 24000},
                            "voice": voice,
                            "speed": speed,
                        },
                    },
                }
            )
            await connection.response.create(
                response={
                    "conversation": "none",
                    "output_modalities": ["audio"],
                    "input": [
                        {
                            "type": "message",
                            "role": "user",
                            "content": [{"type": "input_text", "text": input_text}],
                        }
                    ],
                }
            )

            async for event in connection:
                if event.type == "response.output_audio.delta":
                    pcm_chunks.append(base64.b64decode(event.delta))
                elif event.type == "response.output_audio_transcript.delta":
                    transcript_parts.append(event.delta)
                elif event.type == "error":
                    raise RuntimeError(f"Realtime error: {event.error.message}")
                elif event.type == "response.done":
                    status = event.response.status
                    if event.response.usage is not None:
                        usage = event.response.usage.model_dump()
                    if status != "completed":
                        raise RuntimeError(
                            f"Realtime response {status}: {event.response.status_details}"
                        )
                    break

        pcm = b"".join(pcm_chunks)
        if not pcm:
            raise RuntimeError("RealtimeTtsRepository: no audio data received")

        return RealtimeTtsResult(
            audio_bytes=AudioEncoder.encode(pcm, response_format),
            transcript="".join(transcript_parts),
            elapsed_s=time.monotonic() - started,
            usage=usage,
        )
