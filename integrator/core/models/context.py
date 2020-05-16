from core.models.base import Base

def Context(Base):

    def __init__(self, pathfile, id):
        super(Base, self).__init__(pathfile, id)

