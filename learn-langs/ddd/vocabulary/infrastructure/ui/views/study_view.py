"""Vista de sesion de estudio - Solo renderizado."""

from typing import TYPE_CHECKING, Any, Callable, Self

import flet as ft

from ddd.vocabulary.infrastructure.ui.components.flashcard_comp import FlashcardComp
from ddd.vocabulary.infrastructure.ui.components.input_field_comp import InputFieldComp
from ddd.vocabulary.infrastructure.ui.components.timer_comp import TimerComp

if TYPE_CHECKING:
    from ddd.vocabulary.infrastructure.ui.views.study_view_dto import StudyViewDto


class StudyView(ft.Container):
    """
    Vista de sesion de estudio.

    Responsabilidades:
    - Renderizar UI basada en StudyViewDto
    - Emitir eventos al Controller via callbacks
    - NO tiene logica de negocio
    - NO importa servicios ni repositorios
    """

    # =========================================================================
    # CONSTRUCCIÓN (Public API)
    # =========================================================================
    def __init__(
        self,
        route_on_mount: Callable[[], None] | None,  # 1. Lifecycle (se ejecuta primero)
        route_on_answer: Callable[[str], None],     # 2. Input field (render paso 1 - input)
        route_on_skip: Callable[[], None],          # 3. Skip button (junto al input)
        route_on_timeout: Callable[[], None],       # 4. Timer timeout (render paso 1 - timer)
        route_on_back: Callable[[], None],          # 5. Boton volver (header)
    ):
        super().__init__()

        # Callbacks al controller (en orden de ejecución)
        self._route_on_mount = route_on_mount
        self._route_on_answer = route_on_answer
        self._route_on_skip = route_on_skip
        self._route_on_timeout = route_on_timeout
        self._route_on_back = route_on_back

        # Componentes UI - Header
        self._ft_progress_text: ft.Text | None = None
        self._ft_score_text: ft.Text | None = None

        # Componentes UI - Content Area (dinámico)
        self._ft_content_area: ft.Column | None = None
        self._ft_flashcard: FlashcardComp | None = None
        self._ft_input_field: InputFieldComp | None = None
        self._ft_timer: TimerComp | None = None

        self._build_initial_ui()

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        """Crea la vista desde un diccionario de callbacks."""
        return cls(
            route_on_mount=primitives.get("on_mount"),
            route_on_answer=primitives.get("on_answer", lambda x: None),
            route_on_skip=primitives.get("on_skip", lambda: None),
            route_on_timeout=primitives.get("on_timeout", lambda: None),
            route_on_back=primitives.get("on_back", lambda: None),
        )

    # =========================================================================
    # API PÚBLICA - RENDERIZADO
    # =========================================================================
    def render(self, dto: "StudyViewDto") -> None:
        """Renderiza la vista basado en el DTO."""
        # Actualizar header
        if self._ft_progress_text:
            self._ft_progress_text.value = dto.progress_text

        if self._ft_score_text:
            self._ft_score_text.value = dto.score_text

        # Renderizar segun estado
        if dto.is_loading:
            self._render_loading()
        elif dto.error_message:
            self._render_error(dto.error_message)
        elif dto.has_no_words:
            self._render_no_words()
        elif dto.is_session_complete:
            self._render_session_complete(dto)
        elif dto.last_result:
            self._render_with_result(dto)
        elif dto.current_word:
            self._render_studying(dto)

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
        # Header components
        self._ft_progress_text = ft.Text("Cargando...", size=14)
        self._ft_score_text = ft.Text("Score: 0%", size=14, weight=ft.FontWeight.BOLD)

        # Content area (dinámico)
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
        )

        # Back button
        back_btn = ft.IconButton(
            icon=ft.Icons.ARROW_BACK,
            on_click=lambda _: self._route_on_back(),
            tooltip="Volver",
        )

        # Layout principal
        self.content = ft.Column(
            controls=[
                ft.Row(
                    controls=[
                        back_btn,
                        self._ft_progress_text,
                        ft.Container(expand=True),
                        self._ft_score_text,
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
    # RENDERIZADO PARCIAL (en orden de ejecución en render())
    # =========================================================================
    def _render_loading(self) -> None:
        """Renderiza estado de carga (primer estado al montar)."""
        if not self._ft_content_area:
            return

        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.append(
            ft.Container(
                content=ft.ProgressRing(),
                alignment=ft.Alignment.CENTER,
                expand=True,
            )
        )

    def _render_studying(self, dto: "StudyViewDto") -> None:
        """Renderiza palabra actual para estudiar (estado principal)."""
        if not self._ft_content_area or not dto.current_word:
            return

        word = dto.current_word

        # Crear componentes dinámicos
        self._ft_flashcard = FlashcardComp(
            text_es=word.get("text_es", ""),
            text_lang=word.get("text_lang", ""),
            word_type=word.get("word_type", ""),
            pronunciation=word.get("pronunciation", ""),
            show_translation=False,
        )

        self._ft_input_field = InputFieldComp(
            placeholder="Escribe la traduccion...",
            on_submit=self._route_on_answer,
            on_skip=self._route_on_skip,
        )

        self._ft_timer = TimerComp(
            seconds=30,
            on_timeout=self._route_on_timeout,
            auto_start=True,
        )

        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.extend([
            ft.Container(height=20),
            ft.Container(
                content=self._ft_timer,
                alignment=ft.Alignment.CENTER,
            ),
            ft.Container(height=20),
            ft.Container(
                content=self._ft_flashcard,
                alignment=ft.Alignment.CENTER,
            ),
            ft.Container(height=30),
            self._ft_input_field,
        ])

    def _render_with_result(self, dto: "StudyViewDto") -> None:
        """Renderiza resultado de respuesta (post-answer antes de next word)."""
        if not dto.last_result or not self._ft_input_field or not self._ft_flashcard:
            return

        # Detener timer
        if self._ft_timer:
            self._ft_timer.stop()

        # Mostrar resultado en input
        is_correct = dto.last_result.get("is_correct", False)
        correct_answer = dto.last_result.get("correct_answer", "")

        self._ft_input_field.set_disabled(True)
        self._ft_input_field.show_result(is_correct, correct_answer)

        # Revelar traduccion en flashcard y aplicar estilo segun resultado
        self._ft_flashcard.reveal_translation()
        self._ft_flashcard.set_result_style(is_correct)

    def _render_no_words(self) -> None:
        """Renderiza mensaje cuando no hay palabras para practicar."""
        if not self._ft_content_area:
            return

        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.extend([
            ft.Container(height=40),
            ft.Icon(
                ft.Icons.INFO_OUTLINE,
                size=60,
                color=ft.Colors.BLUE_400,
            ),
            ft.Container(height=20),
            ft.Text(
                "No hay palabras para practicar",
                size=20,
                weight=ft.FontWeight.BOLD,
            ),
            ft.Text(
                "Anade palabras con traduccion al idioma seleccionado",
                size=14,
                color=ft.Colors.GREY_600,
            ),
            ft.Container(height=30),
            ft.ElevatedButton(
                content=ft.Text("Volver"),
                on_click=lambda _: self._route_on_back(),
            ),
        ])

    def _render_session_complete(self, dto: "StudyViewDto") -> None:
        """Renderiza sesion completada con resumen de stats."""
        if not self._ft_content_area:
            return

        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.extend([
            ft.Container(height=40),
            ft.Icon(
                ft.Icons.CELEBRATION,
                size=80,
                color=ft.Colors.AMBER_500,
            ),
            ft.Container(height=20),
            ft.Text(
                "Sesion completada!",
                size=28,
                weight=ft.FontWeight.BOLD,
            ),
            ft.Container(height=20),
            ft.Text(
                f"Palabras practicadas: {dto.answers_count}",
                size=18,
            ),
            ft.Text(
                f"Score promedio: {dto.avg_score_percent}%",
                size=24,
                weight=ft.FontWeight.BOLD,
                color=ft.Colors.GREEN_700 if dto.avg_score_percent >= 70 else ft.Colors.ORANGE_700,
            ),
            ft.Container(height=40),
            ft.ElevatedButton(
                content=ft.Row(
                    [ft.Icon(ft.Icons.HOME), ft.Text("Volver al inicio")],
                    alignment=ft.MainAxisAlignment.CENTER,
                ),
                on_click=lambda _: self._route_on_back(),
                style=ft.ButtonStyle(
                    bgcolor=ft.Colors.BLUE_700,
                    color=ft.Colors.WHITE,
                ),
            ),
        ])

    def _render_error(self, message: str) -> None:
        """Renderiza mensaje de error."""
        if not self._ft_content_area:
            return

        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.extend([
            ft.Container(height=40),
            ft.Icon(
                ft.Icons.ERROR_OUTLINE,
                size=60,
                color=ft.Colors.RED_400,
            ),
            ft.Container(height=20),
            ft.Text(
                "Error",
                size=20,
                weight=ft.FontWeight.BOLD,
            ),
            ft.Text(message, size=14, color=ft.Colors.GREY_600),
            ft.Container(height=30),
            ft.ElevatedButton(
                content=ft.Text("Volver"),
                on_click=lambda _: self._route_on_back(),
            ),
        ])

    # =========================================================================
    # EVENT HANDLERS (Callbacks de UI)
    # =========================================================================
    # Nota: Los callbacks están conectados directamente en _build_initial_ui
    # y en los componentes dinámicos (FlashcardComp, InputFieldComp, TimerComp)
