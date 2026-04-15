"""Vista para listar palabras."""

import flet as ft
from typing import Callable
from pathlib import Path

from ddd.vocabulary.domain.entities import WordImageEntity
from ddd.vocabulary.domain.enums import ImageSourceEnum
from ddd.vocabulary.infrastructure.controllers.list_words_controller import ListWordsController
from ddd.vocabulary.infrastructure.controllers.list_words_view_dto import WordListItemViewDto
from ddd.vocabulary.infrastructure.repositories import (
    ImagesReaderSqliteRepository,
    ImagesWriterSqliteRepository,
)


class ListWordsView(ft.Container):
    """Vista para listar y gestionar palabras."""

    def __init__(
        self,
        on_back: Callable[[], None],
        on_create: Callable[[], None] | None = None,
        on_edit: Callable[[int], None] | None = None,
    ):
        super().__init__()
        self.on_back = on_back
        self.on_create = on_create
        self.on_edit = on_edit

        self._controller = ListWordsController.get_instance()
        self._words: list[WordListItemViewDto] = []
        self._current_search: str = ""

        # UI components
        self._words_list: ft.ListView | None = None
        self._search_field: ft.TextField | None = None
        self._loading: ft.ProgressRing | None = None
        self._count_text: ft.Text | None = None

        # Image dialog state
        self._current_word_for_image: int | None = None

        self._build_ui()

    def _build_ui(self) -> None:
        # Search field
        self._search_field = ft.TextField(
            hint_text="Buscar palabras...",
            prefix_icon=ft.Icons.SEARCH,
            width=300,
            on_change=self._on_search,
        )

        # Loading indicator
        self._loading = ft.ProgressRing(width=20, height=20, visible=False)

        # Count text
        self._count_text = ft.Text("", size=12, color=ft.Colors.GREY_600)

        # Words list
        self._words_list = ft.ListView(
            expand=True,
            spacing=4,
            padding=10,
        )

        # Add button
        add_btn = ft.ElevatedButton(
            content=ft.Row(
                [ft.Icon(ft.Icons.ADD), ft.Text("Nueva palabra")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=lambda _: self.on_create() if self.on_create else None,
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
                        add_btn,
                        ft.Container(width=16),
                        self._search_field,
                        self._loading,
                    ],
                ),
                ft.Row(
                    controls=[
                        ft.Container(expand=True),
                        self._count_text,
                    ],
                ),
                ft.Divider(height=1),
                # List
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
        self.page.run_task(self._load_words)

    def reload(self) -> None:
        """Recarga la lista de palabras."""
        self.page.run_task(self._load_words)

    async def _load_words(self) -> None:
        """Carga la lista de palabras usando el controlador."""
        if self._loading:
            self._loading.visible = True
            self.update()

        result = await self._controller.list_words(
            search=self._current_search,
            limit=100,
        )

        if self._loading:
            self._loading.visible = False

        if result.success:
            self._words = result.words
            self._update_count_text(result.total_count)
            self._render_words_list()
        else:
            self._show_snackbar(result.error_message or "Error desconocido", error=True)
            self._words = []
            self._render_words_list()

    def _update_count_text(self, total: int) -> None:
        """Actualiza el texto del contador."""
        if self._count_text:
            showing = len(self._words)
            if self._current_search:
                self._count_text.value = f"Mostrando {showing} resultados"
            else:
                self._count_text.value = f"Mostrando {showing} de {total} palabras"
            self.update()

    def _render_words_list(self) -> None:
        """Renderiza la lista de palabras."""
        if not self._words_list:
            return

        self._words_list.controls.clear()

        if not self._words:
            self._words_list.controls.append(
                ft.Container(
                    content=ft.Text(
                        "No hay palabras. Anade la primera!",
                        color=ft.Colors.GREY_500,
                        italic=True,
                    ),
                    padding=20,
                    alignment=ft.alignment.center,
                )
            )
            self.update()
            return

        for word in self._words:
            tile = self._build_word_tile(word)
            self._words_list.controls.append(tile)

        self.update()

    def _build_word_tile(self, word: WordListItemViewDto) -> ft.ListTile:
        """Construye un tile para una palabra."""
        # Icono segun tipo
        icon = ft.Icons.ABC
        if word.word_type == "PHRASE":
            icon = ft.Icons.SHORT_TEXT
        elif word.word_type == "SENTENCE":
            icon = ft.Icons.NOTES

        # Badge de imagenes
        image_badge = f" ({word.image_count})" if word.image_count > 0 else ""

        # Subtitulo con traduccion
        subtitle_parts = [word.word_type, word.created_at]
        if word.translation_nl:
            subtitle_parts.append(f"NL: {word.translation_nl}")
        subtitle = " | ".join(subtitle_parts)

        return ft.ListTile(
            leading=ft.Icon(icon, color=ft.Colors.BLUE_700),
            title=ft.Text(word.text, weight=ft.FontWeight.W_500),
            subtitle=ft.Text(subtitle, size=12),
            trailing=ft.Row(
                controls=[
                    # Editar
                    ft.IconButton(
                        icon=ft.Icons.EDIT_OUTLINED,
                        icon_color=ft.Colors.BLUE_600,
                        on_click=lambda e, w=word: self._on_edit_click(w.id),
                        tooltip="Editar",
                    ),
                    # Imagenes
                    ft.IconButton(
                        icon=ft.Icons.IMAGE,
                        icon_color=ft.Colors.GREEN_600 if word.image_count > 0 else ft.Colors.GREY_400,
                        on_click=lambda e, w=word: self._show_images_dialog(w),
                        tooltip=f"Imagenes{image_badge}",
                    ),
                    # Eliminar
                    ft.IconButton(
                        icon=ft.Icons.DELETE_OUTLINE,
                        icon_color=ft.Colors.RED_400,
                        on_click=lambda e, w=word: self._on_delete_click(w.id),
                        tooltip="Eliminar",
                    ),
                ],
                spacing=0,
            ),
        )

    def _on_edit_click(self, word_id: int) -> None:
        """Maneja click en editar."""
        if self.on_edit:
            self.on_edit(word_id)

    def _on_delete_click(self, word_id: int) -> None:
        """Maneja click en eliminar."""
        self.page.run_task(lambda: self._delete_word(word_id))

    async def _delete_word(self, word_id: int) -> None:
        """Elimina una palabra."""
        success, message = await self._controller.delete_word(word_id)

        if success:
            self._show_snackbar(message)
            await self._load_words()
        else:
            self._show_snackbar(message, error=True)

    def _on_search(self, e) -> None:
        """Maneja cambio en busqueda."""
        self._current_search = e.control.value or ""
        self.page.run_task(self._load_words)

    # ============ Image Dialog Methods ============

    def _show_images_dialog(self, word: WordListItemViewDto) -> None:
        """Muestra dialogo para gestionar imagenes."""
        self._current_word_for_image = word.id

        async def load_and_show():
            try:
                images_reader = ImagesReaderSqliteRepository.get_instance()
                images = await images_reader.get_by_word_id(word.id)
                self._display_images_dialog(word, images or [])
            except Exception as e:
                self._show_snackbar(f"Error al cargar imagenes: {e}", error=True)

        self.page.run_task(load_and_show)

    def _display_images_dialog(self, word: WordListItemViewDto, images: list[dict]) -> None:
        """Muestra el dialogo con las imagenes."""
        images_column = ft.Column(
            controls=[],
            spacing=10,
            scroll=ft.ScrollMode.AUTO,
            height=300,
        )

        if images:
            for img in images:
                if not isinstance(img, dict) or "file_path" not in img:
                    continue

                img_row = ft.Row(
                    controls=[
                        ft.Icon(
                            ft.Icons.STAR if img.get("is_primary") else ft.Icons.IMAGE,
                            color=ft.Colors.AMBER_500 if img.get("is_primary") else ft.Colors.GREY_500,
                            size=20,
                        ),
                        ft.Text(
                            img["file_path"][:30] + "..." if len(img["file_path"]) > 30 else img["file_path"],
                            size=12,
                            expand=True,
                        ),
                        ft.Text(img.get("source_type", ""), size=10, color=ft.Colors.GREY_600),
                        ft.IconButton(
                            icon=ft.Icons.DELETE,
                            icon_color=ft.Colors.RED_400,
                            icon_size=18,
                            on_click=lambda e, i=img: self._delete_image(i.get("id")),
                            tooltip="Eliminar imagen",
                        ),
                    ],
                    alignment=ft.MainAxisAlignment.START,
                )
                images_column.controls.append(img_row)
        else:
            images_column.controls.append(
                ft.Text("No hay imagenes", italic=True, color=ft.Colors.GREY_500)
            )

        url_field = ft.TextField(
            label="URL de imagen",
            hint_text="https://...",
            width=350,
        )

        def close_dialog(e=None):
            self.page.close(dialog)

        def add_from_url(e):
            url = url_field.value
            if url and url.strip():
                async def save_url():
                    await self._add_image_from_url(word.id, url.strip())
                    close_dialog()
                self.page.run_task(save_url)

        dialog = ft.AlertDialog(
            title=ft.Text(f"Imagenes: {word.text}"),
            content=ft.Container(
                content=ft.Column(
                    controls=[
                        images_column,
                        ft.Divider(),
                        ft.Text("Agregar imagen:", weight=ft.FontWeight.BOLD, size=14),
                        ft.Row(
                            controls=[
                                ft.ElevatedButton(
                                    content=ft.Row([ft.Icon(ft.Icons.FOLDER_OPEN), ft.Text("Archivo")]),
                                    on_click=lambda e: self._pick_image_file(),
                                ),
                                ft.ElevatedButton(
                                    content=ft.Row([ft.Icon(ft.Icons.LINK), ft.Text("URL")]),
                                    on_click=lambda e: url_field.focus(),
                                ),
                            ],
                            spacing=10,
                        ),
                        url_field,
                        ft.ElevatedButton(
                            content=ft.Text("Agregar desde URL"),
                            on_click=add_from_url,
                        ),
                    ],
                    spacing=10,
                ),
                width=400,
            ),
            actions=[
                ft.TextButton(content=ft.Text("Cerrar"), on_click=close_dialog),
            ],
        )

        self.page.open(dialog)

    def _pick_image_file(self) -> None:
        """Abre el file picker para seleccionar imagen."""
        async def do_pick():
            file_picker = ft.FilePicker()
            self.page.overlay.append(file_picker)
            self.page.update()

            files = await file_picker.pick_files_async(
                allowed_extensions=["png", "jpg", "jpeg", "gif", "webp", "svg", "bmp"],
                allow_multiple=False,
            )

            self.page.overlay.remove(file_picker)
            self.page.update()

            if files and len(files) > 0 and self._current_word_for_image:
                file = files[0]
                await self._add_image_from_file(
                    self._current_word_for_image,
                    file.path,
                    file.name,
                )
                await self._load_words()
                self._show_snackbar("Imagen agregada")

        self.page.run_task(do_pick)

    async def _add_image_from_file(self, word_id: int, file_path: str, filename: str) -> None:
        """Agrega imagen desde archivo local."""
        try:
            path = Path(file_path)
            if not path.exists():
                self._show_snackbar("Archivo no encontrado", error=True)
                return

            image_bytes = path.read_bytes()

            ext = path.suffix.lower()
            mime_map = {
                ".png": "image/png",
                ".jpg": "image/jpeg",
                ".jpeg": "image/jpeg",
                ".gif": "image/gif",
                ".webp": "image/webp",
                ".svg": "image/svg+xml",
                ".bmp": "image/bmp",
            }
            mime_type = mime_map.get(ext, "image/png")

            word_image_entity = WordImageEntity(
                id=0,
                word_es_id=word_id,
                source_type=ImageSourceEnum.LOCAL,
                file_path="",
                mime_type=mime_type,
                original_filename=filename,
            )
            writer = ImagesWriterSqliteRepository.get_instance()
            await writer.save_image_bytes(word_image_entity, image_bytes)
        except Exception as e:
            self._show_snackbar(f"Error: {e}", error=True)

    async def _add_image_from_url(self, word_id: int, url: str) -> None:
        """Agrega imagen desde URL."""
        try:
            import urllib.request
            import ssl

            ctx = ssl.create_default_context()
            ctx.check_hostname = False
            ctx.verify_mode = ssl.CERT_NONE

            with urllib.request.urlopen(url, context=ctx, timeout=10) as response:
                image_bytes = response.read()
                content_type = response.headers.get("Content-Type", "image/png")

            mime_type = content_type.split(";")[0].strip()
            if mime_type not in ["image/png", "image/jpeg", "image/gif", "image/webp", "image/svg+xml"]:
                mime_type = "image/png"

            word_image_entity = WordImageEntity(
                id=0,
                word_es_id=word_id,
                source_type=ImageSourceEnum.URL,
                file_path="",
                mime_type=mime_type,
                original_url=url,
            )
            writer = ImagesWriterSqliteRepository.get_instance()
            await writer.save_image_bytes(word_image_entity, image_bytes)

            await self._load_words()
            self._show_snackbar("Imagen agregada desde URL")

        except Exception as e:
            self._show_snackbar(f"Error descargando imagen: {e}", error=True)

    def _delete_image(self, image_id: int) -> None:
        """Elimina una imagen."""
        async def do_delete():
            images_reader = ImagesReaderSqliteRepository.get_instance()
            image_data = await images_reader.get_by_id(image_id)
            if image_data:
                word_image_entity = WordImageEntity.from_primitives(image_data)
                writer = ImagesWriterSqliteRepository.get_instance()
                await writer.hard_delete(word_image_entity)
            await self._load_words()
            self._show_snackbar("Imagen eliminada")

        self.page.run_task(do_delete)

    def _show_snackbar(self, message: str, error: bool = False) -> None:
        """Muestra un snackbar."""
        self.page.snack_bar = ft.SnackBar(
            content=ft.Text(message),
            bgcolor=ft.Colors.RED_700 if error else ft.Colors.GREEN_700,
        )
        self.page.snack_bar.open = True
        self.page.update()
