"""voice_mod — contra los casos de uso, sin red ni altavoces.

Fish Audio y `winsound` se sustituyen en el método del repositorio: la suite es
hermética (cero red, cero credenciales) y corre igual en Windows que en Linux.
"""
import json
from pathlib import Path

import pytest


def _get_speech_text(text: str, max_chars: int = 600) -> str:
    from src.modules.voice_mod.application.get_speech_text.get_speech_text_dto import (
        GetSpeechTextDto,
    )
    from src.modules.voice_mod.application.get_speech_text.get_speech_text_service import (
        GetSpeechTextService,
    )

    return GetSpeechTextService.get_instance()(
        GetSpeechTextDto.from_primitives({"text": text, "max_chars": max_chars})
    ).speech_text


def _write_transcript(tmp_path: Path, transcript_entries: list[dict]) -> str:
    transcript_file_path = tmp_path / "session.jsonl"
    transcript_lines = [json.dumps(transcript_entry) for transcript_entry in transcript_entries]
    transcript_file_path.write_text("\n".join(transcript_lines) + "\n", encoding="utf-8")
    return str(transcript_file_path)


def _get_last_reply(transcript_path: str) -> str:
    from src.modules.voice_mod.application.get_last_reply.get_last_reply_dto import GetLastReplyDto
    from src.modules.voice_mod.application.get_last_reply.get_last_reply_service import (
        GetLastReplyService,
    )

    return GetLastReplyService.get_instance()(
        GetLastReplyDto.from_primitives({"transcript_path": transcript_path})
    ).reply_text


def _user_prompt(text: str) -> dict:
    return {"type": "user", "message": {"role": "user", "content": text}}


def _tool_result() -> dict:
    return {
        "type": "user",
        "message": {"role": "user", "content": [{"type": "tool_result", "content": "ok"}]},
    }


def _assistant(*content_blocks: dict) -> dict:
    return {"type": "assistant", "message": {"role": "assistant", "content": list(content_blocks)}}


def _text(text: str) -> dict:
    return {"type": "text", "text": text}


def test_code_tables_and_urls_are_not_spoken() -> None:
    speech_text = _get_speech_text(
        "## 1 - Hecho\n\n"
        "He cambiado **dos** ficheros:\n\n"
        "```python\nprint('hola')\n```\n\n"
        "| # | Fichero |\n|---|---|\n| 1 | a.py |\n\n"
        "- Ver [la doc](https://docs.fish.audio) y https://example.com\n"
        "- Usa `make test`."
    )

    assert speech_text == "1 - Hecho\n\nHe cambiado dos ficheros:\n\nVer la doc y\nUsa make test."


def test_long_text_is_cut_at_the_last_sentence_end() -> None:
    speech_text = _get_speech_text("Primera frase. Segunda frase bastante más larga que el límite", 30)

    assert speech_text == "Primera frase."


def test_the_last_reply_is_the_assistant_text_after_the_last_prompt(tmp_path: Path) -> None:
    transcript_path = _write_transcript(tmp_path, [
        _user_prompt("primera pregunta"),
        _assistant(_text("respuesta vieja")),
        _user_prompt("segunda pregunta"),
        _assistant(_text("Voy a mirarlo."), {"type": "tool_use", "name": "Bash", "input": {}}),
        _tool_result(),
        {"type": "assistant", "isSidechain": True, "message": {"content": [_text("subagente")]}},
        _assistant(_text("Listo: está arreglado.")),
    ])

    assert _get_last_reply(transcript_path) == "Voy a mirarlo.\n\nListo: está arreglado."


def test_a_broken_line_in_the_transcript_is_skipped(tmp_path: Path) -> None:
    transcript_path = _write_transcript(tmp_path, [_user_prompt("hola"), _assistant(_text("adiós"))])
    with open(transcript_path, "a", encoding="utf-8") as transcript_file:
        transcript_file.write('{"type": "assistant", "mess')

    assert _get_last_reply(transcript_path) == "adiós"


def test_a_missing_transcript_is_refused(tmp_path: Path) -> None:
    from src.modules.voice_mod.domain.exceptions.voice_exception import VoiceException

    with pytest.raises(VoiceException, match="transcript not found"):
        _get_last_reply(str(tmp_path / "missing.jsonl"))


def test_speak_last_reply_sends_the_clean_text_to_fish_audio_and_plays_it(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    from src.modules.voice_mod.application.speak_last_reply.speak_last_reply_dto import (
        SpeakLastReplyDto,
    )
    from src.modules.voice_mod.application.speak_last_reply.speak_last_reply_service import (
        SpeakLastReplyService,
    )
    from src.modules.voice_mod.infrastructure.repositories.audio_player_winsound_repository import (
        AudioPlayerWinsoundRepository,
    )
    from src.modules.voice_mod.infrastructure.repositories.fish_audio_tts_api_repository import (
        FishAudioTtsApiRepository,
    )

    tts_calls: list[tuple[str, str, str]] = []
    played_audios: list[bytes] = []

    def fake_get_wav_bytes_from_text(_self, speech_text: str, model: str, reference_id: str) -> bytes:
        tts_calls.append((speech_text, model, reference_id))
        return b"RIFF-fake-wav"

    monkeypatch.setattr(FishAudioTtsApiRepository, "get_wav_bytes_from_text", fake_get_wav_bytes_from_text)
    monkeypatch.setattr(
        AudioPlayerWinsoundRepository, "play_wav_bytes", lambda _self, wav_bytes: played_audios.append(wav_bytes)
    )
    monkeypatch.delenv("APP_VOICE_FISH_MODEL", raising=False)
    monkeypatch.setenv("APP_VOICE_FISH_REFERENCE_ID", "voice-123")

    transcript_path = _write_transcript(tmp_path, [
        _user_prompt("¿qué tal?"),
        _assistant(_text("Todo **bien**, mira `x`.")),
    ])
    speak_text_result_dto = SpeakLastReplyService.get_instance()(
        SpeakLastReplyDto.from_primitives({"transcript_path": transcript_path})
    )

    assert tts_calls == [("Todo bien, mira x.", "s2.1-pro-free", "voice-123")]
    assert played_audios == [b"RIFF-fake-wav"]
    assert speak_text_result_dto.spoken_chars == len("Todo bien, mira x.")


def test_a_reply_with_only_code_is_not_spoken() -> None:
    from src.modules.voice_mod.application.speak_text.speak_text_dto import SpeakTextDto
    from src.modules.voice_mod.application.speak_text.speak_text_service import SpeakTextService
    from src.modules.voice_mod.domain.exceptions.voice_exception import VoiceException

    with pytest.raises(VoiceException, match="no text to speak"):
        SpeakTextService.get_instance()(SpeakTextDto.from_primitives({"text": "```\nls\n```"}))
