# builtins_ext.py 1.0.0
import builtins
from pprint import pprint 

"""
http://ozzmaker.com/add-colour-to-text-in-python/
The above ANSI escape code will set the text colour to bright green. The format is;
\033[  Escape code, this is always the same
1 = Style, 1 for normal.
32 = Text colour, 32 for bright green.
40m = Background colour, 40 is for black.
"""
pythontypes = {
    "boolean": ("bool"),
    "numeric": ("int","float"),
    "string":  ("str"),
    "structure": ("array","dict","list","tuple","set"), # file
    "function": ("function"),
    "primitives": ("bool","int","float","str")
    # import types
    # types.GeneratorType
}

class CheckType():

    @staticmethod
    def is_bool(mxvar):
        return isinstance(mxvar, bool)

    @staticmethod
    def is_float(mxvar):
        return isinstance(mxvar, float)

    @staticmethod
    def is_int(mxvar):
        return isinstance(mxvar, int)

    @staticmethod
    def is_float(mxvar):
        return isinstance(mxvar, float)

    @staticmethod
    def is_string(mxvar):
        return isinstance(mxvar, str)

    @staticmethod
    def is_list(mxvar):
        return isinstance(mxvar, list)
    @staticmethod
    def is_dict(mxvar):
        return isinstance(mxvar, dict)

    @staticmethod
    def is_tuple(mxvar):
        return isinstance(mxvar, tuple)

    @staticmethod
    def has_dict(mxvar):
        return hasattr(mxvar, '__dict__')

    @staticmethod
    def is_primitive(mxvar):
        return (CheckType.is_bool(mxvar) or CheckType.is_int(mxvar) 
            or CheckType.is_float(mxvar) or CheckType.is_string(mxvar)
        )

    @staticmethod
    def is_structure(mxvar):
        return (CheckType.is_list(mxvar) or CheckType.is_dict(mxvar) 
            or CheckType.is_tuple(mxvar)
        )

def is_primitive(mxvar):
    return CheckType.is_primitive(mxvar)

def is_structure(mxvar):    
    return CheckType.is_structure(mxvar)

def has_dict(mxvar):
    return CheckType.has_dict(mxvar)

def get_strcolored(strval,colcode):
    strreturn = "\033[{}m{}\033[00m".format(colcode,strval)
    return strreturn

def get_dictcolored(dictvar):
    lstret = []
    for k,v in dictvar.__dict__.items():
        strkey = " .%s" % k
        strval = "%s" % v
        lstret.append(get_strkvcolored(strkey, strval))

    return "\n".join(lstret)

def printcol(primval,colcode="5;30;47"):
    if is_primitive(primval):
        primval = str(primval)
    strval = get_strcolored(primval,colcode)
    print(strval)

def get_strkvcolored(strkey,strval):
    strreturn = ""
    # strkey = "\033[0;95m{}\033[00m" .format(strkey)
    strkey = get_strcolored(strkey,"0;95")
    strval = get_strcolored(strval,"1;96")
    strreturn = strkey + " = "+ strval
    return strreturn

def get_strobject(obj):
    # strobj = ["obj"]
    strobj = []
    for strattr in dir(obj):
        strkey = " .%s" % (strattr)
        strval = "%s" % getattr(obj, strattr)
        strobj.append(get_strkvcolored(strkey, strval))

    return "\n".join(strobj)

def print_format_table():
    """
    https://stackoverflow.com/questions/287871/how-to-print-colored-text-in-terminal-in-python
    prints table of formatted text format options
    """
    for style in range(8):
        for fg in range(30,38):
            s1 = ''
            for bg in range(40,48):
                format = ';'.join([str(style), str(fg), str(bg)])
                s1 += '\x1b[%sm %s \x1b[0m' % (format, format)
            print(s1)
        print('\n')

# print_format_table()

def s(strtext):
    if is_primitive(strtext):
        strtext = str(strtext)
        printcol(strtext,"94")

def sc(strtext,colcode="7;34;47"):
    if is_primitive(strtext):
        strtext = str(strtext)
        printcol(strtext,colcode)

def pr(mxvar, strtitle="", isjustdic=1):
    # https://github.com/shiena/ansicolor/blob/master/README.md
    if strtitle:
        printcol(strtitle,"6;30;43")

    if has_dict(mxvar):
        print(get_dictcolored(mxvar))

    if is_primitive(mxvar):
        printcol(mxvar)
        return
    
    if is_structure(mxvar):
        pprint(mxvar)
        return
    
    if isjustdic:
        return

    printcol("type:"+str(type(mxvar)),"6;30;43")
    # ya lo devuelve con colores
    mxvar = get_strobject(mxvar)
    print(mxvar)


def bug(mxvar,strtitle=""):
    # https://github.com/shiena/ansicolor/blob/master/README.md
    if strtitle:
        printcol(strtitle,"6;30;42")

    if has_dict(mxvar):
        print(get_dictcolored(mxvar))

    if is_primitive(mxvar):
        printcol(mxvar)
        return
    
    if is_structure(mxvar):
        pprint(mxvar)
        return

    # ya lo devuelve con colores
    mxvar = get_strobject(mxvar)
    print(mxvar)


builtins.s = s
builtins.sc = sc
builtins.pr = pr
builtins.bug = bug

