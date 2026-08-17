# 60 · Antes de enseñárselo a negocio

Repasa esto antes de mandar el enlace. Son diez minutos y evitan la reunión en la
que se descubre que falla lo básico.

---

## 1 · El código

- [ ] **`make check` en verde.** No "casi verde".
- [ ] **`make front-build` pasa.** Incluye la comprobación de tipos.
- [ ] No quedan restos de `lists_mod` ni de `tasks_mod` en tu PoC.
- [ ] No queda ningún `todo-app` sin renombrar:
      `grep -rn "todo-app\|todo_app" --exclude-dir=.venv --exclude-dir=node_modules --exclude-dir=dist .`
- [ ] No hay código comentado "por si acaso". Bórralo: está en git.

## 2 · Funciona de verdad

- [ ] `make up-deploy-local` levanta la imagen **real** y todo funciona en
      `http://localhost:6003`. Esto es lo que se despliega: si aquí falla, en el
      servidor falla.
- [ ] El recorrido completo, hecho a mano en el navegador: crear, listar,
      modificar, borrar.
- [ ] **Recargar la página en una ruta interna funciona** (F5 estando en
      `/algo/3/detalle`).
- [ ] Los datos siguen ahí después de `docker stop` y volver a arrancar.
- [ ] `make up-ephemeral` arranca **desde cero**, sin tu `.env` y sin tus datos.
      Si eso funciona, el PoC no depende de nada que solo tengas tú.

## 3 · Los errores se ven

Es lo que más se olvida y lo que peor queda en una demo.

- [ ] Un campo obligatorio vacío → mensaje claro en pantalla, no una pantalla en
      blanco.
- [ ] Con la API parada, el front dice algo comprensible en vez de quedarse
      girando.
- [ ] Ningún mensaje de error del servidor llega tal cual a la pantalla. El
      `except Exception` del controller ya lo evita; comprueba que no lo has
      esquivado.
- [ ] Hay algo que mirar cuando falla: `backend_web/storage/logs/`.

## 4 · Configuración

- [ ] **`API_KEY` cambiada.** La de la plantilla empieza por
      `changethisinproduction-`: si eso llega a un servidor, es como no tener
      ninguna. Compruébalo de un vistazo:
      ```bash
      grep -l "changethisinproduction" backend_web/.env frontend_web/.env.local 2>/dev/null
      ```
      Si no imprime nada, está cambiada. Si imprime un fichero, ahí sigue la de
      la plantilla.
      Y para generar una de verdad:
      ```bash
      python3 -c "import secrets; print(secrets.token_urlsafe(32))"
      ```
- [ ] **Los dos `.env.example` al día**, sin valores reales:
      `backend_web/.env.example` (lo lee la aplicación) y `docker/.env.example`
      (lo lee docker compose en develop y prod).
- [ ] Ningún `.env` está en git: `git status --ignored | grep .env`
- [ ] Ninguna credencial ni URL de servicio escrita dentro del código.
- [ ] **Tu `.env` NO está dentro de la imagen.** Compruébalo, no lo supongas:
      ```bash
      docker run --rm --entrypoint sh mi-poc:develop -c 'ls -la /app/backend_web/.env'
      ```
      Tiene que decir *No such file*. Si aparece, te falta el `.dockerignore` o
      lo has tocado: esa imagen lleva tu credencial a cualquier sitio donde la
      subas.

## 5 · Que alguien más pueda arrancarlo

- [ ] El `README.md` responde a: **qué es**, **qué hace falta instalar**, **cómo se
      arranca** y **cómo se prueba**.
- [ ] Las dependencias de `requirements.txt` llevan un comentario diciendo para
      qué son.
- [ ] Lo que haga falta del sistema (`ffmpeg`, fuentes, un modelo) está en el
      `Dockerfile-deploy`, no solo instalado en tu máquina.
- [ ] **Pruébalo en limpio**: clona el repo en otra carpeta y arráncalo desde
      cero. Es la única forma de descubrir el paso que solo funciona en tu equipo.

## 6 · Si se despliega

- [ ] `docker/.env` creado a partir de `docker/.env.example`, con `APP_NAME`,
      `APP_DOMAIN`, `HOST_STORAGE_PATH` y `PROXY_NETWORK` rellenos.
- [ ] `HOST_STORAGE_PATH` es una ruta **absoluta** y **existe** en el servidor.
- [ ] `APP_ENV=develop` (o `production`) en el `.env` del servidor.
- [ ] `curl https://tu-dominio/health-check` responde con la versión y el entorno
      correctos.
- [ ] Sabes **dónde está el fichero de la base de datos** en el servidor. Si nadie
      lo sabe, no hay copia de seguridad posible.

---

## Lo que hay que decir en voz alta al entregar

Un PoC no es un producto. Escríbelo en el correo, para que nadie se lleve una
sorpresa después:

> **No hay usuarios ni permisos.** La apikey autoriza a usar el servicio, no dice
> quién eres. Todo el que entra ve lo mismo.
>
> **La credencial se puede leer desde el navegador.** Frena rastreadores
> automáticos, no a una persona.
>
> **La base de datos es un fichero.** Va bien para esto; no aguanta varios
> servidores ni mucha escritura simultánea.
>
> **No hay copias de seguridad** salvo que alguien las haya montado aparte.
>
> **Nada de esto es un problema para un PoC. Todo esto es un problema si pasa a
> producción tal cual.**

Y una que es dura pero conviene decir pronto: **si el PoC va a manejar datos
personales reales de más de una persona, con esto no basta.** Hace falta
autenticación de verdad antes de que entre el primer dato real.
