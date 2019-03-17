import uuid

class Client:
    def __init__(self,name,company,email,position,uid=None):
        self.name = name
        self.company = company
        self.email = email
        self.position = position
        self.uid = uid or uuid.uuid4()

    # este método pasa nuestro objeto a una estructura clave valor que será
    # necesaria para poder escribirla en disco
    # def to_dictionary(self):
    def to_dict(self):
        return vars(self)

    @staticmethod
    # las columnas 
    def schema():
        return ["name","company","email","position","uid"]

    