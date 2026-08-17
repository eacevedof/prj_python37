# 10 · La arquitectura, en una página

El código está partido en tres capas. No es por gusto: es lo que hace que se
pueda cambiar una parte sin romper las otras.

```
   ┌──────────────────────────────────────────────────────┐
   │  INFRASTRUCTURE   lo que toca el mundo exterior       │
   │                   controllers · repositories ·        │
   │                   adapters · runners                  │
   └───────────────────────────┬──────────────────────────┘
                               │ puede usar
                               ▼
   ┌──────────────────────────────────────────────────────┐
   │  APPLICATION      los casos de uso: QUÉ hace la app   │
   │                   un caso de uso = una carpeta        │
   └───────────────────────────┬──────────────────────────┘
                               │ puede usar
                               ▼
   ┌──────────────────────────────────────────────────────┐
   │  DOMAIN           las reglas y los conceptos          │
   │                   enums · exceptions · ports ·        │
   │                   services · entities                 │
   │                   NO USA NADA DE ARRIBA               │
   └──────────────────────────────────────────────────────┘
```

**La flecha va en un solo sentido.** Eso es toda la arquitectura. Lo demás son
consecuencias.

---

## Qué va en cada capa

### Domain — las reglas

Lo que sería verdad aunque la aplicación no fuera una API, ni usara SQLite, ni
existiera Python.

- **enums** — las constantes con nombre. El título no puede pasar de 200
  caracteres; `is_done` es 0 o 1.
- **exceptions** — los errores que tu negocio sabe que pueden pasar. Una por
  módulo.
- **ports** — lo que este módulo necesita de otro, descrito como una lista de
  métodos. Ver abajo.
- **services** — reglas que comparten varios casos de uso. Sin entrada ni salida
  al exterior.
- **entities** — la forma de un dato.

No hay base de datos aquí. No hay HTTP. Ni siquiera se importa FastAPI.

### Application — los casos de uso

**Una carpeta por caso de uso**, y dentro siempre tres ficheros:

```
create_task/
├── create_task_dto.py           lo que entra
├── create_task_result_dto.py    lo que sale
└── create_task_service.py       lo que se hace
```

Un caso de uso es una cosa que alguien quiere hacer con la aplicación: crear una
tarea, listar documentos, lanzar un análisis. Si no sabes cómo llamar a una
carpeta, es señal de que ahí dentro hay dos casos de uso.

El service **no captura errores** y **no sabe de HTTP**. Recibe un DTO, decide, y
devuelve otro DTO.

### Infrastructure — el mundo exterior

Todo lo que tiene que ver con *cómo* llegan y salen los datos.

- **controllers** — el borde HTTP. Traducen a códigos de respuesta. **El único
  sitio que captura errores.**
- **repositories** — el acceso a datos: base de datos, ficheros, otras APIs.
- **adapters** — la puerta hacia otro módulo (ver abajo).
- **runners** — trabajo por lotes sin nadie esperando delante.

---

## Un recorrido completo

Qué pasa cuando alguien crea una tarea. Sigue el hilo:

```
POST /api/tasks  {"id_list": 3, "title": "Comprar leche"}
  │
  ▼
public/main.py                      1. ¿trae la credencial? si no, 401
  │                                 2. junta cuerpo + query + URL en un dict
  ▼
routes.py                           3. esta ruta va a CreateTaskController
  │
  ▼
create_task_controller.py           4. dict -> CreateTaskDto
  │                                    (y aquí está el único try/except)
  ▼
create_task_service.py              5. ¿el título está vacío? -> 400
  │                                 6. ¿la fecha tiene buen formato? -> 400
  │                                 7. ¿existe la lista 3? -> 404
  │                                    ...esto se pregunta por un PUERTO
  ▼
tasks_writer_sqlite_repository.py   8. INSERT, y devuelve el id nuevo
  │
  ▼
create_task_service.py              9. arma el CreateTaskResultDto
  │
  ▼
create_task_controller.py          10. {"status": 201, "data": {...}}
  │
  ▼
public/main.py                     11. lo convierte en respuesta HTTP 201
```

Cada paso hace una cosa. Si algo falla, sabes en qué paso mirar.

---

## Puertos y adaptadores: cómo hablan dos módulos

Es lo único de esta arquitectura que no es obvio, así que va con detalle. Es
también lo que más falta hace en cuanto un PoC tiene dos entidades.

**El problema.** Al crear una tarea hay que comprobar que la lista existe. Pero
las listas son de otro módulo.

**La solución fácil, que es la mala:** que `tasks_mod` importe el repositorio de
`lists_mod`. A partir de ahí, tareas conoce el nombre de la tabla de listas, sabe
que el borrado es lógico, y sabe cómo se consultan. Ya no se pueden tocar por
separado.

**Lo que se hace aquí:** tareas declara lo ÚNICO que necesita.

```
tasks_mod/domain/ports/lists_reader.py          ← "necesito preguntar si existe una lista"

    class ListsReader(Protocol):
        def has_list(self, list_id: int) -> bool: ...


lists_mod/infrastructure/adapters/lists_reader_adapter.py   ← "yo sé responder a eso"

    class ListsReaderAdapter:
        def has_list(self, list_id: int) -> bool:
            return self._lists_reader_sqlite_repository.get_by_id(list_id) is not None
```

Y en el caso de uso:

```python
_lists_reader: ListsReader                              # el tipo es el PUERTO

def __init__(self) -> None:
    self._lists_reader = ListsReaderAdapter.get_instance()   # única línea que lo menciona
```

**Las cinco reglas de un puerto:**

1. Lo declara **quien lo necesita**, no quien lo cumple.
2. Va en `domain/ports/`, sin sufijo `_port` y sin `@final`.
3. Entran y salen **primitivos** (un número, un booleano, un texto).
4. **Nunca lanza excepciones.** Si lanzara la excepción de su módulo, cruzaría a
   un controller que no la captura y acabaría siendo un error 500.
5. El adaptador envuelve el **repositorio**, no un caso de uso. Así no se forman
   ciclos: `lists → adaptador de tasks → repositorio de tasks`, y ahí acaba.

En el ejemplar hay dos puertos, uno en cada sentido, para que se vea que los
módulos pueden necesitarse mutuamente sin acoplarse:

| Quién lo necesita | Puerto | Quién lo cumple |
|---|---|---|
| tasks | `ListsReader.has_list()` | `lists_mod/.../lists_reader_adapter.py` |
| lists | `TasksCounter.get_open_tasks_count()` | `tasks_mod/.../tasks_counter_adapter.py` |

---

## Las cuatro reglas que lo sostienen todo

Están medidas por `make check`. No son sugerencias.

1. **El dominio no importa nada de las otras capas.**
2. **Un caso de uso no importa FastAPI ni sqlite3.**
3. **Un módulo llega a otro solo por su carpeta `adapters/`.**
4. **Solo capturan errores: los controllers, los runners, los servicios de
   dominio y el front controller.** Nadie más.

El porqué de cada una está en [`50-guardarrailes.md`](50-guardarrailes.md).
