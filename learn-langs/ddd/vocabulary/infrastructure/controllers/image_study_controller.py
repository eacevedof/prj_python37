"""Controller para el Image Study."""

import asyncio
import time
from typing import Any, Callable

import flet as ft

from ddd.shared.infrastructure.components.audio_player import AudioPlayer
from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.controllers import BaseController
from ddd.vocabulary.application.clear_activity_state import (
    ClearActivityStateDto,
    ClearActivityStateService,
)
from ddd.vocabulary.application.finish_study_session import (
    FinishStudySessionDto,
    FinishStudySessionService,
)
from ddd.vocabulary.application.save_activity_state import (
    SaveActivityStateDto,
    SaveActivityStateService,
)
from ddd.vocabulary.application.record_answer import (
    RecordAnswerDto,
    RecordAnswerService,
)
from ddd.vocabulary.application.evaluate_answer import (
    EvaluateAnswerDto,
    EvaluateAnswerService,
)
from ddd.vocabulary.application.discard_study_session import (
    DiscardStudySessionDto,
    DiscardStudySessionService,
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
from ddd.vocabulary.domain.enums import (
    ActivityEnum,
    ImageStudySequenceEnum,
    LanguageCodeEnum,
    SliderSequenceEnum,
)
from ddd.vocabulary.domain.services import DutchToSpanishPhoneticService
from ddd.vocabulary.infrastructure.repositories import WordGroupsReaderSqliteRepository
from ddd.vocabulary.infrastructure.ui.views.image_study_view import ImageStudyView
from ddd.vocabulary.infrastructure.ui.views.image_study_view_dto import (
    ImageStudyViewDto,
)


class ImageStudyController(BaseController):
    """
    Controller del Image Study.

    Responsabilidades:
    - Orquestar flujo entre Vista y Servicios para estudio con imágenes
    - Manejar estado (sesión, palabras con imágenes, scores)
    - Crear ViewDTOs y pasarlos a la Vista
    - Manejar callbacks de la Vista
    """

    def __init__(
        self,
        lang_code: str,  # Parámetro de sesión: idioma a practicar
        tags: list[str],  # Parámetro de sesión: filtros de tags
        group_id: int | None,  # Parámetro de sesión: grupo de palabras
        route_on_back: Callable[[], None],  # Callback de navegación (volver al home)
        start_word_id: int = 0,  # Palabra donde retomar (0 = desde el inicio)
    ):
        # Parámetros de sesión (inyectados desde app_router)
        self._lang_code = lang_code
        self._tags = tags
        self._group_id = group_id
        self._route_on_back = route_on_back
        self._start_word_id = max(0, start_word_id)

        # Estado interno de sesión
        self.__session_id: int = 0
        self.__words: list[ImageStudyWordDto] = []
        self.__current_index: int = 0
        self.__start_time: float = 0
        self.__total_score: float = 0
        self.__answers_count: int = 0
        self.__failed_words: list[dict[str, Any]] = []
        self.__is_session_complete: bool = False
        # Respuestas acumuladas en memoria; se persisten SOLO al completar (replay).
        # Al abortar se descartan (nada de lo realizado cuenta).
        self.__buffered_answers: list[dict[str, Any]] = []

        # Al salir del examen: corta el audio en curso y evita que arranquen
        # nuevos (los audios seguían sonando tras volver al home)
        self.__is_exited: bool = False

        # Servicios
        self._logger = Logger.get_instance()
        self._audio_player = AudioPlayer.get_instance()
        self._start_session_service = StartImageStudySessionService.get_instance()
        self._evaluate_answer_service = EvaluateAnswerService.get_instance()
        self._record_answer_service = RecordAnswerService.get_instance()
        self._discard_session_service = DiscardStudySessionService.get_instance()
        self._finish_session_service = FinishStudySessionService.get_instance()
        self._save_activity_state_service = SaveActivityStateService.get_instance()
        self._clear_activity_state_service = ClearActivityStateService.get_instance()
        self._generate_text_audio_service = GenerateTextAudioAiService.get_instance()
        self._dutch_phonetic_service = DutchToSpanishPhoneticService.get_instance()
        self._word_groups_reader_sqlite_repository = (
            WordGroupsReaderSqliteRepository.get_instance()
        )

        # Vista
        self._ft_container = ImageStudyView.from_primitives(
            {
                "on_mount": self._on_mount,
                "on_answer": self._on_input_answer,
                "on_skip": self._on_skip_btn_click,
                "on_timeout": self._on_timer_timeout,
                "on_back": self._on_back_btn_click,
                "on_retry_failed": self._on_retry_failed_click,
                "on_play_audio": self._on_play_audio_click,
            }
        )

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
        self.__buffered_answers = []

        # DEBUG: Log del group_id
        self._logger.log_debug(
            "ImageStudyController",
            f"Starting session with group_id={self._group_id}",
            {
                "lang_code": self._lang_code,
                "tags": self._tags,
                "group_id": self._group_id,
            },
        )

        try:
            start_dto = StartImageStudySessionDto.from_primitives(
                {
                    "lang_code": self._lang_code,
                    "tags": self._tags,
                    "group_id": self._group_id,
                    "limit": 40,
                }
            )

            result = await self._start_session_service(start_dto)

            self.__session_id = result.session_id
            # result.words son primitivos (list[dict]); rehidratamos a DTO tipado
            self.__words = [ImageStudyWordDto.from_primitives(w) for w in result.words]

            if not self.__words:
                self._ft_container.render(ImageStudyViewDto.no_words())
                return

            # Retomar sesión: localizar la palabra guardada por id (0 = inicio)
            self.__current_index = next(
                (
                    index
                    for index, word in enumerate(self.__words)
                    if word.word_es_id == self._start_word_id
                ),
                0,
            )
            self._start_word_id = 0

            # Mostrar la fuente del grupo en la cabecera (si no es de migración)
            self._ft_container.render_group_source(await self._get_group_source())

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
        if self.__is_session_complete:
            return

        word = self.__words[self.__current_index]
        response_time = int((time.time() - self.__start_time) * 1000)

        try:
            # Evaluar SIN persistir; la respuesta se acumula y se persiste al completar
            result = await self._evaluate_answer_service(
                EvaluateAnswerDto.from_primitives(
                    {
                        "expected_text": word.text_lang,
                        "user_input": user_input,
                    }
                )
            )

            self.__buffered_answers.append(
                {
                    "session_id": self.__session_id,
                    "word_es_id": word.word_es_id,
                    "user_input": user_input,
                    "expected_text": word.text_lang,
                    "response_time_ms": response_time,
                }
            )

            # Actualizar stats internas
            self.__total_score += result.score
            self.__answers_count += 1

            # Rastrear palabras falladas (cualquier respuesta incorrecta)
            if not result.is_correct:
                self.__failed_words.append(
                    {
                        "word_es_id": word.word_es_id,
                        "text_es": word.text_es,
                        "text_lang": word.text_lang,
                        "word_type": word.word_type,
                        "pronunciation": word.pronunciation,
                        "image_file_path": word.image_file_path,
                        "image_mime_type": word.image_mime_type,
                        "image_caption": word.image_caption,
                    }
                )

            # Mostrar resultado en vista
            dto = ImageStudyViewDto.with_result(
                session_id=self.__session_id,
                lang_code=self._lang_code,
                total_words=len(self.__words),
                current_index=self.__current_index,
                current_word=self._word_to_dict(word),
                total_score=self.__total_score,
                answers_count=self.__answers_count,
                last_result={
                    "is_correct": result.is_correct,
                    "score": result.score,
                    "correct_answer": word.text_lang,
                },
            )
            self._ft_container.render(dto)

            # Como en el aprendizaje: al fallar se pronuncia el neerlandés y se
            # deja tiempo para ver la corrección; al acertar, solo una breve
            # confirmación antes de pasar a la siguiente palabra.
            if not result.is_correct:
                await self._play_text_audio(
                    word.text_lang,
                    self._lang_code,
                    word.word_es_id,
                )
                await asyncio.sleep(
                    ImageStudySequenceEnum.WRONG_REVIEW_WAIT_SECONDS.value
                )
            else:
                await asyncio.sleep(
                    ImageStudySequenceEnum.CORRECT_REVIEW_WAIT_SECONDS.value
                )
            self._next_word()

        except Exception as e:
            self._logger.log_error(
                "ImageStudyController",
                f"Error registrando respuesta: {e}",
                {
                    "session_id": self.__session_id,
                    "word_es_id": word.word_es_id,
                    "user_input": user_input,
                },
            )
            self._next_word()

    async def _async_finish_session(self) -> None:
        """Finaliza la sesión via servicio."""
        try:
            dto = FinishStudySessionDto.from_primitives(
                {
                    "session_id": self.__session_id,
                    "lang_code": self._lang_code,
                    "study_mode": "IMAGE_TYPING",
                }
            )
            await self._finish_session_service(dto)

        except Exception as e:
            self._logger.log_error(
                "ImageStudyController",
                f"Error finalizando sesión: {e}",
                {"session_id": self.__session_id},
            )

    async def _async_commit_and_finish(self) -> None:
        """Al COMPLETAR: persiste todas las respuestas acumuladas y finaliza la sesión."""
        await self._async_commit_answers()
        await self._async_finish_session()
        await self._async_clear_activity_state()

    async def _async_commit_answers(self) -> None:
        """Persiste (replay) cada respuesta acumulada: métricas SM-2 + answer + progreso."""
        for buffered_answer in self.__buffered_answers:
            try:
                await self._record_answer_service(
                    RecordAnswerDto.from_primitives(buffered_answer)
                )
            except Exception as e:
                self._logger.log_error(
                    "ImageStudyController",
                    f"Error persistiendo respuesta al completar: {e}",
                    {"word_es_id": buffered_answer.get("word_es_id")},
                )
        self.__buffered_answers = []

    async def _async_abort(self) -> None:
        """Aborta el examen: descarta el buffer y borra la sesión vacía.

        Como las respuestas solo estaban en memoria (no persistidas), borrar la
        sesión deja la BD como si el examen no hubiera ocurrido.
        """
        # Si el examen ya se completó (persistido), salir no debe borrar nada.
        if self.__is_session_complete:
            return
        self.__buffered_answers = []
        try:
            await self._discard_session_service(
                DiscardStudySessionDto.from_primitives(
                    {"session_id": self.__session_id}
                )
            )
            await self._async_clear_activity_state()
        except Exception as e:
            self._logger.log_error(
                "ImageStudyController",
                f"Error abortando examen: {e}",
                {"session_id": self.__session_id},
            )

    async def _async_retry_failed(self) -> None:
        """Reinicia la sesión con solo las palabras falladas."""
        try:
            # Finalizar sesión actual
            await self._async_finish_session()

            # Convertir palabras falladas a ImageStudyWordDto
            failed_words_dto = [
                ImageStudyWordDto.from_primitives(word) for word in self.__failed_words
            ]

            # Reiniciar estado con palabras falladas
            self.__words = failed_words_dto
            self.__current_index = 0
            self.__total_score = 0
            self.__answers_count = 0
            self.__failed_words = []
            self.__is_session_complete = False
            self.__buffered_answers = []

            # Crear nueva sesión
            start_dto = StartImageStudySessionDto.from_primitives(
                {
                    "lang_code": self._lang_code,
                    "tags": self._tags,
                    "group_id": self._group_id,
                    "limit": len(failed_words_dto),
                }
            )
            result = await self._start_session_service(start_dto)
            self.__session_id = result.session_id

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
        if self.__current_index >= len(self.__words):
            return
        word = self.__words[self.__current_index]
        await self._play_text_audio(
            word.text_lang,
            self._lang_code,
            word.word_es_id,
        )

    async def _async_play_source_audio(self) -> None:
        """Reproduce el audio en español de la palabra actual (al aparecer)."""
        if self.__current_index >= len(self.__words):
            return
        word = self.__words[self.__current_index]
        await self._play_text_audio(
            word.text_es,
            LanguageCodeEnum.ES_ES.value,
            word.word_es_id,
        )

    async def _play_text_audio(self, text: str, lang_code: str, word_id: int) -> None:
        """Genera (o reutiliza de cache) y reproduce el audio de un texto."""
        if not text or self.__is_exited:
            return
        try:
            audio_dto = GenerateTextAudioAiDto.from_primitives(
                {
                    "text": text,
                    "lang_code": lang_code,
                    "word_id": word_id,
                }
            )
            result = await self._generate_text_audio_service(audio_dto)
            if not result.success:
                self._logger.log_error(
                    "ImageStudyController",
                    f"Error generando audio: {result.error_message}",
                )
                return
            if self.__is_exited:
                return
            await self._audio_player.play_until_end(
                self._ft_container.page, result.audio_path, lambda: self.__is_exited
            )
        except Exception as e:
            self._logger.log_error(
                "ImageStudyController",
                f"Error reproduciendo audio: {e}",
                {"text": text, "lang_code": lang_code},
            )

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
        """Salir del examen (abortar): no cuenta nada de lo realizado."""
        # Cortar el audio ANTES de navegar: si no, seguía sonando en el home
        self.__is_exited = True
        self._ft_container.page.run_task(self._audio_player.stop)
        self._ft_container.page.run_task(self._async_abort)
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
        if self.__current_index >= len(self.__words):
            self._show_session_complete()
            return

        self.__start_time = time.time()
        word = self.__words[self.__current_index]

        dto = ImageStudyViewDto.studying(
            session_id=self.__session_id,
            lang_code=self._lang_code,
            total_words=len(self.__words),
            current_index=self.__current_index,
            current_word=self._word_to_dict(word),
            total_score=self.__total_score,
            answers_count=self.__answers_count,
            timer_seconds=self._get_timer_seconds(word),
        )
        self._ft_container.render(dto)

        # Guardar el punto actual para poder retomarlo desde el Home
        self._ft_container.page.run_task(self._async_save_activity_state)

        # Reproducir el audio en español en cuanto aparece la palabra
        self._ft_container.page.run_task(self._async_play_source_audio)

    def _show_session_complete(self) -> None:
        """Completa el examen: persiste TODO lo acumulado y finaliza la sesión."""
        self.__is_session_complete = True
        self._ft_container.page.run_task(self._async_commit_and_finish)

        self._ft_container.render(
            ImageStudyViewDto.session_complete(
                total_score=self.__total_score,
                answers_count=self.__answers_count,
                failed_words=self.__failed_words,
            )
        )

    async def _async_save_activity_state(self) -> None:
        """Guarda el punto actual para poder retomarlo desde el Home (best-effort)."""
        if self.__current_index >= len(self.__words):
            return
        word = self.__words[self.__current_index]
        try:
            await self._save_activity_state_service(
                SaveActivityStateDto.from_primitives(
                    {
                        "activity": ActivityEnum.IMAGE_STUDY.value,
                        "lang_code": self._lang_code,
                        "tags": self._tags,
                        "group_id": self._group_id,
                        "word_es_id": word.word_es_id,
                        "word_index": self.__current_index,
                        "total_words": len(self.__words),
                        "is_random_order": False,
                    }
                )
            )
        except Exception as e:
            self._logger.log_error(
                "ImageStudyController",
                f"Error guardando estado de actividad: {e}",
                {"word_es_id": word.word_es_id},
            )

    async def _async_clear_activity_state(self) -> None:
        """Borra el estado guardado: la sesión terminó, no hay nada que retomar."""
        try:
            await self._clear_activity_state_service(
                ClearActivityStateDto.from_primitives(
                    {
                        "activity": ActivityEnum.IMAGE_STUDY.value,
                    }
                )
            )
        except Exception as e:
            self._logger.log_error(
                "ImageStudyController",
                f"Error borrando estado de actividad: {e}",
            )

    def _next_word(self) -> None:
        """Avanza a la siguiente palabra."""
        self.__current_index += 1
        self._show_current_word()

    def _word_to_dict(self, word: ImageStudyWordDto) -> dict[str, Any]:
        """Convierte ImageStudyWordDto a dict para la vista."""
        return {
            "word_es_id": word.word_es_id,
            "text_es": word.text_es,
            "text_lang": word.text_lang,
            "word_type": word.word_type,
            "pronunciation": self._pronunciation_for(word),
            "image_file_path": word.image_file_path,
            "image_mime_type": word.image_mime_type,
            "image_caption": word.image_caption,
        }

    def _get_timer_seconds(self, word: ImageStudyWordDto) -> int:
        """Tiempo para contestar: más para frases (>2 palabras) que para una palabra."""
        if self._has_more_than_two_words(word.text_lang):
            return ImageStudySequenceEnum.MULTI_WORD_ANSWER_TIMER_SECONDS.value
        return SliderSequenceEnum.FIRST_ES_WAIT_SECONDS.value

    @staticmethod
    def _has_more_than_two_words(text: str) -> bool:
        """True si el texto tiene más de dos palabras (frase)."""
        return len(text.split()) > 2

    async def _get_group_source(self) -> str:
        """Fuente del grupo de la sesión; vacía si no hay o si es de migración."""
        if self._group_id is None:
            return ""
        word_group = (
            await self._word_groups_reader_sqlite_repository.get_word_group_by_group_id(
                self._group_id
            )
        )
        group_source = ((word_group or {}).get("source") or "").strip()
        if group_source.lower() in ("migracion", "migration", "mig"):
            return ""
        return group_source

    def _pronunciation_for(self, word: ImageStudyWordDto) -> str:
        """Pronunciación escrita: para neerlandés, aproximación leíble en español
        (igual que en el slider). Otros idiomas usan la pronunciación de BD.
        """
        is_dutch = self._lang_code in (
            LanguageCodeEnum.NL_NL.value,
            LanguageCodeEnum.NL_BE.value,
        )
        if is_dutch:
            return self._dutch_phonetic_service.transcribe(word.text_lang)
        return word.pronunciation
