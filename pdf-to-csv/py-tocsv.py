# pip install PyPDF2
from files import *
from pprint import pprint
from PyPDF2 import PdfFileReader
import sys

# CÓDIGO RESUMEN UDS LONGITUD ANCHURA ALTURA CANTIDAD PRECIO IMPORTE
#

pages_content = []


def visitor_body(text, cm, text_matrix, fontDict, fontSize):
    dic = {
        "text": text,
        "pos": [text_matrix[3], text_matrix[4], text_matrix[5], ],
    }
    if text_matrix[4] != 0.0 and text_matrix[5] != 0.0:
        pages_content.append(dic)


def get_text():
    reader = PdfFileReader(file_merged)
    texts = []
    for i_page in range(reader.getNumPages()):
        page = reader.pages[i_page]
        texts.append(page.extract_text(visitor_text=visitor_body))
        pprint(pages_content)
        sys.exit()

    pprint(pages_content)


get_text()
