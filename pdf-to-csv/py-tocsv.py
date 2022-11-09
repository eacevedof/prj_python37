# pip install PyPDF2
from files import *
from pprint import pprint
from PyPDF2 import PdfFileReader
import sys

"""
90.72 - 127	166.4 - 407.23	411 - 429.40	436.12 - 483.84	487.87 - 535	538.27 - 575.23	590.01 - 636-38	666.62 - 700.22	735.84 - 776.16

"""
columns = {
    "codigo": {"x1": 90.72, "x2": 127},
    "resumen": {"x1": 166.4, "x2": 407.23},
    "uds": {"x1": 411, "x2": 429.4},
    "longitud": {"x1": 436.12, "x2": 483.84},
    "anchura": {"x1": 487.87, "x2": 535},
    "altura": {"x1": 538.27, "x2": 575.23},
    "cantidad": {"x1": 590.01, "x2": 636.38},
    "precio": {"x1": 666.62, "x2": 700.22},
    "importe": {"x1": 735.84, "x2": 776.16},
}


page_coords = []


def visitor_body(text, cm, text_matrix, fontDict, fontSize):
    # pprint(fontSize);sys.exit()
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
        if i_page == 1:
            return all_pages

    return all_pages


def get_line_by_y(y, lines):
    by_y = filter(lambda line: line.get("coord").get("y") == y and line.get("text") != "\n", lines)
    r = map(lambda line: {"x": line.get("coord").get("x"), "text": line.get("text","").strip()}, by_y)
    return {
        "y": y,
        "xs": list(r)
    }


def get_merged_line_with_same_y():
    page_and_its_coord_lines = get_all_pages_coords()

    transformed = []
    y_processed = []
    for page in page_and_its_coord_lines:
        i_page = page.get("page")
        lines_coords = page.get("lines")
        new_lines = []
        for lines_coord in lines_coords:
            y = lines_coord.get("coord").get("y")
            if y in y_processed:
                continue
            y_processed.append(y)
            by_y = get_line_by_y(y, lines_coords)
            new_lines.append(by_y)
        transformed.append({
            "page": new_lines
        })
    return transformed


by_y = get_merged_line_with_same_y()
pprint(by_y);
sys.exit()


def get_csv():
    global all_pages
    for page in all_pages:
        page_lines = page.get("content", [])
        lines = []
        processed = []
        for i, dic_line in enumerate(page_lines):
            pprint(dic_line)
            y = dic_line.get("coord").get("y", 0)
            if (y in processed): continue
            processed.append(y)
            text_line = get_merged_line_with_same_y(page_lines, y)
            lines.append(text_line)
        pprint(lines)
        sys.exit()

        pprint(lines)

# get_csv()
