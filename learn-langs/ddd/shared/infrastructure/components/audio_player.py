"""Componente reproductor de audio multiplataforma (envuelve flet_audio.Audio).

Sustituye a pygame (que NO existe en el runtime Android de Flet). El control Audio
de Flet funciona en Windows y Android; `src` acepta una ruta local o una URL (CDN),
asi que el mismo reproductor sirve para el fichero local o resources.theframework.es.

Patron fiable (segun la propia libreria flet_audio): el `src` va en el CONSTRUCTOR
y se usa `autoplay=True`. Asi NO dependemos de propagar un cambio de `src` a un Audio
ya montado (no llegaba al backend -> "Null is not a supported source type") ni del
invoke `play()` (que se colgaba -> TimeoutException). Se crea un Audio nuevo por
reproduccion y se retira de la pagina al terminar o parar. `play_until_end` espera al
final del audio (evento COMPLETED) o a que should_stop() pida parar.
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
        self._completed = asyncio.Event()
        self._page: ft.Page | None = None
        self._current_audio: fta.Audio | None = None

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def play_until_end(
        self,
        page: ft.Page,
        src: str,
        should_stop: Callable[[], bool],
    ) -> None:
        """Reproduce src (autoplay) y espera a que termine o a que should_stop() sea True."""
        self._page = page
        self._detach_current()
        self._completed.clear()

        audio = fta.Audio(src=src, autoplay=True, on_state_change=self._on_state_change)
        self._current_audio = audio
        page.services.append(audio)
        page.update()  # autoplay arranca al anadirse (el src ya viene en el constructor)

        while not self._completed.is_set():
            if should_stop():
                self._detach_current()
                return
            await asyncio.sleep(self._POLL_SECONDS)
        self._detach_current()

    async def pause(self) -> None:
        if self._current_audio is not None:
            await self._current_audio.pause()

    async def resume(self) -> None:
        if self._current_audio is not None:
            await self._current_audio.resume()

    async def stop(self) -> None:
        """Para la reproduccion actual retirando el control de la pagina."""
        self._completed.set()
        self._detach_current()

    def _detach_current(self) -> None:
        """Retira el Audio actual de la pagina (para y limpia la reproduccion)."""
        if self._current_audio is not None and self._page is not None:
            if self._current_audio in self._page.services:
                self._page.services.remove(self._current_audio)
                self._page.update()
        self._current_audio = None

    def _on_state_change(self, event: object) -> None:
        state = getattr(event, "state", None) or getattr(event, "data", None)
        if state == AudioState.COMPLETED or str(state).lower().endswith("completed"):
            self._completed.set()
