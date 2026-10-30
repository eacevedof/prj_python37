"""voice_mod — contra los casos de uso, sin red ni altavoces.

Fish Audio y `winsound` se sustituyen en el método del repositorio: la suite es
hermética (cero red, cero credenciales) y corre igual en Windows que en Linux.
"""
import json
from pathlib import Path
from typing import Any

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
    from src.modules.voice_mod.application.get_last_reply.get_last_reply_dto import (
        GetLastReplyDto,
    )
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
    from src.modules.voice_mod.domain.enums import FishAudioVoiceEnum
    from src.modules.voice_mod.infrastructure.repositories.audio_writer_winsound_repository import (
        AudioWriterWinsoundRepository,
    )
    from src.modules.voice_mod.infrastructure.repositories.fish_audio_tts_reader_api_repository import (
        FishAudioTtsReaderApiRepository,
    )

    tts_calls: list[tuple[str, str, str]] = []
    played_audios: list[bytes] = []

    def fake_get_wav_bytes_from_text(_self, speech_text: str, model: str, reference_id: str) -> bytes:
        tts_calls.append((speech_text, model, reference_id))
        return b"RIFF-fake-wav"

    monkeypatch.setattr(FishAudioTtsReaderApiRepository, "get_wav_bytes_from_text", fake_get_wav_bytes_from_text)
    monkeypatch.setattr(
        AudioWriterWinsoundRepository, "play_wav_bytes", lambda _self, wav_bytes: played_audios.append(wav_bytes)
    )

    transcript_path = _write_transcript(tmp_path, [
        _user_prompt("¿qué tal?"),
        _assistant(_text("Todo **bien**, mira `x`.")),
    ])
    speak_text_result_dto = SpeakLastReplyService.get_instance()(
        SpeakLastReplyDto.from_primitives({"transcript_path": transcript_path})
    )

    assert tts_calls == [("Todo bien, mira x.", "s2.1-pro-free", FishAudioVoiceEnum.CHICA_ES)]
    assert played_audios == [b"RIFF-fake-wav"]
    assert speak_text_result_dto.spoken_chars == len("Todo bien, mira x.")


def test_a_reply_with_only_code_is_not_spoken() -> None:
    from src.modules.voice_mod.application.speak_text.speak_text_dto import SpeakTextDto
    from src.modules.voice_mod.application.speak_text.speak_text_service import (
        SpeakTextService,
    )
    from src.modules.voice_mod.domain.exceptions.voice_exception import VoiceException

    with pytest.raises(VoiceException, match="no text to speak"):
        SpeakTextService.get_instance()(SpeakTextDto.from_primitives({"text": "```\nls\n```"}))


def _patch_listen_repositories(
    monkeypatch: pytest.MonkeyPatch, recorded_seconds: float, transcription: str
) -> list[int]:
    import numpy as np

    from src.modules.voice_mod.infrastructure.repositories.audio_writer_winsound_repository import (
        AudioWriterWinsoundRepository,
    )
    from src.modules.voice_mod.infrastructure.repositories.push_to_talk_audio_reader_win32_repository import (
        PushToTalkAudioReaderWin32Repository,
    )
    from src.modules.voice_mod.infrastructure.repositories.speech_to_text_reader_faster_whisper_repository import (
        SpeechToTextReaderFasterWhisperRepository,
    )

    beeps: list[int] = []
    monkeypatch.setattr(SpeechToTextReaderFasterWhisperRepository, "load_model", lambda _self: None)
    monkeypatch.setattr(
        SpeechToTextReaderFasterWhisperRepository, "get_text_from_samples", lambda _self, _samples: transcription
    )
    monkeypatch.setattr(
        PushToTalkAudioReaderWin32Repository,
        "get_samples_while_key_held",
        lambda _self, _wait, _max, sample_rate: np.zeros(int(recorded_seconds * sample_rate), dtype=np.float32),
    )
    monkeypatch.setattr(
        AudioWriterWinsoundRepository, "play_beep", lambda _self, frequency_hz, _ms: beeps.append(frequency_hz)
    )
    return beeps


def _listen_user_prompt():
    from src.modules.voice_mod.application.listen_user_prompt.listen_user_prompt_dto import (
        ListenUserPromptDto,
    )
    from src.modules.voice_mod.application.listen_user_prompt.listen_user_prompt_service import (
        ListenUserPromptService,
    )

    return ListenUserPromptService.get_instance()(ListenUserPromptDto.from_primitives({}))


def test_listen_user_prompt_returns_what_was_said(monkeypatch: pytest.MonkeyPatch) -> None:
    beeps = _patch_listen_repositories(monkeypatch, 2.5, "revisa los tests")

    listen_user_prompt_result_dto = _listen_user_prompt()

    assert listen_user_prompt_result_dto.prompt_text == "revisa los tests"
    assert listen_user_prompt_result_dto.recorded_seconds == 2.5
    assert len(beeps) == 2


def test_a_key_tap_is_not_transcribed(monkeypatch: pytest.MonkeyPatch) -> None:
    beeps = _patch_listen_repositories(monkeypatch, 0.1, "no debería llegar")

    assert _listen_user_prompt().prompt_text == ""
    assert len(beeps) == 1


def test_voice_mode_is_turned_on_and_off(tmp_path: Path) -> None:
    from src.modules.voice_mod.infrastructure.repositories.voice_mode_reader_file_repository import (
        VoiceModeReaderFileRepository,
    )
    from src.modules.voice_mod.infrastructure.repositories.voice_mode_writer_file_repository import (
        VoiceModeWriterFileRepository,
    )

    flag_file_path = tmp_path / "voice" / "voice-mode.on"
    voice_mode_reader_file_repository = VoiceModeReaderFileRepository(flag_file_path)
    voice_mode_writer_file_repository = VoiceModeWriterFileRepository(flag_file_path)
    assert not voice_mode_reader_file_repository.is_voice_mode_on()
    voice_mode_writer_file_repository.turn_voice_mode_on()
    assert voice_mode_reader_file_repository.is_voice_mode_on()
    voice_mode_writer_file_repository.turn_voice_mode_off()
    assert not voice_mode_reader_file_repository.is_voice_mode_on()


def _run_voice_turn(monkeypatch: pytest.MonkeyPatch, transcription: str) -> tuple[Any, list[bool]]:
    from src.modules.voice_mod.application.run_voice_turn.run_voice_turn_dto import (
        RunVoiceTurnDto,
    )
    from src.modules.voice_mod.application.run_voice_turn.run_voice_turn_service import (
        RunVoiceTurnService,
    )
    from src.modules.voice_mod.infrastructure.repositories.voice_mode_writer_file_repository import (
        VoiceModeWriterFileRepository,
    )

    _patch_listen_repositories(monkeypatch, 2.0, transcription)
    turned_off: list[bool] = []
    monkeypatch.setattr(VoiceModeWriterFileRepository, "turn_voice_mode_off", lambda _self: turned_off.append(True))

    return RunVoiceTurnService.get_instance()(RunVoiceTurnDto.from_primitives({})), turned_off


def test_a_voice_turn_returns_the_next_prompt(monkeypatch: pytest.MonkeyPatch) -> None:
    run_voice_turn_result_dto, turned_off = _run_voice_turn(monkeypatch, "revisa los tests")

    assert run_voice_turn_result_dto.prompt_text == "revisa los tests"
    assert not run_voice_turn_result_dto.is_voice_mode_stopped
    assert not turned_off


@pytest.mark.parametrize("transcription", ["fin voz", "Fin de voz.", "¡fin, voz!"])
def test_saying_fin_voz_turns_voice_mode_off(monkeypatch: pytest.MonkeyPatch, transcription: str) -> None:
    run_voice_turn_result_dto, turned_off = _run_voice_turn(monkeypatch, transcription)

    assert run_voice_turn_result_dto.prompt_text == ""
    assert run_voice_turn_result_dto.is_voice_mode_stopped
    assert turned_off == [True]


def test_fish_streaming_wav_header_gets_real_sizes() -> None:
    import struct

    from src.modules.voice_mod.infrastructure.repositories.fish_audio_tts_reader_api_repository import (
        FishAudioTtsReaderApiRepository,
    )

    pcm_bytes = b"" * 50
    fmt_chunk = b"fmt " + struct.pack("<IHHIIHH", 16, 1, 1, 44100, 88200, 2, 16)
    streaming_wav = (
        b"RIFF" + struct.pack("<I", 0xFFFFFF24) + b"WAVE" + fmt_chunk
        + b"data" + struct.pack("<I", 0xFFFFFF00) + pcm_bytes
    )

    fixed_wav = FishAudioTtsReaderApiRepository.get_instance()._get_wav_with_real_sizes(streaming_wav)

    assert struct.unpack("<I", fixed_wav[4:8])[0] == len(streaming_wav) - 8
    assert struct.unpack("<I", fixed_wav[40:44])[0] == len(pcm_bytes)
    assert fixed_wav[44:] == pcm_bytes
