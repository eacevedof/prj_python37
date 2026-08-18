# 80 · Analizar la seguridad de un código ajeno

El encargo suena así: *"mira si este código es seguro"*. Un repo interno, algo
heredado, o el proyecto de GitHub que se quiere envolver en un PoC. **No sale un
PoC de aquí: sale un informe.**

---

## Antes de empezar: qué es esto y qué no es

Esto es **análisis estático asistido**: Claude lee el código y señala problemas.

Lo que NO es, y hay que decirlo en el informe para que nadie se confunda:

- **No es un pentest.** Nadie ha atacado nada: no se ha probado que los fallos
  sean explotables, solo que están en el código.
- **No revisa la infraestructura.** El servidor, el firewall, los certificados y
  los permisos de la base de datos quedan fuera.
- **No garantiza que no haya más.** Claude señala lo que ve; un "no he encontrado
  nada" no es un certificado de seguridad.

Y una regla que no se negocia: **solo se analiza código que te han dado o que es
del departamento.** Sistemas en producción no se tocan — ni "solo para probar si
entra". Eso ya no es análisis, y sin autorización escrita es un problema serio.

## El flujo

1. **Clona el repo y abre Claude en su carpeta.** Claude solo ve lo que puede
   leer: si lo abres en otro sitio, no está analizando nada.
2. **Lánzale el prompt 9 de [`90-prompts.md`](90-prompts.md).** Pide el informe
   ordenado por gravedad, con fichero y línea de cada hallazgo.
3. **Las dependencias van aparte del prompt**, con herramienta, porque tienen
   base de datos de vulnerabilidades y Claude no:
   ```bash
   pip install pip-audit && pip-audit -r requirements.txt   # Python
   npm audit                                                # Node
   ```
4. **Si el repo es grande, por partes.** Un módulo o carpeta por pasada; un
   repo de 500 ficheros en una sola pregunta sale por encima y a vuelo de pájaro.

> `/security-review` (el comando del [paso 9 del
> PoC](00-como-usar-esto.md#paso-9--que-claude-te-revise-lo-que-ha-escrito))
> revisa **los cambios de una rama**, no un repo entero parado. Para auditar
> código ajeno, el prompt; el comando, para lo que tú escribes.

## Qué se le pide que mire

La lista corta, que es donde está casi todo:

| | Ejemplo de lo que caza |
|---|---|
| **Credenciales en el código** | contraseñas, apikeys, tokens escritos en un `.py` o commiteados en un `.env` |
| **Inyección** | SQL concatenado con f-strings, entrada del usuario que llega a un `os.system` |
| **Entrada sin validar** | rutas de fichero que vienen del navegador (`../../etc/passwd`), tamaños sin límite |
| **Endpoints sin proteger** | rutas que se olvidaron de la autenticación, CORS en `*` |
| **Secretos en el historial** | una credencial borrada del código pero viva en `git log` |
| **Errores que cuentan de más** | trazas completas o SQL devueltos al navegador |

## El entregable

Un `.md` con esta forma — pídeselo así y te lo da así:

```
## Resumen            qué se analizó, cuándo, y qué quedó fuera
## Hallazgos          por gravedad: qué, dónde (fichero:línea), qué puede
                      pasar, cómo arreglarlo
## Dependencias       salida de pip-audit / npm audit, comentada
## Lo que NO se miró  infraestructura, explotación real, lo que no se leyó
```

La última sección es la que te protege a ti: deja escrito el alcance antes de
que alguien convierta "Claude no vio nada" en "está auditado".
