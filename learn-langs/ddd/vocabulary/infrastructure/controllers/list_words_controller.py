"""Controller para listado de palabras."""

from typing import Callable, Any
from pathlib import Path

import flet as ft

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.list_words import ListWordsDto, ListWordsService
from ddd.vocabulary.application.delete_word import DeleteWordDto, DeleteWordService
from ddd.vocabulary.domain.entities import WordImageEntity
from ddd.vocabulary.domain.enums import ImageSourceEnum
from ddd.vocabulary.infrastructure.repositories import (
    ImagesReaderSqliteRepository,
    ImagesWriterSqliteRepository,
)
from ddd.vocabulary.infrastructure.ui.views.list_words_view import ListWordsView
from ddd.vocabulary.infrastructure.ui.views.list_words_view_dto import (
    ListWordsViewDto,
    WordListItemViewDto,
)


class ListWordsController:
    """
    Controller para listado de palabras.

    Responsabilidades:
    - Orquestar flujo entre Vista y Servicios
    - Crear ViewDTOs y pasarlos a la Vista
    - Manejar callbacks de la Vista
    - Gestionar dialogos de imagenes
    - NO hereda de ft.Container
    """

    def __init__(
        self,
        on_back: Callable[[], None],
        on_create: Callable[[], None],
        on_edit: Callable[[int], None],
    ):
        self._on_back = on_back
        self._on_create = on_create
        self._on_edit = on_edit

        # Estado interno
        self._current_search: str = ""
        self._words: list[WordListItemViewDto] = []
        self._current_word_for_image: int | None = None

        # Servicios
        self._list_words_service = ListWordsService.get_instance()
        self._delete_word_service = DeleteWordService.get_instance()
        self._images_reader = ImagesReaderSqliteRepository.get_instance()
        self._images_writer = ImagesWriterSqliteRepository.get_instance()
        self._logger = Logger.get_instance()

        # Vista
        self._view = ListWordsView.from_primitives({
            "on_back": on_back,
            "on_create": on_create,
            "on_edit": on_edit,
            "on_delete": self._handle_delete,
            "on_search": self._handle_search,
            "on_show_images": self._handle_show_images,
            "on_mount": self._handle_mount,
        })

    @property
    def view(self) -> ft.Container:
        """Vista para montar en el arbol de Flet."""
        return self._view

    def _handle_mount(self) -> None:
        """Callback cuando la vista se monta."""
        self._view.page.run_task(self._async_load_words)

    async def _async_load_words(self) -> None:
        """Carga la lista de palabras."""
        # Mostrar loading
        self._view.render(ListWordsViewDto.loading())

        try:
            dto = ListWordsDto.from_primitives({
                "search": self._current_search,
                "limit": 100,
            })

            result = await self._list_words_service(dto)

            # Convertir a DTOs de vista
            self._words = [
                WordListItemViewDto.from_primitives({
                    "id": w.id,
                    "text": w.text,
                    "word_type": w.word_type,
                    "notes": w.notes,
                    "created_at": w.created_at,
                    "image_count": w.image_count,
                    "tags": w.tags,
                    "translations": w.translations,
                })
                for w in result.words
            ]

            view_dto = ListWordsViewDto.ok(
                words=self._words,
                total_count=result.total_count,
                has_more=result.has_more,
            )
            self._view.render(view_dto)

        except Exception as e:
            self._logger.write_error(
                "ListWordsController",
                f"Error cargando palabras: {e}",
                {"search": self._current_search},
            )
            self._view.render(ListWordsViewDto.error(f"Error al cargar: {e}"))

    def _handle_search(self, search_text: str) -> None:
        """Maneja cambio en busqueda."""
        self._current_search = search_text
        self._view.page.run_task(self._async_load_words)

    def _handle_delete(self, word_id: int) -> None:
        """Maneja click en eliminar."""
        self._view.page.run_task(lambda: self._async_delete_word(word_id))

    async def _async_delete_word(self, word_id: int) -> None:
        """Elimina una palabra."""
        try:
            dto = DeleteWordDto.from_primitives({"word_id": word_id})
            result = await self._delete_word_service(dto)

            self._view.show_snackbar(
                f"Palabra '{result.text}' eliminada"
            )
            await self._async_load_words()

        except Exception as e:
            self._logger.write_error(
                "ListWordsController",
                f"Error eliminando palabra: {e}",
                {"word_id": word_id},
            )
            self._view.show_snackbar(f"Error: {e}", error=True)

    def _handle_show_images(self, word_id: int) -> None:
        """Maneja click en imagenes."""
        self._current_word_for_image = word_id
        self._view.page.run_task(lambda: self._async_show_images_dialog(word_id))

    async def _async_show_images_dialog(self, word_id: int) -> None:
        """Muestra dialogo de imagenes."""
        try:
            # Buscar la palabra
            word = next((w for w in self._words if w.id == word_id), None)
            if not word:
                return

            images = await self._images_reader.get_by_word_id(word_id)
            self._display_images_dialog(word, images or [])

        except Exception as e:
            self._logger.write_error(
                "ListWordsController",
                f"Error cargando imagenes: {e}",
                {"word_id": word_id},
            )
            self._view.show_snackbar(f"Error al cargar imagenes: {e}", error=True)

    def _display_images_dialog(
        self,
        word: WordListItemViewDto,
        images: list[dict],
    ) -> None:
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

        dialog: ft.AlertDialog | None = None

        def close_dialog(e=None):
            if dialog:
                self._view.page.close(dialog)

        def add_from_url(e):
            url = url_field.value
            if url and url.strip():
                async def save_url():
                    await self._add_image_from_url(word.id, url.strip())
                    close_dialog()
                self._view.page.run_task(save_url)

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

        self._view.page.open(dialog)

    def _pick_image_file(self) -> None:
        """Abre el file picker para seleccionar imagen."""
        async def do_pick():
            file_picker = ft.FilePicker()
            self._view.page.overlay.append(file_picker)
            self._view.page.update()

            files = await file_picker.pick_files_async(
                allowed_extensions=["png", "jpg", "jpeg", "gif", "webp", "svg", "bmp"],
                allow_multiple=False,
            )

            self._view.page.overlay.remove(file_picker)
            self._view.page.update()

            if files and len(files) > 0 and self._current_word_for_image:
                file = files[0]
                await self._add_image_from_file(
                    self._current_word_for_image,
                    file.path,
                    file.name,
                )
                await self._async_load_words()
                self._view.show_snackbar("Imagen agregada")

        self._view.page.run_task(do_pick)

    async def _add_image_from_file(self, word_id: int, file_path: str, filename: str) -> None:
        """Agrega imagen desde archivo local."""
        try:
            path = Path(file_path)
            if not path.exists():
                self._view.show_snackbar("Archivo no encontrado", error=True)
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
            await self._images_writer.save_image_bytes(word_image_entity, image_bytes)

        except Exception as e:
            self._logger.write_error(
                "ListWordsController",
                f"Error agregando imagen desde archivo: {e}",
                {"word_id": word_id, "file_path": file_path},
            )
            self._view.show_snackbar(f"Error: {e}", error=True)

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
            await self._images_writer.save_image_bytes(word_image_entity, image_bytes)

            await self._async_load_words()
            self._view.show_snackbar("Imagen agregada desde URL")

        except Exception as e:
            self._logger.write_error(
                "ListWordsController",
                f"Error agregando imagen desde URL: {e}",
                {"word_id": word_id, "url": url},
            )
            self._view.show_snackbar(f"Error descargando imagen: {e}", error=True)

    def _delete_image(self, image_id: int) -> None:
        """Elimina una imagen."""
        async def do_delete():
            try:
                image_data = await self._images_reader.get_by_id(image_id)
                if image_data:
                    word_image_entity = WordImageEntity.from_primitives(image_data)
                    await self._images_writer.hard_delete(word_image_entity)
                await self._async_load_words()
                self._view.show_snackbar("Imagen eliminada")
            except Exception as e:
                self._logger.write_error(
                    "ListWordsController",
                    f"Error eliminando imagen: {e}",
                    {"image_id": image_id},
                )
                self._view.show_snackbar(f"Error: {e}", error=True)

        self._view.page.run_task(do_delete)
