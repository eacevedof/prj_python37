from core.core import Core as core
from core.models.base import Base

class Context(Base):

    def __init__(self, pathfile, id):
        pathcontext = core.get_path_context(pathfile)
        super().__init__(pathcontext, id)

