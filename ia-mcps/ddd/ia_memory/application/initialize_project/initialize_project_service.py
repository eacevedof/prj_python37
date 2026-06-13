import os
import subprocess
from pathlib import Path
from typing import final, Self
from collections import defaultdict

from ddd.shared.infrastructure.components import Logger
from ddd.ia_memory.application.initialize_project.initialize_project_dto import InitializeProjectDto
from ddd.ia_memory.application.initialize_project.initialize_project_result_dto import InitializeProjectResultDto
from ddd.ia_memory.application.store_memory.store_memory_service import StoreMemoryService
from ddd.ia_memory.application.store_memory.store_memory_dto import StoreMemoryDto
from ddd.ia_memory.domain.enums import MemoryTypeEnum
from ddd.ia_memory.domain.exceptions import MemoryException


@final
class InitializeProjectService:
    """Initialize ChromaDB with complete project knowledge."""

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._store_memory_service = StoreMemoryService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: InitializeProjectDto) -> InitializeProjectResultDto:
        """Index entire project into ChromaDB from scratch."""

        chunks_stored = 0
        files_processed = 0
        memory_types_count = defaultdict(int)

        project_root = Path(dto.project_root)
        if not project_root.exists():
            MemoryException.bad_request_custom(f"Project root not found: {dto.project_root}")

        try:
            # 1. Index README
            readme_path = project_root / "README.md"
            if readme_path.exists():
                with open(readme_path, encoding="utf-8") as f:
                    await self._store_memory_service(
                        StoreMemoryDto(
                            project=dto.project_name,
                            memory_type=MemoryTypeEnum.DOCUMENTATION,
                            content=f.read(),
                            paths=[str(readme_path)]
                        )
                    )
                chunks_stored += 1
                files_processed += 1
                memory_types_count[MemoryTypeEnum.DOCUMENTATION.value] += 1

            # 2. Index CLAUDE.md
            claude_md_path = project_root / "CLAUDE.md"
            if claude_md_path.exists():
                with open(claude_md_path, encoding="utf-8") as f:
                    await self._store_memory_service(
                        StoreMemoryDto(
                            project=dto.project_name,
                            memory_type=MemoryTypeEnum.DOCUMENTATION,
                            content=f.read(),
                            paths=[str(claude_md_path)]
                        )
                    )
                chunks_stored += 1
                files_processed += 1
                memory_types_count[MemoryTypeEnum.DOCUMENTATION.value] += 1

            # 3. Index directory structure
            tree_structure = self._generate_directory_tree(project_root)
            await self._store_memory_service(
                StoreMemoryDto(
                    project=dto.project_name,
                    memory_type=MemoryTypeEnum.INFRASTRUCTURE,
                    content=tree_structure,
                    paths=[str(project_root)]
                )
            )
            chunks_stored += 1
            memory_types_count[MemoryTypeEnum.INFRASTRUCTURE.value] += 1

            # 4. Index key configuration files
            key_files = [
                "pom.xml", "build.gradle", "package.json", "pyproject.toml", "requirements.txt",
                "go.mod", "Cargo.toml", "composer.json", ".env.example", "Makefile"
            ]
            for key_file in key_files:
                key_path = project_root / key_file
                if key_path.exists() and key_path.is_file():
                    with open(key_path, encoding="utf-8") as f:
                        await self._store_memory_service(
                            StoreMemoryDto(
                                project=dto.project_name,
                                memory_type=MemoryTypeEnum.PERSISTENCE,
                                content=f"Configuration: {key_file}\n\n{f.read()}",
                                paths=[str(key_path)]
                            )
                        )
                    chunks_stored += 1
                    files_processed += 1
                    memory_types_count[MemoryTypeEnum.PERSISTENCE.value] += 1

            # 5. Index git history
            if dto.include_git_history:
                git_log = self._get_git_log(project_root, dto.max_recent_commits)
                if git_log:
                    await self._store_memory_service(
                        StoreMemoryDto(
                            project=dto.project_name,
                            memory_type=MemoryTypeEnum.MODULE,
                            content=git_log,
                            paths=[str(project_root / ".git" / "logs" / "HEAD")]
                        )
                    )
                    chunks_stored += 1
                    memory_types_count[MemoryTypeEnum.MODULE.value] += 1

            # 6. Index git status
            git_status = self._get_git_status(project_root)
            if git_status:
                await self._store_memory_service(
                    StoreMemoryDto(
                        project=dto.project_name,
                        memory_type=MemoryTypeEnum.MODULE,
                        content=git_status,
                        paths=[str(project_root / ".git")]
                    )
                )
                chunks_stored += 1
                memory_types_count[MemoryTypeEnum.MODULE.value] += 1

            # 7. Index key source files (limited)
            source_files = self._find_key_source_files(project_root)
            for source_file in source_files[:10]:  # Limit to top 10
                try:
                    with open(source_file, encoding="utf-8") as f:
                        content = f.read()
                        if len(content) > 10000:
                            content = content[:10000] + "\n... (truncated)"

                        await self._store_memory_service(
                            StoreMemoryDto(
                                project=dto.project_name,
                                memory_type=MemoryTypeEnum.APPLICATION,
                                content=f"File: {source_file.name}\n\n{content}",
                                paths=[str(source_file)]
                            )
                        )
                        chunks_stored += 1
                        files_processed += 1
                        memory_types_count[MemoryTypeEnum.APPLICATION.value] += 1
                except Exception as e:
                    self._logger.log_payload_error(str(source_file), f"initialize_project.index_source_file")

            return InitializeProjectResultDto.from_primitives({
                "project_name": dto.project_name,
                "total_chunks": chunks_stored,
                "total_files_processed": files_processed,
                "memory_types_indexed": dict(memory_types_count),
                "status": "success",
                "message": f"Indexed {chunks_stored} chunks from {files_processed} files",
            })

        except Exception as e:
            self._logger.log_payload_error(
                {"project_name": dto.project_name, "error": str(e)},
                "initialize_project.error"
            )
            MemoryException.unexpected_custom(f"Failed to initialize project: {str(e)}")

    def _generate_directory_tree(self, root_path: Path, prefix: str = "", max_depth: int = 3, current_depth: int = 0) -> str:
        """Generate a directory tree representation."""
        if current_depth >= max_depth:
            return ""

        tree_lines = []
        ignore_dirs = {".git", "__pycache__", "node_modules", ".venv", "venv", "target", "build", ".idea"}

        try:
            items = sorted(root_path.iterdir(), key=lambda x: (not x.is_dir(), x.name))
            for i, item in enumerate(items):
                if item.name.startswith(".") and item.name not in {".github", ".gitignore"}:
                    continue
                if item.name in ignore_dirs:
                    continue

                is_last = i == len(items) - 1
                current_prefix = "└── " if is_last else "├── "
                tree_lines.append(f"{prefix}{current_prefix}{item.name}")

                if item.is_dir():
                    next_prefix = prefix + ("    " if is_last else "│   ")
                    tree_lines.append(self._generate_directory_tree(item, next_prefix, max_depth, current_depth + 1))
        except PermissionError:
            pass

        return "\n".join(filter(None, tree_lines))

    def _get_git_log(self, project_root: Path, limit: int) -> str | None:
        """Get recent git log."""
        try:
            result = subprocess.run(
                ["git", "log", "--oneline", f"-{limit}"],
                cwd=project_root,
                capture_output=True,
                text=True,
                timeout=5
            )
            if result.returncode == 0:
                return f"Recent commits:\n{result.stdout}"
        except Exception as e:
            self._logger.log_payload_error(str(project_root), "initialize_project.git_log_error")
        return None

    def _get_git_status(self, project_root: Path) -> str | None:
        """Get current git status."""
        try:
            result = subprocess.run(
                ["git", "status", "--porcelain"],
                cwd=project_root,
                capture_output=True,
                text=True,
                timeout=5
            )
            if result.returncode == 0:
                branch_result = subprocess.run(
                    ["git", "rev-parse", "--abbrev-ref", "HEAD"],
                    cwd=project_root,
                    capture_output=True,
                    text=True,
                    timeout=5
                )
                branch = branch_result.stdout.strip() if branch_result.returncode == 0 else "unknown"
                status = result.stdout if result.stdout else "working tree clean"
                return f"Current branch: {branch}\nStatus:\n{status}"
        except Exception as e:
            self._logger.log_payload_error(str(project_root), "initialize_project.git_status_error")
        return None

    def _find_key_source_files(self, project_root: Path) -> list[Path]:
        """Find key source files (main, entry points, services)."""
        key_files = []
        ignore_dirs = {".git", "__pycache__", "node_modules", ".venv", "venv", "target", "build", ".idea"}

        # Known entry point patterns
        entry_point_patterns = {
            "main.py", "main.java", "app.py", "index.ts", "index.js",
            "Application.java", "App.java", "Server.java"
        }

        # Service/controller patterns
        service_patterns = {
            "Service", "Controller", "Handler", "Manager", "Repository"
        }

        try:
            for item in project_root.rglob("*"):
                if any(ignore in item.parts for ignore in ignore_dirs):
                    continue
                if not item.is_file():
                    continue

                # Check entry points
                if item.name in entry_point_patterns:
                    key_files.append(item)

                # Check service/controller patterns
                if any(pattern in item.name for pattern in service_patterns):
                    if item.suffix in {".py", ".java", ".ts", ".js", ".go", ".rb"}:
                        key_files.append(item)
        except Exception as e:
            self._logger.log_payload_error(str(project_root), "initialize_project.find_key_files_error")

        return key_files[:10]  # Return top 10
