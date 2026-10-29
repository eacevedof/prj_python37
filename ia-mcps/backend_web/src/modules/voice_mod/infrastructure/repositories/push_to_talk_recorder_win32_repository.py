import ctypes
import sys
import time
from ctypes import wintypes
from typing import Any, Self, final

import numpy as np
from numpy.typing import NDArray

from src.modules.voice_mod.domain.enums import PushToTalkKeyEnum
from src.modules.voice_mod.domain.exceptions.voice_exception import VoiceException

_WH_KEYBOARD_LL = 13
_HC_ACTION = 0
_WM_KEYDOWN = 0x0100
_WM_SYSKEYDOWN = 0x0104
_PM_REMOVE = 0x0001
_KEYEVENTF_KEYUP = 0x0002
_PUMP_INTERVAL_SECONDS = 0.01
_CONTROL_KEYS = (PushToTalkKeyEnum.LEFT_CONTROL, PushToTalkKeyEnum.RIGHT_CONTROL)
_ALT_KEYS = (PushToTalkKeyEnum.LEFT_ALT, PushToTalkKeyEnum.RIGHT_ALT)


class _KeyboardEventStruct(ctypes.Structure):
    _fields_ = [
        ("vkCode", wintypes.DWORD),
        ("scanCode", wintypes.DWORD),
        ("flags", wintypes.DWORD),
        ("time", wintypes.DWORD),
        ("dwExtraInfo", ctypes.c_size_t),
    ]


@final
class PushToTalkRecorderWin32Repository:
    """Graba el micro mientras se mantiene pulsada la tecla de *push-to-talk*.

    Datasources: un hook de teclado de bajo nivel de Win32 (`WH_KEYBOARD_LL`, por
    ctypes, sin dependencias) para ver la tecla aunque la ventana activa sea otra,
    y `sounddevice` para el micro. La combinación se traga mientras escucha: no
    llega a la terminal. Solo Windows.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_samples_while_key_held(
        self, wait_seconds: int, max_record_seconds: int, sample_rate: int
    ) -> NDArray[np.float32]:
        """Espera a la tecla, graba mientras está pulsada y devuelve audio mono float32.

        Devuelve un array vacío si nadie pulsa la tecla en `wait_seconds`.

        Raises:
            VoiceException: si la máquina no es Windows o no hay micro.
        """
        if sys.platform != "win32":
            VoiceException.unexpected_custom("push-to-talk is only supported on Windows for now")

        import sounddevice  # type: ignore[import-untyped]

        key_state = {"control": False, "alt": False, "pressed": False, "released": False}
        recorded_chunks: list[NDArray[np.float32]] = []

        def on_keyboard_event(n_code: int, w_param: int, l_param: int) -> int:
            if n_code != _HC_ACTION:
                return int(user32.CallNextHookEx(None, n_code, w_param, l_param))
            keyboard_event = ctypes.cast(l_param, ctypes.POINTER(_KeyboardEventStruct)).contents
            virtual_key = keyboard_event.vkCode
            is_key_down = w_param in (_WM_KEYDOWN, _WM_SYSKEYDOWN)
            if virtual_key in _CONTROL_KEYS:
                key_state["control"] = is_key_down
            elif virtual_key in _ALT_KEYS:
                key_state["alt"] = is_key_down
            elif virtual_key == PushToTalkKeyEnum.TRIGGER:
                if is_key_down and key_state["pressed"]:
                    return 1  # autorrepetición mientras se mantiene
                if is_key_down and key_state["control"] and key_state["alt"]:
                    key_state["pressed"] = True
                    return 1
                if not is_key_down and key_state["pressed"]:
                    key_state["released"] = True
                    return 1
            return int(user32.CallNextHookEx(None, n_code, w_param, l_param))

        user32 = ctypes.WinDLL("user32", use_last_error=True)
        kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
        keyboard_proc_type = ctypes.WINFUNCTYPE(
            ctypes.c_ssize_t, ctypes.c_int, wintypes.WPARAM, wintypes.LPARAM
        )
        user32.SetWindowsHookExW.argtypes = [
            ctypes.c_int, keyboard_proc_type, wintypes.HINSTANCE, wintypes.DWORD
        ]
        user32.SetWindowsHookExW.restype = wintypes.HHOOK
        user32.CallNextHookEx.argtypes = [
            wintypes.HHOOK, ctypes.c_int, wintypes.WPARAM, wintypes.LPARAM
        ]
        user32.CallNextHookEx.restype = ctypes.c_ssize_t
        user32.UnhookWindowsHookEx.argtypes = [wintypes.HHOOK]
        kernel32.GetModuleHandleW.restype = wintypes.HMODULE

        # La referencia al callback tiene que vivir mientras dure el hook.
        keyboard_proc = keyboard_proc_type(on_keyboard_event)
        hook_handle = user32.SetWindowsHookExW(
            _WH_KEYBOARD_LL, keyboard_proc, kernel32.GetModuleHandleW(None), 0
        )
        if not hook_handle:
            VoiceException.unexpected_custom(
                f"cannot install the keyboard hook (win32 error {ctypes.get_last_error()})"
            )

        def on_audio_chunk(chunk: NDArray[np.float32], _frames: int, _time: Any, _status: Any) -> None:
            recorded_chunks.append(chunk.copy())

        try:
            self._pump_until(user32, lambda: key_state["pressed"], wait_seconds)
            if not key_state["pressed"]:
                return np.zeros(0, dtype=np.float32)
            self._send_mask_key(user32)
            try:
                with sounddevice.InputStream(
                    samplerate=sample_rate, channels=1, dtype="float32", callback=on_audio_chunk
                ):
                    self._pump_until(user32, lambda: key_state["released"], max_record_seconds)
            except sounddevice.PortAudioError as port_audio_error:
                VoiceException.unexpected_custom(f"cannot open the microphone: {port_audio_error}")
        finally:
            user32.UnhookWindowsHookEx(hook_handle)

        if not recorded_chunks:
            return np.zeros(0, dtype=np.float32)
        return np.concatenate(recorded_chunks).reshape(-1)

    def _pump_until(self, user32: Any, is_done: Any, limit_seconds: int) -> None:
        """El hook de bajo nivel solo se dispara mientras este hilo procesa mensajes."""
        message = wintypes.MSG()
        deadline = time.monotonic() + limit_seconds
        while not is_done() and time.monotonic() < deadline:
            while user32.PeekMessageW(ctypes.byref(message), None, 0, 0, _PM_REMOVE):
                user32.TranslateMessage(ctypes.byref(message))
                user32.DispatchMessageW(ctypes.byref(message))
            time.sleep(_PUMP_INTERVAL_SECONDS)

    def _send_mask_key(self, user32: Any) -> None:
        user32.keybd_event(PushToTalkKeyEnum.MASK, 0, 0, 0)
        user32.keybd_event(PushToTalkKeyEnum.MASK, 0, _KEYEVENTF_KEYUP, 0)
