"""Vista del Home - Solo renderizado, sin lógica de negocio."""

import flet as ft
from typing import Callable, TYPE_CHECKING

if TYPE_CHECKING:
    from ddd.vocabulary.infrastructure.controllers.home_view_dto import HomeViewDto


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
        on_lang_change: Callable[[str], None],
        on_tag_toggle: Callable[[str], None],
        on_start_study: Callable[[], None],
        on_manage_words: Callable[[], None],
    ):
        super().__init__()

        # Callbacks al controller
        self._on_lang_change = on_lang_change
        self._on_tag_toggle = on_tag_toggle
        self._on_start_study = on_start_study
        self._on_manage_words = on_manage_words

        # Componentes UI (se crean en _build_ui)
        self._lang_dropdown: ft.Dropdown | None = None
        self._tags_row: ft.Row | None = None
        self._stats_column: ft.Column | None = None
        self._loading_indicator: ft.ProgressRing | None = None
        self._content_column: ft.Column | None = None

        self._build_initial_ui()

    def _build_initial_ui(self) -> None:
        """Construye la estructura inicial de la UI."""
        # Loading indicator
        self._loading_indicator = ft.ProgressRing(visible=True)

        # Dropdown de idiomas (se llena en render)
        self._lang_dropdown = ft.Dropdown(
            label="Idioma a practicar",
            width=250,
            options=[],
            on_change=self._handle_lang_change,
        )

        # Tags row
        self._tags_row = ft.Row(
            controls=[],
            wrap=True,
            spacing=8,
            run_spacing=8,
        )

        # Stats column
        self._stats_column = ft.Column(
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
            on_click=lambda _: self._on_start_study(),
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
            on_click=lambda _: self._on_manage_words(),
        )

        # Layout principal
        self._content_column = ft.Column(
            controls=[
                ft.Container(height=20),
                # Titulo
                ft.Text(
                    "Que quieres practicar hoy?",
                    size=28,
                    weight=ft.FontWeight.BOLD,
                    text_align=ft.TextAlign.CENTER,
                ),
                ft.Container(height=30),

                # Loading
                ft.Row(
                    controls=[self._loading_indicator],
                    alignment=ft.MainAxisAlignment.CENTER,
                ),

                # Selección de idioma
                ft.Container(
                    content=self._lang_dropdown,
                    alignment=ft.Alignment.CENTER,
                ),
                ft.Container(height=20),

                # Tags
                ft.Text("Filtrar por tags (opcional):", size=14),
                ft.Container(
                    content=self._tags_row,
                    padding=10,
                ),
                ft.Container(height=20),

                # Estadísticas
                ft.Container(
                    content=ft.Card(
                        content=ft.Container(
                            content=self._stats_column,
                            padding=16,
                        ),
                    ),
                    width=400,
                    alignment=ft.Alignment.CENTER,
                ),
                ft.Container(height=30),

                # Botones
                ft.Row(
                    controls=[start_btn, manage_btn],
                    alignment=ft.MainAxisAlignment.CENTER,
                    spacing=20,
                ),
            ],
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            scroll=ft.ScrollMode.AUTO,
        )

        self.content = self._content_column
        self.expand = True
        self.padding = 20

    def render(self, home_view_dto: "HomeViewDto") -> None:
        """
        Renderiza la vista con los datos del DTO.

        Este es el único punto de entrada de datos desde el Controller.
        """
        # Loading state
        if self._loading_indicator:
            self._loading_indicator.visible = home_view_dto.is_loading

        # Error state
        if home_view_dto.error_message:
            self._show_error(home_view_dto.error_message)
            return

        # Dropdown de idiomas
        self._render_language_dropdown(home_view_dto)

        # Tags
        self._render_tags(home_view_dto)

        # Stats
        self._render_stats(home_view_dto)

        self.update()

    def _render_language_dropdown(self, dto: "HomeViewDto") -> None:
        """Renderiza el dropdown de idiomas."""
        if not self._lang_dropdown:
            return

        self._lang_dropdown.options = [
            ft.dropdown.Option(key=lang.code, text=lang.display_name)
            for lang in dto.language_options
        ]
        self._lang_dropdown.value = dto.selected_lang_code

    def _render_tags(self, dto: "HomeViewDto") -> None:
        """Renderiza los chips de tags."""
        if not self._tags_row:
            return

        self._tags_row.controls.clear()

        if not dto.tags:
            self._tags_row.controls.append(
                ft.Text(
                    "No hay tags disponibles",
                    italic=True,
                    color=ft.Colors.GREY_500,
                    size=12,
                )
            )
        else:
            for tag in dto.tags:
                chip = ft.Chip(
                    label=ft.Text(tag.name),
                    selected=tag.is_selected,
                    on_select=lambda e, t=tag.name: self._on_tag_toggle(t),
                    bgcolor=tag.color if tag.is_selected else None,
                    selected_color=ft.Colors.WHITE,
                )
                self._tags_row.controls.append(chip)

    def _render_stats(self, dto: "HomeViewDto") -> None:
        """Renderiza las estadísticas."""
        if not self._stats_column or not dto.stats:
            return

        self._stats_column.controls.clear()
        self._stats_column.controls.extend([
            ft.Text("Estadisticas", weight=ft.FontWeight.BOLD, size=16),
            ft.Divider(height=1),
            ft.Row([
                ft.Text("Total palabras:"),
                ft.Text(str(dto.stats.total_words), weight=ft.FontWeight.BOLD),
            ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
            ft.Row([
                ft.Text("Pendientes de repaso:"),
                ft.Text(str(dto.stats.due_for_review), weight=ft.FontWeight.BOLD),
            ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
            ft.Row([
                ft.Text("Score promedio:"),
                ft.Text(f"{dto.stats.avg_score_percent}%", weight=ft.FontWeight.BOLD),
            ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
        ])

    def _show_error(self, message: str) -> None:
        """Muestra un mensaje de error."""
        if self._stats_column:
            self._stats_column.controls.clear()
            self._stats_column.controls.append(
                ft.Text(f"Error: {message}", color=ft.Colors.RED_700)
            )
        self.update()

    def _handle_lang_change(self, e: ft.ControlEvent) -> None:
        """Maneja el cambio de idioma y notifica al controller."""
        self._on_lang_change(e.control.value)
