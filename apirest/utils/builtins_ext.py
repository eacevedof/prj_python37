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
def obj_dump(obj):
    strobj = ""
    for attr in dir(obj):
        strobj += "obj.%s = %r\n" % (attr, getattr(obj, attr))
    return strobj

def s(strtext):
    if isinstance(strtext, str):
        temp = "\033[94m{}\033[00m" .format(strtext)
        print(temp)

def pr(mxvar,strtitle=""):
    # https://github.com/shiena/ansicolor/blob/master/README.md
    if strtitle:
        # print('\x1b[6;30;42m' + 'Success!' + '\x1b[0m')
        temp = "\x1b[6;30;43m{}\033[00m" .format(strtitle)
        print(temp)

    if isinstance(mxvar, str):
        print(mxvar)
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
        temp = "\x1b[6;30;42m{}\033[00m" .format(strtitle)
        print(temp)

    if isinstance(mxvar, str):
        print(mxvar)
        return
    
    mxvar = obj_dump(mxvar)
    print(mxvar)

    # print(repr(mxvar))
    # pprint(mxvar)
    #print("\n")    

builtins.s = s
builtins.bug = bug
builtins.pr = pr

