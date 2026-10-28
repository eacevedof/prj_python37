"""Controller para gestión de grupos de palabras."""

from typing import Callable

import flet as ft

from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.controllers import BaseController
from ddd.vocabulary.application.get_word_groups import GetWordGroupsService
from ddd.vocabulary.application.create_word_group import (
    CreateWordGroupDto,
    CreateWordGroupService,
)
from ddd.vocabulary.application.update_word_group import (
    UpdateWordGroupDto,
    UpdateWordGroupService,
)
from ddd.vocabulary.application.delete_word_group import (
    DeleteWordGroupDto,
    DeleteWordGroupService,
)
from ddd.vocabulary.infrastructure.ui.views.manage_word_groups_view import ManageWordGroupsView
from ddd.vocabulary.infrastructure.ui.views.manage_word_groups_view_dto import ManageWordGroupsViewDto


class ManageWordGroupsController(BaseController):
    """
    Controller para gestión de grupos de palabras.

    Responsabilidades:
    - Orquestar flujo entre Vista y Servicios
    - Manejar CRUD de grupos
    - NO hereda de ft.Container
    """

    def __init__(self, route_on_back: Callable[[], None]):
        self._route_on_back = route_on_back

        self._logger = Logger.get_instance()
        self._get_word_groups_service = GetWordGroupsService.get_instance()
        self._create_word_group_service = CreateWordGroupService.get_instance()
        self._update_word_group_service = UpdateWordGroupService.get_instance()
        self._delete_word_group_service = DeleteWordGroupService.get_instance()

        self._ft_container = ManageWordGroupsView.from_primitives({
            "on_mount": self._on_mount,
            "on_back": self._route_on_back,
            "on_create": self._on_create_group,
            "on_edit": self._on_edit_group,
            "on_delete": self._on_delete_group,
        })

    @property
    def ft_container(self) -> ft.Container:
        """Vista para montar en el árbol de Flet."""
        return self._ft_container

    def _on_mount(self) -> None:
        """Callback cuando la vista se monta."""
        self._ft_container.page.run_task(self._async_load_groups)

    async def _async_load_groups(self) -> None:
        """Carga los grupos de palabras."""
        try:
            self._ft_container.render(ManageWordGroupsViewDto.loading())

            result = await self._get_word_groups_service()

            if result.success:
                self._ft_container.render(
                    ManageWordGroupsViewDto.success(list(result.groups))
                )
            else:
                self._ft_container.render(
                    ManageWordGroupsViewDto.error(
                        result.error_message or "Error cargando grupos"
                    )
                )

        except Exception as e:
            self._logger.log_error(
                "ManageWordGroupsController",
                f"Error cargando grupos: {e}",
            )
            self._ft_container.render(
                ManageWordGroupsViewDto.error(str(e))
            )

    def _on_create_group(self, title: str, description: str, source: str) -> None:
        """Maneja la creación de un grupo."""
        async def _task():
            await self._async_create_group(title, description, source)
        self._ft_container.page.run_task(_task)

    async def _async_create_group(self, title: str, description: str, source: str) -> None:
        """Crea un nuevo grupo."""
        try:
            result = await self._create_word_group_service(
                CreateWordGroupDto.from_primitives({
                    "title": title,
                    "description": description,
                    "source": source,
                })
            )

            if result.success:
                # Recargar grupos
                await self._async_load_groups()
                self._ft_container.show_snackbar(
                    f"Grupo '{title}' creado correctamente"
                )
            else:
                self._ft_container.show_snackbar(
                    result.error_message or "Error creando grupo",
                    error=True,
                )

        except Exception as e:
            self._logger.log_error(
                "ManageWordGroupsController",
                f"Error creando grupo: {e}",
            )
            self._ft_container.show_snackbar(str(e), error=True)

    def _on_edit_group(self, group_id: int, title: str, description: str, source: str) -> None:
        """Maneja la edición de un grupo."""
        async def _task():
            await self._async_edit_group(group_id, title, description, source)
        self._ft_container.page.run_task(_task)

    async def _async_edit_group(self, group_id: int, title: str, description: str, source: str) -> None:
        """Actualiza un grupo existente."""
        try:
            result = await self._update_word_group_service(
                UpdateWordGroupDto.from_primitives({
                    "group_id": group_id,
                    "title": title,
                    "description": description,
                    "source": source,
                })
            )

            if result.success:
                # Recargar grupos
                await self._async_load_groups()
                self._ft_container.show_snackbar(
                    f"Grupo '{title}' actualizado correctamente"
                )
            else:
                self._ft_container.show_snackbar(
                    result.error_message or "Error actualizando grupo",
                    error=True,
                )

        except Exception as e:
            self._logger.log_error(
                "ManageWordGroupsController",
                f"Error actualizando grupo: {e}",
            )
            self._ft_container.show_snackbar(str(e), error=True)

    def _on_delete_group(self, group_id: int) -> None:
        """Maneja la eliminación de un grupo."""
        async def _task():
            await self._async_delete_group(group_id)
        self._ft_container.page.run_task(_task)

    async def _async_delete_group(self, group_id: int) -> None:
        """Elimina un grupo."""
        try:
            result = await self._delete_word_group_service(
                DeleteWordGroupDto.from_primitives({"group_id": group_id})
            )

            if result.success:
                # Recargar grupos
                await self._async_load_groups()
                self._ft_container.show_snackbar(
                    f"Grupo '{result.title}' eliminado correctamente"
                )
            else:
                self._ft_container.show_snackbar(
                    result.error_message or "Error eliminando grupo",
                    error=True,
                )

        except Exception as e:
            self._logger.log_error(
                "ManageWordGroupsController",
                f"Error eliminando grupo: {e}",
            )
            self._ft_container.show_snackbar(str(e), error=True)
