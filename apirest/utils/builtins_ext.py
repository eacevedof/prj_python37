import builtins

def pr(mxvar,strtitle=""):
    from pprint import pprint 
    color = "\x1b[6;30;42m"
    background = "\x1b[0m"

    if strtitle:
        # print('\x1b[6;30;42m' + 'Success!' + '\x1b[0m')
        print("")
        print(color+"==["+strtitle+"]:=="+background)

    if isinstance(mxvar, str):
        print(mxvar)
        return
    pprint(mxvar)
    #print("\n")

builtins.bug = pr