"""Controller para listado de palabras."""

from pathlib import Path
from typing import Callable

import flet as ft

from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.controllers import BaseController
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
from ddd.vocabulary.application.add_word_ia_image import (
    AddWordIaImageDto,
    AddWordIaImageService,
)
from ddd.vocabulary.infrastructure.repositories import (
    ImagesReaderSqliteRepository,
    WordGroupsReaderSqliteRepository,
)
from ddd.vocabulary.infrastructure.ui.views.list_words_view import ListWordsView
from ddd.vocabulary.infrastructure.ui.views.list_words_view_dto import (
    ListWordsViewDto,
    WordListItemViewDto,
)


class ListWordsController(BaseController):
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

    # Tamaño de página para el listado paginado
    _PAGE_SIZE: int = 100

    # =========================================================================
    # CONSTRUCCIÓN
    # =========================================================================
    def __init__(
        self,
        route_on_back: Callable[[], None],          # 1. Navegación back (header izquierda)
        route_on_create: Callable[[], None],        # 2. Botón crear palabra (header derecha)
        route_on_edit: Callable[[int], None],       # 3. Botón editar palabra (item lista)
    ):
        # Callbacks de navegación (inyectados desde app_router)
        self._route_on_back = route_on_back
        self._route_on_create = route_on_create
        self._route_on_edit = route_on_edit

        # Estado del controller
        self._current_search: str = ""
        self._current_page: int = 0
        self._words: list[WordListItemViewDto] = []
        self._current_word_for_image: int | None = None
        self._current_dialog: ft.AlertDialog | None = None
        self._current_images_column: ft.Column | None = None

        # Servicios e infraestructura
        self._ft_file_picker = ft.FilePicker()
        self._logger = Logger.get_instance()
        self._list_words_service = ListWordsService.get_instance()
        self._delete_word_service = DeleteWordService.get_instance()
        self._get_word_images_service = GetWordImagesService.get_instance()
        self._add_word_image_service = AddWordImageService.get_instance()
        self._add_word_ia_image_service = AddWordIaImageService.get_instance()
        self._delete_word_image_service = DeleteWordImageService.get_instance()
        self._images_reader = ImagesReaderSqliteRepository.get_instance()
        self._word_groups_reader = WordGroupsReaderSqliteRepository.get_instance()

        # Vista (instancia de ListWordsView)
        self._ft_container = ListWordsView.from_primitives({
            "on_mount": self._on_mount,
            "on_back": self._route_on_back,
            "on_create": self._route_on_create,
            "on_search": self._on_search_input,
            "on_edit": self._route_on_edit,
            "on_delete": self._on_delete_btn_click,
            "on_show_images": self._on_images_btn_click,
            "on_prev_page": self._on_prev_page_click,
            "on_next_page": self._on_next_page_click,
            "on_zoom_image": self._on_zoom_image_click,
        })

    # =========================================================================
    # API PÚBLICA
    # =========================================================================
    # app_router.invoked
    @property
    def ft_container(self) -> ft.Container:
        """Vista para montar en el arbol de Flet."""
        return self._ft_container

    def refresh(self) -> None:
        """Recarga datos. Usar para refresh externo si se necesita."""
        self._ft_container.page.run_task(self._async_load_words)

    # =========================================================================
    # LIFECYCLE & CARGA DE DATOS
    # =========================================================================
    def _on_mount(self) -> None:
        """Callback cuando la vista se monta. Carga datos iniciales."""
        self._ft_container.page.run_task(self._async_load_words)

    async def _async_load_words(self) -> None:
        """Carga la lista de palabras desde el servicio y actualiza la vista."""
        # Mostrar loading
        self._ft_container.render(ListWordsViewDto.loading())

        try:
            result = await self._list_words_service(
                ListWordsDto.from_primitives({
                    "search": self._current_search,
                    "limit": self._PAGE_SIZE,
                    "offset": self._current_page * self._PAGE_SIZE,
                })
            )

            # Cargar palabras
            words_data = []
            for w in result.words:
                word_data = {
                    "id": w.id,
                    "text": w.text,
                    "word_type": w.word_type,
                    "notes": w.notes,
                    "created_at": w.created_at,
                    "image_count": w.image_count,
                    "tags": w.tags,
                    "translations": w.translations,
                    "last_image_path": "",
                    "groups": [],
                }

                # Si tiene imágenes, cargar la última
                if w.image_count > 0:
                    images = await self._images_reader.get_word_es_images_by_word_es_id(w.id)
                    if images:
                        # get_by_word_id ya ordena por is_primary DESC, sort_order, created_at
                        # Así que el último elemento es la última imagen agregada
                        word_data["last_image_path"] = images[-1].get("file_path", "")

                # Cargar grupos de la palabra
                word_groups = await self._word_groups_reader.get_word_group_by_word_es_id(w.id)
                word_data["groups"] = [g.get("title", "") for g in word_groups]

                words_data.append(word_data)

            self._words = [WordListItemViewDto.from_primitives(w) for w in words_data]

            view_dto = ListWordsViewDto.ok(
                words=self._words,
                total_count=result.total_count,
                has_more=result.has_more,
                page=self._current_page,
                page_size=self._PAGE_SIZE,
            )
            self._ft_container.render(view_dto)

        except Exception as e:
            self._logger.log_error(
                "ListWordsController",
                f"Error cargando palabras: {e}",
                {"search": self._current_search},
            )
            self._ft_container.render(ListWordsViewDto.error(f"Error al cargar: {e}"))

    # =========================================================================
    # EVENT HANDLERS (orden visual/lógico de arriba a abajo en UI)
    # =========================================================================
    def _on_search_input(self, search_text: str) -> None:
        """Maneja cambio en busqueda (search field - header)."""
        self._current_search = search_text
        self._current_page = 0  # nueva búsqueda -> volver a la primera página
        self._ft_container.page.run_task(self._async_load_words)

    def _on_prev_page_click(self) -> None:
        """Va a la página anterior."""
        if self._current_page > 0:
            self._current_page -= 1
            self._ft_container.page.run_task(self._async_load_words)

    def _on_next_page_click(self) -> None:
        """Va a la página siguiente."""
        self._current_page += 1
        self._ft_container.page.run_task(self._async_load_words)

    def _on_zoom_image_click(self, image_full_path: str) -> None:
        """Amplía la imagen del listado (lupa)."""
        self._show_large_image(image_full_path)

    def _on_delete_btn_click(self, word_id: int) -> None:
        """Maneja click en eliminar (botón delete - item lista)."""
        async def _task():
            await self._async_delete_word(word_id)
        self._ft_container.page.run_task(_task)


    def _on_images_btn_click(self, word_id: int) -> None:
        """Maneja click en imagenes (botón image - item lista)."""
        self._current_word_for_image = word_id
        async def _task():
            await self._async_show_images_dialog(word_id)
        self._ft_container.page.run_task(_task)

    # =========================================================================
    # GESTIÓN DE PALABRAS (CRUD)
    # =========================================================================
    async def _async_delete_word(self, word_id: int) -> None:
        """Elimina una palabra via servicio."""
        try:
            dto = DeleteWordDto.from_primitives({"word_id": word_id})
            result = await self._delete_word_service(dto)

            self._ft_container.show_snackbar(f"Palabra '{result.text}' eliminada")
            await self._async_load_words()

        except Exception as e:
            self._logger.log_error(
                "ListWordsController",
                f"Error eliminando palabra: {e}",
                {"word_id": word_id},
            )
            self._ft_container.show_snackbar(f"Error: {e}", error=True)

    # =========================================================================
    # GESTIÓN DE IMAGENES (Dialogo y operaciones)
    # =========================================================================
    def _get_image_full_path(self, filename: str) -> str:
        """Obtiene la ruta completa de una imagen."""
        base_path = Path(__file__).parent.parent.parent.parent.parent
        return str(base_path / "data" / "images" / filename)

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
                self._display_images_dialog(word, list(result.images))
            else:
                self._ft_container.show_snackbar(
                    result.error_message or "Error cargando imagenes",
                    error=True,
                )

        except Exception as e:
            self._logger.log_error(
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
            for img_dict in images:
                img_file_name = img_dict.get("file_path", "")
                img_full_path = self._get_image_full_path(img_file_name)

                ft_image = ft.Image(
                    src=img_full_path,
                    width=50,
                    height=50,
                    fit=ft.BoxFit.COVER,
                    border_radius=4,
                )
                # Miniatura clicable -> abre la imagen ampliada
                ft_thumb = ft.Container(
                    content=ft_image,
                    on_click=lambda e, p=img_full_path: self._show_large_image(p),
                    tooltip="Ampliar imagen",
                )

                ft_row = ft.Row(
                    controls=[
                        ft_thumb,
                        ft.Icon(
                            ft.Icons.STAR if img_dict.get("is_primary") else ft.Icons.IMAGE,
                            color=ft.Colors.AMBER_500 if img_dict.get("is_primary") else ft.Colors.GREY_500,
                            size=16,
                        ),
                        ft.Text(
                            img_full_path[:25] + "..." if len(img_full_path) > 25 else img_full_path,
                            size=11,
                            expand=True,
                        ),
                        ft.Text(img_dict.get("source_type", ""), size=10, color=ft.Colors.GREY_600),
                        ft.IconButton(
                            icon=ft.Icons.ZOOM_IN,
                            icon_color=ft.Colors.BLUE_500,
                            icon_size=18,
                            on_click=lambda e, p=img_full_path: self._show_large_image(p),
                            tooltip="Ampliar imagen",
                        ),
                        ft.IconButton(
                            icon=ft.Icons.DELETE,
                            icon_color=ft.Colors.RED_400,
                            icon_size=18,
                            on_click=lambda e, i=img_dict: self._delete_image(i.get("id")),
                            tooltip="Eliminar imagen",
                        ),
                    ],
                    alignment=ft.MainAxisAlignment.START,
                    spacing=8,
                )
                self._current_images_column.controls.append(ft_row)
        else:
            self._current_images_column.controls.append(
                ft.Text("No hay imagenes", italic=True, color=ft.Colors.GREY_500)
            )

    def _show_large_image(self, image_full_path: str) -> None:
        """Abre un dialogo con la imagen ampliada (sobre el modal actual)."""
        page = self._ft_container.page

        def close_large(e=None):
            large_dialog.open = False
            page.update()

        large_dialog = ft.AlertDialog(
            content=ft.Container(
                content=ft.Image(src=image_full_path, fit=ft.BoxFit.CONTAIN),
                width=640,
                height=640,
                alignment=ft.Alignment.CENTER,
            ),
            actions=[ft.TextButton("Cerrar", on_click=close_large)],
            actions_alignment=ft.MainAxisAlignment.END,
        )

        page.overlay.append(large_dialog)
        large_dialog.open = True
        page.update()

    async def _refresh_images_dialog(self) -> None:
        """Recarga las imagenes en el dialogo actual."""
        if not self._current_word_for_image or not self._current_images_column:
            return

        result = await self._get_word_images_service(
            GetWordImagesDto.from_primitives({"word_id": self._current_word_for_image})
        )

        if result.success:
            self._render_images_list(list(result.images))
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

        ft_dialog: ft.AlertDialog | None = None

        def close_dialog(e=None):
            if ft_dialog:
                ft_dialog.open = False
                self._ft_container.page.update()

        def add_from_url(e):
            url = url_field.value
            if url and url.strip():
                async def save_url():
                    await self._add_image_from_url(word.id, url.strip())
                    url_field.value = ""
                    self._ft_container.page.update()
                self._ft_container.page.run_task(save_url)

        ft_dialog = ft.AlertDialog(
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
                                ft.ElevatedButton(
                                    content=ft.Row([ft.Icon(ft.Icons.AUTO_AWESOME), ft.Text("IA Image")]),
                                    on_click=lambda e: self._on_add_ia_image_click(word.id),
                                    style=ft.ButtonStyle(
                                        bgcolor=ft.Colors.PURPLE_600,
                                        color=ft.Colors.WHITE,
                                    ),
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

        self._current_dialog = ft_dialog
        self._ft_container.page.show_dialog(ft_dialog)

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
            # No recargar lista completa para mantener posición de scroll
            self._ft_container.show_snackbar(f"Imagen '{ft_file_picker_file.name}' agregada")


    async def _add_image_from_file(self, word_id: int, file_path: str, filename: str) -> None:
        """Agrega imagen desde archivo local via servicio."""
        try:
            dto = AddWordImageDto.from_file(word_id, file_path, filename)
            result = await self._add_word_image_service(dto)

            if not result.success:
                self._ft_container.show_snackbar(result.error_message or "Error", error=True)

        except Exception as e:
            self._logger.log_error(
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
                # No recargar lista completa para mantener posición de scroll
                self._ft_container.show_snackbar("Imagen agregada desde URL")
            else:
                self._ft_container.show_snackbar(result.error_message or "Error", error=True)

        except Exception as e:
            self._logger.log_error(
                "ListWordsController",
                f"Error agregando imagen desde URL: {e}",
                {"word_id": word_id, "url": url},
            )
            self._ft_container.show_snackbar(f"Error descargando imagen: {e}", error=True)

    def _on_add_ia_image_click(self, word_id: int) -> None:
        """Maneja click en botón IA Image."""
        async def generate_ia_image():
            try:
                self._ft_container.show_snackbar("Generando imagen con IA... (puede tardar 30s)", error=False)

                dto = AddWordIaImageDto.from_primitives({
                    "word_id": word_id,
                    "lang_code": "nl_NL",  # Idioma por defecto
                })

                result = await self._add_word_ia_image_service(dto)

                if result.success:
                    await self._refresh_images_dialog()
                    # No recargar lista completa para mantener posición de scroll
                    self._ft_container.show_snackbar(f"Imagen IA generada exitosamente")
                else:
                    self._ft_container.show_snackbar(
                        result.error_message or "Error generando imagen IA",
                        error=True
                    )

            except Exception as e:
                self._logger.log_error(
                    "ListWordsController",
                    f"Error generando imagen IA: {e}",
                    {"word_id": word_id},
                )
                self._ft_container.show_snackbar(f"Error: {e}", error=True)

        self._ft_container.page.run_task(generate_ia_image)

    def _delete_image(self, image_id: int) -> None:
        """Elimina una imagen via servicio."""
        async def do_delete():
            try:
                dto = DeleteWordImageDto.from_primitives({"image_id": image_id})
                result = await self._delete_word_image_service(dto)

                if result.success:
                    await self._refresh_images_dialog()
                    # No recargar lista completa para mantener posición de scroll
                    self._ft_container.show_snackbar("Imagen eliminada")
                else:
                    self._ft_container.show_snackbar(result.error_message or "Error", error=True)

            except Exception as e:
                self._logger.log_error(
                    "ListWordsController",
                    f"Error eliminando imagen: {e}",
                    {"image_id": image_id},
                )
                self._ft_container.show_snackbar(f"Error: {e}", error=True)

        self._ft_container.page.run_task(do_delete)
