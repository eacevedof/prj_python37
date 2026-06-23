"""Controller para el Image Study."""

import asyncio
import time
from pathlib import Path
from typing import Any, Callable

import flet as ft
import pygame

from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.controllers import BaseController
from ddd.vocabulary.application.finish_study_session import (
    FinishStudySessionDto,
    FinishStudySessionService,
)
from ddd.vocabulary.application.record_answer import (
    RecordAnswerDto,
    RecordAnswerService,
)
from ddd.vocabulary.application.start_image_study_session import (
    StartImageStudySessionDto,
    StartImageStudySessionService,
    ImageStudyWordDto,
)
from ddd.vocabulary.application.generate_text_audio_ai import (
    GenerateTextAudioAiDto,
    GenerateTextAudioAiService,
)
from ddd.vocabulary.domain.enums import LanguageCodeEnum
from ddd.vocabulary.infrastructure.ui.views.image_study_view import ImageStudyView
from ddd.vocabulary.infrastructure.ui.views.image_study_view_dto import ImageStudyViewDto


class ImageStudyController(BaseController):
    """
    Controller del Image Study.

    Responsabilidades:
    - Orquestar flujo entre Vista y Servicios para estudio con imágenes
    - Manejar estado (sesión, palabras con imágenes, scores)
    - Crear ViewDTOs y pasarlos a la Vista
    - Manejar callbacks de la Vista
    """

    # =========================================================================
    # CONSTRUCCIÓN
    # =========================================================================
    def __init__(
        self,
        lang_code: str,                      # Parámetro de sesión: idioma a practicar
        tags: list[str],                     # Parámetro de sesión: filtros de tags
        group_id: int | None,                # Parámetro de sesión: grupo de palabras
        route_on_back: Callable[[], None],  # Callback de navegación (volver al home)
    ):
        # Parámetros de sesión (inyectados desde app_router)
        self._lang_code = lang_code
        self._tags = tags
        self._group_id = group_id
        self._route_on_back = route_on_back

        # Estado interno de sesión
        self._session_id: int = 0
        self._words: list[ImageStudyWordDto] = []
        self._current_index: int = 0
        self._start_time: float = 0
        self._total_score: float = 0
        self._answers_count: int = 0
        self._failed_words: list[dict[str, Any]] = []
        self._is_session_complete: bool = False

        # Servicios
        self._logger = Logger.get_instance()
        self._start_session_service = StartImageStudySessionService.get_instance()
        self._record_answer_service = RecordAnswerService.get_instance()
        self._finish_session_service = FinishStudySessionService.get_instance()
        self._generate_text_audio_service = GenerateTextAudioAiService.get_instance()

        # Vista
        self._ft_container = ImageStudyView.from_primitives({
            "on_mount": self._on_mount,
            "on_answer": self._on_input_answer,
            "on_skip": self._on_skip_btn_click,
            "on_timeout": self._on_timer_timeout,
            "on_back": self._on_back_btn_click,
            "on_retry_failed": self._on_retry_failed_click,
            "on_play_audio": self._on_play_audio_click,
        })

    # =========================================================================
    # API PÚBLICA
    # =========================================================================
    @property
    def ft_container(self) -> ft.Container:
        """Vista para montar en el árbol de Flet."""
        return self._ft_container

    # =========================================================================
    # LIFECYCLE & CARGA DE DATOS
    # =========================================================================
    def _on_mount(self) -> None:
        """Callback cuando la vista se monta. Inicia la sesión de estudio."""
        self._ft_container.page.run_task(self._async_start_session)

    async def _async_start_session(self) -> None:
        """Inicia la sesión de estudio con imágenes cargando palabras del servicio."""
        self._ft_container.render(ImageStudyViewDto.initial())

        # DEBUG: Log del group_id
        self._logger.log_debug(
            "ImageStudyController",
            f"Starting session with group_id={self._group_id}",
            {"lang_code": self._lang_code, "tags": self._tags, "group_id": self._group_id},
        )

        try:
            start_dto = StartImageStudySessionDto.from_primitives({
                "lang_code": self._lang_code,
                "tags": self._tags,
                "group_id": self._group_id,
                "limit": 40,
            })

            result = await self._start_session_service(start_dto)

            self._session_id = result.session_id
            self._words = list(result.words)

            if not self._words:
                self._ft_container.render(ImageStudyViewDto.no_words())
                return

            self._show_current_word()

        except Exception as e:
            self._logger.log_error(
                "ImageStudyController",
                f"Error iniciando sesión: {e}",
                {"lang_code": self._lang_code, "tags": self._tags},
            )
            self._ft_container.render(ImageStudyViewDto.error(str(e)))

    async def _async_process_answer(self, user_input: str) -> None:
        """Procesa y registra la respuesta del usuario via servicio."""
        # Evitar procesar si la sesión ya está completa
        if self._is_session_complete:
            return

        word = self._words[self._current_index]
        response_time = int((time.time() - self._start_time) * 1000)

        try:
            record_dto = RecordAnswerDto.from_primitives({
                "session_id": self._session_id,
                "word_es_id": word.word_es_id,
                "user_input": user_input,
                "expected_text": word.text_lang,
                "response_time_ms": response_time,
            })

            result = await self._record_answer_service(record_dto)

            # Actualizar stats internas
            self._total_score += result.score
            self._answers_count += 1

            # Rastrear palabras falladas (cualquier respuesta incorrecta)
            if not result.is_correct:
                self._failed_words.append({
                    "word_es_id": word.word_es_id,
                    "text_es": word.text_es,
                    "text_lang": word.text_lang,
                    "word_type": word.word_type,
                    "pronunciation": word.pronunciation,
                    "image_file_path": word.image_file_path,
                    "image_mime_type": word.image_mime_type,
                    "image_caption": word.image_caption,
                })

            # Mostrar resultado en vista
            dto = ImageStudyViewDto.with_result(
                session_id=self._session_id,
                lang_code=self._lang_code,
                total_words=len(self._words),
                current_index=self._current_index,
                current_word=self._word_to_dict(word),
                total_score=self._total_score,
                answers_count=self._answers_count,
                last_result={
                    "is_correct": result.is_correct,
                    "score": result.score,
                    "correct_answer": word.text_lang,
                },
            )
            self._ft_container.render(dto)

            # Al revisar: reproducir el audio del idioma destino y esperar 3s
            await self._play_text_audio(
                word.text_lang,
                self._lang_code,
                word.word_es_id,
            )
            await asyncio.sleep(3)
            self._next_word()

        except Exception as e:
            self._logger.log_error(
                "ImageStudyController",
                f"Error registrando respuesta: {e}",
                {
                    "session_id": self._session_id,
                    "word_es_id": word.word_es_id,
                    "user_input": user_input,
                },
            )
            self._next_word()

    async def _async_finish_session(self) -> None:
        """Finaliza la sesión via servicio."""
        try:
            dto = FinishStudySessionDto.from_primitives({
                "session_id": self._session_id,
                "lang_code": self._lang_code,
                "study_mode": "IMAGE_TYPING",
            })
            await self._finish_session_service(dto)

        except Exception as e:
            self._logger.log_error(
                "ImageStudyController",
                f"Error finalizando sesión: {e}",
                {"session_id": self._session_id},
            )

    async def _async_retry_failed(self) -> None:
        """Reinicia la sesión con solo las palabras falladas."""
        try:
            # Finalizar sesión actual
            await self._async_finish_session()

            # Convertir palabras falladas a ImageStudyWordDto
            failed_words_dto = [
                ImageStudyWordDto.from_primitives(word)
                for word in self._failed_words
            ]

            # Reiniciar estado con palabras falladas
            self._words = failed_words_dto
            self._current_index = 0
            self._total_score = 0
            self._answers_count = 0
            self._failed_words = []
            self._is_session_complete = False

            # Crear nueva sesión
            start_dto = StartImageStudySessionDto.from_primitives({
                "lang_code": self._lang_code,
                "tags": self._tags,
                "group_id": self._group_id,
                "limit": len(failed_words_dto),
            })
            result = await self._start_session_service(start_dto)
            self._session_id = result.session_id

            # Mostrar primera palabra
            self._show_current_word()

        except Exception as e:
            self._logger.log_error(
                "ImageStudyController",
                f"Error reiniciando con palabras falladas: {e}",
            )
            self._ft_container.render(ImageStudyViewDto.error(str(e)))

    async def _async_play_audio(self) -> None:
        """Reproduce el audio del idioma destino de la palabra actual (botón pista).

        Usa el mismo camino que la reproducción automática (gpt-4o-mini-tts con
        acento), para que el botón suene igual.
        """
        if self._current_index >= len(self._words):
            return
        word = self._words[self._current_index]
        await self._play_text_audio(
            word.text_lang,
            self._lang_code,
            word.word_es_id,
        )

    async def _async_play_source_audio(self) -> None:
        """Reproduce el audio en español de la palabra actual (al aparecer)."""
        if self._current_index >= len(self._words):
            return
        word = self._words[self._current_index]
        await self._play_text_audio(
            word.text_es,
            LanguageCodeEnum.ES_ES.value,
            word.word_es_id,
        )

    async def _play_text_audio(self, text: str, lang_code: str, word_id: int) -> None:
        """Genera (o reutiliza de cache) y reproduce el audio de un texto."""
        if not text:
            return
        try:
            audio_dto = GenerateTextAudioAiDto.from_primitives({
                "text": text,
                "lang_code": lang_code,
                "word_id": word_id,
            })
            result = await self._generate_text_audio_service(audio_dto)
            if not result.success:
                self._logger.log_error(
                    "ImageStudyController",
                    f"Error generando audio: {result.error_message}",
                )
                return
            await asyncio.to_thread(self._play_audio_file, result.audio_path)
        except Exception as e:
            self._logger.log_error(
                "ImageStudyController",
                f"Error reproduciendo audio: {e}",
                {"text": text, "lang_code": lang_code},
            )

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

    # =========================================================================
    # EVENT HANDLERS (orden visual/lógico en UI: flashcard → input → timer → back)
    # =========================================================================
    def _on_input_answer(self, user_input: str) -> None:
        """Maneja respuesta del usuario en input field (centro en UI)."""
        async def _task():
            await self._async_process_answer(user_input)
        self._ft_container.page.run_task(_task)

    def _on_skip_btn_click(self) -> None:
        """Maneja click en boton skip (boton skip junto al input)."""
        async def _task():
            await self._async_process_answer("")
        self._ft_container.page.run_task(_task)

    def _on_timer_timeout(self) -> None:
        """Maneja timeout del timer (arriba en UI)."""
        async def _task():
            await self._async_process_answer("")
        self._ft_container.page.run_task(_task)

    def _on_back_btn_click(self) -> None:
        """Maneja click en boton volver (arriba izquierda en UI)."""
        self._ft_container.page.run_task(self._async_finish_session)
        self._route_on_back()

    def _on_retry_failed_click(self) -> None:
        """Maneja click en boton repetir errores."""
        self._ft_container.page.run_task(self._async_retry_failed)

    def _on_play_audio_click(self) -> None:
        """Maneja click en boton de audio (pista)."""
        async def _task():
            await self._async_play_audio()
        self._ft_container.page.run_task(_task)

    # =========================================================================
    # HELPERS PRIVADOS
    # =========================================================================
    def _show_current_word(self) -> None:
        """Muestra la palabra actual o completa sesion si no hay mas."""
        if self._current_index >= len(self._words):
            self._show_session_complete()
            return

        self._start_time = time.time()
        word = self._words[self._current_index]

        dto = ImageStudyViewDto.studying(
            session_id=self._session_id,
            lang_code=self._lang_code,
            total_words=len(self._words),
            current_index=self._current_index,
            current_word=self._word_to_dict(word),
            total_score=self._total_score,
            answers_count=self._answers_count,
        )
        self._ft_container.render(dto)

        # Reproducir el audio en español en cuanto aparece la palabra
        self._ft_container.page.run_task(self._async_play_source_audio)

    def _show_session_complete(self) -> None:
        """Muestra pantalla de sesion completada y finaliza via servicio."""
        self._is_session_complete = True
        self._ft_container.page.run_task(self._async_finish_session)

        self._ft_container.render(ImageStudyViewDto.session_complete(
            total_score=self._total_score,
            answers_count=self._answers_count,
            failed_words=self._failed_words,
        ))

    def _next_word(self) -> None:
        """Avanza a la siguiente palabra."""
        self._current_index += 1
        self._show_current_word()

    def _word_to_dict(self, word: ImageStudyWordDto) -> dict[str, Any]:
        """Convierte ImageStudyWordDto a dict para la vista."""
        return {
            "word_es_id": word.word_es_id,
            "text_es": word.text_es,
            "text_lang": word.text_lang,
            "word_type": word.word_type,
            "pronunciation": word.pronunciation,
            "image_file_path": word.image_file_path,
            "image_mime_type": word.image_mime_type,
            "image_caption": word.image_caption,
        }
