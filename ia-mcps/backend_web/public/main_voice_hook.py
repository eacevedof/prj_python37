"""Hook `Stop` de Claude Code: lee en alto la última respuesta (voice_mod, fase 1).

Claude Code llama al hook al terminar cada respuesta y le pasa por stdin un JSON
con `transcript_path`. Leer en alto tarda lo que dure el audio, y un hook que
no vuelve deja a Claude Code esperando, así que el hook NO habla: lanza este
mismo fichero en segundo plano (`--speak`) y sale al momento. Sale siempre con
0: un fallo de la voz nunca debe bloquear a Claude Code; se apunta en el log.

Uso:

    python public/main_voice_hook.py                  # como hook (stdin JSON)
    python public/main_voice_hook.py --speak <ruta>   # leer un transcript (bloquea)
    python public/main_voice_hook.py --say "<texto>"  # probar la voz (bloquea)

Alta en `~/.claude/settings.json` (ver ia-mcps-deploy.md):

    "hooks": {"Stop": [{"hooks": [{"type": "command",
      "command": "C:/projects/prj_python37/ia-mcps/.venv-win/Scripts/python.exe C:/projects/prj_python37/ia-mcps/backend_web/public/main_voice_hook.py"}]}]}
"""

import json
import subprocess
import sys
from pathlib import Path
from typing import Any

# Igual que en `main_stdio.py`: este fichero se lanza suelto y con un cwd que no
# controlamos, así que `src.*` no estaría en el path. De ahí los E402.
_BACKEND_WEB_PATH = str(Path(__file__).resolve().parents[1])
if _BACKEND_WEB_PATH not in sys.path:
    sys.path.insert(0, _BACKEND_WEB_PATH)

from src.modules.shared.infrastructure.components.logger.logger import Logger  # noqa: E402
from src.modules.voice_mod.application.speak_last_reply.speak_last_reply_dto import (  # noqa: E402
    SpeakLastReplyDto,
)
from src.modules.voice_mod.application.speak_last_reply.speak_last_reply_service import (  # noqa: E402
    SpeakLastReplyService,
)
from src.modules.voice_mod.application.speak_text.speak_text_dto import SpeakTextDto  # noqa: E402
from src.modules.voice_mod.application.speak_text.speak_text_service import (  # noqa: E402
    SpeakTextService,
)
from src.modules.voice_mod.domain.exceptions.voice_exception import VoiceException  # noqa: E402

_EXIT_OK = 0
_EXIT_BAD_USAGE = 2
_EXIT_REFUSED = 1
_SPEAK_FLAG = "--speak"
_SAY_FLAG = "--say"
_LOG_MODULE = "voice_hook"


def _get_usage_text() -> str:
    return (
        f"usage: python {Path(__file__).name}"
        f" [{_SPEAK_FLAG} <transcript_path> | {_SAY_FLAG} <texto>]"
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


def _run_as_hook() -> int:
    hook_payload = _get_hook_payload()
    # `stop_hook_active` = Claude Code ya está continuando por otro hook Stop:
    # esa respuesta no ha terminado de verdad, no se lee.
    if hook_payload.get("stop_hook_active"):
        return _EXIT_OK

    transcript_path = str(hook_payload.get("transcript_path", "")).strip()
    if not transcript_path:
        Logger.get_instance().log_error(_LOG_MODULE, "hook payload without transcript_path")
        return _EXIT_OK

    _start_speaker_in_background(transcript_path)
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


def start_voice_hook() -> None:
    arguments = sys.argv[1:]
    if not arguments:
        sys.exit(_run_as_hook())

    if len(arguments) < 2 or arguments[0] not in (_SPEAK_FLAG, _SAY_FLAG):
        print(_get_usage_text(), file=sys.stderr)
        sys.exit(_EXIT_BAD_USAGE)

    if arguments[0] == _SPEAK_FLAG:
        sys.exit(_speak_transcript(arguments[1]))

    sys.exit(_say_text(" ".join(arguments[1:])))


if __name__ == "__main__":
    start_voice_hook()
