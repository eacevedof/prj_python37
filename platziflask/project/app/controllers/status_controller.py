from .base_controller import BaseController

class StatusController(BaseController):
    def __init__(self):
        super().__init__()
        
    def error_500(self,error):
        return self.render("500.html",error=error)

    def error_404(self,error):
        return self.render("404.html",error=error)        