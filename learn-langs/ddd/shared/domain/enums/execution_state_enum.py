"""Flags de SetThreadExecutionState (Windows API) para evitar la suspensión."""

from enum import IntEnum


class ExecutionStateEnum(IntEnum):
    """Valores de la API de Windows kernel32.SetThreadExecutionState."""

    CONTINUOUS = 0x80000000
    SYSTEM_REQUIRED = 0x00000001
    DISPLAY_REQUIRED = 0x00000002
