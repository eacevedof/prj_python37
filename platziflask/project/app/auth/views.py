# project/app/auth/views.py
from flask import render_template, session, redirect, flash, url_for
from flask_login import login_user, login_required, logout_user

# clase LoginForm con el formulario
from app.forms import LoginForm

# importo: Blueprint("auth",__name__,url_prefix="/auth")
from . import auth
from app.services.firestore import get_user
from app.models.user import UserData, UserModel

# blueprint.route("auth/<ruta>")
@auth.route("/login", methods=["GET","POST"])
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
                redirect(url_for("hello"))
            else:
                flash("La informacion no coincide")
        else:
            flash("El usuario no existe")

        return redirect(url_for("index"))
    
    context = {
        "loginform": loginform
    }        
    return render_template("login.html",**context)


@auth.route("logout")
@login_required
def logout():
    logout_user()
    flash("Regresa pronto")
    return redirect(url_for("auth.login"))

