"""Componente: fuente del grupo en cabecera (clicable si contiene un enlace)."""

import re

import flet as ft


class GroupSourceLinkComp(ft.Container):
    """
    Muestra la fuente del grupo de la sesión (título de la lección, canal...).

    - Si la fuente contiene una URL, se muestra como enlace clicable que abre
      el navegador (la URL completa va en el tooltip).
    - Si no hay fuente, el componente queda oculto.
    - NO tiene lógica de negocio: decidir si la fuente se muestra (p. ej.
      excluir 'migracion') es responsabilidad del controller.
    """

    _URL_PATTERN = re.compile(r"https?://\S+")

    def __init__(self) -> None:
        super().__init__()
        self.content = ft.Text("")
        self.visible = False
        self.width = 420

    def render(self, group_source: str) -> None:
        """Renderiza la fuente; oculta el componente si viene vacía."""
        source_text = (group_source or "").strip()
        if not source_text:
            self.visible = False
            return

        url_match = self._URL_PATTERN.search(source_text)
        if not url_match:
            self.content = ft.Text(
                source_text,
                size=12,
                italic=True,
                color=ft.Colors.GREY_600,
                max_lines=1,
                overflow=ft.TextOverflow.ELLIPSIS,
            )
            self.visible = True
            return

        source_url = url_match.group(0)
        display_text = source_text.replace(source_url, "").strip(" -–|") or source_url
        self.content = ft.TextButton(
            content=ft.Row(
                controls=[
                    ft.Icon(ft.Icons.LINK, size=14, color=ft.Colors.BLUE_700),
                    ft.Text(
                        display_text,
                        size=12,
                        color=ft.Colors.BLUE_700,
                        max_lines=1,
                        overflow=ft.TextOverflow.ELLIPSIS,
                    ),
                ],
                spacing=4,
            ),
            tooltip=source_url,
            on_click=lambda _: self.page.launch_url(source_url) if self.page else None,
        )
        self.visible = True
