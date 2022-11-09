# pip install PyPDF2
from files import *
from pprint import pprint
from PyPDF2 import PdfFileReader
import sys

# CÓDIGO RESUMEN UDS LONGITUD ANCHURA ALTURA CANTIDAD PRECIO IMPORTE
#

page_parts = []


def visitor_body(text, cm, text_matrix, fontDict, fontSize):
    #pprint(fontSize);sys.exit()
    dic = {
        "text": text,
        "pos": [text_matrix[4], text_matrix[5]],
    }
    if text_matrix[4] != 0.0 and text_matrix[5] != 0.0:
        page_parts.append(dic)


def get_text():
    global page_parts
    all_pages = []
    reader = PdfFileReader(file_merged)
    for i_page in range(reader.getNumPages()):
        page_parts = []
        page = reader.pages[i_page]
        page.extract_text(visitor_text=visitor_body)

        all_pages.append({
            "page": i_page,
            "content": page_parts.copy()
        })
        if i_page == 7:
            return all_pages

    return all_pages

all_pages = get_text()
pprint(all_pages[1])
