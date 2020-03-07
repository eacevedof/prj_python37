from .base import Base

from app.services.firestore import FirestoreService

class Todos(Base):
    def __init__(self):
        super().__init__()
        
    def delete(self,todoid):
        userid = self.get_user_id()
        FirestoreService().delete_todo(userid=userid,todoid=todoid)
        return self.redirect("todo_list")

    def update(self,todoid,done):
        userid = self.get_user_id()
        FirestoreService().update_todo(userid=userid,todoid=todoid,done=done)
        return self.redirect("todo_list")