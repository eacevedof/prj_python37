# todo-app — ejemplar de referencia del kit vibe-coding

Un CRUD completo de listas y tareas. **No es una aplicación que haya que usar: es
el modelo del que se copia** para montar un PoC.

Cada regla de `../vibe-specs/` tiene aquí su ejemplo real y comentado.

## Arrancar

```bash
make venv-install                       # una vez
cp backend_web/.env.example backend_web/.env
make local                              # API en http://127.0.0.1:6001
```

En otra terminal, el front:

```bash
make front-install                      # una vez
make front-local                        # http://localhost:6002
```

### O sin instalar nada: un contenedor efímero

Si solo quieres **verlo funcionando**, esto no pide `.env`, ni venv, ni npm, y no
deja nada en tu disco:

```bash
make up-ephemeral                       # http://localhost:6004
```

Ctrl-C y desaparece: ni contenedor, ni base de datos, ni logs. Cada arranque
empieza de cero.

Y para verlo **con tu configuración y tus datos**, tal como se despliega:

```bash
make up-deploy-local                    # http://localhost:6003
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
curl -H "X-Api-Key: change-this-in-production-20260901" localhost:6001/api/lists
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
make local             arranca la API en local, con recarga
make check             ruff + mypy + tests
make format            arregla el formato
make test              solo los tests
make db-fresh          borra la base de datos local
make front-local       arranca el front en local
make front-build       compila el front comprobando tipos
make up-local          la API en un contenedor
make up-ephemeral      todo junto en un contenedor EFIMERO (no deja nada)
make up-deploy-local   la imagen de despliegue, con tu .env y tus datos
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
