import importlibfrom flask import Flask, request, Responsefrom asgiref.wsgi import WsgiToAsgiapp_flask = Flask(__name__)def get_result_after_invoke(module_path: str, http_request: request) -> Response | str:    module = importlib.import_module(module_path)    fn_invoke = getattr(module, "invoke")    return fn_invoke(http_request)@app_flask.route("/", methods=["GET"])async def get_documentation_controller():    return get_result_after_invoke(        "api_doc.infrastructure.controllers.get_documentation_controller",        request    )@app_flask.route("/api/v1/health-check", methods=["GET"])async def get_health_check_controller() -> Response:    return (get_result_after_invoke(        "health_check.infrastructure.controllers.get_health_check_controller",        request    )@app_flask.route("/api/v1/talk-to-gpt", methods=["GET"]))async def talk_to_gpt35_controller() -> Response:    return get_result_after_invoke(        "open_ai.infrastructure.controllers.talk_to_gpt35_controller",        request    )if __name__ == "__main__":    import uvicorn    async_flask = WsgiToAsgi(app_flask)    # uvicorn.run(app_flask, host="0.0.0.0", port=3000, log_level="info")    uvicorn.run(async_flask, host="0.0.0.0", port=3000, log_level="info")