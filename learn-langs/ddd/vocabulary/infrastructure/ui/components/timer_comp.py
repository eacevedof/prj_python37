"""Componente de timer para sesiones de estudio."""

import asyncio
import flet as ft
from typing import Callable


class TimerComp(ft.Container):
    """Componente que muestra un timer countdown."""

    def __init__(
        self,
        seconds: int = 30,
        on_timeout: Callable[[], None] | None = None,
        auto_start: bool = False,
    ):
        super().__init__()
        self.total_seconds = seconds
        self.remaining_seconds = seconds
        self.on_timeout = on_timeout
        self.auto_start = auto_start
        self.is_running = False
        self._timer_text: ft.Text | None = None
        self._progress: ft.ProgressRing | None = None

        self._build_ui()

    def _build_ui(self) -> None:
        self._timer_text = ft.Text(
            self._format_time(self.remaining_seconds),
            size=24,
            weight=ft.FontWeight.BOLD,
            color=ft.Colors.BLUE_700,
        )

        self._progress = ft.ProgressRing(
            value=1.0,
            width=60,
            height=60,
            stroke_width=4,
            color=ft.Colors.BLUE_700,
        )

        self.content = ft.Stack(
            controls=[
                self._progress,
                ft.Container(
                    content=self._timer_text,
                    alignment=ft.Alignment.CENTER,
                    width=60,
                    height=60,
                ),
            ],
            width=60,
            height=60,
        )
        self.width = 60
        self.height = 60

    def did_mount(self) -> None:
        if self.auto_start:
            self.start()

    def _format_time(self, seconds: int) -> str:
        """Formatea segundos a MM:SS."""
        mins = seconds // 60
        secs = seconds % 60
        return f"{mins}:{secs:02d}"

    def start(self) -> None:
        """Inicia el timer."""
        if self.is_running:
            return
        self.is_running = True
        self._tick()

    def stop(self) -> None:
        """Detiene el timer."""
        self.is_running = False

    def reset(self, seconds: int | None = None) -> None:
        """Reinicia el timer."""
        self.stop()
        if seconds is not None:
            self.total_seconds = seconds
        self.remaining_seconds = self.total_seconds
        self._update_display()

    def _tick(self) -> None:
        """Actualiza el timer cada segundo."""
        if not self.is_running:
            return

        if self.remaining_seconds > 0:
            self.remaining_seconds -= 1
            self._update_display()
            self.page.run_task(self._schedule_tick)
        else:
            self.is_running = False
            if self.on_timeout:
                self.on_timeout()

    async def _schedule_tick(self) -> None:
        """Programa el siguiente tick."""
        await asyncio.sleep(1)
        if self.is_running:
            self._tick()

    def _update_display(self) -> None:
        """Actualiza la visualizacion del timer."""
        if self._timer_text:
            self._timer_text.value = self._format_time(self.remaining_seconds)

            # Cambiar color segun tiempo restante
            if self.remaining_seconds <= 5:
                self._timer_text.color = ft.Colors.RED_700
                if self._progress:
                    self._progress.color = ft.Colors.RED_700
            elif self.remaining_seconds <= 10:
                self._timer_text.color = ft.Colors.ORANGE_700
                if self._progress:
                    self._progress.color = ft.Colors.ORANGE_700
            else:
                self._timer_text.color = ft.Colors.BLUE_700
                if self._progress:
                    self._progress.color = ft.Colors.BLUE_700

        if self._progress:
            self._progress.value = self.remaining_seconds / self.total_seconds

        self.update()
