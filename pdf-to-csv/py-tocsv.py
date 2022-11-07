# pip install PyPDF2
from files import *
from pprint import pprint
from PyPDF2 import PdfFileReader
import sys


# CÓDIGO RESUMEN UDS LONGITUD ANCHURA ALTURA CANTIDAD PRECIO IMPORTE
#

def chk(txt, ar_map, ar_text, font, d):
    dic = {
        "txt": txt,
        "ar_map": ar_map,
        "ar_text": ar_text,
        #"font": font,
        #"d": d,
    }
    pprint(dic)
    #sys.exit()
    return "hola"


parts = []
def visitor_body(text, cm, tm, fontDict, fontSize):
    y = tm[5]
    if y > 50 and y < 720:
        parts.append(text)

def get_text():
    reader = PdfFileReader(file_merged)
    texts = []
    for i_page in range(reader.getNumPages()):
        page = reader.pages[i_page]
        texts.append(page.extract_text(visitor_text=visitor_body))
        print(texts[0])
        sys.exit()


    print(texts[0])

get_text()
