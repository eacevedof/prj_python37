"""Vista para listar palabras - Solo renderizado."""

import flet as ft
from typing import Callable, Any, Self, TYPE_CHECKING

if TYPE_CHECKING:
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

    def __init__(
        self,
        on_back: Callable[[], None],
        on_create: Callable[[], None],
        on_edit: Callable[[int], None],
        on_delete: Callable[[int], None],
        on_search: Callable[[str], None],
        on_show_images: Callable[[int], None],
        on_mount: Callable[[], None] | None = None,
    ):
        super().__init__()

        self._route_on_back = on_back
        self._route_on_create = on_create
        self._route_on_edit = on_edit
        self._route_on_delete = on_delete
        self._route_on_search = on_search
        self._route_on_show_images = on_show_images
        self._route_on_mount = on_mount

        # UI components
        self._ft_words_list: ft.ListView | None = None
        self._ft_search_field: ft.TextField | None = None
        self._ft_loading: ft.ProgressRing | None = None
        self._ft_count_text: ft.Text | None = None
        self._ft_error_text: ft.Text | None = None

        self._build_ui()

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            on_back=primitives.get("on_back", lambda: None),
            on_create=primitives.get("on_create", lambda: None),
            on_edit=primitives.get("on_edit", lambda x: None),
            on_delete=primitives.get("on_delete", lambda x: None),
            on_search=primitives.get("on_search", lambda x: None),
            on_show_images=primitives.get("on_show_images", lambda x: None),
            on_mount=primitives.get("on_mount"),
        )

    def did_mount(self) -> None:
        """Flet llama esto al montar. Notifica al Controller."""
        if self._route_on_mount:
            self._route_on_mount()

    def _build_ui(self) -> None:
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
                    border=ft.border.all(1, ft.Colors.GREY_300),
                    border_radius=8,
                ),
            ],
            expand=True,
        )
        self.expand = True
        self.padding = 20

    def render(self, dto: "ListWordsViewDto") -> None:
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

    def _render_count(self, dto: "ListWordsViewDto") -> None:
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

    def _render_words_list(self, list_words_view_dto: "ListWordsViewDto") -> None:
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

    def _build_word_tile(self, word: "WordListItemViewDto") -> ft.ListTile:
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
                    # Imagenes
                    ft.IconButton(
                        icon=ft.Icons.IMAGE,
                        icon_color=ft.Colors.GREEN_600 if word.image_count > 0 else ft.Colors.GREY_400,
                        on_click=lambda e, w=word: self._route_on_show_images(w.id),
                        tooltip=f"Imagenes{image_badge}",
                    ),
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

    def show_snackbar(self, message: str, error: bool = False) -> None:
        """Muestra un snackbar."""
        self.page.snack_bar = ft.SnackBar(
            content=ft.Text(message),
            bgcolor=ft.Colors.RED_700 if error else ft.Colors.GREEN_700,
        )
        self.page.snack_bar.open = True
        self.page.update()
