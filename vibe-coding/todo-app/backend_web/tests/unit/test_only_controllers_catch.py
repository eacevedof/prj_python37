"""REGLA: capturar excepciones solo esta permitido en sitios contados.

Es la regla que hace que los errores se puedan encontrar.

Cuando cualquiera puede escribir `except Exception: pass`, un fallo puede quedarse
tragado en cinco capas distintas y lo que llega arriba es "no hay datos" en vez de
"la base de datos esta caida". Depurar eso es una tarde perdida.

La solucion es que los errores SUBAN, y que haya un unico sitio, arriba del todo,
que decida que hacer con ellos. Sitios permitidos, cada uno con su razon:

  infrastructure/controllers/   Es el borde con el mundo. Traduce excepciones a
                               respuestas HTTP: las esperadas, a su codigo; las
                               inesperadas, a un 500 con la traza en el log.

  infrastructure/runners/       Trabajo por lotes sin controller delante (las
                               migraciones del arranque). Un fichero que falla no
                               puede tumbar el lote entero ni pasar en silencio:
                               se captura y se devuelve como DATO.

  domain/services/              Traducir la excepcion de una libreria a un
                               booleano del dominio, como hace `DueDate.is_valid`
                               con `strptime`. Traducir no es tragarse: el
                               resultado sale entero y quien llama decide.

  public/main.py                El cuerpo JSON de una peticion es opcional; que no
                               venga no es un error.

Donde NUNCA: repositorios y casos de uso.
"""

import ast

from tests.unit.conventions import assert_no_offenders, get_source_files

_ALLOWED_PATHS = (
    "infrastructure/controllers/",
    "infrastructure/runners/",
    "domain/services/",
)
_ALLOWED_FILES = ("public/main.py",)


def _has_except_handler(tree: ast.Module) -> bool:
    return any(isinstance(node, ast.ExceptHandler) for node in ast.walk(tree))


def test_los_repositorios_no_capturan_excepciones() -> None:
    offenders = [
        source_file.relative_path
        for source_file in get_source_files()
        if "infrastructure/repositories/" in source_file.relative_path and _has_except_handler(source_file.tree)
    ]

    assert_no_offenders(
        "Un repositorio no puede capturar excepciones. Ni una.",
        offenders,
        "un repositorio que captura y devuelve None convierte 'la base de datos esta"
        " caida' en 'no hay resultados', que es la peor forma de enterarse de un"
        " problema. Deja que el error suba: el controller ya lo captura y lo"
        " registra con su traza.",
    )


def test_los_casos_de_uso_no_capturan_excepciones() -> None:
    offenders = [
        source_file.relative_path
        for source_file in get_source_files()
        if "/application/" in f"/{source_file.relative_path}" and _has_except_handler(source_file.tree)
    ]

    assert_no_offenders(
        "Un caso de uso no puede capturar excepciones.",
        offenders,
        "un caso de uso decide, no maneja fallos de infraestructura. Si lo que"
        " quieres es convertir el error de una libreria en una regla de negocio"
        " (por ejemplo 'esto no es una fecha valida'), sacalo a un servicio de"
        " dominio: mira `tasks_mod/domain/services/due_date.py`.",
    )


def test_solo_capturan_los_sitios_permitidos() -> None:
    offenders = []
    for source_file in get_source_files():
        if not _has_except_handler(source_file.tree):
            continue
        if source_file.relative_path in _ALLOWED_FILES:
            continue
        if any(allowed in source_file.relative_path for allowed in _ALLOWED_PATHS):
            continue
        offenders.append(source_file.relative_path)

    assert_no_offenders(
        "Este fichero captura excepciones y no es uno de los sitios permitidos.",
        offenders,
        "los sitios permitidos son: controllers (traducen a HTTP), runners (trabajo"
        " por lotes), servicios de dominio (traducen una excepcion de libreria a un"
        " booleano) y el front controller. Si crees que tu caso es una excepcion"
        " nueva, anadela a la lista de este test CON su razon escrita: que la"
        " excepcion quede documentada es justo el objetivo.",
    )
