"""Piezas del wake lock de Android (variable de entorno y clases Java)."""

from enum import Enum


class AndroidWakeLockEnum(str, Enum):
    """Constantes para pedir el PARTIAL_WAKE_LOCK a Android via pyjnius.

    ACTIVITY_HOST_CLASS_ENV la publica el runtime Android de Flet
    (serious_python) con el nombre de la clase que guarda la Activity
    (`mActivity`); que NO exista es la señal de que no estamos en Android.
    """

    ACTIVITY_HOST_CLASS_ENV = "MAIN_ACTIVITY_HOST_CLASS_NAME"
    CONTEXT_CLASS = "android.content.Context"
    POWER_MANAGER_CLASS = "android.os.PowerManager"
    LOCK_TAG = "learn-langs:study-session"
