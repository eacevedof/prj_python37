"""REGLA: un fichero, una clase, y el fichero se llama como la clase.

Es la regla mas simple del proyecto y la que mas trabajo ahorra: si sabes el
nombre de una clase, sabes el nombre de su fichero, y al reves. No hay que buscar.

Se rompe sola en cuanto alguien anade "un enum pequeno" al final de un fichero que
ya existe. Empieza con uno y a las dos semanas hay ficheros con cuatro clases y
nombres que no dicen que hay dentro. Por eso se mide.

La segunda regla de este fichero -nada de constantes sueltas a nivel de modulo- va
en la misma direccion: una constante suelta no se puede tipar bien, no se
encuentra buscando, y acaba duplicada. Su sitio es un enum del dominio.
"""

import ast

from tests.unit.conventions import assert_no_offenders, get_classes, get_expected_class_name, get_source_files

# El front controller es la unica excepcion, y esta razonada:
#   - `app` tiene que ser una variable de modulo para que uvicorn la encuentre
#     (`public.main:app`).
#   - El borde de autenticacion vive completo ahi para poder auditarlo de un
#     vistazo en un solo sitio.
_ALLOWED_FILES = {"public/main.py"}


def test_cada_fichero_tiene_una_clase_y_se_llama_como_ella() -> None:
    offenders = []
    for source_file in get_source_files():
        if source_file.relative_path in _ALLOWED_FILES:
            continue

        class_names = [node.name for node in get_classes(source_file.tree)]
        if len(class_names) > 1:
            offenders.append(f"{source_file.relative_path}: tiene {len(class_names)} clases {class_names}")
            continue

        expected = get_expected_class_name(source_file.path.stem)
        if class_names and class_names[0] != expected:
            offenders.append(
                f"{source_file.relative_path}: declara `{class_names[0]}`, pero el nombre del fichero pide `{expected}`"
            )

    assert_no_offenders(
        "Un fichero, una clase, y el fichero se llama como ella.",
        offenders,
        "si el nombre del fichero predice el de la clase, encontrar codigo deja de"
        " requerir buscar. Saca cada clase a su propio fichero, con su nombre en"
        " snake_case (CreateTaskService -> create_task_service.py).",
    )


def test_ningun_fichero_tiene_constantes_sueltas() -> None:
    offenders = []
    for source_file in get_source_files():
        if source_file.relative_path in _ALLOWED_FILES:
            continue

        constants = [
            target.id
            for node in source_file.tree.body
            if isinstance(node, (ast.Assign, ast.AnnAssign))
            for target in ([node.target] if isinstance(node, ast.AnnAssign) else node.targets)
            if isinstance(target, ast.Name)
        ]
        if constants:
            offenders.append(f"{source_file.relative_path}: {constants}")

    assert_no_offenders(
        "Las constantes no van sueltas a nivel de modulo.",
        offenders,
        "una constante suelta no se puede reutilizar sin importar el modulo entero,"
        " no aparece agrupada con las de su tema y acaba duplicada con otro nombre."
        " Metela en un enum de `domain/enums/` (mira `task_limit_enum.py`).",
    )
