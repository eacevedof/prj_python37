# project/main.py
from flask_login import login_required
import unittest 

from bootstrap.builtins_ext import *

# from app.init 
from app import get_flaskapp

from app.controllers.home import Home
from app.controllers.admin import Admin
from app.controllers.todos import Todos
from app.controllers.status import Status

flaskapp = get_flaskapp()

@flaskapp.route("/")
def index():
    return Home().index()
    
@flaskapp.route("/todo-list",methods=["GET","POST"])
@login_required
def todo_list():
    return Admin().index()
    
@flaskapp.route("/todos/delete/<todoid>",methods=["POST"])
def delete(todoid):
    return Todos().delete(todoid)

@flaskapp.route("/todos/update/<todoid>/<int:done>",methods=["POST"])
def update(todoid, done):
    return Todos().update(todoid,done)

@flaskapp.errorhandler(404)
def not_found(error):
    return Status().error_404(error)

@flaskapp.errorhandler(500)
def not_found(error):
    return Status().error_500(error)

# se llamara con: flask test
@flaskapp.cli.command()
def test():
    pr("start test():")
    import werkzeug
    werkzeug.cached_property = werkzeug.utils.cached_property
    # todo lo que este en la carpeta de project/test se ejecutara
    tests = unittest.TestLoader().discover("tests")
    unittest.TextTestRunner().run(tests)