from .base import Base

from app.services.firestore import get_users, get_todos, put_todo, delete_todo, update_todo
from app.forms.forms import TodoForm, DeleteTodoForm, UpdateTodoForm

class Home(Base):
    def __init__(self):
        super().__init__()
        
    def index(self):
        return render_template("index.html")