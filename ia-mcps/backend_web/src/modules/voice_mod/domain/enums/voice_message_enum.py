from typing import final


@final
class VoiceMessageEnum:
    """Mensajes de error de voice_mod (van al log y a la consola, no al agente).

    El detalle variable (ruta, código HTTP, error de la librería) se añade al
    final: `f"{VoiceMessageEnum.X}: {detalle}"`.
    """

    TRANSCRIPT_PATH_REQUIRED = "transcript_path is required"
    TRANSCRIPT_NOT_FOUND = "transcript not found"
    NO_TEXT_TO_SPEAK = "there is no text to speak"
    FISH_API_KEY_NOT_CONFIGURED = "APP_VOICE_FISH_API_KEY is not configured"
    FISH_AUDIO_NO_AUDIO = "fish audio returned no audio"
    AUDIO_PLAYBACK_WINDOWS_ONLY = "audio playback is only supported on Windows for now"
    PUSH_TO_TALK_WINDOWS_ONLY = "push-to-talk is only supported on Windows for now"
    KEYBOARD_HOOK_FAILED = "cannot install the keyboard hook (win32 error)"
