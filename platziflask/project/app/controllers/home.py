from .base import Base

from app.services.firestore import get_users, get_todos, put_todo, delete_todo, update_todo
from app.forms.forms import TodoForm, DeleteTodoForm, UpdateTodoForm

class Home(Base):
    def __init__(self):
        super().__init__()
        
    def index(self):
        user_ip = self.get_session("user_ip")
        username = self.get_user_id()
        frmtodo = TodoForm()
        deleteform = DeleteTodoForm()
        updateform = UpdateTodoForm()

        context = {
            "user_ip":user_ip,
            "todos":get_todos(userid=username),
            "username":username,
            "todoform":frmtodo,
            "deleteform":deleteform,
            "updateform": updateform
        }

        if frmtodo.validate_on_submit():
            put_todo(userid=username,description=todoform.description.data)
            flash("tu tarea se creó con éxito")
            return redirect(url_for("todo-list"))
    
        # spread operator
        return render_template("todo-list.html",**context)