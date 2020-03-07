from .base_controller import BaseController

class HomeController(BaseController):
    def __init__(self):
        super().__init__()
        
    def index(self):
        return self.render("index.html")