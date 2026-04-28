"""Controller para crear palabra."""

from typing import Callable, Any

import flet as ft

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.create_word import CreateWordDto, CreateWordService
from ddd.vocabulary.application.get_tags import GetTagsService
from ddd.vocabulary.domain.enums import LanguageCodeEnum
from ddd.vocabulary.infrastructure.ui.views.create_word_view import CreateWordView
from ddd.vocabulary.infrastructure.ui.views.create_word_view_dto import CreateWordViewDto


class CreateWordController:
    """
    Controller para crear palabra.

    Responsabilidades:
    - Orquestar flujo entre Vista y Servicios
    - Crear ViewDTOs y pasarlos a la Vista
    - Manejar callbacks de la Vista
    - NO hereda de ft.Container
    - NO usa repositorios directamente
    """

    def __init__(
        self,
        on_success: Callable[[], None],
        on_back: Callable[[], None],
    ):
        self._route_on_success = on_success
        self._route_on_back = on_back

        # Servicios
        self._logger = Logger.get_instance()
        self._create_word_service = CreateWordService.get_instance()
        self._get_tags_service = GetTagsService.get_instance()

        # Cache de tags
        self._available_tags: list[dict[str, Any]] = []

        # Vista
        self._ft_container = CreateWordView.from_primitives({
            "on_submit": self._on_submit,
            "on_back": self._route_on_back,
            "on_mount": self._on_mount,
        })

    @property
    def ft_container(self) -> ft.Container:
        """Vista para montar en el arbol de Flet."""
        return self._ft_container

    def _on_mount(self) -> None:
        """Callback cuando la vista se monta. Carga datos iniciales."""
        self._ft_container.page.run_task(self._async_load_initial_data)

    async def _async_load_initial_data(self) -> None:
        """Carga tags y renderiza formulario vacio."""
        try:
            # Cargar tags via servicio
            tags_result = await self._get_tags_service()

            if tags_result.success:
                self._available_tags = tags_result.to_list_of_dicts()
            else:
                self._available_tags = []

            self._ft_container.render(
                CreateWordViewDto.empty(available_tags=self._available_tags)
            )

        except Exception as e:
            self._logger.write_error(
                "CreateWordController",
                f"Error cargando datos iniciales: {e}",
            )
            self._ft_container.render(
                CreateWordViewDto.empty(available_tags=[])
            )

    def _on_submit(self, form_data: dict[str, Any]) -> None:
        """Callback cuando la vista hace submit."""
        self._ft_container.page.run_task(self._async_on_submit(form_data))

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
                    "translations": translations,
                    "notes": (form_data.get("notes") or "").strip(),
                })
            )

            self._ft_container.render(
                CreateWordViewDto.success(
                    message=f"Palabra '{create_word_result_dto.text}' creada correctamente",
                    available_tags=self._available_tags,
                )
            )

        except Exception as e:
            self._logger.write_error(
                "CreateWordController",
                f"Error creando palabra: {e}",
                {"form_data": form_data},
            )
            self._ft_container.render(
                CreateWordViewDto.error(
                    message=str(e),
                    form_values=form_data,
                    available_tags=self._available_tags,
                )
            )
