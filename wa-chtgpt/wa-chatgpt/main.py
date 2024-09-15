from flask import Flask, request, jsonify
from asgiref.wsgi import WsgiToAsgi

app_flask = Flask(__name__)

@app_flask.route("/", methods=["GET"])
async def index():
    response = {
        "message": "API documentation"
    }
    return jsonify(response)

if __name__ == "__main__":
    import uvicorn
    async_flask = WsgiToAsgi(app_flask)
    # uvicorn.run(app_flask, host="0.0.0.0", port=3000, log_level="info")
    uvicorn.run(async_flask, host="0.0.0.0", port=3000, log_level="info")