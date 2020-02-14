# project/main.py
from flask import Flask, request, make_response, redirect, render_template

app = Flask(__name__)

@app.route("/")
def index():
    user_ip = request.remote_addr
    response = make_response(redirect("/hello"))
    response.set_cookie("user_ip",user_ip+" :) ")
    return response

todos = ["Comprar cafe","Enviar solicitud","Entregar video"]

@app.route("/hello")
def hello():
    userip = request.cookies.get("user_ip")
    context = {
        "user_ip":userip,
        "todos":todos
    }
    # spread operator
    return render_template("hello.html",**context)