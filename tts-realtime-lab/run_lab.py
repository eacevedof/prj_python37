"""Banco de pruebas: audio.speech (legacy) frente a la Realtime API.

Uso:
    python run_lab.py                       # batería por defecto, legacy + realtime
    python run_lab.py --only-new            # solo realtime (no gasta en legacy)
    python run_lab.py --text "Hoe gaat het?" --voices marin cedar
    python run_lab.py --speed 0.8 --format wav

Deja en out/<timestamp>/ un fichero de audio por caso y un report.md con latencia,
tamaño, transcripción y si el modelo leyó el texto literal.
"""

import argparse
import asyncio
import re
import sys
import time
import unicodedata
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path

from dotenv import load_dotenv
from openai import AsyncOpenAI, OpenAI

from realtime_tts_repository import RealtimeTtsRepository

LAB_DIR = Path(__file__).resolve().parent

LEGACY_MODEL = "gpt-4o-mini-tts"
LEGACY_VOICE = "nova"  # la que usa learn-langs para nl_NL / nl_BE (no existe en Realtime)
NEW_MODEL = "gpt-realtime-2.1-mini"
NEW_VOICES = ["marin", "cedar", "coral", "shimmer"]

# Acento activo de nl_NL en learn-langs (TtsAccentEnum.NL_HAARLEM).
NL_ACCENT = (
    "Spreek Standaardnederlands (ABN) zoals in Nederland, "
    "met het neutrale Randstad/Haarlem-accent. "
    "Gebruik geen Vlaams of Belgisch accent."
)
ES_ACCENT = "Habla en español de España, con acento castellano peninsular. No uses acento latinoamericano."


@dataclass(frozen=True)
class LabCase:
    slug: str
    text: str
    accent: str


# Las "trampas" (pregunta, orden, palabra suelta) son las que delatan si el
# modelo conversacional contesta en vez de leer.
DEFAULT_CASES = [
    LabCase("nl-word", "de fiets", NL_ACCENT),
    LabCase("nl-sentence", "Gisteren ben ik met de trein naar Haarlem gegaan.", NL_ACCENT),
    LabCase("nl-question", "Hoe laat begint de vergadering morgen?", NL_ACCENT),
    LabCase("nl-command", "Vertel me een grap over katten.", NL_ACCENT),
    LabCase("nl-gutural", "Scheveningen, gezellig, achtentachtig.", NL_ACCENT),
    LabCase("es-notice", "¿Sabes cuál es la respuesta? Piénsalo antes de contestar.", ES_ACCENT),
]


def _normalize(text: str) -> str:
    text = unicodedata.normalize("NFKD", text.lower())
    text = "".join(char for char in text if not unicodedata.combining(char))
    return " ".join(re.sub(r"[^\w\s]", "", text).split())


def _is_verbatim(expected: str, transcript: str) -> bool:
    return _normalize(expected) == _normalize(transcript)


def _load_env() -> None:
    # Primero el .env del laboratorio; si no hay, el de learn-langs (sin copiar la clave).
    load_dotenv(LAB_DIR / ".env")
    load_dotenv(LAB_DIR.parent / "learn-langs" / ".env")


def _legacy(client: OpenAI, case: LabCase, response_format: str) -> tuple[bytes, float]:
    started = time.monotonic()
    # gpt-4o-mini-tts: con 'instructions' learn-langs no manda 'speed'.
    response = client.audio.speech.create(
        model=LEGACY_MODEL,
        voice=LEGACY_VOICE,
        input=case.text,
        instructions=case.accent,
        response_format=response_format,  # type: ignore[arg-type]
    )
    return response.content, time.monotonic() - started


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--text", help="texto suelto (neerlandés, acento Haarlem)")
    parser.add_argument("--voices", nargs="+", default=NEW_VOICES)
    parser.add_argument("--model", default=NEW_MODEL)
    parser.add_argument("--speed", type=float, default=1.0)
    parser.add_argument("--format", default="mp3", choices=["mp3", "wav"])
    parser.add_argument("--only-new", action="store_true", help="no llamar al modelo legacy")
    args = parser.parse_args()

    cases = [LabCase("custom", args.text, NL_ACCENT)] if args.text else DEFAULT_CASES
    _load_env()
    client = OpenAI()
    repository = RealtimeTtsRepository(AsyncOpenAI())

    out_dir = LAB_DIR / "out" / datetime.now().strftime("%Y%m%d-%H%M%S")
    out_dir.mkdir(parents=True)
    rows: list[str] = []
    row_number = 0

    for case in cases:
        if not args.only_new:
            row_number += 1
            try:
                audio, elapsed = _legacy(client, case, args.format)
                file_name = f"{case.slug}--legacy-{LEGACY_VOICE}.{args.format}"
                (out_dir / file_name).write_bytes(audio)
                rows.append(
                    f"| {row_number} | {case.slug} | {LEGACY_MODEL} | {LEGACY_VOICE} | {elapsed:.2f} "
                    f"| {len(audio) // 1024} | — | — | {file_name} |"
                )
            except Exception as error:  # noqa: BLE001 - laboratorio: se anota y se sigue
                rows.append(f"| {row_number} | {case.slug} | {LEGACY_MODEL} | {LEGACY_VOICE} | ERROR: {error} |||||")
            print(rows[-1])

        for voice in args.voices:
            row_number += 1
            try:
                result = asyncio.run(
                    repository.synthesize_async(
                        model=args.model,
                        voice=voice,
                        input_text=case.text,
                        speed=args.speed,
                        response_format=args.format,
                        instructions=case.accent,
                    )
                )
                file_name = f"{case.slug}--{args.model}-{voice}.{args.format}"
                (out_dir / file_name).write_bytes(result.audio_bytes)
                verbatim = "✅" if _is_verbatim(case.text, result.transcript) else "❌"
                tokens = result.usage.get("total_tokens", "?")
                rows.append(
                    f"| {row_number} | {case.slug} | {args.model} | {voice} | {result.elapsed_s:.2f} "
                    f"| {len(result.audio_bytes) // 1024} | {verbatim} {result.transcript!r} | {tokens} | {file_name} |"
                )
            except Exception as error:  # noqa: BLE001
                rows.append(f"| {row_number} | {case.slug} | {args.model} | {voice} | ERROR: {error} |||||")
            print(rows[-1])

    report = [
        f"# 1 - tts-realtime-lab · {out_dir.name}",
        "",
        f"speed={args.speed} · format={args.format}",
        "",
        "| # | Caso | Modelo | Voz | Seg | KB | Literal · transcripción | Tokens | Fichero |",
        "|---|---|---|---|---|---|---|---|---|",
        *rows,
        "",
    ]
    (out_dir / "report.md").write_text("\n".join(report), encoding="utf-8")
    print(f"\nReport: {out_dir / 'report.md'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
