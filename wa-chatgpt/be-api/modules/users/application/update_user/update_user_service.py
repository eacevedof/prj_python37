from dataclasses import dataclass
from typing import final
from modules.users.infrastructure.repositories.users_writer_postgres_repository import UsersWriterPostgresRepository
from modules.users.infrastructure.repositories.users_reader_postgres_repository import UsersReaderPostgresRepository
from shared.infrastructure.components.encrypter import Encrypter
from shared.infrastructure.components.uuider import Uuider
from users.application.update_user.update_user_dto import UpdateUserDto
from users.application.update_user.created_user_dto import CreatedUserDto
from users.domain.entities.user_entity import UserEntity
from users.domain.exceptions.update_user_exception import UpdateUserException


@final
@dataclass(frozen=False)
class UpdateUserService:
    __update_user_dto: UpdateUserDto
    __uuider: Uuider
    __encrypter: Encrypter
    __users_writer_repository: UsersWriterPostgresRepository
    __users_reader_repository: UsersReaderPostgresRepository

    @staticmethod
    def get_instance() -> 'UpdateUserService':
        return UpdateUserService(
            Uuider.get_instance(),
            Encrypter.get_instance(),
            UsersWriterPostgresRepository.get_instance(),
            UsersReaderPostgresRepository.get_instance()
        )

    def invoke(self, update_user_dto: UpdateUserDto) -> CreatedUserDto:
        self.__update_user_dto = update_user_dto

        self.__fail_if_wrong_input()

        user_uuid = self.__uuider.get_id_with_prefix("usr")
        user_password = self.__encrypter.get_encrypted(update_user_dto.user_password)

        user_entity = UserEntity.from_primitives(
            id=None,
            user_uuid=user_uuid,
            user_name=update_user_dto.user_name,
            user_password=user_password,
            user_email=update_user_dto.user_email,
            user_code=update_user_dto.user_code,
            user_login="",
            created_at=""
        )
        user_entity.login_with_email()
        self.__users_writer_repository.update_user(user_entity)

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
        if not self.__update_user_dto.user_name:
            raise UpdateUserException.empty_user_name()


