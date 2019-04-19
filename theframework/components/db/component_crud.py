import sys; sys.path.append("..")
from pprint import pprint

class ComponentCrud():
    
    def __init__(self,objdb=None):
        self.strsqlcomment = ""
        self.strsql = ""
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
    
    def add_orderby(self,strfield,strascdesc=""):
        if strfield:
            self.lstorderbys.append({strfield:strascdesc})    
    
    def autoinsert(strtable=None,lstfieldvals=[]):
        # limpio la consulta 
        self.strsql = "-- autoinsert"
        
        strsqlcomment = ""
        if self.strsqlcomment:
            strsqlcomment = "/*{}*/".format(self.strsqlcomment)
        
        if not strtable:
            strtable = self.strtable
        
        if strtable:
            if not lstfieldvals:
                lstfieldvals = self.lstinsertfvs
            
            if lstfieldvals:
                
                strsql = strsqlcomment + "INSERT INTO "
                strsql += strtable + " ( "

                lstfileds = [dic.keys() for dic in lstfieldvals]

                lstfileds = dic.keys() for dic in lstfieldvals
                arfields = array_keys(lstfieldvals)
                strsql += implode(",",arfields)

                arvalues = array_values(lstfieldvals)
                # los paso a entrecomillado
                foreach (arvalues as i=>svalue)
                
                    if svalue===null)
                        araux[] = "null"
                    else:
                        araux[] = "'svalue'"
                

                strsql += ") values ("
                strsql += implode(",",araux)
                strsql += ")"
                
                self.strsql = strsql
                # si hay bd intenta ejecutar la consulta
                self.query("w")
            # si se han proporcionado correctamente los datos campo=>valor
        # se ha proporcionado una tabla
    # autoinsert    
    
    
    def get_result(self):
        return self.lstresults

    def is_distinct(self,ison=True): 
        self.isdistinct = ison

    def add_orderby(sfieldname,sorder="asc"): 
        self.lstorderby[sfieldname]=sorder

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


    def set_dbobj(odb=None): 
        self.odb=odb

    def test(self):
        return self.__get_orderby()
    
#class ComponentCrud

if __name__ == "__main__":
    o = ComponentCrud()
    pprint(o.test())
