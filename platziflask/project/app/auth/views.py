# project/app/auth/views.py
from flask import render_template, session, redirect, flash, url_for

# clase LoginForm con el formulario
from app.forms import LoginForm

# importo: Blueprint("auth",__name__,url_prefix="/auth")
from . import auth

# blueprint.route("auth/<ruta>")
@auth.route("/login", methods=["GET","POST"])
def login():

    loginform = LoginForm()
    context = {
        "loginform": loginform
    }

    if loginform.validate_on_submit():
        username = loginform.username.data
        session["username"] = username
        flash("Nombre de usuario registrado con exito")
        password = loginform.password.data
        return redirect(url_for("index"))
        
    return render_template("login.html",**context)
