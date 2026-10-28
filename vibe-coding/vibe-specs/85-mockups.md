# 85 · Mockups: enseñar la interfaz antes de construir nada

El encargo suena así: *"queremos VER cómo sería antes de decidir si se hace"*.
No piden que funcione: piden algo que se pueda mirar y tocar en una reunión.

La pregunta que decide todo el camino: **¿esto puede acabar siendo un PoC?**

---

## Camino A · Puede acabar siendo un PoC → el kit, sin backend

Se monta **solo el front** del kit, con datos falsos. Nada de API, nada de base
de datos, nada de Docker.

**Por qué así y no un HTML rápido:** porque si el mockup gusta — y si lo estás
haciendo es porque puede gustar — el paso a PoC es enchufar el backend, no
empezar de cero. El sistema de diseño, las vistas y la estructura ya son los
definitivos.

### Los pasos

1. **Copiar el ejemplar y renombrar** ([pasos 1 y 2 del
   PoC](00-como-usar-esto.md#paso-1--copiar-el-ejemplar)). Del backend no se
   borra nada: simplemente **no se arranca**.
2. **Solo el front:**
   ```bash
   make front-install
   make front-local      # http://localhost:6002
   ```
3. **Los datos falsos, en un solo sitio:** un `fixtures.ts` en
   `infrastructure/` del módulo, y el store de Pinia lee de ahí en vez de llamar
   al `*ApiRepository`. Es la versión front de un repositorio: cuando llegue el
   backend, se cambia una importación y las vistas ni se enteran.
4. **Las reglas del front siguen valiendo** —
   [`30-frontend-vue.md`](30-frontend-vue.md): tokens de `style.css`, ningún
   tamaño a mano, TypeScript estricto. Es justo lo que hace que parezca un
   producto y no un prototipo, que es lo único que un mockup tiene que conseguir.

Prompt listo: el **10** de [`90-prompts.md`](90-prompts.md).

### Datos falsos que parezcan de verdad

Es lo que más sube — y más barato es. En la reunión se mira el contenido, no el
código:

- Nombres y textos **del dominio real** ("Póliza 4711 · Siniestro abierto"), no
  "test 1, test 2, asdf".
- **Cantidad realista**: si habrá 200 filas, que el mockup tenga 30 y se vea el
  scroll, no 3.
- **Los estados feos también**: la lista vacía, el nombre kilométrico, el
  registro con campos sin rellenar. Son las preguntas que van a hacer.

## Camino B · Es solo para una reunión → desechable, y fuera del repo

Si es para decidir entre dos disposiciones de pantalla o acompañar una
presentación, no hace falta el kit: pídele a Claude un HTML suelto con todo
dentro y ábrelo en el navegador.

Dos reglas:

- **No entra en el repositorio.** A `/tmp` o a `_scratch/`, como todo lo
  desechable ([dónde trastear](00-como-usar-esto.md#si-necesitas-trastear)).
- **Se dice que es desechable.** La frase "esto es un dibujo, no hay nada
  detrás" evita la reunión en la que alguien pregunta por qué "lo que ya estaba
  hecho" tarda tres semanas.

## La trampa de los mockups

Un buen mockup se confunde con un producto — ese es su trabajo. Al enseñarlo,
**di siempre en voz alta qué hay detrás**: nada (camino B) o solo la pantalla
(camino A). El coste de construirlo de verdad se decide en esa reunión, y se
decide mal si nadie sabe que lo que se está viendo son datos pintados.
