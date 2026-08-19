"""Vista de sesión de estudio con imágenes - Solo renderizado."""

from typing import Any, Callable, Self

import flet as ft

from ddd.vocabulary.infrastructure.ui.components.group_source_link_comp import GroupSourceLinkComp
from ddd.vocabulary.infrastructure.ui.components.image_flashcard_comp import ImageFlashcardComp
from ddd.vocabulary.infrastructure.ui.components.input_field_comp import InputFieldComp
from ddd.vocabulary.infrastructure.ui.components.rules_help_dialog_comp import (
    RulesHelpDialogComp,
)
from ddd.vocabulary.infrastructure.ui.components.timer_comp import TimerComp
from ddd.vocabulary.infrastructure.ui.enums.slider_card_size_enum import (
    SliderCardSizeEnum,
)
from ddd.vocabulary.infrastructure.ui.components.ui_scale import (
    get_page_scale,
    get_page_size,
    is_portrait,
)
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
        route_on_pause: Callable[[bool], None] | None = None,
        route_on_play_audio: Callable[[], None] | None = None,
    ):
        super().__init__()

        # Callbacks al controller
        self._route_on_mount = route_on_mount
        self._route_on_answer = route_on_answer
        self._route_on_skip = route_on_skip
        self._route_on_timeout = route_on_timeout
        self._route_on_back = route_on_back
        self._route_on_retry_failed = route_on_retry_failed
        self._route_on_pause = route_on_pause or (lambda _paused: None)
        self._route_on_play_audio = route_on_play_audio

        # Componentes UI - Header
        self._ft_progress_text: ft.Text | None = None
        self._ft_score_text: ft.Text | None = None
        self._ft_group_source_link: GroupSourceLinkComp | None = None

        # Componentes UI - Content Area
        self._ft_content_area: ft.Column | None = None
        self._ft_image_flashcard: ImageFlashcardComp | None = None
        self._ft_input_field: InputFieldComp | None = None
        self._ft_timer: TimerComp | None = None
        self._ft_pause_btn: ft.IconButton | None = None
        self._ft_help_btn: ft.IconButton | None = None
        self._ft_rules_help_dialog = RulesHelpDialogComp(
            route_on_close=self._on_help_dialog_close
        )
        self.__is_paused: bool = False
        # True mientras se muestra la corrección (auto-avance): el botón de pausa
        # congela el avance en vez de tocar el temporizador (ya parado).
        self.__in_review: bool = False
        # La pausa activa la provocó abrir la ayuda (hay que reanudar al cerrar)
        self.__is_paused_by_help: bool = False
        # Grupo de la sesión («<id> - <título>»), lo pinta la tarjeta
        self.__group_label: str = ""
        # Datos para el modal de ayuda (reglas de uso) de la palabra actual
        self.__current_word_text: str = ""
        self.__current_word_lang_text: str = ""
        self.__current_word_id: int | str = ""
        self.__current_rules_help: str = ""

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
            route_on_pause=primitives.get("on_pause", lambda _paused: None),
            route_on_play_audio=primitives.get("on_play_audio"),
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

    def render_group_source(self, group_source: str) -> None:
        """Muestra la fuente del grupo en la cabecera (clicable si es enlace)."""
        if self._ft_group_source_link:
            self._ft_group_source_link.render(group_source)
        self.update()

    def render_group_label(self, group_label: str) -> None:
        """Guarda el grupo de la sesión; lo pinta la tarjeta en su esquina izquierda."""
        self.__group_label = group_label

    # =========================================================================
    # LIFECYCLE HOOKS
    # =========================================================================
    def did_mount(self) -> None:
        """Flet llama esto al montar: engancha el atajo de teclado del examen."""
        if self.page:
            self.page.on_keyboard_event = self._on_keyboard
        if self._route_on_mount:
            self._route_on_mount()

    def will_unmount(self) -> None:
        """Flet llama esto al desmontar: suelta el atajo para no afectar a otras vistas."""
        if self.page and self.page.on_keyboard_event is self._on_keyboard:
            self.page.on_keyboard_event = None

    def _on_keyboard(self, event: ft.KeyboardEvent) -> None:
        """Atajo del examen: Ctrl+Espacio pausa/reanuda (pregunta o revisión).

        Se usa Ctrl+Espacio (no el espacio suelto) para no interferir con el tecleo
        de respuestas que llevan espacios. Es el mismo gesto que en el Aprendizaje.
        """
        if event.key == " " and event.ctrl and not event.alt and not event.meta:
            self._on_pause_click()

    # =========================================================================
    # CONSTRUCCIÓN DE UI
    # =========================================================================
    def _build_initial_ui(self) -> None:
        """Construye la estructura inicial de la UI."""
        # Header components
        self._ft_progress_text = ft.Text("Cargando...", size=14)
        self._ft_score_text = ft.Text("Score: 0%", size=14, weight=ft.FontWeight.BOLD)
        self._ft_group_source_link = GroupSourceLinkComp()

        # Content area
        # scroll AUTO: en pantallas bajas (tablet) el input y la botonera quedaban
        # ocultos bajo el borde sin forma de llegar a ellos
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

        # Back button
        back_btn = ft.IconButton(
            icon=ft.Icons.ARROW_BACK,
            on_click=lambda _: self._route_on_back(),
            tooltip="Salir del examen (abortar — no cuenta nada)",
        )

        # Layout principal
        self.content = ft.Column(
            controls=[
                ft.Row(
                    controls=[
                        back_btn,
                        self._ft_progress_text,
                        ft.Container(expand=True),
                        self._ft_group_source_link,
                        self._ft_score_text,
                    ],
                    alignment=ft.MainAxisAlignment.START,
                ),
                ft.Divider(height=1),
                self._ft_content_area,
            ],
            expand=True,
            # spacing por defecto de Column = 10: apretar los márgenes del
            # separador (cabecera → hr → contenido)
            spacing=4,
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

        self._ft_pause_btn = None  # sin pregunta activa: Ctrl+Espacio no-op
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

        # Datos para el modal de ayuda (el botón solo se ve si hay reglas)
        self.__current_word_text = word.get("text_es", "")
        self.__current_word_lang_text = word.get("text_lang", "")
        self.__current_word_id = word.get("word_es_id", "")
        self.__current_rules_help = word.get("rules_help", "") or ""

        # Crear componentes dinámicos. Escala/orientación se calculan aquí (la
        # vista ya está montada; el comp aún no y no puede leer self.page)
        self._ft_image_flashcard = ImageFlashcardComp(
            image_file_path=word.get("image_file_path", ""),
            image_caption=word.get("text_es", ""),  # Solo español, sin traducción
            text_lang=word.get("text_lang", ""),
            pronunciation=word.get("pronunciation", ""),
            show_translation=False,
            group_label=self.__group_label,
            word_id=word.get("word_es_id", ""),
            ui_scale=get_page_scale(self),
            is_vertical=is_portrait(self),
        )

        self._ft_input_field = InputFieldComp(
            placeholder="Escribe la traducción...",
            on_submit=self._route_on_answer,
            on_skip=self._route_on_skip,
        )

        self._ft_timer = TimerComp(
            seconds=dto.timer_seconds,
            on_timeout=self._route_on_timeout,
            auto_start=True,
        )

        # Botonera: pausa/reanudar (+ audio pista si está disponible)
        self.__is_paused = False
        self.__in_review = False  # arrancamos en fase de pregunta
        self._ft_pause_btn = ft.IconButton(
            icon=ft.Icons.PAUSE_CIRCLE,
            icon_size=32,
            tooltip="Pausar",
            on_click=lambda _: self._on_pause_click(),
            style=ft.ButtonStyle(color=ft.Colors.BLUE_GREY_700),
        )
        buttons_row_controls = [self._ft_pause_btn]
        if self._route_on_play_audio:
            buttons_row_controls.append(
                ft.IconButton(
                    icon=ft.Icons.VOLUME_UP,
                    icon_size=32,
                    tooltip="Escuchar pronunciación (pista)",
                    on_click=lambda _: self._route_on_play_audio(),
                    style=ft.ButtonStyle(color=ft.Colors.BLUE_700),
                )
            )
        # Botón de ayuda (reglas de uso), igual que en Aprendizaje: solo se VE si la
        # palabra tiene reglas (deshabilitado parecía que la ayuda no funcionaba);
        # al abrirlo se pausa el examen (temporizador o auto-avance) y al cerrarlo
        # se reanuda.
        buttons_row_controls.append(self._get_built_help_button())

        # Espaciados compactos, replicando los del Aprendizaje (mismo modo de
        # presentación): el alto es el recurso escaso en tablet
        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.extend([
            ft.Container(height=8),
            ft.Container(content=self._ft_timer, alignment=ft.Alignment.CENTER),
            ft.Container(height=8),
            ft.Container(content=self._ft_image_flashcard, alignment=ft.Alignment.CENTER),
            ft.Container(height=4),
            ft.Row(
                controls=buttons_row_controls,
                alignment=ft.MainAxisAlignment.CENTER,
                spacing=16,
            ),
            ft.Container(height=6),
            self._ft_input_field,
        ])

    def _on_pause_click(self) -> None:
        """Pausa/reanuda el examen: durante la pregunta detiene el temporizador;
        durante la revisión congela el auto-avance (vía callback al controller)."""
        if not self._ft_pause_btn:
            return
        self.__is_paused = not self.__is_paused
        if self.__is_paused:
            if not self.__in_review and self._ft_timer:
                self._ft_timer.stop()
            self._ft_pause_btn.icon = ft.Icons.PLAY_CIRCLE
            self._ft_pause_btn.tooltip = "Reanudar"
        else:
            if not self.__in_review and self._ft_timer:
                self._ft_timer.start()
            self._ft_pause_btn.icon = ft.Icons.PAUSE_CIRCLE
            self._ft_pause_btn.tooltip = "Pausar"
        # Avisar al controller para que el auto-avance respete la pausa
        self._route_on_pause(self.__is_paused)
        self.update()

    def _get_built_help_button(self) -> ft.IconButton:
        """Construye el botón de ayuda (reglas de uso) de la botonera del examen."""
        self._ft_help_btn = ft.IconButton(
            icon=ft.Icons.HELP_OUTLINE,
            icon_size=32,
            icon_color=ft.Colors.GREEN_700,
            tooltip="Reglas de uso: cuándo y cómo se usa",
            on_click=lambda _: self._on_help_btn_click(),
            visible=bool(self.__current_rules_help),
        )
        return self._ft_help_btn

    def _on_help_btn_click(self) -> None:
        """Muestra el modal de reglas de uso pausando el examen automáticamente.

        Al abrir pausa (temporizador durante la pregunta o auto-avance durante la
        revisión); al cerrar reanuda solo si la pausa la provocó la propia ayuda.
        """
        if not self.__current_rules_help or not self.page:
            return

        self.__is_paused_by_help = not self.__is_paused
        if self.__is_paused_by_help:
            self._on_pause_click()

        page_width, page_height = get_page_size(self)
        self._ft_rules_help_dialog.render(
            word_text=self.__current_word_text,
            word_lang_text=self.__current_word_lang_text,
            word_id=self.__current_word_id,
            rules_help=self.__current_rules_help,
            page_width=page_width,
            page_height=page_height,
        )
        if self._ft_rules_help_dialog not in self.page.overlay:
            self.page.overlay.append(self._ft_rules_help_dialog)
        self._ft_rules_help_dialog.open = True
        self.page.update()

    def _on_help_dialog_close(self) -> None:
        """Cierra la ayuda y reanuda el examen si lo había pausado ella."""
        self._ft_rules_help_dialog.open = False
        if self.__is_paused_by_help and self.__is_paused:
            self._on_pause_click()
        self.__is_paused_by_help = False
        self.page.update()

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
        user_input = dto.last_result.get("user_input", "")

        self._ft_input_field.set_disabled(True)
        self._ft_input_field.show_result(is_correct, correct_answer, user_input)

        # Revelar traducción en flashcard
        self._ft_image_flashcard.reveal_translation()
        self._ft_image_flashcard.set_result_style(is_correct)

        # Fase de revisión: el botón de pausa ahora congela el AUTO-AVANCE (no el
        # temporizador, que ya está parado). El botón sigue visible del render de
        # la pregunta; lo dejamos en estado "Pausar" (la revisión arranca sin pausa).
        self.__in_review = True
        self.__is_paused = False
        if self._ft_pause_btn:
            self._ft_pause_btn.icon = ft.Icons.PAUSE_CIRCLE
            self._ft_pause_btn.tooltip = "Pausar"

    def _render_no_words(self) -> None:
        """Renderiza mensaje cuando no hay palabras para practicar."""
        if not self._ft_content_area:
            return

        self._ft_pause_btn = None  # sin pregunta activa: Ctrl+Espacio no-op
        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.extend([
            ft.Container(height=40),
            ft.Icon(
                ft.Icons.INBOX_OUTLINED,
                size=60,
                color=ft.Colors.ORANGE_400,
            ),
            ft.Container(height=20),
            ft.Text(
                "No hay palabras para practicar",
                size=20,
                weight=ft.FontWeight.BOLD,
            ),
            ft.Text(
                "Añade o traduce palabras en el idioma seleccionado (la imagen es opcional)",
                size=14,
                color=ft.Colors.GREY_600,
            ),
            ft.Container(height=30),
            ft.ElevatedButton(
                content=ft.Text("Volver"),
                on_click=lambda _: self._route_on_back(),
            ),
        ])

    def _get_built_group_label_text(self) -> ft.Text:
        """Etiqueta del grupo para la pantalla de resultados (oculta si no hay grupo)."""
        return ft.Text(
            self.__group_label,
            size=SliderCardSizeEnum.GROUP_LABEL.value,
            color=ft.Colors.GREY_600,
            text_align=ft.TextAlign.CENTER,
            visible=bool(self.__group_label),
        )

    def _render_session_complete(self, dto: ImageStudyViewDto) -> None:
        """Renderiza sesión completada."""
        if not self._ft_content_area:
            return

        self._ft_pause_btn = None  # sesión terminada: Ctrl+Espacio no-op
        controls = [
            ft.Container(height=20),
            ft.Icon(
                ft.Icons.CELEBRATION,
                size=50,
                color=ft.Colors.AMBER_500,
            ),
            ft.Container(height=10),
            ft.Text(
                "¡Sesión completada!",
                size=24,
                weight=ft.FontWeight.BOLD,
            ),
            self._get_built_group_label_text(),
            ft.Container(height=10),
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
                ft.Container(height=15),
                ft.Divider(height=1, color=ft.Colors.GREY_400),
                ft.Container(height=10),
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
                        padding=ft.Padding(left=10, right=10, top=4, bottom=4),
                    )
                    for word in dto.failed_words
                ],
                spacing=2,
                scroll=ft.ScrollMode.AUTO,
            )

            # Altura dinámica: min 150, max 400
            list_height = min(400, max(150, len(dto.failed_words) * 35))

            controls.append(
                ft.Container(
                    content=failed_list,
                    border=ft.Border.all(1, ft.Colors.RED_300),
                    border_radius=8,
                    padding=10,
                    bgcolor=ft.Colors.RED_50,
                    height=list_height,
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

        self._ft_pause_btn = None  # sin pregunta activa: Ctrl+Espacio no-op
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
            except Exception:
                # Si pyperclip no está disponible, el texto ya es seleccionable manualmente
                message = "Selecciona el texto para copiarlo manualmente (Ctrl+C)"
                color = ft.Colors.BLUE_700

            # flet 0.86: page.snack_bar ya no existe; los diálogos se muestran
            # con show_dialog (el SnackBar es un DialogControl)
            self.page.show_dialog(
                ft.SnackBar(
                    content=ft.Text(message),
                    bgcolor=color,
                )
            )
            self.page.update()
