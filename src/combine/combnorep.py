import os
import sys
from pprint import pprint

class C:

    def __init__(self,n,k):
        self._n = n
        self._k = k
        if k>n:
            print("k:{}  >  n:{}".format(k,n))

    def _get_factorial(self,n):
        if n > 1:
            r = n * self._get_factorial(n-1)
            return r
        else:
            return 1

    def _calculate(self):
        # (m n) = C(m,n) = m! /((m-n)!n!)
        iResult = 0


        return iResult

    def test(self):
        r1 = self._get_factorial(self._n)
        r2 = self._get_factorial(self._k)
        print("r1: {}, r2:{}".format(r1,r2))


o = C(5,3)
o.test()


