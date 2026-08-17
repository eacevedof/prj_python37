# 00 · Cómo montar un PoC, paso a paso

De "me han pedido un PoC" a "negocio lo está probando". Sigue el orden.

---

## Paso 0 · Entender qué te han pedido

Antes de tocar nada, ten claras estas cuatro cosas. Si alguna no la sabes,
pregúntala: es más barato preguntar ahora que rehacerlo luego.

| Pregunta | Por qué importa |
|---|---|
| ¿Qué herramienta o repo hay que envolver? | Define qué dependencias entran y qué puede fallar |
| ¿Qué tiene que poder hacer una persona con esto? | Son los casos de uso, y de ahí sale la estructura |
| ¿Qué datos hay que guardar? | Son las tablas |
| ¿Quién lo va a probar y desde dónde? | Decide si hace falta desplegarlo o basta con local |

Escribe las respuestas en el `README.md` de tu PoC. Te las va a preguntar
cualquiera que lo mire, incluido tú dentro de dos semanas.

---

## Paso 1 · Copiar el ejemplar

```bash
cp -r vibe-coding/todo-app vibe-coding/mi-poc
cd vibe-coding/mi-poc
rm -rf .venv frontend_web/node_modules frontend_web/dist backend_web/storage/database/*.db*
```

**No empieces de cero.** Todo lo que hay en `todo-app` que no sean los dos módulos
de ejemplo es infraestructura que necesitas igual: el arranque, la autenticación,
el migrador, los guardarraíles, Docker. Reescribirlo es perder una tarde para
acabar con algo peor.

## Paso 2 · Renombrar

`todo-app` aparece en estos sitios, y en ninguno más:

```bash
grep -rl "todo-app\|todo_app" --exclude-dir=.venv --exclude-dir=node_modules --exclude-dir=dist .
```

A día de hoy son:

- `makefile` — el mensaje del target `gitpush`
- `backend_web/.env.example` y tu `.env` — `DB_PATH=storage/database/todo_app.db`
- `backend_web/public/main.py` — `FastAPI(title="todo-app")`
- `frontend_web/package.json` — el campo `name`
- `frontend_web/index.html` — el `<title>`
- `docker/*.yml` — los comentarios de ejemplo
- `CLAUDE.md` y `README.md`

## Paso 3 · Dejarlo arrancando, antes de tocar nada

```bash
make venv-install
cp backend_web/.env.example backend_web/.env
make local
```

En otra terminal:

```bash
curl localhost:8000/health-check
```

Tiene que responder `{"status":"ok",...}`. **No sigas hasta que responda.** Si
algo está mal, es mucho más fácil arreglarlo ahora, cuando lo único que hay es el
esqueleto.

Y comprueba que partes de verde:

```bash
make check
```

## Paso 4 · Quitar los módulos de ejemplo

`lists_mod` y `tasks_mod` son un ejemplo de to-do list. Tu PoC va de otra cosa.

```bash
rm -rf backend_web/src/modules/lists_mod backend_web/src/modules/tasks_mod
rm -rf backend_web/tests/integration/test_lists_crud.py \
       backend_web/tests/integration/test_tasks_crud.py \
       backend_web/tests/integration/test_lists_tasks_relation.py
rm -rf backend_web/database/migrations/20260818090500-create-app-lists.sql \
       backend_web/database/migrations/20260818091000-create-app-tasks.sql \
       backend_web/database/migrations/20260818091500-initial-data.sql
rm -rf frontend_web/src/modules/lists_mod frontend_web/src/modules/tasks_mod
```

Deja **la primera migración** (`...-create-migrations-table.sql`): esa es del
sistema, no del ejemplo.

Luego vacía la tabla de rutas de `backend_web/src/core/routes/routes.py` (quita
los imports y deja `BY_PATH = {}`) y la de
`frontend_web/src/core/routes/Routes.ts`.

> **Antes de borrarlos, léelos.** Sobre todo `create_task_service.py`,
> `create_list_controller.py` y los dos puertos. Son quince minutos y te ahorran
> tener que volver aquí a preguntar cómo se hacía cada cosa.

Vuelve a lanzar `make check`. Tiene que seguir verde con los módulos fuera.

## Paso 5 · Pedirle a Claude tus módulos

Ahora sí. Usa un prompt de [`90-prompts.md`](90-prompts.md), que ya incluye lo que
Claude necesita saber.

Un módulo por entidad. Si tu PoC va de documentos y de etiquetas, son
`documents_mod` y `tags_mod`, no un `main_mod` con todo dentro.

## Paso 6 · `make check` en verde

```bash
make check
```

Si sale algo en rojo, el mensaje te dice qué regla se ha roto y cómo arreglarlo.
Si no lo entiendes, búscalo en [`50-guardarrailes.md`](50-guardarrailes.md).

**No sigas con el rojo puesto.** Un fallo de convención al principio son dos
minutos; treinta ficheros después, una tarde.

## Paso 7 · El front

```bash
make front-install
make front-local      # http://localhost:5173
```

Con `make local` corriendo en otra terminal. El front habla con la API a través del
proxy de Vite, así que las dos cosas parecen estar en el mismo sitio — igual que
estarán cuando se despliegue.

## Paso 8 · Verlo entero como se va a desplegar

```bash
make up-deploy-local      # http://localhost:8080
```

Esto construye la imagen de verdad: compila el front y lo sirve junto con la API
en **un solo contenedor**. Es exactamente lo que se despliega. Si aquí funciona,
en el servidor funciona.

## Paso 9 · La lista de comprobación

Antes de enseñárselo a nadie: [`60-checklist-poc.md`](60-checklist-poc.md).

---

## Los cuatro errores que se repiten

1. **Empezar de cero "porque el ejemplar tiene cosas que no necesito".** Lo que
   sobra son dos módulos. Lo demás lo necesitas.
2. **Dejar `make check` en rojo "para arreglarlo luego".** Luego son treinta
   ficheros con el mismo fallo repetido.
3. **Meter todo en un módulo.** Un módulo por entidad. Si dudas, mira si las dos
   cosas se borrarían juntas: si no, son dos módulos.
4. **Copiar el `.env` con la credencial de ejemplo a un servidor.** `API_KEY` se
   cambia siempre antes de desplegar.
