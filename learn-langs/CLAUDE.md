# CLAUDE.md - Learn Languages App

Este archivo proporciona contexto a Claude Code para trabajar con este repositorio.

---

## Skills (centralizadas en dev-ops)

**Path**: `C:/projects/temper/ai/obsidian/dev-ops/skills`

| Categoria | Skills |
|-----------|--------|
| Base | `_base/commits/`, `_base/ddd-architecture/`, `_base/karpathy-guidelines/` |
| Python | `python/clean-code/`, `python/python-pro/`, `python/flet-gui/`, `python/sqlite/`, `python/async-patterns/` |

---

## Overview

Aplicación de aprendizaje de idiomas con sistema de repetición espaciada (Spaced Repetition - SM-2). Permite gestionar vocabulario en español con traducciones a múltiples idiomas, realizar sesiones de estudio con métricas de progreso, y aplicar algoritmos de refuerzo basados en errores y tiempo.

## Tech Stack

- **Python 3.12+**
- **UI Framework**: Flet (multiplataforma: Windows, Mac, Linux, Web, Mobile)
- **Base de datos**: SQLite
- **Arquitectura**: Domain-Driven Design (DDD)
- **Validación**: Pydantic V2
- **Async**: asyncio + aiosqlite

## Estructura del Proyecto

```
learn-langs/
├── main.py                              # Entry point Flet
├── requirements.txt
├── .env
├── CLAUDE.md
├── .claude/
│   └── settings.local.json              # Permisos del proyecto
│
├── data/
│   ├── learn_lang.db                    # Base de datos SQLite
│   └── images/                          # Imagenes de palabras
│
└── ddd/
    ├── __init__.py
    │
    ├── shared/                          # Bounded Context compartido
    │   ├── domain/
    │   │   └── enums/
    │   │       ├── response_code_enum.py
    │   │       └── envvars_keys_enum.py
    │   └── infrastructure/
    │       ├── components/
    │       │   ├── logger.py
    │       │   ├── response_dto.py
    │       │   ├── date_timer.py
    │       │   └── ...
    │       └── repositories/
    │           ├── environment_reader_raw_repository.py
    │           └── sqlite_connection.py
    │
    └── vocabulary/                      # Bounded Context principal
        │
        ├── application/                 # Casos de uso
        │   ├── create_word/
        │   │   ├── create_word_dto.py
        │   │   ├── create_word_result_dto.py
        │   │   └── create_word_service.py
        │   ├── update_word/
        │   ├── delete_word/
        │   ├── get_words/
        │   ├── create_translation/
        │   ├── manage_tags/
        │   ├── link_words/
        │   ├── start_study_session/
        │   ├── get_next_word/
        │   ├── record_answer/
        │   ├── finish_study_session/
        │   └── get_study_stats/
        │
        ├── domain/
        │   ├── entities/
        │   │   ├── word_es_entity.py
        │   │   ├── word_lang_entity.py
        │   │   ├── tag_entity.py
        │   │   ├── word_metric_entity.py
        │   │   ├── study_session_entity.py
        │   │   ├── session_answer_entity.py
        │   │   ├── language_entity.py
        │   │   └── word_image_entity.py
        │   ├── enums/
        │   │   ├── language_code_enum.py
        │   │   ├── word_type_enum.py
        │   │   ├── study_mode_enum.py
        │   │   ├── relation_type_enum.py
        │   │   └── image_source_enum.py
        │   ├── exceptions/
        │   │   └── vocabulary_exception.py
        │   └── services/
        │       ├── spaced_repetition_service.py
        │       └── score_calculator_service.py
        │
        └── infrastructure/
            ├── repositories/
            │   ├── abstract_vocabulary_repository.py
            │   ├── words_es_reader_sqlite_repository.py
            │   ├── words_es_writer_sqlite_repository.py
            │   ├── words_lang_reader_sqlite_repository.py
            │   ├── words_lang_writer_sqlite_repository.py
            │   ├── tags_reader_sqlite_repository.py
            │   ├── tags_writer_sqlite_repository.py
            │   ├── metrics_reader_sqlite_repository.py
            │   ├── metrics_writer_sqlite_repository.py
            │   ├── sessions_reader_sqlite_repository.py
            │   ├── sessions_writer_sqlite_repository.py
            │   ├── answers_reader_sqlite_repository.py
            │   ├── answers_writer_sqlite_repository.py
            │   ├── word_relations_reader_sqlite_repository.py
            │   ├── word_relations_writer_sqlite_repository.py
            │   ├── images_reader_sqlite_repository.py
            │   └── images_writer_sqlite_repository.py
            │
            ├── ui/
            │   ├── views/
            │   │   ├── home_view.py
            │   │   ├── study_view.py
            │   │   ├── word_crud_view.py
            │   │   └── stats_view.py
            │   └── components/
            │       ├── flashcard_comp.py
            │       ├── timer_comp.py
            │       └── input_field_comp.py
            │
            └── persistence/
                └── migrations/
                    ├── 001_initial_schema.sql
                    └── 002_word_images.sql
```

---

## Modelo de Datos

### Diagrama Entidad-Relación

```
┌─────────────────────┐
│      words_es       │  ← Tabla principal (español como origen)
├─────────────────────┤
│ id (PK)             │
│ text                │  ← Texto en español
│ word_type           │  ← WORD, PHRASE, SENTENCE
│ notes               │  ← Notas/contexto (nullable)
│ created_at          │
│ updated_at          │
└────────┬────────────┘
         │
         ├──── 1:N ────┐
         │             ▼
         │   ┌─────────────────────┐
         │   │   word_es_images    │  ← Imagenes de la palabra
         │   ├─────────────────────┤
         │   │ id (PK)             │
         │   │ word_es_id (FK)     │
         │   │ source_type         │  ← SCREENSHOT, CLIPBOARD, CAMERA, URL, LOCAL, VECTORIAL
         │   │ file_path           │  ← Ruta relativa en data/images/
         │   │ original_url        │  ← URL original (si aplica)
         │   │ mime_type           │  ← image/png, image/jpeg, image/svg+xml...
         │   │ width, height       │  ← Dimensiones (nullable para SVG)
         │   │ file_size           │  ← Tamano en bytes
         │   │ svg_content         │  ← Contenido SVG inline (opcional)
         │   │ caption, alt_text   │  ← Metadatos descriptivos
         │   │ sort_order          │  ← Orden de visualizacion
         │   │ is_primary          │  ← 1 = imagen principal
         │   │ is_active           │  ← 0 = soft delete
         │   └─────────────────────┘
         │
         │ 1:N
         ▼
┌─────────────────────┐
│     words_lang      │  ← Traducciones a otros idiomas
├─────────────────────┤
│ id (PK)             │
│ word_es_id (FK)     │  ← Referencia a palabra español
│ lang_code           │  ← nl_NL, en_US, en_GB, de_DE, fr_FR...
│ text                │  ← Traducción en el idioma destino
│ pronunciation       │  ← Pronunciación/fonética (nullable)
│ audio_path          │  ← Audio pronunciación (nullable)
│ notes               │  ← Notas específicas idioma (nullable)
│ created_at          │
│ updated_at          │
│                     │
│ UNIQUE(word_es_id, lang_code)
└─────────────────────┘

┌─────────────────────┐
│   word_metrics      │  ← Métricas SM-2 por palabra+idioma
├─────────────────────┤
│ id (PK)             │
│ word_es_id (FK)     │
│ lang_code           │  ← Métricas separadas por idioma destino
│ repetitions         │  ← Veces consecutivas correctas
│ easiness_factor     │  ← EF del algoritmo SM-2 (default 2.5)
│ interval_days       │  ← Días hasta próximo repaso
│ next_review_at      │  ← Fecha próximo repaso
│ last_reviewed_at    │
│ total_attempts      │  ← Total intentos histórico
│ total_score         │  ← Suma de scores (para promedio)
│                     │
│ UNIQUE(word_es_id, lang_code)
└─────────────────────┘

┌─────────────────────┐
│   study_sessions    │  ← Sesión de repaso/examen
├─────────────────────┤
│ id (PK)             │
│ lang_code           │  ← Idioma destino de la sesión
│ study_mode          │  ← TYPING, PRESENTATION
│ started_at          │
│ finished_at         │  ← NULL si en progreso
│ total_words         │
│ total_score         │
│ average_score       │
│ tags_filter         │  ← JSON array (nullable)
└────────┬────────────┘
         │
         │ 1:N
         ▼
┌─────────────────────┐
│   session_answers   │  ← Historial de respuestas por sesión
├─────────────────────┤
│ id (PK)             │
│ session_id (FK)     │
│ word_es_id (FK)     │
│ user_input          │  ← Respuesta del usuario (nullable si PRESENTATION)
│ expected_text       │  ← Texto correcto (desnormalizado para histórico)
│ score               │  ← 0.0 a 1.0 (0=mal, 0.x=parcial, 1=correcto)
│ response_time_ms    │  ← Tiempo de respuesta en ms
│ answered_at         │
└─────────────────────┘

┌─────────────────────┐
│        tags         │
├─────────────────────┤
│ id (PK)             │
│ name (UQ)           │
│ color               │  ← Hex para UI (#FF5733)
│ created_at          │
└────────┬────────────┘
         │
         │ N:M
         ▼
┌─────────────────────┐
│    word_es_tags     │
├─────────────────────┤
│ word_es_id (FK)     │  ← PK compuesta
│ tag_id (FK)         │
└─────────────────────┘

┌─────────────────────┐
│  word_es_relations  │  ← Relaciones N:M entre palabras ES
├─────────────────────┤
│ word_es_id_a (FK)   │  ← PK compuesta
│ word_es_id_b (FK)   │
│ relation_type       │  ← SYNONYM, ANTONYM, RELATED, CONJUGATION
└─────────────────────┘

┌─────────────────────┐
│     languages       │  ← Catálogo de idiomas disponibles
├─────────────────────┤
│ code (PK)           │  ← nl_NL, en_US, de_DE...
│ name                │  ← Nederlands, English, Deutsch...
│ native_name         │  ← Nederlands, English, Deutsch...
│ flag_emoji          │  ← 🇳🇱, 🇺🇸, 🇩🇪...
│ is_active           │  ← Para habilitar/deshabilitar
└─────────────────────┘
```

### Códigos de Idioma (ISO 639-1 + País)

| code   | name        | native_name  | flag |
|--------|-------------|--------------|------|
| nl_NL  | Dutch       | Nederlands   | 🇳🇱   |
| nl_BE  | Flemish     | Vlaams       | 🇧🇪   |
| en_US  | English US  | English      | 🇺🇸   |
| en_GB  | English UK  | English      | 🇬🇧   |
| de_DE  | German      | Deutsch      | 🇩🇪   |
| fr_FR  | French      | Français     | 🇫🇷   |
| pt_BR  | Portuguese  | Português    | 🇧🇷   |
| it_IT  | Italian     | Italiano     | 🇮🇹   |

---

## Algoritmos Core

### Score Calculator (0.0 a 1.0)

```python
def calculate_score(expected: str, user_input: str) -> float:
    """
    Calcula score de 0.0 a 1.0 basado en similitud Levenshtein.

    Returns:
        0.0  - Sin respuesta o completamente incorrecto (<50% similar)
        0.1-0.9 - Parcialmente correcto
        1.0  - Exactamente correcto
    """
    if not user_input or not user_input.strip():
        return 0.0

    expected_clean = expected.lower().strip()
    input_clean = user_input.lower().strip()

    if expected_clean == input_clean:
        return 1.0

    distance = levenshtein_distance(expected_clean, input_clean)
    max_len = max(len(expected_clean), len(input_clean))
    similarity = 1 - (distance / max_len)

    if similarity < 0.5:
        return 0.0

    return round(similarity, 2)
```

### Spaced Repetition (SM-2 Modificado)

```python
def calculate_next_review(
    quality: float,  # score 0.0-1.0, convertido a 0-5
    repetitions: int,
    easiness: float,
    interval: int
) -> tuple[int, float, int]:
    """
    Algoritmo SM-2 usado por Anki.

    Args:
        quality: 0-5 (0-2 = error, 3-5 = correcto)
        repetitions: veces consecutivas correctas
        easiness: factor de facilidad (default 2.5)
        interval: días hasta próximo repaso

    Returns:
        (new_repetitions, new_easiness, new_interval)
    """
    # Convertir score 0-1 a quality 0-5
    quality_int = int(quality * 5)

    if quality_int < 3:  # Error
        repetitions = 0
        interval = 1
    else:
        if repetitions == 0:
            interval = 1
        elif repetitions == 1:
            interval = 6
        else:
            interval = round(interval * easiness)
        repetitions += 1

    # Ajustar factor de facilidad
    easiness = max(1.3, easiness + 0.1 - (5 - quality_int) * (0.08 + (5 - quality_int) * 0.02))

    return repetitions, easiness, interval
```

---

## Flujo de Estudio

```
1. Usuario selecciona:
   - Idioma destino: nl_NL
   - Tags: ["verbos", "básico"]
   - Modo: TYPING o PRESENTATION

2. Sistema crea study_session:
   - lang_code: nl_NL
   - study_mode: TYPING
   - tags_filter: ["verbos", "básico"]

3. Sistema selecciona palabras (SM-2):
   - JOIN words_es + words_lang (nl_NL) + word_metrics
   - Filtrar por tags
   - Ordenar por next_review_at (prioriza vencidas)
   - Aplicar algoritmo de refuerzo

4. Por cada palabra mostrada:
   - Muestra: text de words_es (español) + timer
   - TYPING: Usuario escribe traducción
   - PRESENTATION: Usuario presiona Enter para continuar
   - Sistema compara con words_lang.text (nl_NL)
   - Calcula score 0.0-1.0
   - Si error: muestra palabra correcta 5 segundos
   - Guarda en session_answers
   - Actualiza word_metrics

5. Al finalizar sesión:
   - Calcula average_score
   - Actualiza finished_at
   - Muestra resumen de estadísticas
```

---

## Patrones DDD del Proyecto

### DTOs (Data Transfer Objects)

```python
@dataclass(frozen=True, slots=True)
class CreateWordDto:
    """Input DTO - inmutable."""
    text: str
    word_type: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            text=str(primitives.get("text", "")).strip(),
            word_type=str(primitives.get("word_type", "WORD")),
        )
```

### Services (Casos de Uso)

```python
@final
class CreateWordService:
    """Orquesta la lógica del caso de uso."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: CreateWordDto) -> CreateWordResultDto:
        # Validar
        # Ejecutar lógica
        # Persistir via repository
        # Retornar resultado
        pass
```

### Repositories (Reader/Writer Separados)

```python
class WordsEsReaderSqliteRepository:
    """Solo operaciones de lectura."""

    async def get_by_id(self, word_id: int) -> dict | None:
        pass

    async def get_all(self, filters: dict) -> list[dict]:
        pass

class WordsEsWriterSqliteRepository:
    """Solo operaciones de escritura."""

    async def create(self, data: dict) -> dict:
        pass

    async def update(self, word_id: int, data: dict) -> dict:
        pass

    async def delete(self, word_id: int) -> bool:
        pass
```

### Exceptions (Factory Methods)

```python
@final
class VocabularyException(Exception):
    _code: int
    _message: str

    @classmethod
    def word_not_found(cls, word_id: int) -> "VocabularyException":
        return cls(f"Word #{word_id} not found", ResponseCodeEnum.NOT_FOUND)

    @classmethod
    def translation_already_exists(cls, word_id: int, lang: str) -> "VocabularyException":
        return cls(f"Translation {lang} already exists for word #{word_id}", ResponseCodeEnum.CONFLICT)
```

---

## Comandos de Desarrollo

```bash
# Crear entorno virtual
python -m venv .venv-win
.venv-win\Scripts\activate

# Instalar dependencias
pip install -r requirements.txt

# Ejecutar app
python main.py

# Linting y formato
ruff check --fix .
ruff format .

# Type checking
mypy ddd/

# Tests
pytest tests/ -v
```

---

## Paths Mapping (WSL/Windows)

```
/mnt/c/projects/prj_python37/learn-langs -> C:\projects\prj_python37\learn-langs
```