from dataclasses import dataclass
from typing import final
from modules.users.infrastructure.repositories.users_postgres_repository import UsersPostgresRepository
from shared.infrastructure.components.encrypter import Encrypter
from shared.infrastructure.components.uuider import Uuider
from users.application.create_user.create_user_dto import CreateUserDto
from users.domain.entities.user_entity import UserEntity


@final
@dataclass(frozen=True)
class CreateUserService:

    __uuider: Uuider
    __encrypter: Encrypter
    __users_repository: UsersPostgresRepository

    @staticmethod
    def get_instance() -> 'CreateUserService':
        return CreateUserService(
            Uuider.get_instance(),
            Encrypter.get_instance(),
            UsersPostgresRepository.get_instance()
        )

    def invoke(self, create_user_dto: CreateUserDto) -> None:
        user_uuid = self.__uuider.get_id_with_prefix("usr")
        user_password = self.__encrypter.get_encrypted(create_user_dto.user_password)
        user_entity = UserEntity.from_primitives(
            user_uuid=user_uuid,
            user_name=create_user_dto.user_name,
            user_password=user_password,
            user_email=create_user_dto.user_email,
            user_code=create_user_dto.user_code
        )
        self.__users_repository.create_user(user_entity)