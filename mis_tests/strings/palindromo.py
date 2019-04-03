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

    def __is_mirror(self,sText):
        iLen = len(sText)
        # cociente i resto
        cnr = divmod(iLen,2)

        pprint(cnr)
        pprint(cnr[0])
        pprint(cnr[1])        
        if cnr[1]==0 :
            return False

        iHalf = (iLen / 2)

    def check(self):
        arResult = []
        pprint(self.arText)
        for sText in self.arText:
            print(sText)
            self.__is_mirror(sText)



    def add_text(self,sValue):
        self.arText.append(sValue)


if __name__ == "__main__":
    o = Palindromo()
    o.add_text("Logra Casillas allí sacar gol")
    o.check()
