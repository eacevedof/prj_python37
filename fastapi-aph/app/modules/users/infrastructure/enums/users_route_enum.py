from enum import Enum

class UsersRouteEnum(Enum):
    CREATE_USER_V1 = "/v1/users/create-user"
    DELETE_USER_V1 = "/v1/users/delete-user/{user_uuid}"