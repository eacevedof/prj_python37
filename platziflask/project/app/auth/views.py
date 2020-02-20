# project/app/auth/views.py
from flask import render_template, session, redirect, flash, url_for
from flask_login import login_user, login_required, logout_user

from werkzeug.security import generate_password_hash
from app.forms.forms import LoginForm

# importo: Blueprint("auth",__name__,url_prefix="/auth")
from . import bpauth
from app.services.firestore import get_user, user_put
from app.models.user import UserData, UserModel

# blueprint.route("auth/<ruta>")
@bpauth.route("/login", methods=["GET","POST"])
def login():

    loginform = LoginForm()

    if loginform.validate_on_submit():
        username = loginform.username.data
        password = loginform.password.data

        userdoc = get_user(username)
        if userdoc.to_dict() is not None:
            passdb = userdoc.to_dict()["password"]

            if passdb == password:
                userdata = UserData(username, password)
                #user = UserData(username, password)
                user = UserModel(userdata)
                login_user(user)
                flash("Bienvenido de nuevo")
                redirect(url_for("todo-list"))
            else:
                flash("La informacion no coincide")
        else:
            flash("El usuario no existe")

        return redirect(url_for("index"))
    
    context = {
        "loginform": loginform
    }        
    return render_template("login.html",**context)


@bpauth.route("signup",methods=["GET","POST"])
def signup():
    signupform = LoginForm()
    context = {
        "signupform":signupform
    }

    if signupform.validate_on_submit():
        username = signupform.username.data
        password = signupform.password.data

        userdoc = get_user(username)
        if userdoc.to_dict() is None:
            passwordhash = generate_password_hash(password)
            userdata = UserData(username, passwordhash)
            user_put(userdata)
            user = UserModel(userdata)
            login_user(user)
            flash("bienvenido")
            return redirect(url_for("todo-list"))
        else:
            flash("El usuario ya existe")


    return render_template("signup.html",**context)


@bpauth.route("logout")
@login_required
def logout():
    logout_user()
    flash("Regresa pronto")
    return redirect(url_for("auth.login"))

