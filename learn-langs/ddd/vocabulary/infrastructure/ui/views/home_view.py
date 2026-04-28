"""Vista del Home - Solo renderizado, sin lógica de negocio."""

import flet as ft
from typing import Callable, Any, Self, TYPE_CHECKING

if TYPE_CHECKING:
    from ddd.vocabulary.infrastructure.ui.views.home_view_dto import HomeViewDto


class HomeView(ft.Container):
    """
    Vista del Home.

    Responsabilidades:
    - Renderizar UI basada en HomeViewDto
    - Emitir eventos al Controller via callbacks
    - NO tiene lógica de negocio
    - NO importa repositorios ni servicios
    """

    def __init__(
        self,
        route_on_lang_change: Callable[[str], None],
        route_on_tag_toggle: Callable[[str], None],
        route_on_start_study: Callable[[], None],
        route_on_manage_words: Callable[[], None],
        route_on_mount: Callable[[], None] | None = None,
    ):
        super().__init__()

        # Callbacks al controller
        self._route_on_lang_change = route_on_lang_change
        self._route_on_tag_toggle = route_on_tag_toggle
        self._route_on_start_study = route_on_start_study
        self._route_on_manage_words = route_on_manage_words
        self._route_on_mount = route_on_mount

        # Componentes UI
        self._ft_lang_dropdown: ft.Dropdown | None = None
        self._ft_tags_row: ft.Row | None = None
        self._ft_stats_column: ft.Column | None = None
        self._ft_loading_indicator: ft.ProgressRing | None = None
        self._ft_content_column: ft.Column | None = None

        self._build_initial_ui()

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        """Crea la vista desde un diccionario de callbacks."""
        return cls(
            route_on_lang_change=primitives.get("on_lang_change", lambda x: None),
            route_on_tag_toggle=primitives.get("on_tag_toggle", lambda x: None),
            route_on_start_study=primitives.get("on_start_study", lambda: None),
            route_on_manage_words=primitives.get("on_manage_words", lambda: None),
            route_on_mount=primitives.get("on_mount"),
        )

    def did_mount(self) -> None:
        """Flet llama esto al montar. Notifica al Controller."""
        if self._route_on_mount:
            self._route_on_mount()

    def _build_initial_ui(self) -> None:
        """Construye la estructura inicial de la UI."""
        # Loading indicator
        self._ft_loading_indicator = ft.ProgressRing(visible=True)

        # Dropdown de idiomas (se llena en render)
        self._ft_lang_dropdown = ft.Dropdown(
            label="Idioma a practicar",
            width=250,
            options=[],
        )
        self._ft_lang_dropdown.on_change = self._handle_lang_change

        # Tags row
        self._ft_tags_row = ft.Row(
            controls=[],
            wrap=True,
            spacing=8,
            run_spacing=8,
        )

        # Stats column
        self._ft_stats_column = ft.Column(
            controls=[
                ft.Text("Cargando estadisticas...", italic=True),
            ],
            spacing=8,
        )

        # Botones de acción
        start_btn = ft.ElevatedButton(
            content=ft.Row(
                [ft.Icon(ft.Icons.PLAY_ARROW), ft.Text("Comenzar estudio")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=lambda _: self._route_on_start_study(),
            style=ft.ButtonStyle(
                bgcolor=ft.Colors.GREEN_600,
                color=ft.Colors.WHITE,
                padding=20,
            ),
        )

        manage_btn = ft.ElevatedButton(
            content=ft.Row(
                [ft.Icon(ft.Icons.EDIT), ft.Text("Gestionar palabras")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=lambda _: self._route_on_manage_words(),
        )

        # Layout principal
        self._ft_content_column = ft.Column(
            controls=[
                ft.Container(height=20),
                ft.Text(
                    "Que quieres practicar hoy?",
                    size=28,
                    weight=ft.FontWeight.BOLD,
                    text_align=ft.TextAlign.CENTER,
                ),
                ft.Container(height=30),
                ft.Row(
                    controls=[self._ft_loading_indicator],
                    alignment=ft.MainAxisAlignment.CENTER,
                ),
                ft.Container(
                    content=self._ft_lang_dropdown,
                    alignment=ft.Alignment.CENTER,
                ),
                ft.Container(height=20),
                ft.Text("Filtrar por tags (opcional):", size=14),
                ft.Container(
                    content=self._ft_tags_row,
                    padding=10,
                ),
                ft.Container(height=20),
                ft.Container(
                    content=ft.Card(
                        content=ft.Container(
                            content=self._ft_stats_column,
                            padding=16,
                        ),
                    ),
                    width=400,
                    alignment=ft.Alignment.CENTER,
                ),
                ft.Container(height=30),
                ft.Row(
                    controls=[start_btn, manage_btn],
                    alignment=ft.MainAxisAlignment.CENTER,
                    spacing=20,
                ),
            ],
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            scroll=ft.ScrollMode.AUTO,
        )

        self.content = self._ft_content_column
        self.expand = True
        self.padding = 20

    def render(self, dto: "HomeViewDto") -> None:
        """Renderiza la vista con los datos del DTO."""
        if self._ft_loading_indicator:
            self._ft_loading_indicator.visible = dto.is_loading

        if dto.error_message:
            self._show_error(dto.error_message)
            return

        self._render_language_dropdown(dto)
        self._render_tags(dto)
        self._render_stats(dto)
        self.update()

    def _render_language_dropdown(self, dto: "HomeViewDto") -> None:
        """Renderiza el dropdown de idiomas."""
        if not self._ft_lang_dropdown:
            return

        self._ft_lang_dropdown.options = [
            ft.dropdown.Option(key=lang["code"], text=lang["display_name"])
            for lang in dto.language_options
        ]
        self._ft_lang_dropdown.value = dto.selected_lang_code

    def _render_tags(self, dto: "HomeViewDto") -> None:
        """Renderiza los chips de tags."""
        if not self._ft_tags_row:
            return

        self._ft_tags_row.controls.clear()

        if not dto.tags:
            self._ft_tags_row.controls.append(
                ft.Text(
                    "No hay tags disponibles",
                    italic=True,
                    color=ft.Colors.GREY_500,
                    size=12,
                )
            )
        else:
            for tag in dto.tags:
                tag_name = tag.get("name", "")
                is_selected = tag.get("is_selected", False)
                color = tag.get("color", "#6B7280")

                chip = ft.Chip(
                    label=ft.Text(tag_name),
                    selected=is_selected,
                    on_select=lambda e, t=tag_name: self._route_on_tag_toggle(t),
                    bgcolor=color if is_selected else None,
                    selected_color=ft.Colors.WHITE,
                )
                self._ft_tags_row.controls.append(chip)

    def _render_stats(self, dto: "HomeViewDto") -> None:
        """Renderiza las estadísticas."""
        if not self._ft_stats_column or not dto.stats:
            return

        total_words = dto.stats.get("total_words", 0)
        due_for_review = dto.stats.get("due_for_review", 0)
        avg_score = float(dto.stats.get("avg_score", 0) or 0)
        avg_score_percent = int(avg_score * 100)

        self._ft_stats_column.controls.clear()
        self._ft_stats_column.controls.extend([
            ft.Text("Estadisticas", weight=ft.FontWeight.BOLD, size=16),
            ft.Divider(height=1),
            ft.Row([
                ft.Text("Total palabras:"),
                ft.Text(str(total_words), weight=ft.FontWeight.BOLD),
            ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
            ft.Row([
                ft.Text("Pendientes de repaso:"),
                ft.Text(str(due_for_review), weight=ft.FontWeight.BOLD),
            ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
            ft.Row([
                ft.Text("Score promedio:"),
                ft.Text(f"{avg_score_percent}%", weight=ft.FontWeight.BOLD),
            ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
        ])

    def _show_error(self, message: str) -> None:
        """Muestra un mensaje de error."""
        if self._ft_stats_column:
            self._ft_stats_column.controls.clear()
            self._ft_stats_column.controls.append(
                ft.Text(f"Error: {message}", color=ft.Colors.RED_700)
            )
        self.update()

    def _handle_lang_change(self, e: ft.ControlEvent) -> None:
        """Maneja el cambio de idioma y notifica al controller."""
        self._route_on_lang_change(e.control.value)
