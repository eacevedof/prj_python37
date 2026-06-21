"""Componente: ajusta el volumen maestro del sistema (Windows Core Audio)."""

import sys
from typing import final, Self


@final
class Volumer:
    """Sube/ajusta el volumen maestro de Windows vía pycaw.

    Wrapper sobre la Core Audio API de Windows. En plataformas no-Windows
    no realiza ninguna acción. Cualquier error (pycaw/comtypes ausente, fallo
    COM, etc.) se propaga al llamante: el componente no captura ni registra.
    """

    _instance: "Volumer | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def set_to_max(self) -> None:
        """Sube el volumen maestro del sistema al máximo (100%)."""
        self._set_scalar(1.0)

    def _set_scalar(self, level: float) -> None:
        """Fija el volumen maestro (0.0-1.0) y desactiva el mute."""
        if sys.platform != "win32":
            return

        clamped_level = max(0.0, min(1.0, level))

        from comtypes import CoInitialize, CoUninitialize
        from pycaw.pycaw import AudioUtilities

        # COM debe inicializarse en el hilo que llama (se invoca en thread aparte)
        CoInitialize()
        try:
            endpoint_volume = AudioUtilities.GetSpeakers().EndpointVolume
            endpoint_volume.SetMute(0, None)
            endpoint_volume.SetMasterVolumeLevelScalar(clamped_level, None)

        # finally (NO try/except): no capturamos el error, solo garantizamos la
        # limpieza. CoInitialize/CoUninitialize llevan conteo de referencias por hilo
        # y deben ir balanceados; si una llamada COM falla, el finally cierra el par
        # y la excepción propaga intacta al controlador (regla DDD: el componente no
        # captura ni registra; los errores de infra escalan).
        finally:
            CoUninitialize()


