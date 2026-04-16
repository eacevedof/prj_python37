"""Script de prueba para verificar la configuración inicial."""

import asyncio
import sys
from pathlib import Path

# Fix encoding para Windows
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

# Añadir el directorio raíz al path
sys.path.insert(0, str(Path(__file__).parent))

from ddd.shared.infrastructure.components.sqlite_connector import SqliteConnector
from ddd.vocabulary.application.create_word import CreateWordDto, CreateWordService
from ddd.vocabulary.infrastructure.repositories import (
    WordsEsReaderSqliteRepository,
)
from ddd.vocabulary.domain.services import ScoreCalculatorService, SpacedRepetitionService


async def test_database_setup():
    """Prueba la inicialización de la base de datos."""
    print("=" * 50)
    print("1. Inicializando base de datos...")

    sqlite = SqliteConnector.get_instance()
    await sqlite.initialize_database()

    print("   Base de datos inicializada correctamente")

    # Verificar idiomas
    languages = await sqlite.fetch_all("SELECT code, name, flag_emoji FROM languages")
    print(f"   Idiomas disponibles: {len(languages)}")
    for lang in languages[:3]:
        print(f"      - {lang['flag_emoji']} {lang['code']}: {lang['name']}")

    # Verificar tags
    tags = await sqlite.fetch_all("SELECT name, color FROM tags")
    print(f"   Tags creados: {len(tags)}")


async def test_create_word():
    """Prueba la creación de una palabra."""
    print("\n" + "=" * 50)
    print("2. Probando creación de palabra...")

    # Crear palabra de prueba
    dto = CreateWordDto.from_primitives({
        "text": "hola",
        "word_type": "WORD",
        "notes": "Saludo común",
        "tags": ["básico", "cotidiano"],
        "translations": {
            "nl_NL": "hallo",
            "en_US": "hello",
        }
    })

    try:
        service = CreateWordService.get_instance()
        result = await service(dto)

        print(f"   Palabra creada: #{result.id} '{result.text}'")
        print(f"   Tipo: {result.word_type}")
        print(f"   Tags: {result.tags}")
        print(f"   Traducciones: {result.translations}")

    except Exception as e:
        print(f"   Error (puede ser normal si ya existe): {e}")


async def test_read_words():
    """Prueba la lectura de palabras."""
    print("\n" + "=" * 50)
    print("3. Probando lectura de palabras...")

    reader = WordsEsReaderSqliteRepository.get_instance()

    # Buscar palabra
    word = await reader.get_by_text("hola")
    if word:
        print(f"   Encontrada: #{word['id']} '{word['text']}'")

        # Obtener con traducciones
        word_full = await reader.get_with_translations(word['id'])
        if word_full:
            print(f"   Traducciones: {word_full.get('translations', {})}")
    else:
        print("   No se encontró la palabra 'hola'")

    # Contar total
    total = await reader.count()
    print(f"   Total de palabras: {total}")


async def test_score_calculator():
    """Prueba el calculador de score."""
    print("\n" + "=" * 50)
    print("4. Probando Score Calculator...")

    test_cases = [
        ("hallo", "hallo", "Exacto"),
        ("hallo", "halo", "Casi correcto"),
        ("hallo", "hello", "Similar"),
        ("hallo", "xyz", "Incorrecto"),
        ("hallo", "", "Vacío"),
    ]

    for expected, user_input, description in test_cases:
        score = ScoreCalculatorService.calculate(expected, user_input)
        quality = ScoreCalculatorService.score_to_quality(score)
        print(f"   '{expected}' vs '{user_input}' ({description}): score={score}, quality={quality}")


async def test_spaced_repetition():
    """Prueba el algoritmo SM-2."""
    print("\n" + "=" * 50)
    print("5. Probando Spaced Repetition (SM-2)...")

    # Simular secuencia de repasos
    repetitions = 0
    easiness = 2.5
    interval = 1

    scores = [1.0, 0.8, 1.0, 0.3, 1.0]  # Secuencia de scores

    for i, score in enumerate(scores):
        result = SpacedRepetitionService.calculate_from_score(
            score=score,
            repetitions=repetitions,
            easiness_factor=easiness,
            interval_days=interval,
        )

        print(f"   Repaso {i+1}: score={score}")
        print(f"      repetitions: {repetitions} -> {result.repetitions}")
        print(f"      interval: {interval} -> {result.interval_days} días")
        print(f"      easiness: {easiness:.2f} -> {result.easiness_factor:.2f}")

        repetitions = result.repetitions
        easiness = result.easiness_factor
        interval = result.interval_days


async def main():
    """Ejecuta todas las pruebas."""
    print("\n" + "=" * 50)
    print("LEARN LANGUAGES - Test de configuración inicial")
    print("=" * 50)

    await test_database_setup()
    await test_create_word()
    await test_read_words()
    await test_score_calculator()
    await test_spaced_repetition()

    print("\n" + "=" * 50)
    print("Todas las pruebas completadas")
    print("=" * 50 + "\n")


if __name__ == "__main__":
    asyncio.run(main())
