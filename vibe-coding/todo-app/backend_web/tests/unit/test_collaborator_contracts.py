"""REGLA: si llamas a un metodo de un colaborador, ese metodo tiene que existir.

Python no comprueba esto hasta que la linea se ejecuta. Si un service llama a
`self._tasks_reader_sqlite_repository.get_open_count()` y el metodo se llama
`get_open_count_by_list`, no te enteras al arrancar: te enteras cuando alguien usa
esa funcion en concreto. Si esa rama solo se ejecuta los martes, te enteras un
martes.

Es la clase de fallo que un doble de test tapa perfectamente: el doble responde a
lo que le preguntes, exista o no en el original.

Este test recorre las declaraciones de colaboradores de cada clase:

    _tasks_reader_sqlite_repository: TasksReaderSqliteRepository   <- de aqui saca el tipo

...y comprueba que cada `self._tasks_reader_sqlite_repository.loquesea()` existe
de verdad en esa clase (o en una de la que herede).

Es tambien la razon de que los colaboradores se declaren arriba con su tipo: sin
esa declaracion, esto no se podria comprobar.
"""

import ast

from tests.unit.conventions import assert_no_offenders, get_classes, get_source_files

# Metodos que vienen de fuera de nuestro codigo y no se pueden comprobar aqui.
_IGNORED_METHODS = {"append", "get", "items", "keys", "values", "strip", "lower", "upper"}


def _get_methods_by_class() -> dict[str, tuple[set[str], list[str]]]:
    """Mapa: nombre de clase -> (sus metodos, sus clases base).

    Incluye tambien los metodos de los Protocol (los puertos), que es lo que
    permite comprobar las llamadas a un puerto.
    """
    methods_by_class: dict[str, tuple[set[str], list[str]]] = {}
    for source_file in get_source_files():
        for class_node in get_classes(source_file.tree):
            method_names = {
                node.name for node in class_node.body if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef))
            }
            base_names = [base.id for base in class_node.bases if isinstance(base, ast.Name)]
            methods_by_class[class_node.name] = (method_names, base_names)
    return methods_by_class


def _get_all_methods(class_name: str, methods_by_class: dict[str, tuple[set[str], list[str]]]) -> set[str]:
    """Los metodos de una clase mas los que hereda, recorriendo hacia arriba."""
    if class_name not in methods_by_class:
        return set()
    method_names, base_names = methods_by_class[class_name]
    all_methods = set(method_names)
    for base_name in base_names:
        all_methods |= _get_all_methods(base_name, methods_by_class)
    return all_methods


def _get_collaborator_types(class_node: ast.ClassDef) -> dict[str, str]:
    """Lee las declaraciones `_x: MiClase` del cuerpo de la clase."""
    collaborator_types: dict[str, str] = {}
    for node in class_node.body:
        if (
            isinstance(node, ast.AnnAssign)
            and isinstance(node.target, ast.Name)
            and isinstance(node.annotation, ast.Name)
        ):
            collaborator_types[node.target.id] = node.annotation.id
    return collaborator_types


def test_los_metodos_que_se_llaman_existen_en_el_colaborador() -> None:
    methods_by_class = _get_methods_by_class()
    offenders = []

    for source_file in get_source_files():
        for class_node in get_classes(source_file.tree):
            collaborator_types = _get_collaborator_types(class_node)
            if not collaborator_types:
                continue

            for node in ast.walk(class_node):
                # Buscamos llamadas con la forma `self._algo.metodo(...)`
                if not isinstance(node, ast.Call) or not isinstance(node.func, ast.Attribute):
                    continue
                target = node.func.value
                if not (
                    isinstance(target, ast.Attribute)
                    and isinstance(target.value, ast.Name)
                    and target.value.id == "self"
                ):
                    continue

                collaborator_name = target.attr
                called_method = node.func.attr
                collaborator_class = collaborator_types.get(collaborator_name)
                if collaborator_class is None or called_method in _IGNORED_METHODS:
                    continue
                # Clases de fuera de nuestro codigo: no hay nada que comprobar.
                if collaborator_class not in methods_by_class:
                    continue

                available = _get_all_methods(collaborator_class, methods_by_class)
                if called_method not in available:
                    offenders.append(
                        f"{source_file.relative_path}: {class_node.name} llama a "
                        f"self.{collaborator_name}.{called_method}(), que no existe en "
                        f"{collaborator_class}"
                    )

    assert_no_offenders(
        "Se esta llamando a un metodo que no existe en el colaborador.",
        offenders,
        "Python no avisa de esto hasta que la linea se ejecuta, asi que sin este"
        " test el fallo aparece en produccion y no al arrancar. Revisa el nombre del"
        " metodo en la clase del colaborador; casi siempre es un cambio de nombre a"
        " medias.",
    )


def test_los_colaboradores_estan_declarados_con_su_tipo() -> None:
    """Todo lo que se asigna en `__init__` tiene que estar declarado arriba.

    No es cosmetico: la declaracion es de donde el test de arriba saca el tipo. Un
    colaborador sin declarar es un colaborador que nadie comprueba.
    """
    offenders = []
    for source_file in get_source_files():
        for class_node in get_classes(source_file.tree):
            declared = set(_get_collaborator_types(class_node))
            init_node = next(
                (node for node in class_node.body if isinstance(node, ast.FunctionDef) and node.name == "__init__"),
                None,
            )
            if init_node is None:
                continue

            for node in ast.walk(init_node):
                if not isinstance(node, ast.Assign):
                    continue
                for assign_target in node.targets:
                    if (
                        isinstance(assign_target, ast.Attribute)
                        and isinstance(assign_target.value, ast.Name)
                        and assign_target.value.id == "self"
                        and assign_target.attr not in declared
                    ):
                        offenders.append(
                            f"{source_file.relative_path}: {class_node.name} asigna "
                            f"self.{assign_target.attr} sin declararlo arriba"
                        )

    assert_no_offenders(
        "Hay un colaborador asignado en __init__ que no esta declarado con su tipo.",
        offenders,
        "declara el atributo encima de `__init__`, con su tipo:\n"
        "      _tasks_reader_sqlite_repository: TasksReaderSqliteRepository\n"
        "  Sirve de indice de lo que usa la clase, y es de donde el test de"
        " contratos saca el tipo para comprobar que las llamadas existen.",
    )
