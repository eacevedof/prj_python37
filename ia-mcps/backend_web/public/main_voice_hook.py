"""Hook `Stop` de Claude Code: lee en alto la última respuesta y, en modo voz, te escucha.

Claude Code llama al hook al terminar cada respuesta y le pasa por stdin un JSON
con `transcript_path`. Sale siempre con 0: un fallo de la voz nunca debe
bloquear a Claude Code; se apunta en el log.

- **Modo normal** (fase 1): leer en alto tarda lo que dure el audio, y un hook
  que no vuelve deja a Claude Code esperando, así que el hook NO habla: lanza
  este mismo fichero en segundo plano (`--speak`) y sale al momento.
- **Modo voz** (fase 2a, lo enciende `/voz` con `--on`): el hook espera. Lee la
  respuesta si hay API key de Fish Audio, pita, graba mientras mantienes pulsado
  Ctrl+Alt+Espacio, transcribe con faster-whisper y devuelve
  `{"decision": "block", "reason": <tu frase>}`: Claude no se para y la toma
  como siguiente instrucción. Decir «fin voz» apaga el modo.

Uso:

    python public/main_voice_hook.py                  # como hook (stdin JSON)
    python public/main_voice_hook.py --speak <ruta>   # leer un transcript (bloquea)
    python public/main_voice_hook.py --say "<texto>"  # probar la voz (bloquea)
    python public/main_voice_hook.py --listen         # probar el micro: imprime lo que digas
    python public/main_voice_hook.py --on | --off     # encender / apagar el modo voz

Alta y `timeout` en `.claude/settings.local.json` del proyecto (ver ia-mcps-deploy.md).
"""

import json
import re
import subprocess
import sys
from pathlib import Path
from typing import Any

# Igual que en `main_stdio.py`: este fichero se lanza suelto y con un cwd que no
# controlamos, así que `src.*` no estaría en el path: los imports de `src.*` van
# después de esto a propósito.
_BACKEND_WEB_PATH = str(Path(__file__).resolve().parents[1])
if _BACKEND_WEB_PATH not in sys.path:
    sys.path.insert(0, _BACKEND_WEB_PATH)

from src.modules.shared.infrastructure.components.logger.logger import (
    Logger,
)
from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)
from src.modules.voice_mod.application.listen_user_prompt.listen_user_prompt_dto import (
    ListenUserPromptDto,
)
from src.modules.voice_mod.application.listen_user_prompt.listen_user_prompt_service import (
    ListenUserPromptService,
)
from src.modules.voice_mod.application.speak_last_reply.speak_last_reply_dto import (
    SpeakLastReplyDto,
)
from src.modules.voice_mod.application.speak_last_reply.speak_last_reply_service import (
    SpeakLastReplyService,
)
from src.modules.voice_mod.application.speak_text.speak_text_dto import (
    SpeakTextDto,
)
from src.modules.voice_mod.application.speak_text.speak_text_service import (
    SpeakTextService,
)
from src.modules.voice_mod.domain.exceptions.voice_exception import (
    VoiceException,
)
from src.modules.voice_mod.infrastructure.repositories.voice_mode_file_repository import (
    VoiceModeFileRepository,
)

_EXIT_OK = 0
_EXIT_BAD_USAGE = 2
_EXIT_REFUSED = 1
_SPEAK_FLAG = "--speak"
_SAY_FLAG = "--say"
_LISTEN_FLAG = "--listen"
_ON_FLAG = "--on"
_OFF_FLAG = "--off"
_LOG_MODULE = "voice_hook"
_STOP_VOICE_PATTERN = re.compile(r"^\W*fin\W+(de\W+)?voz\W*$", re.IGNORECASE)
_VOICE_PROMPT_PREFIX = "Instrucción del usuario por voz (transcrita, puede tener errores): "


def _get_usage_text() -> str:
    return (
        f"usage: python {Path(__file__).name}"
        f" [{_SPEAK_FLAG} <transcript_path> | {_SAY_FLAG} <texto>"
        f" | {_LISTEN_FLAG} | {_ON_FLAG} | {_OFF_FLAG}]"
    )


def _get_hook_payload() -> dict[str, Any]:
    try:
        hook_payload = json.loads(sys.stdin.read() or "{}")
    except json.JSONDecodeError:
        return {}
    return hook_payload if isinstance(hook_payload, dict) else {}


def _get_detached_creation_flags() -> int:
    if sys.platform != "win32":
        return 0
    return subprocess.DETACHED_PROCESS | subprocess.CREATE_NEW_PROCESS_GROUP


def _start_speaker_in_background(transcript_path: str) -> None:
    """El hijo sobrevive a la salida del hook: sin consola, en su propio grupo."""
    subprocess.Popen(
        [sys.executable, str(Path(__file__).resolve()), _SPEAK_FLAG, transcript_path],
        stdin=subprocess.DEVNULL,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        creationflags=_get_detached_creation_flags(),
        start_new_session=sys.platform != "win32",
        close_fds=True,
    )


def _has_fish_api_key() -> bool:
    return bool(EnvironmentReaderRawRepository.get_instance().get_voice_fish_api_key())


def _run_as_hook() -> int:
    hook_payload = _get_hook_payload()
    transcript_path = str(hook_payload.get("transcript_path", "")).strip()

    if VoiceModeFileRepository.get_instance().is_voice_mode_on():
        return _run_voice_turn(transcript_path)

    # `stop_hook_active` = Claude Code ya está continuando por otro hook Stop:
    # esa respuesta no ha terminado de verdad, no se lee.
    if hook_payload.get("stop_hook_active"):
        return _EXIT_OK

    # Sin API key de Fish Audio no hay voz que sacar: se calla sin ensuciar el log.
    if not _has_fish_api_key():
        return _EXIT_OK

    if not transcript_path:
        Logger.get_instance().log_error(_LOG_MODULE, "hook payload without transcript_path")
        return _EXIT_OK

    _start_speaker_in_background(transcript_path)
    return _EXIT_OK


def _run_voice_turn(transcript_path: str) -> int:
    """Aquí no se mira `stop_hook_active`: en el bucle de voz todos los turnos
    después del primero llegan con él a true, porque los continúa este hook."""
    if transcript_path and _has_fish_api_key():
        _speak_transcript(transcript_path)

    try:
        listen_user_prompt_result_dto = ListenUserPromptService.get_instance()(
            ListenUserPromptDto.from_primitives({})
        )
    except VoiceException as voice_exception:
        Logger.get_instance().log_error(_LOG_MODULE, voice_exception.message)
        return _EXIT_OK

    prompt_text = listen_user_prompt_result_dto.prompt_text
    if not prompt_text:
        return _EXIT_OK

    if _STOP_VOICE_PATTERN.match(prompt_text):
        VoiceModeFileRepository.get_instance().turn_voice_mode_off()
        return _EXIT_OK

    print(json.dumps({"decision": "block", "reason": _VOICE_PROMPT_PREFIX + prompt_text}))
    return _EXIT_OK


def _speak_transcript(transcript_path: str) -> int:
    try:
        SpeakLastReplyService.get_instance()(
            SpeakLastReplyDto.from_primitives({"transcript_path": transcript_path})
        )
    except VoiceException as voice_exception:
        Logger.get_instance().log_error(
            _LOG_MODULE, voice_exception.message, {"transcript_path": transcript_path}
        )
        return _EXIT_REFUSED
    return _EXIT_OK


def _say_text(speech_text: str) -> int:
    try:
        speak_text_result_dto = SpeakTextService.get_instance()(
            SpeakTextDto.from_primitives({"text": speech_text})
        )
    except VoiceException as voice_exception:
        print(f"error: {voice_exception.message}", file=sys.stderr)
        return _EXIT_REFUSED
    print(
        f"leído: {speak_text_result_dto.spoken_chars} caracteres"
        f" (modelo: {speak_text_result_dto.model})"
    )
    return _EXIT_OK


def _listen_once() -> int:
    print("cargando el modelo… cuando pite, mantén pulsado Ctrl+Alt+Espacio y habla")
    try:
        listen_user_prompt_result_dto = ListenUserPromptService.get_instance()(
            ListenUserPromptDto.from_primitives({"wait_seconds": 30})
        )
    except VoiceException as voice_exception:
        print(f"error: {voice_exception.message}", file=sys.stderr)
        return _EXIT_REFUSED
    print(f"grabado: {listen_user_prompt_result_dto.recorded_seconds} s")
    print(f"> {listen_user_prompt_result_dto.prompt_text or '(nada)'}")
    return _EXIT_OK


def _set_voice_mode(is_on: bool) -> int:
    voice_mode_file_repository = VoiceModeFileRepository.get_instance()
    if is_on:
        voice_mode_file_repository.turn_voice_mode_on()
        print("modo voz: activo (Ctrl+Alt+Espacio para hablar, «fin voz» para salir)")
        return _EXIT_OK
    voice_mode_file_repository.turn_voice_mode_off()
    print("modo voz: apagado")
    return _EXIT_OK


def start_voice_hook() -> None:
    # La consola de Windows no es UTF-8: sin esto, «fin voz» sale como «�fin voz�».
    sys.stdout.reconfigure(encoding="utf-8")  # type: ignore[union-attr]
    arguments = sys.argv[1:]
    if not arguments:
        sys.exit(_run_as_hook())

    single_flags = {
        _LISTEN_FLAG: _listen_once,
        _ON_FLAG: lambda: _set_voice_mode(True),
        _OFF_FLAG: lambda: _set_voice_mode(False),
    }
    if len(arguments) == 1 and arguments[0] in single_flags:
        sys.exit(single_flags[arguments[0]]())

    if len(arguments) < 2 or arguments[0] not in (_SPEAK_FLAG, _SAY_FLAG):
        print(_get_usage_text(), file=sys.stderr)
        sys.exit(_EXIT_BAD_USAGE)

    if arguments[0] == _SPEAK_FLAG:
        sys.exit(_speak_transcript(arguments[1]))

    sys.exit(_say_text(" ".join(arguments[1:])))


if __name__ == "__main__":
    start_voice_hook()
