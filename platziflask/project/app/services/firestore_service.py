# project/app/services/firestore_service.py
s("project/app/services/firestore_service.py")
import firebase_admin
# from firebase_admin import credentials
from firebase_admin import firestore

# https://stackoverflow.com/questions/56676296/initialize-app-the-default-firebase-app-already-exists-cloud-functions-pub-s
# credential = credentials.ApplicationDefault()
#firebase_admin.initialize_app(credential)

if not firebase_admin._DEFAULT_APP_NAME in firebase_admin._apps:
    firebase_admin.initialize_app()

db = firestore.client()

class FirestoreService():
    
    def __init__(self):
        pass

    def get_users():
        return db.collection("users").get()

    def get_todos(self,userid):
        return db.collection("users")\
                .document(userid)\
                .collection("todos").get()

    def get_user(self,userid):
        return db.collection("users").document(userid).get()

    def user_put(self, userdata):
        userref = db.collection("users").document(userdata.username)
        userref.set({"password":userdata.password})

    def put_todo(self, userid,description):
        todoscollection = db.collection("users").document(userid).collection("todos")
        todoscollection.add({"description":description,"done":False})
        
    def delete_todo(self, userid, todoid):
        todoref = self._get_todo_ref(userid,todoid)
        todoref.delete()
        #todoref = db.collection("users").document(userid).collection("todos").document(todoid)

    def update_todo(self, userid,todoid,done):
        tododone = not bool(done)
        todoref = self._get_todo_ref(userid,todoid)
        todoref.update({"done": tododone})
        
    def _get_todo_ref(self,userid,todoid):
        return db.document("users/{}/todos/{}".format(userid,todoid))