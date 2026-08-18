# vibe-coding — kit para montar PoC mantenibles

Carpeta de trabajo para PoC. El objetivo de este kit es que todos los PoC salgan
con la **misma estructura**, para que el equipo de desarrollo pueda mantenerlos
cuando alguno pase a producción.

## LEE ESTO ANTES DE ESCRIBIR CÓDIGO

**`vibe-specs/` es la normativa de este repositorio, y es de obligado
cumplimiento.** Empieza por `vibe-specs/vibe-specs.md`, que es el índice.

No propongas otra arquitectura, otra forma de nombrar los ficheros ni otra
organización de carpetas: ya están decididas y hay tests que las comprueban.

## Las tres piezas

| | |
|---|---|
| `vibe-specs/` | La normativa. Fuente de verdad |
| `todo-app/` | El **ejemplar**: un CRUD completo que la cumple. De aquí se copia |
| `<mi-poc>/` | El PoC en el que se esté trabajando |

## Stack

Python 3.12 + FastAPI + SQLite · Vue 3 + Vite + TypeScript + Pinia · DDD por
capas · un contenedor Docker que sirve el front y la API juntos.

## Reglas de trabajo

1. **Antes de escribir código nuevo**, lee `vibe-specs/` y mira cómo está resuelto
   lo equivalente en `todo-app/`. Copiar la forma del ejemplar es la respuesta
   correcta casi siempre.
2. **Después de escribir código, ejecuta `make check`** y arregla lo que salga.
   Verde no es opcional: es la definición de terminado.
3. **Antes de dar un PoC por entregable**, recuérdale al usuario que pase
   `/code-review` y `/security-review`: `make check` no ve ni los errores de
   comportamiento ni los agujeros de seguridad.
4. **No desactives un test de convención ni añadas excepciones** sin decirlo
   explícitamente y explicar por qué.
5. **Antes de crear un fichero `.md` nuevo**, pregunta.
6. **Git lo gestiona el usuario.** Nunca hagas `commit` ni `push` por iniciativa
   propia. Al terminar un bloque, ofrece `make gitpush m="..."`.

## Dónde está cada cosa de la normativa

- Arquitectura y puertos: `vibe-specs/10-arquitectura.md`
- Backend: `vibe-specs/20-backend-python.md`
- Frontend: `vibe-specs/30-frontend-vue.md`
- Base de datos y migraciones: `vibe-specs/40-base-de-datos.md`
- Qué mide `make check`: `vibe-specs/50-guardarrailes.md`
- Envolver una librería o repo de terceros: `vibe-specs/70-envolver-un-repo.md`
- Backend en Node o Go: `vibe-specs/21-backend-otros-lenguajes.md`

> La normativa detallada es para **Python**. Para **Node o Go** existe
> `vibe-specs/21-backend-otros-lenguajes.md`: **se replica la misma arquitectura**,
> solo cambia la sintaxis. Lo que ahí falta son los tests de convención, que en
> esos lenguajes todavía no existen — dilo si te piden un PoC así.
