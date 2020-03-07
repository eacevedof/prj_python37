# project/app/auth/views.py
# importo: Blueprint("auth",__name__,url_prefix="/auth")
from . import blueprint_auth
#from flask_login import login_required
from app.controllers.auth import Auth

# blueprint.route("auth/<ruta>")
@blueprint_auth.route("/login", methods=["GET","POST"])
def login():
    return Auth().login()

@blueprint_auth.route("signup",methods=["GET","POST"])
def signup():
    return Auth().signup()

@blueprint_auth.route("logout")
#@login_required
def logout():
    return Auth().logout()

