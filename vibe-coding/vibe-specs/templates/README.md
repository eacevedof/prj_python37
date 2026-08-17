# Plantillas

Ficheros de partida con `{{MARCADORES}}` que hay que sustituir.

## Los marcadores

| Marcador | Ejemplo | Qué es |
|---|---|---|
| `{{modulo}}` | `documents` | nombre del módulo, **en plural** y minúsculas |
| `{{Modulo}}` | `Documents` | lo mismo en PascalCase |
| `{{entidad}}` | `document` | la entidad, **en singular** y minúsculas |
| `{{Entidad}}` | `Document` | lo mismo en PascalCase |
| `{{caso_de_uso}}` | `create_document` | el caso de uso, en snake_case |
| `{{CasoDeUso}}` | `CreateDocument` | lo mismo en PascalCase |
| `{{Capacidad}}` | `DocumentsReader` | nombre de un puerto, en PascalCase |
| `{{tabla}}` | `app_documents` | la tabla, con prefijo `app_` y en plural |
| `{{marca_de_tiempo}}` | `20260819100000` | prefijo de una migración, `YYYYMMDDHHMMSS` |

## Singular o plural: la regla

Es lo que más se equivoca, así que va aquí y en
[`../20-backend-python.md`](../20-backend-python.md):

| Va en **PLURAL** | Va en **SINGULAR** |
|---|---|
| el módulo: `documents_mod` | los enums: `document_field_enum.py` |
| la excepción: `documents_exception.py` | la entidad: `document_entity.py` |
| los repositorios: `documents_reader_sqlite_repository.py` | los servicios de dominio: `due_date.py` |
| la tabla: `app_documents` | |
| los casos de uso de colección: `search_documents` | los de un elemento: `get_document`, `create_document` |

Ojo con los plurales irregulares: `category` → `categories`, no `categorys`. Las
plantillas no pueden adivinarlo por ti.

## Cómo usarlas

> **Estas plantillas son la red de seguridad, no el camino principal.** Lo normal
> es pedírselo a Claude con un prompt de [`../90-prompts.md`](../90-prompts.md):
> copia la forma del ejemplar, que está mejor comentado que cualquier plantilla.
> Esto es para cuando quieres escribir un fichero a mano y no acordarte de la
> forma exacta.

Un caso de uso completo son **tres ficheros** (`_dto`, `_result_dto`, `_service`)
más **un controller** más **su ruta**. Si te falta alguno, `make check` te lo dice.

**Cuando termines de sustituir, ejecuta `make check`.** Las plantillas dejan
huecos (`<campos>`, `<columnas>`) que no compilan hasta que los rellenas: eso es
a propósito, para que no se cuele un fichero a medio hacer.
