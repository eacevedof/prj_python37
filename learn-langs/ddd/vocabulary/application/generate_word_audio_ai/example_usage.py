"""
Ejemplo de uso del servicio GenerateWordAudioAiService.

Este script demuestra cómo generar audio de pronunciación
para traducciones existentes en la base de datos.
"""

import asyncio

from ddd.vocabulary.application.generate_word_audio_ai import (
    GenerateWordAudioAiDto,
    GenerateWordAudioAiService,
)


async def example_generate_audio_for_translation():
    """Ejemplo básico: generar audio para una traducción existente."""

    print("\n=== Ejemplo 1: Generar audio para traducción (automático) ===\n")

    # Obtener instancia del servicio
    audio_service = GenerateWordAudioAiService.get_instance()

    # Generar audio para word_lang_id = 1 (debe existir en BD)
    # La voz se selecciona automáticamente según el lang_code
    dto = GenerateWordAudioAiDto.from_primitives({
        "word_lang_id": 1,  # ID de traducción en words_lang
        # text y lang_code se obtienen de BD automáticamente
    })

    result = await audio_service(dto)

    if result.success:
        print(f"✓ Audio generado exitosamente")
        print(f"  - ID traducción: {result.word_lang_id}")
        print(f"  - Texto: '{result.text_generated}'")
        print(f"  - Voz usada: {result.voice_used}")
        print(f"  - Modelo: {result.model_used}")
        print(f"  - Guardado en: {result.audio_path}")
    else:
        print(f"✗ Error: {result.error_message}")


async def example_generate_audio_custom_voice():
    """Ejemplo con voz y velocidad personalizadas."""

    print("\n=== Ejemplo 2: Generar audio con voz personalizada ===\n")

    audio_service = GenerateWordAudioAiService.get_instance()

    # Generar audio con voz específica
    dto = GenerateWordAudioAiDto.from_primitives({
        "word_lang_id": 1,
        "voice": "shimmer",  # Voz femenina suave
        "speed": 0.9,  # 10% más lento
    })

    result = await audio_service(dto)

    if result.success:
        print(f"✓ Audio con voz personalizada generado")
        print(f"  - Voz: {result.voice_used}")
        print(f"  - Archivo: {result.audio_path}")
    else:
        print(f"✗ Error: {result.error_message}")


async def example_batch_generate_multiple_translations():
    """Ejemplo: generar audio para múltiples traducciones."""

    print("\n=== Ejemplo 3: Generar audio en lote ===\n")

    audio_service = GenerateWordAudioAiService.get_instance()

    # Lista de word_lang_ids a procesar
    word_lang_ids = [1, 2, 3, 4, 5]

    results = []

    for word_lang_id in word_lang_ids:
        dto = GenerateWordAudioAiDto.from_primitives({
            "word_lang_id": word_lang_id,
        })

        result = await audio_service(dto)
        results.append(result)

        if result.success:
            print(f"✓ [{word_lang_id}] Audio generado: {result.audio_path}")
        else:
            print(f"✗ [{word_lang_id}] Error: {result.error_message}")

    # Resumen
    success_count = sum(1 for r in results if r.success)
    print(f"\nResumen: {success_count}/{len(results)} audios generados exitosamente")


async def example_override_text():
    """Ejemplo: generar audio para texto personalizado."""

    print("\n=== Ejemplo 4: Generar audio con texto personalizado ===\n")

    audio_service = GenerateWordAudioAiService.get_instance()

    # Sobrescribir texto (útil para pronunciaciones alternativas)
    dto = GenerateWordAudioAiDto.from_primitives({
        "word_lang_id": 1,
        "text": "Hallo daar! Hoe gaat het vandaag?",  # Texto personalizado
        "lang_code": "nl_NL",  # Especificar idioma
        "speed": 0.85,  # Más lento para aprender
    })

    result = await audio_service(dto)

    if result.success:
        print(f"✓ Audio con texto personalizado generado")
        print(f"  - Texto: '{result.text_generated}'")
        print(f"  - Archivo: {result.audio_path}")
    else:
        print(f"✗ Error: {result.error_message}")


async def main():
    """Ejecutar todos los ejemplos."""

    print("\n" + "="*60)
    print("EJEMPLOS DE USO: GenerateWordAudioAiService")
    print("="*60)

    try:
        # Ejemplo 1: Básico
        await example_generate_audio_for_translation()

        # Ejemplo 2: Voz personalizada
        await example_generate_audio_custom_voice()

        # Ejemplo 3: Batch
        await example_batch_generate_multiple_translations()

        # Ejemplo 4: Texto personalizado
        await example_override_text()

    except Exception as e:
        print(f"\n✗ Error general: {e}")

    print("\n" + "="*60)
    print("NOTAS:")
    print("- Los word_lang_id deben existir en la tabla words_lang")
    print("- Los audios se guardan en data/audio/")
    print("- El audio_path se actualiza automáticamente en BD")
    print("- Voces disponibles: alloy, echo, fable, onyx, nova, shimmer")
    print("="*60 + "\n")


if __name__ == "__main__":
    asyncio.run(main())
