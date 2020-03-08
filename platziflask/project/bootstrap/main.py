# project/bootstrap/main.py
# export FLASK_APP=bootstrap/main.p
from bootstrap.builtins_ext import pr
sc("project/bootstrap/main.py")
from flask_login import login_required
import unittest 


# from app.init 
from app import get_flaskapp

from app.controllers.home_controller import HomeController
from app.controllers.admin_controller import AdminController
from app.controllers.todos_controller import TodosController
from app.controllers.status_controller import StatusController

flaskapp = get_flaskapp()

@flaskapp.route("/")
def index():
    return HomeController().index()
    
@flaskapp.route("/todo-list",methods=["GET","POST"])
@login_required
def todo_list():
    return AdminController().index()
    
@flaskapp.route("/todos/delete/<todoid>",methods=["POST"])
def delete(todoid):
    return TodosController().delete(todoid)

@flaskapp.route("/todos/update/<todoid>/<int:done>",methods=["POST"])
def update(todoid, done):
    return TodosController().update(todoid,done)

@flaskapp.errorhandler(404)
def not_found(error):
    return StatusController().error_404(error)

@flaskapp.errorhandler(500)
def not_found(error):
    return StatusController().error_500(error)

# se llamara con: flask test
@flaskapp.cli.command()
def test():
    pr("start test():")
    import werkzeug
    werkzeug.cached_property = werkzeug.utils.cached_property
    # todo lo que este en la carpeta de project/test se ejecutara
    tests = unittest.TestLoader().discover("tests")
    unittest.TextTestRunner().run(tests)