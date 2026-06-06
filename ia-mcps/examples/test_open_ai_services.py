"""Script de ejemplo para probar los servicios de OpenAI."""

import sys
from pathlib import Path

# Agregar el directorio raíz al path para poder importar ddd
sys.path.insert(0, str(Path(__file__).parent.parent))

from ddd.open_ai.application import (
    CreateImageOpenaiDto,
    CreateImageOpenaiService,
    CreateMp3OpenaiDto,
    CreateMp3OpenaiService,
)


def test_create_image() -> None:
    """Prueba CreateImageOpenaiService con un prompt simple."""
    print("\n" + "=" * 60)
    print("TEST: CreateImageOpenaiService")
    print("=" * 60)

    dto = CreateImageOpenaiDto(
        prompt="A friendly robot helping a child learn to code",
        image_model="gpt-image-1.5",
        size="1024x1024",
        quality="low",
        number_of_images=1,
    )

    print(f"Prompt: {dto.prompt}")
    print(f"Model: {dto.model}")
    print(f"Size: {dto.size}")
    print(f"Quality: {dto.quality}")

    result = CreateImageOpenaiService.get_instance()(dto)

    print(f"\n✅ Imagen generada correctamente")
    print(f"   - Tamaño b64: {len(result['images'][0]['b64_json'])} caracteres")
    print(f"   - Modelo usado: {result['model']}")
    print(f"   - Tamaño: {result['size']}")
    print(f"   - Calidad: {result['quality']}")


def test_create_mp3() -> None:
    """Prueba CreateMp3OpenaiService con un texto simple."""
    print("\n" + "=" * 60)
    print("TEST: CreateMp3OpenaiService")
    print("=" * 60)

    dto = CreateMp3OpenaiDto(
        text="Hello! This is a test of the OpenAI text to speech service.",
        voice="nova",
        tts_model="tts-1",
        speed=1.0,
        response_format="mp3",
    )

    print(f"Text: {dto.text}")
    print(f"Voice: {dto.voice}")
    print(f"Model: {dto.model}")
    print(f"Speed: {dto.speed}x")
    print(f"Format: {dto.response_format}")

    result = CreateMp3OpenaiService.get_instance()(dto)

    print(f"\n✅ Audio generado correctamente")
    print(f"   - Tamaño b64: {len(result['audio_b64'])} caracteres")
    print(f"   - MIME type: {result['mime_type']}")
    print(f"   - Voz usada: {result['voice']}")
    print(f"   - Modelo usado: {result['model']}")
    print(f"   - Formato: {result['format']}")


def test_dto_validations() -> None:
    """Prueba las validaciones de los DTOs."""
    print("\n" + "=" * 60)
    print("TEST: Validaciones de DTOs")
    print("=" * 60)

    # Test 1: Prompt vacío
    try:
        CreateImageOpenaiDto(prompt="")
        print("❌ FAIL: Debería rechazar prompt vacío")
    except ValueError as e:
        print(f"✅ PASS: Prompt vacío rechazado - {e}")

    # Test 2: number_of_images fuera de rango
    try:
        CreateImageOpenaiDto(prompt="Test", number_of_images=15)
        print("❌ FAIL: Debería rechazar number_of_images > 10")
    except ValueError as e:
        print(f"✅ PASS: number_of_images=15 rechazado - {e}")

    # Test 3: Speed fuera de rango
    try:
        CreateMp3OpenaiDto(text="Test", speed=5.0)
        print("❌ FAIL: Debería rechazar speed > 4.0")
    except ValueError as e:
        print(f"✅ PASS: speed=5.0 rechazado - {e}")

    # Test 4: Texto excede límite
    try:
        CreateMp3OpenaiDto(text="a" * 5000)
        print("❌ FAIL: Debería rechazar texto > 4096 caracteres")
    except ValueError as e:
        print(f"✅ PASS: Texto largo rechazado - {e}")

    # Test 5: dall-e-3 con tamaño no soportado
    try:
        CreateImageOpenaiDto(prompt="Test", image_model="dall-e-3", size="256x256")
        print("❌ FAIL: Debería rechazar dall-e-3 con 256x256")
    except ValueError as e:
        print(f"✅ PASS: Combinación inválida rechazada - {e}")


if __name__ == "__main__":
    print("\n🚀 Iniciando tests de OpenAI Services...")
    print("=" * 60)

    # Test validaciones (no requiere API key)
    test_dto_validations()

    # Tests que requieren API key (comentar si no está configurada)
    try:
        test_create_image()
        test_create_mp3()
    except Exception as e:
        print(f"\n⚠️  Tests de API omitidos: {e}")
        print("   Verifica que OPENAI_API_KEY esté configurada en .env")

    print("\n" + "=" * 60)
    print("✅ Tests completados")
    print("=" * 60 + "\n")
