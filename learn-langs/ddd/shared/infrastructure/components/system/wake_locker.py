"""Componente: mantiene viva la CPU de Android con la pantalla apagada."""

import os
from typing import Any, Self, final

from ddd.shared.domain.enums.android_wake_lock_enum import AndroidWakeLockEnum


@final
class WakeLocker:
    """PARTIAL_WAKE_LOCK de Android (via pyjnius). En escritorio es un no-op.

    Al apagarse la pantalla Android duerme la CPU: el reproductor se calla y el
    bucle asíncrono de la sesión deja de programar el audio siguiente. El wake
    lock parcial mantiene la CPU viva SIN encender la pantalla (encenderla es
    cosa de `Awaker`, y solo en Windows), que es lo que permite seguir oyendo
    la sesión con la tablet bloqueada.

    Necesita el permiso `android.permission.WAKE_LOCK` y la dependencia
    `pyjnius`, declarados en `[tool.flet.android]` de `pyproject.toml`. Fuera de
    Android no hay Activity que pedir (la variable de entorno no existe) y
    todos los métodos salen sin hacer nada.
    """

    _ACTIVITY_HOST_CLASS_ENV: str = AndroidWakeLockEnum.ACTIVITY_HOST_CLASS_ENV.value
    _CONTEXT_CLASS: str = AndroidWakeLockEnum.CONTEXT_CLASS.value
    _POWER_MANAGER_CLASS: str = AndroidWakeLockEnum.POWER_MANAGER_CLASS.value
    _LOCK_TAG: str = AndroidWakeLockEnum.LOCK_TAG.value

    __instance: "WakeLocker | None" = None

    def __init__(self) -> None:
        # El WakeLock de Java vive aquí entre acquire() y release().
        self._wake_lock: Any | None = None

    @classmethod
    def get_instance(cls) -> Self:
        if cls.__instance is None:
            cls.__instance = cls()
        return cls.__instance

    def acquire(self) -> None:
        """Coge el wake lock parcial (idempotente). Fuera de Android, no-op."""
        if self._wake_lock is not None:
            return

        activity_host_class_name = os.getenv(self._ACTIVITY_HOST_CLASS_ENV, "")
        if not activity_host_class_name:
            return

        from jnius import autoclass, cast

        activity = autoclass(activity_host_class_name).mActivity
        context_class = autoclass(self._CONTEXT_CLASS)
        power_manager_class = autoclass(self._POWER_MANAGER_CLASS)
        # getSystemService devuelve java.lang.Object: sin el cast, pyjnius no
        # encuentra newWakeLock.
        power_manager = cast(
            self._POWER_MANAGER_CLASS,
            activity.getSystemService(context_class.POWER_SERVICE),
        )

        wake_lock = power_manager.newWakeLock(
            power_manager_class.PARTIAL_WAKE_LOCK, self._LOCK_TAG
        )
        # Sin contador de referencias: un release() suelta siempre el lock.
        wake_lock.setReferenceCounted(False)
        wake_lock.acquire()
        self._wake_lock = wake_lock

    def release(self) -> None:
        """Suelta el wake lock si lo tenía cogido (idempotente)."""
        wake_lock = self._wake_lock
        if wake_lock is None:
            return
        self._wake_lock = None
        if wake_lock.isHeld():
            wake_lock.release()
