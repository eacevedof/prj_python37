print("modb1 imported")

def func_b1():
    print("func_b1")

def func_b2():
    print("func_b2")

def func_b3():
    print("func_b3")

class ModB1:

    def foo(self, x):
        print "executing foo(%s, %s)" % (self, x)

    @classmethod
    def class_foo(cls, x):
        print "executing class_foo(%s, %s)" % (cls, x)

    @staticmethod
    def static_foo(x):
        print "executing static_foo(%s)" % x
