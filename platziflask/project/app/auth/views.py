# project/app/auth/views.py
# importo: Blueprint("auth",__name__,url_prefix="/auth")
from . import bpauth
#from flask_login import login_required
from app.controllers.auth import Auth

# blueprint.route("auth/<ruta>")
@bpauth.route("/login", methods=["GET","POST"])
def login():
    return Auth().login()

@bpauth.route("signup",methods=["GET","POST"])
def signup():
    return Auth().signup()

@bpauth.route("logout")
#@login_required
def logout():
    return Auth().logout()

