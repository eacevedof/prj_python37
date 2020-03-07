from .base import Base

from pprint import pprint
from app.services.firestore import  FirestoreService
from app.forms.forms import TodoForm, DeleteTodoForm, UpdateTodoForm

class Admin(Base):
    def __init__(self):
        super().__init__()
        
    def index(self):
        pprint("Admin.index()")

        user_ip = self.get_session("user_ip")
        username = self.get_user_id()
        frmtodo = TodoForm()
        deleteform = DeleteTodoForm()
        updateform = UpdateTodoForm()

        context = {
            "user_ip":user_ip,
            "todos":FirestoreService().get_todos(userid=username),
            "username":username,
            "todoform":frmtodo,
            "deleteform":deleteform,
            "updateform": updateform
        }

        if frmtodo.validate_on_submit():
            FirestoreService().put_todo(userid=username,description=frmtodo.description.data)
            self.set_flash("tu tarea se creó con éxito")
            return self.redirect("todo_list")
    
        # spread operator
        print("Admin.index.render(todo-list.html)")
        return self.render("todo-list.html",**context)