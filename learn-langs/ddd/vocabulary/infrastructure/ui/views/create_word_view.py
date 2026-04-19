"""Vista para crear nuevas palabras."""

import flet as ft
from typing import Callable

from ddd.vocabulary.domain.enums import LanguageCodeEnum
from ddd.vocabulary.infrastructure.controllers import CreateWordController
from ddd.vocabulary.infrastructure.repositories import TagsReaderSqliteRepository


class CreateWordView(ft.Container):
    """Vista para crear nuevas palabras."""

    def __init__(
        self,
        on_back: Callable[[], None],
        on_word_created: Callable[[], None] | None = None,
    ):
        super().__init__()
        self.on_back = on_back
        self.on_word_created = on_word_created
        self.available_tags: list[dict] = []
        self._selected_tags: list[str] = []

        # Form fields
        self._text_es_field: ft.TextField | None = None
        self._text_nl_field: ft.TextField | None = None
        self._word_type_dropdown: ft.Dropdown | None = None
        self._tags_row: ft.Row | None = None
        self._notes_field: ft.TextField | None = None

        self._build_ui()

    def _build_ui(self) -> None:
        # Form fields
        self._text_es_field = ft.TextField(
            label="Palabra en espanol *",
            hint_text="Escribe la palabra en espanol",
            width=400,
            autofocus=True,
        )

        self._text_nl_field = ft.TextField(
            label="Traduccion (Nederlands)",
            hint_text="Escribe la traduccion en holandes",
            width=400,
        )

        self._word_type_dropdown = ft.Dropdown(
            label="Tipo",
            width=200,
            options=[
                ft.dropdown.Option("WORD", "Palabra"),
                ft.dropdown.Option("PHRASE", "Frase"),
                ft.dropdown.Option("SENTENCE", "Oracion"),
            ],
            value="WORD",
        )

        self._notes_field = ft.TextField(
            label="Notas (opcional)",
            hint_text="Contexto, ejemplos de uso...",
            width=400,
            multiline=True,
            min_lines=2,
            max_lines=4,
        )

        self._tags_row = ft.Row(
            controls=[],
            wrap=True,
            spacing=8,
        )

        # Buttons
        save_btn = ft.ElevatedButton(
            content=ft.Row(
                [ft.Icon(ft.Icons.SAVE), ft.Text("Guardar")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=self._save_word,
            style=ft.ButtonStyle(
                bgcolor=ft.Colors.GREEN_600,
                color=ft.Colors.WHITE,
            ),
            width=150,
        )

        cancel_btn = ft.OutlinedButton(
            content=ft.Row(
                [ft.Icon(ft.Icons.CLOSE), ft.Text("Cancelar")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=lambda _: self.on_back(),
            width=150,
        )

        back_btn = ft.IconButton(
            icon=ft.Icons.ARROW_BACK,
            on_click=lambda _: self.on_back(),
            tooltip="Volver",
        )

        # Form card
        form_card = ft.Container(
            content=ft.Column(
                controls=[
                    # Palabra espanol
                    self._text_es_field,
                    ft.Container(height=10),
                    # Traduccion
                    self._text_nl_field,
                    ft.Container(height=10),
                    # Tipo
                    self._word_type_dropdown,
                    ft.Container(height=10),
                    # Notas
                    self._notes_field,
                    ft.Container(height=16),
                    # Tags
                    ft.Text("Tags:", size=14, weight=ft.FontWeight.W_500),
                    self._tags_row,
                    ft.Container(height=24),
                    # Buttons
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
        )

        self.content = ft.Column(
            controls=[
                # Header
                ft.Row(
                    controls=[
                        back_btn,
                        ft.Text(
                            "Crear nueva palabra",
                            size=24,
                            weight=ft.FontWeight.BOLD,
                        ),
                    ],
                ),
                ft.Divider(height=1),
                ft.Container(height=20),
                # Form centered
                ft.Row(
                    controls=[form_card],
                    alignment=ft.MainAxisAlignment.CENTER,
                ),
            ],
            expand=True,
            horizontal_alignment=ft.CrossAxisAlignment.START,
        )
        self.expand = True
        self.padding = 20

    def did_mount(self) -> None:
        """Carga datos al montar."""
        self.page.run_task(self._load_tags)

    async def _load_tags(self) -> None:
        """Carga los tags disponibles."""
        tags_reader = TagsReaderSqliteRepository.get_instance()
        self.available_tags = await tags_reader.get_all()
        self._update_tags_ui()

    def _update_tags_ui(self) -> None:
        """Actualiza los chips de tags."""
        if not self._tags_row:
            return

        self._tags_row.controls.clear()

        if not self.available_tags:
            self._tags_row.controls.append(
                ft.Text(
                    "No hay tags disponibles",
                    italic=True,
                    color=ft.Colors.GREY_500,
                    size=12,
                )
            )
        else:
            for tag in self.available_tags:
                is_selected = tag["name"] in self._selected_tags
                chip = ft.Chip(
                    label=ft.Text(tag["name"], size=12),
                    selected=is_selected,
                    on_select=lambda e, t=tag["name"]: self._toggle_tag(t),
                    bgcolor=tag.get("color") if is_selected else None,
                )
                self._tags_row.controls.append(chip)

        self.update()

    def _toggle_tag(self, tag_name: str) -> None:
        """Alterna seleccion de tag."""
        if tag_name in self._selected_tags:
            self._selected_tags.remove(tag_name)
        else:
            self._selected_tags.append(tag_name)
        self._update_tags_ui()

    def _save_word(self, e) -> None:
        """Guarda la nueva palabra."""
        self.page.run_task(self._create_word)

    async def _create_word(self) -> None:
        """Crea la palabra en la base de datos."""
        if not self._text_es_field or not self._text_nl_field:
            return

        text_es = self._text_es_field.value or ""
        text_nl = self._text_nl_field.value or ""
        word_type = self._word_type_dropdown.value if self._word_type_dropdown else "WORD"
        notes = self._notes_field.value if self._notes_field else ""

        if not text_es.strip():
            self._show_snackbar("La palabra en espanol es obligatoria", error=True)
            return

        translations = {}
        if text_nl.strip():
            translations[LanguageCodeEnum.NL_NL.value] = text_nl.strip()

        controller = CreateWordController.get_instance()
        result = await controller.create(
            text=text_es.strip(),
            word_type=word_type,
            tags=self._selected_tags,
            translations=translations,
            notes=notes.strip() if notes else None,
        )

        if result.success:
            self._show_snackbar(f"Palabra '{result.text}' creada")

            # Notify parent
            if self.on_word_created:
                self.on_word_created()

            # Clear form for next word
            self._clear_form()
        else:
            self._show_snackbar(result.error_message or "Error desconocido", error=True)

    def _clear_form(self) -> None:
        """Limpia el formulario."""
        if self._text_es_field:
            self._text_es_field.value = ""
        if self._text_nl_field:
            self._text_nl_field.value = ""
        if self._word_type_dropdown:
            self._word_type_dropdown.value = "WORD"
        if self._notes_field:
            self._notes_field.value = ""
        self._selected_tags.clear()
        self._update_tags_ui()
        self.update()

    def _show_snackbar(self, message: str, error: bool = False) -> None:
        """Muestra un snackbar."""
        self.page.snack_bar = ft.SnackBar(
            content=ft.Text(message),
            bgcolor=ft.Colors.RED_700 if error else ft.Colors.GREEN_700,
        )
        self.page.snack_bar.open = True
        self.page.update()
