# todo-app

Ejemplar de referencia del kit `vibe-coding`: un CRUD de listas y tareas que
cumple la normativa al pie de la letra. **Python 3.12 + FastAPI + SQLite** ·
**Vue 3 + Vite + TypeScript + Pinia** · DDD por capas.

## Antes de tocar nada

**La normativa está en `../vibe-specs/`** y es de obligado cumplimiento. Empieza
por `../vibe-specs/README.md`.

Este repositorio es el ejemplar del que se copia, así que **cualquier cambio aquí
cambia el patrón de todos los PoC que vengan después**. Antes de modificar la
forma de algo (nombres, capas, estructura), pregunta.

## Reglas

1. `make check` tiene que quedar en verde. Es la definición de terminado.
2. No desactives un test de convención sin decirlo y explicar por qué.
3. Antes de crear un fichero `.md`, pregunta.
4. Git lo gestiona el usuario: nunca `commit` ni `push` por iniciativa propia. Al
   cerrar un bloque, ofrece `make gitpush m="..."`.

## Documentación del proyecto (Obsidian)

Estado y evolución del kit: `projects/vibe-coding/vibe-coding.md` en el vault.
Ahí va **qué se ha decidido y por qué**; la normativa ejecutable va en
`vibe-specs/`, que es lo que viaja con cada copia.
