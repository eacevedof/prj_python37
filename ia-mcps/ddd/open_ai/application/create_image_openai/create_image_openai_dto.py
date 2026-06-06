"""DTO para crear imágenes con OpenAI Images API."""

from dataclasses import dataclass
from typing import Literal


@dataclass(frozen=True, slots=True)
class CreateImageOpenaiDto:
    """
    DTO para parametrizar la generación de imágenes con OpenAI.

    Soporta tanto dall-e-3 como gpt-image-1.5.
    """

    prompt: str
    """Descripción completa de la imagen a generar."""

    model: Literal["gpt-image-1.5", "dall-e-3", "dall-e-2"] = "gpt-image-1.5"
    """Modelo a utilizar para generar la imagen."""

    size: Literal[
        "256x256", "512x512", "1024x1024",  # gpt-image-1.5, dall-e-2
        "1024x1792", "1792x1024"  # dall-e-3
    ] = "1024x1024"
    """Tamaño de la imagen a generar."""

    quality: Literal["low", "high"] = "low"
    """Calidad de la imagen (low es más rápido y económico)."""

    style: Literal["natural", "vivid"] | None = None
    """Estilo visual (solo para dall-e-3)."""

    n: int = 1
    """Número de imágenes a generar (1-10)."""

    def __post_init__(self) -> None:
        """Valida los parámetros del DTO."""
        if not self.prompt or not self.prompt.strip():
            raise ValueError("CreateImageOpenaiDto: prompt no puede estar vacío")

        if self.n < 1 or self.n > 10:
            raise ValueError("CreateImageOpenaiDto: n debe estar entre 1 y 10")

        # Validar combinaciones de modelo/tamaño
        if self.model == "dall-e-3" and self.size in ["256x256", "512x512"]:
            raise ValueError(
                "CreateImageOpenaiDto: dall-e-3 no soporta tamaños 256x256 ni 512x512"
            )

        if self.model in ["dall-e-2", "gpt-image-1.5"] and self.size in ["1024x1792", "1792x1024"]:
            raise ValueError(
                f"CreateImageOpenaiDto: {self.model} no soporta tamaños 1024x1792 ni 1792x1024"
            )
