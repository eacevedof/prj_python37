"""Vista de sesion de estudio."""

import asyncio
import time
import flet as ft
from typing import Callable

from ddd.vocabulary.application.start_study_session import (
    StartStudySessionDto,
    StartStudySessionService,
    StudyWordDto,
)
from ddd.vocabulary.application.record_answer import (
    RecordAnswerDto,
    RecordAnswerService,
)
from ddd.vocabulary.infrastructure.repositories import SessionsWriterSqliteRepository
from ddd.vocabulary.infrastructure.ui.components.flashcard_comp import FlashcardComp
from ddd.vocabulary.infrastructure.ui.components.timer_comp import TimerComp
from ddd.vocabulary.infrastructure.ui.components.input_field_comp import InputFieldComp


class StudyView(ft.Container):
    """Vista de sesion de estudio con flashcards."""

    def __init__(
        self,
        lang_code: str,
        tags: list[str],
        on_back: Callable[[], None],
    ):
        super().__init__()
        self.lang_code = lang_code
        self.tags = tags
        self.on_back = on_back

        self.session_id: int = 0
        self.words: list[StudyWordDto] = []
        self.current_index: int = 0
        self.start_time: float = 0

        self._content_area: ft.Column | None = None
        self._flashcard: FlashcardComp | None = None
        self._input_field: InputFieldComp | None = None
        self._timer: TimerComp | None = None
        self._progress_text: ft.Text | None = None
        self._score_text: ft.Text | None = None

        self.total_score: float = 0
        self.answers_count: int = 0

        self._build_ui()

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
            on_click=lambda _: self._finish_and_back(),
            tooltip="Volver",
        )

        self.content = ft.Column(
            controls=[
                # Header con navegacion y progreso
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
                # Contenido principal
                self._content_area,
            ],
            expand=True,
        )
        self.expand = True
        self.padding = 20

    def did_mount(self) -> None:
        """Inicia la sesion al montar."""
        self.page.run_task(self._start_session)

    async def _start_session(self) -> None:
        """Inicia la sesion de estudio."""
        try:
            dto = StartStudySessionDto.from_primitives({
                "lang_code": self.lang_code,
                "study_mode": "TYPING",
                "tags": self.tags,
                "limit": 20,
            })

            service = StartStudySessionService.get_instance()
            result = await service(dto)

            self.session_id = result.session_id
            self.words = list(result.words)

            if self.words:
                self._show_current_word()
            else:
                self._show_no_words()

        except Exception as e:
            self._show_error(str(e))

    def _show_current_word(self) -> None:
        """Muestra la palabra actual."""
        if self.current_index >= len(self.words):
            self._show_session_complete()
            return

        word = self.words[self.current_index]
        self.start_time = time.time()

        # Actualizar progreso
        if self._progress_text:
            self._progress_text.value = f"Palabra {self.current_index + 1} de {len(self.words)}"

        # Crear flashcard
        self._flashcard = FlashcardComp(
            text_es=word.text_es,
            text_lang=word.text_lang,
            word_type=word.word_type,
            pronunciation=word.pronunciation,
            show_translation=False,
        )

        # Crear input
        self._input_field = InputFieldComp(
            placeholder="Escribe la traduccion...",
            on_submit=self._handle_answer,
            on_skip=self._handle_skip,
        )

        # Crear timer
        self._timer = TimerComp(
            seconds=30,
            on_timeout=self._handle_timeout,
            auto_start=True,
        )

        if self._content_area:
            self._content_area.controls.clear()
            self._content_area.controls.extend([
                ft.Container(height=20),
                # Timer
                ft.Container(
                    content=self._timer,
                    alignment=ft.Alignment.CENTER,
                ),
                ft.Container(height=20),
                # Flashcard
                ft.Container(
                    content=self._flashcard,
                    alignment=ft.Alignment.CENTER,
                ),
                ft.Container(height=30),
                # Input
                self._input_field,
            ])
            self.update()

    def _handle_answer(self, user_input: str) -> None:
        """Procesa la respuesta del usuario."""
        self.page.run_task(lambda: self._process_answer(user_input))

    async def _process_answer(self, user_input: str) -> None:
        """Procesa y registra la respuesta."""
        if self._timer:
            self._timer.stop()

        word = self.words[self.current_index]
        response_time = int((time.time() - self.start_time) * 1000)

        try:
            dto = RecordAnswerDto.from_primitives({
                "session_id": self.session_id,
                "word_es_id": word.word_es_id,
                "user_input": user_input,
                "expected_text": word.text_lang,
                "response_time_ms": response_time,
            })

            service = RecordAnswerService.get_instance()
            result = await service(dto)

            # Actualizar score
            self.total_score += result.score
            self.answers_count += 1
            self._update_score_display()

            # Mostrar resultado
            self._show_result(result.is_correct, result.score, word.text_lang)

        except Exception as e:
            print(f"Error recording answer: {e}")
            self._next_word()

    def _handle_skip(self) -> None:
        """Maneja cuando el usuario salta la pregunta."""
        self.page.run_task(lambda: self._process_answer(""))

    def _handle_timeout(self) -> None:
        """Maneja cuando se acaba el tiempo."""
        self.page.run_task(lambda: self._process_answer(""))

    def _show_result(self, is_correct: bool, score: float, correct_answer: str) -> None:
        """Muestra el resultado y continua."""
        if self._input_field:
            self._input_field.set_disabled(True)
            self._input_field.show_result(is_correct, correct_answer)

        if self._flashcard:
            self._flashcard.reveal_translation()

        # Esperar y continuar
        async def wait_and_continue():
            wait_time = 2 if is_correct else 5  # 5 segundos si error
            await asyncio.sleep(wait_time)
            self._next_word()

        self.page.run_task(wait_and_continue)

    def _next_word(self) -> None:
        """Avanza a la siguiente palabra."""
        self.current_index += 1
        self._show_current_word()

    def _update_score_display(self) -> None:
        """Actualiza el display del score."""
        if self._score_text and self.answers_count > 0:
            avg_score = (self.total_score / self.answers_count) * 100
            self._score_text.value = f"Score: {avg_score:.0f}%"
            self.update()

    def _show_session_complete(self) -> None:
        """Muestra pantalla de sesion completada."""
        avg_score = (self.total_score / self.answers_count * 100) if self.answers_count > 0 else 0

        # Finalizar sesion
        self.page.run_task(self._finish_session)

        if self._content_area:
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
                    f"Palabras practicadas: {self.answers_count}",
                    size=18,
                ),
                ft.Text(
                    f"Score promedio: {avg_score:.0f}%",
                    size=24,
                    weight=ft.FontWeight.BOLD,
                    color=ft.Colors.GREEN_700 if avg_score >= 70 else ft.Colors.ORANGE_700,
                ),
                ft.Container(height=40),
                ft.ElevatedButton(
                    content=ft.Row(
                        [ft.Icon(ft.Icons.HOME), ft.Text("Volver al inicio")],
                        alignment=ft.MainAxisAlignment.CENTER,
                    ),
                    on_click=lambda _: self.on_back(),
                    style=ft.ButtonStyle(
                        bgcolor=ft.Colors.BLUE_700,
                        color=ft.Colors.WHITE,
                    ),
                ),
            ])
            self.update()

    async def _finish_session(self) -> None:
        """Finaliza la sesion en la base de datos."""
        if self.session_id:
            writer = SessionsWriterSqliteRepository.get_instance()
            await writer.finish(self.session_id)

    def _finish_and_back(self) -> None:
        """Finaliza y vuelve al inicio."""
        self.page.run_task(self._finish_session)
        self.on_back()

    def _show_no_words(self) -> None:
        """Muestra mensaje cuando no hay palabras."""
        if self._content_area:
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
                    on_click=lambda _: self.on_back(),
                ),
            ])
            self.update()

    def _show_error(self, message: str) -> None:
        """Muestra mensaje de error."""
        if self._content_area:
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
                    on_click=lambda _: self.on_back(),
                ),
            ])
            self.update()
