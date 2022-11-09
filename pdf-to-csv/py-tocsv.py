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
        # if x=90.72 && text=="PRESUPUESTO Y MEDICIONES"
        "codigo": "PRESUPUESTO Y MEDICIONES",
    },
    "table_header": {
        # if x=90.72 && text=="CÓDIGO RESUMEN UDS LONGITUD ANCHURA ALTURA CANTIDAD PRECIO IMPORTE"
        "codigo": "CÓDIGO RESUMEN UDS LONGITUD ANCHURA ALTURA CANTIDAD PRECIO IMPORTE"
    },
    "section_header": {
        # if same y and in x in codigo is regex[\d{2}] and
        # next item in x in resumen and no more in other cols
        """
        {'pos': {'x': 90.72, 'y': 84.32}, 'text': '\n'}
        {'pos': {'x': 90.72, 'y': 84.32}, 'text': '01'}
        {'pos': {'x': 166.4, 'y': 84.32}, 'text': ' VIVIENDA MODULAR'}
        """
        "codigo": "01",
        "resumen":"01 VIVIENDA MODULAR"
    },
    "subsection_header": {
        # if same y and in x in codigo is regex[\d{2}.\d{2}] and next x in resumen and no more in otherscols
        "codigo": "01.01",
        "resumen": "ESTRUCTURA METÁLICA",
    },
    "chapter": {
        # if same y and in x in codigo is regex[\d{2}.\d{2}.\d{2}] and next x in resumen and no more in otherscols
        """
        {
            'coord': {'x': 90.72, 'y': 131.52},
            'text': '01.01.01 kg VIGAS METÁLICAS DE MÓDULOS 1, 2, 3, 4, 5, 6, 7 y 8'
        }
        """
        "codigo": "01.01.01",
        "resumen": "kg VIGAS METÁLICAS DE MÓDULOS 1, 2, 3, 4, 5, 6, 7 y 8",
    },
    "chapter_description": {
        [
            # if only in resumen
            {"codigo":"","resumen":"a"},
            {"codigo":"","resumen":"b"},
            {"codigo":"","resumen":"c"},
            {"codigo":"","resumen":""}, # is only description
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
        ]
    },
    "cantidades": [
        {
            # if in resumen and in cantidad
            "codigo": "",
            "resumen": "concepto x",
            "uds": "2",
            "longitud": "13,64",
            "anchura": "22.40",
        },
    ],
    "chapter_total": {
        "codigo": "", "resumen": "", "uds": "", "longitud": "",
        "anchura": "", "altura": "",
        # calcular por coor-x y si hay 3 numeros
        "cantidad": "", "precio": "", "importe": "",
    },
    "subsection_total": {
        # si hay TOTAL y ....
        #TOTAL 01.03.......................................... 11.455,45
        "codigo": "", "resumen": "",
        "uds": "TOTAL nn.pp ...........................................................................................",
        "longitud": "",
        "anchura": "",
        "altura": "",
        "cantidad": "",
        "precio": "",
        "importe": "11.455,45",
    }
}

page_coords = []


def visitor_body(text, cm, text_matrix, fontDict, fontSize):
    #pprint(fontSize);sys.exit()
    dic = {
        "text": text,
        "coord": {
            "x": text_matrix[4],
            "y": text_matrix[5],
        }
    }
    if text_matrix[4] != 0.0 and text_matrix[5] != 0.0:
        page_coords.append(dic)


def get_all_pages_coords():
    global page_coords
    
    all_pages = []
    reader = PdfFileReader(file_merged)
    for i_page in range(reader.getNumPages()):
        page_coords = []
        page = reader.pages[i_page]
        page.extract_text(visitor_text=visitor_body)

        all_pages.append({
            "page": i_page,
            "lines": page_coords.copy()
        })
        if i_page == 2:
            return all_pages

    return all_pages


def get_merged_line_with_same_y():
    page_coords = get_all_pages_coords()

    for page in page_coords:
        page_lines_coord = page.get("lines")


by_y = get_merged_line_with_same_y()
pprint(by_y)

def get_csv():
    global all_pages
    for page in all_pages:
        page_lines = page.get("content", [])
        lines = []
        processed = []
        for i,dic_line in enumerate(page_lines):
            pprint(dic_line)
            y = dic_line.get("coord").get("y", 0)
            if (y in processed): continue
            processed.append(y)
            text_line = get_merged_line_with_same_y(page_lines, y)
            lines.append(text_line)
        pprint(lines)
        sys.exit()

        pprint(lines)

#get_csv()
