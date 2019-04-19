import sys; sys.path.append("..")
from pprint import pprint

class ComponentCrud():
    
    def __init__(self,objdb=None):
        self.lstends = []
        self.lstjoins = []
        self.lstresults = []
        self.lstinsertfvs = []
        self.lstupdatefvs = []
        self.lstpksfvs = []
        self.lstgetfields = []
        self.lstorderbys = []
        self.lstnumerics = []
        self.lstands = []
        self.ojbdb = objdb
        
        
    def __get_orderby(self):
        strorderby = ""
        if self.lstorderbys:
            lstsql = []
            strorderby = " ORDER BY "
            for dic in self.lstorderbys:
                for f in dic.keys():
                    #field AscDesc
                    lstsql.append("{} {}".format(f,dic[f]))
            
            strorderby = strorderby+(", ".join(lstsql))
        
        return strorderby
    
    def __get_imploded(self,lststrings):
        return " "+"\n".join(lststrings)
    
    def __get_joins(self):
        strreturn = self._get_imploded(self.lstjoins)
        return strreturn
    
    def __get_end(self):
        strreturn = self._get_imploded(self.lstends)
        return strreturn
        
   def __is_numeric(self,strfieldname):
        return strfieldname in self.lstnumerics
   
    def add_orderby(self,strfield,strascdesc=""):
        if strfield:
            self.lstorderbys.append({strfield:strascdesc})
    
    def test(self):
        return self.__get_orderby()
    
#class ComponentCrud

if __name__ == "__main__":
    o = ComponentCrud()
    pprint(o.test())
