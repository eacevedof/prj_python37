"""Componente reproductor de audio multiplataforma (envuelve flet_audio.Audio).

Sustituye a pygame (que NO existe en el runtime Android de Flet). El control Audio
de Flet funciona en Windows y Android; `src` acepta una ruta local o una URL (CDN),
asi que el mismo reproductor sirve para el fichero local o para
resources.theframework.es. El control (un Service) se monta una vez en page.services.

La reproduccion es asincrona; `play_until_end` espera al final del audio o a que el
llamante pida parar (should_stop) — replica el bucle bloqueante que tenia pygame,
pero sobre el loop asyncio (sin hilo aparte).
"""

import asyncio
from typing import Callable, Self, final

import flet as ft
import flet_audio as fta
from flet_audio.types import AudioState


@final
class AudioPlayer:
    """Reproduce mp3 (local o URL) con el Audio nativo de Flet. Multiplataforma."""

    _POLL_SECONDS: float = 0.05

    def __init__(self) -> None:
        self._audio = fta.Audio(on_state_changed=self._on_state_changed)
        self._completed = asyncio.Event()
        self._is_mounted = False

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def play_until_end(
        self,
        page: ft.Page,
        src: str,
        should_stop: Callable[[], bool],
    ) -> None:
        """Reproduce src y espera a que termine, o a que should_stop() sea True."""
        self._mount(page)
        self._audio.src = src
        self._completed.clear()
        await self._audio.play()
        while not self._completed.is_set():
            if should_stop():
                await self._audio.pause()
                return
            await asyncio.sleep(self._POLL_SECONDS)

    async def pause(self) -> None:
        if self._is_mounted:
            await self._audio.pause()

    async def resume(self) -> None:
        if self._is_mounted:
            await self._audio.resume()

    async def stop(self) -> None:
        """Para y libera el fichero (necesario para renombrar/borrar el mp3)."""
        self._completed.set()
        if self._is_mounted:
            await self._audio.release()

    def _mount(self, page: ft.Page) -> None:
        """Monta el control Audio en la pagina (idempotente)."""
        if self._is_mounted:
            return
        page.services.append(self._audio)
        page.update()
        self._is_mounted = True

    def _on_state_changed(self, event: object) -> None:
        state = getattr(event, "state", None) or getattr(event, "data", None)
        if state == AudioState.COMPLETED or str(state).lower().endswith("completed"):
            self._completed.set()
