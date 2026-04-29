"""Controller para listado de palabras."""

from pathlib import Path
from typing import Callable

import flet as ft
from mypy.build import initial_gc_freeze_done
from mypy.checker import is_more_general_arg_prefix

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
        self._route_on_back = on_back
        self._route_on_create = on_create
        self._route_on_edit = on_edit

        # Estado interno
        self._current_search: str = ""
        self._words: list[WordListItemViewDto] = []
        self._current_word_for_image: int | None = None
        self._current_dialog: ft.AlertDialog | None = None
        self._current_images_column: ft.Column | None = None

        # Servicios
        self._ft_file_picker = ft.FilePicker()
        self._logger = Logger.get_instance()
        self._list_words_service = ListWordsService.get_instance()
        self._delete_word_service = DeleteWordService.get_instance()
        self._get_word_images_service = GetWordImagesService.get_instance()
        self._add_word_image_service = AddWordImageService.get_instance()
        self._delete_word_image_service = DeleteWordImageService.get_instance()


        # Vista
        self._ft_container = ListWordsView.from_primitives({
            "on_back": self._route_on_back,
            "on_create": self._route_on_create,
            "on_edit": self._route_on_edit,
            "on_delete": self._on_delete_btn_click,
            "on_search": self._on_search_input,
            "on_show_images": self._on_images_btn_click,
            "on_mount": self._on_mount,
        })

    @property
    def ft_container(self) -> ft.Container:
        """Vista para montar en el arbol de Flet."""
        return self._ft_container

    def _get_image_full_path(self, filename: str) -> str:
        """Obtiene la ruta completa de una imagen."""
        base_path = Path(__file__).parent.parent.parent.parent.parent
        return str(base_path / "data" / "images" / filename)

    def _on_mount(self) -> None:
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

    def _on_search_input(self, search_text: str) -> None:
        """Maneja cambio en busqueda."""
        self._current_search = search_text
        self._ft_container.page.run_task(self._async_load_words)

    def _on_delete_btn_click(self, word_id: int) -> None:
        """Maneja click en eliminar."""
        async def _task():
            await self._async_delete_word(word_id)
        self._ft_container.page.run_task(_task)

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

    def _on_images_btn_click(self, word_id: int) -> None:
        """Maneja click en imagenes."""
        self._current_word_for_image = word_id
        async def _task():
            await self._async_show_images_dialog(word_id)
        self._ft_container.page.run_task(_task)

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

    def _render_images_list(self, images: list[dict]) -> None:
        """Renderiza la lista de imagenes en el column actual."""
        if not self._current_images_column:
            return

        self._current_images_column.controls.clear()

        if images:
            for img in images:
                img_file_name = img.get("file_path", "")
                img_full_path = self._get_image_full_path(img_file_name)

                # Thumbnail de la imagen
                thumbnail = ft.Image(
                    src=img_full_path,
                    width=50,
                    height=50,
                    fit=ft.BoxFit.COVER,
                    border_radius=4,
                )

                img_row = ft.Row(
                    controls=[
                        thumbnail,
                        ft.Icon(
                            ft.Icons.STAR if img.get("is_primary") else ft.Icons.IMAGE,
                            color=ft.Colors.AMBER_500 if img.get("is_primary") else ft.Colors.GREY_500,
                            size=16,
                        ),
                        ft.Text(
                            img_full_path[:25] + "..." if len(img_full_path) > 25 else img_full_path,
                            size=11,
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
                    spacing=8,
                )
                self._current_images_column.controls.append(img_row)
        else:
            self._current_images_column.controls.append(
                ft.Text("No hay imagenes", italic=True, color=ft.Colors.GREY_500)
            )

    async def _refresh_images_dialog(self) -> None:
        """Recarga las imagenes en el dialogo actual."""
        if not self._current_word_for_image or not self._current_images_column:
            return

        result = await self._get_word_images_service(
            GetWordImagesDto.from_primitives({"word_id": self._current_word_for_image})
        )

        if result.success:
            self._render_images_list(result.to_list_of_dicts())
            self._ft_container.page.update()

    def _display_images_dialog(
        self,
        word: WordListItemViewDto,
        images: list[dict],
    ) -> None:
        """Muestra el dialogo con las imagenes."""
        self._current_images_column = ft.Column(
            controls=[],
            spacing=10,
            scroll=ft.ScrollMode.AUTO,
            height=450,
        )

        self._render_images_list(images)

        url_field = ft.TextField(
            label="URL de imagen",
            hint_text="https://...",
            width=550,
        )

        dialog: ft.AlertDialog | None = None

        def close_dialog(e=None):
            if dialog:
                dialog.open = False
                self._ft_container.page.update()

        def add_from_url(e):
            url = url_field.value
            if url and url.strip():
                async def save_url():
                    await self._add_image_from_url(word.id, url.strip())
                    url_field.value = ""
                    self._ft_container.page.update()
                self._ft_container.page.run_task(save_url)

        dialog = ft.AlertDialog(
            title=ft.Text(f"Imagenes: {word.text}"),
            content=ft.Container(
                content=ft.Column(
                    controls=[
                        self._current_images_column,
                        ft.Divider(),
                        ft.Text("Agregar imagen:", weight=ft.FontWeight.BOLD, size=14),
                        ft.Row(
                            controls=[
                                ft.ElevatedButton(
                                    content=ft.Row([ft.Icon(ft.Icons.FOLDER_OPEN), ft.Text("Archivo")]),
                                    on_click=self.handle_pick_files,
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
                width=600,
            ),
            actions=[
                ft.TextButton(content=ft.Text("Cerrar"), on_click=close_dialog),
            ],
        )

        self._current_dialog = dialog
        self._ft_container.page.show_dialog(dialog)

    async def handle_pick_files(self, e: ft.Event[ft.Button]):
        ft_file_picker_files = await self._ft_file_picker.pick_files(
            allowed_extensions=["png", "jpg", "jpeg", "gif", "webp", "svg", "bmp"],
            allow_multiple=False,
        )

        if ft_file_picker_files and self._current_word_for_image:
            ft_file_picker_file = ft_file_picker_files[0]
            await self._add_image_from_file(
                self._current_word_for_image,
                ft_file_picker_file.path,
                ft_file_picker_file.name,
            )
            await self._refresh_images_dialog()
            await self._async_load_words()
            self._ft_container.show_snackbar(f"Imagen '{ft_file_picker_file.name}' agregada")


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
                await self._refresh_images_dialog()
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
                    await self._refresh_images_dialog()
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
