import sys

def fibonacci(max):
    a, b = 0, 1

    print("a:"+str(a))
    print("b:"+str(b))
    while a < max:
        print("whie.a:"+str(b))
        yield a  # acumula en memoria
        # a, b = b, a+b
        a = b
        b = a + b
    

if __name__ == '__main__':
    i = 10
    oIter = fibonacci(i)
    print(oIter)
    dir(oIter)
    oIter2 = [i for i in oIter]
    print(oIter2)