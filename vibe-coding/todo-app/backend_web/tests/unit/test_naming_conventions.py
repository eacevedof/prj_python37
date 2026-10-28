"""REGLA: el sitio de un fichero decide como se llama.

Si un fichero esta en `infrastructure/repositories/`, se llama `*_repository.py`.
Si esta en `application/create_task/`, empieza por `create_task`. Sin excepciones.

Suena a burocracia y no lo es: es lo que permite entender un modulo que no has
visto nunca leyendo solo el arbol de carpetas, sin abrir un fichero. Y es lo que
hace que anadir un modulo nuevo sea copiar una forma en vez de inventar una.
"""

import ast

from tests.unit.conventions import assert_no_offenders, get_classes, get_source_files

# Carpeta -> sufijo obligatorio del fichero.
_REQUIRED_SUFFIX_BY_FOLDER = {
    "infrastructure/controllers/": "_controller.py",
    "infrastructure/repositories/": "_repository.py",
    "infrastructure/adapters/": "_adapter.py",
    "infrastructure/runners/": "_runner.py",
    "domain/enums/": "_enum.py",
    "domain/exceptions/": "_exception.py",
    "domain/entities/": "_entity.py",
}

# De donde saca los datos un repositorio. El segmento va en el NOMBRE, siempre:
# `tasks_reader_sqlite_repository`, no `tasks_reader_repository`. Asi se ve de un
# vistazo que un repositorio habla con una API y no con la base de datos.
_DATASOURCES = ("sqlite", "api", "file", "raw", "memory", "http", "cdn", "s3", "redis")

# Prefijos que no dicen nada. `process_document` no explica que le hace al
# documento; `build_query` tampoco. Obligan a leer el cuerpo del metodo.
_BANNED_METHOD_PREFIXES = ("prepare_", "build_", "make_", "process_", "parse_", "handle_", "manage_")


def test_el_nombre_del_fichero_encaja_con_su_carpeta() -> None:
    offenders = []
    for source_file in get_source_files():
        for folder, required_suffix in _REQUIRED_SUFFIX_BY_FOLDER.items():
            if folder in source_file.relative_path and not source_file.path.name.endswith(required_suffix):
                offenders.append(
                    f"{source_file.relative_path}: al estar en `{folder}` tendria que acabar en `{required_suffix}`"
                )

    assert_no_offenders(
        "El nombre del fichero no encaja con la carpeta donde esta.",
        offenders,
        "o el fichero esta mal nombrado, o esta en la carpeta equivocada. Las dos"
        " cosas se arreglan igual de rapido y las dos confunden igual de tiempo si"
        " no se arreglan.",
    )


def test_los_repositorios_dicen_de_donde_sacan_los_datos() -> None:
    offenders = []
    for source_file in get_source_files():
        if "infrastructure/repositories/" not in source_file.relative_path:
            continue
        stem = source_file.path.stem
        if stem.startswith("abstract_"):
            continue
        if not any(f"_{datasource}_" in stem for datasource in _DATASOURCES):
            offenders.append(f"{source_file.relative_path}: falta el origen de los datos en el nombre")

    assert_no_offenders(
        "El nombre de un repositorio tiene que decir de donde saca los datos.",
        offenders,
        "el formato es `<entidad>_<reader|writer>_<origen>_repository.py`, por"
        f" ejemplo `tasks_reader_sqlite_repository.py`. Origenes validos: {', '.join(_DATASOURCES)}."
        " Sirve para saber, sin abrir el fichero, si una llamada va a la base de"
        " datos local o a una API por internet, que no cuestan lo mismo.",
    )


def test_los_ficheros_de_un_caso_de_uso_llevan_su_nombre() -> None:
    offenders = []
    for source_file in get_source_files():
        parts = source_file.relative_path.split("/")
        if "application" not in parts:
            continue
        use_case_folder = parts[-2]
        if use_case_folder == "application":
            continue
        if not source_file.path.stem.startswith(use_case_folder):
            offenders.append(
                f"{source_file.relative_path}: al estar en `{use_case_folder}/` "
                f"tendria que empezar por `{use_case_folder}`"
            )

    assert_no_offenders(
        "Los ficheros de un caso de uso empiezan por el nombre del caso de uso.",
        offenders,
        "una carpeta `create_task/` contiene `create_task_dto.py`,"
        " `create_task_result_dto.py` y `create_task_service.py`. Repetir el nombre"
        " parece redundante en el arbol, pero deja de serlo en cuanto tienes ocho"
        " ficheros `service.py` abiertos en pestanas y no sabes cual es cual.",
    )


def test_los_puertos_no_llevan_sufijo_port() -> None:
    offenders = [
        source_file.relative_path
        for source_file in get_source_files()
        if "domain/ports/" in source_file.relative_path and source_file.path.stem.endswith("_port")
    ]

    assert_no_offenders(
        "Un puerto no lleva el sufijo `_port`.",
        offenders,
        "la carpeta ya dice que es un puerto. El nombre tiene que decir QUE"
        " capacidad se necesita: `lists_reader.py`, `tasks_counter.py`.",
    )


def test_ningun_metodo_usa_un_prefijo_prohibido() -> None:
    offenders = []
    for source_file in get_source_files():
        for class_node in get_classes(source_file.tree):
            for node in class_node.body:
                if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
                    continue
                clean_name = node.name.lstrip("_")
                if clean_name.startswith(_BANNED_METHOD_PREFIXES):
                    offenders.append(f"{source_file.relative_path}: {class_node.name}.{node.name}()")

    assert_no_offenders(
        "Este metodo usa un prefijo que no dice nada.",
        offenders,
        f"prefijos prohibidos: {', '.join(_BANNED_METHOD_PREFIXES)}. Todos ellos"
        " obligan a leer el cuerpo del metodo para saber que hace. Si el metodo"
        " DEVUELVE algo, empieza por `get_`, `has_`, `is_`, `can_` o `should_`. Si"
        " HACE algo, usa el verbo concreto: `create`, `send`, `apply`.",
    )


def test_los_metodos_get_devuelven_algo() -> None:
    offenders = []
    for source_file in get_source_files():
        for class_node in get_classes(source_file.tree):
            for node in class_node.body:
                if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
                    continue
                if not node.name.lstrip("_").startswith("get_"):
                    continue
                returns_nothing = isinstance(node.returns, ast.Constant) and node.returns.value is None
                if returns_nothing:
                    offenders.append(f"{source_file.relative_path}: {class_node.name}.{node.name}() -> None")

    assert_no_offenders(
        "Un metodo que empieza por `get_` tiene que devolver algo.",
        offenders,
        "`get_` es una promesa: quien lee la llamada espera un valor de vuelta. Si"
        " el metodo lo que hace es una accion, cambiale el nombre por el verbo que"
        " la describa.",
    )
