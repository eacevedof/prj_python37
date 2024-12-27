from flask import Request, Response

from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.http.response.http_json_response import HttpJsonResponse
from modules.shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum

from modules.lang_chain.application.lc_ask_question.lc_ask_question_dto import LcAskQuestionDTO
from modules.lang_chain.application.lc_ask_question.lc_ask_question_service import LcAskQuestionService
from modules.open_ai.domain.exceptions.lc_ask_question_exception import LcAskQuestionException


def invoke(http_request: Request) -> Response:
    try:
        lc_ask_question_dto = LcAskQuestionDTO(
            question=http_request.args["question"]
        )
        talked_to_gpt35_dto = LcAskQuestionService.get_instance().invoke(
            lc_ask_question_dto
        )

        return HttpJsonResponse.from_primitives({
            "code": HttpResponseCodeEnum.OK.value,
            "message": "open-ai-tr.lc_ask_question",
            "data": {"chat_response": talked_to_gpt35_dto.chat_response}
        }).get_as_json_response()

    except LcAskQuestionException as ex:
        return HttpJsonResponse.from_primitives({
            "code": ex.code,
            "message": ex.message,
        }).get_as_json_response()

    except Exception as ex:
        Log.log_exception(ex, "lc_ask_question_controller.invoke")
        return HttpJsonResponse.from_primitives({
            "code": HttpResponseCodeEnum.INTERNAL_SERVER_ERROR.value,
            "message": "shared-tr.some-unexpected-error-occurred",
        }).get_as_json_response()

