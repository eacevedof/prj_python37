"""Factores de escala del texto de las tarjetas (sobre los tamaños kiosko)."""

from enum import Enum


class CardTextFactorEnum(float, Enum):
    """Cuánto se encoge cada texto respecto al tamaño base de SliderCardSizeEnum.

    En el Examen la palabra y la respuesta conviven con timer + campo de entrada,
    así que van algo más pequeñas que en el slider puro.
    """

    IMAGE_CARD_WORD = 0.8
    IMAGE_CARD_TRANSLATION = 0.7
    SLIDER_CARD_TRANSLATION = 0.75
