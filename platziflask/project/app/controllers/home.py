from .base import Base

class Home(Base):
    def __init__(self):
        super().__init__()
        
    def index(self):
        return self.render("index.html")