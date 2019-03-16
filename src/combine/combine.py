# noinspection PyInterpreter
import os
import sys
from pprint import pprint


class Combine:
    arFinal = []
    arLetters = ["a", "b", "c", "d"]
    iLen = 0
    iLoop = 0

    def __init__(self):
        self.iLen = len(self.arLetters)
        self._init_final_array()

    def _addto_final(self, arString):
        for sString in arString:
            if not sString in self.arFinal:
                self.arFinal.append(sString)

    def testme(self, s, ar):
        print(s)
        print(ar)
        arN = []
        for i in range(1, 4):
            arN.append({i: []})
        print(arN)
        print(arN[0])

    def _get_ar_concat(self, arStr, arChar):
        """concatena un array de strings con cun array de caracteres"""
        arConcated = []
        for sStr in arStr:
            for cChar in arChar:
                sConcat = sStr + cChar
                sConcat = self._string_asc(sConcat)
                if not sConcat in arConcated:
                    arConcated.append(sConcat)

        print(arConcated)
        # sys.exit()
        return arConcated

    def _init_final_array(self):
        self.arFinal = []
        # for i in range(1,self.iLen + 1):
        # self.arFinal.append({i:[]})

    def _get_str_char(self, s, arChars):
        arReturn = []
        for i, c in enumerate(arChars):
            sTmp = s + c
            arReturn.append(sTmp)
        return arReturn

    def _get_combined(self, iLen):
        arCombined = []
        for cL in self.arLetters:
            if iLen == 1:
                cL = ""
            arTmp = self._get_str_char(cL, self.arLetters)
            arCombined.append({(iLen, cL): arTmp})

        return arCombined

    def _get_recursive(self, arLoop, arChars):
        if self.iLoop == self.iLen:
            arConc = self._get_ar_concat(arLoop, arChars)
            # self.arFinal.append(arConc)
            self._addto_final(arConc)
            return
        else:
            self.iLoop += 1
            arConc = self._get_ar_concat(arLoop, arChars)
            # self.arFinal.append(arConc)
            self._addto_final(arConc)
            self._get_recursive(arConc, arChars)

    def _string_asc(self, sString):
        # arChars = sString.split("")
        arChars = list(sString)
        print(arChars)
        arChars.sort()
        sString = "".join(arChars)
        return sString

    def _array_unique(self, arCombined):
        list(set(arCombined))

    def testrec(self):
        self._get_recursive([""], self.arLetters)
        print(self.arFinal)
        print("\n=============\n")
        print(len(self.arFinal))


oC = Combine()
# oC._get_str_char("xxx",["a","b","c"])
# oC.testme("xxx",["a","b","c"])
# oC.testme("somestring",[8.9,10,11])
# oC._go()
oC.testrec()




