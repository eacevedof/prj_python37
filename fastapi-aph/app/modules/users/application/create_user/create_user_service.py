from typing import Optional, final

from app.shared.infrastructure.components.uuider import Uuider
from app.modules.projects.infrastructure.repositories.projects_reader_postgres_repository import ProjectsReaderPostgresRepository
from app.modules.users.infrastructure.repositories.users_writer_postgres_repository import UsersWriterPostgresRepository
from app.modules.users.infrastructure.repositories.users_reader_postgres_repository import UsersReaderPostgresRepository
from app.modules.users.application.create_user.create_user_dto import CreateUserDto
from app.modules.users.application.create_user.created_user_dto import CreatedUserDto
from app.modules.users.domain.exceptions.users_exception import UsersException


@final
class CreateUserService:
    """User creation service following the original Deno implementation"""
    
    def __init__(self):
        self.uuider = Uuider.get_instance()
        self.projects_reader_postgres_repository = ProjectsReaderPostgresRepository.get_instance()
        self.users_writer_postgres_repository = UsersWriterPostgresRepository.get_instance()
        self.users_reader_postgres_repository = UsersReaderPostgresRepository.get_instance()
        
        self.create_user_dto: Optional[CreateUserDto] = None
        self.created_user_uuid: Optional[str] = None
        self.project_id: Optional[int] = None
    
    @classmethod
    def get_instance(cls):
        return cls()
    
    async def invoke(self, create_user_dto: CreateUserDto) -> CreatedUserDto:
        """Execute user creation process following Deno implementation"""
        self.create_user_dto = create_user_dto
        
        self.__fail_if_wrong_input()
        await self.__fail_if_user_already_exists()
        await self.__create_user()
        
        return CreatedUserDto.from_primitives(self.created_user_uuid)
    
    def __fail_if_wrong_input(self):
        """Validate input data"""
        if not self.create_user_dto.get_project_uuid():
            UsersException.bad_request_custom("project_uuid is required.")
        
        if not self.create_user_dto.get_project_user_uuid():
            UsersException.bad_request_custom("project_user_uuid is required.")
    
    async def __fail_if_user_already_exists(self) -> None:
        """Check if user already exists for this project"""
        project_id = await self.projects_reader_postgres_repository.get_project_id_by_project_uuid(
            self.create_user_dto.get_project_uuid()
        )
        
        if not project_id:
            UsersException.not_found_custom(f"project {self.create_user_dto.get_project_uuid()} not found")
        
        self.project_id = project_id
        
        user_uuid = await self.users_reader_postgres_repository.get_user_uuid_by_project_id_and_project_user_uuid(
            self.project_id,
            self.create_user_dto.get_project_user_uuid()
        )
        
        if user_uuid:
            UsersException.conflict_custom(
                f"user {user_uuid} already exists for this project {self.create_user_dto.get_project_uuid()} and user {self.create_user_dto.get_project_user_uuid()}"
            )
    
    async def __create_user(self) -> None:
        """Create user in database"""
        self.created_user_uuid = await self.users_writer_postgres_repository.create_user({
            "project_id": self.project_id,
            "project_user_uuid": self.create_user_dto.get_project_user_uuid(),
            "user_uuid": self.uuider.get_random_uuid_with_prefix("usr"),
        })
        
        if not self.created_user_uuid:
            UsersException.unexpected_custom("user creation failed")