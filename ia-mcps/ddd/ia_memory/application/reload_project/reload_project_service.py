from typing import final, Self

from ddd.shared.infrastructure.components import Logger
from ddd.ia_memory.application.reload_project.reload_project_dto import ReloadProjectDto
from ddd.ia_memory.application.reload_project.reload_project_result_dto import ReloadProjectResultDto
from ddd.ia_memory.application.initialize_project.initialize_project_service import InitializeProjectService
from ddd.ia_memory.application.initialize_project.initialize_project_dto import InitializeProjectDto
from ddd.ia_memory.application.list_memories.list_memories_service import ListMemoriesService
from ddd.ia_memory.application.list_memories.list_memories_dto import ListMemoriesDto
from ddd.ia_memory.application.delete_memory.delete_memory_service import DeleteMemoryService
from ddd.ia_memory.application.delete_memory.delete_memory_dto import DeleteMemoryDto
from ddd.ia_memory.domain.exceptions import MemoryException


@final
class ReloadProjectService:
    """Clear and reinitialize project memory from scratch."""

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._list_memories_service = ListMemoriesService.get_instance()
        self._delete_memory_service = DeleteMemoryService.get_instance()
        self._initialize_project_service = InitializeProjectService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: ReloadProjectDto) -> ReloadProjectResultDto:
        """Delete all memories for a project and reinitialize."""

        try:
            # 1. List all memories for this project
            all_memories = await self._list_memories_service(
                ListMemoriesDto(project=dto.project_name)
            )

            # 2. Delete all memories
            chunks_deleted = 0
            for chunk in all_memories.chunks:
                await self._delete_memory_service(
                    DeleteMemoryDto(
                        chunk_id=chunk["id"],
                        project=dto.project_name
                    )
                )
                chunks_deleted += 1

            self._logger.log_payload_error(
                {"project": dto.project_name, "chunks_deleted": chunks_deleted},
                "reload_project.deleted_chunks"
            )

            # 3. Reinitialize with fresh data
            initialize_result = await self._initialize_project_service(
                InitializeProjectDto(
                    project_name=dto.project_name,
                    project_root=dto.project_root,
                    include_git_history=dto.include_git_history,
                    include_dependencies=dto.include_dependencies,
                    max_recent_commits=dto.max_recent_commits,
                )
            )

            return ReloadProjectResultDto.from_primitives({
                "project_name": dto.project_name,
                "chunks_deleted": chunks_deleted,
                "chunks_created": initialize_result.total_chunks,
                "status": "success",
                "message": f"Reloaded: deleted {chunks_deleted} old chunks, created {initialize_result.total_chunks} new chunks",
            })

        except Exception as e:
            self._logger.log_payload_error(
                {"project_name": dto.project_name, "error": str(e)},
                "reload_project.error"
            )
            MemoryException.unexpected_custom(f"Failed to reload project: {str(e)}")
