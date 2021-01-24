import sys
import os

class DebugService:

    def get_index(self):
        paths = []
        for p in sys.path:
            p = os.path.realpath(p)
            paths.append(p)

        return {"DebugService":"Python Print","paths":paths}
