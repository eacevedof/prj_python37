from flask import Response, Request

from modules.shared.infrastructure.components.log import Log
from modules.shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from modules.shared.infrastructure.components.http.response.http_json_response import HttpJsonResponse

from modules.users.application.update_user.update_user_dto import UpdateUserDto
from modules.users.application.update_user.update_user_service import UpdateUserService
from modules.users.domain.exceptions.update_user_exception import UpdateUserException


def invoke(http_request: Request) -> Response:
    try:
        update_user_dto = UpdateUserDto.from_primitives(
            user_name=http_request.form.get("user_name", ""),
            user_password=http_request.form.get("user_password", ""),
            user_email=http_request.form.get("user_email", ""),
            user_code=http_request.form.get("user_code", "")
        )
        updated_user_dto = UpdateUserService.get_instance().invoke(
            update_user_dto
        )

        return HttpJsonResponse.from_primitives({
            "code": HttpResponseCodeEnum.OK.value,
            "message": "users-tr.update_user",
            "data": {"user": updated_user_dto}
        }).get_as_json_response()

    except CreateUserException as ex:
        return HttpJsonResponse.from_primitives({
            "code": ex.code,
            "message": ex.message,
        }).get_as_json_response()

    except Exception as ex:
        Log.log_exception(ex, "update_user_controller.invoke")
        return HttpJsonResponse.from_primitives({
            "code": HttpResponseCodeEnum.INTERNAL_SERVER_ERROR.value,
            "message": "shared-tr.some-unexpected-error-occurred",
        }).get_as_json_response()
