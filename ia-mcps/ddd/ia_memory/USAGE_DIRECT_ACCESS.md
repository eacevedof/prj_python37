# ia_memory: Direct Access (Non-RAG)

When you know exactly where the information is, bypass semantic search and use direct access.

## Problem: RAG Limitations

```
Scenario: You know the info is in UserService.java
         but RAG doesn't find it (low similarity score)

SearchMemoryService(query="user validation"):
  ✓ Finds: UserController
  ✗ Misses: UserService  ← You actually needed this!

Solution: GetMemoryByPathService → Access directly by filename
```

---

## 1. GetMemoryByPath - Direct file access

When you know the **exact filename or path**:

### Use Case 1: "Give me the UserService code"

```python
from ddd.ia_memory.application import GetMemoryByPathService, GetMemoryByPathDto

result = await GetMemoryByPathService.get_instance()(
    GetMemoryByPathDto(
        project="java-service",
        file_path="UserService.java"  # ← Exact or partial path
    )
)

# Returns all chunks indexed from that file
for chunk in result.chunks:
    print(chunk["content"])
    print(f"Type: {chunk['metadata']['type']}")
    print(f"Source: {chunk['metadata']['file']}")
```

### Use Case 2: "Show me everything in the auth folder"

```python
result = await GetMemoryByPathService.get_instance()(
    GetMemoryByPathDto(
        project="java-service",
        file_path="src/auth/"  # ← Partial path matches all files in folder
    )
)

# Returns chunks from:
# - AuthController.java
# - AuthService.java
# - OAuth2Provider.java
# - Any other files in src/auth/
```

### Use Case 3: "I need the pom.xml dependencies"

```python
result = await GetMemoryByPathService.get_instance()(
    GetMemoryByPathDto(
        project="java-service",
        file_path="pom.xml"
    )
)

# Result:
# {
#     "project": "java-service",
#     "file_path": "pom.xml",
#     "total_chunks": 1,
#     "chunks": [
#         {
#             "id": "abc123",
#             "content": "<project>...<dependencies>...",
#             "metadata": {"type": "persistence", "file": "pom.xml"}
#         }
#     ]
# }
```

---

## 2. GetMemoryByType - All chunks of a category

When you want **all documentation** or **all application code**:

### Use Case 1: "Show me all the documentation"

```python
from ddd.ia_memory.application import GetMemoryByTypeService, GetMemoryByTypeDto
from ddd.ia_memory.domain.enums import MemoryTypeEnum

result = await GetMemoryByTypeService.get_instance()(
    GetMemoryByTypeDto(
        project="java-service",
        memory_type=MemoryTypeEnum.DOCUMENTATION  # README, CLAUDE.md, etc
    )
)

# Returns:
# {
#     "project": "java-service",
#     "memory_type": "documentation",
#     "total_chunks": 2,
#     "chunks": [
#         {"content": "README content...", ...},
#         {"content": "CLAUDE.md content...", ...}
#     ]
# }
```

### Use Case 2: "Give me all the architecture documentation"

```python
result = await GetMemoryByTypeService.get_instance()(
    GetMemoryByTypeDto(
        project="java-service",
        memory_type=MemoryTypeEnum.INFRASTRUCTURE
    )
)

# Returns all chunks of type INFRASTRUCTURE:
# - Directory structure
# - Tech stack info
# - Config files (pom.xml, application.yml, etc)
```

### Use Case 3: "What services exist? Show me all APPLICATION code"

```python
result = await GetMemoryByTypeService.get_instance()(
    GetMemoryByTypeDto(
        project="java-service",
        memory_type=MemoryTypeEnum.APPLICATION
    )
)

# Returns all code chunks:
# - AuthService.java
# - UserService.java
# - AuthController.java
# - (All main source files)

for chunk in result.chunks:
    print(f"File: {chunk['metadata'].get('file')}")
    print(f"Preview: {chunk['content_preview']}")
```

---

## 3. GetMemoryByMetadata - Custom metadata queries

When you want **commits by author**, **recent changes**, **tests**, etc:

### Use Case 1: "Show me recent changes"

```python
from ddd.ia_memory.application import GetMemoryByMetadataService, GetMemoryByMetadataDto

result = await GetMemoryByMetadataService.get_instance()(
    GetMemoryByMetadataDto(
        project="java-service",
        metadata_key="type",
        metadata_value="recent_commit"
    )
)

# Returns chunks marked as recent commits
```

### Use Case 2: "Get all changes in auth module"

```python
result = await GetMemoryByMetadataService.get_instance()(
    GetMemoryByMetadataDto(
        project="java-service",
        metadata_key="module",
        metadata_value="auth"
    )
)

# Returns all chunks tagged with module=auth
```

### Use Case 3: "Show me test files"

```python
result = await GetMemoryByMetadataService.get_instance()(
    GetMemoryByMetadataDto(
        project="java-service",
        metadata_key="is_test",
        metadata_value="true"
    )
)

# Returns chunks from *Test.java files
```

---

## RAG vs Direct Access: Decision Tree

```
                         Need information?
                               |
                 ______________|______________
                |                             |
         Know WHERE it is?              Not sure WHERE
              |                              |
             YES                            NO
              |                              |
         Use Direct Access          Use RAG (Search)
         ├─ GetMemoryByPath          SearchMemoryService
         ├─ GetMemoryByType              |
         └─ GetMemoryByMetadata     Retrieves by
                                    semantic similarity
    Examples:
    - "Give me UserService"     Examples:
    - "Show all docs"           - "How is auth done?"
    - "List auth files"         - "What validates input?"
                                - "Where's the OAuth code?"
```

---

## Combined Strategy: RAG + Direct Access

Use them together for robustness:

```python
# Hook: on_user_input.py

async def enrich_message(user_message: str, project: str):
    """
    Smart enrichment: Try RAG first, fallback to direct access
    """
    
    # 1. Try semantic search first
    search_result = await SearchMemoryService.get_instance()(
        SearchMemoryDto(
            project=project,
            query=user_message,
            limit=5
        )
    )
    
    # 2. If no high-relevance results, ask user for direct path
    high_relevance = [c for c in search_result.results if c["similarity"] > 0.75]
    
    if not high_relevance:
        # Fallback: Try to extract filename from message
        filename = extract_filename_from_query(user_message)
        # "show me UserService" → extract "UserService"
        
        if filename:
            # Direct access
            direct_result = await GetMemoryByPathService.get_instance()(
                GetMemoryByPathDto(
                    project=project,
                    file_path=filename
                )
            )
            return format_context(direct_result.chunks)
    
    # 3. Use RAG results
    return format_context(search_result.results)
```

---

## Available Memory Types

```python
from ddd.ia_memory.domain.enums import MemoryTypeEnum

MemoryTypeEnum.MODULE            # Code modules, services, recent changes
MemoryTypeEnum.APPLICATION       # Application logic (controllers, services)
MemoryTypeEnum.DOMAIN            # Business rules, entities, validation
MemoryTypeEnum.INFRASTRUCTURE    # Config, structure, tech stack
MemoryTypeEnum.PERSISTENCE       # Database, cache configuration
MemoryTypeEnum.DOCUMENTATION     # README, guides, architecture notes
```

---

## Performance

| Service | Latency | Use When |
|---------|---------|----------|
| **SearchMemoryService** (RAG) | 200-500ms | You're unsure where info is |
| **GetMemoryByPath** | <50ms | You know the filename |
| **GetMemoryByType** | <50ms | You want all of a category |
| **GetMemoryByMetadata** | <50ms | You want specific metadata match |

---

## When to Use Each

| Scenario | Service |
|----------|---------|
| "How does auth work?" | SearchMemoryService (RAG) |
| "Show me UserService" | GetMemoryByPath |
| "Give me all documentation" | GetMemoryByType + DOCUMENTATION |
| "List all controllers" | GetMemoryByType + APPLICATION |
| "What changed recently?" | GetMemoryByType + MODULE |
| "Get test files" | GetMemoryByMetadata + is_test=true |

---

## Example: Complete Non-RAG Hook

```python
# ~/.claude/hooks/on_user_input_direct.py

from ddd.ia_memory.application import (
    GetMemoryByPathService,
    GetMemoryByTypeService,
    GetMemoryByMetadataService,
    MemoryTypeEnum
)

async def enrich_with_direct_access(user_message: str, project: str):
    """Direct access (no semantic search)"""
    
    context_blocks = []
    
    # Check if user mentioned a specific file
    if "UserService" in user_message:
        result = await GetMemoryByPathService.get_instance()(
            GetMemoryByPathDto(
                project=project,
                file_path="UserService.java"
            )
        )
        context_blocks.extend(result.chunks)
    
    # Check if they want documentation
    if "how does" in user_message.lower() or "what is" in user_message.lower():
        result = await GetMemoryByTypeService.get_instance()(
            GetMemoryByTypeDto(
                project=project,
                memory_type=MemoryTypeEnum.DOCUMENTATION
            )
        )
        context_blocks.extend(result.chunks)
    
    # Return enriched message
    if context_blocks:
        return format_message_with_context(user_message, context_blocks)
    else:
        return user_message  # No direct matches, message as-is
```

---

## Troubleshooting

### "No chunks found for path X"

```python
# Get all available paths
from ddd.ia_memory.application import ListMemoriesService

all_chunks = await ListMemoriesService.get_instance()(
    ListMemoriesDto(project="java-service")
)

available_paths = set(
    chunk["paths"] for chunk in all_chunks.chunks
)

print(f"Available paths: {available_paths}")
```

### "No memory of type X"

```python
# List all memory types
from ddd.ia_memory.domain.enums import MemoryTypeEnum

for mem_type in MemoryTypeEnum:
    try:
        result = await GetMemoryByTypeService.get_instance()(
            GetMemoryByTypeDto(
                project="java-service",
                memory_type=mem_type
            )
        )
        print(f"{mem_type.value}: {result.total_chunks} chunks")
    except Exception:
        print(f"{mem_type.value}: (none)")
```
