"""Vista de gestion de palabras (CRUD)."""

import flet as ft
from typing import Callable

from ddd.vocabulary.application.create_word import (
    CreateWordDto,
    CreateWordService,
)
from ddd.vocabulary.infrastructure.repositories import (
    WordsEsReaderSqliteRepository,
    WordsEsWriterSqliteRepository,
    WordsLangWriterSqliteRepository,
    TagsReaderSqliteRepository,
)


class WordCrudView(ft.Container):
    """Vista para gestionar palabras."""

    def __init__(self, on_back: Callable[[], None]):
        super().__init__()
        self.on_back = on_back
        self.words: list[dict] = []
        self.available_tags: list[dict] = []

        self._words_list: ft.ListView | None = None
        self._search_field: ft.TextField | None = None

        # Form fields
        self._text_es_field: ft.TextField | None = None
        self._text_nl_field: ft.TextField | None = None
        self._word_type_dropdown: ft.Dropdown | None = None
        self._tags_row: ft.Row | None = None
        self._selected_tags: list[str] = []

        self._build_ui()

    def _build_ui(self) -> None:
        # Search
        self._search_field = ft.TextField(
            hint_text="Buscar palabras...",
            prefix_icon=ft.Icons.SEARCH,
            width=300,
            on_change=self._on_search,
        )

        # Words list
        self._words_list = ft.ListView(
            expand=True,
            spacing=4,
            padding=10,
        )

        # Form fields
        self._text_es_field = ft.TextField(
            label="Palabra en espanol",
            width=300,
        )

        self._text_nl_field = ft.TextField(
            label="Traduccion (Nederlands)",
            width=300,
        )

        self._word_type_dropdown = ft.Dropdown(
            label="Tipo",
            width=150,
            options=[
                ft.dropdown.Option("WORD", "Palabra"),
                ft.dropdown.Option("PHRASE", "Frase"),
                ft.dropdown.Option("SENTENCE", "Oracion"),
            ],
            value="WORD",
        )

        self._tags_row = ft.Row(
            controls=[],
            wrap=True,
            spacing=4,
        )

        add_btn = ft.ElevatedButton(
            content=ft.Row(
                [ft.Icon(ft.Icons.ADD), ft.Text("Anadir")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=self._add_word,
            style=ft.ButtonStyle(
                bgcolor=ft.Colors.GREEN_600,
                color=ft.Colors.WHITE,
            ),
        )

        back_btn = ft.IconButton(
            icon=ft.Icons.ARROW_BACK,
            on_click=lambda _: self.on_back(),
            tooltip="Volver",
        )

        # Form section
        form_section = ft.Container(
            content=ft.Column(
                controls=[
                    ft.Text("Anadir nueva palabra", weight=ft.FontWeight.BOLD, size=16),
                    ft.Row(
                        controls=[
                            self._text_es_field,
                            self._text_nl_field,
                            self._word_type_dropdown,
                        ],
                        wrap=True,
                        spacing=10,
                    ),
                    ft.Text("Tags:", size=12),
                    self._tags_row,
                    add_btn,
                ],
                spacing=10,
            ),
            padding=16,
            bgcolor=ft.Colors.GREY_100,
            border_radius=8,
        )

        self.content = ft.Column(
            controls=[
                # Header
                ft.Row(
                    controls=[
                        back_btn,
                        ft.Text(
                            "Gestionar palabras",
                            size=20,
                            weight=ft.FontWeight.BOLD,
                        ),
                        ft.Container(expand=True),
                        self._search_field,
                    ],
                ),
                ft.Divider(height=1),
                # Form
                form_section,
                ft.Container(height=10),
                # List
                ft.Text("Palabras existentes:", weight=ft.FontWeight.BOLD),
                ft.Container(
                    content=self._words_list,
                    expand=True,
                    border=ft.border.all(1, ft.Colors.GREY_300),
                    border_radius=8,
                ),
            ],
            expand=True,
        )
        self.expand = True
        self.padding = 20

    def did_mount(self) -> None:
        """Carga datos al montar."""
        self.page.run_task(self._load_data)

    async def _load_data(self) -> None:
        """Carga palabras y tags."""
        # Tags
        tags_reader = TagsReaderSqliteRepository.get_instance()
        self.available_tags = await tags_reader.get_all()
        self._update_tags_ui()

        # Words
        await self._load_words()

    async def _load_words(self, search: str = "") -> None:
        """Carga la lista de palabras."""
        reader = WordsEsReaderSqliteRepository.get_instance()

        if search:
            self.words = await reader.search(search)
        else:
            self.words = await reader.get_all(limit=100)

        self._update_words_list()

    def _update_words_list(self) -> None:
        """Actualiza la lista visual de palabras."""
        if not self._words_list:
            return

        self._words_list.controls.clear()

        for word in self.words:
            tile = ft.ListTile(
                leading=ft.Icon(
                    ft.Icons.ABC if word["word_type"] == "WORD"
                    else ft.Icons.SHORT_TEXT if word["word_type"] == "PHRASE"
                    else ft.Icons.NOTES,
                    color=ft.Colors.BLUE_700,
                ),
                title=ft.Text(word["text"], weight=ft.FontWeight.W_500),
                subtitle=ft.Text(
                    f"{word['word_type']} - {word.get('created_at', '')[:10]}",
                    size=12,
                ),
                trailing=ft.IconButton(
                    icon=ft.Icons.DELETE_OUTLINE,
                    icon_color=ft.Colors.RED_400,
                    on_click=lambda e, w=word: self._delete_word(w["id"]),
                    tooltip="Eliminar",
                ),
            )
            self._words_list.controls.append(tile)

        if not self.words:
            self._words_list.controls.append(
                ft.Container(
                    content=ft.Text(
                        "No hay palabras. Anade la primera!",
                        color=ft.Colors.GREY_500,
                        italic=True,
                    ),
                    padding=20,
                    alignment=ft.Alignment.CENTER,
                )
            )

        self.update()

    def _update_tags_ui(self) -> None:
        """Actualiza los chips de tags."""
        if not self._tags_row:
            return

        self._tags_row.controls.clear()

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

    def _on_search(self, e) -> None:
        """Maneja busqueda."""
        search_text = e.control.value or ""
        async def search():
            await self._load_words(search_text)
        self.page.run_task(search)

    def _add_word(self, e) -> None:
        """Anade una nueva palabra."""
        self.page.run_task(self._create_word)

    async def _create_word(self) -> None:
        """Crea la palabra en la base de datos."""
        if not self._text_es_field or not self._text_nl_field:
            return

        text_es = self._text_es_field.value or ""
        text_nl = self._text_nl_field.value or ""
        word_type = self._word_type_dropdown.value if self._word_type_dropdown else "WORD"

        if not text_es.strip():
            self._show_snackbar("La palabra en espanol es obligatoria", error=True)
            return

        try:
            translations = {}
            if text_nl.strip():
                translations["nl_NL"] = text_nl.strip()

            dto = CreateWordDto.from_primitives({
                "text": text_es,
                "word_type": word_type,
                "tags": self._selected_tags,
                "translations": translations,
            })

            service = CreateWordService.get_instance()
            await service(dto)

            # Limpiar form
            self._text_es_field.value = ""
            self._text_nl_field.value = ""
            self._selected_tags.clear()
            self._update_tags_ui()

            # Recargar lista
            await self._load_words()

            self._show_snackbar(f"Palabra '{text_es}' anadida")

        except Exception as e:
            self._show_snackbar(str(e), error=True)

    def _delete_word(self, word_id: int) -> None:
        """Elimina una palabra."""
        async def do_delete():
            await self._do_delete(word_id)
        self.page.run_task(do_delete)

    async def _do_delete(self, word_id: int) -> None:
        """Ejecuta la eliminacion."""
        writer = WordsEsWriterSqliteRepository.get_instance()
        await writer.delete(word_id)
        await self._load_words()
        self._show_snackbar("Palabra eliminada")

    def _show_snackbar(self, message: str, error: bool = False) -> None:
        """Muestra un snackbar."""
        self.page.snack_bar = ft.SnackBar(
            content=ft.Text(message),
            bgcolor=ft.Colors.RED_700 if error else ft.Colors.GREEN_700,
        )
        self.page.snack_bar.open = True
        self.page.update()
