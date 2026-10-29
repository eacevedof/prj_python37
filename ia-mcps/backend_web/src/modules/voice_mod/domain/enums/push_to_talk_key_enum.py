from enum import IntEnum
from typing import final


@final
class PushToTalkKeyEnum(IntEnum):
    """Tecla de *push-to-talk*: Ctrl+Alt+Espacio, pulsada mientras se habla.

    Códigos virtual-key de Win32. La combinación no la usan Windows, Windows
    Terminal ni Claude Code; en teclado español Ctrl+Alt es AltGr, y AltGr+Espacio
    solo escribe un espacio. Cambiar de tecla = cambiar estos valores.
    """

    TRIGGER = 0x20  # VK_SPACE
    LEFT_CONTROL = 0xA2
    RIGHT_CONTROL = 0xA3
    LEFT_ALT = 0xA4
    RIGHT_ALT = 0xA5
    # Tecla sin asignar que se inyecta al tragarse la combinación, para que al
    # soltar Alt la ventana activa no abra su menú (el truco de AutoHotkey).
    MASK = 0xE8
