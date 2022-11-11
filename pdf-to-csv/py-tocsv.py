# pip install PyPDF2
from files import *
from pprint import pprint
from PyPDF2 import PdfFileReader
from pdf_parts import *
import sys


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
        if i_page == 3:
            return all_pages

    return all_pages


def get_line_by_y(y, lines):
    by_y = filter(lambda line: line.get("coord").get("y") == y and line.get("text") != "\n", lines)
    r = map(lambda line: {"x": line.get("coord").get("x"), "text": line.get("text","").strip()}, by_y)
    r = list(r)
    def _sort(dc):
        return dc["x"]
    r.sort(key = _sort)
    return {
        "y": y,
        "xs": r
    }


def get_merged_line_with_same_y():
    page_and_its_coord_lines = get_all_pages_coords()

    transformed = []
    for page in page_and_its_coord_lines:
        #i_page = page.get("page")
        lines_coords = page.get("lines")
        new_lines = []
        y_processed = []
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


as_dicts = []
pages_by_y = get_merged_line_with_same_y()
#pprint(pages_by_y)
for i,page in enumerate(pages_by_y):
    print(f"page {i}")
    page_lines = page.get("page")
    # pprint(page_lines); sys.exit()
    for page_y in page_lines:
        row = get_title_row(page_y)
        if row: as_dicts.append(row)
        row = get_table_row(page_y)
        if row: as_dicts.append(row)
        row = get_section_header_row(page_y)
        if row: as_dicts.append(row)
        row = get_subsection_header_row(page_y)
        if row: as_dicts.append(row)
        row = get_chapter_description_row(page_y)
        if row: as_dicts.append(row)
        row = get_quantity_row(page_y)
        if row: as_dicts.append(row)
        row = get_chapter_total(page_y)
        if row: as_dicts.append(row)
        row = get_subsection_total(page_y)
        if row: as_dicts.append(row)
#pprint(as_dicts)

def to_csv():
    import csv
    with open("./in-excel.csv", "w") as f:
        # using csv.writer method from CSV package
        write = csv.writer(f)
        write.writerows(map(lambda row: list(row.values()), as_dicts))

to_csv()
