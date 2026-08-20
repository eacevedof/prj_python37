# ia_memory: Casos de Uso Completos

Matriz de **todos los servicios** y cuándo usar cada uno.

---

## 📊 Vista Panorámica

```
ia_memory - Servicios disponibles (12 total)

ESCRITURA (Write):
├── StoreMemoryService          Guardar fragmento individual
├── StoreFileService            Procesar archivo completo
├── UpdateMemoryService         Actualizar fragmento existente
├── DeleteMemoryService         Eliminar fragmento
├── InitializeProjectService    Indexar proyecto desde 0
└── ReloadProjectService        Reiniciar todo

LECTURA - RAG (Semantic):
└── SearchMemoryService         Búsqueda por similitud (on-demand)

LECTURA - Directo (Direct):
├── GetMemoryByPathService      Por ruta exacta/parcial
├── GetMemoryByTypeService      Por tipo (DOCUMENTATION, APPLICATION, etc)
├── GetMemoryByMetadataService  Por metadata custom
├── ListMemoriesService         Listar todos los chunks
└── CheckFreshnessService       Verificar si está actualizado
```

---

## 🔍 Decisión: ¿Qué servicio usar?

### Quiero GUARDAR información

```
¿Qué quiero guardar?

├─ Un fragmento específico (texto que no es archivo)
│  └─ StoreMemoryService
│     await store(StoreMemoryDto(
│       project="java-service",
│       memory_type=DOCUMENTATION,
│       content="Mi nota...",
│       paths=["/path/to/file.py"]
│     ))
│
├─ Un archivo completo (PDF, código, etc)
│  └─ StoreFileService
│     await store(StoreFileDto(
│       project="java-service",
│       file_path="/home/user/docs/architecture.pdf",
│       memory_type=DOCUMENTATION
│     ))
│
├─ Actualizar un fragmento existente
│  └─ UpdateMemoryService
│     await update(UpdateMemoryDto(
│       chunk_id="abc123",
│       project="java-service",
│       content="Contenido nuevo...",
│       paths=["/updated/file.py"]
│     ))
│
├─ Eliminar un fragmento
│  └─ DeleteMemoryService
│     await delete(DeleteMemoryDto(
│       chunk_id="abc123",
│       project="java-service"
│     ))
│
└─ Cargar proyecto ENTERO desde 0
   └─ InitializeProjectService
      await initialize(InitializeProjectDto(
        project_name="java-service",
        project_root="/home/user/projects/java-service"
      ))
```

---

### Quiero RECUPERAR información

#### Opción 1: Búsqueda semántica (RAG)

**Cuándo**: No sabes dónde está, pero sabes QUÉ buscas

```python
# Usuario: "¿Cómo funciona la autenticación?"
# Tú NO sabes: qué archivo, qué tipo

await SearchMemoryService()(
    SearchMemoryDto(
        project="java-service",
        query="How does authentication work?",
        limit=5,
        memory_type=None  # Busca en TODO
    )
)

# Retorna: Top-5 chunks similares
# - AuthController: login endpoint (similarity: 0.92)
# - UserService: validates credentials (similarity: 0.88)
# - Spring Security config (similarity: 0.85)
# - etc.
```

**Ventajas:**
- ✅ Flexible, busca por contenido
- ✅ Entiende sinónimos
- ✅ Encuentra código relacionado

**Desventajas:**
- ❌ ~300-500ms latencia (búsqueda en ChromaDB)
- ❌ Puede no encontrar si similitud es baja
- ❌ Contexto vaginal (sin history)

---

#### Opción 2: Acceso directo por ruta (Direct)

**Cuándo**: Sabes EXACTAMENTE dónde está

```python
# Usuario: "Muéstrame UserService"
# Tú SABES: UserService.java

await GetMemoryByPathService()(
    GetMemoryByPathDto(
        project="java-service",
        file_path="UserService.java"
    )
)

# Retorna: TODOS los chunks indexados de UserService.java
# Latencia: <50ms
# Precisión: 100%
```

**Ventajas:**
- ✅ Super rápido (<50ms)
- ✅ Precisión garantizada
- ✅ No depende de similitud

**Desventajas:**
- ❌ Necesitas saber la ruta
- ❌ No busca por contenido

---

#### Opción 3: Por tipo (Direct)

**Cuándo**: Quieres TODA una categoría

```python
# Usuario: "Muéstrame toda la documentación"
# Tú SABES: quiero type=DOCUMENTATION

await GetMemoryByTypeService()(
    GetMemoryByTypeDto(
        project="java-service",
        memory_type=MemoryTypeEnum.DOCUMENTATION
    )
)

# Retorna: README.md, CLAUDE.md, todos los docs
# Latencia: <50ms
```

**Casos:**
- "Muéstrame toda la arquitectura" → MemoryTypeEnum.INFRASTRUCTURE
- "Qué servicios tengo?" → MemoryTypeEnum.APPLICATION
- "Cambios recientes?" → MemoryTypeEnum.MODULE

---

#### Opción 4: Por metadata (Direct)

**Cuándo**: Quieres chunks que coincidan con criterio específico

```python
# Usuario: "Muéstrame los cambios del último día"
# Tú SABES: metadata key="recent_commits"

await GetMemoryByMetadataService()(
    GetMemoryByMetadataDto(
        project="java-service",
        metadata_key="recent_commits",
        metadata_value="true"
    )
)

# Retorna: chunks marcados como cambios recientes
```

---

#### Opción 5: Listar todo

**Cuándo**: Quieres saber QUÉ hay indexado

```python
await ListMemoriesService()(
    ListMemoriesDto(
        project="java-service",
        memory_type=None,  # Todos los tipos
        stale_only=False   # Incluyendo frescos
    )
)

# Retorna: todos los chunks con metadata
```

---

## 📋 Matriz: Cuándo usar cada servicio

```
                    RAG (Semántica)  │  Directo (Ruta/Tipo/Metadata)
──────────────────────────────────────────────────────────────────────
Usuario sabe QUÉ        ✅ Ideal    │  ❌ No aplicable
(contenido/significado)

Usuario sabe DÓNDE      ❌ Lento    │  ✅ IDEAL
(archivo/tipo)                       │     (GetMemoryByPath/Type/Meta)

Búsqueda flexible       ✅ Mejor    │  ❌ Rígido
(sinónimos, conceptos)

Búsqueda rápida         ❌ Lento    │  ✅ IDEAL (<50ms)
                        (500ms)      │

Precisión              🟡 Buena    │  ✅ Perfecta
                        (0.75+)      │  (100%)

Latencia aceptable     🟡 Si       │  ✅ Siempre
                        (RAG lento)  │
```

---

## 🎯 Flujo recomendado en Hook

```python
# ~/.claude/hooks/on_user_input.py

async def enrich_with_context(user_message: str, project: str):
    """
    Estrategia: RAG + Direct (fallback)
    """
    
    # 1. Intentar RAG primero
    search_result = await SearchMemoryService()(
        SearchMemoryDto(
            project=project,
            query=user_message,
            limit=5
        )
    )
    
    # 2. Si RAG no encuentra (similitud baja), extraer filename
    high_relevance = [c for c in search_result.results if c["similarity"] > 0.75]
    
    if not high_relevance:
        # Extraer "UserService" de "muéstrame UserService"
        filename = extract_filename(user_message)
        
        if filename:
            # Fallback: Acceso directo
            direct_result = await GetMemoryByPathService()(
                GetMemoryByPathDto(
                    project=project,
                    file_path=filename
                )
            )
            
            # Usar resultado directo
            context = direct_result.chunks
        else:
            # Si tampoco hay filename, usar RAG aunque sea baja similitud
            context = search_result.results
    else:
        # RAG encontró buenos resultados
        context = high_relevance
    
    # Enriquecer mensaje
    return inject_context(user_message, context)
```

---

## 💡 Ejemplos prácticos

### Ejemplo 1: "Cómo funciona la auth?"

```
Usuario: "¿Cómo funciona la autenticación?"

Estrategia: RAG (no sabes dónde)
  ↓
SearchMemoryService:
  query="How does authentication work?"
  
  ↓
Retorna:
  - AuthController (similarity: 0.92)
  - UserService (similarity: 0.88)
  - Spring Security (similarity: 0.85)
  
Claude responde basado en eso
```

### Ejemplo 2: "Muéstrame UserService"

```
Usuario: "Muéstrame UserService"

Estrategia: Directo (sabes el nombre)
  ↓
GetMemoryByPathService:
  file_path="UserService.java"
  
  ↓
Retorna (instantáneo):
  - Código completo de UserService
  
Claude tiene el código para refactorizar
```

### Ejemplo 3: "Qué cambió?"

```
Usuario: "¿Qué cambió recientemente?"

Estrategia: Por tipo (sabes categoría)
  ↓
GetMemoryByTypeService:
  memory_type=MemoryTypeEnum.MODULE
  
  ↓
Retorna:
  - Últimos commits
  - Cambios recientes
  - Git status
  
Claude resume los cambios
```

### Ejemplo 4: "Dame toda la configuración"

```
Usuario: "Dame toda la configuración"

Estrategia: Por tipo
  ↓
GetMemoryByTypeService:
  memory_type=MemoryTypeEnum.PERSISTENCE
  
  ↓
Retorna:
  - pom.xml
  - application.yml
  - DB schema
  
Claude tiene config para revisar
```

---

## ⚡ Performance expectado

| Servicio | Latencia | Caso de Uso |
|----------|----------|------------|
| SearchMemoryService | 200-500ms | RAG, búsqueda flexible |
| GetMemoryByPath | <50ms | Acceso directo por ruta |
| GetMemoryByType | <50ms | Acceso directo por tipo |
| GetMemoryByMetadata | <50ms | Acceso directo por metadata |
| ListMemoriesService | <100ms | Explorar qué hay |
| CheckFreshnessService | 100-200ms | Verificar si está actualizado |

---

## 🔄 Ciclo de vida completo

```
DÍA 1, MAÑANA
═════════════
InitializeProjectService
  → Indexa proyecto
  → ChromaDB = 15 chunks

DÍA 1, 10AM
═══════════
Usuario: "¿Cómo funciona auth?"
  → SearchMemoryService (RAG)
  → Retorna AuthController

DÍA 1, 10:30AM
═════════════
Usuario: "Muéstrame UserService"
  → GetMemoryByPathService (Direct)
  → Retorna UserService código

DÍA 1, 3PM
══════════
git commit "Add OAuth2"
  → post-commit hook
  → StoreMemoryService
  → ChromaDB = 16 chunks

DÍA 3, 9AM (Nueva sesión)
═════════════════════════
ChromaDB aún tiene 16 chunks (persisten)

Usuario: "Necesito OAuth2 como 2FA"
  → SearchMemoryService
  → Encuentra: "Add OAuth2" (reciente)
  → Claude ya sabe qué se hizo

DÍA 10
══════
Refactor masivo

Usuario: "/reload-project-memory"
  → ReloadProjectService
  → Limpia 16 chunks
  → Reindexa todo
  → ChromaDB = 22 chunks (más contenido)
```

---

## 🎓 Guía rápida

```
¿QUIERO GUARDAR?
  → Si es fragmento: StoreMemoryService
  → Si es archivo: StoreFileService
  → Si es actualización: UpdateMemoryService
  → Si es proyecto entero: InitializeProjectService

¿QUIERO RECUPERAR?
  → Si no sé dónde: SearchMemoryService (RAG)
  → Si sé el archivo: GetMemoryByPathService
  → Si sé el tipo: GetMemoryByTypeService
  → Si quiero todo: ListMemoriesService

¿QUIERO ACTUALIZAR?
  → Un chunk: UpdateMemoryService
  → Todo el proyecto: ReloadProjectService
  → Limpiar uno: DeleteMemoryService
```

---

## 📁 Archivos de documentación

- **USAGE_INITIALIZE_RELOAD.md** - InitializeProjectService, ReloadProjectService
- **USAGE_DIRECT_ACCESS.md** - GetMemoryByPath, GetMemoryByType, GetMemoryByMetadata
- **Este archivo** - Matriz completa y decisiones
