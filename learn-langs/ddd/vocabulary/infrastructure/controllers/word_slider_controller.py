"""Controller para el Word Slider (presentación auto-reproducida con audio)."""

import asyncio
from typing import Callable

import flet as ft

from ddd.shared.infrastructure.components.audio_player import AudioPlayer
from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.components.system.wake_locker import WakeLocker
from ddd.shared.infrastructure.controllers import BaseController
from ddd.vocabulary.application.finish_study_session import (
    FinishStudySessionDto,
    FinishStudySessionService,
)
from ddd.vocabulary.application.generate_notice_audio_ai import (
    GenerateNoticeAudioAiDto,
    GenerateNoticeAudioAiService,
)
from ddd.vocabulary.application.generate_text_audio_ai import (
    GenerateTextAudioAiDto,
    GenerateTextAudioAiService,
)
from ddd.vocabulary.application.clear_activity_state import (
    ClearActivityStateDto,
    ClearActivityStateService,
)
from ddd.vocabulary.application.reset_word_metrics import (
    ResetWordMetricsDto,
    ResetWordMetricsService,
)
from ddd.vocabulary.application.save_activity_state import (
    SaveActivityStateDto,
    SaveActivityStateService,
)
from ddd.vocabulary.application.start_word_slider_session import (
    StartWordSliderSessionDto,
    StartWordSliderSessionService,
    SliderWordDto,
)
from ddd.vocabulary.domain.enums import (
    ActivityEnum,
    LanguageCodeEnum,
    SessionNoticeEnum,
    SliderSequenceEnum,
    StudyModeEnum,
)
from ddd.vocabulary.domain.services import DutchToSpanishPhoneticService
from ddd.vocabulary.infrastructure.repositories import WordGroupsReaderSqliteRepository
from ddd.vocabulary.infrastructure.ui.views.word_slider_view import WordSliderView
from ddd.vocabulary.infrastructure.ui.views.word_slider_view_dto import (
    WordSliderViewDto,
)


class WordSliderController(BaseController):
    """
    Controller del Word Slider.

    Responsabilidades:
    - Orquestar el flujo temporizado entre Vista y Servicios
    - Reproducir la secuencia de audio por palabra (cadencia en SliderSequenceEnum):
        1. Pronuncia ES -> espera (10s el primer ciclo, 5s el resto)
        2. Pronuncia idioma destino -> espera 3s y vuelve al español (x8)
        3. En el último ciclo, tras el idioma destino espera 20s
           (mostrando ejemplos si hay) y salta a la siguiente palabra
    - Crear ViewDTOs y pasarlos a la Vista
    """

    # Idioma origen del vocabulario (siempre español)
    _SOURCE_LANG_CODE: str = LanguageCodeEnum.ES_ES.value

    # =========================================================================
    # CONSTRUCCIÓN
    # =========================================================================
    def __init__(
        self,
        lang_code: str,  # Idioma destino a reproducir
        tags: list[str],  # Filtros de tags
        group_id: int | None,  # Grupo de palabras
        start_word_id: int,  # Palabra donde retomar (0 = desde el inicio)
        is_random_order: bool,  # Baraja las palabras (sin orden concreto)
        route_on_back: Callable[[], None],  # Navegación (volver al home)
        route_on_edit_word: Callable[[int], None],  # Navegación (editar palabra actual)
    ):
        self._lang_code = lang_code
        self._tags = tags
        self._group_id = group_id
        self._start_word_id = max(0, start_word_id)
        self._is_random_order = is_random_order
        self.__start_index = 0
        self._route_on_back = route_on_back
        self._route_on_edit_word = route_on_edit_word

        # Estado interno de sesión
        self.__session_id: int = 0
        self.__words: list[SliderWordDto] = []
        self.__current_index: int = 0
        self.__is_stopped: bool = False
        self.__is_paused: bool = False
        self.__navigation_request: int | None = (
            None  # índice pedido con anterior/siguiente
        )
        self.__run_token: int = (
            0  # identifica el bucle vigente; invalida bucles/hilos obsoletos
        )

        # Servicios
        self._logger = Logger.get_instance()
        self._audio_player = AudioPlayer.get_instance()
        self._wake_locker = WakeLocker.get_instance()
        self._start_word_slider_session_service = StartWordSliderSessionService.get_instance()
        self._generate_text_audio_ai_service = GenerateTextAudioAiService.get_instance()
        self._generate_notice_audio_ai_service = GenerateNoticeAudioAiService.get_instance()
        self._finish_study_session_service = FinishStudySessionService.get_instance()
        self._reset_word_metrics_service = ResetWordMetricsService.get_instance()
        self._save_activity_state_service = SaveActivityStateService.get_instance()
        self._clear_activity_state_service = ClearActivityStateService.get_instance()
        self._dutch_to_spanish_phonetic_service = DutchToSpanishPhoneticService.get_instance()
        self._word_groups_reader_sqlite_repository = (
            WordGroupsReaderSqliteRepository.get_instance()
        )

        # Vista
        self._ft_container = WordSliderView.from_primitives(
            {
                "on_mount": self._on_mount,
                "on_back": self._on_back_btn_click,
                "on_replay": self._on_replay_click,
                "on_prev": self._on_prev_btn_click,
                "on_next": self._on_next_btn_click,
                "on_toggle_pause": self._on_toggle_pause_click,
                "on_edit_word": self._on_edit_word_click,
                "on_reset_word": self._on_reset_word_click,
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
        """Callback cuando la vista se monta. Inicia la sesión de slider."""
        self._ft_container.page.run_task(self._async_start_session)

    async def _async_start_session(self) -> None:
        """Inicia la sesión cargando palabras del servicio y lanza el slider."""
        self._ft_container.render(WordSliderViewDto.initial())

        try:
            start_dto = StartWordSliderSessionDto.from_primitives(
                {
                    "lang_code": self._lang_code,
                    "tags": self._tags,
                    "group_id": self._group_id,
                    "limit": 1000,  # todas las palabras/imágenes del grupo (tope alto)
                    "is_random_order": self._is_random_order,
                }
            )

            result = await self._start_word_slider_session_service(start_dto)

            self.__session_id = result.session_id
            # result.words son primitivos (list[dict]); rehidratamos a DTO tipado
            self.__words = [SliderWordDto.from_primitives(w) for w in result.words]
            self.__current_index = 0
            self.__is_stopped = False
            self.__is_paused = False
            self.__navigation_request = None
            # Retomar tras editar: localizar la palabra por id (robusto también
            # con orden aleatorio, donde el índice cambia entre sesiones)
            self.__start_index = next(
                (
                    index
                    for index, word in enumerate(self.__words)
                    if word.word_es_id == self._start_word_id
                ),
                0,
            )

            if not self.__words:
                self._ft_container.render(WordSliderViewDto.no_words())
                return

            # Cabecera: etiqueta del grupo («<id> - <título>», en la tarjeta) y su
            # fuente (si no es de migración). Una sola lectura del grupo.
            word_group = await self._get_word_group()
            self._ft_container.render_group_label(self._get_group_label(word_group))
            self._ft_container.render_group_source(self._get_group_source(word_group))

            # El audio se reproduce al volumen actual de la máquina (no se toca
            # el volumen maestro del sistema)
            await self._async_run_slider()

        except Exception as e:
            self._logger.log_error(
                "WordSliderController",
                f"Error iniciando sesión: {e}",
                {
                    "lang_code": self._lang_code,
                    "tags": self._tags,
                    "group_id": self._group_id,
                },
            )
            self._ft_container.render(WordSliderViewDto.error(str(e)))

    async def _async_run_slider(self) -> None:
        """Recorre las palabras reproduciendo cada secuencia; admite saltos prev/next.

        Cada arranque invalida el bucle anterior via _run_token: si por cualquier
        motivo quedara un bucle vivo, se corta solo (evita audios solapados).

        Mientras dura el recorrido se mantiene el wake lock: en Android la CPU
        se dormiría al apagarse la pantalla y la sesión se cortaría.
        """
        self.__run_token += 1
        run_token = self.__run_token

        index = min(self.__start_index, len(self.__words) - 1) if self.__words else 0
        # Retomar solo aplica a la primera pasada (al volver de editar una palabra)
        self.__start_index = 0
        self._keep_cpu_awake()
        try:
            while index < len(self.__words):
                if self._is_run_cancelled(run_token):
                    return
                self.__current_index = index
                await self._async_save_activity_state(self.__words[index], index)
                await self._async_play_word(self.__words[index], run_token)

                if self._is_run_cancelled(run_token):
                    return

                if self.__navigation_request is not None:
                    # Salto pedido con anterior/siguiente (si supera el final, completa)
                    index = min(self.__navigation_request, len(self.__words))
                    self.__navigation_request = None
                else:
                    index += 1

            if not self._is_run_cancelled(run_token):
                await self._async_play_end_notice(run_token)
            # Se recomprueba: el aviso dura unos segundos y pueden haber salido
            if not self._is_run_cancelled(run_token):
                self._show_session_complete()
        finally:
            # Si otro bucle ya tomó el relevo (replay), el wake lock es suyo
            if run_token == self.__run_token:
                self._release_cpu()

    async def _async_play_word(self, word: SliderWordDto, run_token: int) -> None:
        """Reproduce la secuencia temporizada de una palabra (SliderSequenceEnum).

        8 ciclos español -> idioma destino: tras el primer español 10s (tiempo
        para contestar antes de oír el NL), tras el resto 5s; tras el idioma
        destino 3s y vuelta al español. En el último ciclo, la espera tras el
        idioma destino es de 20s mostrando los ejemplos de uso si existen.
        """
        lang_name = self._lang_display_name()
        total_repetitions = SliderSequenceEnum.PAIR_REPETITIONS.value

        for repetition in range(total_repetitions):
            if self._is_run_cancelled(run_token):
                return

            # Español (en el primer ciclo sin revelar aún la traducción y con
            # espera larga para asimilar la palabra)
            self._render_phase(
                word,
                show_translation=repetition > 0,
                phase_label=f"🔊 Español ({repetition + 1}/{total_repetitions})",
            )
            await self._play_text_audio(
                word.text_es, self._SOURCE_LANG_CODE, word.word_es_id, run_token
            )
            es_wait_seconds = (
                SliderSequenceEnum.FIRST_ES_WAIT_SECONDS.value
                if repetition == 0
                else SliderSequenceEnum.ES_TO_LANG_WAIT_SECONDS.value
            )
            if not await self._wait(es_wait_seconds, run_token):
                return

            # Idioma destino
            self._render_phase(
                word,
                show_translation=True,
                phase_label=f"🔊 {lang_name} ({repetition + 1}/{total_repetitions})",
            )
            await self._play_text_audio(
                word.text_lang, self._lang_code, word.word_es_id, run_token
            )

            is_last_repetition = repetition == total_repetitions - 1
            if not is_last_repetition:
                if not await self._wait(
                    SliderSequenceEnum.LANG_TO_ES_WAIT_SECONDS.value, run_token
                ):
                    return
                continue

            # Último ciclo: espera larga mostrando los ejemplos de uso si existen
            if (
                self._is_run_cancelled(run_token)
                or self.__navigation_request is not None
            ):
                return
            if word.examples_lang:
                self._render_phase(
                    word,
                    show_translation=True,
                    phase_label="📚 Ejemplos de uso",
                    show_examples=True,
                )
            if not await self._wait(
                SliderSequenceEnum.NEXT_WORD_WAIT_SECONDS.value, run_token
            ):
                return

    async def _async_finish_session(self) -> None:
        """Finaliza la sesión via servicio."""
        try:
            dto = FinishStudySessionDto.from_primitives(
                {
                    "session_id": self.__session_id,
                    "lang_code": self._lang_code,
                    "study_mode": StudyModeEnum.SLIDER.value,
                }
            )
            await self._finish_study_session_service(dto)
        except Exception as e:
            self._logger.log_error(
                "WordSliderController",
                f"Error finalizando sesión: {e}",
                {"session_id": self.__session_id},
            )

    async def _play_text_audio(
        self, text: str, lang_code: str, word_id: int, run_token: int
    ) -> None:
        """Genera (o reutiliza) y reproduce el audio de un texto."""
        if (
            self._is_run_cancelled(run_token)
            or self.__navigation_request is not None
            or not text
        ):
            return

        try:
            audio_dto = GenerateTextAudioAiDto.from_primitives(
                {
                    "text": text,
                    "lang_code": lang_code,
                    "word_id": word_id,
                }
            )
            result = await self._generate_text_audio_ai_service(audio_dto)

            if not result.success:
                self._logger.log_error(
                    "WordSliderController",
                    f"Error generando audio: {result.error_message}",
                )
                return

            # Puerta de pausa: no arrancar un audio nuevo mientras esté en pausa
            while self.__is_paused:
                if (
                    self._is_run_cancelled(run_token)
                    or self.__navigation_request is not None
                ):
                    return
                await asyncio.sleep(0.2)

            if (
                self._is_run_cancelled(run_token)
                or self.__navigation_request is not None
            ):
                return

            await self._audio_player.play_until_end(
                self._ft_container.page,
                result.audio_path,
                lambda: (
                    self._is_run_cancelled(run_token)
                    or self.__navigation_request is not None
                ),
            )

        except Exception as e:
            self._logger.log_error(
                "WordSliderController",
                f"Error reproduciendo audio: {e}",
                {"text": text, "lang_code": lang_code},
            )

    async def _async_play_end_notice(self, run_token: int) -> None:
        """Pronuncia el aviso de fin tras el último audio de la sesión."""
        try:
            generate_notice_audio_ai_dto = GenerateNoticeAudioAiDto.from_primitives(
                {
                    "notice_key": SessionNoticeEnum.END_OF_SESSION_KEY.value,
                    "text": SessionNoticeEnum.END_OF_SESSION_TEXT.value,
                    "lang_code": self._SOURCE_LANG_CODE,
                }
            )
            result = await self._generate_notice_audio_ai_service(
                generate_notice_audio_ai_dto
            )

            if not result.success:
                self._logger.log_error(
                    "WordSliderController",
                    f"Error generando el aviso de fin: {result.error_message}",
                )
                return

            await self._audio_player.play_until_end(
                self._ft_container.page,
                result.audio_path,
                lambda: self._is_run_cancelled(run_token),
            )

        except Exception as e:
            self._logger.log_error(
                "WordSliderController",
                f"Error reproduciendo el aviso de fin: {e}",
            )

    # (audio: pygame reemplazado por AudioPlayer/ft.Audio — ver _audio_player.play_until_end)

    # =========================================================================
    # EVENT HANDLERS
    # =========================================================================
    def _on_back_btn_click(self) -> None:
        """Detiene el slider, finaliza la sesión y vuelve al home."""
        self.__is_stopped = True
        self.__is_paused = False
        self._stop_audio()
        self._ft_container.page.run_task(self._async_finish_session)
        self._route_on_back()

    def _on_replay_click(self) -> None:
        """Reinicia el slider con las mismas palabras (ignora doble clic)."""
        if not self.__is_stopped:
            return
        self.__is_stopped = False
        self.__is_paused = False
        self.__navigation_request = None
        self.__current_index = 0
        self._ft_container.page.run_task(self._async_run_slider)

    def _on_prev_btn_click(self) -> None:
        """Salta a la palabra anterior (corta la secuencia actual)."""
        self.__navigation_request = max(0, self.__current_index - 1)
        self._resume_if_paused()
        self._stop_audio()

    def _on_next_btn_click(self) -> None:
        """Salta a la palabra siguiente (corta la secuencia actual)."""
        self.__navigation_request = self.__current_index + 1
        self._resume_if_paused()
        self._stop_audio()

    def _on_toggle_pause_click(self) -> None:
        """Pausa/reanuda la reproducción (audio y temporizadores)."""
        self.__is_paused = not self.__is_paused
        if self.__is_paused:
            self._ft_container.page.run_task(self._audio_player.pause)
        else:
            self._ft_container.page.run_task(self._audio_player.resume)

    def _on_edit_word_click(self) -> None:
        """Detiene el slider y navega a editar la palabra actual.

        Al volver de la edición, el slider se retoma en esa misma palabra
        (localizada por id, ver _async_start_session).
        """
        if not self.__words:
            return
        word = self.__words[self.__current_index]
        self.__is_stopped = True
        self.__is_paused = False
        self._stop_audio()
        self._ft_container.page.run_task(self._async_finish_session)
        self._route_on_edit_word(word.word_es_id)

    def _on_reset_word_click(self) -> None:
        """Reinicia el progreso de estudio (SM-2) de la palabra actual.

        La vista ya pidió confirmación; el slider sigue reproduciendo.
        """
        if not self.__words:
            return
        word = self.__words[self.__current_index]
        self._ft_container.page.run_task(self._async_reset_word, word)

    async def _async_reset_word(self, word: SliderWordDto) -> None:
        """Ejecuta el reinicio via servicio y avisa del resultado en un snackbar."""
        try:
            reset_dto = ResetWordMetricsDto.from_primitives(
                {
                    "word_es_id": word.word_es_id,
                    "lang_code": self._lang_code,
                }
            )
            result = await self._reset_word_metrics_service(reset_dto)
            message = (
                f"Progreso reiniciado: {word.text_es}"
                if result.is_reset
                else f"La palabra ya estaba como nueva: {word.text_es}"
            )
            self._show_snackbar(message, ft.Colors.GREEN_700)
        except Exception as e:
            self._logger.log_error(
                "WordSliderController",
                f"Error reiniciando palabra: {e}",
                {"word_es_id": word.word_es_id, "lang_code": self._lang_code},
            )
            self._show_snackbar("No se pudo reiniciar la palabra", ft.Colors.RED_700)

    def _show_snackbar(self, message: str, bgcolor: str) -> None:
        """Muestra un aviso flotante sin interrumpir la reproducción."""
        snackbar = ft.SnackBar(content=ft.Text(message), bgcolor=bgcolor, open=True)
        self._ft_container.page.overlay.append(snackbar)
        self._ft_container.page.update()

    # =========================================================================
    # HELPERS PRIVADOS
    # =========================================================================
    async def _wait(self, seconds: int, run_token: int) -> bool:
        """Espera en tramos de 1s para poder abortar pronto.

        Respeta la pausa (no consume tiempo) y devuelve False si se detuvo,
        si el bucle quedó obsoleto o si hay un salto anterior/siguiente pendiente.
        """
        elapsed_seconds = 0
        while elapsed_seconds < seconds:
            if (
                self._is_run_cancelled(run_token)
                or self.__navigation_request is not None
            ):
                return False
            if self.__is_paused:
                await asyncio.sleep(0.2)
                continue
            await asyncio.sleep(1)
            elapsed_seconds += 1
        return (
            not self._is_run_cancelled(run_token) and self.__navigation_request is None
        )

    def _is_run_cancelled(self, run_token: int) -> bool:
        """True si el slider se detuvo o este bucle quedó obsoleto (otro arrancó)."""
        return self.__is_stopped or run_token != self.__run_token

    async def _get_word_group(self) -> dict:
        """Grupo de la sesión; diccionario vacío si la sesión no va por grupo."""
        if self._group_id is None:
            return {}
        word_group = (
            await self._word_groups_reader_sqlite_repository.get_word_group_by_group_id(
                self._group_id
            )
        )
        return word_group or {}

    def _get_group_label(self, word_group: dict) -> str:
        """Etiqueta del grupo que se está repasando: «<id> - <título>»."""
        group_title = (word_group.get("title") or "").strip()
        if not group_title:
            return ""
        return f"{word_group.get('id', '')} - {group_title}"

    def _get_group_source(self, word_group: dict) -> str:
        """Fuente del grupo de la sesión; vacía si no hay o si es de migración."""
        group_source = (word_group.get("source") or "").strip()
        if group_source.lower() in ("migracion", "migration", "mig"):
            return ""
        return group_source

    def _resume_if_paused(self) -> None:
        """Sale del estado de pausa (al navegar con anterior/siguiente)."""
        if self.__is_paused:
            self.__is_paused = False

    def _render_phase(
        self,
        word: SliderWordDto,
        show_translation: bool,
        phase_label: str,
        show_examples: bool = False,
    ) -> None:
        """Renderiza la palabra actual en una fase concreta (si no se detuvo)."""
        if self.__is_stopped:
            return
        self._ft_container.render(
            WordSliderViewDto.sliding(
                session_id=self.__session_id,
                lang_code=self._lang_code,
                total_words=len(self.__words),
                current_index=self.__current_index,
                current_word={
                    "word_es_id": word.word_es_id,
                    "text_es": word.text_es,
                    "text_lang": word.text_lang,
                    "pronunciation": self._pronunciation_for(word),
                    "image_file_path": word.image_file_path,
                    "examples": word.examples_lang,
                    "rules_help": word.rules_help,
                },
                phase_label=phase_label,
                show_translation=show_translation,
                show_examples=show_examples,
            )
        )

    def _show_session_complete(self) -> None:
        """Muestra pantalla de sesión completada y finaliza via servicio."""
        self.__is_stopped = True
        self._ft_container.page.run_task(self._async_finish_session)
        self._ft_container.page.run_task(self._async_clear_activity_state)
        self._ft_container.render(
            WordSliderViewDto.session_complete(
                total_words=len(self.__words),
            )
        )

    async def _async_save_activity_state(self, word: SliderWordDto, index: int) -> None:
        """Guarda el punto actual para poder retomarlo desde el Home (best-effort)."""
        try:
            await self._save_activity_state_service(
                SaveActivityStateDto.from_primitives(
                    {
                        "activity": ActivityEnum.WORD_SLIDER.value,
                        "lang_code": self._lang_code,
                        "tags": self._tags,
                        "group_id": self._group_id,
                        "word_es_id": word.word_es_id,
                        "word_index": index,
                        "total_words": len(self.__words),
                        "is_random_order": self._is_random_order,
                    }
                )
            )
        except Exception as e:
            self._logger.log_error(
                "WordSliderController",
                f"Error guardando estado de actividad: {e}",
                {"word_es_id": word.word_es_id},
            )

    async def _async_clear_activity_state(self) -> None:
        """Borra el estado guardado: la sesión terminó, no hay nada que retomar."""
        try:
            await self._clear_activity_state_service(
                ClearActivityStateDto.from_primitives(
                    {
                        "activity": ActivityEnum.WORD_SLIDER.value,
                    }
                )
            )
        except Exception as e:
            self._logger.log_error(
                "WordSliderController",
                f"Error borrando estado de actividad: {e}",
            )

    def _lang_display_name(self) -> str:
        """Nombre del idioma destino para las etiquetas de fase."""
        try:
            return LanguageCodeEnum(self._lang_code).display_name
        except ValueError:
            return self._lang_code

    def _pronunciation_for(self, word: SliderWordDto) -> str:
        """Pronunciación (gris): para neerlandés, aproximación leíble en español."""
        is_dutch = self._lang_code in (
            LanguageCodeEnum.NL_NL.value,
            LanguageCodeEnum.NL_BE.value,
        )
        if is_dutch:
            return self._dutch_to_spanish_phonetic_service.transcribe(word.text_lang)
        return word.pronunciation

    def _stop_audio(self) -> None:
        """Detiene cualquier audio en reproducción (best-effort)."""
        self._ft_container.page.run_task(self._audio_player.stop)

    def _keep_cpu_awake(self) -> None:
        """Impide que Android duerma la CPU al apagarse la pantalla (best-effort).

        Sin esto la sesión se corta al bloquear la tablet. En escritorio no hace
        nada (el componente sale solo si no hay Activity de Android).
        """
        try:
            self._wake_locker.acquire()
        except Exception as e:
            self._logger.log_error(
                "WordSliderController",
                f"No se pudo mantener la CPU despierta: {e}",
            )

    def _release_cpu(self) -> None:
        """Suelta el wake lock al acabar la sesión (best-effort)."""
        try:
            self._wake_locker.release()
        except Exception as e:
            self._logger.log_error(
                "WordSliderController",
                f"No se pudo soltar el wake lock: {e}",
            )
