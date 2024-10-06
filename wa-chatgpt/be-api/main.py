import importlibfrom flask import Flask, request, Responsefrom asgiref.wsgi import WsgiToAsgifrom shared.domain.enums.http_response_code_enum import HttpResponseCodeEnumfrom shared.infrastructure.http.response.http_json_response import HttpJsonResponseapp_flask = Flask(__name__)def get_result_after_invoke(module_path: str, http_request: request) -> Response | str:    try:        module = importlib.import_module(module_path)        fn_invoke = getattr(module, "invoke")        return fn_invoke(http_request)    except Exception as ex:        return HttpJsonResponse.from_primitives({            "code": HttpResponseCodeEnum.INTERNAL_SERVER_ERROR.value,            "message": "shared-tr.unexpected-error",            "data": {"infrastructure": str(ex)}        }).get_as_json_response()@app_flask.route("/api/v1/whatsapp/send-text-message", methods=["POST"])async def whatsapp_send_text_message() -> Response:    return get_result_after_invoke(         "whatsapp.infrastructure.controllers.send_message_controller",        request    )@app_flask.route("/api/v1/talk-to-gpt", methods=["GET"])async def talk_to_gpt35_controller() -> Response:    return get_result_after_invoke(         "open_ai.infrastructure.controllers.talk_to_gpt35_controller",        request    )@app_flask.route("/api/v1/health-check", methods=["GET"])async def get_health_check_controller() -> Response:    return get_result_after_invoke(        "health_check.infrastructure.controllers.get_health_check_controller",        request    )@app_flask.route("/", methods=["GET"])async def get_documentation_controller():    return get_result_after_invoke(        "api_doc.infrastructure.controllers.get_documentation_controller",        request    )if __name__ == "__main__":    app_flask.run()    #import uvicorn    #async_flask = WsgiToAsgi(app_flask)    # uvicorn.run(app_flask, host="0.0.0.0", port=3000, log_level="info")    #uvicorn.run(async_flask, host="127.0.0.1", port=5000, log_level="info")