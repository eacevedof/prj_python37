# 90 · Prompts para Claude

Cópialos y rellena lo que está entre `<...>`. Están escritos para que Claude no
tenga que adivinar nada: cada uno ya le dice dónde está la normativa y de dónde
copiar.

> **Antes de nada**, abre Claude **en la carpeta de tu PoC**. El `CLAUDE.md` de
> ahí ya le dice que lea `vibe-specs/`. Si lo abres en otro sitio, no lo lee.

---

## 1 · Arrancar un PoC

```
Voy a montar un PoC a partir de <URL del repo / nombre de la herramienta>.

Lo que tiene que poder hacer una persona con esto:
- <acción 1>
- <acción 2>
- <acción 3>

Datos que hay que guardar:
- <entidad 1>: <campos>
- <entidad 2>: <campos>

Antes de escribir nada:
1. Lee vibe-specs/ entero (empieza por README.md).
2. Lee el ejemplar todo-app: create_task_service.py, create_list_controller.py,
   los dos puertos y sus adaptadores.
3. Dime qué módulos y qué casos de uso propones, y ESPERA a que te confirme.

No escribas código hasta que te lo confirme.
```

**Por qué esperar:** rehacer la estructura después de treinta ficheros cuesta
mucho más que discutirla antes. Y casi siempre la primera propuesta tiene un
módulo de más o de menos.

---

## 2 · Añadir un módulo

```
Añade el módulo <nombre>_mod siguiendo vibe-specs/20-backend-python.md y copiando
la forma de tasks_mod del ejemplar.

Entidad: <nombre>
Campos: <campo>: <tipo> (<obligatorio/opcional>), ...

Casos de uso: search_<plural>, get_<singular>, create_<singular>,
update_<singular>, delete_<singular>

Reglas de negocio:
- <regla 1>
- <regla 2>

Incluye:
- la migración .sql, idempotente y con una marca de tiempo POSTERIOR a todas las
  que ya hay en la carpeta
- las rutas en src/core/routes/routes.py
- los tests de integración en tests/integration/, siguiendo vibe-specs/25-tests.md

Al terminar, ejecuta `make check` y arregla lo que salga.
```

---

## 3 · Relacionar dos módulos

```
En <modulo_a>_mod necesito <lo que necesitas: comprobar que existe X / contar Y>,
y ese dato vive en <modulo_b>_mod.

Hazlo con el patrón puerto/adaptador, como ListsReader/ListsReaderAdapter en el
ejemplar:
- el puerto en <modulo_a>_mod/domain/ports/
- el adaptador en <modulo_b>_mod/infrastructure/adapters/
- el adaptador envuelve el REPOSITORIO, no un caso de uso
- entra y sale en primitivos, y nunca lanza excepciones

Al terminar, `make check`: el test de dependencias entre capas tiene que pasar.
```

---

## 4 · Enchufar una librería o herramienta

```
Necesito usar <librería / herramienta / API> para <qué hace>.

Sigue vibe-specs/70-envolver-un-repo.md:
- si trae o guarda datos, va en un *_<origen>_repository.py
- si calcula o transforma, va en shared/infrastructure/components/
- NINGÚN caso de uso puede importarla directamente
- sin try/except en el repositorio

Añade la dependencia a backend_web/requirements.txt con un comentario diciendo
para qué es, y si necesita algo del sistema operativo, al Dockerfile-deploy.
```

---

## 4b · El repo que hay que envolver NO es de Python

```
El repo que hay que envolver es <URL> y está escrito en <Node / Go / ...>.

Lee vibe-specs/21-backend-otros-lenguajes.md ENTERO antes de proponer nada.

Dime primero cuál de las dos opciones aplica y por qué:
  (1) levantarlo al lado y hablarle por HTTP desde un backend de Python normal
  (2) escribir el backend en ese lenguaje

Si es la (2), dime también qué stack concreto propones (servidor, driver de base
de datos, formateador, linter, tests) y cómo quedaría `make check`. ESPERA a que
te lo confirme antes de escribir código: esa decisión se queda para todos los PoC
siguientes.
```

**Por qué preguntar**: la opción 1 resuelve la mayoría de los casos y te deja el
kit entero. La 2 es bastante más trabajo y hoy no tiene tests de convención.

---

## 5 · El front de un módulo

```
Añade al front las pantallas de <nombre>_mod, copiando la forma de tasks_mod en
frontend_web y siguiendo vibe-specs/30-frontend-vue.md.

Pantallas:
- <descripción de la pantalla 1>
- <descripción de la pantalla 2>

Recuerda: el store es el único sitio con try/catch, las vistas van en
infrastructure/views/ y un store no importa otro store.

Al terminar, `make front-build`.
```

---

## 6 · Cuando `make check` está en rojo y no lo entiendes

```
`make check` da este error:

<pega el mensaje ENTERO, incluida la parte de POR QUE>

Explícame en una frase qué regla se ha roto y arréglalo siguiendo la normativa.
No desactives el test ni añadas excepciones sin decírmelo antes.
```

**La última frase importa.** Sin ella, la salida fácil es quitar la comprobación,
y eso quita la medida, no el problema.

---

## 7 · Repaso antes de entregar

```
Repasa el PoC entero contra vibe-specs/60-checklist-poc.md y dime punto por punto
qué cumple y qué no. No arregles nada todavía: primero la lista.
```

---

## Cosas que conviene decirle siempre

- **"y ejecuta `make check`"** al final de cualquier petición de código. Si no se
  lo dices, puede no hacerlo.
- **"copiando la forma de `<fichero del ejemplar>`"**. Es lo que más ayuda: un
  ejemplo concreto vale más que tres párrafos de normativa.
- **"no toques nada más"** si estás pidiendo un cambio pequeño.

## Cosas que conviene NO decirle

- **"hazlo rápido"** o **"simplifica"** → suele traducirse en saltarse el patrón,
  que es justo lo que este kit existe para evitar.
- **"da igual la estructura, que funcione"** → eso es exactamente el problema que
  estamos resolviendo.
