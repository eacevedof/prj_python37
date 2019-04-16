

class Test():
    _prop_string = "string"
    _prop_int = 1
    _prop_double = 78.653
    _list = []
    _dict = {}
    
    def __init__(self):
        pass
    
    
def dump(obj):
    '''return a printable representation of an object for debugging'''
    newobj=obj
    if '__dict__' in dir(obj):
        newobj=obj.__dict__
        if ' object at ' in str(obj) and not newobj.has_key('__type__'):
            newobj['__type__']=str(obj)
    
    for attr in newobj:
        newobj[attr]=dump(newobj[attr])
    return newobj    

    

def var_export(mxVar):
    from inspect import getmembers
    from pprint import pprint
    pprint(getmembers(mxVar))



                
if __name__ == "__main__":
    o = Test()
    # var_export(o)
    s = "esto es un texto"
    # print(s.__len__())
    # var_export(s.__len__)