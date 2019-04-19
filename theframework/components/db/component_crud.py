import sys; sys.path.append("..")
from pprint import pprint

class ComponentCrud():
    
    def __init__(self,objdb=None):
        self.strtable = ""
        self.strsqlcomment = ""
        self.strsql = ""
        self.lstends = []
        self.lstjoins = []
        self.lstresults = []
        self.dicinsertfvs = {}
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
    
    def autoinsert(self,strtable=None, dicfieldvals=[]):
        # limpio la consulta 
        self.strsql = "-- autoinsert"
        
        strsqlcomment = ""
        if self.strsqlcomment:
            strsqlcomment = "/*{}*/".format(self.strsqlcomment)
        
        if not strtable:
            strtable = self.strtable
        
        # pprint(self.dicinsertfvs)
        if strtable:
            if not dicfieldvals:
                dicfieldvals = self.dicinsertfvs
            
            if dicfieldvals:
                lstinsert = []
                lstinsert.append(strsqlcomment + "INSERT INTO")
                lstinsert.append(strtable)
                lstinsert.append("( "+",".join(dicfieldvals.keys())+")")
                lstinsert.append("VALUES")
                lstinsert.append("(")
                
                lstvals = []
                for f in dicfieldvals.keys():
                    value = dicfieldvals[f]
                    if value == None:
                        lstvals.append("NULL")
                    else:
                        lstvals.append("'{}'".format(value))
                
                lstinsert.append(",".join(lstvals))
                lstinsert.append(")")
                self.strsql = " ".join(lstinsert)
                pprint(self.strsql)
        
        
    def get_sql(self):
        return self.strsql
    
    def add_insert(self,strfieldname,mxfieldvalue):
        if strfieldname:
            self.dicinsertfvs[strfieldname] = mxfieldvalue
    
    def get_result(self):
        return self.lstresults

    def is_distinct(self,ison=True): 
        self.isdistinct = ison

    def add_numeric(sfieldname): 
        self.lstnumeric.append(sfieldname)

    def add_and(sand): 
        self.lstands.append(sand)

    def add_and1(sfieldname,svalue,soper="="): 
        self.lstands.append("sfieldname soper svalue")

    def add_join(sjoin,skey=None): 
        if skey: 
            self.lstjoins[skey] = sjoin
        else:
            self.lstjoins.append(sjoin)

    def add_end(send,skey=None): 
        if skey: 
            self.lstend[skey]=send
        else:
            self.lstend.append(send)

    def add_error(smessage): 
        self.iserror = True
        self.lsterrors.append(smessage)

    def is_error(self): 
        return self.iserror

    def get_errors(injson=0): 
        if injson:  
                return json_encode(self.lsterrors)
        return self.lsterrors

    def get_error(i=0): 
        self.lsterrors[i] = None if self.lsterrors[i] else None


    def set_table(self,strtable):
        self.strtable = strtable

    def set_dbobj(odb=None): 
        self.odb=odb

    def test(self):
        return self.__get_orderby()
    
#class ComponentCrud

if __name__ == "__main__":
    o = ComponentCrud()
    pprint(o.test())
