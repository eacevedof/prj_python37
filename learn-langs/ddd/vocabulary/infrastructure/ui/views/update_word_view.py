"""Vista para editar palabras - Solo renderizado."""

import os
import flet as ft
from typing import Callable, Any, Self

from ddd.shared.infrastructure.components.logger import Logger
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

    # =========================================================================
    # CONSTRUCCIÓN (Public API)
    # =========================================================================
    def __init__(
        self,
        route_on_mount: Callable[[], None] | None,         # 1. Lifecycle (se ejecuta primero)
        route_on_submit: Callable[[dict[str, Any]], None], # 2. Submit formulario (render paso 1)
        route_on_back: Callable[[], None],                 # 3. Botón cancelar/volver (acción secundaria)
    ):
        super().__init__()

        # Callbacks al controller (en orden de ejecución)
        self._route_on_mount = route_on_mount
        self._route_on_submit = route_on_submit
        self._route_on_back = route_on_back

        # Logger
        self._logger = Logger.get_instance()

        # Estado local de tags seleccionados
        self._selected_tags: list[str] = []
        self._available_tags: list[dict[str, Any]] = []

        # Estado local de imagenes
        self._word_images: list[dict[str, Any]] = []

        # Estado local de grupos
        self._word_groups: list[dict[str, Any]] = []
        self._available_groups: list[dict[str, Any]] = []
        self._selected_group_ids: list[int] = []

        # Componentes UI - Header
        self._ft_word_groups_text: ft.Text | None = None
        self._ft_groups_column: ft.Column | None = None

        # Componentes UI - Form fields
        self._ft_text_es_field: ft.TextField | None = None
        self._ft_text_nl_field: ft.TextField | None = None
        self._ft_word_type_dropdown: ft.Dropdown | None = None
        self._ft_notes_field: ft.TextField | None = None
        self._ft_tags_row: ft.Row | None = None
        self._ft_loading_indicator: ft.ProgressRing | None = None
        self._ft_form_container: ft.Container | None = None
        self._ft_error_text: ft.Text | None = None
        self._ft_success_text: ft.Text | None = None

        # Componentes UI - Images
        self._ft_last_image_container: ft.Container | None = None
        self._ft_images_grid: ft.Row | None = None

        self._build_initial_ui()

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        """Crea la vista desde un diccionario de callbacks."""
        return cls(
            route_on_mount=primitives.get("on_mount"),
            route_on_submit=primitives.get("on_submit", lambda x: None),
            route_on_back=primitives.get("on_back", lambda: None),
        )

    # =========================================================================
    # API PÚBLICA - RENDERIZADO
    # =========================================================================
    def render(self, dto: UpdateWordViewDto) -> None:
        """Renderiza la vista con los datos del DTO."""
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

        # Imagenes disponibles
        self._word_images = list(dto.word_images)
        self._render_images()

        # Grupos de palabras
        self._word_groups = list(dto.word_groups)
        self._available_groups = list(dto.available_groups)
        self._selected_group_ids = [g.get("id", 0) for g in self._word_groups]
        self._render_word_groups()

        # Mensajes
        self._render_messages(dto)

        # Highlight campo con error
        if dto.error_field:
            self._highlight_error_field(dto.error_field)

        self.update()

    def show_snackbar(self, message: str, error: bool = False) -> None:
        """Muestra un snackbar."""
        self.page.snack_bar = ft.SnackBar(
            content=ft.Text(message),
            bgcolor=ft.Colors.RED_700 if error else ft.Colors.GREEN_700,
        )
        self.page.snack_bar.open = True
        self.page.update()

    # =========================================================================
    # LIFECYCLE HOOKS (Flet)
    # =========================================================================
    def did_mount(self) -> None:
        """Flet llama esto al montar. Notifica al Controller."""
        if self._route_on_mount:
            self._route_on_mount()

    # =========================================================================
    # CONSTRUCCIÓN DE UI (Privado)
    # =========================================================================
    def _build_initial_ui(self) -> None:
        """Construye la estructura inicial de la UI."""
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

        self._ft_groups_column = ft.Column(
            controls=[],
            spacing=4,
        )

        # Contenedor para última imagen
        self._ft_last_image_container = ft.Container(
            content=ft.Text("No hay imágenes", italic=True, color=ft.Colors.GREY_500, size=12),
            visible=False,
        )

        # Grid de imágenes (listado)
        self._ft_images_grid = ft.Row(
            controls=[],
            wrap=True,
            spacing=8,
            scroll=ft.ScrollMode.AUTO,
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

        # Columna izquierda - Formulario
        left_column = ft.Column(
            controls=[
                self._ft_text_es_field,
                ft.Container(height=8),
                self._ft_text_nl_field,
                ft.Container(height=8),
                self._ft_word_type_dropdown,
                ft.Container(height=8),
                self._ft_notes_field,
            ],
            spacing=4,
        )

        # Columna derecha - Imagen, tags y grupos
        right_column = ft.Column(
            controls=[
                ft.Text("Última imagen:", size=12, weight=ft.FontWeight.W_500),
                self._ft_last_image_container,
                ft.Container(height=10),
                ft.Text("Tags:", size=12, weight=ft.FontWeight.W_500),
                ft.Container(
                    content=self._ft_tags_row,
                    width=220,
                ),
                ft.Container(height=10),
                ft.Text("Grupos:", size=12, weight=ft.FontWeight.W_500),
                ft.Container(
                    content=self._ft_groups_column,
                    width=220,
                ),
            ],
            spacing=4,
        )

        # Form card con dos columnas y scroll
        self._ft_form_container = ft.Container(
            content=ft.Column(
                controls=[
                    ft.Row(
                        controls=[
                            left_column,
                            ft.Container(width=20),
                            right_column,
                        ],
                        vertical_alignment=ft.CrossAxisAlignment.START,
                    ),
                    ft.Container(height=12),
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
                scroll=ft.ScrollMode.AUTO,
            ),
            padding=20,
            bgcolor=ft.Colors.WHITE,
            border_radius=12,
            border=ft.border.all(1, ft.Colors.GREY_300),
            width=750,
            height=600,
            visible=False,
        )

        # Word groups text (header)
        self._ft_word_groups_text = ft.Text(
            "",
            size=12,
            color=ft.Colors.GREY_600,
            italic=True,
        )

        self.content = ft.Column(
            controls=[
                ft.Row(
                    controls=[
                        back_btn,
                        ft.Column(
                            controls=[
                                ft.Text(
                                    "Editar palabra",
                                    size=24,
                                    weight=ft.FontWeight.BOLD,
                                ),
                                self._ft_word_groups_text,
                            ],
                            spacing=2,
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

    # =========================================================================
    # RENDERIZADO PARCIAL (en orden de ejecución en render())
    # =========================================================================
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
                    label=ft.Text(tag_name, size=10),
                    selected=is_selected,
                    on_select=lambda e, t=tag_name: self._toggle_tag(t),
                    bgcolor=tag.get("color") if is_selected else None,
                    height=28,
                )
                self._ft_tags_row.controls.append(chip)

    def _render_word_groups(self) -> None:
        """Renderiza los checkboxes de grupos de palabras."""
        if not self._ft_groups_column:
            return

        self._ft_groups_column.controls.clear()

        if not self._available_groups:
            self._ft_groups_column.controls.append(
                ft.Text(
                    "No hay grupos disponibles",
                    italic=True,
                    color=ft.Colors.GREY_500,
                    size=12,
                )
            )
        else:
            for group in self._available_groups:
                group_id = group.get("id", 0)
                group_title = group.get("title", "")
                is_generic = group_title.lower() == "generic"
                is_selected = group_id in self._selected_group_ids

                checkbox = ft.Checkbox(
                    label=group_title,
                    value=is_selected or is_generic,
                    disabled=is_generic,
                    on_change=lambda e, gid=group_id: self._toggle_group(gid, e.control.value),
                )
                self._ft_groups_column.controls.append(checkbox)

    def _get_full_image_path(self, relative_path: str) -> str:
        """Construye la ruta completa de la imagen desde la ruta relativa."""
        if not relative_path:
            return ""

        # Si ya es una ruta absoluta, devolverla tal cual
        if os.path.isabs(relative_path):
            return relative_path

        # Construir ruta absoluta desde data/images
        # C:\projects\prj_python37\learn-langs\data\images
        from pathlib import Path
        base_path = Path(__file__).parent.parent.parent.parent.parent.parent / "data" / "images"
        full_path = base_path / relative_path
        return str(full_path)

    def _render_images(self) -> None:
        """Renderiza las imagenes de la palabra."""
        if not self._ft_last_image_container or not self._ft_images_grid:
            return

        # Limpiar grid
        self._ft_images_grid.controls.clear()

        if not self._word_images:
            self._ft_last_image_container.visible = False
            self._ft_images_grid.controls.append(
                ft.Text(
                    "No hay imagenes",
                    italic=True,
                    color=ft.Colors.GREY_500,
                    size=12,
                )
            )
            return

        # Mostrar última imagen (la última del array)
        last_image = self._word_images[-1]
        self._render_last_image(last_image)

        # Mostrar grid de todas las imagenes
        thumbnails_added = 0
        for image_data in self._word_images:
            relative_path = image_data.get("file_path", "")
            if not relative_path:
                continue

            full_path = self._get_full_image_path(relative_path)
            if not full_path or not os.path.exists(full_path):
                # Agregar placeholder para imagen no encontrada
                self._ft_images_grid.controls.append(
                    ft.Container(
                        content=ft.Icon(ft.Icons.BROKEN_IMAGE, size=40, color=ft.Colors.GREY_400),
                        width=80,
                        height=80,
                        border=ft.border.all(2, ft.Colors.RED_300),
                        border_radius=4,
                        bgcolor=ft.Colors.GREY_100,
                    )
                )
                thumbnails_added += 1
                continue

            try:
                # Crear thumbnail clickeable
                thumbnail = ft.Container(
                    content=ft.Image(
                        src=full_path,
                        width=80,
                        height=80,
                        fit=ft.BoxFit.COVER,
                        border_radius=4,
                    ),
                    border=ft.border.all(2, ft.Colors.GREY_300),
                    border_radius=4,
                    on_click=lambda e, img=full_path: self._show_fullscreen_image(img),
                    tooltip="Click para ampliar",
                    ink=True,
                )
                self._ft_images_grid.controls.append(thumbnail)
                thumbnails_added += 1
            except Exception as ex:
                # Log error
                self._logger.log_error(
                    "UpdateWordView",
                    f"Error renderizando thumbnail de imagen: {ex}",
                    {"image_path": full_path}
                )
                # Agregar placeholder para error
                self._ft_images_grid.controls.append(
                    ft.Container(
                        content=ft.Icon(ft.Icons.ERROR_OUTLINE, size=40, color=ft.Colors.RED_400),
                        width=80,
                        height=80,
                        border=ft.border.all(2, ft.Colors.RED_300),
                        border_radius=4,
                        bgcolor=ft.Colors.GREY_100,
                        tooltip=f"Error: {str(ex)}",
                    )
                )
                thumbnails_added += 1

        # Si no se agregó ningún thumbnail, mostrar mensaje
        if thumbnails_added == 0:
            self._ft_images_grid.controls.append(
                ft.Text(
                    "No se pudieron cargar las imagenes",
                    italic=True,
                    color=ft.Colors.ORANGE_500,
                    size=12,
                )
            )

    def _render_last_image(self, image_data: dict[str, Any]) -> None:
        """Renderiza la última imagen cargada."""
        if not self._ft_last_image_container:
            return

        relative_path = image_data.get("file_path", "")
        if not relative_path:
            self._ft_last_image_container.content = ft.Text(
                "No hay ruta de imagen",
                italic=True,
                color=ft.Colors.ORANGE_500,
                size=12,
            )
            self._ft_last_image_container.visible = True
            return

        full_path = self._get_full_image_path(relative_path)
        if not os.path.exists(full_path):
            self._ft_last_image_container.content = ft.Column([
                ft.Text(
                    "Imagen no encontrada",
                    italic=True,
                    color=ft.Colors.RED_500,
                    size=12,
                ),
                ft.Text(
                    f"Ruta: {relative_path}",
                    italic=True,
                    color=ft.Colors.GREY_500,
                    size=10,
                ),
            ])
            self._ft_last_image_container.visible = True
            return

        try:
            self._ft_last_image_container.content = ft.Container(
                content=ft.Image(
                    src=full_path,
                    width=200,
                    height=130,
                    fit=ft.BoxFit.CONTAIN,
                    border_radius=8,
                ),
                border=ft.border.all(1, ft.Colors.GREY_400),
                border_radius=8,
                padding=6,
                bgcolor=ft.Colors.GREY_100,
                on_click=lambda e: self._show_fullscreen_image(full_path),
                tooltip="Click para ampliar",
                ink=True,
            )
            self._ft_last_image_container.visible = True
        except Exception as ex:
            # Log error
            self._logger.log_error(
                "UpdateWordView",
                f"Error renderizando última imagen: {ex}",
                {"image_path": full_path, "relative_path": relative_path}
            )
            self._ft_last_image_container.content = ft.Column([
                ft.Text(
                    "Error al cargar imagen",
                    italic=True,
                    color=ft.Colors.RED_500,
                    size=12,
                ),
                ft.Text(
                    str(ex),
                    italic=True,
                    color=ft.Colors.GREY_500,
                    size=10,
                ),
            ])
            self._ft_last_image_container.visible = True

    def _show_fullscreen_image(self, image_path: str) -> None:
        """Muestra la imagen en pantalla completa."""
        if not self.page:
            return

        def close_dialog():
            dialog.open = False
            self.page.update()

        dialog = ft.AlertDialog(
            content=ft.Container(
                content=ft.Image(
                    src=image_path,
                    fit=ft.BoxFit.CONTAIN,
                ),
                width=self.page.window.width * 0.9 if self.page.window.width else 800,
                height=self.page.window.height * 0.8 if self.page.window.height else 600,
            ),
            actions=[
                ft.TextButton("Cerrar", on_click=lambda _: close_dialog()),
            ],
            actions_alignment=ft.MainAxisAlignment.CENTER,
        )

        self.page.overlay.append(dialog)
        dialog.open = True
        self.page.update()

    def _render_messages(self, dto: UpdateWordViewDto) -> None:
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
        """Destaca el campo con error en rojo."""
        field_map = {
            "text_es": self._ft_text_es_field,
            "text_nl": self._ft_text_nl_field,
            "notes": self._ft_notes_field,
        }
        target_field = field_map.get(field_name)
        if target_field:
            target_field.border_color = ft.Colors.RED_700
            target_field.focus()

    # =========================================================================
    # EVENT HANDLERS (Callbacks de UI)
    # =========================================================================
    def _toggle_tag(self, tag_name: str) -> None:
        """Alterna seleccion de tag (estado local)."""
        if tag_name in self._selected_tags:
            self._selected_tags.remove(tag_name)
        else:
            self._selected_tags.append(tag_name)
        self._render_tags()
        self.update()

    def _toggle_group(self, group_id: int, is_checked: bool) -> None:
        """Alterna selección de grupo (estado local)."""
        if is_checked and group_id not in self._selected_group_ids:
            self._selected_group_ids.append(group_id)
        elif not is_checked and group_id in self._selected_group_ids:
            self._selected_group_ids.remove(group_id)
        self.update()

    def _on_save_btn_click(self) -> None:
        """Maneja click en guardar cambios y notifica al controller."""
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
            "selected_group_ids": list(self._selected_group_ids),
        }
