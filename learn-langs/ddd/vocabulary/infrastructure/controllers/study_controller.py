"""Controller para el Study."""

import asyncio
import time
from typing import Any, Callable

import flet as ft

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
from ddd.vocabulary.application.start_study_session import (
    StartStudySessionDto,
    StartStudySessionService,
    StudyWordDto,
)
from ddd.vocabulary.infrastructure.ui.views.study_view import StudyView
from ddd.vocabulary.infrastructure.ui.views.study_view_dto import StudyViewDto


class StudyController(BaseController):
    """
    Controller del Study.

    Responsabilidades:
    - Orquestar flujo entre Vista y Servicios
    - Manejar estado (sesion, palabras, scores)
    - Crear ViewDTOs y pasarlos a la Vista
    - Manejar callbacks de la Vista
    - NO hereda de ft.Container
    """

    # =========================================================================
    # CONSTRUCCIÓN
    # =========================================================================
    def __init__(
        self,
        lang_code: str,               # Parametro de sesion: idioma a practicar
        tags: list[str],              # Parametro de sesion: filtros de tags
        group_id: int | None,         # Parametro de sesion: grupo de palabras
        route_on_back: Callable[[], None],  # Callback de navegacion (volver al home)
    ):
        # Parametros de sesion (inyectados desde app_router)
        self._lang_code = lang_code
        self._tags = tags
        self._group_id = group_id
        self._route_on_back = route_on_back

        # Estado interno de sesion
        self._session_id: int = 0
        self._words: list[StudyWordDto] = []
        self._current_index: int = 0
        self._start_time: float = 0
        self._total_score: float = 0
        self._answers_count: int = 0
        self._failed_words: list[dict[str, Any]] = []

        # Servicios
        self._logger = Logger.get_instance()
        self._start_session_service = StartStudySessionService.get_instance()
        self._record_answer_service = RecordAnswerService.get_instance()
        self._finish_session_service = FinishStudySessionService.get_instance()

        # Vista
        self._ft_container = StudyView.from_primitives({
            "on_mount": self._on_mount,
            "on_answer": self._on_input_answer,
            "on_skip": self._on_skip_btn_click,
            "on_timeout": self._on_timer_timeout,
            "on_back": self._on_back_btn_click,
            "on_retry_failed": self._on_retry_failed_click,
        })

    # =========================================================================
    # API PÚBLICA
    # =========================================================================
    @property
    def ft_container(self) -> ft.Container:
        """Vista para montar en el arbol de Flet."""
        return self._ft_container

    # =========================================================================
    # LIFECYCLE & CARGA DE DATOS
    # =========================================================================
    def _on_mount(self) -> None:
        """Callback cuando la vista se monta. Inicia la sesion de estudio."""
        self._ft_container.page.run_task(self._async_start_session)

    async def _async_start_session(self) -> None:
        """Inicia la sesion de estudio cargando palabras del servicio."""
        self._ft_container.render(StudyViewDto.initial())

        try:
            start_dto = StartStudySessionDto.from_primitives({
                "lang_code": self._lang_code,
                "study_mode": "TYPING",
                "tags": self._tags,
                "group_id": self._group_id,
                "limit": 20,
            })

            result = await self._start_session_service(start_dto)

            self._session_id = result.session_id
            self._words = list(result.words)

            if not self._words:
                self._ft_container.render(StudyViewDto.no_words())
                return

            self._show_current_word()

        except Exception as e:
            self._logger.log_error(
                "StudyController",
                f"Error iniciando sesion: {e}",
                {"lang_code": self._lang_code, "tags": self._tags},
            )
            self._ft_container.render(StudyViewDto.error(str(e)))

    async def _async_process_answer(self, user_input: str) -> None:
        """Procesa y registra la respuesta del usuario via servicio."""
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

            # Rastrear palabras falladas (score < 0.7)
            if result.score < 0.7:
                self._failed_words.append({
                    "word_es_id": word.word_es_id,
                    "text_es": word.text_es,
                    "text_lang": word.text_lang,
                    "word_type": word.word_type,
                    "pronunciation": word.pronunciation,
                })

            # Mostrar resultado en vista
            dto = StudyViewDto.with_result(
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

            # Esperar (2s si correcto, 5s si error) y continuar
            wait_time = 2 if result.is_correct else 5
            await asyncio.sleep(wait_time)
            self._next_word()

        except Exception as e:
            self._logger.log_error(
                "StudyController",
                f"Error registrando respuesta: {e}",
                {
                    "session_id": self._session_id,
                    "word_es_id": word.word_es_id,
                    "user_input": user_input,
                },
            )
            self._next_word()

    async def _async_finish_session(self) -> None:
        """Finaliza la sesion via servicio."""
        try:
            dto = FinishStudySessionDto.from_primitives({
                "session_id": self._session_id,
                "lang_code": self._lang_code,
                "study_mode": "TYPING",
            })
            await self._finish_session_service(dto)

        except Exception as e:
            self._logger.log_error(
                "StudyController",
                f"Error finalizando sesion: {e}",
                {"session_id": self._session_id},
            )

    async def _async_retry_failed(self) -> None:
        """Reinicia la sesión con solo las palabras falladas."""
        try:
            # Finalizar sesión actual
            await self._async_finish_session()

            # Convertir palabras falladas a StudyWordDto
            failed_words_dto = [
                StudyWordDto.from_primitives(word)
                for word in self._failed_words
            ]

            # Reiniciar estado con palabras falladas
            self._words = failed_words_dto
            self._current_index = 0
            self._total_score = 0
            self._answers_count = 0
            self._failed_words = []

            # Crear nueva sesión
            start_dto = StartStudySessionDto.from_primitives({
                "lang_code": self._lang_code,
                "study_mode": "TYPING",
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
                "StudyController",
                f"Error reiniciando con palabras falladas: {e}",
            )
            self._ft_container.render(StudyViewDto.error(str(e)))

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

        dto = StudyViewDto.studying(
            session_id=self._session_id,
            lang_code=self._lang_code,
            total_words=len(self._words),
            current_index=self._current_index,
            current_word=self._word_to_dict(word),
            total_score=self._total_score,
            answers_count=self._answers_count,
        )
        self._ft_container.render(dto)

    def _show_session_complete(self) -> None:
        """Muestra pantalla de sesion completada y finaliza via servicio."""
        self._ft_container.page.run_task(self._async_finish_session)

        self._ft_container.render(StudyViewDto.session_complete(
            total_score=self._total_score,
            answers_count=self._answers_count,
            failed_words=self._failed_words,
        ))

    def _next_word(self) -> None:
        """Avanza a la siguiente palabra."""
        self._current_index += 1
        self._show_current_word()

    def _word_to_dict(self, word: StudyWordDto) -> dict[str, Any]:
        """Convierte StudyWordDto a dict para la vista."""
        return {
            "word_es_id": word.word_es_id,
            "text_es": word.text_es,
            "text_lang": word.text_lang,
            "word_type": word.word_type,
            "pronunciation": word.pronunciation,
        }
