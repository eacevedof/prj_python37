"""Vista de sesión de slider - Solo renderizado."""

from typing import Any, Callable, Self

import flet as ft

from ddd.vocabulary.infrastructure.ui.components.group_source_link_comp import (
    GroupSourceLinkComp,
)
from ddd.vocabulary.infrastructure.ui.components.slider_card_comp import SliderCardComp
from ddd.vocabulary.infrastructure.ui.views.word_slider_view_dto import (
    WordSliderViewDto,
)


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
        route_on_prev: Callable[[], None] | None = None,
        route_on_next: Callable[[], None] | None = None,
        route_on_toggle_pause: Callable[[], None] | None = None,
        route_on_edit_word: Callable[[], None] | None = None,
        route_on_reset_word: Callable[[], None] | None = None,
    ):
        super().__init__()

        self._route_on_mount = route_on_mount
        self._route_on_back = route_on_back
        self._route_on_replay = route_on_replay
        self._route_on_prev = route_on_prev
        self._route_on_next = route_on_next
        self._route_on_toggle_pause = route_on_toggle_pause
        self._route_on_edit_word = route_on_edit_word
        self._route_on_reset_word = route_on_reset_word

        # Estado local del botón de pausa (solo icono; el estado real vive en el controller)
        self.__is_paused: bool = False
        # Hay un diálogo (ayuda/reiniciar) abierto: ignora los atajos de teclado
        self.__is_modal_open: bool = False

        # Datos de la palabra actual para el modal de ayuda (reglas de uso)
        self.__current_word_text: str = ""
        self.__current_rules_help: str = ""

        # Componentes UI - Header
        self._ft_progress_text: ft.Text | None = None
        self._ft_group_source_link: GroupSourceLinkComp | None = None

        # Componentes UI - Content Area
        self._ft_content_area: ft.Column | None = None
        self._ft_slider_card: SliderCardComp | None = None
        self._ft_pause_btn: ft.IconButton | None = None
        self._ft_help_btn: ft.IconButton | None = None
        self._ft_controls_row: ft.Row | None = None
        self.__is_card_mounted: bool = False

        self._build_initial_ui()

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        """Crea la vista desde un diccionario de callbacks."""
        return cls(
            route_on_mount=primitives.get("on_mount"),
            route_on_back=primitives.get("on_back", lambda: None),
            route_on_replay=primitives.get("on_replay"),
            route_on_prev=primitives.get("on_prev"),
            route_on_next=primitives.get("on_next"),
            route_on_toggle_pause=primitives.get("on_toggle_pause"),
            route_on_edit_word=primitives.get("on_edit_word"),
            route_on_reset_word=primitives.get("on_reset_word"),
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

    def render_group_source(self, group_source: str) -> None:
        """Muestra la fuente del grupo en la cabecera (clicable si es enlace)."""
        if self._ft_group_source_link:
            self._ft_group_source_link.render(group_source)
        self.update()

    # =========================================================================
    # LIFECYCLE HOOKS
    # =========================================================================
    def did_mount(self) -> None:
        """Flet llama esto al montar: engancha los atajos de teclado del slider."""
        if self.page:
            self.page.on_keyboard_event = self._on_keyboard
        if self._route_on_mount:
            self._route_on_mount()

    def will_unmount(self) -> None:
        """Flet llama esto al desmontar: suelta el atajo para no afectar a otras vistas."""
        if self.page and self.page.on_keyboard_event is self._on_keyboard:
            self.page.on_keyboard_event = None

    def _on_keyboard(self, event: ft.KeyboardEvent) -> None:
        """Atajos del slider: ← anterior · espacio pausa/reanuda · → siguiente.

        Se ignoran si hay un diálogo abierto o si se pulsa con ctrl/alt/meta.
        """
        if self.__is_modal_open or event.ctrl or event.alt or event.meta:
            return
        if event.key == "Arrow Left":
            self._on_prev_btn_click()
        elif event.key == "Arrow Right":
            self._on_next_btn_click()
        elif event.key == " ":
            self._on_pause_btn_click()

    # =========================================================================
    # CONSTRUCCIÓN DE UI
    # =========================================================================
    def _build_initial_ui(self) -> None:
        """Construye la estructura inicial de la UI."""
        self._ft_progress_text = ft.Text("Cargando...", size=14)
        self._ft_group_source_link = GroupSourceLinkComp()
        self._ft_slider_card = SliderCardComp()

        # Controles de reproducción: anterior | pausa | siguiente | ayuda | editar | reiniciar
        self._ft_pause_btn = ft.IconButton(
            icon=ft.Icons.PAUSE_CIRCLE,
            icon_size=42,
            tooltip="Pausar",
            on_click=lambda _: self._on_pause_btn_click(),
        )
        self._ft_controls_row = ft.Row(
            controls=[
                ft.IconButton(
                    icon=ft.Icons.SKIP_PREVIOUS,
                    icon_size=42,
                    tooltip="Palabra anterior",
                    on_click=lambda _: self._on_prev_btn_click(),
                ),
                self._ft_pause_btn,
                ft.IconButton(
                    icon=ft.Icons.SKIP_NEXT,
                    icon_size=42,
                    tooltip="Palabra siguiente",
                    on_click=lambda _: self._on_next_btn_click(),
                ),
                self._get_built_help_button(),
                ft.IconButton(
                    icon=ft.Icons.EDIT,
                    icon_size=36,
                    icon_color=ft.Colors.AMBER_800,
                    tooltip="Editar palabra (audio, contexto, traducción...)",
                    on_click=lambda _: (
                        self._route_on_edit_word() if self._route_on_edit_word else None
                    ),
                ),
                ft.IconButton(
                    icon=ft.Icons.RESTART_ALT,
                    icon_size=36,
                    icon_color=ft.Colors.RED_700,
                    tooltip="Reiniciar palabra: su progreso de estudio vuelve a cero",
                    on_click=lambda _: self._on_reset_btn_click(),
                ),
            ],
            alignment=ft.MainAxisAlignment.CENTER,
            spacing=16,
        )

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
                        self._ft_group_source_link,
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

        self.__is_card_mounted = False
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
        if (
            not self._ft_content_area
            or not dto.current_word
            or not self._ft_slider_card
        ):
            return

        word = dto.current_word

        # Datos para el modal de ayuda (habilitado solo si la palabra tiene reglas)
        self.__current_word_text = word.get("text_es", "")
        self.__current_rules_help = word.get("rules_help", "") or ""
        if self._ft_help_btn:
            self._ft_help_btn.disabled = not self.__current_rules_help

        # Montar la tarjeta persistente una sola vez para preservar la animación
        if not self.__is_card_mounted:
            self._reset_pause_button()
            self._ft_content_area.controls.clear()
            self._ft_content_area.controls.extend(
                [
                    ft.Container(height=20),
                    ft.Row(
                        controls=[self._ft_slider_card],
                        alignment=ft.MainAxisAlignment.CENTER,
                    ),
                    ft.Container(height=12),
                    self._ft_controls_row,
                ]
            )
            self.__is_card_mounted = True

        self._ft_slider_card.render(
            text_es=word.get("text_es", ""),
            text_lang=word.get("text_lang", ""),
            pronunciation=word.get("pronunciation", ""),
            show_translation=dto.show_translation,
            phase_label=dto.phase_label,
            word_key=str(dto.current_index),
            image_file_path=word.get("image_file_path", ""),
            word_id=word.get("word_es_id", ""),
            examples=word.get("examples", ""),
            show_examples=dto.show_examples,
        )

    def _render_no_words(self) -> None:
        """Renderiza mensaje cuando no hay palabras."""
        if not self._ft_content_area:
            return

        self.__is_card_mounted = False
        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.extend(
            [
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
            ]
        )

    def _render_session_complete(self, dto: WordSliderViewDto) -> None:
        """Renderiza sesión completada."""
        if not self._ft_content_area:
            return

        self.__is_card_mounted = False
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
        self._ft_content_area.controls.extend(
            [
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
            ]
        )

    def _get_built_help_button(self) -> ft.IconButton:
        """Construye el botón de ayuda (reglas de uso) de la botonera."""
        self._ft_help_btn = ft.IconButton(
            icon=ft.Icons.HELP_OUTLINE,
            icon_size=32,
            icon_color=ft.Colors.GREEN_700,
            tooltip="Reglas de uso: cuándo y cómo se usa",
            on_click=lambda _: self._on_help_btn_click(),
            disabled=True,
        )
        return self._ft_help_btn

    # =========================================================================
    # EVENT HANDLERS (Callbacks de UI)
    # =========================================================================
    def _on_help_btn_click(self) -> None:
        """Muestra el modal de reglas de uso pausando el slider automáticamente.

        Al cerrar, reanuda solo si la pausa la provocó la propia ayuda.
        """
        if not self.__current_rules_help or not self.page:
            return

        self.__is_modal_open = True
        was_playing = not self.__is_paused
        if was_playing and self._route_on_toggle_pause:
            self.__is_paused = True
            self._apply_pause_icon()
            self._route_on_toggle_pause()

        def close_dialog(_) -> None:
            self.__is_modal_open = False
            dialog.open = False
            if was_playing and self._route_on_toggle_pause:
                self.__is_paused = False
                self._apply_pause_icon()
                self._route_on_toggle_pause()
            self.page.update()

        dialog = ft.AlertDialog(
            modal=True,
            title=ft.Text(self.__current_word_text, size=22, weight=ft.FontWeight.BOLD),
            content=ft.Container(
                content=ft.Column(
                    controls=self._get_rules_controls(self.__current_rules_help),
                    scroll=ft.ScrollMode.AUTO,
                    spacing=6,
                ),
                width=650,
                height=420,
            ),
            actions=[
                ft.TextButton("Cerrar", on_click=close_dialog),
            ],
            actions_alignment=ft.MainAxisAlignment.END,
        )
        self.page.overlay.append(dialog)
        dialog.open = True
        self.page.update()

    @staticmethod
    def _get_rules_controls(rules_text: str) -> list[ft.Control]:
        """Convierte las reglas en controles: ítems enumerados y neerlandés en negrita."""
        controls: list[ft.Control] = []
        item_number = 0
        for raw_line in rules_text.splitlines():
            line = raw_line.strip()
            if not line:
                controls.append(ft.Container(height=4))
                continue

            is_item = line[0] in "•-*"
            while line and line[0] in "•-*":
                line = line[1:].strip()

            if not is_item:
                controls.append(ft.Text(line, size=16, selectable=True))
                continue

            item_number += 1
            if "—" in line:
                text_lang, text_es = line.split("—", 1)
                spans = [
                    ft.TextSpan(
                        f"{item_number}. ", ft.TextStyle(color=ft.Colors.GREY_600)
                    ),
                    ft.TextSpan(
                        f"{text_lang.strip()} ", ft.TextStyle(weight=ft.FontWeight.BOLD)
                    ),
                    ft.TextSpan(
                        f"— {text_es.strip()}", ft.TextStyle(color=ft.Colors.GREY_700)
                    ),
                ]
            else:
                spans = [
                    ft.TextSpan(
                        f"{item_number}. ", ft.TextStyle(color=ft.Colors.GREY_600)
                    ),
                    ft.TextSpan(line, ft.TextStyle(weight=ft.FontWeight.BOLD)),
                ]
            controls.append(ft.Text(spans=spans, size=16, selectable=True))
        return controls

    def _on_reset_btn_click(self) -> None:
        """Pide confirmación para reiniciar el progreso de la palabra actual.

        Pausa el slider mientras el diálogo está abierto; al cerrar, reanuda
        solo si la pausa la provocó el propio diálogo.
        """
        if not self.page or not self._route_on_reset_word:
            return

        self.__is_modal_open = True
        was_playing = not self.__is_paused
        if was_playing and self._route_on_toggle_pause:
            self.__is_paused = True
            self._apply_pause_icon()
            self._route_on_toggle_pause()

        def close_dialog(_) -> None:
            self.__is_modal_open = False
            dialog.open = False
            if was_playing and self._route_on_toggle_pause:
                self.__is_paused = False
                self._apply_pause_icon()
                self._route_on_toggle_pause()
            self.page.update()

        def confirm_reset(event) -> None:
            if self._route_on_reset_word:
                self._route_on_reset_word()
            close_dialog(event)

        dialog = ft.AlertDialog(
            modal=True,
            title=ft.Text("Reiniciar palabra", size=22, weight=ft.FontWeight.BOLD),
            content=ft.Text(
                f"El progreso de estudio de «{self.__current_word_text}» volverá a cero "
                "y entrará al entrenamiento como palabra nueva. La palabra, sus "
                "traducciones, audios e imágenes no se tocan.",
                size=16,
            ),
            actions=[
                ft.TextButton("Cancelar", on_click=close_dialog),
                ft.TextButton(
                    "Reiniciar",
                    on_click=confirm_reset,
                    style=ft.ButtonStyle(color=ft.Colors.RED_700),
                ),
            ],
            actions_alignment=ft.MainAxisAlignment.END,
        )
        self.page.overlay.append(dialog)
        dialog.open = True
        self.page.update()

    def _on_prev_btn_click(self) -> None:
        """Navega a la palabra anterior (la navegación reanuda la reproducción)."""
        self._reset_pause_button()
        if self._route_on_prev:
            self._route_on_prev()
        self.update()

    def _on_next_btn_click(self) -> None:
        """Navega a la palabra siguiente (la navegación reanuda la reproducción)."""
        self._reset_pause_button()
        if self._route_on_next:
            self._route_on_next()
        self.update()

    def _on_pause_btn_click(self) -> None:
        """Alterna el icono pausa/reanudar y notifica al controller."""
        self.__is_paused = not self.__is_paused
        self._apply_pause_icon()
        if self._route_on_toggle_pause:
            self._route_on_toggle_pause()
        self.update()

    def _reset_pause_button(self) -> None:
        """Restaura el botón de pausa al estado reproduciendo."""
        self.__is_paused = False
        self._apply_pause_icon()

    def _apply_pause_icon(self) -> None:
        """Sincroniza icono y tooltip del botón con el estado de pausa."""
        if not self._ft_pause_btn:
            return
        if self.__is_paused:
            self._ft_pause_btn.icon = ft.Icons.PLAY_CIRCLE
            self._ft_pause_btn.tooltip = "Reanudar"
        else:
            self._ft_pause_btn.icon = ft.Icons.PAUSE_CIRCLE
            self._ft_pause_btn.tooltip = "Pausar"

    def _render_error(self, message: str) -> None:
        """Renderiza mensaje de error."""
        if not self._ft_content_area:
            return

        self.__is_card_mounted = False
        self._ft_content_area.controls.clear()
        self._ft_content_area.controls.extend(
            [
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
            ]
        )
