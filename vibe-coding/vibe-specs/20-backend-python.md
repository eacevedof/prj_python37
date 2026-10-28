# 20 · Backend en Python

Cómo se escribe cada pieza. Todo lo de aquí tiene su ejemplo en `todo-app`.

> ¿El backend no es Python? Lee
> [`21-backend-otros-lenguajes.md`](21-backend-otros-lenguajes.md), pero **lee
> antes esta página**: es la referencia que allí se replica.

---

## Dónde va cada fichero

```
backend_web/
├── public/main.py                     arranque + autenticación + servir el front
├── src/
│   ├── core/
│   │   ├── boot/env.py                único sitio que lee el .env
│   │   ├── config/database.py         abre la conexión a SQLite
│   │   └── routes/routes.py           TABLA DE RUTAS: todos los endpoints
│   └── modules/
│       ├── shared/                    lo que usan todos los módulos
│       ├── devops_mod/                el migrador (no lo toques)
│       └── <lo_tuyo>_mod/
│           ├── application/<caso_de_uso>/
│           ├── domain/{enums,exceptions,ports,services,entities}/
│           └── infrastructure/{controllers,repositories,adapters}/
├── database/migrations/*.sql
├── storage/{database,logs}/
└── tests/{unit,integration}/
```

## Cómo se llama cada fichero

**El sitio decide el nombre.** Está medido por `make check`.

| Está en... | Se llama... | Ejemplo |
|---|---|---|
| `application/create_task/` | `create_task_*.py` | `create_task_service.py` |
| `infrastructure/controllers/` | `*_controller.py` | `create_task_controller.py` |
| `infrastructure/repositories/` | `*_<origen>_repository.py` | `tasks_reader_sqlite_repository.py` |
| `infrastructure/adapters/` | `*_adapter.py` | `lists_reader_adapter.py` |
| `domain/enums/` | `*_enum.py` | `task_field_enum.py` |
| `domain/exceptions/` | `*_exception.py` | `tasks_exception.py` |
| `domain/entities/` | `*_entity.py` | `task_entity.py` |
| `domain/ports/` | sin sufijo | `lists_reader.py` |
| `domain/services/` | sin sufijo | `due_date.py` |

**Un fichero, una clase, y el fichero se llama como la clase** en snake_case:
`CreateTaskService` → `create_task_service.py`.

### Singular o plural

Es lo que más se equivoca, porque en la tabla de arriba aparecen mezclados. La
regla, para una entidad `task`:

| Va en **PLURAL** | Va en **SINGULAR** |
|---|---|
| el módulo → `tasks_mod` | los enums → `task_field_enum.py`, `TaskFieldEnum` |
| la excepción → `tasks_exception.py`, `TasksException` | la entidad → `task_entity.py`, `TaskEntity` |
| los repositorios → `tasks_reader_sqlite_repository.py` | los servicios de dominio → `due_date.py`, `DueDate` |
| la tabla → `app_tasks` | |
| el caso de uso de una colección → `search_tasks` | el de un elemento → `get_task`, `create_task` |

La idea de fondo: **plural cuando la pieza gestiona el conjunto** (un repositorio
consulta la tabla entera, el módulo agrupa todo lo de esa entidad), **singular
cuando describe uno**.

Cuidado con los plurales irregulares: `category` → `categories`, no `categorys`.

### Carpetas que puede que no necesites

**Crea solo las carpetas que vayas a usar.** No hay que dejar `domain/ports/`
ni `infrastructure/adapters/` vacías "por si acaso":

- **`ports/` y `adapters/`** solo si tu módulo habla con otro. Un módulo
  independiente no los tiene.
- **`entities/`** solo si necesitas una forma de dato con nombre propio. En un
  CRUD normal no hace falta: los DTO ya describen lo que entra y lo que sale, y
  el ejemplar no usa ninguna en el backend por eso. Aparece en el árbol porque
  existe la convención, no porque haya que crearla.
- **`services/`** solo si una regla la comparten dos casos de uso.

**El nombre de un repositorio dice de dónde salen los datos**:
`sqlite`, `api`, `file`, `raw`, `memory`, `http`, `cdn`, `s3`, `redis`. Así sabes
si una llamada va al disco de al lado o a internet, que no cuestan lo mismo.

---

## Las cinco piezas

### 1 · DTO de entrada — `create_task_dto.py`

```python
@final
@dataclass(frozen=True, slots=True)
class CreateTaskDto:
    id_list: int
    title: str
    due_date: str | None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        due_date = str(primitives.get(TaskFieldEnum.DUE_DATE, "")).strip()
        return cls(
            id_list=int(primitives.get(TaskFieldEnum.ID_LIST, 0) or 0),
            title=str(primitives.get(TaskFieldEnum.TITLE, "")).strip(),
            due_date=due_date or None,
        )
```

- `frozen=True` — nadie puede cambiarte los datos a media ejecución.
- `slots=True` — un error de escritura al asignar revienta, en vez de crear un
  campo nuevo en silencio.
- `from_primitives` **convierte, no valida**. Validar es decidir, y decidir es del
  service. Aquí solo se pasa de "lo que llegó por HTTP" a "tipos de Python".

  > **Dónde está la frontera**, que no siempre es obvia: si la operación tiene
  > **una sola respuesta posible** y nunca produce un error, es convertir
  > (`.strip()`, `int(...)`, cadena vacía → `None`). Si la operación puede
  > responder *"esto no vale"*, es validar, y va al service. Por eso
  > `due_date or None` va en el DTO y "¿es una fecha real?" va en el service.
- El `or 0` cubre que llegue `None` o vacío: `int(None)` reventaría con un error
  que no dice nada.
- **Solo primitivos.** Un DTO no contiene otro DTO ni una lista de DTOs.

### 2 · DTO de salida — `create_task_result_dto.py`

Igual, más un `to_dict()`, que es lo que el controller mete en `data`. **Ese
diccionario es el contrato con quien te llama**: si cambias una clave, rompes al
front.

Cada caso de uso tiene el suyo, aunque dos se parezcan. Compartirlos parece un
ahorro hasta el día en que uno necesita un campo que el otro no.

### 3 · Service — `create_task_service.py`

**La plantilla. Todos los services tienen esta forma exacta.**

```python
@final
class CreateTaskService:

    _create_task_dto: CreateTaskDto                            # 1
    _lists_reader: ListsReader
    _tasks_writer_sqlite_repository: TasksWriterSqliteRepository

    def __init__(self) -> None:                                # 2
        self._lists_reader = ListsReaderAdapter.get_instance()
        self._tasks_writer_sqlite_repository = TasksWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:                             # 3
        return cls()

    def __call__(self, create_task_dto: CreateTaskDto) -> CreateTaskResultDto:   # 4
        """Ejecuta el caso de uso.

        Returns:
            CreateTaskResultDto: la tarea creada.

        Raises:
            TasksException: 400 entrada inválida, 404 la lista no existe.
        """
        self._create_task_dto = create_task_dto                # 5
        self._fail_if_wrong_input()
        self.__fail_if_list_not_found()
        ...

    def _fail_if_wrong_input(self) -> None:                    # 6
        if not self._create_task_dto.title:
            TasksException.bad_request_custom("title es obligatorio")
```

1. **Colaboradores declarados arriba, con su tipo.** No es cosmético: es de donde
   `make check` saca el tipo para comprobar que los métodos que llamas existen.
   Un colaborador sin declarar es un colaborador que nadie verifica.

   **El orden importa**, y va de lo compartido a lo propio: primero lo de
   `shared` (componentes como `Logger`), luego lo del módulo (servicios de
   dominio, puertos, repositorios) y **el DTO el último**. El DTO no es un
   colaborador: es el estado de esta ejecución. Dejarlo al final agrupa arriba
   todo lo que se construye en `__init__`.
2. Se construyen con `get_instance()`. **Nunca `Clase()` directo.**
3. `get_instance()` es la única forma de crear el service.
4. `__call__` es el **único** método público.
5. Lo primero: guardar el DTO y validar.
6. `_fail_if_wrong_input` con un guion bajo, siempre con ese nombre.

**Un service NO lleva try/except.** Si algo falla, sube al controller.

Nombres de los atributos: el nombre de la clase en snake_case, **completo**.
`self._tasks_writer_sqlite_repository`, nunca `self._repo`. Es largo a propósito:
al leer una línea suelta sabes qué se está usando.

### 4 · Repositorio — `tasks_reader_sqlite_repository.py`

```python
@final
class TasksReaderSqliteRepository(AbstractSqliteRepository):

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_by_id(self, task_id: int) -> dict[str, Any] | None:
        cursor = self._get_connection().cursor()
        cursor.execute(
            """
            SELECT id, id_list, title, is_done
            FROM app_tasks
            WHERE id = ? AND delete_date IS NULL
            LIMIT 1
            """,
            (task_id,),
        )
        row = cursor.fetchone()
        return dict(row) if row else None
```

Cinco reglas, todas obligatorias:

1. **Cero try/except.** Un repositorio que captura y devuelve `None` convierte
   *"la base de datos está caída"* en *"no hay resultados"*.
2. **Cero reglas de negocio.** Lee y devuelve. Decidir es del service.
3. **Devuelve primitivos** (`dict`, `list`, `int`, `bool`).
4. **Siempre `?` para los valores**, nunca meterlos con f-string. Un valor
   interpolado en un SQL es como se crea una inyección SQL.
5. **Siempre `delete_date IS NULL`**: el borrado es lógico, y sin ese filtro ves
   filas borradas.

Lectura y escritura en clases separadas (`Reader` / `Writer`): así sabes de un
vistazo si lo que estás mirando puede modificar datos.

### 5 · Controller — `create_task_controller.py`

**Todos son iguales. Cuando todos hacen lo mismo, leer uno es leerlos todos.**

```python
def invoke(self, request_data: dict[str, Any]) -> dict[str, Any]:
    try:
        result_dto = self._create_task_service(CreateTaskDto.from_primitives(request_data))
        return {
            ResponseKeyEnum.STATUS: ResponseCodeEnum.CREATED,
            ResponseKeyEnum.DATA: result_dto.to_dict(),
        }
    except TasksException as tasks_exception:
        return {
            ResponseKeyEnum.STATUS: tasks_exception.code,
            ResponseKeyEnum.ERROR: tasks_exception.message,
        }
    except Exception as exception:
        self._logger.log_exception(exception, "CreateTaskController.invoke")
        return {
            ResponseKeyEnum.STATUS: ResponseCodeEnum.INTERNAL_SERVER_ERROR,
            ResponseKeyEnum.ERROR: ResponseMessageEnum.UNEXPECTED_ERROR,
        }
```

Dos capturas, y son distintas:

- **`except TasksException`** — error **esperado**. El service decidió que esto
  podía pasar. Su código y su mensaje van tal cual al cliente.
- **`except Exception`** — error **inesperado**. Va al log con su traza completa,
  y al cliente le llega un mensaje genérico. **Nunca** se devuelve el texto de la
  excepción: puede llevar rutas del servidor o trozos de SQL.

Si te ves escribiendo un `if` en un controller que no sea uno de estos dos
`except`, esa decisión es del service.

---

## La excepción del módulo

**Una por módulo**, no una por tipo de error. El código HTTP ya distingue el tipo.

```python
@classmethod
def bad_request_custom(cls, message: str) -> NoReturn:
    raise cls(message, ResponseCodeEnum.BAD_REQUEST)
```

Están tipadas como `NoReturn` porque **lanzan**. Eso permite escribir la
validación como una lista de guardias, y además le dice a las herramientas que el
código no continúa después.

| Método | Código | Cuándo |
|---|---|---|
| `bad_request_custom` | 400 | falta un campo, formato inválido |
| `not_found_custom` | 404 | lo que pide no existe |
| `conflict_custom` | 409 | existe, pero choca con una regla |

## Los enums

**Ninguna cadena ni número suelto en el código.** Todos los literales van a un
enum de `domain/enums/`. Dos formas, y cada una para lo suyo:

```python
@final
class TaskFieldEnum:          # bolsa de constantes: se usan como claves
    TITLE = "title"

class TaskDoneEnum(IntEnum):  # valores con identidad: se comparan, se recorren
    PENDING = 0
    DONE = 1
```

**Usa SIEMPRE `.value` al leer el valor de un enum**, y anota el tipo donde lo
guardes:

```python
# Sale hacia fuera
request.headers.get(AuthEnum.APIKEY_HEADER.value, "")

# Se guarda: la anotación evita que el editor infiera mal el tipo de `.value`
app_version: str = AppVersionEnum.CURRENT.value

# También aquí, aunque IntEnum ya sea un int
cursor.execute(sql, (TaskDoneEnum.PENDING.value, task_id))
```

Con `(str, Enum)` o `IntEnum` el valor y el miembro son intercambiables en tiempo
de ejecución, así que **omitir `.value` funcionaría**. La regla existe por otra
cosa: los analizadores de tipos resuelven mal `Enum.value` y lo infieren como una
función en vez de como el valor. Una sola regla uniforme —siempre `.value`, y el
tipo anotado donde se guarde— deja el proyecto sin avisos falsos.

La excepción es comparar **miembro con miembro** (`if status == MigrationStatusEnum.APPLIED`)
o devolver el miembro: ahí no estás leyendo el primitivo.

## Añadir un endpoint

Un solo sitio: `src/core/routes/routes.py`.

```python
"POST /api/tasks": lambda body: CreateTaskController.get_instance().invoke(body),
"GET /api/tasks/{id}": lambda body: GetTaskController.get_instance().invoke(
    {**body, "task_id": body.get("id")},
),
```

- El valor es una **lambda**, no un controller ya construido: si no, se
  construiría al importar, antes de que exista la base de datos.
- `{id}` se renombra aquí a la clave que espera el DTO. Es la única traducción de
  este fichero, y es lo que permite cambiar la URL sin tocar el caso de uso.

## Estilo

- Línea de 120. Comillas dobles. Lo arregla `make format`.
- **Tipos en todo**: argumentos y retorno. `mypy --strict` no perdona.
- Métodos que devuelven algo: `get_`, `has_`, `is_`, `can_`, `should_`.
  **Prohibidos** `prepare_`, `build_`, `make_`, `process_`, `parse_`, `handle_`,
  `manage_`: no dicen qué hacen.
- Métodos que hacen algo: el verbo concreto (`create`, `send`, `apply`).
- `_metodo` protegido (parte de la plantilla), `__metodo` privado (de este caso de
  uso).
- Los comentarios explican **por qué**, no qué. El qué ya lo dice el código.
