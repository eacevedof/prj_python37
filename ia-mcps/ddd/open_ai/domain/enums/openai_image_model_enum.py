from enum import StrEnum
from typing import final


@final
class OpenaiImageModelEnum(StrEnum):
    """OpenAI models for image generation."""

    GPT_IMAGE_1 = "gpt-image-1"
    GPT_IMAGE_1_MINI = "gpt-image-1-mini"
    GPT_IMAGE_2 = "gpt-image-2"
    GPT_IMAGE_1_5 = "gpt-image-1.5"
    CHATGPT_IMAGE_LATEST = "chatgpt-image-latest"
    DALL_E_3 = "dall-e-3"
    DALL_E_2 = "dall-e-2"

"""
┌─────┬──────────────────────┬────────────────────────────────────────────────────────────────────────────┬────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│  #  │        Modelo        │                                Caso de Uso                                 │                                                       Razón                                                        │
├─────┼──────────────────────┼────────────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ 1   │ gpt-image-1-mini     │ Alto volumen con presupuesto limitado, prototipado, testing                │ 80% más barato que gpt-image-1. Low: $0.005, Medium: $0.011, High: $0.036                                          │
├─────┼──────────────────────┼────────────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ 2   │ gpt-image-1.5        │ Generación rápida manteniendo calidad                                      │ 4x más rápido, integrado en GPT-5, mejor comprensión y control preciso                                             │
├─────┼──────────────────────┼────────────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ 3   │ gpt-image-1          │ Proyectos que requieren máxima precisión composicional                     │ Mejor adherencia al prompt y exactitud composicional (2-4x más caro que mini)                                      │
├─────┼──────────────────────┼────────────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ 4   │ gpt-image-2          │ Producción comercial profesional, especialmente con texto en imágenes      │ Renderizado perfecto de texto multilingüe, alta resolución, fotorrealismo avanzado, transformación imagen-a-imagen │
├─────┼──────────────────────┼────────────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ 5   │ chatgpt-image-latest │ Cuando quieres usar siempre el modelo más reciente sin especificar versión │ Auto-actualiza al modelo flagship actual de ChatGPT                                                                │
└─────┴──────────────────────┴────────────────────────────────────────────────────────────────────────────┴────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
⚠️ IMPORTANTE
A partir del 12 de mayo de 2026, DALL-E 2 y DALL-E 3 dejarán de responder a llamadas API. Migra a los modelos GPT Image.
"""