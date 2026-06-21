"""Controller para el Word Slider (presentación auto-reproducida con audio)."""

import asyncio
from pathlib import Path
from typing import Callable

import flet as ft
import pygame

from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.components.system.volumer import Volumer
from ddd.shared.infrastructure.controllers import BaseController
from ddd.vocabulary.application.finish_study_session import (
    FinishStudySessionDto,
    FinishStudySessionService,
)
from ddd.vocabulary.application.generate_text_audio_ai import (
    GenerateTextAudioAiDto,
    GenerateTextAudioAiService,
)
from ddd.vocabulary.application.start_word_slider_session import (
    StartWordSliderSessionDto,
    StartWordSliderSessionService,
    SliderWordDto,
)
from ddd.vocabulary.domain.enums import LanguageCodeEnum, StudyModeEnum
from ddd.vocabulary.infrastructure.ui.views.word_slider_view import WordSliderView
from ddd.vocabulary.infrastructure.ui.views.word_slider_view_dto import WordSliderViewDto


class WordSliderController(BaseController):
    """
    Controller del Word Slider.

    Responsabilidades:
    - Orquestar el flujo temporizado entre Vista y Servicios
    - Reproducir la secuencia de audio por palabra:
        1. Pronuncia ES -> espera 10s
        2. Pronuncia idioma destino -> espera 8s (x3)
        3. Pronuncia ES + idioma destino (refuerzo final)
        4. Salta a la siguiente palabra
    - Crear ViewDTOs y pasarlos a la Vista
    """

    # Idioma origen del vocabulario (siempre español)
    _SOURCE_LANG_CODE: str = LanguageCodeEnum.ES_ES.value

    # Tiempos de la secuencia (segundos)
    _ES_WAIT_SECONDS = 10
    _LANG_WAIT_SECONDS = 8
    _LANG_REPETITIONS = 3
    _FINAL_PAUSE_SECONDS = 2

    # =========================================================================
    # CONSTRUCCIÓN
    # =========================================================================
    def __init__(
        self,
        lang_code: str,                      # Idioma destino a reproducir
        tags: list[str],                     # Filtros de tags
        group_id: int | None,                # Grupo de palabras
        route_on_back: Callable[[], None],  # Navegación (volver al home)
    ):
        self._lang_code = lang_code
        self._tags = tags
        self._group_id = group_id
        self._route_on_back = route_on_back

        # Estado interno de sesión
        self._session_id: int = 0
        self._words: list[SliderWordDto] = []
        self._current_index: int = 0
        self._is_stopped: bool = False

        # Servicios
        self._logger = Logger.get_instance()
        self._volumer = Volumer.get_instance()
        self._start_session_service = StartWordSliderSessionService.get_instance()
        self._generate_audio_service = GenerateTextAudioAiService.get_instance()
        self._finish_session_service = FinishStudySessionService.get_instance()

        # Vista
        self._ft_container = WordSliderView.from_primitives({
            "on_mount": self._on_mount,
            "on_back": self._on_back_btn_click,
            "on_replay": self._on_replay_click,
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
        """Callback cuando la vista se monta. Inicia la sesión de slider."""
        self._ft_container.page.run_task(self._async_start_session)

    async def _async_start_session(self) -> None:
        """Inicia la sesión cargando palabras del servicio y lanza el slider."""
        self._ft_container.render(WordSliderViewDto.initial())

        try:
            start_dto = StartWordSliderSessionDto.from_primitives({
                "lang_code": self._lang_code,
                "tags": self._tags,
                "group_id": self._group_id,
                "limit": 20,
            })

            result = await self._start_session_service(start_dto)

            self._session_id = result.session_id
            self._words = list(result.words)
            self._current_index = 0
            self._is_stopped = False

            if not self._words:
                self._ft_container.render(WordSliderViewDto.no_words())
                return

            # Sincronizar con el equipo: volumen maestro del sistema al máximo (best-effort)
            try:
                await asyncio.to_thread(self._volumer.set_to_max)
            except Exception as e:
                self._logger.log_error(
                    "WordSliderController",
                    f"No se pudo ajustar el volumen del sistema: {e}",
                )

            await self._async_run_slider()

        except Exception as e:
            self._logger.log_error(
                "WordSliderController",
                f"Error iniciando sesión: {e}",
                {"lang_code": self._lang_code, "tags": self._tags, "group_id": self._group_id},
            )
            self._ft_container.render(WordSliderViewDto.error(str(e)))

    async def _async_run_slider(self) -> None:
        """Recorre todas las palabras reproduciendo la secuencia de cada una."""
        for index in range(len(self._words)):
            if self._is_stopped:
                return
            self._current_index = index
            await self._async_play_word(self._words[index])

        if not self._is_stopped:
            self._show_session_complete()

    async def _async_play_word(self, word: SliderWordDto) -> None:
        """Reproduce la secuencia temporizada de una palabra."""
        lang_name = self._lang_display_name()

        # Fase 1: Español -> espera 10s
        self._render_phase(word, show_translation=False, phase_label="🔊 Español")
        await self._play_text_audio(word.text_es, self._SOURCE_LANG_CODE, f"es_{word.word_es_id}")
        if not await self._wait(self._ES_WAIT_SECONDS):
            return

        # Fase 2: Idioma destino -> espera 8s (x3)
        for repetition in range(self._LANG_REPETITIONS):
            if self._is_stopped:
                return
            self._render_phase(
                word,
                show_translation=True,
                phase_label=f"🔊 {lang_name} ({repetition + 1}/{self._LANG_REPETITIONS})",
            )
            await self._play_text_audio(
                word.text_lang, self._lang_code, f"{self._lang_code}_{word.word_es_id}"
            )
            if not await self._wait(self._LANG_WAIT_SECONDS):
                return

        # Fase 3: Español + idioma destino (refuerzo final)
        self._render_phase(
            word, show_translation=True, phase_label=f"🔊 Español + {lang_name}"
        )
        await self._play_text_audio(word.text_es, self._SOURCE_LANG_CODE, f"es_{word.word_es_id}")
        if self._is_stopped:
            return
        await self._play_text_audio(
            word.text_lang, self._lang_code, f"{self._lang_code}_{word.word_es_id}"
        )
        await self._wait(self._FINAL_PAUSE_SECONDS)

    async def _async_finish_session(self) -> None:
        """Finaliza la sesión via servicio."""
        try:
            dto = FinishStudySessionDto.from_primitives({
                "session_id": self._session_id,
                "lang_code": self._lang_code,
                "study_mode": StudyModeEnum.SLIDER.value,
            })
            await self._finish_session_service(dto)
        except Exception as e:
            self._logger.log_error(
                "WordSliderController",
                f"Error finalizando sesión: {e}",
                {"session_id": self._session_id},
            )

    async def _play_text_audio(self, text: str, lang_code: str, cache_key: str) -> None:
        """Genera (o reutiliza) y reproduce el audio de un texto."""
        if self._is_stopped or not text:
            return

        try:
            audio_dto = GenerateTextAudioAiDto.from_primitives({
                "text": text,
                "lang_code": lang_code,
                "cache_key": cache_key,
            })
            result = await self._generate_audio_service(audio_dto)

            if not result.success:
                self._logger.log_error(
                    "WordSliderController",
                    f"Error generando audio: {result.error_message}",
                )
                return

            if self._is_stopped:
                return

            await asyncio.to_thread(self._play_audio_file, result.audio_path)

        except Exception as e:
            self._logger.log_error(
                "WordSliderController",
                f"Error reproduciendo audio: {e}",
                {"text": text, "lang_code": lang_code},
            )

    @staticmethod
    def _play_audio_file(audio_path: str) -> None:
        """Reproduce un mp3 de forma sincrónica usando pygame (en thread aparte)."""
        try:
            if not pygame.mixer.get_init():
                pygame.mixer.init()

            # Volumen al máximo por defecto (para escuchar a distancia)
            pygame.mixer.music.set_volume(1.0)

            pygame.mixer.music.load(str(Path(audio_path).resolve()))
            pygame.mixer.music.play()

            while pygame.mixer.music.get_busy():
                pygame.time.Clock().tick(10)

            # Liberar el archivo para que pueda reutilizarse/sobrescribirse
            pygame.mixer.music.unload()
        except Exception as e:
            raise Exception(f"Error reproduciendo audio con pygame: {e}")

    # =========================================================================
    # EVENT HANDLERS
    # =========================================================================
    def _on_back_btn_click(self) -> None:
        """Detiene el slider, finaliza la sesión y vuelve al home."""
        self._is_stopped = True
        self._stop_audio()
        self._ft_container.page.run_task(self._async_finish_session)
        self._route_on_back()

    def _on_replay_click(self) -> None:
        """Reinicia el slider con las mismas palabras."""
        self._is_stopped = False
        self._current_index = 0
        self._ft_container.page.run_task(self._async_run_slider)

    # =========================================================================
    # HELPERS PRIVADOS
    # =========================================================================
    async def _wait(self, seconds: int) -> bool:
        """Espera en tramos de 1s para poder abortar pronto. False si se detuvo."""
        for _ in range(seconds):
            if self._is_stopped:
                return False
            await asyncio.sleep(1)
        return not self._is_stopped

    def _render_phase(
        self,
        word: SliderWordDto,
        show_translation: bool,
        phase_label: str,
    ) -> None:
        """Renderiza la palabra actual en una fase concreta (si no se detuvo)."""
        if self._is_stopped:
            return
        self._ft_container.render(WordSliderViewDto.sliding(
            session_id=self._session_id,
            lang_code=self._lang_code,
            total_words=len(self._words),
            current_index=self._current_index,
            current_word={
                "text_es": word.text_es,
                "text_lang": word.text_lang,
                "pronunciation": word.pronunciation,
                "image_file_path": word.image_file_path,
            },
            phase_label=phase_label,
            show_translation=show_translation,
        ))

    def _show_session_complete(self) -> None:
        """Muestra pantalla de sesión completada y finaliza via servicio."""
        self._is_stopped = True
        self._ft_container.page.run_task(self._async_finish_session)
        self._ft_container.render(WordSliderViewDto.session_complete(
            total_words=len(self._words),
        ))

    def _lang_display_name(self) -> str:
        """Nombre del idioma destino para las etiquetas de fase."""
        try:
            return LanguageCodeEnum(self._lang_code).display_name
        except ValueError:
            return self._lang_code

    @staticmethod
    def _stop_audio() -> None:
        """Detiene cualquier audio en reproducción (best-effort)."""
        try:
            if pygame.mixer.get_init():
                pygame.mixer.music.stop()
        except Exception:
            pass
