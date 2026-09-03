-- Learn Languages App - la 920: la regla de la inversion (V2), que estaba sin ayuda
-- Migration: 20260902000003-help-920-inversie-v2.sql
-- Description: Eduardo sobre la 920 (Volgens mij is het te duur): «¿que regla se sigue para
--   aplicar inversie? ¿que no se empieza por sujeto?». Casi: la regla de verdad es V2 — el verbo
--   conjugado va clavado en la casilla 2 y delante de el solo cabe UNA cosa. Si esa cosa no es
--   el sujeto (aqui volgens mij), el sujeto salta detras del verbo. La 920 estaba SIN ayuda y se
--   crea entera: tabla de casillas con 4 ejemplos, el error tipico del hispanohablante (sujeto
--   ademas delante), por que no se confunde con pregunta (la pregunta deja la casilla 1 vacia),
--   que solo se mueve la conjugada, las coordinantes que no invierten frente a la subordinada
--   inicial que si, truco y ejercicio. Idempotente: WHERE rules_help IS NULL.

PRAGMA foreign_keys = ON;

UPDATE words_es
SET rules_help = 'Volgens mij is het te duur: inversion (inversie). La regla no es «no se empieza por sujeto»: es que el verbo va CLAVADO en la casilla 2. Si la casilla 1 la ocupa otra cosa (aqui volgens mij), el sujeto salta a la 3, justo detras del verbo.

📐 La regla V2 — una sola cosa delante del verbo:

La casilla 1 es libre: puede llevar el sujeto (orden neutro) o cualquier pieza que quieras destacar (tiempo, lugar, opinion, objeto). Lo que no se mueve es el verbo conjugado, siempre en la 2. Con la 1 ocupada por otra cosa, el sujeto no cabe delante: se coloca detras del verbo.

| casilla 1 | verbo (2) | sujeto (3) | resto |
|---|---|---|---|
| Het | is | — | te duur. |
| Volgens mij | is | het | te duur. |
| Morgen | ga | ik | naar Amsterdam. |
| Die film | heb | ik | al gezien. |

• «Volgens mij het is te duur» ✗ — el error tipico del hispanohablante: dejar el sujeto ADEMAS delante. Delante del verbo solo cabe una cosa.
• no se confunde con una pregunta: la pregunta deja la casilla 1 VACIA (Is het te duur?); aqui la 1 esta ocupada y la entonacion es de afirmacion.
• solo se mueve la forma CONJUGADA: el resto del grupo verbal sigue al final. Gisteren heb ik hem gezien.
• las coordinantes en, maar, of, want, dus no ocupan casilla: tras ellas NO hay inversion (want het is te duur). Una subordinada entera al principio si es casilla 1: Als het regent, blijven we thuis.

🔑 El truco que casi nunca falla: cuenta lo que hay delante del verbo conjugado. Tiene que ser UNA sola cosa. Si esa cosa no es el sujeto, el sujeto va justo detras del verbo — como en las preguntas.

🏋️ Ejercicio: empieza por «morgen»: «Manana voy al mercado» → Morgen ___ ___ naar de markt. (Respuesta: ga ik — verbo en la 2, sujeto detras.)'
WHERE id = 920 AND rules_help IS NULL;
