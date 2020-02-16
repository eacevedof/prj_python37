# project/app/models/user.py
from flask_login import UserMixin
from app.services.firestore import get_user

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

    @staticmethod
    def query(userid):
        userdoc = get_user(userid)
        userdata = UserData(
            username = userdoc.id,
            password = userdoc.to_dict()["password"]
        )

        return UserModel(userdata)