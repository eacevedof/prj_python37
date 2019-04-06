"""
Detecta palindromos:

http://www.estandarte.com/noticias/idioma-espanol/qu-es-un-palndromo-ejemplos_1723.html
Ejemplos:

A Bali su flan anal fusilaba
No subas, abusón
Oí lo de mamá: me dolió
Sometamos o matemos
Yo dono rosas, oro no doy
Isaac no ronca así
Lavan esa base naval
No traces en ese cartón
¿Será lodo o dólares?
Logra Casillas allí sacar gol
"""
import io
from pprint import pprint 

class Palindromo():

    arText = []

    def __init__(self,sText=""):
        if self.arText:
            self.arText.append(sText)

    def __get_cleaned(self,sText):
        """
        Obtiene un texto y limpia los caracteres mudos dejando solo letras sin espacios
        """
        arVocals = [
            ("á","a"),("é","e"),("í","i"),("ó","o"),("ú","u")
        ]
        arWhite = [" ",",","?","¡","¿","`","+","&","%","$","@","|","!","#","*","{","}"
                    ,";",".","-",":",""]
        # sText = sText.split()
        for c in arWhite:
            sText = sText.replace(c,"")
        
        for dic in arVocals:
            sText = sText.replace(dic[0],dic[1])

        return sText

    def __is_mirror(self,sText):
        """
        Comprueba si las dos mitades del texto, que se limpiará, son un reflejo 
        """
        sText = self.__get_cleaned(sText)
        # print("some text:",sText)
        sText = sText.lower()
        iLen = len(sText)
        # cociente i resto
        cnr = divmod(iLen,2)

        # pprint(cnr)
        # pprint(iLen)
        # pprint(cnr[0])
        # pprint(cnr[1])  
        if cnr[1]==0 :
            return (False,iLen)

        iMiddle = cnr[0]
        sSideL = sText[0:iMiddle]
        sSideR = (sText[iMiddle+1:])[::-1]
        # pprint(sSideL)
        # pprint(sSideR)
        return ((sSideL == sSideR),iLen)


    def check(self):
        """
        """
        arResult = []
        # pprint(self.arText)
        for sText in self.arText:
            isPalLen = self.__is_mirror(sText)
            arResult.append((sText,isPalLen[0],isPalLen[1]))
        pprint(arResult)


    def add_text(self,sValue):
        self.arText.append(sValue)



if __name__ == "__main__":
    o = Palindromo()
    o.add_text("Logra Casillas allí sacar gol")
    o.add_text("A Bali su flan anal fusilaba")
    o.add_text("No subas, abusón")
    o.add_text("Yo dono rosas, oro no doy")
    o.check()
