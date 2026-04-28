"""Controller para listado de palabras."""

from typing import Callable

import flet as ft

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.list_words import ListWordsDto, ListWordsService
from ddd.vocabulary.application.delete_word import DeleteWordDto, DeleteWordService
from ddd.vocabulary.application.get_word_images import (
    GetWordImagesDto,
    GetWordImagesService,
)
from ddd.vocabulary.application.add_word_image import (
    AddWordImageDto,
    AddWordImageService,
)
from ddd.vocabulary.application.delete_word_image import (
    DeleteWordImageDto,
    DeleteWordImageService,
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
    - NO usa repositorios directamente
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
        self._get_word_images_service = GetWordImagesService.get_instance()
        self._add_word_image_service = AddWordImageService.get_instance()
        self._delete_word_image_service = DeleteWordImageService.get_instance()
        self._logger = Logger.get_instance()

        # Vista
        self._ft_container = ListWordsView.from_primitives({
            "on_back": on_back,
            "on_create": on_create,
            "on_edit": on_edit,
            "on_delete": self._handle_delete,
            "on_search": self._handle_search,
            "on_show_images": self._handle_show_images,
            "on_mount": self._handle_mount,
        })

    @property
    def ft_container(self) -> ft.Container:
        """Vista para montar en el arbol de Flet."""
        return self._ft_container

    def _handle_mount(self) -> None:
        """Callback cuando la vista se monta."""
        self._ft_container.page.run_task(self._async_load_words)

    async def _async_load_words(self) -> None:
        """Carga la lista de palabras."""
        # Mostrar loading
        self._ft_container.render(ListWordsViewDto.loading())

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
            self._ft_container.render(view_dto)

        except Exception as e:
            self._logger.write_error(
                "ListWordsController",
                f"Error cargando palabras: {e}",
                {"search": self._current_search},
            )
            self._ft_container.render(ListWordsViewDto.error(f"Error al cargar: {e}"))

    def _handle_search(self, search_text: str) -> None:
        """Maneja cambio en busqueda."""
        self._current_search = search_text
        self._ft_container.page.run_task(self._async_load_words)

    def _handle_delete(self, word_id: int) -> None:
        """Maneja click en eliminar."""
        self._ft_container.page.run_task(lambda: self._async_delete_word(word_id))

    async def _async_delete_word(self, word_id: int) -> None:
        """Elimina una palabra."""
        try:
            dto = DeleteWordDto.from_primitives({"word_id": word_id})
            result = await self._delete_word_service(dto)

            self._ft_container.show_snackbar(f"Palabra '{result.text}' eliminada")
            await self._async_load_words()

        except Exception as e:
            self._logger.write_error(
                "ListWordsController",
                f"Error eliminando palabra: {e}",
                {"word_id": word_id},
            )
            self._ft_container.show_snackbar(f"Error: {e}", error=True)

    def _handle_show_images(self, word_id: int) -> None:
        """Maneja click en imagenes."""
        self._current_word_for_image = word_id
        self._ft_container.page.run_task(lambda: self._async_show_images_dialog(word_id))

    async def _async_show_images_dialog(self, word_id: int) -> None:
        """Muestra dialogo de imagenes."""
        try:
            # Buscar la palabra
            word = next((w for w in self._words if w.id == word_id), None)
            if not word:
                return

            # Obtener imagenes via servicio
            result = await self._get_word_images_service(
                GetWordImagesDto.from_primitives({"word_id": word_id})
            )

            if result.success:
                self._display_images_dialog(word, result.to_list_of_dicts())
            else:
                self._ft_container.show_snackbar(
                    result.error_message or "Error cargando imagenes",
                    error=True,
                )

        except Exception as e:
            self._logger.write_error(
                "ListWordsController",
                f"Error mostrando imagenes: {e}",
                {"word_id": word_id},
            )
            self._ft_container.show_snackbar(f"Error al cargar imagenes: {e}", error=True)

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
                img_row = ft.Row(
                    controls=[
                        ft.Icon(
                            ft.Icons.STAR if img.get("is_primary") else ft.Icons.IMAGE,
                            color=ft.Colors.AMBER_500 if img.get("is_primary") else ft.Colors.GREY_500,
                            size=20,
                        ),
                        ft.Text(
                            img["file_path"][:30] + "..." if len(img.get("file_path", "")) > 30 else img.get("file_path", ""),
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
                self._ft_container.page.close(dialog)

        def add_from_url(e):
            url = url_field.value
            if url and url.strip():
                async def save_url():
                    await self._add_image_from_url(word.id, url.strip())
                    close_dialog()
                self._ft_container.page.run_task(save_url)

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

        self._ft_container.page.open(dialog)

    def _pick_image_file(self) -> None:
        """Abre el file picker para seleccionar imagen."""
        async def do_pick():
            file_picker = ft.FilePicker()
            self._ft_container.page.overlay.append(file_picker)
            self._ft_container.page.update()

            files = await file_picker.pick_files_async(
                allowed_extensions=["png", "jpg", "jpeg", "gif", "webp", "svg", "bmp"],
                allow_multiple=False,
            )

            self._ft_container.page.overlay.remove(file_picker)
            self._ft_container.page.update()

            if files and len(files) > 0 and self._current_word_for_image:
                file = files[0]
                await self._add_image_from_file(
                    self._current_word_for_image,
                    file.path,
                    file.name,
                )
                await self._async_load_words()
                self._ft_container.show_snackbar("Imagen agregada")

        self._ft_container.page.run_task(do_pick)

    async def _add_image_from_file(self, word_id: int, file_path: str, filename: str) -> None:
        """Agrega imagen desde archivo local via servicio."""
        try:
            dto = AddWordImageDto.from_file(word_id, file_path, filename)
            result = await self._add_word_image_service(dto)

            if not result.success:
                self._ft_container.show_snackbar(result.error_message or "Error", error=True)

        except Exception as e:
            self._logger.write_error(
                "ListWordsController",
                f"Error agregando imagen desde archivo: {e}",
                {"word_id": word_id, "file_path": file_path},
            )
            self._ft_container.show_snackbar(f"Error: {e}", error=True)

    async def _add_image_from_url(self, word_id: int, url: str) -> None:
        """Agrega imagen desde URL via servicio."""
        try:
            dto = AddWordImageDto.from_url(word_id, url)
            result = await self._add_word_image_service(dto)

            if result.success:
                await self._async_load_words()
                self._ft_container.show_snackbar("Imagen agregada desde URL")
            else:
                self._ft_container.show_snackbar(result.error_message or "Error", error=True)

        except Exception as e:
            self._logger.write_error(
                "ListWordsController",
                f"Error agregando imagen desde URL: {e}",
                {"word_id": word_id, "url": url},
            )
            self._ft_container.show_snackbar(f"Error descargando imagen: {e}", error=True)

    def _delete_image(self, image_id: int) -> None:
        """Elimina una imagen via servicio."""
        async def do_delete():
            try:
                dto = DeleteWordImageDto.from_primitives({"image_id": image_id})
                result = await self._delete_word_image_service(dto)

                if result.success:
                    await self._async_load_words()
                    self._ft_container.show_snackbar("Imagen eliminada")
                else:
                    self._ft_container.show_snackbar(result.error_message or "Error", error=True)

            except Exception as e:
                self._logger.write_error(
                    "ListWordsController",
                    f"Error eliminando imagen: {e}",
                    {"image_id": image_id},
                )
                self._ft_container.show_snackbar(f"Error: {e}", error=True)

        self._ft_container.page.run_task(do_delete)
