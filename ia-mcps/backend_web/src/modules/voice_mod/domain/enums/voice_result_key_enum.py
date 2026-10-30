from typing import final


@final
class VoiceResultKeyEnum:
    """Claves de los `from_primitives()` y `to_dict()` de los DTOs de voice_mod."""

    TRANSCRIPT_PATH = "transcript_path"
    TEXT = "text"
    MAX_CHARS = "max_chars"
    REPLY_TEXT = "reply_text"
    MODEL = "model"
    REFERENCE_ID = "reference_id"
    SPEECH_TEXT = "speech_text"
    SPOKEN_CHARS = "spoken_chars"
    WAIT_SECONDS = "wait_seconds"
    MAX_RECORD_SECONDS = "max_record_seconds"
    PROMPT_TEXT = "prompt_text"
    RECORDED_SECONDS = "recorded_seconds"
    IS_VOICE_MODE_STOPPED = "is_voice_mode_stopped"
