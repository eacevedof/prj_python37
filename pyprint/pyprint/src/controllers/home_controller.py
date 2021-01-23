import sys
import os

class HomeController:
    def __init__(self):
        pass

    def index(self):
        paths = []
        for p in sys.path:
            p = os.path.realpath(p)
            paths.append(p)

        return {"hola":"Python Print","paths":paths}
