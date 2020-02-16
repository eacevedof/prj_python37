# project/main.py
from flask import request, make_response, redirect, render_template, session, redirect, url_for, flash
import unittest 
from pprint import pprint

from app.services.firestore import get_users, get_todos

# from folder-app import __init__.py.def create_app
from app import create_app
from app.forms import LoginForm

app = create_app()

@app.errorhandler(404)
def not_found(error):
    return render_template("404.html",error=error)

@app.errorhandler(500)
def not_found(error):
    return render_template("500.html",error=error)

@app.route("/")
def index():
    user_ip = request.remote_addr
    response = make_response(redirect("/hello"))
    # response.set_cookie("user_ip",user_ip+" :) ")
    session["user_ip"] = user_ip
    return response

# todos = ["Comprar cafe","Enviar solicitud","Entregar video"]

@app.route("/hello",methods=["GET","POST"])
def hello():
    user_ip = session.get("user_ip")
    username = session.get("username")

    context = {
        "user_ip":user_ip,
        "todos":get_todos(userid=username),
        "username":username
    }

    # devuelve un generator
    genusers = get_users()
    #pprint(users)
    #pprint(type(users))

    for objuser in genusers:
        #objuser: <google.cloud.firestore_v1.document.DocumentSnapshot object at 0x10eaec790>
        print(objuser.id)
        print(objuser.to_dict()["password"])

    # spread operator
    return render_template("hello.html",**context)

# se llamara con: flask test
@app.cli.command()
def test():
    import werkzeug
    werkzeug.cached_property = werkzeug.utils.cached_property
    # todo lo que este en la carpeta de project/test se ejecutara
    tests = unittest.TestLoader().discover("tests")
    unittest.TextTestRunner().run(tests)

