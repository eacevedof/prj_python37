# project/main.py
# from flask import request, make_response, redirect, render_template, session, redirect, url_for, flash
from flask_login import login_required
import unittest 
from pprint import pprint

# from app.services.firestore import get_users, get_todos, put_todo, delete_todo, update_todo

# from folder-app import __init__.py.def create_app
from app import create_app
# from app.forms.forms import DeleteTodoForm, UpdateTodoForm

from app.controllers.home import Home
from app.controllers.admin import Admin
from app.controllers.todos import Todos
from app.controllers.status import Status


app = create_app()

@app.route("/")
def index():
    return Home().index()
    
@app.route("/todo-list",methods=["GET","POST"])
@login_required
def todo_list():
    return Admin().index()
    
@app.route("/todos/delete/<todoid>",methods=["POST"])
def delete(todoid):
    return Todos().delete(todoid)

@app.route("/todos/update/<todoid>/<int:done>",methods=["POST"])
def update(todoid, done):
    return Todos().update(todoid,done)

@app.errorhandler(404)
def not_found(error):
    return Status().error_404(error)

@app.errorhandler(500)
def not_found(error):
    return (Status()).error_500(error)

# se llamara con: flask test
@app.cli.command()
def test():
    import werkzeug
    werkzeug.cached_property = werkzeug.utils.cached_property
    # todo lo que este en la carpeta de project/test se ejecutara
    tests = unittest.TestLoader().discover("tests")
    unittest.TextTestRunner().run(tests)