from .base import Base

#from app.services.firestore import  (get_todos, put_todo, delete_todo, update_todo)
from app.services.firestore import  Firestore

class Todos(Base):
    def __init__(self):
        super().__init__()
        
    def delete(self,todoid):
        userid = self.get_user_id()
        Firestore().delete_todo(userid=userid,todoid=todoid)
        return self.redirect("todo_list")

    def update(self,todoid,done):
        userid = self.get_user_id()
        Firestore().update_todo(userid=userid,todoid=todoid,done=done)
        return self.redirect("todo_list")