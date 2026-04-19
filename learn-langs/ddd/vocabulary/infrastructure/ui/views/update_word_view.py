"""Vista para editar palabras existentes."""

import flet as ft
from typing import Callable

from ddd.vocabulary.domain.enums import LanguageCodeEnum
from ddd.vocabulary.infrastructure.controllers.update_word_controller import UpdateWordController
from ddd.vocabulary.infrastructure.repositories import (
    WordsEsReaderSqliteRepository,
    WordsLangReaderSqliteRepository,
    TagsReaderSqliteRepository,
)


class UpdateWordView(ft.Container):
    """Vista para editar una palabra existente."""

    def __init__(
        self,
        word_id: int,
        on_back: Callable[[], None],
        on_word_updated: Callable[[], None] | None = None,
    ):
        super().__init__()
        self.word_id = word_id
        self.on_back = on_back
        self.on_word_updated = on_word_updated

        self.word_data: dict = {}
        self.available_tags: list[dict] = []
        self._selected_tags: list[str] = []
        self._current_translations: dict[str, str] = {}

        # Form fields
        self._text_es_field: ft.TextField | None = None
        self._text_nl_field: ft.TextField | None = None
        self._word_type_dropdown: ft.Dropdown | None = None
        self._tags_row: ft.Row | None = None
        self._notes_field: ft.TextField | None = None
        self._loading_indicator: ft.ProgressRing | None = None
        self._form_container: ft.Container | None = None

        self._build_ui()

    def _build_ui(self) -> None:
        # Loading indicator
        self._loading_indicator = ft.ProgressRing(visible=True)

        # Form fields (initially empty, populated after load)
        self._text_es_field = ft.TextField(
            label="Palabra en espanol *",
            hint_text="Escribe la palabra en espanol",
            width=400,
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
                [ft.Icon(ft.Icons.SAVE), ft.Text("Guardar cambios")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=self._save_word,
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
            on_click=lambda _: self.on_back(),
            width=150,
        )

        back_btn = ft.IconButton(
            icon=ft.Icons.ARROW_BACK,
            on_click=lambda _: self.on_back(),
            tooltip="Volver",
        )

        # Form card
        self._form_container = ft.Container(
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
            visible=False,
        )

        self.content = ft.Column(
            controls=[
                # Header
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
                # Loading or form
                ft.Row(
                    controls=[
                        ft.Column(
                            controls=[self._loading_indicator],
                            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                        ),
                    ],
                    alignment=ft.MainAxisAlignment.CENTER,
                ),
                ft.Row(
                    controls=[self._form_container],
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
        self.page.run_task(self._load_data)

    async def _load_data(self) -> None:
        """Carga la palabra y los tags disponibles."""
        try:
            # Cargar palabra
            words_reader = WordsEsReaderSqliteRepository.get_instance()
            self.word_data = await words_reader.get_by_id(self.word_id) or {}

            if not self.word_data:
                self._show_snackbar("Palabra no encontrada", error=True)
                self.on_back()
                return

            # Cargar traducciones
            lang_reader = WordsLangReaderSqliteRepository.get_instance()
            translations = await lang_reader.get_all_for_word(self.word_id)
            for t in translations:
                self._current_translations[t["lang_code"]] = t["text"]

            # Cargar tags disponibles
            tags_reader = TagsReaderSqliteRepository.get_instance()
            self.available_tags = await tags_reader.get_all()

            # Cargar tags de la palabra
            word_tags = await words_reader.get_tags_for_word(self.word_id)
            self._selected_tags = [t["name"] for t in word_tags]

            # Poblar formulario
            self._populate_form()

        except Exception as e:
            self._show_snackbar(f"Error al cargar: {e}", error=True)

    def _populate_form(self) -> None:
        """Llena el formulario con los datos de la palabra."""
        if self._text_es_field:
            self._text_es_field.value = self.word_data.get("text", "")

        if self._text_nl_field:
            self._text_nl_field.value = self._current_translations.get(LanguageCodeEnum.NL_NL.value, "")

        if self._word_type_dropdown:
            self._word_type_dropdown.value = self.word_data.get("word_type", "WORD")

        if self._notes_field:
            self._notes_field.value = self.word_data.get("notes", "") or ""

        self._update_tags_ui()

        # Ocultar loading, mostrar form
        if self._loading_indicator:
            self._loading_indicator.visible = False
        if self._form_container:
            self._form_container.visible = True

        self.update()

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
        """Guarda los cambios de la palabra."""
        self.page.run_task(self._update_word)

    async def _update_word(self) -> None:
        """Actualiza la palabra en la base de datos."""
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

        controller = UpdateWordController.get_instance()
        result = await controller.update(
            word_id=self.word_id,
            text=text_es.strip(),
            word_type=word_type,
            tags=self._selected_tags,
            translations=translations,
            notes=notes.strip() if notes else "",
        )

        if result.success:
            self._show_snackbar(f"Palabra '{result.text}' actualizada")

            # Notify parent
            if self.on_word_updated:
                self.on_word_updated()

            # Volver a la lista
            self.on_back()
        else:
            self._show_snackbar(result.error_message or "Error desconocido", error=True)

    def _show_snackbar(self, message: str, error: bool = False) -> None:
        """Muestra un snackbar."""
        self.page.snack_bar = ft.SnackBar(
            content=ft.Text(message),
            bgcolor=ft.Colors.RED_700 if error else ft.Colors.GREEN_700,
        )
        self.page.snack_bar.open = True
        self.page.update()
