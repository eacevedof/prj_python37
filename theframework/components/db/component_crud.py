import sys; sys.path.append("..")
from pprint import pprint

class ComponentCrud():
    
    def __init__(self,objdb=None):
        self.lstend = []
        self.lstresult = []
        self.lstinsertfv = []
        self.lstupdatefv = []
        self.lstpksfv = []
        self.lstgetfields = []
        self.lstorderby = []
        self.lstnumeric = []
        self.lstands = []
        self.ojbdb = objdb
    
    
#class ComponentCrud

if __name__ == "__main__":
    o = ComponentCrud()
    pprint(o.is_connected())
