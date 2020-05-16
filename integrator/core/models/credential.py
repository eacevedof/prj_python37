from core.core import Core as core
from core.models.base import Base

class Credential(Base):

    def __init__(self, pathfile):
        pathcredential = core.get_path_credential(pathfile)
        super().__init__(pathcredential, id)

