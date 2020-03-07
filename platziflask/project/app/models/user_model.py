# project/app/models/user_model.py
sc("project/app/models/user_model.py")
from flask_login import UserMixin
from app.services.firestore_service import FirestoreService

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
        userdoc = FirestoreService().get_user(userid)
        if userdoc is not None:
            userdata = UserData(
                username = userdoc.id,
                password = userdoc.to_dict()["password"]
            )
        else:
            userdoc = UserData("","")

        return UserModel(userdata)