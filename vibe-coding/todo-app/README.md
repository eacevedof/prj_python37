# todo-app — ejemplar de referencia del kit vibe-coding

Un CRUD completo de listas y tareas. **No es una aplicación que haya que usar: es
el modelo del que se copia** para montar un PoC.

Cada regla de `../vibe-specs/` tiene aquí su ejemplo real y comentado.

## Arrancar

```bash
make venv-install                       # una vez
cp backend_web/.env.example backend_web/.env
make dev                                # API en http://127.0.0.1:8000
```

En otra terminal, el front:

```bash
make front-install                      # una vez
make front-dev                          # http://localhost:5173
```

Y para ver el conjunto tal como se despliega — **un solo contenedor sirviendo el
front y la API**:

```bash
make up-prod-local                      # http://localhost:8080
```

## Comprobar que está bien

```bash
make check
```

ruff + mypy en modo estricto + 50 tests. **Si está verde, el patrón se respetó.**
Lo que mide cada cosa: `../vibe-specs/50-guardarrailes.md`.

## Qué hace

| | |
|---|---|
| Listas | crear, listar, modificar, borrar. Nombre único entre las vivas |
| Tareas | crear, listar, modificar, marcar hecha, borrar. Pertenecen a una lista |
| Reglas | una tarea no puede existir sin lista · no se puede borrar una lista con tareas sin terminar |
| Auth | `X-Api-Key` contra el `.env`. Sin usuarios |
| Datos | SQLite en `backend_web/storage/database/`, borrado lógico |

## Endpoints

```
GET    /health-check                sin credencial
GET    /api/lists                   ?name_contains=
POST   /api/lists
GET    /api/lists/{id}
PUT    /api/lists/{id}
DELETE /api/lists/{id}
GET    /api/lists/{id}/tasks
GET    /api/tasks                   ?id_list=&is_done=
POST   /api/tasks
GET    /api/tasks/{id}
PUT    /api/tasks/{id}
PATCH  /api/tasks/{id}/done
DELETE /api/tasks/{id}
```

```bash
curl -H "X-Api-Key: change-me-local-only" localhost:8000/api/lists
```

## Los ficheros que hay que leer

Si vas a montar un PoC, estos seis explican el patrón entero:

| Fichero | Qué enseña |
|---|---|
| `backend_web/public/main.py` | Arranque, autenticación, cómo se sirve el front |
| `backend_web/src/core/routes/routes.py` | Todos los endpoints, en un sitio |
| `.../lists_mod/application/create_list/create_list_service.py` | **La plantilla de un caso de uso** |
| `.../lists_mod/infrastructure/controllers/create_list_controller.py` | **La plantilla de un controller** |
| `.../tasks_mod/domain/ports/lists_reader.py` | Cómo hablan dos módulos sin acoplarse |
| `.../tasks_mod/application/create_task/create_task_service.py` | El puerto en uso |

Y del front: `.../tasks_mod/infrastructure/stores/useTasksStore.ts`, que es el
equivalente del controller.

## Comandos

```
make help              lista todos los targets
make dev               API con recarga automática
make check             ruff + mypy + tests
make format            arregla el formato
make test              solo los tests
make db-fresh          borra la base de datos local
make front-dev         front en modo desarrollo
make front-build       compila el front comprobando tipos
make up-prod-local     la imagen real: front + API en un contenedor
```

## Avisos

Esto es un **ejemplar de PoC**, y como tal:

- No hay usuarios ni permisos. La apikey autoriza a usar el servicio, no dice
  quién eres.
- La credencial se puede leer desde el navegador. Frena rastreadores automáticos,
  no a una persona.
- SQLite es un fichero: no aguanta varios servidores ni mucha escritura a la vez.

Nada de eso es un problema para un PoC. Todo eso es un problema si pasa a
producción tal cual — está desarrollado en `../vibe-specs/60-checklist-poc.md`.
