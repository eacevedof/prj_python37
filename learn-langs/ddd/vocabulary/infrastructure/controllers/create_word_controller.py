"""Controller para crear palabra."""

from typing import Callable, Any

import flet as ft

from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.controllers import BaseController
from ddd.vocabulary.application.create_word import CreateWordDto, CreateWordService
from ddd.vocabulary.application.get_tags import GetTagsService
from ddd.vocabulary.application.get_word_groups import GetWordGroupsService
from ddd.vocabulary.application.create_word_group import (
    CreateWordGroupDto,
    CreateWordGroupService,
)
from ddd.vocabulary.domain.enums import LanguageCodeEnum
from ddd.vocabulary.infrastructure.ui.views.create_word_view import CreateWordView
from ddd.vocabulary.infrastructure.ui.views.create_word_view_dto import CreateWordViewDto


class CreateWordController(BaseController):
    """
    Controller para crear palabra.

    Responsabilidades:
    - Orquestar flujo entre Vista y Servicios
    - Crear ViewDTOs y pasarlos a la Vista
    - Manejar callbacks de la Vista
    - NO hereda de ft.Container
    """

    # =========================================================================
    # CONSTRUCCIÓN
    # =========================================================================
    def __init__(
        self,
        route_on_success: Callable[[], None],    # 1. Callback éxito (cierra formulario)
        route_on_back: Callable[[], None],       # 2. Callback cancelar (vuelve atrás)
    ):
        # Callbacks de navegación (inyectados desde app_router)
        self._route_on_success = route_on_success
        self._route_on_back = route_on_back

        self._logger = Logger.get_instance()
        self._create_word_service = CreateWordService.get_instance()
        self._get_tags_service = GetTagsService.get_instance()
        self._get_word_groups_service = GetWordGroupsService.get_instance()
        self._create_word_group_service = CreateWordGroupService.get_instance()

        # Cache de tags y grupos
        self._available_tags: list[dict[str, Any]] = []
        self._available_groups: list[dict[str, Any]] = []

        self._ft_container = CreateWordView.from_primitives({
            "on_mount": self._on_mount,
            "on_submit": self._on_save_btn_click,
            "on_back": self._route_on_back,
            "on_create_group": self._on_create_group,
        })

    # =========================================================================
    # API PÚBLICA
    # =========================================================================
    # app_router.invoked
    @property
    def ft_container(self) -> ft.Container:
        """Vista para montar en el arbol de Flet."""
        return self._ft_container

    # =========================================================================
    # LIFECYCLE & CARGA DE DATOS
    # =========================================================================
    def _on_mount(self) -> None:
        """Callback cuando la vista se monta. Carga datos iniciales."""
        self._ft_container.page.run_task(self._async_load_initial_data)

    async def _async_load_initial_data(self) -> None:
        """Carga tags, grupos y renderiza formulario vacio."""
        try:
            # Cargar tags via servicio
            tags_result = await self._get_tags_service()
            if tags_result.success:
                self._available_tags = tags_result.to_list_of_dicts()
            else:
                self._available_tags = []

            # Cargar grupos via servicio
            groups_result = await self._get_word_groups_service()
            if groups_result.success:
                self._available_groups = [
                    {"id": g.id, "title": g.title, "description": g.description}
                    for g in groups_result.groups
                ]
            else:
                self._available_groups = []

            # Encontrar ID del grupo "generic" para pre-seleccionarlo
            generic_group_ids = [
                g["id"] for g in self._available_groups if g["title"] == "generic"
            ]

            self._ft_container.render(
                CreateWordViewDto.empty(
                    available_tags=self._available_tags,
                    available_groups=self._available_groups,
                    selected_group_ids=generic_group_ids,
                )
            )

        except Exception as e:
            self._logger.log_error(
                "CreateWordController",
                f"Error cargando datos iniciales: {e}",
            )
            # Encontrar ID del grupo "generic" para pre-seleccionarlo
            generic_group_ids = [
                g["id"] for g in self._available_groups if g["title"] == "generic"
            ]
            self._ft_container.render(
                CreateWordViewDto.empty(
                    available_tags=[],
                    available_groups=self._available_groups,
                    selected_group_ids=generic_group_ids,
                )
            )

    # =========================================================================
    # EVENT HANDLERS (orden visual/lógico de arriba a abajo en UI)
    # =========================================================================
    def _on_save_btn_click(self, form_data: dict[str, Any]) -> None:
        """Maneja click en guardar (botón verde - abajo en UI)."""
        async def _task():
            await self._async_on_submit(form_data)
        self._ft_container.page.run_task(_task)

    def _on_create_group(self, title: str, description: str) -> None:
        """Maneja creación de nuevo grupo."""
        async def _task():
            await self._async_create_group(title, description)
        self._ft_container.page.run_task(_task)

    async def _async_create_group(self, title: str, description: str) -> None:
        """Crea un nuevo grupo y recarga la lista."""
        try:
            result = await self._create_word_group_service(
                CreateWordGroupDto.from_primitives({
                    "title": title,
                    "description": description,
                })
            )

            if result.success:
                # Recargar lista de grupos
                groups_result = await self._get_word_groups_service()
                if groups_result.success:
                    self._available_groups = [
                        {"id": g.id, "title": g.title, "description": g.description}
                        for g in groups_result.groups
                    ]

                    # Seleccionar el nuevo grupo creado
                    new_group_id = result.group_id
                    current_selected = self._ft_container._selected_group_ids.copy()
                    if new_group_id and new_group_id not in current_selected:
                        current_selected.append(new_group_id)

                    # Re-renderizar con el nuevo grupo seleccionado
                    self._ft_container.render(
                        CreateWordViewDto.from_primitives({
                            "form_values": self._ft_container._get_form_data(),
                            "available_tags": self._available_tags,
                            "available_groups": self._available_groups,
                            "selected_group_ids": current_selected,
                            "success_message": f"Grupo '{title}' creado correctamente",
                        })
                    )
            else:
                # Mostrar error
                self._ft_container.render(
                    CreateWordViewDto.from_primitives({
                        "form_values": self._ft_container._get_form_data(),
                        "available_tags": self._available_tags,
                        "available_groups": self._available_groups,
                        "selected_group_ids": self._ft_container._selected_group_ids,
                        "error_message": result.error_message,
                    })
                )

        except Exception as e:
            self._logger.log_error(
                "CreateWordController",
                f"Error creando grupo: {e}",
            )
            self._ft_container.render(
                CreateWordViewDto.from_primitives({
                    "form_values": self._ft_container._get_form_data(),
                    "available_tags": self._available_tags,
                    "available_groups": self._available_groups,
                    "selected_group_ids": self._ft_container._selected_group_ids,
                    "error_message": str(e),
                })
            )

    async def _async_on_submit(self, form_data: dict[str, Any]) -> None:
        """Procesa el submit del formulario."""
        # Validacion basica
        text_es = (form_data.get("text_es") or "").strip()
        if not text_es:
            self._ft_container.render(
                CreateWordViewDto.error(
                    message="La palabra en espanol es obligatoria",
                    form_values=form_data,
                    available_tags=self._available_tags,
                    available_groups=self._available_groups,
                    error_field="text_es",
                )
            )
            return

        # Preparar traducciones
        translations = {}
        text_lang = (form_data.get("text_lang") or "").strip()
        if text_lang:
            translations[LanguageCodeEnum.NL_NL.value] = text_lang

        try:
            create_word_result_dto = await self._create_word_service(
                CreateWordDto.from_primitives({
                    "text": text_es,
                    "word_type": form_data.get("word_type", "WORD"),
                    "tags": form_data.get("selected_tags", []),
                    "group_ids": form_data.get("selected_group_ids", []),
                    "translations": translations,
                    "notes": (form_data.get("notes") or "").strip(),
                })
            )

            # Encontrar ID del grupo "generic" para pre-seleccionarlo tras éxito
            generic_group_ids = [
                g["id"] for g in self._available_groups if g["title"] == "generic"
            ]

            self._ft_container.render(
                CreateWordViewDto.success(
                    message=f"Palabra '{create_word_result_dto.text}' creada correctamente",
                    available_tags=self._available_tags,
                    available_groups=self._available_groups,
                    selected_group_ids=generic_group_ids,
                )
            )

            # Notificar éxito después de un delay
            # (permite ver el mensaje de éxito antes de cerrar)
            # self._route_on_success()

        except Exception as e:
            self._logger.log_error(
                "CreateWordController",
                f"Error creando palabra: {e}",
                {"form_data": form_data},
            )
            self._ft_container.render(
                CreateWordViewDto.error(
                    message=str(e),
                    form_values=form_data,
                    available_tags=self._available_tags,
                    available_groups=self._available_groups,
                )
            )
