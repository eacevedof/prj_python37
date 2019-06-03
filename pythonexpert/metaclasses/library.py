# library.py
class Base:
    def foo(self):
        return self.bar

old_bc = __build_class__

def my_bc(*a,**kw):
    print("my buildclass->",a,kw)
    return old_bc(*a,**kw)

import builtins
builtins.__build_class__ = my_bc