"""Controller para crear palabra."""

from typing import Callable, Any

import flet as ft

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.create_word import CreateWordDto, CreateWordService
from ddd.vocabulary.domain.enums import LanguageCodeEnum
from ddd.vocabulary.infrastructure.repositories import TagsReaderSqliteRepository
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
    """

    def __init__(
        self,
        on_success: Callable[[], None],
        on_back: Callable[[], None],
    ):
        self._on_success = on_success
        self._on_back = on_back

        # Servicios
        self._create_word_service = CreateWordService.get_instance()
        self._tags_reader = TagsReaderSqliteRepository.get_instance()
        self._logger = Logger.get_instance()

        # Cache de tags
        self._available_tags: list[dict[str, Any]] = []

        # Vista
        self._view = CreateWordView.from_primitives({
            "on_submit": self._handle_submit,
            "on_back": on_back,
            "on_mount": self._handle_mount,
        })

    @property
    def view(self) -> ft.Container:
        """Vista para montar en el árbol de Flet."""
        return self._view

    def _handle_mount(self) -> None:
        """Callback cuando la vista se monta. Carga datos iniciales."""
        self._view.page.run_task(self._async_load_initial_data)

    async def _async_load_initial_data(self) -> None:
        """Carga tags y renderiza formulario vacío."""
        # Cargar tags
        self._available_tags = await self._tags_reader.get_all()

        # Renderizar formulario vacío con tags
        dto = CreateWordViewDto.empty(available_tags=self._available_tags)
        self._view.render(dto)

    def _handle_submit(self, form_data: dict[str, Any]) -> None:
        """Callback cuando la vista hace submit."""
        self._view.page.run_task(lambda: self._async_submit(form_data))

    async def _async_submit(self, form_data: dict[str, Any]) -> None:
        """Procesa el submit del formulario."""
        # Validación básica
        text_es = (form_data.get("text_es") or "").strip()
        if not text_es:
            dto = CreateWordViewDto.error(
                message="La palabra en español es obligatoria",
                form_values=form_data,
                available_tags=self._available_tags,
                error_field="text_es",
            )
            self._view.render(dto)
            return

        # Preparar traducciones
        translations = {}
        text_lang = (form_data.get("text_lang") or "").strip()
        if text_lang:
            translations[LanguageCodeEnum.NL_NL.value] = text_lang

        try:
            # Llamar servicio
            create_dto = CreateWordDto.from_primitives({
                "text": text_es,
                "word_type": form_data.get("word_type", "WORD"),
                "tags": form_data.get("selected_tags", []),
                "translations": translations,
                "notes": (form_data.get("notes") or "").strip(),
            })

            result = await self._create_word_service(create_dto)

            # Éxito: mostrar mensaje y limpiar form
            dto = CreateWordViewDto.success(
                message=f"Palabra '{result.text}' creada correctamente",
                available_tags=self._available_tags,
            )
            self._view.render(dto)

            # Opcional: navegar después de éxito
            # self._on_success()

        except Exception as e:
            self._logger.write_error(
                "CreateWordController",
                f"Error creando palabra: {e}",
                {"form_data": form_data},
            )
            dto = CreateWordViewDto.error(
                message=str(e),
                form_values=form_data,
                available_tags=self._available_tags,
            )
            self._view.render(dto)
