import sys
import os

class HomeService:

    def get_index(self):
        paths = []
        for p in sys.path:
            p = os.path.realpath(p)
            paths.append(p)

        return {"HomeService":"Python Print","paths":paths}
