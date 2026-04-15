"""Vista de gestion de palabras (listado, busqueda, eliminacion)."""

import flet as ft
from typing import Callable
from pathlib import Path

from ddd.vocabulary.domain.entities import WordEsEntity, WordImageEntity
from ddd.vocabulary.domain.enums import ImageSourceEnum
from ddd.vocabulary.infrastructure.repositories import (
    WordsEsReaderSqliteRepository,
    WordsEsWriterSqliteRepository,
    ImagesReaderSqliteRepository,
    ImagesWriterSqliteRepository,
)


class WordCrudView(ft.Container):
    """Vista para listar y gestionar palabras existentes."""

    def __init__(
        self,
        on_back: Callable[[], None],
        on_create: Callable[[], None] | None = None,
    ):
        super().__init__()
        self.on_back = on_back
        self.on_create = on_create
        self.words: list[dict] = []

        self._words_list: ft.ListView | None = None
        self._search_field: ft.TextField | None = None

        # Current word for image operations
        self._current_word_for_image: int | None = None

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
                    ],
                ),
                ft.Divider(height=1),
                ft.Container(height=10),
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

    def reload_words(self) -> None:
        """Recarga la lista de palabras (llamado externamente)."""
        self.page.run_task(self._load_words)

    async def _load_words(self, search: str = "") -> None:
        """Carga la lista de palabras."""
        try:
            reader = WordsEsReaderSqliteRepository.get_instance()
            images_reader = ImagesReaderSqliteRepository.get_instance()

            if search:
                self.words = await reader.search(search)
            else:
                self.words = await reader.get_all(limit=100)

            # Validar que self.words sea una lista
            if not isinstance(self.words, list):
                self.words = []
                self._show_snackbar("Error: formato de datos inválido", error=True)
                return

            # Cargar conteo de imagenes para cada palabra
            for word in self.words:
                if isinstance(word, dict) and "id" in word:
                    word["image_count"] = await images_reader.count_by_word_id(word["id"])
                else:
                    word["image_count"] = 0

            self._update_words_list()
        except Exception as e:
            self.words = []
            self._show_snackbar(f"Error al cargar palabras: {e}", error=True)
            self._update_words_list()

    def _update_words_list(self) -> None:
        """Actualiza la lista visual de palabras."""
        if not self._words_list:
            return

        self._words_list.controls.clear()

        # Validar que self.words sea una lista
        if not isinstance(self.words, list):
            self.words = []
            self._words_list.controls.append(
                ft.Container(
                    content=ft.Text(
                        "Error: formato de datos inválido",
                        color=ft.Colors.RED_500,
                        weight=ft.FontWeight.BOLD,
                    ),
                    padding=20,
                    alignment=ft.Alignment.CENTER,
                )
            )
            self.update()
            return

        for word in self.words:
            # Validar que cada palabra sea un diccionario
            if not isinstance(word, dict) or "text" not in word:
                continue

            image_count = word.get("image_count", 0)
            image_badge = f" ({image_count})" if image_count > 0 else ""

            tile = ft.ListTile(
                leading=ft.Icon(
                    ft.Icons.ABC if word.get("word_type") == "WORD"
                    else ft.Icons.SHORT_TEXT if word.get("word_type") == "PHRASE"
                    else ft.Icons.NOTES,
                    color=ft.Colors.BLUE_700,
                ),
                title=ft.Text(word["text"], weight=ft.FontWeight.W_500),
                subtitle=ft.Text(
                    f"{word.get('word_type', 'UNKNOWN')} - {word.get('created_at', '')[:10]}",
                    size=12,
                ),
                trailing=ft.Row(
                    controls=[
                        # Boton de imagenes
                        ft.IconButton(
                            icon=ft.Icons.IMAGE,
                            icon_color=ft.Colors.GREEN_600 if image_count > 0 else ft.Colors.GREY_400,
                            on_click=lambda e, w=word: self._show_images_dialog(w),
                            tooltip=f"Imagenes{image_badge}",
                        ),
                        # Boton de eliminar
                        ft.IconButton(
                            icon=ft.Icons.DELETE_OUTLINE,
                            icon_color=ft.Colors.RED_400,
                            on_click=lambda e, w=word: self._delete_word(w["id"]),
                            tooltip="Eliminar",
                        ),
                    ],
                    spacing=0,
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

    def _show_images_dialog(self, word: dict) -> None:
        """Muestra dialogo para gestionar imagenes de una palabra."""
        self._current_word_for_image = word["id"]

        async def load_and_show():
            try:
                images_reader = ImagesReaderSqliteRepository.get_instance()
                images = await images_reader.get_by_word_id(word["id"])
                
                # Validar que images sea una lista
                if not isinstance(images, list):
                    images = []
                    self._show_snackbar("Error: formato de imágenes inválido", error=True)
                
                self._display_images_dialog(word, images)
            except Exception as e:
                self._show_snackbar(f"Error al cargar imágenes: {e}", error=True)
                self._display_images_dialog(word, [])

        self.page.run_task(load_and_show)

    def _display_images_dialog(self, word: dict, images: list[dict]) -> None:
        """Muestra el dialogo con las imagenes."""
        images_column = ft.Column(
            controls=[],
            spacing=10,
            scroll=ft.ScrollMode.AUTO,
            height=300,
        )

        # Validar que images sea una lista
        if not isinstance(images, list):
            images = []

        # Mostrar imagenes existentes
        if images:
            for img in images:
                # Validar que cada imagen sea un diccionario válido
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

        # URL input
        url_field = ft.TextField(
            label="URL de imagen",
            hint_text="https://...",
            width=350,
        )

        def close_dialog(e=None):
            self.page.pop_dialog()

        def add_from_url(e):
            url = url_field.value
            if url and url.strip():
                async def save_url():
                    await self._add_image_from_url(word["id"], url.strip())
                    close_dialog()
                self.page.run_task(save_url)

        dialog = ft.AlertDialog(
            title=ft.Text(f"Imagenes: {word['text']}"),
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

        self.page.show_dialog(dialog)

    def _pick_image_file(self) -> None:
        """Abre el file picker para seleccionar imagen."""
        async def do_pick():
            file_picker = ft.FilePicker()
            self.page.overlay.append(file_picker)
            self.page.update()

            files = await file_picker.pick_files(
                allowed_extensions=["png", "jpg", "jpeg", "gif", "webp", "svg", "bmp"],
                allow_multiple=False,
            )

            self.page.overlay.remove(file_picker)
            self.page.update()

            if files and len(files) > 0 and self._current_word_for_image:
                file = files[0]
                word_id = self._current_word_for_image
                await self._add_image_from_file(word_id, file.path, file.name)
                await self._load_words()
                self._show_snackbar("Imagen agregada")

        self.page.run_task(do_pick)

    async def _add_image_from_file(self, word_id: int, file_path: str, filename: str) -> None:
        """Agrega imagen desde archivo local."""
        try:
            # Leer archivo
            path = Path(file_path)
            if not path.exists():
                self._show_snackbar("Archivo no encontrado", error=True)
                return

            image_bytes = path.read_bytes()

            # Determinar mime type
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

            # Descargar imagen
            ctx = ssl.create_default_context()
            ctx.check_hostname = False
            ctx.verify_mode = ssl.CERT_NONE

            with urllib.request.urlopen(url, context=ctx, timeout=10) as response:
                image_bytes = response.read()
                content_type = response.headers.get("Content-Type", "image/png")

            # Extraer mime type
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
            # Leer imagen para obtener datos necesarios
            images_reader = ImagesReaderSqliteRepository.get_instance()
            image_data = await images_reader.get_by_id(image_id)
            if image_data:
                word_image_entity = WordImageEntity.from_primitives(image_data)
                writer = ImagesWriterSqliteRepository.get_instance()
                await writer.hard_delete(word_image_entity)
            await self._load_words()
            self._show_snackbar("Imagen eliminada")
            # Cerrar y reabrir dialogo
            if self._current_word_for_image:
                for word in self.words:
                    if word["id"] == self._current_word_for_image:
                        self._show_images_dialog(word)
                        break

        self.page.run_task(do_delete)

    def _on_search(self, e) -> None:
        """Maneja busqueda."""
        search_text = e.control.value or ""
        async def search():
            await self._load_words(search_text)
        self.page.run_task(search)

    def _delete_word(self, word_id: int) -> None:
        """Elimina una palabra."""
        async def do_delete():
            await self._do_delete(word_id)
        self.page.run_task(do_delete)

    async def _do_delete(self, word_id: int) -> None:
        """Ejecuta la eliminacion."""
        # Eliminar imagenes primero
        images_writer = ImagesWriterSqliteRepository.get_instance()
        await images_writer.delete_all_by_word(word_id)

        # Leer palabra para crear entidad
        reader = WordsEsReaderSqliteRepository.get_instance()
        word_data = await reader.get_by_id(word_id)
        if word_data:
            word_es_entity = WordEsEntity.from_primitives(word_data)
            writer = WordsEsWriterSqliteRepository.get_instance()
            await writer.delete(word_es_entity)
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
