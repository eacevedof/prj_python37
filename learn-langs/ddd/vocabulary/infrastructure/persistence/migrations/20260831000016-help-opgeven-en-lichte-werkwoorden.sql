-- Learn Languages App - opgeven solo vs de moed opgeven, y el patron sustantivo + verbo (853)
-- Migration: 20260831000016-help-opgeven-en-lichte-werkwoorden.sql
-- Description: Eduardo en la 853 («Na de derde afwijzing gaf ze de moed niet op»): «¿podria ser
--   gaf ze niet op? ¿por que se mete de moed? ¿que percibe un neerlandes sin de moed?». Las dos
--   son correctas pero dicen cosas distintas: «Ze gaf niet op» habla de la ACCION (no abandono,
--   siguio intentandolo) y «Ze gaf de moed niet op» habla de lo de DENTRO (no se desanimo,
--   mantuvo la moral). No van siempre juntas: se puede seguir intentandolo con la moral por los
--   suelos, y al reves. Tras tres negativas, lo que estaba en juego era el animo, y por eso la
--   version con de moed es la natural.
--   Bloque 🏳️ (solo en la 853) con esa distincion, las cinco vidas de opgeven (zich opgeven VOOR
--   = inscribirse · iets opgeven = declarar · huiswerk opgeven = mandar deberes · de moed of de
--   hoop opgeven · hoog opgeven VAN = elogiar), su conjugacion fuerte (opgeven - gaf op -
--   opgegeven) y los antonimos (volhouden, doorzetten, de moed erin houden, y el modismo het
--   bijltje erbij neergooien = tirar la toalla).
--   Bloque 🧱 IDENTICO byte a byte con el patron general que hay detras y que explica la duda: en
--   neerlandes muchas ideas que en espanol son UN verbo son SUSTANTIVO + verbo de apoyo (de moed
--   opgeven, spijt hebben van, gelijk hebben, honger hebben, zin hebben in, haast hebben, last
--   hebben van, afscheid nemen, een beslissing nemen, ruzie maken), el verbo de apoyo no es
--   siempre hebben, y el articulo tampoco es libre: los de sensacion van pelados y los que
--   nombran algo que ya tienes lo llevan (DE moed, DE hoop), que es la misma logica del bloque
--   del articulo. Va a 146, 489, 546, 596, 853 y 914.
--   100% aditiva e idempotente: UPDATE con guard por marca.


-- ==============================================================================
-- 1. opgeven vs de moed opgeven, en la 853
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🏳️ opgeven solo o de moed opgeven, que no dicen lo mismo
Las dos frases son correctas, pero un neerlandes oye cosas distintas:
• Ze gaf niet op = no abandono, siguio intentandolo. Habla de la ACCION: no paro.
• Ze gaf de moed niet op = no perdio el animo, no se desanimo. Habla de lo de DENTRO: mantuvo la moral.

📌 Y no van siempre juntas: se puede seguir intentandolo con la moral por los suelos (hij geeft niet op, maar hij is de moed kwijt) y se puede estar animado y aun asi dejarlo. Despues de tres negativas, de moed opgeven es lo que suena natural, porque lo que estaba en juego era el animo.

🎒 opgeven es ademas un separable con varias vidas, y conviene tenerlas localizadas:
• zich opgeven VOOR = apuntarse a, inscribirse. Ik heb me opgegeven voor de cursus.
• iets opgeven = declarar datos, dar de alta. Je inkomsten opgeven bij de belasting.
• huiswerk opgeven = mandar deberes. De leraar geeft veel huiswerk op.
• de moed of de hoop opgeven = perder el animo o la esperanza.
• hoog opgeven VAN iemand = poner a alguien por las nubes, elogiarlo mucho.

📐 Es fuerte, porque sale de geven: opgeven - gaf op - opgegeven. Ze gaf de moed niet op. · Ze heeft de moed nooit opgegeven.

↔️ Antonimos: opgeven ↔ volhouden (aguantar) y doorzetten (seguir adelante) · de moed opgeven ↔ de moed erin houden (mantener el animo). Y la expresion hecha para tirar la toalla es het bijltje erbij neergooien. Los sustantivos, con su articulo: de moed (el animo, el valor) y de hoop (la esperanza), con el adjetivo moedig (valiente) ↔ laf (cobarde).',
    updated_at = datetime('now')
WHERE id IN (853)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🏳️ opgeven solo o de moed opgeven%';

-- ==============================================================================
-- 2. El patron sustantivo + verbo, en 6 tarjetas
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧱 El patron sustantivo + verbo, donde el espanol usa un verbo solo
Es de las diferencias que mas se notan: muchas ideas que en espanol son UN verbo, en neerlandes son un SUSTANTIVO con un verbo de apoyo. Si intentas traducir con un verbo solo, casi siempre te falta la pieza.

| en espanol | en NL | literalmente |
|---|---|---|
| desanimarse | **de moed opgeven** | abandonar el animo |
| arrepentirse (de) | **spijt hebben (van)** | tener pesar |
| tener razon | **gelijk hebben** | tener igualdad |
| tener hambre, sed | **honger, dorst hebben** | tener hambre |
| apetecer | **zin hebben in** | tener gana en |
| tener prisa | **haast hebben** | tener prisa |
| molestar, sufrir algo | **last hebben van** | tener carga de |
| despedirse (de) | **afscheid nemen (van)** | tomar despedida |
| decidir | **een beslissing nemen** | tomar una decision |
| pelearse | **ruzie maken** | hacer pelea |

📌 Fijate en que el verbo de apoyo no es siempre hebben: hay hebben, nemen, maken, doen y opgeven, y no se puede elegir a ojo. La colocacion se aprende entera, como una pieza, igual que en espanol no dices «hacer una decision».

⚠️ Y ojo al articulo, que tampoco es libre: los de cantidad o sensacion van pelados (honger hebben, zin hebben in, haast hebben, gelijk hebben, afscheid nemen), pero los que hablan de algo que ya tienes lo llevan (DE moed opgeven, DE hoop opgeven). Es la misma logica del articulo de siempre: cuando el sustantivo nombra una funcion o una sensacion se cae, y cuando nombra algo identificable se queda.',
    updated_at = datetime('now')
WHERE id IN (146, 489, 546, 596, 853, 914)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧱 El patron sustantivo + verbo%';
