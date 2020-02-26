# project/app/services/firestore.py
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

try:
    app = firebase_admin.get_app()
except ValueError as e:
    credential = credentials.ApplicationDefault()
    firebase_admin.initialize_app(credential)


db = firestore.client()

def get_users():
    return db.collection("users").get()

def get_todos(userid):
    return db.collection("users")\
            .document(userid)\
            .collection("todos").get()

def get_user(userid):
    return db.collection("users").document(userid).get()

def user_put(userdata):
    userref = db.collection("users").document(userdata.username)
    userref.set({"password":userdata.password})

def put_todo(userid,description):
    todoscollection = db.collection("users").document(userid).collection("todos")
    todoscollection.add({"description":description,"done":False})
    
def delete_todo(userid, todoid):
    todoref = _get_todo_ref(userid,todoid)
    todoref.delete()
    #todoref = db.collection("users").document(userid).collection("todos").document(todoid)

def update_todo(userid,todoid,done):
    tododone = not bool(done)
    todoref = _get_todo_ref(userid,todoid)
    todoref.update({"done": tododone})
    
def _get_todo_ref(userid,todoid):
    return db.document("users/{}/todos/{}".format(userid,todoid))