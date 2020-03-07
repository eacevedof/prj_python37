from .base_controller import BaseController

class HomeController(BaseController):
    def __init__(self):
        super().__init__()
        
    def index(self):
        sc("HomeController.index")
        return self.render("index.html")