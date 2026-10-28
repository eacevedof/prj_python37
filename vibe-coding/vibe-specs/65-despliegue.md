# 65 · Desplegar: la app sola, o la app con servicios al lado

El PoC se despliega en **develop** y **production** con **Dokploy**, un panel que
hace una cosa muy simple: coge tu `docker/docker-compose-<entorno>.yml`, lo
ejecuta en el servidor, y el proxy (Traefik) enruta el dominio hacia tu app
leyendo las `labels` que ya vienen en la plantilla.

La consecuencia práctica es esta: **tu compose ES tu despliegue.** No hay un
equipo de sistemas traduciendo tu proyecto a otra cosa: lo que escribas en ese
fichero es exactamente lo que va a correr. Por eso esta página existe.

---

## Lo primero: ¿de qué índole es tu PoC?

Antes de escribir el primer módulo, decide cuál de estas tres formas tiene. Lo
decide una sola pregunta: **¿qué necesita estar corriendo, además de tu app?**

| Índole | Qué es | Contenedores |
|---|---|---|
| **A · La app sola** | front + API + SQLite. El ejemplar tal cual | 1 |
| **B · La app + servicios de apoyo** | tu app necesita piezas que corren aparte: un Valkey/Redis, un Tor, un worker que hace trabajo periódico | 1 + sidecars, **en el mismo compose** |
| **C · La app + un servicio de terceros que vive solo** | el repo que envuelves es una aplicación completa, con su propio compose y su propia base de datos | 2 despliegues **separados**, hablándose por HTTP |

Cómo distinguir B de C: mira si la pieza **trae su propio `docker-compose.yml`
y se administra sola** (su web, su API, sus datos). Si sí, es C: no la copies
dentro de tu proyecto. Si es una imagen suelta que solo existe para servir a tu
app (una cola, una caché, un proxy), es B.

> La índole A ya está resuelta: es lo que hay en `todo-app/docker/` y no hay que
> tocar nada. El resto de esta página es para B y C.

---

## Índole B · Servicios de apoyo en el mismo compose

Los sidecars se añaden a **cada** compose de entorno (`local`, `develop`,
`production` — los tres, completos, como todo en este kit). Las reglas:

### 1. Solo tu app se asoma al mundo

El sidecar **no publica puertos ni lleva labels de Traefik**. Tu app le habla
por la red interna del compose, usando el nombre del servicio como host:

```yaml
services:
  mi-poc:
    # ... igual que la plantilla de todo-app ...
    networks: [web, internal]        # web para Traefik, internal para los sidecars

  valkey:
    image: valkey/valkey:8
    container_name: cont-develop-${APP_NAME}-valkey
    restart: unless-stopped
    # SIN ports: y SIN labels: - solo lo ve tu app, por la red interna
    volumes:
      - ${APP_HOST_STORAGE_PATH}/valkey:/data
    networks: [internal]

networks:
  web:
    external: true
    name: ${APP_PROXY_NETWORK:-web}
  internal:                          # esta si la crea el compose: es solo tuya
```

**Por qué:** cada puerto publicado es una puerta que alguien tiene que vigilar.
El Valkey de tu PoC no tiene contraseña; mientras solo exista en la red interna
eso es correcto, y en el momento en que publiques su puerto es un incidente.

### 2. La dirección del sidecar va al `.env`, como todo

```
APP_VALKEY_URL=redis://valkey:6379
```

El host es el **nombre del servicio** en el compose. En local, si arrancas la
API fuera de Docker (`make local`), el mismo valor apunta a
`redis://localhost:6379` y publicas el puerto **solo** en
`docker-compose-local.yml`. Local es la única excepción a la regla 1.

### 3. El estado del sidecar vive bajo `APP_HOST_STORAGE_PATH`

Cada servicio con datos monta su carpeta ahí
(`${APP_HOST_STORAGE_PATH}/valkey`, `.../tor`), igual que la base de datos de la
app. Así "qué hay que copiar para no perder nada" sigue teniendo una sola
respuesta: esa carpeta.

### 4. El trabajo periódico es un servicio más, con la misma imagen

Si tu PoC necesita hacer algo cada X minutos (sincronizar datos de una API,
procesar una cola), **no metas un cron dentro del contenedor de la app** ni un
hilo raro en FastAPI. Es otro servicio del compose, con la **misma imagen** y
otro `command`:

```yaml
  mi-poc-worker:
    image: ${APP_NAME}:develop        # la MISMA imagen que la app
    container_name: cont-develop-${APP_NAME}-worker
    restart: unless-stopped
    command: python -m src.modules.devops_mod.application.run_sync   # tu bucle
    volumes:
      - ${APP_HOST_STORAGE_PATH}/.env:/app/backend_web/.env
      - ${APP_HOST_STORAGE_PATH}/storage:/app/backend_web/storage
    networks: [internal]
```

El bucle es un fichero de `devops_mod/application/`, como `run_migrations`: un
`while True` con su `time.sleep(...)` que llama a **un caso de uso normal**. La
lógica no vive en el worker; el worker solo la invoca. Así se prueba como todo
lo demás.

### 5. La demo con sidecars

`make up-ephemeral` levanta **solo la app**: si tu PoC es de índole B, para la
demo usa el compose entero (`docker compose -f docker/docker-compose-local.yml
up`). Y ten en cuenta lo que el checklist llama "arrancar desde cero": un
sidecar recién nacido está **vacío**. Si la gracia de la demo son los datos,
decide de dónde salen en un arranque limpio — o acepta y avisa de que la demo
enseña la primera sincronización, no un histórico.

---

## Índole C · El servicio de terceros se despliega aparte

Cuando el repo que envuelves es una aplicación completa (su compose, su web, su
base de datos), **tu proyecto no lo absorbe**:

1. **Se despliega como otra aplicación** en Dokploy, con su propio compose — el
   suyo, el que trae el repo — y su propio ciclo de vida. Quien lo despliega
   normalmente es quien administra el servidor: **pídelo**, no lo calces dentro
   de tu compose para evitar la conversación.
2. **Tu app le habla por HTTP** con un `*_reader_api_repository.py`, igual que a
   cualquier API externa ([`70-envolver-un-repo.md`](70-envolver-un-repo.md#cuando-el-repo-que-te-dan-es-un-servicio-entero)).
   Su URL y su credencial, al `.env`.
3. **En local**, lo levantas con su propio `docker compose up` en su carpeta,
   fuera de tu proyecto, y tu `.env` apunta a `http://localhost:<su puerto>`.
4. **Tu PoC tiene que sobrevivir a que el tercero esté caído.** Es la prueba de
   que la frontera está bien puesta: con él parado, tu app arranca, responde, y
   sus pantallas dicen "el servicio X no está disponible" — no una traza.

**Por qué no absorberlo:** su compose trae decisiones suyas (versiones, redes,
volúmenes) que cambiarán con su próxima release. Si viven dentro de tu proyecto,
su mantenimiento pasa a ser tuyo. Al lado, actualizar es `git pull` + redeploy
**suyo**, y tu PoC ni se entera.

---

## Qué NO va en tu compose, tenga la índole que tenga

- **Bases de datos compartidas de la infraestructura.** Si el PoC necesita un
  MySQL/Postgres "de verdad", eso se pide a quien administra el servidor; no se
  levanta uno propio por PoC sin decirlo.
- **Otro proxy.** Traefik ya está en el servidor; tu compose solo trae labels.
- **Credenciales escritas en el YAML.** Ni en `environment:`: van al `.env`
  montado, como siempre.
- **Puertos publicados en develop/production.** Nadie entra por IP:puerto; se
  entra por el dominio, y eso lo hace el proxy.
