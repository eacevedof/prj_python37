"""Controller para actualizacion de palabra."""

import asyncio
from pathlib import Path
from typing import Callable, Any

import flet as ft
import pygame

from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.controllers import BaseController
from ddd.vocabulary.application.update_word import UpdateWordDto, UpdateWordService
from ddd.vocabulary.application.get_word_for_edit import (
    GetWordForEditDto,
    GetWordForEditService,
)
from ddd.vocabulary.application.generate_text_audio_ai import (
    GenerateTextAudioAiDto,
    GenerateTextAudioAiService,
)
from ddd.vocabulary.application.regenerate_word_audio import (
    RegenerateWordAudioDto,
    RegenerateWordAudioService,
)
from ddd.vocabulary.application.accept_word_audio import (
    AcceptWordAudioDto,
    AcceptWordAudioService,
)
from ddd.vocabulary.application.discard_word_audio import (
    DiscardWordAudioDto,
    DiscardWordAudioService,
)
from ddd.vocabulary.domain.enums import LanguageCodeEnum
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.repositories import (
    ImagesReaderSqliteRepository,
    WordAudiosReaderFileRepository,
    WordGroupsReaderSqliteRepository,
)
from ddd.vocabulary.infrastructure.ui.views.update_word_view import UpdateWordView
from ddd.vocabulary.infrastructure.ui.views.update_word_view_dto import UpdateWordViewDto


class UpdateWordController(BaseController):
    """
    Controller para actualizacion de palabra.

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
        word_id: int,                           # 1. Dato requerido (ID de palabra a editar)
        on_success: Callable[[], None],         # 2. Callback primario (al guardar cambios)
        on_back: Callable[[], None],            # 3. Callback secundario (cancelar/volver)
    ):
        # Datos iniciales
        self._word_id = word_id

        # Callbacks de navegación (inyectados desde app_router)
        self._route_on_success = on_success
        self._route_on_back = on_back

        # Estado interno
        self._available_tags: list[dict[str, Any]] = []
        self._audio_rows: list[dict[str, Any]] = []

        # Servicios
        self._logger = Logger.get_instance()
        self._update_word_service = UpdateWordService.get_instance()
        self._get_word_for_edit_service = GetWordForEditService.get_instance()
        self._generate_text_audio_service = GenerateTextAudioAiService.get_instance()
        self._regenerate_word_audio_service = RegenerateWordAudioService.get_instance()
        self._accept_word_audio_service = AcceptWordAudioService.get_instance()
        self._discard_word_audio_service = DiscardWordAudioService.get_instance()
        self._images_reader = ImagesReaderSqliteRepository.get_instance()
        self._word_groups_reader = WordGroupsReaderSqliteRepository.get_instance()
        self._word_audios_reader = WordAudiosReaderFileRepository.get_instance()

        # Vista
        self._ft_container = UpdateWordView.from_primitives({
            "on_mount": self._on_mount,
            "on_submit": self._on_save_btn_click,
            "on_back": self._route_on_back,
            "on_play_audio": self._on_play_audio_click,
            "on_regenerate_audio": self._on_regenerate_audio_click,
            "on_play_temp_audio": self._on_play_temp_audio_click,
            "on_accept_audio": self._on_accept_audio_click,
            "on_discard_audio": self._on_discard_audio_click,
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
        self._ft_container.page.run_task(self._async_load_data)

    async def _async_load_data(self) -> None:
        """Carga la palabra y datos iniciales desde el servicio."""
        # Mostrar loading
        self._ft_container.render(UpdateWordViewDto.create_loading())

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
            self._available_tags = list(result.available_tags)

            # Cargar imagenes de la palabra
            word_images = await self._images_reader.get_word_es_images_by_word_es_id(self._word_id)

            # Cargar grupos de la palabra
            word_groups = await self._word_groups_reader.get_word_group_by_word_es_id(self._word_id)

            # Cargar todos los grupos disponibles
            all_groups = await self._word_groups_reader.get_all_word_groups()

            # Estado de audios por idioma (español origen + neerlandés destino)
            self._audio_rows = self._get_initial_audio_rows()

            # Renderizar
            update_word_view_dto = UpdateWordViewDto.with_data(
                word_id=self._word_id,
                text=result.text,
                word_type=result.word_type,
                notes=result.notes,
                img_ia_context=result.img_ia_context,
                translation_nl=result.translations.get(
                    LanguageCodeEnum.NL_NL.value, ""
                ),
                examples_nl=result.translations_examples.get(
                    LanguageCodeEnum.NL_NL.value, ""
                ),
                selected_tags=list(result.selected_tags),
                available_tags=self._available_tags,
                available_groups=all_groups,
                word_groups=word_groups,
                word_images=word_images,
                audio_languages=self._audio_rows,
            )
            self._ft_container.render(update_word_view_dto)

        except Exception as e:
            self._logger.log_error(
                "UpdateWordController",
                f"Error cargando palabra: {e}",
                {"word_id": self._word_id},
            )
            self._ft_container.show_snackbar(f"Error al cargar: {e}", error=True)

    # =========================================================================
    # EVENT HANDLERS (orden visual/lógico de arriba a abajo en UI)
    # =========================================================================
    def _on_save_btn_click(self, form_data: dict[str, Any]) -> None:
        """Maneja click en guardar cambios (boton azul - abajo en UI)."""
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

        # Preparar traducciones (texto + ejemplos de uso)
        translations = {}
        translations_examples = {}
        text_nl = (form_data.get("text_nl") or "").strip()
        if text_nl:
            translations[LanguageCodeEnum.NL_NL.value] = text_nl
            translations_examples[LanguageCodeEnum.NL_NL.value] = (
                form_data.get("examples_nl") or ""
            ).strip()

        try:
            # Llamar servicio
            update_dto = UpdateWordDto.from_primitives({
                "word_id": self._word_id,
                "text": text_es,
                "word_type": form_data.get("word_type", "WORD"),
                "tags": form_data.get("selected_tags", []),
                "group_ids": form_data.get("selected_group_ids", []),
                "translations": translations,
                "translations_examples": translations_examples,
                "notes": (form_data.get("notes") or "").strip(),
                "img_ia_context": (form_data.get("img_ia_context") or "").strip(),
            })

            result = await self._update_word_service(update_dto)

            # Exito: mostrar mensaje
            self._ft_container.show_snackbar(f"Palabra '{result.text}' actualizada")

            # Navegar de vuelta
            self._route_on_success()

        except VocabularyException as e:
            self._logger.log_error(
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
            self._logger.log_error(
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

    # =========================================================================
    # EVENT HANDLERS - AUDIOS (escuchar / regenerar / aceptar / rechazar)
    # =========================================================================
    def _on_play_audio_click(self, audio_payload: dict[str, Any]) -> None:
        """Maneja click en escuchar audio actual (lo genera si no existe)."""
        async def _task():
            await self._async_play_audio(audio_payload)
        self._ft_container.page.run_task(_task)

    def _on_regenerate_audio_click(self, audio_payload: dict[str, Any]) -> None:
        """Maneja click en regenerar audio (borra el actual, crea propuesta temporal)."""
        async def _task():
            await self._async_regenerate_audio(audio_payload)
        self._ft_container.page.run_task(_task)

    def _on_play_temp_audio_click(self, lang_code: str) -> None:
        """Maneja click en escuchar la propuesta temporal."""
        async def _task():
            temp_audio_path = self._word_audios_reader.get_temp_audio_path(self._word_id, lang_code)
            await asyncio.to_thread(self._play_audio_file, temp_audio_path)
        self._ft_container.page.run_task(_task)

    def _on_accept_audio_click(self, lang_code: str) -> None:
        """Maneja click en aceptar la propuesta (pasa a ser el audio definitivo)."""
        async def _task():
            await self._async_accept_audio(lang_code)
        self._ft_container.page.run_task(_task)

    def _on_discard_audio_click(self, lang_code: str) -> None:
        """Maneja click en rechazar la propuesta temporal."""
        async def _task():
            await self._async_discard_audio(lang_code)
        self._ft_container.page.run_task(_task)

    async def _async_play_audio(self, audio_payload: dict[str, Any]) -> None:
        """Genera (o reutiliza de cache) y reproduce el audio actual del idioma."""
        lang_code = str(audio_payload.get("lang_code", ""))
        text_to_speak = str(audio_payload.get("text", "")).strip()

        if not text_to_speak:
            self._ft_container.show_snackbar("No hay texto para reproducir", error=True)
            return

        try:
            result = await self._generate_text_audio_service(
                GenerateTextAudioAiDto.from_primitives({
                    "text": text_to_speak,
                    "lang_code": lang_code,
                    "word_id": self._word_id,
                })
            )
            if not result.success:
                self._ft_container.show_snackbar(result.error_message or "Error", error=True)
                return

            await asyncio.to_thread(self._play_audio_file, result.audio_path)

        except Exception as e:
            self._logger.log_error(
                "UpdateWordController",
                f"Error reproduciendo audio: {e}",
                {"word_id": self._word_id, "lang_code": lang_code},
            )
            self._ft_container.show_snackbar(f"Error reproduciendo audio: {e}", error=True)

    async def _async_regenerate_audio(self, audio_payload: dict[str, Any]) -> None:
        """Regenera el audio: borra el definitivo, crea propuesta temporal y la reproduce."""
        lang_code = str(audio_payload.get("lang_code", ""))
        text_to_speak = str(audio_payload.get("text", "")).strip()

        if not text_to_speak:
            self._ft_container.show_snackbar("No hay texto para generar el audio", error=True)
            return

        self._set_audio_row(lang_code, is_generating=True)
        self._ft_container.render_audio_rows(self._audio_rows)

        result = await self._regenerate_word_audio_service(
            RegenerateWordAudioDto.from_primitives({
                "word_id": self._word_id,
                "lang_code": lang_code,
                "text": text_to_speak,
            })
        )

        if not result.success:
            self._set_audio_row(lang_code, is_generating=False)
            self._ft_container.render_audio_rows(self._audio_rows)
            self._ft_container.show_snackbar(result.error_message or "Error", error=True)
            return

        self._set_audio_row(lang_code, is_generating=False, has_temp=True)
        self._ft_container.render_audio_rows(self._audio_rows)

        # Reproducir la propuesta para comprobarla de inmediato
        await asyncio.to_thread(self._play_audio_file, result.temp_audio_path)

    async def _async_accept_audio(self, lang_code: str) -> None:
        """Acepta la propuesta temporal via servicio."""
        result = await self._accept_word_audio_service(
            AcceptWordAudioDto.from_primitives({
                "word_id": self._word_id,
                "lang_code": lang_code,
            })
        )

        if not result.success:
            self._ft_container.show_snackbar(result.error_message or "Error", error=True)
            return

        self._set_audio_row(lang_code, has_temp=False)
        self._ft_container.render_audio_rows(self._audio_rows)
        self._ft_container.show_snackbar("Audio aceptado como definitivo")

    async def _async_discard_audio(self, lang_code: str) -> None:
        """Descarta la propuesta temporal via servicio."""
        result = await self._discard_word_audio_service(
            DiscardWordAudioDto.from_primitives({
                "word_id": self._word_id,
                "lang_code": lang_code,
            })
        )

        if not result.success:
            self._ft_container.show_snackbar(result.error_message or "Error", error=True)
            return

        self._set_audio_row(lang_code, has_temp=False)
        self._ft_container.render_audio_rows(self._audio_rows)
        self._ft_container.show_snackbar("Propuesta de audio descartada")

    # =========================================================================
    # HELPERS PRIVADOS
    # =========================================================================
    def _get_initial_audio_rows(self) -> list[dict[str, Any]]:
        """Filas de audio por idioma (origen español + destino neerlandés)."""
        return [
            {
                "lang_code": lang_code_enum.value,
                "label": lang_code_enum.display_name,
                "has_temp": self._word_audios_reader.has_temp_audio(
                    self._word_id, lang_code_enum.value
                ),
                "is_generating": False,
            }
            for lang_code_enum in (LanguageCodeEnum.ES_ES, LanguageCodeEnum.NL_NL)
        ]

    def _set_audio_row(self, lang_code: str, **changes: Any) -> None:
        """Actualiza el estado de la fila de audio del idioma dado."""
        for audio_row in self._audio_rows:
            if audio_row.get("lang_code") == lang_code:
                audio_row.update(changes)
                return

    @staticmethod
    def _play_audio_file(audio_path: str) -> None:
        """Reproduce un mp3 de forma sincrónica con pygame (en thread aparte)."""
        if not pygame.mixer.get_init():
            pygame.mixer.init()
        pygame.mixer.music.load(str(Path(audio_path).resolve()))
        pygame.mixer.music.play()
        while pygame.mixer.music.get_busy():
            pygame.time.Clock().tick(10)
        pygame.mixer.music.unload()
