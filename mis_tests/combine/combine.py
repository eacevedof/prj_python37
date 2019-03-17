# noinspection PyInterpreter
import os
import sys
from pprint import pprint
import test.d as x

import combnorep

class Combine:
    #arFinal = []
    #arLetters = ["a", "b", "c", "d"]
    #iLen = 0
    #iLoop = 0

    def __init__(self,arLetters=[]):
        self._arFinal = []
        self._arLetters = arLetters
        self._iLen = len(self._arLetters)
        self._iLoop = 0


    def _addto_final(self, arString):
        for sString in arString:
            if not sString in self._arFinal:
                self._arFinal.append(sString)

    def _get_crossjoin(self, arStrings, arChar):
        """concatena un array de strings con cun array de caracteres"""
        arConcated = []
        for sStr in arStrings:
            arSplit= list(sStr)
            for cChar in arChar:
                if not cChar in arSplit:
                    # print("str: {},char: {}".format(sStr,cChar))
                    # print("-->add")
                    sConcat = sStr + cChar
                    sConcat = self._get_string_asc(sConcat)
                    if not sConcat in arConcated:
                        arConcated.append(sConcat)

        #print(arConcated)
        # sys.exit()
        return arConcated


    def _get_recursive(self, arLoop, arChars):
        if self._iLoop == self._iLen:
            arConc = self._get_crossjoin(arLoop, arChars)
            self._addto_final(arConc)
            return
        else:
            self._iLoop += 1
            arConc = self._get_crossjoin(arLoop, arChars)
            self._addto_final(arConc)
            self._get_recursive(arConc, arChars)

    def _get_string_asc(self, sString):
        # arChars = sString.split("")
        arChars = list(sString)
        #print(arChars)
        arChars.sort()
        sString = "".join(arChars)
        return sString

    def _get_total(self):
        iR = 0
        for i in range(1,self._iLen+1):
            oC = combnorep.C(self._iLen,i)
            iR += oC.get_combnorep()

        return iR


    def run(self):
        self._get_recursive([""], self._arLetters)
        # print(self._arFinal)
        x.bug(self._arFinal)
        #print("\n=============\n")
        print(len(self._arFinal))
        print("must be: {}".format(self._get_total()))


oC = Combine(["a","b","c","d","e"])
oC.run()




