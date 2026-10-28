from typing import final


@final
class FavoriteStopMessageEnum:
    """Mensajes de los casos de uso de paradas favoritas.

    Hablan de paradas, nunca de tablas ni de columnas: el agente no tiene por
    qué saber cómo se guarda esto.
    """

    STOP_NR_REQUIRED = "stop_nr es obligatorio"
    STOP_NR_TOO_LONG = "stop_nr no es un número de parada válido"
    STOP_DESCRIPTION_REQUIRED = "stop_description es obligatorio"
    STOP_DESCRIPTION_TOO_LONG = "stop_description es demasiado largo (máximo 120 caracteres)"

    STOP_ALREADY_IN_FAVORITES = "esa parada ya está en favoritos"
    STOP_NOT_IN_FAVORITES = "esa parada no está en favoritos"
