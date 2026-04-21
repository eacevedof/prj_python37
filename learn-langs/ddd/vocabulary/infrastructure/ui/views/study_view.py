"""Vista de sesion de estudio - Solo renderizado."""

import flet as ft
from typing import Callable, Any, Self, TYPE_CHECKING

from ddd.vocabulary.infrastructure.ui.components.flashcard_comp import FlashcardComp
from ddd.vocabulary.infrastructure.ui.components.timer_comp import TimerComp
from ddd.vocabulary.infrastructure.ui.components.input_field_comp import InputFieldComp

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

    def __init__(
        self,
        on_answer: Callable[[str], None],
        on_skip: Callable[[], None],
        on_timeout: Callable[[], None],
        on_back: Callable[[], None],
        on_mount: Callable[[], None] | None = None,
    ):
        super().__init__()

        self._on_answer = on_answer
        self._on_skip = on_skip
        self._on_timeout = on_timeout
        self._on_back = on_back
        self._on_mount = on_mount

        # UI components
        self._content_area: ft.Column | None = None
        self._flashcard: FlashcardComp | None = None
        self._input_field: InputFieldComp | None = None
        self._timer: TimerComp | None = None
        self._progress_text: ft.Text | None = None
        self._score_text: ft.Text | None = None

        self._build_ui()

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            on_answer=primitives.get("on_answer", lambda x: None),
            on_skip=primitives.get("on_skip", lambda: None),
            on_timeout=primitives.get("on_timeout", lambda: None),
            on_back=primitives.get("on_back", lambda: None),
            on_mount=primitives.get("on_mount"),
        )

    def did_mount(self) -> None:
        """Flet llama esto al montar. Notifica al Controller."""
        if self._on_mount:
            self._on_mount()

    def _build_ui(self) -> None:
        self._progress_text = ft.Text("Cargando...", size=14)
        self._score_text = ft.Text("Score: 0%", size=14, weight=ft.FontWeight.BOLD)

        self._content_area = ft.Column(
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

        back_btn = ft.IconButton(
            icon=ft.Icons.ARROW_BACK,
            on_click=lambda _: self._on_back(),
            tooltip="Volver",
        )

        self.content = ft.Column(
            controls=[
                ft.Row(
                    controls=[
                        back_btn,
                        self._progress_text,
                        ft.Container(expand=True),
                        self._score_text,
                    ],
                    alignment=ft.MainAxisAlignment.START,
                ),
                ft.Divider(height=1),
                self._content_area,
            ],
            expand=True,
        )
        self.expand = True
        self.padding = 20

    def render(self, dto: "StudyViewDto") -> None:
        """Renderiza la vista basado en el DTO."""
        # Actualizar header
        if self._progress_text:
            self._progress_text.value = dto.progress_text

        if self._score_text:
            self._score_text.value = dto.score_text

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

    def _render_loading(self) -> None:
        """Renderiza estado de carga."""
        if not self._content_area:
            return

        self._content_area.controls.clear()
        self._content_area.controls.append(
            ft.Container(
                content=ft.ProgressRing(),
                alignment=ft.Alignment.CENTER,
                expand=True,
            )
        )

    def _render_studying(self, dto: "StudyViewDto") -> None:
        """Renderiza palabra actual para estudiar."""
        if not self._content_area or not dto.current_word:
            return

        word = dto.current_word

        # Crear flashcard
        self._flashcard = FlashcardComp(
            text_es=word.get("text_es", ""),
            text_lang=word.get("text_lang", ""),
            word_type=word.get("word_type", ""),
            pronunciation=word.get("pronunciation", ""),
            show_translation=False,
        )

        # Crear input
        self._input_field = InputFieldComp(
            placeholder="Escribe la traduccion...",
            on_submit=self._on_answer,
            on_skip=self._on_skip,
        )

        # Crear timer
        self._timer = TimerComp(
            seconds=30,
            on_timeout=self._on_timeout,
            auto_start=True,
        )

        self._content_area.controls.clear()
        self._content_area.controls.extend([
            ft.Container(height=20),
            ft.Container(
                content=self._timer,
                alignment=ft.Alignment.CENTER,
            ),
            ft.Container(height=20),
            ft.Container(
                content=self._flashcard,
                alignment=ft.Alignment.CENTER,
            ),
            ft.Container(height=30),
            self._input_field,
        ])

    def _render_with_result(self, dto: "StudyViewDto") -> None:
        """Renderiza resultado de respuesta."""
        if not dto.last_result or not self._input_field or not self._flashcard:
            return

        # Detener timer
        if self._timer:
            self._timer.stop()

        # Mostrar resultado en input
        is_correct = dto.last_result.get("is_correct", False)
        correct_answer = dto.last_result.get("correct_answer", "")

        self._input_field.set_disabled(True)
        self._input_field.show_result(is_correct, correct_answer)

        # Revelar traduccion en flashcard
        self._flashcard.reveal_translation()

    def _render_no_words(self) -> None:
        """Renderiza mensaje cuando no hay palabras."""
        if not self._content_area:
            return

        self._content_area.controls.clear()
        self._content_area.controls.extend([
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
                on_click=lambda _: self._on_back(),
            ),
        ])

    def _render_session_complete(self, dto: "StudyViewDto") -> None:
        """Renderiza sesion completada."""
        if not self._content_area:
            return

        self._content_area.controls.clear()
        self._content_area.controls.extend([
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
                on_click=lambda _: self._on_back(),
                style=ft.ButtonStyle(
                    bgcolor=ft.Colors.BLUE_700,
                    color=ft.Colors.WHITE,
                ),
            ),
        ])

    def _render_error(self, message: str) -> None:
        """Renderiza mensaje de error."""
        if not self._content_area:
            return

        self._content_area.controls.clear()
        self._content_area.controls.extend([
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
                on_click=lambda _: self._on_back(),
            ),
        ])
