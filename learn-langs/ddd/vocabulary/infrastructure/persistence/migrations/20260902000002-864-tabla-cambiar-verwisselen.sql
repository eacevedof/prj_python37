-- Learn Languages App - la 864: el reparto de «cambiar» a tabla, ampliado con verwisselen
-- Migration: 20260902000002-864-tabla-cambiar-verwisselen.sql
-- Description: Eduardo pide llevar a tabla el parrafo corrido de la 864 (wisselen/ruilen/
--   veranderen/omwisselen + euro''s + articulos) — «un humano sigue la informacion de manera mas
--   amigable si esta tabulado porque puede comparar» (misma norma nueva del howto §2.3) — y
--   ampliarlo con verwisselen (sustituir 1x1 o confundir, rige met). Se conserva la regla
--   voor/door con la referencia a la 830 y el detalle ortografico; el resto del help (el bloque
--   🔁 del «por», el test door/voor, las cuatro vidas de voor…) no se toca. Idempotente:
--   REPLACE del parrafo viejo exacto, que desaparece al aplicar.

PRAGMA foreign_keys = ON;

UPDATE words_es
SET rules_help = REPLACE(rules_help, 'wisselen VOOR = cambiar A CAMBIO DE, y por eso aqui es voor y no door: lo que hay es un intercambio, no un agente ni una causa. Este es exactamente el par que confunde, porque la tarjeta 830 usa el otro («Ik ben benaderd DOOR een recruiter», donde el «por» es quien hace la accion). Ademas, el «cambiar» espanol se reparte: wisselen es cambiar dinero o intercambiar, ruilen es canjear una cosa por otra (ruilen voor tambien), veranderen es cambiar de estado o de forma, y omwisselen es hacer el cambio efectivo en ventanilla. Detalle ortografico: el plural de euro se escribe con apostrofo, euro''s, como foto''s y taxi''s, porque sin el la o se leeria corta. Los articulos: de euro, de dollar, het geld (el dinero).', 'wisselen VOOR = cambiar A CAMBIO DE, y por eso aqui es voor y no door: lo que hay es un intercambio, no un agente ni una causa. Es justo el par que confunde con la 830 («Ik ben benaderd DOOR een recruiter»), donde el «por» si es quien hace la accion.

🪙 El «cambiar» espanol se reparte — no son intercambiables:

| verbo | que es | ejemplo |
|---|---|---|
| wisselen (voor) | cambiar dinero, intercambiar o alternar | Euro''''s wisselen voor dollars. |
| verwisselen (met) | sustituir una cosa por otra igual, o CONFUNDIRLAS | De banden verwisselen. · Ik verwissel jou met je broer. |
| ruilen (voor/tegen) | canjear, trocar una cosa por otra | Mijn boek ruilen voor het jouwe. |
| omwisselen (voor) | hacer el cambio EFECTIVO en ventanilla | Geld omwisselen bij de bank. |
| veranderen | cambiar de estado o de forma: no hay trueque | Het plan is veranderd. |

📌 Regla de bolsillo:
• ¿Trueque de dinero, turnos o sitio? → wisselen.
• ¿Sustituyes o confundes dos cosas iguales? → verwisselen.
• ¿Canje de objetos, sin dinero por medio? → ruilen.
• ¿La operacion de ventanilla? → omwisselen.
• ¿No hay intercambio: algo se vuelve distinto? → veranderen.

✍️ Detalle ortografico: el plural de euro lleva apostrofo — euro''''s, como foto''''s y taxi''''s — porque sin el la o se leeria corta. Y los articulos: de euro · de dollar · het geld (el dinero).')
WHERE id = 864 AND rules_help LIKE '%veranderen es cambiar de estado o de forma, y omwisselen%';
