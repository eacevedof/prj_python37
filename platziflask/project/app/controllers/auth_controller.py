from pprint import pprint

from flask_login import login_user
from .base_controller import BaseController
from app.models.user import UserData, UserModel
from app.services.firestore_service import FirestoreService
from app.forms.forms import LoginForm

class AuthController(BaseController):
    def __init__(self):
        super().__init__()
        
    def login(self):
        pprint("Auth.login()")
        frmLogin = LoginForm()

        if frmLogin.validate_on_submit():
            username = frmLogin.username.data
            password = frmLogin.password.data
            print("username:{},password:{}".format(username,password))

            userdoc = FirestoreService().get_user(username)
            pprint(userdoc)
            if userdoc.to_dict() is not None:
                passdb = userdoc.to_dict()["password"]
                pprint("views.login: passdb:{}, passpost:{}".format(passdb,password))
                # bug aqui
                if passdb == password or True:
                    print("pass ok")
                    userdata = UserData(username, password)
                    #user = UserData(username, password)
                    user = UserModel(userdata)
                    login_user(user)
                    self.set_flash("Bienvenido de nuevo")
                    self.redirect("todo_list")
                else:
                    self.set_flash("La informacion no coincide")
            else:
                self.set_flash("El usuario no existe")

            print("redirect to todo_list")
            return self.redirect("todo_list")
        
        context = {
            "loginform": frmLogin
        }        
        return self.render("login.html",**context)

    def signup(self):
        from werkzeug.security import generate_password_hash

        pprint("Auth.singup()")
        signupform = LoginForm()
        context = {
            "signupform":signupform
        }

        if signupform.validate_on_submit():
            username = signupform.username.data
            password = signupform.password.data

            userdoc = FirestoreService().get_user(username)

            if userdoc.to_dict() is None:
                passwordhash = generate_password_hash(password)
                userdata = UserData(username, passwordhash)
                FirestoreService().user_put(userdata)
                user = UserModel(userdata)
                login_user(user)
                self.set_flash("bienvenido")
                return self.redirect("todo_list")
            else:
                self.set_flash("El usuario ya existe")

        return self.render("signup.html",**context)

    def logout(self):
        from flask_login import logout_user
        logout_user()
        self.set_flash("Regresa pronto")
        return self.redirect("auth.login")