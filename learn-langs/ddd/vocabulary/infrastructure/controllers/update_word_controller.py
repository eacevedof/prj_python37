"""Controller para actualizacion de palabra."""

from typing import Callable, Any

import flet as ft

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.update_word import UpdateWordDto, UpdateWordService
from ddd.vocabulary.application.get_word_for_edit import (
    GetWordForEditDto,
    GetWordForEditService,
)
from ddd.vocabulary.domain.enums import LanguageCodeEnum
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.ui.views.update_word_view import UpdateWordView
from ddd.vocabulary.infrastructure.ui.views.update_word_view_dto import UpdateWordViewDto


class UpdateWordController:
    """
    Controller para actualizacion de palabra.

    Responsabilidades:
    - Orquestar flujo entre Vista y Servicios
    - Crear ViewDTOs y pasarlos a la Vista
    - Manejar callbacks de la Vista
    - NO hereda de ft.Container
    - NO usa repositorios directamente
    """

    def __init__(
        self,
        word_id: int,
        on_success: Callable[[], None],
        on_back: Callable[[], None],
    ):
        self._word_id = word_id
        self._route_on_success = on_success
        self._route_on_back = on_back

        # Estado interno
        self._available_tags: list[dict[str, Any]] = []

        # Servicios
        self._update_word_service = UpdateWordService.get_instance()
        self._get_word_for_edit_service = GetWordForEditService.get_instance()
        self._logger = Logger.get_instance()

        # Vista
        self._ft_container = UpdateWordView.from_primitives({
            "on_submit": self._on_save_btn_click,
            "on_back": self._route_on_back,
            "on_mount": self._on_mount,
        })

    @property
    def ft_container(self) -> ft.Container:
        """Vista para montar en el arbol de Flet."""
        return self._ft_container

    def _on_mount(self) -> None:
        """Callback cuando la vista se monta."""
        self._ft_container.page.run_task(self._async_load_data)

    async def _async_load_data(self) -> None:
        """Carga la palabra y datos iniciales."""
        # Mostrar loading
        self._ft_container.render(UpdateWordViewDto.loading())

        try:
            # Cargar palabra via servicio
            result = await self._get_word_for_edit_service(
                GetWordForEditDto.from_primitives({"word_id": self._word_id})
            )

            if not result.success:
                self._ft_container.show_snackbar(result.error_message or "Error", error=True)
                self._route_on_back()
                return

            # Guardar tags disponibles
            self._available_tags = result.available_tags_as_dicts()

            # Renderizar
            dto = UpdateWordViewDto.with_data(
                word_id=self._word_id,
                text=result.text,
                word_type=result.word_type,
                notes=result.notes,
                translation_nl=result.translations.get(LanguageCodeEnum.NL_NL.value, ""),
                selected_tags=list(result.selected_tags),
                available_tags=self._available_tags,
            )
            self._ft_container.render(dto)

        except Exception as e:
            self._logger.write_error(
                "UpdateWordController",
                f"Error cargando palabra: {e}",
                {"word_id": self._word_id},
            )
            self._ft_container.show_snackbar(f"Error al cargar: {e}", error=True)

    def _on_save_btn_click(self, form_data: dict[str, Any]) -> None:
        """Callback cuando la vista hace submit."""
        async def _task():
            await self._async_submit(form_data)
        self._ft_container.page.run_task(_task)

    async def _async_submit(self, form_data: dict[str, Any]) -> None:
        """Procesa el submit del formulario."""
        # Validacion basica
        text_es = (form_data.get("text_es") or "").strip()
        if not text_es:
            dto = UpdateWordViewDto.error(
                message="La palabra en espanol es obligatoria",
                form_values=form_data,
                available_tags=self._available_tags,
                error_field="text_es",
            )
            self._ft_container.render(dto)
            return

        # Preparar traducciones
        translations = {}
        text_nl = (form_data.get("text_nl") or "").strip()
        if text_nl:
            translations[LanguageCodeEnum.NL_NL.value] = text_nl

        try:
            # Llamar servicio
            update_dto = UpdateWordDto.from_primitives({
                "word_id": self._word_id,
                "text": text_es,
                "word_type": form_data.get("word_type", "WORD"),
                "tags": form_data.get("selected_tags", []),
                "translations": translations,
                "notes": (form_data.get("notes") or "").strip(),
            })

            result = await self._update_word_service(update_dto)

            # Exito: mostrar mensaje
            self._ft_container.show_snackbar(f"Palabra '{result.text}' actualizada")

            # Navegar de vuelta
            self._route_on_success()

        except VocabularyException as e:
            self._logger.write_error(
                "UpdateWordController",
                f"Error de vocabulario: {e.message}",
                {"word_id": self._word_id, "form_data": form_data},
            )
            dto = UpdateWordViewDto.error(
                message=e.message,
                form_values=form_data,
                available_tags=self._available_tags,
            )
            self._ft_container.render(dto)

        except Exception as e:
            self._logger.write_error(
                "UpdateWordController",
                f"Error inesperado: {e}",
                {"word_id": self._word_id, "form_data": form_data},
            )
            dto = UpdateWordViewDto.error(
                message=str(e),
                form_values=form_data,
                available_tags=self._available_tags,
            )
            self._ft_container.render(dto)
