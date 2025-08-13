from dataclasses import dataclass
from typing import final

from modules.shared.infrastructure.components.encrypter import Encrypter
from modules.shared.infrastructure.components.uuider import Uuider
from modules.users.application.get_api_auth_token_by_user.get_api_auth_token_by_user_dto import GetApiAuthTokenByUserDto
from modules.users.application.get_api_auth_token_by_user.got_api_auth_token_by_user_dto import GotApiAuthTokenByUserDto
from modules.users.domain.entities.user_entity import UserEntity
from modules.users.infrastructure.repositories.users_writer_postgres_repository import UsersWriterPostgresRepository
from modules.users.infrastructure.repositories.users_reader_postgres_repository import UsersReaderPostgresRepository
from modules.users.domain.exceptions.get_api_auth_token_by_user_exception import GetApiAuthTokenByUserException

@final
@dataclass(frozen=False)
class GetApiAuthTokenByUserService:

    __get_api_auth_token_by_user_dto: GetApiAuthTokenByUserDto
    __uuider: Uuider
    __encrypter: Encrypter
    __users_writer_repository: UsersWriterPostgresRepository
    __users_reader_repository: UsersReaderPostgresRepository

    @staticmethod
    def get_instance() -> 'GetApiAuthTokenByUserService':
        return GetApiAuthTokenByUserService(
            Uuider.get_instance(),
            Encrypter.get_instance(),
            UsersWriterPostgresRepository.get_instance(),
            UsersReaderPostgresRepository.get_instance()
        )

    def invoke(self, get_api_auth_token_by_user_dto: GetApiAuthTokenByUserDto) -> GotApiAuthTokenByUserDto:
        self.__get_api_auth_token_by_user_dto = get_api_auth_token_by_user_dto

        self.__fail_if_wrong_input()

        user_uuid = self.__uuider.get_id_with_prefix("usr")
        user_password = self.__encrypter.get_encrypted(get_api_auth_token_by_user_dto.user_password)

        user_entity = UserEntity.from_primitives(
            id=None,
            user_uuid=user_uuid,
            user_name=get_api_auth_token_by_user_dto.user_name,
            user_password=user_password,
            user_email=get_api_auth_token_by_user_dto.user_email,
            user_code=get_api_auth_token_by_user_dto.user_code,
            user_login="",
            created_at=""
        )
        self.__users_writer_repository.get_api_auth_token_by_user_by_uuid(user_entity)

        new_user = self.__users_reader_repository.get_user_by_uuid(user_entity)
        return GotApiAuthTokenByUserDto.from_primitives(
            new_user.id,
            new_user.user_uuid,
            new_user.user_name,
            new_user.user_login,
            new_user.user_email,
            new_user.user_code,
            new_user.created_at
        )

    def __fail_if_wrong_input(self) -> None:
        if not self.__get_api_auth_token_by_user_dto.user_name:
            raise GetApiAuthTokenByUserException.empty_user_name()


