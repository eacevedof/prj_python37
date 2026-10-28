"""Escala responsive de la UI según el tamaño real de la página.

Los tamaños base de las tarjetas (SliderCardSizeEnum) son de escritorio/kiosko;
en pantallas pequeñas (tablet) se multiplican por este factor para que quepan.
"""

import flet as ft


def get_page_size(control: ft.Control) -> tuple[float | None, float | None]:
    """(ancho, alto) de la página; (None, None) si el control aún no está montado.

    flet 0.86: acceder a `control.page` LANZA si el control no está en la página
    (p.ej. el primer render ocurre antes del update que lo monta).
    """
    try:
        page = control.page
    except Exception:
        return (None, None)
    if not page:
        return (None, None)
    return (getattr(page, "width", None), getattr(page, "height", None))


def get_page_scale(control: ft.Control) -> float:
    """Factor de escala 0.4–1.0: 1.0 en escritorio, <1 en pantallas pequeñas."""
    width, height = get_page_size(control)
    if not width or not height:
        return 1.0
    return max(0.4, min(1.0, width / 1280, height / 900))


def is_portrait(control: ft.Control) -> bool:
    """True si la página está en retrato (ancho < alto); False si no se sabe."""
    width, height = get_page_size(control)
    return bool(width and height and width < height)
