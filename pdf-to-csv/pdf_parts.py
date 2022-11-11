import re

columns_coords = {
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

empty_row = {
    "codigo": None,
    "resumen": None,
    "uds": None,
    "longitud": None,
    "anchura": None,
    "altura": None,
    "cantidad": None,
    "precio": None,
    "importe": None,
}

table_row = {
    "codigo": "CÓDIGO",
    "resumen": "RESUMEN",
    "uds": "UDS",
    "longitud": "LONGITUD",
    "anchura": "ANCHURA",
    "altura": "ALTURA",
    "cantidad": "CANTIDAD",
    "precio": "PRECIO",
    "importe": "IMPORTE",
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
        "resumen": "01 VIVIENDA MODULAR"
    },
    "subsection_header": {
        # if same y and in x in codigo is regex[\d{2}.\d{2}] and next x in resumen and no more in otherscols
        "codigo": "01.01",
        "resumen": "ESTRUCTURA METÁLICA",
    },
    "chapter_title": {
        # if same y and in x in codigo is regex[\d{2}.\d{2}.\d{2}] and next x in resumen and no more in otherscols
        "codigo": "01.01.01",
        "resumen": "kg VIGAS METÁLICAS DE MÓDULOS 1, 2, 3, 4, 5, 6, 7 y 8",
    },
    "chapter_description": [
        # if only in resumen
        {"codigo": "", "resumen": "a"},
        {"codigo": "", "resumen": "b"},
        {"codigo": "", "resumen": "c"},
        {"codigo": "", "resumen": ""},  # is only description
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
    ],

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
        # calcular por coor-x y si hay 3 numeros: 15.545,91 1,58 24.562,54
        "cantidad": "", "precio": "", "importe": "",
    },
    "subsection_total": {
        """
        {'xs': [
        {'text': 'TOTAL 01.01........................................................................................... 39.008,61',
         'x': 351.52}], //resumen
        'y': 659.2},
        """
    }
}


def _is_title(line_y):
    title = "PRESUPUESTO Y MEDICIONES"
    xs = line_y.get("xs")
    x0 = xs[0].get("x")
    text = xs[0].get("text")
    return (_is_in_column("codigo", x0) and text == title)


def get_title_row(line_y):
    if _is_title(line_y):
        row = empty_row.copy()
        xs = line_y.get("xs")
        text = xs[0].get("text")
        row["codigo"] = text
        return row
    return None


def get_table_row(line_y):
    title = "CÓDIGO RESUMEN UDS LONGITUD ANCHURA ALTURA CANTIDAD PRECIO IMPORTE"
    xs = line_y.get("xs")
    x0 = xs[0].get("x")
    text = xs[0].get("text")
    if _is_in_column("codigo", x0) and text == title:
        return table_row
    return None


def get_section_header_row(line_y):
    xs = line_y.get("xs")
    if len(xs) < 2:
        return None
    x0 = xs[0].get("x")
    x0text = xs[0].get("text")
    x1 = xs[1].get("x")
    x1text = xs[1].get("text")

    if _is_in_column("codigo", x0) and _match("^\d{2}$", x0text) and x1 and _are_empty_after("resumen", line_y):
        row = empty_row.copy()
        row["codigo"] = x0text
        row["resumen"] = x1text
        return row

    return None


def get_subsection_header_row(line_y):
    xs = line_y.get("xs")
    if len(xs) < 2:
        return None
    x0 = xs[0].get("x")
    x0text = xs[0].get("text")
    x1 = xs[1].get("x")
    x1text = xs[1].get("text")

    if _is_in_column("codigo", x0) and _match("\d{2}\.\d{2}$", x0text) and x1 and _are_empty_after("resumen", line_y):
        row = empty_row.copy()
        row["codigo"] = x0text
        row["resumen"] = x1text
        return row

    return None


def get_chapter_title_row(line_y):
    xs = line_y.get("xs")
    if len(xs) != 1:
        return None
    x0 = xs[0].get("x")
    x0text = xs[0].get("text")

    if _is_in_column("codigo", x0) and _match("^(\d{2}\.\d{2}\.\d{2}).*", x0text) and _are_empty_after("codigo",
                                                                                                       line_y):
        row = empty_row.copy()
        codigo = x0text.split(" ")
        title = codigo[1:]
        codigo = codigo[0]
        title = " ".join(title)
        row["codigo"] = codigo
        row["resumen"] = title
        return row

    return None


def get_chapter_description_row(line_y):
    xs = line_y.get("xs")
    if len(xs) != 1:
        return None
    x0 = xs[0].get("x")
    x0text = xs[0].get("text")

    if not _is_in_column("codigo", x0) and _is_in_column("resumen", x0) and _are_empty_after("resumen", line_y) and "...." not in x0text:
        row = empty_row.copy()
        row["resumen"] = x0text
        return row

    return None


def get_quantity_row(line_y):
    xs = line_y.get("xs")
    if len(xs) < 3:
        return None
    x0 = xs[0].get("x")
    x0text = xs[0].get("text")

    if not _is_in_column("codigo", x0) and _is_in_column("resumen", x0) and _match("\d+\,\d+", x0text):
        row = empty_row.copy()
        row["resumen"] = x0text
        row["uds"] = xs[1].get("text")
        row["longitud"] = xs[2].get("text")
        altura = xs[3].get("text").split(" ")
        row["anchura"] = altura[0]
        row["cantidad"] = altura[1]
        return row

    return None


def get_chapter_total(line_y):
    xs = line_y.get("xs")
    if len(xs) != 1:
        return None
    x0 = xs[0].get("x")
    x0text = xs[0].get("text")

    # {'xs': [{'text': '15.545,91 1,58 24.562,54', 'x': 591.68}],
    if not _is_in_column("cantidad", x0) and " " in x0text and _match("\d+\,\d+\s\d+\,\d+\s\d+\,\d+", x0text):
        row = empty_row.copy()
        # cantidad, precio e importe
        values = x0text.split(" ")
        row["cantidad"] = values[0]
        row["precio"] = values[1]
        row["importe"] = values[2]
        return row

    return None


def get_subsection_total(line_y):
    xs = line_y.get("xs")
    if len(xs) != 1:
        return None
    x0 = xs[0].get("x")
    x0text = xs[0].get("text")

    """
    {'text': 'TOTAL 01.01............................................................................... 39.008,61','x': 351.52}
    """
    if not _is_in_column("altura", x0) and "....." in x0text and _match("\d+\,\d+", x0text):
        row = empty_row.copy()
        parts = x0text.split(".....")
        row["resumen"] = parts[0]
        total = parts[-1:].split(" ")
        row["importe"] = total[-1:]
        return row

    return None


def _match(pattern, text):
    r = re.search(pattern, text)
    return True if r else False


def _is_in_column(name, x):
    coords = columns_coords.get(name)
    return coords.get("x1") <= x <= coords.get("x2")


def _are_empty_after(colname, line_y):
    xs = line_y.get("xs")
    columns = list(columns_coords.keys())
    for i, col in enumerate(columns):
        if col == colname:
            break
    columns = columns[i + 1:10]
    for x in xs:
        coord_x = x.get("x")
        for col in columns:
            x_range = columns_coords.get(col)
            x1 = x_range.get("x1")
            if coord_x < x1: continue
            x2 = x_range.get("x2")
            if x1 <= coord_x <= x2:
                return False
    return True


def _is_index(idx, ls):
    return idx < len(ls)
