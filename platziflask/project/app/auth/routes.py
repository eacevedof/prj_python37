# project/app/auth/routes.py
s("project/app/auth/routes.py")

#blueprint en init.py
from . import blueprint_auth
#from flask_login import login_required
from app.controllers.auth_controller import AuthController

# blueprint.route("auth/<ruta>")
@blueprint_auth.route("/login", methods=["GET","POST"])
def login():
    return AuthController().login()

@blueprint_auth.route("signup",methods=["GET","POST"])
def signup():
    return AuthController().signup()

@blueprint_auth.route("logout")
#@login_required
def logout():
    return AuthController().logout()

