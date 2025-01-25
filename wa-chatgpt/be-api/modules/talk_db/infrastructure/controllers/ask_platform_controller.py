from flask import Request, Response

from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.http.response.http_json_response import HttpJsonResponse
from modules.shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum

from modules.talk_db.application.lc_ask_platform.lc_ask_platform_dto import LcAskPlatformDTO
from modules.talk_db.application.lc_ask_platform.lc_ask_platform_service import LcAskPlatformService
from modules.talk_db.domain.exceptions.ask_platform_exception import AskPlatformException


def invoke(http_request: Request) -> Response:
    try:
        lc_ask_platform_dto = LcAskPlatformDTO(
            question=http_request.args["question"]
        )
        lc_asked_question_dto = LcAskPlatformService.get_instance().invoke(
            lc_ask_platform_dto
        )

        return HttpJsonResponse.from_primitives({
            "code": HttpResponseCodeEnum.OK.value,
            "message": "talk-db-tr.lc_ask_platform",
            "data": {"chat_response": lc_asked_question_dto.chat_response}
        }).get_as_json_response()

    except AskPlatformException as ex:
        return HttpJsonResponse.from_primitives({
            "code": ex.code,
            "message": ex.message,
        }).get_as_json_response()

    except Exception as ex:
        Log.log_exception(ex, "lc_ask_platform_controller.invoke")
        return HttpJsonResponse.from_primitives({
            "code": HttpResponseCodeEnum.INTERNAL_SERVER_ERROR.value,
            "message": "shared-tr.some-unexpected-error-occurred",
        }).get_as_json_response()

