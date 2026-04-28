"""Vista para editar palabras - Solo renderizado."""

import flet as ft
from typing import Callable, Any, Self, TYPE_CHECKING

if TYPE_CHECKING:
    from ddd.vocabulary.infrastructure.ui.views.update_word_view_dto import UpdateWordViewDto


class UpdateWordView(ft.Container):
    """
    Vista para editar una palabra.

    Responsabilidades:
    - Renderizar UI basada en UpdateWordViewDto
    - Emitir eventos al Controller via callbacks
    - NO tiene logica de negocio
    - NO importa repositorios ni servicios
    """

    def __init__(
        self,
        on_submit: Callable[[dict[str, Any]], None],
        on_back: Callable[[], None],
        on_mount: Callable[[], None] | None = None,
    ):
        super().__init__()

        self._route_on_submit = on_submit
        self._route_on_back = on_back
        self._route_on_mount = on_mount

        # Estado local de tags seleccionados
        self._selected_tags: list[str] = []
        self._available_tags: list[dict[str, Any]] = []

        # Form fields
        self._ft_text_es_field: ft.TextField | None = None
        self._ft_text_nl_field: ft.TextField | None = None
        self._ft_word_type_dropdown: ft.Dropdown | None = None
        self._ft_notes_field: ft.TextField | None = None
        self._ft_tags_row: ft.Row | None = None
        self._ft_loading_indicator: ft.ProgressRing | None = None
        self._ft_form_container: ft.Container | None = None
        self._ft_error_text: ft.Text | None = None
        self._ft_success_text: ft.Text | None = None

        self._build_ui()

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            on_submit=primitives.get("on_submit", lambda x: None),
            on_back=primitives.get("on_back", lambda: None),
            on_mount=primitives.get("on_mount"),
        )

    def did_mount(self) -> None:
        """Flet llama esto al montar. Notifica al Controller."""
        if self._route_on_mount:
            self._route_on_mount()

    def _build_ui(self) -> None:
        # Loading indicator
        self._ft_loading_indicator = ft.ProgressRing(visible=True)

        # Form fields
        self._ft_text_es_field = ft.TextField(
            label="Palabra en espanol *",
            hint_text="Escribe la palabra en espanol",
            width=400,
        )

        self._ft_text_nl_field = ft.TextField(
            label="Traduccion (Nederlands)",
            hint_text="Escribe la traduccion en holandes",
            width=400,
        )

        self._ft_word_type_dropdown = ft.Dropdown(
            label="Tipo",
            width=200,
            options=[
                ft.dropdown.Option("WORD", "Palabra"),
                ft.dropdown.Option("PHRASE", "Frase"),
                ft.dropdown.Option("SENTENCE", "Oracion"),
            ],
            value="WORD",
        )

        self._ft_notes_field = ft.TextField(
            label="Notas (opcional)",
            hint_text="Contexto, ejemplos de uso...",
            width=400,
            multiline=True,
            min_lines=2,
            max_lines=4,
        )

        self._ft_tags_row = ft.Row(
            controls=[],
            wrap=True,
            spacing=8,
        )

        self._ft_error_text = ft.Text(
            color=ft.Colors.RED_700,
            visible=False,
        )

        self._ft_success_text = ft.Text(
            color=ft.Colors.GREEN_700,
            visible=False,
        )

        # Buttons
        save_btn = ft.ElevatedButton(
            content=ft.Row(
                [ft.Icon(ft.Icons.SAVE), ft.Text("Guardar cambios")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=lambda _: self._on_save_btn_click(),
            style=ft.ButtonStyle(
                bgcolor=ft.Colors.BLUE_600,
                color=ft.Colors.WHITE,
            ),
            width=180,
        )

        cancel_btn = ft.OutlinedButton(
            content=ft.Row(
                [ft.Icon(ft.Icons.CLOSE), ft.Text("Cancelar")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=lambda _: self._route_on_back(),
            width=150,
        )

        back_btn = ft.IconButton(
            icon=ft.Icons.ARROW_BACK,
            on_click=lambda _: self._route_on_back(),
            tooltip="Volver",
        )

        # Form card
        self._ft_form_container = ft.Container(
            content=ft.Column(
                controls=[
                    self._ft_text_es_field,
                    ft.Container(height=10),
                    self._ft_text_nl_field,
                    ft.Container(height=10),
                    self._ft_word_type_dropdown,
                    ft.Container(height=10),
                    self._ft_notes_field,
                    ft.Container(height=16),
                    ft.Text("Tags:", size=14, weight=ft.FontWeight.W_500),
                    self._ft_tags_row,
                    ft.Container(height=16),
                    self._ft_error_text,
                    self._ft_success_text,
                    ft.Container(height=8),
                    ft.Row(
                        controls=[save_btn, cancel_btn],
                        spacing=16,
                    ),
                ],
                spacing=4,
                horizontal_alignment=ft.CrossAxisAlignment.START,
            ),
            padding=24,
            bgcolor=ft.Colors.WHITE,
            border_radius=12,
            border=ft.border.all(1, ft.Colors.GREY_300),
            width=500,
            visible=False,
        )

        self.content = ft.Column(
            controls=[
                ft.Row(
                    controls=[
                        back_btn,
                        ft.Text(
                            "Editar palabra",
                            size=24,
                            weight=ft.FontWeight.BOLD,
                        ),
                    ],
                ),
                ft.Divider(height=1),
                ft.Container(height=20),
                ft.Row(
                    controls=[
                        ft.Column(
                            controls=[self._ft_loading_indicator],
                            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                        ),
                    ],
                    alignment=ft.MainAxisAlignment.CENTER,
                ),
                ft.Row(
                    controls=[self._ft_form_container],
                    alignment=ft.MainAxisAlignment.CENTER,
                ),
            ],
            expand=True,
            horizontal_alignment=ft.CrossAxisAlignment.START,
        )
        self.expand = True
        self.padding = 20

    def render(self, dto: "UpdateWordViewDto") -> None:
        """Renderiza la vista basado en el DTO."""
        # Loading state
        if self._ft_loading_indicator:
            self._ft_loading_indicator.visible = dto.is_loading

        if self._ft_form_container:
            self._ft_form_container.visible = not dto.is_loading

        if dto.is_loading:
            self.update()
            return

        # Restaurar valores del formulario
        self._render_form_values(dto.form_values)

        # Tags disponibles
        self._available_tags = list(dto.available_tags)
        self._selected_tags = list(dto.form_values.get("selected_tags", []))
        self._render_tags()

        # Mensajes
        self._render_messages(dto)

        # Highlight campo con error
        if dto.error_field:
            self._highlight_error_field(dto.error_field)

        self.update()

    def _render_form_values(self, form_values: dict[str, Any]) -> None:
        """Restaura valores del formulario."""
        if self._ft_text_es_field:
            self._ft_text_es_field.value = form_values.get("text_es", "")
            self._ft_text_es_field.border_color = None

        if self._ft_text_nl_field:
            self._ft_text_nl_field.value = form_values.get("text_nl", "")
            self._ft_text_nl_field.border_color = None

        if self._ft_word_type_dropdown:
            self._ft_word_type_dropdown.value = form_values.get("word_type", "WORD")

        if self._ft_notes_field:
            self._ft_notes_field.value = form_values.get("notes", "")
            self._ft_notes_field.border_color = None

    def _render_tags(self) -> None:
        """Renderiza los chips de tags."""
        if not self._ft_tags_row:
            return

        self._ft_tags_row.controls.clear()

        if not self._available_tags:
            self._ft_tags_row.controls.append(
                ft.Text(
                    "No hay tags disponibles",
                    italic=True,
                    color=ft.Colors.GREY_500,
                    size=12,
                )
            )
        else:
            for tag in self._available_tags:
                tag_name = tag.get("name", "")
                is_selected = tag_name in self._selected_tags
                chip = ft.Chip(
                    label=ft.Text(tag_name, size=12),
                    selected=is_selected,
                    on_select=lambda e, t=tag_name: self._toggle_tag(t),
                    bgcolor=tag.get("color") if is_selected else None,
                )
                self._ft_tags_row.controls.append(chip)

    def _render_messages(self, dto: "UpdateWordViewDto") -> None:
        """Renderiza mensajes de error/exito."""
        if self._ft_error_text:
            if dto.error_message:
                self._ft_error_text.value = dto.error_message
                self._ft_error_text.visible = True
            else:
                self._ft_error_text.visible = False

        if self._ft_success_text:
            if dto.success_message:
                self._ft_success_text.value = dto.success_message
                self._ft_success_text.visible = True
            else:
                self._ft_success_text.visible = False

    def _highlight_error_field(self, field_name: str) -> None:
        """Destaca el campo con error."""
        field_map = {
            "text_es": self._ft_text_es_field,
            "text_nl": self._ft_text_nl_field,
            "notes": self._ft_notes_field,
        }
        target_field = field_map.get(field_name)
        if target_field:
            target_field.border_color = ft.Colors.RED_700
            target_field.focus()

    def _toggle_tag(self, tag_name: str) -> None:
        """Alterna seleccion de tag (estado local)."""
        if tag_name in self._selected_tags:
            self._selected_tags.remove(tag_name)
        else:
            self._selected_tags.append(tag_name)
        self._render_tags()
        self.update()

    def _on_save_btn_click(self) -> None:
        """Recopila datos del form y emite callback."""
        form_data = self._get_form_data()
        self._route_on_submit(form_data)

    def _get_form_data(self) -> dict[str, Any]:
        """Obtiene los datos actuales del formulario."""
        return {
            "text_es": self._ft_text_es_field.value if self._ft_text_es_field else "",
            "text_nl": self._ft_text_nl_field.value if self._ft_text_nl_field else "",
            "word_type": self._ft_word_type_dropdown.value if self._ft_word_type_dropdown else "WORD",
            "notes": self._ft_notes_field.value if self._ft_notes_field else "",
            "selected_tags": list(self._selected_tags),
        }

    def show_snackbar(self, message: str, error: bool = False) -> None:
        """Muestra un snackbar."""
        self.page.snack_bar = ft.SnackBar(
            content=ft.Text(message),
            bgcolor=ft.Colors.RED_700 if error else ft.Colors.GREEN_700,
        )
        self.page.snack_bar.open = True
        self.page.update()
