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
        
        
    def __get_orderby(self):
        strorderby = ""
        if self.lstorderby:
            lstsql = []
            strorderby = " ORDER BY "
            for dic in self.lstorderby:
                for f in dic.keys():
                    #field AscDesc
                    lstsql.append("{} {}".format(f,dic[f]))
            
            strorderby = strorderby+(", ".join(lstsql))
        
        return strorderby
    
    
    def add_orderby(self,strfield,strascdesc=""):
        if strfield:
            self.lstorderby.append({strfield:strascdesc})
    
    def test(self):
        return self.__get_orderby()
    
#class ComponentCrud

if __name__ == "__main__":
    o = ComponentCrud()
    pprint(o.test())
