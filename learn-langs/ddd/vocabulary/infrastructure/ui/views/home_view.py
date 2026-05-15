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

    # =========================================================================
    # CONSTRUCCIÓN (Public API)
    # =========================================================================
    def __init__(
        self,
        route_on_mount: Callable[[], None] | None,         # 1. Lifecycle (se ejecuta primero)
        route_on_lang_change: Callable[[str], None],       # 2. Dropdown idiomas (render paso 1)
        route_on_tag_toggle: Callable[[str], None],        # 3. Tags (render paso 2)
        route_on_start_study: Callable[[], None],          # 4. Botón acción primaria (verde)
        route_on_start_image_study: Callable[[], None],    # 5. Botón acción secundaria (morado)
        route_on_manage_words: Callable[[], None],         # 6. Botón acción terciaria (gris)
    ):
        super().__init__()

        # Callbacks al controller (en orden de ejecución)
        self._route_on_mount = route_on_mount
        self._route_on_lang_change = route_on_lang_change
        self._route_on_tag_toggle = route_on_tag_toggle
        self._route_on_start_study = route_on_start_study
        self._route_on_start_image_study = route_on_start_image_study
        self._route_on_manage_words = route_on_manage_words

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
            route_on_mount=primitives.get("on_mount"),
            route_on_lang_change=primitives.get("on_lang_change", lambda x: None),
            route_on_tag_toggle=primitives.get("on_tag_toggle", lambda x: None),
            route_on_start_study=primitives.get("on_start_study", lambda: None),
            route_on_start_image_study=primitives.get("on_start_image_study", lambda: None),
            route_on_manage_words=primitives.get("on_manage_words", lambda: None),
        )

    # =========================================================================
    # API PÚBLICA - RENDERIZADO
    # =========================================================================
    def render(self, home_view_dto: "HomeViewDto") -> None:
        """Renderiza la vista con los datos del DTO."""
        if self._ft_loading_indicator:
            self._ft_loading_indicator.visible = home_view_dto.is_loading

        if home_view_dto.error_message:
            self._show_error(home_view_dto.error_message)
            return

        self._render_language_dropdown(home_view_dto)
        self._render_tags(home_view_dto)
        self._render_stats(home_view_dto)
        self.update()

    # =========================================================================
    # LIFECYCLE HOOKS (Flet)
    # =========================================================================
    def did_mount(self) -> None:
        """Flet llama esto al montar. Notifica al Controller."""
        if self._route_on_mount:
            self._route_on_mount()

    # =========================================================================
    # CONSTRUCCIÓN DE UI (Privado)
    # =========================================================================
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
        self._ft_lang_dropdown.on_change = self._on_lang_dropdown_change

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

        image_study_btn = ft.ElevatedButton(
            content=ft.Row(
                [ft.Icon(ft.Icons.IMAGE), ft.Text("Estudiar con imágenes")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=lambda _: self._route_on_start_image_study(),
            style=ft.ButtonStyle(
                bgcolor=ft.Colors.PURPLE_600,
                color=ft.Colors.WHITE,
                padding=20,
            ),
        )

        manage_btn = ft.ElevatedButton(
            content=ft.Row(
                [ft.Icon(ft.Icons.EDIT), ft.Text("Palabras")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=lambda _: self._route_on_manage_words(),
            bgcolor=ft.Colors.YELLOW_700,
            color=ft.Colors.BLACK,
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
                    controls=[start_btn, image_study_btn, manage_btn],
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

    # =========================================================================
    # RENDERIZADO PARCIAL (en orden de ejecución en render())
    # =========================================================================

    def _render_language_dropdown(self, home_view_dto: "HomeViewDto") -> None:
        """Renderiza el dropdown de idiomas."""
        if not self._ft_lang_dropdown:
            return

        self._ft_lang_dropdown.options = [
            ft.dropdown.Option(key=lang["code"], text=lang["display_name"])
            for lang in home_view_dto.language_options
        ]
        self._ft_lang_dropdown.value = home_view_dto.selected_lang_code

    def _render_tags(self, home_view_dto: "HomeViewDto") -> None:
        """Renderiza los chips de tags."""
        if not self._ft_tags_row:
            return

        self._ft_tags_row.controls.clear()

        if not home_view_dto.tags:
            self._ft_tags_row.controls.append(
                ft.Text(
                    "No hay tags disponibles",
                    italic=True,
                    color=ft.Colors.GREY_500,
                    size=12,
                )
            )
        else:
            for tag in home_view_dto.tags:
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

    def _render_stats(self, home_view_dto: "HomeViewDto") -> None:
        """Renderiza las estadísticas."""
        if not self._ft_stats_column or not home_view_dto.stats:
            return

        total_words = home_view_dto.stats.get("total_words", 0)
        due_for_review = home_view_dto.stats.get("due_for_review", 0)
        avg_score = float(home_view_dto.stats.get("avg_score", 0) or 0)
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

    # =========================================================================
    # EVENT HANDLERS (Callbacks de UI)
    # =========================================================================
    def _on_lang_dropdown_change(self, e: ft.ControlEvent) -> None:
        """Maneja el cambio de idioma y notifica al controller."""
        self._route_on_lang_change(e.control.value)
