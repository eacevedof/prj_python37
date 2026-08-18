"""Componente: modal de reglas de uso (`rules_help`) renderizado como markdown."""

from typing import Callable

import flet as ft

from ddd.vocabulary.infrastructure.ui.components.rules_help_markdown_formatter import (
    RulesHelpMarkdownFormatter,
)
from ddd.vocabulary.infrastructure.ui.enums.rules_help_size_enum import (
    RulesHelpSizeEnum,
)


class RulesHelpDialogComp(ft.AlertDialog):
    """
    Modal de ayuda de una palabra, a pantalla casi completa.

    - El texto de `rules_help` se pinta como markdown (`ft.Markdown`), con
      encabezados, listas y avisos jerarquizados: leer no debe ser una búsqueda
      visual dentro de un muro de líneas.
    - El tamaño se calcula sobre el de la página (ver RulesHelpSizeEnum).
    - NO tiene lógica de negocio ni decide cuándo se abre: la vista lo abre,
      lo cierra y se ocupa de pausar/reanudar su sesión.
    """

    def __init__(self, route_on_close: Callable[[], None]) -> None:
        super().__init__(modal=True)

        self._rules_help_markdown_formatter = RulesHelpMarkdownFormatter.get_instance()
        self._route_on_close = route_on_close

        self._ft_title_text = ft.Text(
            "",
            size=RulesHelpSizeEnum.TITLE.value,
            weight=ft.FontWeight.BOLD,
            max_lines=2,
            overflow=ft.TextOverflow.ELLIPSIS,
        )
        self._ft_markdown = ft.Markdown(
            value="",
            selectable=True,
            extension_set=ft.MarkdownExtensionSet.GITHUB_WEB,
            # El texto plano heredado usa el salto de línea como separación real
            soft_line_break=True,
            md_style_sheet=self._get_markdown_style_sheet(),
        )
        self._ft_body_container = ft.Container(
            content=ft.Column(
                controls=[self._ft_markdown],
                scroll=ft.ScrollMode.AUTO,
                spacing=0,
            ),
        )

        self.title = ft.Row(
            controls=[
                ft.Icon(ft.Icons.HELP_OUTLINE, color=ft.Colors.GREEN_700),
                ft.Column(
                    controls=[
                        self._ft_title_text,
                        ft.Text(
                            "Reglas de uso",
                            size=RulesHelpSizeEnum.SUBTITLE.value,
                            color=ft.Colors.GREY_600,
                        ),
                    ],
                    spacing=0,
                    expand=True,
                ),
                self._get_built_close_button(),
            ],
            spacing=10,
            vertical_alignment=ft.CrossAxisAlignment.CENTER,
        )
        self.content = self._ft_body_container
        self.actions = [
            ft.TextButton("Cerrar", on_click=lambda _: self._on_close_btn_click())
        ]
        self.actions_alignment = ft.MainAxisAlignment.END
        # Sin este padding mínimo el diálogo no puede crecer hasta el 95%
        self.inset_padding = ft.Padding.all(12)
        self.content_padding = ft.Padding.symmetric(horizontal=20, vertical=10)

    def _get_built_close_button(self) -> ft.IconButton:
        """Aspa de cerrar de la cabecera.

        Con el modal a pantalla casi completa el botón de abajo queda lejos del
        pulgar; las dos salidas hacen lo mismo.
        """
        return ft.IconButton(
            icon=ft.Icons.CLOSE,
            icon_size=RulesHelpSizeEnum.CLOSE_ICON.value,
            icon_color=ft.Colors.GREY_700,
            tooltip="Cerrar",
            on_click=lambda _: self._on_close_btn_click(),
        )

    def _on_close_btn_click(self) -> None:
        """Cerrar: lo resuelve la vista (cierra el modal y reanuda su sesión)."""
        self._route_on_close()

    def render(
        self, word_text: str, rules_help: str, page_width: float | None, page_height: float | None
    ) -> None:
        """Vuelca la ayuda de la palabra y ajusta el modal al tamaño de pantalla."""
        self._ft_title_text.value = word_text
        self._ft_markdown.value = (
            self._rules_help_markdown_formatter.get_rules_help_as_markdown(rules_help)
        )
        self._ft_body_container.width = self._get_body_width(page_width)
        self._ft_body_container.height = self._get_body_height(page_height)

    def _get_body_width(self, page_width: float | None) -> float:
        """Ancho útil: el porcentaje de pantalla configurado."""
        available_width = page_width or RulesHelpSizeEnum.FALLBACK_WIDTH.value
        return max(
            RulesHelpSizeEnum.MIN_WIDTH.value,
            available_width * RulesHelpSizeEnum.SCREEN_PERCENT.value / 100,
        )

    def _get_body_height(self, page_height: float | None) -> float:
        """Alto útil: el porcentaje de pantalla menos el marco del diálogo."""
        available_height = page_height or RulesHelpSizeEnum.FALLBACK_HEIGHT.value
        body_height = (
            available_height * RulesHelpSizeEnum.SCREEN_PERCENT.value / 100
            - RulesHelpSizeEnum.CHROME_HEIGHT.value
        )
        return max(RulesHelpSizeEnum.MIN_HEIGHT.value, body_height)

    def _get_markdown_style_sheet(self) -> ft.MarkdownStyleSheet:
        """Estilo del markdown: jerarquía visible y neerlandés destacado."""
        return ft.MarkdownStyleSheet(
            p_text_style=ft.TextStyle(size=RulesHelpSizeEnum.TEXT.value, height=1.45),
            # Negrita = el término neerlandés o el rótulo del párrafo
            strong_text_style=ft.TextStyle(
                weight=ft.FontWeight.BOLD, color=ft.Colors.INDIGO_900
            ),
            em_text_style=ft.TextStyle(italic=True, color=ft.Colors.GREY_700),
            h3_text_style=ft.TextStyle(
                size=RulesHelpSizeEnum.HEADING.value,
                weight=ft.FontWeight.BOLD,
                color=ft.Colors.GREEN_800,
            ),
            h3_padding=ft.Padding.only(top=18, bottom=2),
            h4_text_style=ft.TextStyle(
                size=RulesHelpSizeEnum.SUBHEADING.value,
                weight=ft.FontWeight.BOLD,
                color=ft.Colors.BLUE_GREY_700,
            ),
            h4_padding=ft.Padding.only(top=12, bottom=2),
            # Cita = la regla de la tarjeta y los avisos ⚠️: lo que no hay que buscar
            blockquote_text_style=ft.TextStyle(size=RulesHelpSizeEnum.TEXT.value, height=1.45),
            blockquote_padding=ft.Padding.symmetric(horizontal=14, vertical=10),
            blockquote_decoration=ft.BoxDecoration(
                bgcolor=ft.Colors.AMBER_50,
                border=ft.Border.only(left=ft.BorderSide(4, ft.Colors.AMBER_600)),
                border_radius=ft.BorderRadius.all(6),
            ),
            code_text_style=ft.TextStyle(
                size=RulesHelpSizeEnum.CODE.value, font_family="monospace"
            ),
            codeblock_decoration=ft.BoxDecoration(
                bgcolor=ft.Colors.GREY_100, border_radius=ft.BorderRadius.all(6)
            ),
            table_head_text_style=ft.TextStyle(
                size=RulesHelpSizeEnum.TEXT.value, weight=ft.FontWeight.BOLD
            ),
            table_body_text_style=ft.TextStyle(size=RulesHelpSizeEnum.TEXT.value),
            table_cells_padding=ft.Padding.symmetric(horizontal=10, vertical=6),
            table_cells_decoration=ft.BoxDecoration(bgcolor=ft.Colors.TRANSPARENT),
            horizontal_rule_decoration=ft.BoxDecoration(
                border=ft.Border.only(top=ft.BorderSide(1, ft.Colors.GREY_300))
            ),
            list_bullet_text_style=ft.TextStyle(
                size=RulesHelpSizeEnum.TEXT.value, color=ft.Colors.GREEN_700
            ),
            list_indent=22,
            block_spacing=10,
        )
