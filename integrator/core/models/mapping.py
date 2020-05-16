from core.core import Core as core
from core.models.base import Base


class Mapping(Base):

    def __init__(self, pathfile, id):
        pathmapping = core.get_path_mapping(pathfile)
        super().__init__(pathmapping, id)

