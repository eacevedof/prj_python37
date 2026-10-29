import glob
import os
import sysconfig
from typing import Any, ClassVar, Self, final

import numpy as np
from numpy.typing import NDArray

from src.modules.voice_mod.domain.enums import SpeechToTextEnum
from src.modules.voice_mod.domain.exceptions.voice_exception import VoiceException


@final
class SpeechToTextFasterWhisperRepository:
    """Audio → texto en local, en la GPU (datasource: faster-whisper / CTranslate2).

    El modelo tarda 3-5 s en cargar: se carga una vez por proceso y se reutiliza.
    En Windows, CTranslate2 busca `cublas64_12.dll` y cuDNN en el PATH; vienen en
    las wheels `nvidia-*-cu12`, así que se añaden sus `bin` antes de cargar
    (gotcha en ia-mcps-deploy §Transcripción local).
    """

    _whisper_model: ClassVar[Any] = None

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def load_model(self) -> None:
        """Raises: VoiceException si faster-whisper o CUDA no están disponibles."""
        if SpeechToTextFasterWhisperRepository._whisper_model is not None:
            return
        self._add_nvidia_dll_directories()
        try:
            from faster_whisper import WhisperModel  # type: ignore[import-untyped]

            SpeechToTextFasterWhisperRepository._whisper_model = WhisperModel(
                SpeechToTextEnum.MODEL,
                device=SpeechToTextEnum.DEVICE,
                compute_type=SpeechToTextEnum.COMPUTE_TYPE,
            )
        except Exception as error:  # noqa: BLE001 - CTranslate2 lanza RuntimeError/OSError/ImportError
            VoiceException.unexpected_custom(f"cannot load faster-whisper: {error}")

    def get_text_from_samples(self, audio_samples: NDArray[np.float32]) -> str:
        """`audio_samples`: mono, float32, 16 kHz.

        Raises:
            VoiceException: si el modelo no carga o la transcripción falla.
        """
        self.load_model()
        try:
            segments, _info = SpeechToTextFasterWhisperRepository._whisper_model.transcribe(
                audio_samples,
                language=SpeechToTextEnum.LANGUAGE,
                beam_size=5,
                vad_filter=True,
                initial_prompt=SpeechToTextEnum.INITIAL_PROMPT,
            )
            return " ".join(segment.text.strip() for segment in segments).strip()
        except Exception as error:  # noqa: BLE001
            VoiceException.unexpected_custom(f"faster-whisper failed: {error}")
        return ""

    def _add_nvidia_dll_directories(self) -> None:
        if os.name != "nt":
            return
        purelib_path = sysconfig.get_paths()["purelib"]
        for nvidia_bin_path in glob.glob(os.path.join(purelib_path, "nvidia", "*", "bin")):
            os.add_dll_directory(nvidia_bin_path)
            os.environ["PATH"] = nvidia_bin_path + os.pathsep + os.environ.get("PATH", "")
