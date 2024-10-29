from dataclasses import dataclass
from typing import final
from modules.users.infrastructure.repositories.users_writer_postgres_repository import UsersWriterPostgresRepository
from modules.users.infrastructure.repositories.users_reader_postgres_repository import UsersReaderPostgresRepository
from shared.infrastructure.components.encrypter import Encrypter
from shared.infrastructure.components.uuider import Uuider
from users.application.create_user.create_user_dto import CreateUserDto
from users.application.create_user.created_user_dto import CreatedUserDto
from users.domain.entities.user_entity import UserEntity


@final
@dataclass(frozen=True)
class CreateUserService:

    __uuider: Uuider
    __encrypter: Encrypter
    __users_writer_repository: UsersWriterPostgresRepository
    __users_reader_repository: UsersReaderPostgresRepository

    @staticmethod
    def get_instance() -> 'CreateUserService':
        return CreateUserService(
            Uuider.get_instance(),
            Encrypter.get_instance(),
            UsersWriterPostgresRepository.get_instance(),
            UsersReaderPostgresRepository.get_instance()
        )

    def invoke(self, create_user_dto: CreateUserDto) -> CreatedUserDto:
        user_uuid = self.__uuider.get_id_with_prefix("usr")
        user_password = self.__encrypter.get_encrypted(create_user_dto.user_password)

        user_entity = UserEntity.from_primitives(
            id=None,
            user_uuid=user_uuid,
            user_name=create_user_dto.user_name,
            user_password=user_password,
            user_email=create_user_dto.user_email,
            user_code=create_user_dto.user_code,
            user_login="",
            created_at=""
        )
        user_entity.login_with_email()
        self.__users_writer_repository.create_user(user_entity)

        new_user = self.__users_reader_repository.get_user_by_uuid(user_entity)
        return CreatedUserDto.from_primitives(
            new_user.id,
            new_user.user_uuid,
            new_user.user_name,
            new_user.user_login,
            new_user.user_email,
            new_user.user_code,
            new_user.created_at
        )