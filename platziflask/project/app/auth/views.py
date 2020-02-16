# project/app/auth/views.py
from flask import render_template

# clase LoginForm con el formulario
from app.forms import LoginForm

# importo: Blueprint("auth",__name__,url_prefix="/auth")
from . import auth

# blueprint.route("auth/<ruta>")
@auth.route("/login")
def login():
    context = {
        "loginform": LoginForm()
    }
    return render_template("login.html",**context)
