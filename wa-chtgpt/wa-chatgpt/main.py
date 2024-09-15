from flask import Flask, request, jsonify
from asgiref.wsgi import WsgiToAsgi

app = Flask(__name__)

@app.route("/", methods=["GET"])
def index():
    response = {
        "message": "API documentation"
    }
    return jsonify(response)

@app.route("/get-data", methods=["GET"])
def get_data():
    param1 = request.args.get("param1")
    param2 = request.args.get("param2")
    response = {
        "param1": param1,
        "param2": param2,
        "message": "GET request received successfully!"
    }
    return jsonify(response)

if __name__ == "__main__":
    import uvicorn
    asgi_app = WsgiToAsgi(app)
    uvicorn.run(asgi_app, host="0.0.0.0", port=5000, log_level="info")