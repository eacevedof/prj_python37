# Content Chunking Strategy for ChromaDB

How content is split before storage in ChromaDB.

---

## El Problema: Archivos enormes

```
UserService.java (3000 líneas)

❌ Opción 1: Guardar completo
   - Size: 50-100 KB
   - Tokens: 12,500-25,000
   - Problemas:
     ✗ Embedding muy lento
     ✗ Contexto perdido en búsqueda
     ✗ Sobre el límite de sentence-transformers

❌ Opción 2: Truncar a 10KB
   - Pierde 90% del contenido
   - Se corta en mitad de métodos
   - Información incompleta

✅ Opción 3: Chunking inteligente
   - Divide en 500 tokens por chunk
   - Mantiene límites semánticos (métodos completos)
   - Todos los chunks son consultables
   - Óptimo para embeddings
```

---

## Tamaños recomendados

```
CONVERSIÓN:
  1 token ≈ 4 caracteres
  1 token ≈ 0.75 palabras

RANGO ÓPTIMO:
  ├─ Mínimo:  100 tokens    (400 chars,   ~130 palabras)  - Muy pequeño
  ├─ Ideal:   500 tokens   (2000 chars,  ~660 palabras)  ← USAR ESTE
  ├─ Máximo:  700 tokens   (2800 chars,  ~930 palabras)  - Contexto máx
  └─ Hard limit: 1000 tokens (4000 chars, ~1330 palabras) - sentence-transformers

PARA CHROMADB:
  Búsqueda: 500 tokens (mejor similitud + contexto)
  Inyección: 700 tokens (máximo contexto sin saturar)
  Embeddings: < 1000 tokens (límite del modelo)
```

---

## Estrategia por tipo de archivo

### 1. **Código fuente** (.py, .java, .ts, .js, .go, .rb, .rs)

**Estrategia**: Chunking por función/método/clase

```
INPUT: UserService.java (3000 líneas)

CHUNKING:
Chunk 1: package imports + class definition      (150 tokens)
Chunk 2: constructor + init methods             (450 tokens)
Chunk 3: validate_email + validate_password     (480 tokens)
Chunk 4: create_user method                     (520 tokens)
Chunk 5: update_user + helper methods           (510 tokens)
...

VENTAJAS:
✓ Métodos completos (no cortados a mitad)
✓ Contexto semántico preservado
✓ Fácil de navegar
✓ Óptimo para búsqueda

RESULTADO: 6-8 chunks (vs 1 grande o 50 pequeños)
```

### 2. **Markdown** (.md, .txt, documentación)

**Estrategia**: Chunking por headers (H1, H2, H3)

```
INPUT: README.md

# Installation     ← H1 header
## Prerequisites   ← H2 section
## Setup          ← H2 section

CHUNKING:
Chunk 1: # Installation
         ## Prerequisites
         (content) ~450 tokens

Chunk 2: ## Setup
         (content) ~520 tokens

VENTAJAS:
✓ Secciones completas
✓ Contexto de documentación
✓ Fácil de buscar por tema

RESULTADO: 3-5 chunks por documento
```

### 3. **Configuración** (.yaml, .json, .xml, .toml)

**Estrategia**: Guardar completo (usualmente pequeño) o por secciones

```
INPUT: pom.xml, application.yml

CHUNKING:
- Si < 500 tokens: 1 chunk completo
- Si > 500 tokens: por bloques lógicos
  (dependencies, properties, plugins, etc)

VENTAJAS:
✓ Config siempre completa para búsqueda
✓ Rápido de procesar
✓ Pocas excepciones

RESULTADO: 1-3 chunks
```

---

## Algoritmo de chunking por tipo

### Código Fuente (Source Code Chunking)

```
1. Split por líneas
2. Busca límites de función/método/clase:
   def function()      (Python)
   public void method() (Java)
   function() {}       (JavaScript)
3. Cuando acumulas ~500 tokens:
   - Si ESTÁS en mitad de un método: sigue
   - Si TERMINASTE un método: guarda chunk
4. Continúa con siguiente método
5. Siempre mantiene métodos enteros
```

**Ejemplo:**
```python
# Chunk 1
class UserService:
    def __init__(self):
        self.db = Database()
        self.logger = Logger()
    # Total: 150 tokens

# Chunk 2
    def validate_email(self, email):
        if not email:
            raise ValidationError("Email required")
        if "@" not in email:
            raise ValidationError("Invalid email")
        return True

    def validate_password(self, password):
        if len(password) < 8:
            raise ValidationError("Password too short")
        return True
    # Total: 480 tokens

# Chunk 3
    def create_user(self, email, password):
        ...
    # Total: 520 tokens
```

### Markdown Chunking

```
1. Split por headers (^## , ^### )
2. Agrupa header + contenido
3. Cuando acumulas ~500 tokens:
   - Guarda chunk actual
4. Inicia nuevo chunk con next header
5. Mantiene secciones coherentes
```

**Ejemplo:**
```markdown
# Installation

## Prerequisites
- Python 3.8+
- PostgreSQL 12+
- Redis 6+
[...content...] 

Total: ~420 tokens → Chunk 1

## Setup Steps
1. Clone repository
2. Install dependencies
3. Configure .env
[...content...]

Total: ~480 tokens → Chunk 2
```

---

## Uso: ContentChunkerRepository

### Básico

```python
from ddd.ia_memory.infrastructure.repositories import ContentChunkerRepository

chunker = ContentChunkerRepository.get_instance()

# Chunking automático por tipo de archivo
chunks = chunker.chunk_by_file_type(
    content="def foo():\n  pass\n...",
    file_path="services/user_service.py",
    chunk_size=500  # tokens
)

# Resultado
for chunk in chunks:
    print(f"Token count: {chunk['token_count']}")
    print(f"Content: {chunk['content']}")
    print(f"Metadata: {chunk['metadata']}")
```

### Con validación

```python
# Chunking + validación
chunks = chunker.chunk_and_validate(
    content=content,
    file_path="service.py",
    chunk_size=500
)

# Si hay chunks oversized, logs aparecen
# Pero chunks se retornan de todas formas
```

### Tipos de archivos soportados

```
CÓDIGO:
  Python:      .py
  Java:        .java
  TypeScript:  .ts
  JavaScript:  .js
  Go:          .go
  Ruby:        .rb
  Rust:        .rs
  
DOCUMENTACIÓN:
  Markdown:    .md
  Texto:       .txt
  
CONFIGURACIÓN:
  YAML:        .yaml, .yml
  JSON:        .json
  XML:         .xml
  TOML:        .toml

FALLBACK: Chunking genérico para otros tipos
```

---

## Integración con servicios

### En InitializeProjectService

```python
# ANTES: truncaba a 10KB
if len(content) > 10000:
    content = content[:10000] + "\n... (truncated)"

# AHORA: chunking inteligente
from ddd.ia_memory.infrastructure.repositories import ContentChunkerRepository

chunker = ContentChunkerRepository.get_instance()
chunks = chunker.chunk_by_file_type(
    content=content,
    file_path=str(source_file),
    chunk_size=500
)

# Guardar cada chunk
for chunk in chunks:
    await self._store_memory_service(
        StoreMemoryDto(
            project=dto.project_name,
            memory_type=MemoryTypeEnum.APPLICATION,
            content=chunk["content"],
            paths=[str(source_file)],
            metadata=chunk["metadata"]
        )
    )
```

### En StoreFileService

```python
chunks = file_processor.process_file(dto.file_path)

# NUEVO: re-chunking de contenido procesado
for chunk in chunks:
    # Si el contenido es grande, re-chunkear
    if len(chunk["content"]) > 4000:  # ~1000 tokens
        sub_chunks = chunker.chunk_by_file_type(
            content=chunk["content"],
            file_path=dto.file_path,
            chunk_size=500
        )
        for sub_chunk in sub_chunks:
            # Guardar sub-chunk
    else:
        # Guardar como está
```

---

## Métricas esperadas

### Proyecto típico (10k líneas)

```
Archivo                     Líneas    Chunks   Promedio/chunk
─────────────────────────────────────────────────────────────
AuthController.java         800       2        400 líneas
UserService.java            1200      3        400 líneas
ProductService.java         950       2        475 líneas
AuthRepository.java         600       1        600 líneas
config/application.yml      150       1        150 líneas
README.md                   300       1        300 líneas
CLAUDE.md                   250       1        250 líneas
─────────────────────────────────────────────────────────────
TOTAL                       ~4250     ~11      ~380 líneas/chunk

ChromaDB chunks indexados: ~11
Tokens totales: ~5500 (11 chunks × 500 tokens)
Size en disco: ~50-100 KB (ChromaDB)
```

### Proyecto grande (100k líneas)

```
Chunks indexados: ~110
Size en disco: ~500 KB - 1 MB
Búsqueda: <100ms por query
Saturación: Ninguna (cada pregunta Top-5)
```

---

## Quality vs Performance

```
Chunk Size   Quality    Perf    Casos
─────────────────────────────────────
100 tokens   ❌ Mala    ✅ Rápido   - Demasiado fragmentado
300 tokens   🟡 Buena   ✅ Rápido   - Poco contexto
500 tokens   ✅ Óptimo  ✅ Rápido   ← USAR ESTE
700 tokens   ✅ Bueno   🟡 Normal   - Contexto máx
1000 tokens  🟡 Mucho   ❌ Lento    - Límite absoluto
```

**Recomendación: 500 tokens (default)**

---

## Logging y debugging

```python
# Si chunks son oversized
chunker.chunk_and_validate(content, file_path, chunk_size=500)

# Logs aparecen si > 600 tokens
# "oversized_chunks": 2
# "max_tokens": 650

# Debugging: ver estructura de chunks
for chunk in chunks:
    print(f"Lines: {chunk['start_line']}-{chunk['end_line']}")
    print(f"Tokens: {chunk['token_count']}")
    print(f"Type: {chunk['metadata']['chunk_type']}")
```

---

## Casos especiales

### 1. Archivo muy pequeño (< 100 tokens)

```
Resultado: 1 chunk
No hay "sobre-chunking"
```

### 2. Un método muy grande (> 500 tokens)

```
Código:
  def huge_method():
      [800 líneas]

Resultado: 1 chunk de 1000+ tokens
Razón: Mantener método intacto
Solución: Refactorizar método (problem en el código, no en chunking)
```

### 3. Archivo binario o no soportado

```
Fallback: Chunking genérico
Resultado: Splits por párrafos/líneas
```

---

## Conclusión

**El chunking inteligente:**
- ✅ Optimiza para embeddings (500 tokens)
- ✅ Mantiene límites semánticos (métodos, secciones)
- ✅ Escala bien (10k a 100k líneas)
- ✅ Acelera búsqueda (cada chunk es independiente)
- ✅ No pierde información (vs truncar)

**Sin chunking inteligente:**
- ❌ Pérdida de información (truncar)
- ❌ Embeddings lentos (chunks oversized)
- ❌ Búsqueda de baja calidad
- ❌ Mala utilización de ChromaDB

**Default: 500 tokens por chunk** → Óptimo balance
