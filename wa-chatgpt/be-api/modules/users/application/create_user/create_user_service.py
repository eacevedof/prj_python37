from dataclasses import dataclass
from typing import final

from modules.shared.infrastructure.components.encrypter import Encrypter
from modules.shared.infrastructure.components.uuider import Uuider
from modules.users.infrastructure.repositories.users_writer_postgres_repository import UsersWriterPostgresRepository
from modules.users.infrastructure.repositories.users_reader_postgres_repository import UsersReaderPostgresRepository
from modules.users.application.create_user.create_user_dto import CreateUserDto
from modules.users.application.create_user.created_user_dto import CreatedUserDto
from modules.users.domain.entities.user_entity import UserEntity
from modules.users.domain.exceptions.create_user_exception import CreateUserException


@final
@dataclass(frozen=False)
class CreateUserService:
    __create_user_dto: CreateUserDto
    __uuider: Uuider
    __encrypter: Encrypter
    __users_writer_repository: UsersWriterPostgresRepository
    __users_reader_repository: UsersReaderPostgresRepository

    @staticmethod
    def get_instance() -> 'CreateUserService':
        return CreateUserService(
            None,
            Uuider.get_instance(),
            Encrypter.get_instance(),
            UsersWriterPostgresRepository.get_instance(),
            UsersReaderPostgresRepository.get_instance()
        )

    def invoke(self, create_user_dto: CreateUserDto) -> CreatedUserDto:
        self.__create_user_dto = create_user_dto

        self.__fail_if_wrong_input()

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

    def __fail_if_wrong_input(self) -> None:
        if not self.__create_user_dto.user_name:
            raise CreateUserException.empty_user_name()

        user_name = self.__create_user_dto.user_name
        user_entity = UserEntity.from_primitives(user_name=user_name)
        user_entity = self.__users_reader_repository.get_user_by_user_name(user_entity)
        if user_entity:
            raise CreateUserException.user_name_already_exists()




