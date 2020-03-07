# project/app/models/user.py
from flask_login import UserMixin
# from app.services.firestore import get_user
from app.services.firestore import Firestore

class UserData:
    def __init__(self,username, password):
        self.username = username
        self.password = password

class UserModel(UserMixin):
    def __init__(self,user_data):
        """
        ;param user_data: Userdata
        """
        self.id = user_data.username
        self.password = user_data.password

    # se usa en: project/app/__init__.py 
    # @login_manager.user_loader
    # load_user(username)
    @staticmethod
    def query(userid):
        userdoc = Firestore().get_user(userid)
        if userdoc is not None:
            userdata = UserData(
                username = userdoc.id,
                password = userdoc.to_dict()["password"]
            )
        else:
            userdoc = UserData("","")

        return UserModel(userdata)