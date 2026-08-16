# ia_memory: Initialize & Reload Project Memory

Complete guide for initializing ChromaDB with project knowledge and handling project reloads.

## Overview

Two new services manage project memory lifecycle:

- **InitializeProjectService**: Index a project into ChromaDB from scratch
- **ReloadProjectService**: Clear and reinitialize project memory (full refresh)

## Use Cases

### 1. First-time project setup

When a user opens a project for the first time, initialize ChromaDB with all project knowledge:

```python
from ddd.ia_memory.application import InitializeProjectService, InitializeProjectDto

service = InitializeProjectService.get_instance()

result = await service(
    InitializeProjectDto(
        project_name="java-spring-service",
        project_root="/home/user/projects/java-spring-service",
        include_git_history=True,
        include_dependencies=True,
        max_recent_commits=20
    )
)

print(result.to_dict())
# {
#     "project_name": "java-spring-service",
#     "total_chunks": 15,
#     "total_files_processed": 8,
#     "memory_types_indexed": {
#         "documentation": 2,
#         "infrastructure": 1,
#         "persistence": 3,
#         "module": 2,
#         "application": 7
#     },
#     "status": "success",
#     "message": "Indexed 15 chunks from 8 files"
# }
```

### 2. Force reload project memory

User wants to clear and refresh all project knowledge (e.g., after major refactor):

```python
from ddd.ia_memory.application import ReloadProjectService, ReloadProjectDto

service = ReloadProjectService.get_instance()

result = await service(
    ReloadProjectDto(
        project_name="java-spring-service",
        project_root="/home/user/projects/java-spring-service",
        include_git_history=True,
        max_recent_commits=20
    )
)

print(result.to_dict())
# {
#     "project_name": "java-spring-service",
#     "chunks_deleted": 15,
#     "chunks_created": 18,  # More chunks after refactor
#     "status": "success",
#     "message": "Reloaded: deleted 15 old chunks, created 18 new chunks"
# }
```

### 3. On-demand context retrieval (hook)

Claude CLI hook that searches ChromaDB based on user question:

```python
# ~/.claude/hooks/on_user_input.py

from ddd.ia_memory.application import SearchMemoryService, SearchMemoryDto

async def enrich_user_input(user_message: str, project_root: str):
    """
    Intercept user input and retrieve relevant context from ChromaDB
    """
    project_name = get_project_name(project_root)
    
    # Search ChromaDB with the user's question
    result = await SearchMemoryService.get_instance()(
        SearchMemoryDto(
            project=project_name,
            query=user_message,
            limit=5,
            memory_type=None  # Search across all types
        )
    )
    
    # Format context
    context_blocks = []
    for chunk in result.results:
        if chunk["similarity"] > 0.65:  # Only high-relevance chunks
            summary = summarize(chunk["content"], max_tokens=150)
            context_blocks.append(f"- {summary}")
    
    # Inject into message
    if context_blocks:
        enriched = f"""
PROJECT CONTEXT (auto-retrieved):
{chr(10).join(context_blocks)}

USER QUESTION:
{user_message}
"""
    else:
        enriched = user_message
    
    return enriched
```

## Indexed Content

### What gets indexed by InitializeProjectService?

```
PROJECT_ROOT/
├── README.md                  → DOCUMENTATION type
├── CLAUDE.md                  → DOCUMENTATION type
├── Directory tree             → INFRASTRUCTURE type
├── pom.xml / package.json     → PERSISTENCE type
├── Git history (last 20)      → MODULE type
├── Git status                 → MODULE type
└── Key source files           → APPLICATION type
    ├── *Service.java
    ├── *Controller.java
    ├── main.py
    └── index.ts (up to 10 files)
```

### Memory Types

| Type | Purpose | Example |
|------|---------|---------|
| `DOCUMENTATION` | README, guides, architecture notes | "Spring Boot with JWT auth" |
| `MODULE` | Code modules, recent changes | "Latest: refactored auth" |
| `APPLICATION` | Service logic, handlers | AuthController, UserService |
| `DOMAIN` | Business rules, entities | Auth schema, validation rules |
| `INFRASTRUCTURE` | Config, structure, tech stack | pom.xml, directory tree |
| `PERSISTENCE` | Database, cache config | PostgreSQL schema |

## Integration with Claude CLI

### Hook: on_session_start

Initialize ChromaDB when entering a project:

```python
# ~/.claude/hooks/on_session_start.py

from ddd.ia_memory.application import InitializeProjectService, InitializeProjectDto
from pathlib import Path

def setup_project_memory():
    project_root = Path.cwd()
    project_name = project_root.name
    
    # Check if already initialized
    if is_project_memory_initialized(project_name):
        return  # Skip if already has chunks
    
    # Initialize from scratch
    service = InitializeProjectService.get_instance()
    result = await service(
        InitializeProjectDto(
            project_name=project_name,
            project_root=str(project_root),
        )
    )
    
    print(f"✓ Project memory initialized: {result.message}")
```

### Hook: on_user_input (on-demand context)

Enrich every user question with relevant context:

```python
# ~/.claude/hooks/on_user_input.py

from ddd.ia_memory.application import SearchMemoryService, SearchMemoryDto

async def enrich_with_context(user_message: str):
    project_name = get_project_name()
    
    # Retrieve relevant context
    context = await SearchMemoryService.get_instance()(
        SearchMemoryDto(
            project=project_name,
            query=user_message,
            limit=5
        )
    )
    
    # Inject top chunks
    return inject_context(user_message, context.results)
```

### Hook: post-commit (keep memory fresh)

Update ChromaDB after git commits:

```bash
#!/bin/bash
# .git/hooks/post-commit

python3 << 'EOF'
from ddd.ia_memory.application import (
    InitializeProjectService,
    InitializeProjectDto,
    ListMemoriesService,
    ListMemoriesDto
)

# Get last commit
last_commit = $(git log -1 --format="%H %s")

# Check if memory is stale (> 100 commits behind)
current_commits = $(git rev-list --count HEAD)
memory_commits = get_memory_commit_count()

if current_commits - memory_commits > 100:
    # Full reload if too far behind
    ReloadProjectService().call(...)
else:
    # Just add the new commit info
    StoreMemoryService().call(...)
EOF
```

## Configuration

Add to `settings.json`:

```json
{
  "rag_config": {
    "auto_initialize": true,
    "initialize_on_new_project": true,
    "search_limit": 5,
    "relevance_threshold": 0.65,
    "max_context_tokens": 500,
    "auto_reload_after_commits": 100
  }
}
```

## Performance Considerations

### InitializeProjectService

- **Time**: ~5-10 seconds for typical project
- **Space**: ~500KB ChromaDB per medium project
- **Tokens**: Embeddings generated for each chunk (~50-100 tokens per chunk)

### SearchMemoryService

- **Latency**: ~200-500ms per search
- **Context injected**: Top-5 results = ~500 tokens max

### ReloadProjectService

- **Time**: Delete old chunks (~1s) + reinitialize (~10s)
- **Space**: Replaces old ChromaDB collection

## Troubleshooting

### ChromaDB not initialized

```python
# Check if project has chunks
from ddd.ia_memory.application import ListMemoriesService, ListMemoriesDto

result = await ListMemoriesService.get_instance()(
    ListMemoriesDto(project="java-service")
)

if result.total_chunks == 0:
    # Not initialized, run InitializeProjectService
```

### Memory is stale

```python
# Check freshness
from ddd.ia_memory.application import CheckFreshnessService, CheckFreshnessDto

result = await CheckFreshnessService.get_instance()(
    CheckFreshnessDto(project="java-service")
)

if result.stale > 0:
    print(f"Found {result.stale} stale chunks")
    # Run ReloadProjectService
```

### Search returns no results

```python
# Verify memory is initialized
result = await ListMemoriesService.get_instance()(
    ListMemoriesDto(project="java-service")
)

if result.total_chunks == 0:
    await InitializeProjectService.get_instance()(
        InitializeProjectDto(
            project_name="java-service",
            project_root="/path/to/project"
        )
    )
```

## Related Services

- **SearchMemoryService**: On-demand context retrieval
- **StoreMemoryService**: Store individual chunks
- **UpdateMemoryService**: Update existing chunks
- **DeleteMemoryService**: Remove chunks
- **CheckFreshnessService**: Verify memory freshness
