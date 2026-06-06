# OpenAI Services - Ejemplos de Uso

Casos de uso genéricos para generación de imágenes y audio con OpenAI API.

---

## CreateImageOpenaiService

Genera imágenes con modelos de OpenAI (gpt-image-1.5, dall-e-3, dall-e-2).

### Ejemplo básico

```python
from ddd.open_ai.application import CreateImageOpenaiDto, CreateImageOpenaiService

# Crear DTO con parámetros
dto = CreateImageOpenaiDto(
    prompt="A futuristic city with flying cars at sunset",
    model="gpt-image-1.5",
    size="1024x1024",
    quality="low",
    n=1
)

# Ejecutar servicio
# Usar patrón get_instance() + __call__()
result = CreateImageOpenaiService.get_instance()(dto)

# Resultado
print(result["images"][0]["b64_json"])  # Imagen en base64
print(result["model"])                   # "gpt-image-1.5"
print(result["size"])                    # "1024x1024"
```

### Ejemplo con dall-e-3

```python
from ddd.open_ai.application import CreateImageOpenaiDto, CreateImageOpenaiService

dto = CreateImageOpenaiDto(
    prompt="A cyberpunk hacker in a neon-lit room",
    model="dall-e-3",
    size="1792x1024",  # Tamaño horizontal disponible en dall-e-3
    quality="high",
    style="vivid",     # Solo para dall-e-3
    n=1
)

# Usar patrón get_instance() + __call__()
result = CreateImageOpenaiService.get_instance()(dto)

# dall-e-3 puede revisar el prompt
if result["images"][0]["revised_prompt"]:
    print("Prompt revisado:", result["images"][0]["revised_prompt"])
```

### Ejemplo educativo (estilo learn-lang)

```python
from ddd.open_ai.application import CreateImageOpenaiDto, CreateImageOpenaiService

# Construir prompt educativo manualmente
word = "apple"
style_prompt = (
    "Kawaii style, flat colors, minimalist, educational, "
    "clean white background, vector art style, "
    "NO TEXT, NO WORDS, only visual representation"
)

dto = CreateImageOpenaiDto(
    prompt=f"A cute cartoon illustration of a {word}. {style_prompt}",
    model="gpt-image-1.5",
    size="1024x1024",
    quality="low",
    n=1
)

# Usar patrón get_instance() + __call__()
result = CreateImageOpenaiService.get_instance()(dto)
```

---

## CreateMp3OpenaiService

Genera audio TTS con modelos de OpenAI (tts-1, tts-1-hd).

### Ejemplo básico

```python
from ddd.open_ai.application import CreateMp3OpenaiDto, CreateMp3OpenaiService

# Crear DTO con parámetros
dto = CreateMp3OpenaiDto(
    text="Hello, this is a test of text to speech",
    voice="alloy",
    model="tts-1",
    speed=1.0,
    response_format="mp3"
)

# Ejecutar servicio
# Usar patrón get_instance() + __call__()
result = CreateImageOpenaiService.get_instance()(dto)

# Resultado
print(result["audio_b64"])    # Audio en base64
print(result["mime_type"])    # "audio/mpeg"
print(result["voice"])        # "alloy"
```

### Ejemplo con voz femenina y velocidad lenta

```python
from ddd.open_ai.application import CreateMp3OpenaiDto, CreateMp3OpenaiService

dto = CreateMp3OpenaiDto(
    text="The quick brown fox jumps over the lazy dog",
    voice="nova",      # Voz femenina energética
    model="tts-1-hd",  # Alta calidad
    speed=0.75,        # 75% velocidad normal
    response_format="mp3"
)

# Usar patrón get_instance() + __call__()
result = CreateImageOpenaiService.get_instance()(dto)
```

### Ejemplo con formato WAV

```python
from ddd.open_ai.application import CreateMp3OpenaiDto, CreateMp3OpenaiService

dto = CreateMp3OpenaiDto(
    text="This will be in WAV format",
    voice="echo",
    model="tts-1",
    speed=1.0,
    response_format="wav"  # Formato WAV en lugar de MP3
)

# Usar patrón get_instance() + __call__()
result = CreateImageOpenaiService.get_instance()(dto)

print(result["mime_type"])  # "audio/wav"
print(result["format"])     # "wav"
```

---

## Voces disponibles

| Voz | Características |
|-----|-----------------|
| `alloy` | Neutral, versátil |
| `echo` | Masculina, clara |
| `fable` | Británica, expresiva |
| `onyx` | Masculina, profunda |
| `nova` | Femenina, energética |
| `shimmer` | Femenina, suave |

---

## Formatos de audio disponibles

- `mp3` (default) - MPEG Audio Layer III
- `opus` - Opus codec (alta compresión)
- `aac` - Advanced Audio Coding
- `flac` - Free Lossless Audio Codec
- `wav` - Waveform Audio File Format
- `pcm` - Pulse-Code Modulation (raw audio)

---

## Validaciones de DTOs

Los DTOs validan automáticamente los parámetros:

```python
# Esto lanzará ValueError
dto = CreateImageOpenaiDto(
    prompt="",  # ❌ Prompt vacío
    n=15        # ❌ n debe estar entre 1-10
)

# Esto lanzará ValueError
dto = CreateMp3OpenaiDto(
    text="Test",
    speed=5.0   # ❌ speed debe estar entre 0.25-4.0
)

# Esto lanzará ValueError
dto = CreateImageOpenaiDto(
    prompt="Test",
    model="dall-e-3",
    size="256x256"  # ❌ dall-e-3 no soporta 256x256
)
```
