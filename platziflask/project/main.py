# project/main.py
from flask import request, make_response, redirect, render_template, session, redirect, url_for, flash
from flask_login import login_required, current_user
import unittest 
from pprint import pprint

from app.services.firestore import get_users, get_todos, put_todo

# from folder-app import __init__.py.def create_app
from app import create_app
from app.forms import LoginForm, TodoForm

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

@app.route("/hello",methods=["GET","POST"])
@login_required
def hello():
    user_ip = session.get("user_ip")
    username = current_user.id
    todoform = TodoForm()

    context = {
        "user_ip":user_ip,
        "todos":get_todos(userid=username),
        "username":username,
        "todoform":todoform
    }

    if todoform.validate_on_submit():
        put_todo(userid=username,description=todoform.description.data)
        flash("tu tarea se creó con éxito")
        return redirect(url_for("hello"))
  
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

