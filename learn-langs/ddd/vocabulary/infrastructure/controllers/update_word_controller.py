"""Controller para actualizacion de palabra."""

from typing import Callable, Any

import flet as ft

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.update_word import UpdateWordDto, UpdateWordService
from ddd.vocabulary.domain.enums import LanguageCodeEnum
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.repositories import (
    WordsEsReaderSqliteRepository,
    WordsLangReaderSqliteRepository,
    TagsReaderSqliteRepository,
)
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
    """

    def __init__(
        self,
        word_id: int,
        on_success: Callable[[], None],
        on_back: Callable[[], None],
    ):
        self._word_id = word_id
        self._on_success = on_success
        self._on_back = on_back

        # Estado interno
        self._available_tags: list[dict[str, Any]] = []
        self._current_form_values: dict[str, Any] = {}

        # Servicios
        self._update_word_service = UpdateWordService.get_instance()
        self._words_reader = WordsEsReaderSqliteRepository.get_instance()
        self._lang_reader = WordsLangReaderSqliteRepository.get_instance()
        self._tags_reader = TagsReaderSqliteRepository.get_instance()
        self._logger = Logger.get_instance()

        # Vista
        self._view = UpdateWordView.from_primitives({
            "on_submit": self._handle_submit,
            "on_back": on_back,
            "on_mount": self._handle_mount,
        })

    @property
    def view(self) -> ft.Container:
        """Vista para montar en el arbol de Flet."""
        return self._view

    def _handle_mount(self) -> None:
        """Callback cuando la vista se monta."""
        self._view.page.run_task(self._async_load_data)

    async def _async_load_data(self) -> None:
        """Carga la palabra y datos iniciales."""
        # Mostrar loading
        self._view.render(UpdateWordViewDto.loading())

        try:
            # Cargar palabra
            word_data = await self._words_reader.get_by_id(self._word_id)

            if not word_data:
                self._view.show_snackbar("Palabra no encontrada", error=True)
                self._on_back()
                return

            # Cargar traducciones
            translations = await self._lang_reader.get_all_for_word(self._word_id)
            translation_nl = ""
            for t in translations:
                if t.get("lang_code") == LanguageCodeEnum.NL_NL.value:
                    translation_nl = t.get("text", "")
                    break

            # Cargar tags disponibles
            self._available_tags = await self._tags_reader.get_all()

            # Cargar tags de la palabra
            word_tags = await self._words_reader.get_tags_for_word(self._word_id)
            selected_tags = [t["name"] for t in word_tags]

            # Guardar valores actuales
            self._current_form_values = {
                "text_es": word_data.get("text", ""),
                "text_nl": translation_nl,
                "word_type": word_data.get("word_type", "WORD"),
                "notes": word_data.get("notes", "") or "",
                "selected_tags": selected_tags,
            }

            # Renderizar
            dto = UpdateWordViewDto.with_data(
                word_id=self._word_id,
                text=word_data.get("text", ""),
                word_type=word_data.get("word_type", "WORD"),
                notes=word_data.get("notes", "") or "",
                translation_nl=translation_nl,
                selected_tags=selected_tags,
                available_tags=self._available_tags,
            )
            self._view.render(dto)

        except Exception as e:
            self._logger.write_error(
                "UpdateWordController",
                f"Error cargando palabra: {e}",
                {"word_id": self._word_id},
            )
            self._view.show_snackbar(f"Error al cargar: {e}", error=True)

    def _handle_submit(self, form_data: dict[str, Any]) -> None:
        """Callback cuando la vista hace submit."""
        self._view.page.run_task(lambda: self._async_submit(form_data))

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
            self._view.render(dto)
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
            self._view.show_snackbar(f"Palabra '{result.text}' actualizada")

            # Navegar de vuelta
            self._on_success()

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
            self._view.render(dto)

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
            self._view.render(dto)
