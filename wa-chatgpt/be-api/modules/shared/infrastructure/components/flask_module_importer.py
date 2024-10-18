import importlib
from flask import request, Response
from modules.shared.infrastructure.components.log import Log
from modules.shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from modules.shared.infrastructure.components.http.response.http_json_response import HttpJsonResponse


def get_result_after_invoke(module_path: str, http_request: request) -> Response | str:
    try:
        module = importlib.import_module(module_path)
        fn_invoke = getattr(module, "invoke")
        return fn_invoke(http_request)
    except Exception as ex:
        Log.log_exception(ex, "main.get_result_after_invoke")
        return HttpJsonResponse.from_primitives({
            "code": HttpResponseCodeEnum.INTERNAL_SERVER_ERROR.value,
            "message": "shared-tr.unexpected-error",
            "data": {"infrastructure": str(ex), "module_path": module_path}
        }).get_as_json_response()
