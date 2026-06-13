# MCP Memory - Configuración y Uso

El servidor MCP `ia-memory` está ya configurado en tu Claude Code global.

---

## ✅ Configuración Completada

Agregado a `C:\Users\Eduardo Acevedo\.claude.json`:

```json
"ia-memory": {
  "type": "stdio",
  "command": "cmd",
  "args": [
    "/c",
    "cd /d C:\\projects\\prj_python37\\ia-mcps && C:\\projects\\prj_python37\\ia-mcps\\.venv-win\\Scripts\\python.exe -m ddd.mcp_memory"
  ],
  "env": {}
}
```

---

## 🚀 Cómo usarlo

### 1. Reinicia Claude Code

Una vez reiniciado, el servidor MCP estará disponible automáticamente.

### 2. Las 7 herramientas disponibles

Claude podrá usar estas herramientas automáticamente:

| Herramienta | Uso | Parámetros |
|------------|-----|-----------|
| **memory_search** | Búsqueda semántica (RAG) | `project`, `query`, `limit`, `type` |
| **memory_store** | Guardar fragmento | `project`, `type`, `content`, `paths`, `metadata` |
| **memory_store_file** | Procesar archivo completo | `project`, `file_path`, `type` |
| **memory_list** | Listar todos chunks | `project`, `type`, `stale_only` |
| **memory_update** | Actualizar fragmento | `chunk_id`, `project`, `content`, `paths`, `metadata` |
| **memory_delete** | Eliminar fragmento | `chunk_id`, `project` |
| **memory_check_freshness** | Validar actualización | `project` |

---

## 📝 Ejemplos de uso desde Claude Code

### Ejemplo 1: Indexar un proyecto

```
Tú: "Indexa el proyecto ia-mcps en ChromaDB"

Claude internamente usa:
→ memory_store (7 veces)
→ memory_store_file (2 veces)

Resultado: "✅ Indexed 15 chunks from ia-mcps"
```

### Ejemplo 2: Buscar información

```
Tú: "¿Cómo funciona el chunking en ia_memory?"

Claude internamente usa:
→ memory_search({
    "project": "ia-mcps",
    "query": "How does chunking work?",
    "limit": 5
  })

Resultado: Top-5 chunks relevantes + similitud
```

### Ejemplo 3: Ver qué hay indexado

```
Tú: "Muéstrame qué tengo indexado en ia-mcps"

Claude internamente usa:
→ memory_list({
    "project": "ia-mcps"
  })

Resultado: Lista de todos los chunks + metadatos
```

---

## 🎯 Tipos de memoria soportados

```python
MemoryTypeEnum.MODULE            # Código modules, servicios, cambios recientes
MemoryTypeEnum.APPLICATION       # Controllers, services, lógica
MemoryTypeEnum.DOMAIN            # Entidades, reglas de negocio
MemoryTypeEnum.INFRASTRUCTURE    # Config, estructura, tech stack
MemoryTypeEnum.PERSISTENCE       # Base de datos, cache
MemoryTypeEnum.DOCUMENTATION     # README, guías, notas
```

---

## 💡 Workflow típico

```
DÍA 1, MAÑANA:
─────────────
Tú: "Indexa ia-mcps en memoria"
  → memory_store_file(README.md, CLAUDE.md, etc)
  → memory_store(source files, structure, git history)
  → ChromaDB: 15 chunks indexados ✅

DÍA 1, 10AM:
──────────
Tú: "¿Cómo se configura ia_memory?"
  → memory_search(query="configuration")
  → Retorna: CLAUDE.md, setup guide, examples
  → Claude explica basado en chunks reales ✅

DÍA 2, 9AM (Nueva sesión):
──────────────────────────
ChromaDB persiste (los chunks siguen ahí)
  
Tú: "Necesito usar SearchMemoryService"
  → memory_search(query="SearchMemoryService")
  → Retorna: ejemplo + documentación
  → Claude responde sin necesidad de reindexar ✅
```

---

## 🔧 Troubleshooting

### "MCP ia-memory no aparece"

1. Verifica que `.venv-win` esté activado en ia-mcps
2. Reinicia Claude Code completamente
3. Revisa que `C:\Users\Eduardo Acevedo\.claude.json` tenga la configuración

### "No encuentra chunks"

```
Tú: "Muéstrame qué hay indexado"
  → memory_list({ "project": "ia-mcps" })
  
Si retorna 0 chunks: necesitas indexar primero
  → "Indexa el proyecto ia-mcps"
  → Esto ejecutará memory_store + memory_store_file
```

### "Búsqueda no encuentra nada"

Esto es normal si:
- El proyecto no está indexado
- La similitud semántica es baja (prueba términos más específicos)

**Fallback a directo:**

```
Tú: "Muéstrame el archivo CHUNKING_STRATEGY.md"

Claude puede:
1. Primero intentar memory_search("chunking strategy")
2. Si no encuentra, usar memory_store_file(CHUNKING_STRATEGY.md)
3. O leer el archivo directamente sin MCP
```

---

## 📊 Casos de uso recomendados

| Caso | Comando | Herramienta |
|------|---------|-----------|
| Primer acceso a proyecto | "Indexa [proyecto]" | memory_store_file |
| Buscar por contenido | "¿Cómo funciona X?" | memory_search |
| Buscar por archivo | "Muéstrame [archivo]" | memory_store_file (directo) |
| Ver cambios recientes | "¿Qué cambió?" | memory_list |
| Actualizar después de editar | "/reload-project-memory" | memory_store (múltiple) |

---

## ✨ Lo siguiente

Una vez que mcp_memory esté funcionando, puedes:

1. **Indexar otros proyectos** (Java, PHP, etc) automáticamente
2. **Crear hooks git** para mantener ChromaDB actualizado
3. **Usar RAG** en todos tus proyectos para no perder contexto

Ejemplo:

```
Cambias de proyecto Java → PHP → Python
  
Sin mcp_memory:
  → "Cuéntame todo de nuevo"
  → Contexto perdido

Con mcp_memory:
  → Claude busca automáticamente
  → "Veo que trabajabas en [módulo]"
  → Contexto preservado ✅
```

---

## 🎓 Referencia rápida

```bash
# Reiniciar Claude Code
# (para que cargue mcp_memory)

# Luego, en cualquier proyecto:
"Indexa [proyecto]"              # Indexar
"¿Cómo funciona X en ia-mcps?"  # Buscar
"Muéstrame el archivo Y"        # Acceso directo
"¿Qué hay indexado?"            # Listar chunks
```

Listo. MCP Memory está configurado y listo para usar. ✅
