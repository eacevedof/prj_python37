# 40 · Base de datos

SQLite. Es un fichero, no un servidor: no hay nada que instalar ni que levantar,
y para un PoC eso vale más que cualquier otra cosa.

El fichero vive en `backend_web/storage/database/todo_app.db` y **no se sube a
git**.

---

## Las migraciones

Un cambio en la base de datos es **un fichero `.sql` nuevo**. Nunca se edita uno
ya aplicado, y nunca se toca la base a mano.

```
backend_web/database/migrations/
├── 20260818090000-create-migrations-table.sql   ← del sistema, no la borres
├── 20260818090500-create-app-lists.sql
└── 20260818091000-create-app-tasks.sql
```

**Se aplican solas al arrancar la aplicación.** No hay comando de migrar y no hace
falta acordarse de nada: desplegar es levantar la app.

```
[migraciones] aplicadas=0 saltadas=3 fallidas=0
```

### El nombre

```
YYYYMMDDHHMMSS-descripcion-en-minusculas.sql
20260818091000-create-app-tasks.sql
```

La marca de tiempo del principio no es decoración: **es lo que ordena las
migraciones**. Se aplican en orden alfabético, y como la fecha va de mayor a menor
unidad, el orden alfabético coincide con el cronológico.

Si dos personas crean una el mismo día, la hora las desempata. Si aun así
coinciden, cambia un minuto: **nunca dos ficheros con el mismo prefijo**.

> ⚠️ **La marca de tiempo tiene que ordenar DESPUÉS de todas las que ya existen**,
> aunque para eso tengas que poner una fecha futura. No es la fecha de hoy: es la
> posición en la cola. Mira el último fichero de la carpeta y pon algo mayor.
>
> Si pones una anterior, tu tabla intentaría crearse antes que aquello de lo que
> depende, y en una base nueva reventaría.

### Tienen que poder ejecutarse dos veces

Esto es obligatorio, no un consejo. El arranque las recorre siempre, y hay una
ventana mínima en la que una migración puede aplicarse sin quedar registrada. Si
no es repetible, el siguiente arranque revienta.

```sql
CREATE TABLE IF NOT EXISTS app_tasks (...);
CREATE INDEX IF NOT EXISTS app_tasks_list_idx ON app_tasks (...);

-- Para insertar datos:
INSERT INTO app_lists (name, color, position)
SELECT 'Entrada', '#4F8EF7', 0
WHERE NOT EXISTS (SELECT 1 FROM app_lists WHERE lower(name) = 'entrada');
```

### Empezar de cero

```bash
make db-fresh      # borra el fichero
make local           # el arranque lo reconstruye entero
```

No hay ninguna opción dentro de la aplicación para borrar la base de datos, y es
a propósito: código destructivo protegido por un flag que alguien puede activar en
producción no compensa ahorrarse un `rm`.

---

## Cómo se escribe una tabla

```sql
CREATE TABLE IF NOT EXISTS app_tasks (
    id          INTEGER PRIMARY KEY,
    id_list     INTEGER NOT NULL REFERENCES app_lists(id),
    title       TEXT    NOT NULL,
    is_done     INTEGER NOT NULL DEFAULT 0 CHECK (is_done IN (0, 1)),
    due_date    TEXT    DEFAULT NULL,
    insert_date TEXT    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date TEXT    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    delete_date TEXT    DEFAULT NULL
);
```

| Convención | Por qué |
|---|---|
| Prefijo `app_` | Distingue tus tablas de las del sistema (`migrations`) |
| `INTEGER PRIMARY KEY`, sin `AUTOINCREMENT` | En SQLite ya es autoincremental; `AUTOINCREMENT` solo añade coste |
| Nombres en inglés, minúsculas, con guion bajo | Lo mismo que los campos del código |
| Las tres fechas de auditoría | Ver abajo |

### Las tres columnas de auditoría

- **`insert_date`** — para ordenar "lo más reciente primero".
- **`update_date`** — para mostrar "modificado hace X".
- **`delete_date`** — **borrado lógico**, y es la importante.

**Aquí no se borra nada de verdad.** Borrar es poner una fecha en `delete_date`.
Eso permite borrar una lista sin romper la clave ajena de sus tareas, no perder
historial, y que "deshacer" sea un `UPDATE`.

**Consecuencia que se olvida siempre:** toda consulta de lectura tiene que llevar
`WHERE delete_date IS NULL`. Si se te olvida, verás filas borradas.

---

## Cosas de SQLite que sorprenden

### No hay BOOLEAN

Se usa `INTEGER` con 0 y 1, y un `CHECK` para que no entre otra cosa:

```sql
is_done INTEGER NOT NULL DEFAULT 0 CHECK (is_done IN (0, 1))
```

En el código, ese 0 y ese 1 van en un enum (`TaskDoneEnum`). **Dentro es un
número** porque así lo guarda la base; **hacia fuera es un booleano** porque es lo
que espera un cliente JSON.

Dónde se hace la conversión, exactamente:

| Dirección | Dónde | Ejemplo del ejemplar |
|---|---|---|
| 0/1 → `true`/`false`, un elemento | en el **ResultDto** | `GetTaskResultDto.from_primitives` |
| 0/1 → `true`/`false`, una lista | en el **service** | `SearchTasksService.__get_item` |
| `true`/`false` → 0/1, al escribir | en el **service** | `SetTaskDoneService.__call__` |

La lista y la escritura no pueden hacerlo en el DTO porque el ResultDto de una
búsqueda transporta `list[dict]`, no campos sueltos. **Nunca lo hace el
repositorio**: un repositorio devuelve lo que hay en la tabla, sin interpretar.

### No hay DATE

Las fechas se guardan como texto en formato ISO (`2026-08-25`). Ese formato ordena
bien alfabéticamente, que es justo por lo que se elige.

### Las claves ajenas vienen APAGADAS

Es la trampa clásica. Un `REFERENCES app_lists(id)` **no hace nada** a menos que
la conexión traiga `PRAGMA foreign_keys = ON`.

Ya está puesto en `src/core/config/database.py`. No lo quites.

Y aun así, la regla del negocio se comprueba **también** en el caso de uso (mira
`CreateTaskService`). Hacen falta las dos: la del caso de uso da un 404 con un
mensaje que se entiende; la de la base protege por si alguien escribe saltándose
la aplicación.

### Los ficheros `-wal` y `-shm`

Aparecen al lado del `.db`. Son normales: SQLite está en modo WAL, que permite
leer mientras se escribe. Se ignoran en git junto con el `.db`.

---

## Índices

Uno por cada columna por la que filtres a menudo, y uno compuesto para la consulta
principal:

```sql
-- "las tareas vivas de esta lista, ordenadas": sus tres columnas juntas
CREATE INDEX IF NOT EXISTS app_tasks_list_idx ON app_tasks (id_list, delete_date, position);
```

Y para "este nombre no puede repetirse", un índice único **parcial**:

```sql
CREATE UNIQUE INDEX IF NOT EXISTS app_lists_name_uq
    ON app_lists (lower(name)) WHERE delete_date IS NULL;
```

El `WHERE` del final es lo que permite reutilizar el nombre de una lista que
borraste. Sin él, un nombre quedaría ocupado para siempre.

---

## Cuando SQLite deja de valer

Para un PoC vale casi siempre. Deja de valer cuando:

- **Escriben varios procesos a la vez** de forma constante. SQLite serializa las
  escrituras: van de una en una.
- **La base pasa de unos pocos GB.**
- **Hace falta que dos servidores la compartan.** Un fichero no se comparte por
  red de forma fiable — y sobre NFS o carpeta compartida de Windows el bloqueo de
  SQLite **no funciona**: no lo hagas.

Si el PoC pasa a producción y se da alguno de esos casos, lo que hay que cambiar
son los `*_sqlite_repository.py` por `*_postgres_repository.py`. Los casos de uso
no se tocan. Para eso está la arquitectura.
