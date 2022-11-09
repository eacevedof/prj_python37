columns_coords = {
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


def is_title(dic_line):
    title = "PRESUPUESTO Y MEDICIONES"
    x = dic_line.get("pos").get("x")
    text = dic_line.get("text")
    return (is_in_colum("codigo", x) and text == title)

def is_table_header(dic_line):
    title = "CÓDIGO RESUMEN UDS LONGITUD ANCHURA ALTURA CANTIDAD PRECIO IMPORTE"
    x = dic_line.get("pos").get("x")
    text = dic_line.get("text")
    return (is_in_colum("codigo", x) and text == title)


def is_in_colum(name, x):
    coords = columns_coords.get(name)
    return (coords.get("x1")<=x and x<=coords.get("x2"))
