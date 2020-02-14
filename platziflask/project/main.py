# project/main.py
from flask import Flask, request, make_response, redirect, render_template

app = Flask(__name__)

@app.route("/")
def index():
    user_ip = request.remote_addr
    response = make_response(redirect("/hello"))
    response.set_cookie("user_ip",user_ip+" :) ")
    return response

@app.route("/hello")
def hello():
    userip = request.cookies.get("user_ip")
    # return "Hola tu ip es {}".format(userip)
    return render_template("hello.html",user_ip=userip)