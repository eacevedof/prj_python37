"""Vista de sesión de estudio con imágenes - Solo renderizado."""

from typing import Any, Callable, Self

import flet as ft

from ddd.vocabulary.infrastructure.ui.components.image_flashcard_comp import ImageFlashcardComp
from ddd.vocabulary.infrastructure.ui.components.input_field_comp import InputFieldComp
from ddd.vocabulary.infrastructure.ui.components.timer_comp import TimerComp
from ddd.vocabulary.infrastructure.ui.views.image_study_view_dto import ImageStudyViewDto


class ImageStudyView(ft.Container):
    """
    Vista de sesión de estudio con imágenes.

    Responsabilidades:
    - Renderizar UI basada en ImageStudyViewDto
    - Mostrar imagen de la palabra como pista visual
    - Emitir eventos al Controller via callbacks
    - NO tiene lógica de negocio
    """

    # =========================================================================
    # CONSTRUCCIÓN
    # =========================================================================
    def __init__(
        self,
        route_on_mount: Callable[[], None] | None,
        route_on_answer: Callable[[str], None],
        route_on_skip: Callable[[], None],
        route_on_timeout: Callable[[], None],
        route_on_back: Callable[[], None],
        route_on_retry_failed: Callable[[], None],
    ):
        super().__init__()

        # Callbacks al controller
        self._route_on_mount = route_on_mount
        self._route_on_answer = route_on_answer
        self._route_on_skip = route_on_skip
        self._route_on_timeout = route_on_timeout
        self._route_on_back = route_on_back
        self._route_on_retry_failed = route_on_retry_failed

        # Componentes UI - Header
        self._ft_progress_text: ft.Text | None = None
        self._ft_score_text: ft.Text | None = None

        # Componentes UI - Content Area
        self._ft_content_area: ft.Column | None = None
        self._ft_image_flashcard: ImageFlashcardComp | None = None
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
            route_on_retry_failed=primitives.get("on_retry_failed", lambda: None),
        )

    # =========================================================================
    # API PÚBLICA - RENDERIZADO
    # =========================================================================
    def render(self, dto: ImageStudyViewDto) -> None:
        """Renderiza la vista basado en el DTO."""
        # Actualizar header
        if self._ft_progress_text:
            self._ft_progress_text.value = dto.progress_text

        if self._ft_score_text:
            self._ft_score_text.value = dto.score_text

        # Renderizar según estado
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
        # Header components
        self._ft_progress_text = ft.Text("Cargando...", size=14)
        self._ft_score_text = ft.Text("Score: 0%", size=14, weight=ft.FontWeight.BOLD)

        # Content area
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
    # RENDERIZADO PARCIAL
    # =========================================================================
    def _render_loading(self) -> None:
        """Renderiza estado de carga."""
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

    def _render_studying(self, dto: ImageStudyViewDto) -> None:
        """Renderiza palabra actual con imagen."""
        if not self._ft_content_area or not dto.current_word:
            return

        word = dto.current_word

        # Crear componentes dinámicos
        self._ft_image_flashcard = ImageFlashcardComp(
            image_file_path=word.get("image_file_path", ""),
            image_caption=word.get("text_es", ""),  # Solo español, sin traducción
            text_lang=word.get("text_lang", ""),
            pronunciation=word.get("pronunciation", ""),
            show_translation=False,
        )

        self._ft_input_field = InputFieldComp(
            placeholder="Escribe la traducción...",
            on_submit=self._route_on_answer,
            on_skip=self._route_on_skip,
        )

        self._ft_timer = TimerComp(
            seconds=20,
            on_timeout=self._route_on_timeout,
            auto_start=True,
        )

        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.extend([
            ft.Container(height=10),
            ft.Container(
                content=self._ft_timer,
                alignment=ft.Alignment.CENTER,
            ),
            ft.Container(height=15),
            ft.Container(
                content=self._ft_image_flashcard,
                alignment=ft.Alignment.CENTER,
            ),
            ft.Container(height=20),
            self._ft_input_field,
        ])

    def _render_with_result(self, dto: ImageStudyViewDto) -> None:
        """Renderiza resultado de respuesta."""
        if not dto.last_result or not self._ft_input_field or not self._ft_image_flashcard:
            return

        # Detener timer
        if self._ft_timer:
            self._ft_timer.stop()

        # Mostrar resultado
        is_correct = dto.last_result.get("is_correct", False)
        correct_answer = dto.last_result.get("correct_answer", "")

        self._ft_input_field.set_disabled(True)
        self._ft_input_field.show_result(is_correct, correct_answer)

        # Revelar traducción en flashcard
        self._ft_image_flashcard.reveal_translation()
        self._ft_image_flashcard.set_result_style(is_correct)

    def _render_no_words(self) -> None:
        """Renderiza mensaje cuando no hay palabras con imágenes."""
        if not self._ft_content_area:
            return

        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.extend([
            ft.Container(height=40),
            ft.Icon(
                ft.Icons.IMAGE_NOT_SUPPORTED_OUTLINED,
                size=60,
                color=ft.Colors.ORANGE_400,
            ),
            ft.Container(height=20),
            ft.Text(
                "No hay palabras con imágenes para practicar",
                size=20,
                weight=ft.FontWeight.BOLD,
            ),
            ft.Text(
                "Añade imágenes a las palabras en el idioma seleccionado",
                size=14,
                color=ft.Colors.GREY_600,
            ),
            ft.Container(height=30),
            ft.ElevatedButton(
                content=ft.Text("Volver"),
                on_click=lambda _: self._route_on_back(),
            ),
        ])

    def _render_session_complete(self, dto: ImageStudyViewDto) -> None:
        """Renderiza sesión completada."""
        if not self._ft_content_area:
            return

        controls = [
            ft.Container(height=40),
            ft.Icon(
                ft.Icons.CELEBRATION,
                size=80,
                color=ft.Colors.AMBER_500,
            ),
            ft.Container(height=20),
            ft.Text(
                "¡Sesión completada!",
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
        ]

        # Mostrar palabras falladas si hay
        if dto.failed_words:
            # Preparar texto para copiar
            failed_words_text = "\n".join([
                f"{word.get('text_es', '')} = {word.get('text_lang', '')}"
                for word in dto.failed_words
            ])

            controls.extend([
                ft.Container(height=30),
                ft.Divider(height=1, color=ft.Colors.GREY_400),
                ft.Container(height=15),
                ft.Row(
                    controls=[
                        ft.Text(
                            f"Palabras falladas ({len(dto.failed_words)}):",
                            size=18,
                            weight=ft.FontWeight.BOLD,
                            color=ft.Colors.RED_700,
                        ),
                        ft.IconButton(
                            icon=ft.Icons.COPY,
                            tooltip="Copiar al portapapeles",
                            icon_color=ft.Colors.BLUE_700,
                            on_click=lambda _: self._copy_to_clipboard(failed_words_text),
                        ),
                    ],
                    alignment=ft.MainAxisAlignment.SPACE_BETWEEN,
                ),
                ft.Container(height=10),
            ])

            # Lista de palabras falladas (seleccionable)
            failed_list = ft.Column(
                controls=[
                    ft.Container(
                        content=ft.Row(
                            controls=[
                                ft.Text(
                                    word.get("text_es", ""),
                                    size=14,
                                    weight=ft.FontWeight.W_500,
                                    expand=True,
                                    selectable=True,
                                ),
                                ft.Text(
                                    "=",
                                    size=14,
                                    color=ft.Colors.GREY_600,
                                ),
                                ft.Text(
                                    word.get("text_lang", ""),
                                    size=14,
                                    color=ft.Colors.GREEN_700,
                                    weight=ft.FontWeight.W_500,
                                    expand=True,
                                    selectable=True,
                                ),
                            ],
                            alignment=ft.MainAxisAlignment.CENTER,
                        ),
                        padding=ft.padding.symmetric(vertical=4, horizontal=10),
                    )
                    for word in dto.failed_words
                ],
                spacing=2,
                scroll=ft.ScrollMode.AUTO,
            )

            controls.append(
                ft.Container(
                    content=failed_list,
                    border=ft.border.all(1, ft.Colors.RED_300),
                    border_radius=8,
                    padding=10,
                    bgcolor=ft.Colors.RED_50,
                    height=200,
                )
            )

        # Botones de acción
        action_buttons = []

        # Botón de repetir errores (solo si hay palabras falladas)
        if dto.failed_words:
            retry_btn = ft.ElevatedButton(
                content=ft.Row(
                    [ft.Icon(ft.Icons.REFRESH), ft.Text("Repetir errores")],
                    alignment=ft.MainAxisAlignment.CENTER,
                ),
                on_click=lambda _: self._route_on_retry_failed(),
                style=ft.ButtonStyle(
                    bgcolor=ft.Colors.ORANGE_700,
                    color=ft.Colors.WHITE,
                ),
            )
            action_buttons.append(retry_btn)

        # Botón de volver al inicio
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

        controls.extend([
            ft.Container(height=40),
            ft.Row(
                controls=action_buttons,
                alignment=ft.MainAxisAlignment.CENTER,
                spacing=20,
            ),
        ])

        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.extend(controls)

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

    def _copy_to_clipboard(self, text: str) -> None:
        """Copia texto al portapapeles usando pyperclip."""
        if self.page:
            try:
                import pyperclip
                pyperclip.copy(text)
                message = "Palabras copiadas al portapapeles"
                color = ft.Colors.GREEN_700
            except Exception as e:
                # Si pyperclip no está disponible, el texto ya es seleccionable manualmente
                message = "Selecciona el texto para copiarlo manualmente (Ctrl+C)"
                color = ft.Colors.BLUE_700

            self.page.snack_bar = ft.SnackBar(
                content=ft.Text(message),
                bgcolor=color,
            )
            self.page.snack_bar.open = True
            self.page.update()
