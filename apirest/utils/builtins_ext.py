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
    "structure": ("dict","list","tuple"),
    "function": ("function"),
    "primitives": ("bool","int","float","str")
    # import types
    # types.GeneratorType
}

def obj_dump(obj):
    strobj = []
    for strattr in dir(obj):
        strkey = "obj.%s" % (strattr)
        strval = "%s" % getattr(obj, strattr)
        strobj.append(obj_strkval(strkey, strval))

    return "\n".join(strobj)

def obj_strkval(strkey,strval):
    strreturn = ""
    strkey = "\033[0;95m{}\033[00m" .format(strkey)
    strval = "\033[1;96m{}\033[00m" .format(strval)
    strreturn = strkey + " = "+ strval

    return strreturn


def s(strtext):
    if isinstance(strtext, str):
        temp = "\033[94m{}\033[00m" .format(strtext)
        print(temp)

def pr(mxvar,strtitle=""):
    # https://github.com/shiena/ansicolor/blob/master/README.md
    if strtitle:
        # print('\x1b[6;30;42m' + 'Success!' + '\x1b[0m')
        temp = "\x1b[6;30;43m{}: \033[00m" .format(strtitle)
        print(temp)

    if type(mxvar) in pythontypes["primitives"]:
        print(str(mxvar))
        return
    
    if type(mxvar) in pythontypes["structure"]:
        pprint(mxvar)
        return
    
    mxvar = obj_dump(mxvar)
    print(mxvar)
    # is an object
    # print(repr(mxvar))
    #pprint(mxvar)
    #print("\n")

def bug(mxvar,strtitle=""):
    # https://github.com/shiena/ansicolor/blob/master/README.md
    if strtitle:
        temp = "\x1b[6;30;42m{}: \033[00m" .format(strtitle)
        print(temp)

    if type(mxvar) in pythontypes["primitives"]:
        print(str(mxvar))
        return
    
    if type(mxvar) in pythontypes["structure"]:
        pprint(mxvar)
        return    
    mxvar = obj_dump(mxvar)
    print(mxvar)

    # print(repr(mxvar))
    # pprint(mxvar)
    #print("\n")    

builtins.s = s
builtins.bug = bug
builtins.pr = pr

