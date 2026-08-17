# 50 · Los guardarraíles: qué mide `make check` y qué hacer si sale rojo

Este es el fichero que hay que abrir cuando algo se pone en rojo.

```
make check
```

Hace cuatro cosas, en este orden. Si una falla, para.

| | Qué mira | Si falla |
|---|---|---|
| **ruff (lint)** | errores de código y de imports | `make format` arregla casi todo |
| **ruff (formato)** | espaciado, comillas, líneas | `make format` lo arregla todo |
| **mypy** | que los tipos cuadren | hay que arreglarlo a mano |
| **pytest** | que funcione y que siga el patrón | depende del test |

> **Verde no quiere decir "está terminado".** Quiere decir "el código es
> mantenible". Que la aplicación haga lo que negocio pidió, eso lo compruebas tú.

---

## Los tests de convención

**5 ficheros, 16 comprobaciones.** No miran qué hace el código, sino **cómo
está escrito**. Existen porque nadie va a revisar tu diff: son el revisor.

Leen el código sin ejecutarlo, así que tardan milisegundos, y cuando fallan te
dicen los tres datos que necesitas: **qué regla**, **dónde**, y **por qué existe
esa regla**.

---

### `test_file_per_class.py`

**Un fichero, una clase, y el fichero se llama como la clase.**

```
Un fichero, una clase, y el fichero se llama como ella.

  - src/modules/tasks_mod/domain/enums/task_done_enum.py: tiene 2 clases ['TaskDoneEnum', 'OtroEnum']

POR QUE: si el nombre del fichero predice el de la clase, encontrar código deja
de requerir buscar. Saca cada clase a su propio fichero...
```

**Cómo se rompe:** añadiendo "un enum pequeño" al final de un fichero que ya
existe. Empieza con uno y a las dos semanas hay ficheros con cuatro clases.

**Cómo se arregla:** cada clase a su fichero, con su nombre en snake_case.

**Y la segunda mitad: nada de constantes sueltas.**

```
Las constantes no van sueltas a nivel de modulo.
  - src/modules/tasks_mod/domain/enums/task_done_enum.py: ['MAX_INTENTOS']
```

Una constante suelta no se puede reutilizar sin importar el módulo entero y acaba
duplicada con otro nombre. Su sitio es un enum de `domain/enums/`.

---

### `test_layer_dependencies.py`

**Las capas solo se miran en un sentido.** Tres comprobaciones:

**1. El dominio no importa nada de application ni de infrastructure.**

Si el dominio necesita algo de fuera, no se importa: se declara un **puerto**.
Mira `tasks_mod/domain/ports/lists_reader.py`.

**2. Un caso de uso no importa `fastapi` ni `sqlite3`.**

Un caso de uso tiene que poder ejecutarse desde un test o desde un script, no
solo desde una petición HTTP. Lo de HTTP es del controller; lo de SQLite, del
repositorio.

**3. Un módulo no entra en la aplicación ni el dominio de otro módulo.**

```
Un modulo solo puede llamar a OTRO modulo por su carpeta `infrastructure/adapters/`.

  - src/modules/tasks_mod/application/get_task/get_task_service.py (tasks_mod)
    entra en src.modules.lists_mod.application.get_list.get_list_service

POR QUE: si un modulo importa los casos de uso o el dominio de otro, los dos
quedan atados y ya no se pueden tocar por separado. La forma correcta: declara un
puerto en tu `domain/ports/` diciendo QUE necesitas...
```

Es el que más salta al principio, y el que más valor tiene. La forma correcta
está explicada entera en [`10-arquitectura.md`](10-arquitectura.md).

`shared` es la excepción: lo puede usar todo el mundo.

---

### `test_only_controllers_catch.py`

**Capturar errores solo está permitido en sitios contados.**

Cuando cualquiera puede escribir `except Exception: pass`, un fallo puede quedarse
tragado en cinco capas y lo que llega arriba es *"no hay datos"* en vez de *"la
base de datos está caída"*. Depurar eso es una tarde perdida.

Sitios permitidos, cada uno con su razón:

| Dónde | Por qué |
|---|---|
| `infrastructure/controllers/` | Es el borde. Traduce errores a respuestas HTTP |
| `infrastructure/runners/` | Trabajo por lotes sin controller delante |
| `domain/services/` | Traducir la excepción de una librería a un booleano |
| `public/main.py` | El cuerpo JSON es opcional; que no venga no es un error |

**Nunca:** repositorios ni casos de uso.

Sobre `domain/services/`: la diferencia entre **traducir** un error y
**tragárselo** es que después de traducirlo quien llama sigue sabiendo qué pasó.
`DueDate.is_valid()` captura el error de `strptime` y devuelve `False`; el caso de
uso recibe ese `False` y decide devolver un 400. No se ha ocultado nada.

Si crees que tu caso es una excepción nueva, **añádela a la lista del test con su
razón escrita**. Que la excepción quede documentada es justo el objetivo.

---

### `test_naming_conventions.py`

Seis comprobaciones de nombres. Las que más saltan:

**El nombre del fichero encaja con su carpeta.** Un fichero en
`infrastructure/repositories/` acaba en `_repository.py`. O el fichero está mal
nombrado, o está en la carpeta equivocada.

**Un repositorio dice de dónde saca los datos.**
`tasks_reader_sqlite_repository.py`, no `tasks_reader_repository.py`. Sirve para
saber, sin abrir el fichero, si esa llamada va al disco de al lado o a internet.

**Los ficheros de un caso de uso empiezan por su nombre.** La carpeta
`create_task/` contiene `create_task_dto.py`, `create_task_result_dto.py` y
`create_task_service.py`. Parece redundante en el árbol y deja de parecerlo en
cuanto tienes ocho pestañas abiertas llamadas `service.py`.

**Prefijos prohibidos:** `prepare_`, `build_`, `make_`, `process_`, `parse_`,
`handle_`, `manage_`. Todos obligan a leer el cuerpo del método para saber qué
hace.

---

### `test_collaborator_contracts.py`

**Si llamas a un método de un colaborador, ese método tiene que existir.**

Python no comprueba esto hasta que la línea se ejecuta. Si llamas a
`get_open_count()` y el método se llama `get_open_count_by_list()`, no te enteras
al arrancar: te enteras cuando alguien usa esa función. Si esa rama solo se
ejecuta los martes, te enteras un martes.

Este test lo detecta al escribirlo, y es también la razón de que los
colaboradores se declaren arriba con su tipo:

```python
_tasks_reader_sqlite_repository: TasksReaderSqliteRepository   # ← de aquí saca el tipo
```

Su hermano `test_los_colaboradores_estan_declarados_con_su_tipo` comprueba que no
te dejes ninguno sin declarar. Un colaborador sin declarar es un colaborador que
nadie verifica.

---

## Errores de mypy que vas a ver

**`Item "None" of "dict | None" has no attribute ...`**

Estás usando algo que puede no existir. Falta la guarda:

```python
task_row = self._tasks_reader_sqlite_repository.get_by_id(task_id)
if task_row is None:
    TasksException.not_found_custom(f"no existe la tarea {task_id}")
# a partir de aquí mypy ya sabe que no es None, porque la factoría es NoReturn
```

**`Function is missing a type annotation`**

Falta el tipo de un argumento o del retorno. Si no devuelve nada, es `-> None`.

**`Returning Any from function declared to return "int"`**

Algo devuelve un tipo que mypy no conoce. Conviértelo explícitamente:
`int(row["open_count"])`.

---

## Cuando el guardarraíl te estorba

A veces vas a estar seguro de que la regla no aplica a tu caso. Tres opciones, en
orden:

1. **Mírate el ejemplo que da el mensaje.** Nueve de cada diez veces hay una forma
   de hacerlo que cumple la regla y además queda mejor.
2. **Si de verdad es una excepción**, añádela a la lista del test **con un
   comentario explicando por qué**. Así queda documentada y auditable, que es de
   lo que se trata.
3. **Lo que no se hace nunca:** borrar el test, o comentarlo, o poner
   `# noqa` sin explicación. Eso quita la medida, no el problema.
