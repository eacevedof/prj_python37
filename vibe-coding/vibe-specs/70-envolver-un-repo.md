# 70 · Envolver una herramienta o un repo de GitHub

Es el caso más habitual: *"haznos un PoC de esto"*, con un enlace a un proyecto
publicado. Este fichero va de dónde se enchufa ese proyecto sin que se coma la
arquitectura.

---

## La regla, en una frase

> **La librería de terceros se toca en UN sitio, y ese sitio es un repositorio o
> un componente. Nunca dentro de un caso de uso.**

Si `import loquesea` aparece en un `*_service.py`, está mal.

## Por qué

No es purismo. Son cuatro consecuencias concretas:

1. **Puedes probar tu lógica sin la librería.** Un caso de uso que llama a la
   librería directamente no se puede probar sin ella: sin red, sin la clave de la
   API, sin el modelo de 2 GB descargado.
2. **Puedes cambiarla.** La mitad de los proyectos de GitHub que envuelves hoy no
   se parecerán a sí mismos dentro de un año. Si está detrás de una clase tuya, el
   cambio es un fichero.
3. **Sabes qué te va a costar.** Al leer `PdfReaderApiRepository` sabes que esa
   llamada sale por internet. Al leer `pdf.extract(x)` no sabes si tarda 2 ms o 20
   segundos.
4. **Sus errores no se te cuelan.** La librería lanzará lo que le dé la gana. En
   el borde lo conviertes en algo que tu aplicación entiende.

---

## Dónde va exactamente

Depende de qué hace la librería. Dos casos:

### Caso A — la librería trae o guarda datos

Va en un **repositorio**, y el nombre dice de dónde salen los datos:

```
infrastructure/repositories/
├── transcriptions_reader_api_repository.py      llama a la API de OpenAI
├── documents_reader_file_repository.py          lee ficheros del disco
├── pages_reader_pdf_repository.py               extrae páginas con pypdfium2
└── vectors_writer_chroma_repository.py          escribe en ChromaDB
```

Los orígenes válidos están en el test de convenciones. Si el tuyo no está en la
lista (`sqlite`, `api`, `file`, `raw`, `memory`, `http`, `cdn`, `s3`, `redis`),
**añádelo al test** — que el catálogo crezca a propósito y no por accidente.

```python
@final
class PagesReaderPdfRepository:
    """Extrae el texto de un PDF con pypdfium2.

    ÚNICO fichero del proyecto que importa pypdfium2. Si mañana se cambia por
    otra librería, se cambia aquí y nadie más se entera.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_page_texts(self, pdf_bytes: bytes) -> list[str]:
        # Sin try/except: si el PDF está corrupto, el error sube. Quien decide qué
        # hacer con eso es el caso de uso, no este fichero.
        document = pypdfium2.PdfDocument(pdf_bytes)
        return [page.get_textpage().get_text_range() for page in document]
```

### Caso B — la librería calcula, transforma o formatea

No trae datos de ningún sitio: convierte, valida, cifra, formatea. Eso es un
**componente**, en `shared/infrastructure/components/<nombre>/<nombre>.py`.

```
shared/infrastructure/components/
├── logger/logger.py
├── tokener/tokener.py            compara secretos (hmac)
├── slugger/slugger.py            texto → slug
└── image_resizer/image_resizer.py  redimensiona con Pillow
```

Un componente **solo depende de la librería estándar y de la de terceros**. Nada
de logger, nada de enums del dominio, nada de otros componentes de la aplicación.
Son las piezas de más abajo del todo.

El nombre es un **sustantivo de agente**, acabado en `-er`: `Logger`, `Slugger`,
`Resizer`. No `LoggerComponent` ni `LoggingService`.

---

## Los errores de la librería

Una librería de terceros lanza lo que quiere: `ValueError`, `RuntimeError`, o una
excepción propia suya.

**No la captures en el repositorio.** Deja que suba. El controller ya tiene su
`except Exception`, que la registra con su traza completa y devuelve un 500.

Ahora bien: si un error de la librería significa en realidad **algo que tu negocio
entiende** ("este PDF no tiene texto", "esta fecha no vale"), entonces sí se
traduce — y el sitio para eso es un **servicio de dominio**:

```python
@final
class PdfReadability:
    """Servicio de dominio: ¿este PDF se puede leer?"""

    def is_readable(self, pdf_bytes: bytes) -> bool:
        try:
            return len(self._pages_reader_pdf_repository.get_page_texts(pdf_bytes)) > 0
        except Exception:
            # Traducir, no tragarse: el caso de uso recibe un False y decide
            # devolver un 400 con un mensaje que se entiende.
            return False
```

Mira `tasks_mod/domain/services/due_date.py` en el ejemplar: es exactamente este
patrón con `strptime`.

---

## Antes de meter la dependencia

Cinco preguntas. Contéstalas en el `README.md` de tu PoC:

| | Por qué |
|---|---|
| **¿Qué licencia tiene?** | GPL en un producto que se va a vender es un problema legal, no técnico |
| **¿Está viva?** | Último commit, issues abiertos. Un proyecto abandonado es deuda desde el día uno |
| **¿Cuánto pesa?** | Una que arrastre `torch` son 2 GB en la imagen. Igual hay una API que hace lo mismo |
| **¿Necesita algo del sistema?** | `ffmpeg`, `poppler`, un modelo descargado... eso va al Dockerfile, y si no lo pones el PoC solo funciona en tu máquina |
| **¿Necesita credenciales?** | Van al `.env` y a `.env.example` (el segundo, vacío). **Nunca** en el código |

Las dependencias de Python van a `backend_web/requirements.txt`, **con un
comentario diciendo para qué son**. Alguien tendrá que decidir si esa línea sigue
haciendo falta.

```
# Extracción de texto de PDF. La usa PagesReaderPdfRepository.
pypdfium2>=5.12.1
```

Lo que haga falta del sistema operativo va al `Dockerfile-deploy`, en la segunda
etapa:

```dockerfile
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg \
    && rm -rf /var/lib/apt/lists/*
```

---

## Cuando el repo que te dan es un servicio entero

A veces lo que te pasan no es una librería, sino un proyecto que se levanta solo
(con su propio Docker, su puerto y su API).

En ese caso **no lo metas dentro de tu PoC**. Levántalo al lado y háblale por HTTP
desde un `*_reader_api_repository.py`. Tu aplicación sigue teniendo la misma
forma, y ese servicio es un origen de datos más.

La dirección URL va al `.env`, con su getter en `EnvironmentReaderRawRepository`.
Nunca escrita dentro del código.

> **Esta es casi siempre la respuesta correcta cuando el repo no es de Python.**
> Levantas esa herramienta al lado, le hablas por HTTP, y tu backend sigue
> siendo Python con el kit entero: guardarraíles, plantillas y ejemplar. Ver
> [`21-backend-otros-lenguajes.md`](21-backend-otros-lenguajes.md).

---

## Cuando NO hay repo: clonar la funcionalidad de otro fabricante

A veces el encargo no trae enlace: *"queremos algo como lo que hace <producto de
otro fabricante>"*. No hay nada que envolver — hay un **comportamiento que
replicar** — así que esto no es un caso de este fichero: es un **PoC normal**
([`00-como-usar-esto.md`](00-como-usar-esto.md)) en el que el paso 0 cuesta más.

### El trabajo de verdad: especificar lo observado

Nadie te va a dar los casos de uso; hay que sacarlos mirando el producto.
Escríbelo en el `README.md` de tu PoC **antes** de pedir nada a Claude:

- **Qué hace, pantalla a pantalla**: qué mete la persona, qué sale, en qué orden.
- **Los casos límite que se ven usándolo**: qué pasa con el campo vacío, con el
  fichero enorme, con dos elementos con el mismo nombre.
- **Qué parte NO se clona.** Un producto lleva años de funciones; el PoC
  demuestra la que importa. Decir cuál es la mitad de la especificación.

Con eso, el prompt 11 de [`90-prompts.md`](90-prompts.md): Claude propone
módulos y casos de uso a partir del comportamiento, y se sigue el flujo normal.

### Lo que NO se hace (y no por cortesía: por legal)

Se replica la **funcionalidad** — la idea de qué hace no es de nadie. Lo demás sí
tiene dueño:

| No se hace | Porque |
|---|---|
| Copiar su código, descompilarlo o sacarlo de su JavaScript | el código es suyo, da igual que se pueda leer |
| Copiar sus iconos, textos, capturas o diseño pixel a pixel | los assets también; el mockup se hace con nuestro sistema de diseño |
| Usar su API privada o hacerle scraping para alimentar el PoC | sus condiciones de uso casi siempre lo prohíben |
| Usar su marca o nombre en el PoC | ni en el título "de broma": las demos se enseñan |

> Si el fabricante publica una librería o API **con licencia que lo permita**,
> deja de ser este caso: es el caso normal de este fichero — se envuelve, y a las
> cinco preguntas de la licencia de [más arriba](#antes-de-meter-la-dependencia).

---

## Resumen

```
              tu caso de uso
                    │
                    │  solo habla con clases TUYAS
                    ▼
     ┌──────────────────────────────┐
     │  *_<origen>_repository.py    │  ← el ÚNICO sitio que importa la librería
     │  o  components/<nombre>/     │
     └──────────────┬───────────────┘
                    ▼
            la librería de GitHub
```

Si mañana la cambian, la sustituyen o la abandonan, tocas una caja.
