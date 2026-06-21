"""Vista de sesión de slider - Solo renderizado."""

from typing import Any, Callable, Self

import flet as ft

from ddd.vocabulary.infrastructure.ui.components.slider_card_comp import SliderCardComp
from ddd.vocabulary.infrastructure.ui.views.word_slider_view_dto import WordSliderViewDto


class WordSliderView(ft.Container):
    """
    Vista de sesión de slider (presentación auto-reproducida).

    Responsabilidades:
    - Renderizar UI basada en WordSliderViewDto
    - Mostrar la palabra ES animada y revelar la traducción según la fase
    - Emitir eventos al Controller via callbacks
    - NO tiene lógica de negocio
    """

    # =========================================================================
    # CONSTRUCCIÓN
    # =========================================================================
    def __init__(
        self,
        route_on_mount: Callable[[], None] | None,
        route_on_back: Callable[[], None],
        route_on_replay: Callable[[], None] | None = None,
    ):
        super().__init__()

        self._route_on_mount = route_on_mount
        self._route_on_back = route_on_back
        self._route_on_replay = route_on_replay

        # Componentes UI - Header
        self._ft_progress_text: ft.Text | None = None

        # Componentes UI - Content Area
        self._ft_content_area: ft.Column | None = None
        self._ft_slider_card: SliderCardComp | None = None
        self._is_card_mounted: bool = False

        self._build_initial_ui()

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        """Crea la vista desde un diccionario de callbacks."""
        return cls(
            route_on_mount=primitives.get("on_mount"),
            route_on_back=primitives.get("on_back", lambda: None),
            route_on_replay=primitives.get("on_replay"),
        )

    # =========================================================================
    # API PÚBLICA - RENDERIZADO
    # =========================================================================
    def render(self, dto: WordSliderViewDto) -> None:
        """Renderiza la vista basado en el DTO."""
        if self._ft_progress_text:
            self._ft_progress_text.value = dto.progress_text

        if dto.is_loading:
            self._render_loading()
        elif dto.error_message:
            self._render_error(dto.error_message)
        elif dto.has_no_words:
            self._render_no_words()
        elif dto.is_session_complete:
            self._render_session_complete(dto)
        elif dto.current_word:
            self._render_sliding(dto)

        self.update()

    # =========================================================================
    # LIFECYCLE HOOKS
    # =========================================================================
    def did_mount(self) -> None:
        """Flet llama esto al montar."""
        if self._route_on_mount:
            self._route_on_mount()

    # =========================================================================
    # CONSTRUCCIÓN DE UI
    # =========================================================================
    def _build_initial_ui(self) -> None:
        """Construye la estructura inicial de la UI."""
        self._ft_progress_text = ft.Text("Cargando...", size=14)
        self._ft_slider_card = SliderCardComp()

        self._ft_content_area = ft.Column(
            controls=[
                ft.Container(
                    content=ft.ProgressRing(),
                    alignment=ft.Alignment.CENTER,
                    expand=True,
                ),
            ],
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            alignment=ft.MainAxisAlignment.CENTER,
            expand=True,
            scroll=ft.ScrollMode.AUTO,
        )

        back_btn = ft.IconButton(
            icon=ft.Icons.ARROW_BACK,
            on_click=lambda _: self._route_on_back(),
            tooltip="Volver",
        )

        self.content = ft.Column(
            controls=[
                ft.Row(
                    controls=[
                        back_btn,
                        self._ft_progress_text,
                        ft.Container(expand=True),
                        ft.Icon(ft.Icons.SLIDESHOW, color=ft.Colors.BLUE_700),
                    ],
                    alignment=ft.MainAxisAlignment.START,
                ),
                ft.Divider(height=1),
                self._ft_content_area,
            ],
            expand=True,
        )
        self.expand = True
        self.padding = 20

    # =========================================================================
    # RENDERIZADO PARCIAL
    # =========================================================================
    def _render_loading(self) -> None:
        """Renderiza estado de carga."""
        if not self._ft_content_area:
            return

        self._is_card_mounted = False
        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.append(
            ft.Container(
                content=ft.ProgressRing(),
                alignment=ft.Alignment.CENTER,
                expand=True,
            )
        )

    def _render_sliding(self, dto: WordSliderViewDto) -> None:
        """Renderiza la palabra actual en su fase de reproducción."""
        if not self._ft_content_area or not dto.current_word or not self._ft_slider_card:
            return

        word = dto.current_word

        # Montar la tarjeta persistente una sola vez para preservar la animación
        if not self._is_card_mounted:
            self._ft_content_area.controls.clear()
            self._ft_content_area.controls.extend([
                ft.Container(height=20),
                ft.Row(
                    controls=[self._ft_slider_card],
                    alignment=ft.MainAxisAlignment.CENTER,
                ),
            ])
            self._is_card_mounted = True

        self._ft_slider_card.render(
            text_es=word.get("text_es", ""),
            text_lang=word.get("text_lang", ""),
            pronunciation=word.get("pronunciation", ""),
            show_translation=dto.show_translation,
            phase_label=dto.phase_label,
            word_key=str(dto.current_index),
            image_file_path=word.get("image_file_path", ""),
            word_id=word.get("word_es_id", ""),
        )

    def _render_no_words(self) -> None:
        """Renderiza mensaje cuando no hay palabras."""
        if not self._ft_content_area:
            return

        self._is_card_mounted = False
        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.extend([
            ft.Container(height=40),
            ft.Icon(ft.Icons.INBOX_OUTLINED, size=60, color=ft.Colors.ORANGE_400),
            ft.Container(height=20),
            ft.Text(
                "No hay palabras para reproducir",
                size=20,
                weight=ft.FontWeight.BOLD,
            ),
            ft.Text(
                "Selecciona otro grupo o idioma con traducciones disponibles",
                size=14,
                color=ft.Colors.GREY_600,
            ),
            ft.Container(height=30),
            ft.ElevatedButton(
                content=ft.Text("Volver"),
                on_click=lambda _: self._route_on_back(),
            ),
        ])

    def _render_session_complete(self, dto: WordSliderViewDto) -> None:
        """Renderiza sesión completada."""
        if not self._ft_content_area:
            return

        self._is_card_mounted = False
        action_buttons = []

        if self._route_on_replay:
            replay_btn = ft.ElevatedButton(
                content=ft.Row(
                    [ft.Icon(ft.Icons.REPLAY), ft.Text("Repetir slider")],
                    alignment=ft.MainAxisAlignment.CENTER,
                ),
                on_click=lambda _: self._route_on_replay(),
                style=ft.ButtonStyle(
                    bgcolor=ft.Colors.TEAL_600,
                    color=ft.Colors.WHITE,
                ),
            )
            action_buttons.append(replay_btn)

        home_btn = ft.ElevatedButton(
            content=ft.Row(
                [ft.Icon(ft.Icons.HOME), ft.Text("Volver al inicio")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=lambda _: self._route_on_back(),
            style=ft.ButtonStyle(
                bgcolor=ft.Colors.BLUE_700,
                color=ft.Colors.WHITE,
            ),
        )
        action_buttons.append(home_btn)

        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.extend([
            ft.Container(height=20),
            ft.Icon(ft.Icons.CELEBRATION, size=50, color=ft.Colors.AMBER_500),
            ft.Container(height=10),
            ft.Text("¡Slider completado!", size=24, weight=ft.FontWeight.BOLD),
            ft.Container(height=10),
            ft.Text(f"Palabras reproducidas: {dto.total_words}", size=18),
            ft.Container(height=40),
            ft.Row(
                controls=action_buttons,
                alignment=ft.MainAxisAlignment.CENTER,
                spacing=20,
            ),
        ])

    def _render_error(self, message: str) -> None:
        """Renderiza mensaje de error."""
        if not self._ft_content_area:
            return

        self._is_card_mounted = False
        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.extend([
            ft.Container(height=40),
            ft.Icon(ft.Icons.ERROR_OUTLINE, size=60, color=ft.Colors.RED_400),
            ft.Container(height=20),
            ft.Text("Error", size=20, weight=ft.FontWeight.BOLD),
            ft.Text(message, size=14, color=ft.Colors.GREY_600),
            ft.Container(height=30),
            ft.ElevatedButton(
                content=ft.Text("Volver"),
                on_click=lambda _: self._route_on_back(),
            ),
        ])
