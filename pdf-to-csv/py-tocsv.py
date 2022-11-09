# pip install PyPDF2
from files import *
from pprint import pprint
from PyPDF2 import PdfFileReader
import sys

"""
90.72 - 127	166.4 - 407.23	411 - 429.40	436.12 - 483.84	487.87 - 535	538.27 - 575.23	590.01 - 636-38	666.62 - 700.22	735.84 - 776.16

"""
columns = {
    "codigo": {"x1":90.72, "x2":127},
    "resumen": {"x1":166.4, "x2":407.23},
    "uds": {"x1":411, "x2":429.4},
    "longitud": {"x1":436.12, "x2":483.84},
    "anchura": {"x1":487.87, "x2":535},
    "altura": {"x1":538.27, "x2":575.23},
    "cantidad": {"x1":590.01, "x2":636.38},
    "precio": {"x1":666.62, "x2":700.22},
    "importe": {"x1":735.84, "x2":776.16},
}

page_sections = {
    "titulo": {
        "codigo": "PRESUPUESTO Y MEDICIONES",
    },
    "table_headers": {
        "codigo": "CÓDIGO RESUMEN UDS LONGITUD ANCHURA ALTURA CANTIDAD PRECIO IMPORTE"
    },
    "section": {
        "codigo": "01",
        "resumen":"01 VIVIENDA MODULAR"
    },
    "sub_section": {
        "codigo": "01.01",
        "resumen": "ESTRUCTURA METÁLICA",
    },
    "item": {
        "codigo": "01.01.01",
        "resumen": "kg VIGAS METÁLICAS DE MÓDULOS 1, 2, 3, 4, 5, 6, 7 y 8",
    },
    "item_description": {
        [
            {"codigo":"","resumen":"a"},
            {"codigo":"","resumen":"b"},
            {"codigo":"","resumen":"c"},
            {"codigo":"","resumen":""},
            {"codigo":"","resumen":"ESTRUCTURA SUELO"},
        ]
    },
    "cantidades": [
        {
            "codigo": "",
            "resumen": "TITULO 1"
        },
        {
            "codigo": "",
            "resumen": "TITULO 2"
        },
        {
            "codigo": "",
            "resumen": "TITULO 3"
        },
        {
            "codigo": "",
            "resumen": "concepto x",
            "uds": "2",
            "longitud": "13,64",
            "anchura": "22.40",
        },
    ]
}

page_parts = []


def visitor_body(text, cm, text_matrix, fontDict, fontSize):
    #pprint(fontSize);sys.exit()
    dic = {
        "text": text,
        "pos": {
            "x": text_matrix[4],
            "y": text_matrix[5],
        }
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

def get_merged_line_with_same_y(page_lines, y):
    lines = filter(lambda line: line.get("pos").get("y")==y, page_lines)
    #lines = list(lines)
    texts = list(map(lambda line: line.get("text", ""), lines))
    texts = "".join(texts)
    return texts

def get_csv():
    global all_pages
    for page in all_pages:
        page_lines = page.get("content", [])
        lines = []
        processed = []
        for i,dic_line in enumerate(page_lines):
            pprint(dic_line)
            y = dic_line.get("pos").get("y",0)
            if (y in processed): continue
            processed.append(y)
            text_line = get_merged_line_with_same_y(page_lines, y)
            lines.append(text_line)
        pprint(lines)
        sys.exit()

        pprint(lines)

get_csv()
