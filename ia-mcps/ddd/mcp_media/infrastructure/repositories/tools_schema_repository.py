from typing import final, Self

from mcp.types import Tool

from ddd.mcp_media.domain.enums import ToolNameEnum


@final
class ToolsSchemaRepository:
    """Repository for Media MCP tool schemas."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all_media_tools(self) -> list[Tool]:
        return [
            self._get_create_image_schema(),
            self._get_create_audio_schema(),
        ]

    def _get_create_image_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.CREATE_IMAGE,
            description="generate an image from a text prompt using OpenAI and save it to disk",
            inputSchema={
                "type": "object",
                "properties": {
                    "prompt": {
                        "type": "string",
                        "description": "text description of the image to generate",
                    },
                    "model": {
                        "type": "string",
                        "description": "model to use (gpt-image-1.5, gpt-image-2, dall-e-3, dall-e-2)",
                        "default": "gpt-image-1.5",
                    },
                    "size": {
                        "type": "string",
                        "description": "image size (256x256, 512x512, 1024x1024, 1024x1792, 1792x1024)",
                        "default": "1024x1024",
                    },
                    "quality": {
                        "type": "string",
                        "description": "quality level (standard, hd) - only for dall-e-3",
                        "default": "standard",
                    },
                    "n": {
                        "type": "integer",
                        "description": "number of images to generate (1-10)",
                        "default": 1,
                    },
                    "filename": {
                        "type": "string",
                        "description": "optional filename (without extension). If not provided, auto-generated from prompt",
                    },
                },
                "required": ["prompt"],
            },
        )

    def _get_create_audio_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.CREATE_AUDIO,
            description="generate audio from text using OpenAI text-to-speech and save it to disk",
            inputSchema={
                "type": "object",
                "properties": {
                    "text": {
                        "type": "string",
                        "description": "text to convert to speech (max 4096 characters)",
                    },
                    "voice": {
                        "type": "string",
                        "description": "voice to use (alloy, echo, fable, onyx, nova, shimmer)",
                        "default": "alloy",
                    },
                    "model": {
                        "type": "string",
                        "description": "model to use (tts-1, tts-1-hd)",
                        "default": "tts-1",
                    },
                    "speed": {
                        "type": "number",
                        "description": "playback speed (0.25 to 4.0)",
                        "default": 1.0,
                    },
                    "response_format": {
                        "type": "string",
                        "description": "audio format (mp3, opus, aac, flac, wav, pcm)",
                        "default": "mp3",
                    },
                    "filename": {
                        "type": "string",
                        "description": "optional filename (without extension). If not provided, auto-generated from text",
                    },
                },
                "required": ["text"],
            },
        )
