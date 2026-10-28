"""Componente: mantiene el equipo despierto (sin suspensión) mientras está activo."""

import ctypes
import sys
from typing import final, Self

from ddd.shared.domain.enums.execution_state_enum import ExecutionStateEnum


@final
class Awaker:
    """Evita la suspensión del sistema y el apagado de pantalla (Windows).

    Wrapper de SetThreadExecutionState. El estado ES_CONTINUOUS pertenece al
    hilo que lo pide: activar y restaurar deben ejecutarse en el MISMO hilo
    (en Flet, dentro de tareas async del event loop). En otros SO es un no-op.
    """

    _ES_CONTINUOUS: int = ExecutionStateEnum.CONTINUOUS.value
    _ES_SYSTEM_REQUIRED: int = ExecutionStateEnum.SYSTEM_REQUIRED.value
    _ES_DISPLAY_REQUIRED: int = ExecutionStateEnum.DISPLAY_REQUIRED.value

    __instance: "Awaker | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        if cls.__instance is None:
            cls.__instance = cls()
        return cls.__instance

    def keep_awake(self) -> None:
        """Activa el modo sin suspensión (sistema + pantalla encendida)."""
        if sys.platform != "win32":
            return
        ctypes.windll.kernel32.SetThreadExecutionState(
            self._ES_CONTINUOUS | self._ES_SYSTEM_REQUIRED | self._ES_DISPLAY_REQUIRED
        )

    def restore(self) -> None:
        """Restaura el comportamiento normal de energía del sistema."""
        if sys.platform != "win32":
            return
        ctypes.windll.kernel32.SetThreadExecutionState(self._ES_CONTINUOUS)
