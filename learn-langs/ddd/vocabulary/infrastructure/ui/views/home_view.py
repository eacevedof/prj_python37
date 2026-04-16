"""Vista para listar palabras."""

import flet as ft
from typing import Callable


class HomeView(ft.Container):
    """Vista para listar palabras."""

    def __init__(
            self,
            on_start_study: Callable[[str, list[str]], None],
            on_manage_words: Callable[[], None],
    ):
        super().__init__()
        self.on_start_study = on_start_study
        self.on_manage_words = on_manage_words

        self.selected_lang = "nl_NL"
        self.selected_tags: list[str] = []
        self.available_tags: list[dict] = []
        self.stats: dict = {}

        self._lang_dropdown: ft.Dropdown | None = None
        self._tags_row: ft.Row | None = None
        self._stats_column: ft.Column | None = None

        self._build_ui()

    def _build_ui(self) -> None:
        # Dropdown de idiomas
        self._lang_dropdown = ft.Dropdown(
            label="Idioma a practicar",
            width=250,
            options=[
                ft.dropdown.Option(key="nl_NL", text="Nederlands"),
                ft.dropdown.Option(key="en_US", text="English (US)"),
                ft.dropdown.Option(key="en_GB", text="English (UK)"),
                ft.dropdown.Option(key="de_DE", text="Deutsch"),
                ft.dropdown.Option(key="fr_FR", text="Francais"),
            ],
            value="nl_NL",
            on_select=self._on_lang_change,
        )

        # Tags
        self._tags_row = ft.Row(
            controls=[],
            wrap=True,
            spacing=8,
            run_spacing=8,
        )

        # Stats
        self._stats_column = ft.Column(
            controls=[
                ft.Text("Cargando estadisticas...", italic=True),
            ],
            spacing=8,
        )

        # Botones de accion
        start_btn = ft.ElevatedButton(
            content=ft.Row(
                [ft.Icon(ft.Icons.PLAY_ARROW), ft.Text("Comenzar estudio")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=self._start_study,
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
            on_click=lambda _: self.on_manage_words(),
        )

        self.content = ft.Column(
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

                # Seleccion de idioma
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

                # Estadisticas
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
        self.expand = True
        self.padding = 20

    def did_mount(self) -> None:
        """Carga datos al montar el componente."""
        self.page.run_task(self._load_data)

    async def _load_data(self) -> None:
        """Carga tags y estadisticas."""
        # Cargar tags
        tags_reader = TagsReaderSqliteRepository.get_instance()
        self.available_tags = await tags_reader.get_all()
        self._update_tags_ui()

        # Cargar estadisticas
        await self._load_stats()

    def _update_tags_ui(self) -> None:
        """Actualiza la UI de tags."""
        if not self._tags_row:
            return

        self._tags_row.controls.clear()

        for tag in self.available_tags:
            is_selected = tag["name"] in self.selected_tags
            chip = ft.Chip(
                label=ft.Text(tag["name"]),
                selected=is_selected,
                on_select=lambda e, t=tag["name"]: self._toggle_tag(t),
                bgcolor=tag.get("color", "#6B7280") if is_selected else None,
                selected_color=ft.Colors.WHITE,
            )
            self._tags_row.controls.append(chip)

        self.update()

    def _toggle_tag(self, tag_name: str) -> None:
        """Alterna la seleccion de un tag."""
        if tag_name in self.selected_tags:
            self.selected_tags.remove(tag_name)
        else:
            self.selected_tags.append(tag_name)
        self._update_tags_ui()

    def _on_lang_change(self, e) -> None:
        """Maneja cambio de idioma."""
        self.selected_lang = e.control.value
        self.page.run_task(self._load_stats)

    async def _load_stats(self) -> None:
        """Carga estadisticas del idioma seleccionado."""
        metrics_reader = MetricsReaderSqliteRepository.get_instance()
        words_reader = WordsEsReaderSqliteRepository.get_instance()

        stats = await metrics_reader.get_stats_for_lang(self.selected_lang)
        total_words = await words_reader.count()

        if self._stats_column:
            self._stats_column.controls.clear()
            self._stats_column.controls.extend([
                ft.Text("Estadisticas", weight=ft.FontWeight.BOLD, size=16),
                ft.Divider(height=1),
                ft.Row([
                    ft.Text("Total palabras:"),
                    ft.Text(str(total_words), weight=ft.FontWeight.BOLD),
                ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
                ft.Row([
                    ft.Text("Pendientes de repaso:"),
                    ft.Text(str(stats.get("due_for_review", 0) or 0), weight=ft.FontWeight.BOLD),
                ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
                ft.Row([
                    ft.Text("Score promedio:"),
                    ft.Text(f"{(stats.get('avg_score', 0) or 0) * 100:.0f}%", weight=ft.FontWeight.BOLD),
                ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
            ])
            self.update()

    def _start_study(self, e) -> None:
        """Inicia la sesion de estudio."""
        self.on_start_study(self.selected_lang, self.selected_tags)
