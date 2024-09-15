from flask import Flask, request, jsonify, render_template_string
from asgiref.wsgi import WsgiToAsgi

app_flask = Flask(__name__)

@app_flask.route("/x", methods=["GET"])
async def get_documentation_html():
    from api_doc.infrastructure.controllers.get_documentation_controller import invoke
    html = invoke()
    return render_template_string(html)

@app_flask.route("/", methods=["GET"])
async def index2():
    response = {
        "message": "API documentation"
    }
    return render_template_string("hola")

if __name__ == "__main__":
    import uvicorn
    async_flask = WsgiToAsgi(app_flask)
    # uvicorn.run(app_flask, host="0.0.0.0", port=3000, log_level="info")
    uvicorn.run(async_flask, host="0.0.0.0", port=3000, log_level="info")