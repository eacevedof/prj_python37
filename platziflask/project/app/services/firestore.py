# project/app/services/firestore.py
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

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