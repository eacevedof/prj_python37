"""REGLA: las capas solo se pueden mirar en un sentido.

Es la regla que sostiene toda la arquitectura. Si se rompe, lo demas da igual.

    infrastructure  ->  application  ->  domain
    (controllers,       (casos de uso)   (reglas y
     repositorios,                        conceptos del
     adaptadores)                         negocio)

La flecha va en un solo sentido. En concreto:

  - **domain no importa NADA** de application ni de infrastructure. Es el nucleo:
    las reglas del negocio no pueden depender de si los datos vienen de SQLite o
    de una API, ni de que exista FastAPI.
  - **application no importa el framework ni el driver.** Un caso de uso no sabe
    que la aplicacion se sirve por HTTP ni que la base es SQLite. Si `fastapi`
    aparece en un caso de uso, ese caso de uso ya no se puede usar desde un script
    ni probar sin levantar un servidor.
  - **un modulo no entra en la capa de aplicacion de otro modulo.** Para eso estan
    los puertos y los adaptadores: se pide por la puerta (`infrastructure/adapters/`),
    no por la ventana.

Lo que este test NO prohibe: que un caso de uso importe un repositorio concreto.
Es una simplificacion deliberada del kit -sin ella habria que inyectar todo por
constructor y montar un contenedor de dependencias- y para un PoC no compensa.
Lo que si se exige es que la frontera ENTRE MODULOS pase siempre por un puerto.
"""

from tests.unit.conventions import assert_no_offenders, get_imported_modules, get_source_files

# Ni framework web ni driver de base de datos dentro de un caso de uso.
_FORBIDDEN_IN_APPLICATION = ("fastapi", "starlette", "uvicorn", "sqlite3")

# `src/core` y `public` son el arranque, no un modulo de negocio: es su trabajo
# conocer a todo el mundo para poder cablearlo.
_WIRING_PATHS = ("src/core/", "public/")


def _get_module_name(relative_path: str) -> str:
    """`src/modules/tasks_mod/domain/...` -> `tasks_mod`. Cadena vacia si no es un modulo."""
    parts = relative_path.split("/")
    if len(parts) > 2 and parts[0] == "src" and parts[1] == "modules":
        return parts[2]
    return ""


def test_el_dominio_no_importa_las_otras_capas() -> None:
    offenders = []
    for source_file in get_source_files():
        if "/domain/" not in f"/{source_file.relative_path}":
            continue
        for imported in get_imported_modules(source_file.tree):
            if ".application." in imported or ".infrastructure." in imported:
                offenders.append(f"{source_file.relative_path} importa {imported}")

    assert_no_offenders(
        "El dominio no puede importar application ni infrastructure.",
        offenders,
        "el dominio son las reglas del negocio, y tienen que poder existir sin saber"
        " si los datos vienen de SQLite, de una API o de un fichero. Si el dominio"
        " necesita algo de fuera, declara un PUERTO en `domain/ports/` y que otro"
        " modulo lo cumpla (mira `tasks_counter.py`).",
    )


def test_los_casos_de_uso_no_importan_el_framework_ni_el_driver() -> None:
    offenders = []
    for source_file in get_source_files():
        if "/application/" not in f"/{source_file.relative_path}":
            continue
        for imported in get_imported_modules(source_file.tree):
            root_package = imported.split(".")[0]
            if root_package in _FORBIDDEN_IN_APPLICATION:
                offenders.append(f"{source_file.relative_path} importa {imported}")

    assert_no_offenders(
        "Un caso de uso no puede importar FastAPI ni sqlite3.",
        offenders,
        "un caso de uso tiene que poder ejecutarse desde un test, desde un script o"
        " desde una cola, no solo desde una peticion HTTP. Lo de HTTP es del"
        " controller; lo de SQLite, del repositorio.",
    )


def test_un_modulo_no_entra_en_la_aplicacion_de_otro() -> None:
    offenders = []
    for source_file in get_source_files():
        if source_file.relative_path.startswith(_WIRING_PATHS):
            continue
        own_module = _get_module_name(source_file.relative_path)
        if not own_module:
            continue

        for imported in get_imported_modules(source_file.tree):
            if not imported.startswith("src.modules."):
                continue
            imported_module = imported.split(".")[2]
            # `shared` es el nucleo comun: lo puede usar todo el mundo.
            if imported_module in (own_module, "shared"):
                continue
            if ".application." in imported or ".domain." in imported:
                offenders.append(f"{source_file.relative_path} ({own_module}) entra en {imported}")

    assert_no_offenders(
        "Un modulo solo puede llamar a OTRO modulo por su carpeta `infrastructure/adapters/`.",
        offenders,
        "si un modulo importa los casos de uso o el dominio de otro, los dos quedan"
        " atados y ya no se pueden tocar por separado. La forma correcta: declara un"
        " puerto en tu `domain/ports/` diciendo QUE necesitas, y que el otro modulo"
        " lo cumpla con un adaptador. Ejemplo completo: `lists_reader.py` (puerto) +"
        " `lists_reader_adapter.py` (quien lo cumple).",
    )
