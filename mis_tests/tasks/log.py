from inspect import getmembers
from pprint import pprint

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
    if hasattr(mxVar, "__dict__"):
        s = "{}: {}".format(mxVar, vars(mxVar))
    else:
        s = repr(mxVar)
    return s


def var_dump(var, prefix=''):
    """
    You know you're a php developer when the first thing you ask for
    when learning a new language is 'Where's var_dump?????'
    """
    my_type = '[' + var.__class__.__name__ + '(' + str(len(var)) + ')]:'
    print(prefix, my_type, sep='')
    prefix += '    '
    for i in var:
        if type(i) in (list, tuple, dict, set):
            var_dump(i, prefix)
        else:
            if isinstance(var, dict):
                print(prefix, i, ': (', var[i].__class__.__name__, ') ', var[i], sep='')
            else:
                print(prefix, '(', i.__class__.__name__, ') ', i, sep='')
                
if __name__ == "__main__":
    # oDic = {"a":"aaaa","b":"bbbb"}
    #s = var_export(oDic)
    #print(s)
    o = Test()
    var_dump(o)
    # pprint(getmembers(o))
    # print(repr(o))
    # print(vars(o))
    # pprint(vars(o))
    # print(o)
    # pprint(globals())
    # pprint(locals())