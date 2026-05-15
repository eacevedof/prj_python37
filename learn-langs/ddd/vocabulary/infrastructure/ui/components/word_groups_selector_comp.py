"""Componente selector multiple de grupos de palabras."""

from typing import Optional, Callable, List, Dict

import flet as ft


class WordGroupsSelectorComp(ft.Container):
    """Selector multiple de grupos de palabras con checkboxes."""

    def __init__(
        self,
        groups: List[Dict],  # [{"id": 1, "title": "generic", "description": "..."}]
        selected_group_ids: Optional[List[int]] = None,
        on_change: Optional[Callable] = None,
    ):
        super().__init__()
        self.groups = groups
        self.selected_group_ids = selected_group_ids or []
        self.on_change_callback = on_change
        self._checkboxes: Dict[int, ft.Checkbox] = {}

        # Construir UI
        self._build()

    def _build(self) -> None:
        """Construye la UI del selector."""
        checkboxes = []

        for group in self.groups:
            group_id = group["id"]
            is_checked = group_id in self.selected_group_ids

            checkbox = ft.Checkbox(
                label=group["title"],
                value=is_checked,
                on_change=lambda e, gid=group_id: self._on_checkbox_change(gid, e.control.value),
            )

            self._checkboxes[group_id] = checkbox
            checkboxes.append(checkbox)

        self.content = ft.Column(
            controls=checkboxes,
            spacing=8,
            scroll=ft.ScrollMode.AUTO,
        )
        self.height = min(200, len(checkboxes) * 40 + 20)
        self.padding = 10
        self.border = ft.border.all(1, ft.Colors.GREY_400)
        self.border_radius = 8

    def _on_checkbox_change(self, group_id: int, is_checked: bool) -> None:
        """Handler cuando cambia el estado de un checkbox."""
        if is_checked and group_id not in self.selected_group_ids:
            self.selected_group_ids.append(group_id)
        elif not is_checked and group_id in self.selected_group_ids:
            self.selected_group_ids.remove(group_id)

        # Llamar callback si existe
        if self.on_change_callback:
            self.on_change_callback(self.selected_group_ids)

    def get_selected_ids(self) -> List[int]:
        """Retorna lista de IDs de grupos seleccionados."""
        return self.selected_group_ids.copy()

    def set_selected_ids(self, group_ids: List[int]) -> None:
        """Establece los grupos seleccionados."""
        self.selected_group_ids = group_ids.copy()

        # Actualizar checkboxes
        for group_id, checkbox in self._checkboxes.items():
            checkbox.value = group_id in self.selected_group_ids

        if self.page:
            self.update()

    def refresh_groups(self, groups: List[Dict], selected_group_ids: Optional[List[int]] = None) -> None:
        """Refresca la lista de grupos."""
        self.groups = groups
        if selected_group_ids is not None:
            self.selected_group_ids = selected_group_ids
        self._checkboxes.clear()
        self._build()

        if self.page:
            self.update()
