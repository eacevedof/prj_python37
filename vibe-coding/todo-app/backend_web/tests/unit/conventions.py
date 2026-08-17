"""Utilidades compartidas por los tests de convencion.

No es un test: es el codigo que los cinco tests de convencion usan para recorrer
el proyecto. Se llama `conventions.py` y no `test_*.py` justamente para que pytest
no intente ejecutarlo.

Todos los tests de convencion funcionan igual: leen el codigo fuente con `ast`
(el analizador de Python), sin importarlo ni ejecutarlo. Por eso son instantaneos
y no necesitan base de datos.
"""

import ast
from pathlib import Path
from typing import Iterator, NamedTuple


class SourceFile(NamedTuple):
    """Un fichero de codigo, ya analizado."""

    relative_path: str
    path: Path
    tree: ast.Module


def get_backend_root() -> Path:
    # conventions.py -> unit -> tests -> backend_web
    return Path(__file__).resolve().parents[2]


def get_source_files() -> list[SourceFile]:
    """Todos los .py de la aplicacion, ya analizados.

    Se saltan los `__init__.py` (estan vacios, solo marcan paquetes) y todo lo que
    no sea codigo de la aplicacion: el entorno virtual, los tests y las caches.
    """
    root = get_backend_root()
    source_files: list[SourceFile] = []
    for source_root in ("src", "public"):
        for path in sorted((root / source_root).rglob("*.py")):
            if path.name == "__init__.py" or "__pycache__" in path.parts:
                continue
            relative_path = str(path.relative_to(root)).replace("\\", "/")
            source_files.append(
                SourceFile(
                    relative_path=relative_path,
                    path=path,
                    tree=ast.parse(path.read_text(encoding="utf-8")),
                )
            )
    return source_files


def get_imported_modules(tree: ast.Module) -> Iterator[str]:
    """Los modulos que importa un fichero, como cadenas con puntos."""
    for node in ast.walk(tree):
        if isinstance(node, ast.Import):
            for alias in node.names:
                yield alias.name
        elif isinstance(node, ast.ImportFrom) and node.module:
            yield node.module


def get_classes(tree: ast.Module) -> list[ast.ClassDef]:
    return [node for node in tree.body if isinstance(node, ast.ClassDef)]


def get_expected_class_name(file_stem: str) -> str:
    """`create_task_service` -> `CreateTaskService`."""
    return "".join(part[:1].upper() + part[1:] for part in file_stem.split("_"))


def get_offenders_message(title: str, offenders: list[str], why: str) -> str:
    """Mensaje de fallo con formato uniforme.

    Los tests de convencion los va a leer alguien que quiza no sabe programar, asi
    que el mensaje tiene que decir tres cosas: que regla se ha roto, donde, y por
    que existe la regla.
    """
    listado = "\n".join(f"  - {offender}" for offender in offenders)
    return f"\n{title}\n\n{listado}\n\nPOR QUE: {why}\n"
