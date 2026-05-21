"""Vista para gestión de grupos de palabras."""

import flet as ft
from typing import Callable, Any, Self

from ddd.vocabulary.infrastructure.ui.views.manage_word_groups_view_dto import ManageWordGroupsViewDto


class ManageWordGroupsView(ft.Container):
    """Vista para gestionar grupos de palabras con CRUD."""

    def __init__(
        self,
        route_on_mount: Callable[[], None] | None,
        route_on_back: Callable[[], None],
        route_on_create: Callable[[str, str, str], None],
        route_on_edit: Callable[[int, str, str, str], None],
        route_on_delete: Callable[[int], None],
    ):
        super().__init__()

        self._route_on_mount = route_on_mount
        self._route_on_back = route_on_back
        self._route_on_create = route_on_create
        self._route_on_edit = route_on_edit
        self._route_on_delete = route_on_delete

        self._ft_groups_table: ft.DataTable | None = None
        self._ft_loading_indicator: ft.ProgressRing | None = None
        self._ft_message_text: ft.Text | None = None

        self._build_initial_ui()

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            route_on_mount=primitives.get("on_mount"),
            route_on_back=primitives.get("on_back", lambda: None),
            route_on_create=primitives.get("on_create", lambda t, d, s: None),
            route_on_edit=primitives.get("on_edit", lambda id, t, d, s: None),
            route_on_delete=primitives.get("on_delete", lambda id: None),
        )

    def render(self, dto: ManageWordGroupsViewDto) -> None:
        """Renderiza la vista con los datos del DTO."""
        if self._ft_loading_indicator:
            self._ft_loading_indicator.visible = dto.is_loading

        if self._ft_message_text:
            if dto.error_message:
                self._ft_message_text.value = dto.error_message
                self._ft_message_text.color = ft.Colors.RED
                self._ft_message_text.visible = True
            elif dto.success_message:
                self._ft_message_text.value = dto.success_message
                self._ft_message_text.color = ft.Colors.GREEN
                self._ft_message_text.visible = True
            else:
                self._ft_message_text.visible = False

        self._render_groups_table(dto)
        self.update()

    def did_mount(self) -> None:
        if self._route_on_mount:
            self._route_on_mount()

    def _build_initial_ui(self) -> None:
        self._ft_loading_indicator = ft.ProgressRing(visible=True)
        self._ft_message_text = ft.Text(visible=False, size=14)

        self._ft_groups_table = ft.DataTable(
            columns=[
                ft.DataColumn(ft.Text("ID", weight=ft.FontWeight.BOLD)),
                ft.DataColumn(ft.Text("Título", weight=ft.FontWeight.BOLD)),
                ft.DataColumn(ft.Text("Descripción", weight=ft.FontWeight.BOLD)),
                ft.DataColumn(ft.Text("Fuente", weight=ft.FontWeight.BOLD)),
                ft.DataColumn(ft.Text("Palabras", weight=ft.FontWeight.BOLD)),
                ft.DataColumn(ft.Text("Acciones", weight=ft.FontWeight.BOLD)),
            ],
            rows=[],
        )

        # Formulario de creación
        self._ft_new_title = ft.TextField(label="Título del nuevo grupo", width=300)
        self._ft_new_description = ft.TextField(label="Descripción", width=400, multiline=True, max_lines=3)
        self._ft_new_source = ft.TextField(label="Fuente (URL o archivo)", width=400, hint_text="Ej: https://..., video.mp4, articulo.pdf")

        create_btn = ft.ElevatedButton(
            "Crear Grupo",
            icon=ft.Icons.ADD,
            on_click=self._on_create_click,
            bgcolor=ft.Colors.GREEN_700,
            color=ft.Colors.WHITE,
        )

        back_btn = ft.ElevatedButton(
            "Volver al Home",
            icon=ft.Icons.ARROW_BACK,
            on_click=lambda _: self._route_on_back(),
        )

        self.content = ft.Column(
            controls=[
                ft.Container(height=20),
                ft.Row(
                    controls=[
                        back_btn,
                        ft.Text("Gestión de Grupos de Palabras", size=28, weight=ft.FontWeight.BOLD),
                    ],
                    alignment=ft.MainAxisAlignment.SPACE_BETWEEN,
                ),
                ft.Container(height=20),
                self._ft_message_text,
                self._ft_loading_indicator,
                ft.Container(height=10),
                ft.Card(
                    content=ft.Container(
                        content=ft.Column([
                            ft.Text("Crear Nuevo Grupo", size=18, weight=ft.FontWeight.BOLD),
                            self._ft_new_title,
                            self._ft_new_description,
                            self._ft_new_source,
                            create_btn,
                        ]),
                        padding=20,
                    ),
                ),
                ft.Container(height=20),
                ft.Text("Grupos Existentes:", size=18, weight=ft.FontWeight.BOLD),
                ft.Container(
                    content=ft.Row(
                        controls=[self._ft_groups_table],
                        scroll=ft.ScrollMode.AUTO,
                    ),
                    border=ft.border.all(1, ft.Colors.GREY_400),
                    border_radius=8,
                    padding=10,
                ),
            ],
            horizontal_alignment=ft.CrossAxisAlignment.START,
            scroll=ft.ScrollMode.AUTO,
            expand=True,
        )
        self.expand = True
        self.padding = ft.padding.only(left=20, right=20, top=20, bottom=20)

    def _render_groups_table(self, dto: ManageWordGroupsViewDto) -> None:
        if not self._ft_groups_table:
            return

        rows = []
        for group in dto.groups:
            group_id = group.get("id", 0)
            title = group.get("title", "")
            description = group.get("description", "")
            source = group.get("source", "")
            word_count = group.get("word_count", 0)

            is_generic = title.lower() == "generic"

            # Crear campos editables solo si no es generic
            if is_generic:
                title_cell = ft.DataCell(ft.Text(title, weight=ft.FontWeight.BOLD))
                desc_cell = ft.DataCell(ft.Text(description))
                source_cell = ft.DataCell(ft.Text(source or "--"))
                actions_cell = ft.DataCell(ft.Text("--", color=ft.Colors.GREY))
            else:
                title_field = ft.TextField(value=title, width=220, dense=True)
                desc_field = ft.TextField(value=description, width=180, dense=True, multiline=True)
                source_field = ft.TextField(value=source, width=250, dense=True)
                title_cell = ft.DataCell(title_field)
                desc_cell = ft.DataCell(desc_field)
                source_cell = ft.DataCell(source_field)
                actions_cell = ft.DataCell(
                    ft.Row([
                        ft.IconButton(
                            icon=ft.Icons.SAVE,
                            tooltip="Guardar cambios",
                            on_click=lambda _, gid=group_id, tf=title_field, df=desc_field, sf=source_field: self._on_edit_click(gid, tf, df, sf),
                            icon_color=ft.Colors.BLUE,
                        ),
                        ft.IconButton(
                            icon=ft.Icons.DELETE,
                            tooltip="Eliminar grupo",
                            on_click=lambda _, gid=group_id: self._on_delete_click(gid, title),
                            icon_color=ft.Colors.RED,
                        ),
                    ], spacing=5)
                )

            rows.append(
                ft.DataRow(
                    cells=[
                        ft.DataCell(ft.Text(str(group_id))),
                        title_cell,
                        desc_cell,
                        source_cell,
                        ft.DataCell(
                            ft.Text(
                                str(word_count),
                                size=16,
                                weight=ft.FontWeight.BOLD,
                                color=ft.Colors.BLUE_700,
                            )
                        ),
                        actions_cell,
                    ]
                )
            )

        self._ft_groups_table.rows = rows

    def _on_create_click(self, _) -> None:
        if self._ft_new_title and self._ft_new_description and self._ft_new_source:
            title = self._ft_new_title.value or ""
            description = self._ft_new_description.value or ""
            source = self._ft_new_source.value or ""

            if title.strip():
                self._route_on_create(title.strip(), description.strip(), source.strip())
                self._ft_new_title.value = ""
                self._ft_new_description.value = ""
                self._ft_new_source.value = ""

    def _on_edit_click(self, group_id: int, title_field: ft.TextField, desc_field: ft.TextField, source_field: ft.TextField) -> None:
        title = title_field.value or ""
        description = desc_field.value or ""
        source = source_field.value or ""
        if title.strip():
            self._route_on_edit(group_id, title.strip(), description.strip(), source.strip())

    def _on_delete_click(self, group_id: int, title: str) -> None:
        # Confirmar eliminación
        if title.lower() != "generic":
            self._route_on_delete(group_id)

    def show_snackbar(self, message: str, error: bool = False) -> None:
        """Muestra un snackbar con un mensaje."""
        if self.page:
            self.page.snack_bar = ft.SnackBar(
                content=ft.Text(message),
                bgcolor=ft.Colors.RED if error else ft.Colors.GREEN,
            )
            self.page.snack_bar.open = True
            self.page.update()
