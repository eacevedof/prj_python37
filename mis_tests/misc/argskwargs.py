# argskwargs
from pprint import pprint

def fn_args(*args):
    print("args:")
    pprint(args)

def fn_kwargs(**kwargs):
    print("kwargs:")
    pprint(kwargs)


def fn_argskwargs(*args,**kwargs):
    print("fn_argskwargs.args:")
    pprint(args)
    print("fn_argskwargs.kwargs:")
    pprint(kwargs)    

def pr():
    print("="*50)

if __name__== "__main__":
    fn_args(1,2.3,"a",{},[])
    # fn_kwargs({"a1":1,"a2":2.3,"a3":"a","a4":{},"a5":[]}) #TypeError: fn_kwargs() takes 0 positional arguments but 1 was given
    fn_kwargs(a1=1,a2=2.3,a3="a",a4={},a5=[])
    # fn_args(a1=1,a2=2.3,a3="a",a4={},a5=[]) # got an unexpected keyword argument 'a1'
    fn_argskwargs(1,2.3,"a",{},[])
    pr()
    fn_argskwargs(a1=1,a2=2.3,a3="a",a4={},a5=[])
    pr()
    objdic = {"a1":1,"a2":2.3,"a3":"a","a4":{},"a5":[]}
    fn_argskwargs(objdic) # entra por args
    pr()
    # fn_argskwargs(a1=1,a2=2.3,a3="a",a4={},a5=[],1,2.3,"a",{},[]) #SyntaxError: positional argument follows keyword argument
    fn_argskwargs(1,2.3,"a",{},[],a1=1,a2=2.3,a3="a",a4={},a5=[])
