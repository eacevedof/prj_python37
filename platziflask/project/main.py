# project/main.py
from flask import Flask, request

app = Flask(__name__)

@app.route("/")
def hello():
    userip = request.remote_addr
    return "Hola tu ip es {}".format(userip)