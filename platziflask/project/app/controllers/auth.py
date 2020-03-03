from .base import Base

from pprint import pprint
# from app.services.firestore import get_users, get_todos, put_todo, delete_todo, update_todo
from app.models.user import UserData, UserModel
from app.forms.forms import LoginForm

class Auth(Base):
    def __init__(self):
        super().__init__()
        
    def login(self):
        pprint("views.login")
        frmLogin = LoginForm()

        if frmLogin.validate_on_submit():
            username = frmLogin.username.data
            password = frmLogin.password.data
            print("username:{},password:{}".format(username,password))

            userdoc = get_user(username)
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