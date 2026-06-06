"""Vista para listar palabras - Solo renderizado."""

import os
from pathlib import Path
import flet as ft
from typing import Callable, Any, Self

from ddd.vocabulary.domain.enums import WordTypeEnum
from ddd.vocabulary.infrastructure.ui.views.list_words_view_dto import (
    ListWordsViewDto,
    WordListItemViewDto,
)


class ListWordsView(ft.Container):
    """
    Vista para listar palabras.

    Responsabilidades:
    - Renderizar UI basada en ListWordsViewDto
    - Emitir eventos al Controller via callbacks
    - NO tiene logica de negocio
    - NO importa repositorios ni servicios
    """

    # =========================================================================
    # CONSTRUCCIÓN (Public API)
    # =========================================================================
    def __init__(
        self,
        route_on_mount: Callable[[], None] | None,     # 1. Lifecycle (se ejecuta primero)
        route_on_back: Callable[[], None],             # 2. Botón back (header izquierda)
        route_on_create: Callable[[], None],           # 3. Botón crear (header derecha)
        route_on_search: Callable[[str], None],        # 4. Campo búsqueda (header)
        route_on_edit: Callable[[int], None],          # 5. Botón editar (item lista)
        route_on_delete: Callable[[int], None],        # 6. Botón eliminar (item lista)
        route_on_show_images: Callable[[int], None],   # 7. Botón imagenes (item lista)
    ):
        super().__init__()

        # Callbacks al controller (en orden de ejecución)
        self._route_on_mount = route_on_mount
        self._route_on_back = route_on_back
        self._route_on_create = route_on_create
        self._route_on_search = route_on_search
        self._route_on_edit = route_on_edit
        self._route_on_delete = route_on_delete
        self._route_on_show_images = route_on_show_images

        # Componentes UI
        self._ft_words_list: ft.ListView | None = None
        self._ft_search_field: ft.TextField | None = None
        self._ft_loading: ft.ProgressRing | None = None
        self._ft_count_text: ft.Text | None = None
        self._ft_error_text: ft.Text | None = None

        self._build_initial_ui()

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        """Crea la vista desde un diccionario de callbacks."""
        return cls(
            route_on_mount=primitives.get("on_mount"),
            route_on_back=primitives.get("on_back", lambda: None),
            route_on_create=primitives.get("on_create", lambda: None),
            route_on_search=primitives.get("on_search", lambda x: None),
            route_on_edit=primitives.get("on_edit", lambda x: None),
            route_on_delete=primitives.get("on_delete", lambda x: None),
            route_on_show_images=primitives.get("on_show_images", lambda x: None),
        )

    # =========================================================================
    # API PÚBLICA - RENDERIZADO
    # =========================================================================
    def render(self, dto: ListWordsViewDto) -> None:
        """Renderiza la vista con los datos del DTO."""
        # Loading
        if self._ft_loading:
            self._ft_loading.visible = dto.is_loading

        # Error
        if self._ft_error_text:
            if dto.error_message:
                self._ft_error_text.value = dto.error_message
                self._ft_error_text.visible = True
            else:
                self._ft_error_text.visible = False

        # Count
        self._render_count(dto)

        # Words list
        self._render_words_list(dto)

        self.update()

    def show_snackbar(self, message: str, error: bool = False) -> None:
        """Muestra un snackbar o dialog de error."""
        if error:
            # Para errores, mostrar dialog seleccionable
            def close_dialog(e):
                dialog.open = False
                self.page.update()

            def copy_error(e):
                self.page.set_clipboard(message)
                self.page.show_snack_bar(
                    ft.SnackBar(content=ft.Text("Error copiado al portapapeles"), duration=1500)
                )

            dialog = ft.AlertDialog(
                modal=True,
                title=ft.Text("Error", color=ft.Colors.RED_700),
                content=ft.Container(
                    content=ft.Text(
                        message,
                        selectable=True,
                        size=14,
                    ),
                    width=500,
                ),
                actions=[
                    ft.TextButton("Copiar", on_click=copy_error),
                    ft.TextButton("Cerrar", on_click=close_dialog),
                ],
                actions_alignment=ft.MainAxisAlignment.END,
            )
            self.page.overlay.append(dialog)
            dialog.open = True
            self.page.update()
        else:
            # Para mensajes normales, usar snackbar
            snackbar = ft.SnackBar(
                content=ft.Text(message),
                bgcolor=ft.Colors.GREEN_700,
                open=True,
            )
            self.page.overlay.append(snackbar)
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
        # Search field
        self._ft_search_field = ft.TextField(
            hint_text="Buscar palabras...",
            prefix_icon=ft.Icons.SEARCH,
            width=300,
            on_change=lambda e: self._route_on_search(e.control.value or ""),
        )

        # Loading indicator
        self._ft_loading = ft.ProgressRing(width=20, height=20, visible=False)

        # Count text
        self._ft_count_text = ft.Text("", size=12, color=ft.Colors.GREY_600)

        # Error text
        self._ft_error_text = ft.Text("", color=ft.Colors.RED_700, visible=False)

        # Words list
        self._ft_words_list = ft.ListView(
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
            on_click=lambda _: self._route_on_create(),
            style=ft.ButtonStyle(
                bgcolor=ft.Colors.GREEN_600,
                color=ft.Colors.WHITE,
            ),
        )

        back_btn = ft.IconButton(
            icon=ft.Icons.ARROW_BACK,
            on_click=lambda _: self._route_on_back(),
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
                        self._ft_search_field,
                        self._ft_loading,
                    ],
                ),
                ft.Row(
                    controls=[
                        self._ft_error_text,
                        ft.Container(expand=True),
                        self._ft_count_text,
                    ],
                ),
                ft.Divider(height=1),
                # List
                ft.Container(
                    content=self._ft_words_list,
                    expand=True,
                    border=ft.Border.all(1, ft.Colors.GREY_300),
                    border_radius=8,
                ),
            ],
            expand=True,
        )
        self.expand = True
        self.padding = 20

    # =========================================================================
    # RENDERIZADO PARCIAL (en orden de ejecución en render())
    # =========================================================================
    def _render_count(self, dto: ListWordsViewDto) -> None:
        """Renderiza el contador de palabras."""
        if not self._ft_count_text:
            return

        if dto.is_loading:
            self._ft_count_text.value = "Cargando..."
        elif dto.error_message:
            self._ft_count_text.value = ""
        else:
            showing = len(dto.words)
            self._ft_count_text.value = f"Mostrando {showing} de {dto.total_count} palabras"

    def _render_words_list(self, list_words_view_dto: ListWordsViewDto) -> None:
        """Renderiza la lista de palabras."""
        if not self._ft_words_list:
            return

        self._ft_words_list.controls.clear()

        if list_words_view_dto.is_loading:
            self._ft_words_list.controls.append(
                ft.Container(
                    content=ft.ProgressRing(),
                    padding=20,
                    alignment=ft.alignment.Alignment.CENTER,
                )
            )
            return

        if list_words_view_dto.is_empty and not list_words_view_dto.error_message:
            self._ft_words_list.controls.append(
                ft.Container(
                    content=ft.Text(
                        "No hay palabras. Anade la primera!",
                        color=ft.Colors.GREY_500,
                        italic=True,
                    ),
                    padding=20,
                    alignment=ft.alignment.Alignment.CENTER,
                )
            )
            return

        for word in list_words_view_dto.words:
            tile = self._build_word_tile(word)
            self._ft_words_list.controls.append(tile)

    # =========================================================================
    # EVENT HANDLERS (Callbacks de UI)
    # =========================================================================
    # Los eventos están mapeados directamente en _build_initial_ui y _build_word_tile
    # No hay métodos intermedios necesarios en esta vista

    # =========================================================================
    # HELPERS (Construcción de componentes individuales)
    # =========================================================================
    def _get_full_image_path(self, relative_path: str) -> str:
        """Construye la ruta completa de la imagen desde la ruta relativa."""
        if not relative_path:
            return ""

        # Si ya es una ruta absoluta, devolverla tal cual
        if os.path.isabs(relative_path):
            return relative_path

        # Construir ruta absoluta desde data/images
        base_path = Path(__file__).parent.parent.parent.parent.parent.parent / "data" / "images"
        full_path = base_path / relative_path
        return str(full_path)

    def _build_image_button(self, word: WordListItemViewDto) -> ft.Control:
        """Construye el botón de imagen con thumbnail o icono."""
        image_badge = f" ({word.image_count})" if word.image_count > 0 else ""
        tooltip_text = f"Imagenes{image_badge}"

        # Si tiene imagen, mostrar thumbnail
        if word.last_image_path:
            full_path = self._get_full_image_path(word.last_image_path)
            if os.path.exists(full_path):
                return ft.Container(
                    content=ft.Image(
                        src=full_path,
                        width=40,
                        height=40,
                        fit=ft.BoxFit.COVER,
                        border_radius=4,
                    ),
                    width=48,
                    height=48,
                    border=ft.Border.all(2, ft.Colors.GREEN_600),
                    border_radius=6,
                    on_click=lambda e, w=word: self._route_on_show_images(w.id),
                    tooltip=tooltip_text,
                    ink=True,
                )

        # Si no tiene imagen, mostrar icono
        return ft.IconButton(
            icon=ft.Icons.IMAGE,
            icon_color=ft.Colors.GREY_400,
            on_click=lambda e, w=word: self._route_on_show_images(w.id),
            tooltip=tooltip_text,
        )

    def _build_word_tile(self, word: WordListItemViewDto) -> ft.ListTile:
        """Construye un tile para una palabra."""
        # Icono segun tipo
        icon = ft.Icons.ABC
        if word.word_type == WordTypeEnum.PHRASE.value:
            icon = ft.Icons.SHORT_TEXT
        elif word.word_type == WordTypeEnum.SENTENCE.value:
            icon = ft.Icons.NOTES

        # Badge de imagenes
        image_badge = f" ({word.image_count})" if word.image_count > 0 else ""

        # Subtitulo con traduccion y grupos
        subtitle_parts = [word.word_type, word.created_at]
        if word.translation_nl:
            subtitle_parts.append(f"NL: {word.translation_nl}")
        if word.groups:
            groups_str = ", ".join(word.groups)
            subtitle_parts.append(f"Grupos: {groups_str}")
        subtitle = " | ".join(subtitle_parts)

        return ft.ListTile(
            leading=ft.Row(
                controls=[
                    ft.Text(
                        f"#{word.id}",
                        size=11,
                        weight=ft.FontWeight.BOLD,
                        color=ft.Colors.GREY_600,
                        width=45,
                    ),
                    ft.Icon(icon, color=ft.Colors.BLUE_700, size=20),
                ],
                spacing=4,
                tight=True,
            ),
            title=ft.Text(word.text, weight=ft.FontWeight.W_500, expand=True),
            subtitle=ft.Text(subtitle, size=12),
            trailing=ft.Row(
                controls=[
                    # Editar
                    ft.IconButton(
                        icon=ft.Icons.EDIT_OUTLINED,
                        icon_color=ft.Colors.BLUE_600,
                        on_click=lambda e, w=word: self._route_on_edit(w.id),
                        tooltip="Editar",
                    ),
                    # Imagenes - Mostrar thumbnail o icono
                    self._build_image_button(word),
                    # Eliminar
                    ft.IconButton(
                        icon=ft.Icons.DELETE_OUTLINE,
                        icon_color=ft.Colors.RED_400,
                        on_click=lambda e, w=word: self._route_on_delete(w.id),
                        tooltip="Eliminar",
                    ),
                ],
                spacing=0,
                tight=True,
            ),
        )
