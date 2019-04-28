import builtins
from pprint import pprint 

def bug(mxvar,strtitle=""):
    # https://github.com/shiena/ansicolor/blob/master/README.md
    #  \x1b[1;33m \x1b[0;33m
    color = "\x1b[1;33m"

    background = "\x1b[0;33m"
    reset = "\x1b[0m"

    if strtitle:
        # print('\x1b[6;30;42m' + 'Success!' + '\x1b[0m')
        print("")
        print(color+"==["+strtitle+"]:=="+background+reset)

    if isinstance(mxvar, str):
        print(mxvar)
        return
    pprint(mxvar)
    #print("\n")

def p(strtext):
    if isinstance(strtext, str):
        temp = "\033[94m{}\033[00m" .format(strtext)
        print(temp)

def pr(mxvar,strtitle=""):
    # https://github.com/shiena/ansicolor/blob/master/README.md
    color = "\x1b[6;30;42m"
    background = "\x1b[0m" # yellow
    reset = "\x1b[0m"
    if strtitle:
        # print('\x1b[6;30;42m' + 'Success!' + '\x1b[0m')
        print("")
        print(color+"==["+strtitle+"]:=="+background+reset)

    if isinstance(mxvar, str):
        print(mxvar)
        return
    pprint(mxvar)
    #print("\n")

builtins.bug = bug
builtins.pr = pr
builtins.p = p
