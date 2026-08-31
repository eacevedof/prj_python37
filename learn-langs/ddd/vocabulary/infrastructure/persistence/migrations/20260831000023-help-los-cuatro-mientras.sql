-- Learn Languages App - Los cuatro «mientras»: terwijl · zolang · tijdens · ondertussen (duda 807)
-- Migration: 20260831000023-help-los-cuatro-mientras.sql
-- Description: Eduardo, leyendo la 807: «vaya, zolang tambien es mientras, no solo terwijl y
--   tijdens». Y tenia razon en la queja: la tarjeta del «mientras» es la 278 y ahi solo estaban
--   terwijl (conjuncion) y tijdens (con sustantivo) — zolang no aparecia, asi que el mazo ensenaba
--   un mapa incompleto y solo se veia en los bloques de conjunciones temporales.
--   Se arregla en dos pasos: (1) la primera linea de la 278, que es la que sale destacada, deja de
--   decir «TERWIJL = mientras» a secas y avisa de que son cuatro palabras; (2) bloque 🕰️ IDENTICO
--   byte a byte en la 278 y en las siete tarjetas de la familia de conjunciones temporales (502,
--   524, 731, 772, 807, 808, 837) con el reparto completo: terwijl (dos acciones A LA VEZ, y su
--   segundo uso de contraste, «mientras que») · zolang (todo el tiempo que dure, con condicion) ·
--   tijdens (preposicion + sustantivo, con gedurende como variante formal) · ondertussen/intussen
--   (adverbio: mientras tanto).
--   La pieza que de verdad resuelve la eleccion es el MODO del verbo espanol: «mientras +
--   SUBJUNTIVO» (mientras estes, mientras llueva) es condicion y duracion -> zolang; «mientras +
--   INDICATIVO» (mientras cocinaba, mientras cocino) es simultaneidad -> terwijl. Incluye tambien
--   la trampa ortografica zolang (conjuncion) frente a zo lang (tan largo, tanto tiempo) y la
--   separacion de terwijl frente a als/toen/wanneer, que marcan el momento y no la duracion.
--   100% aditiva e idempotente: UPDATE con guard por marca y por el texto exacto.

-- ==============================================================================
-- 1. La 278 dejaba de fuera zolang ya en su primera linea (la destacada)
-- ==============================================================================
UPDATE words_es
SET rules_help = REPLACE(
        rules_help,
        'TERWIJL = mientras. SUBORDINANTE: verbo al final:',
        'TERWIJL = mientras, cuando dos cosas pasan A LA VEZ. Ojo, porque el «mientras» espanol se reparte en cuatro palabras (terwijl · zolang · tijdens · ondertussen) y el bloque de abajo dice cual toca en cada caso. SUBORDINANTE: verbo al final:'
    ),
    updated_at = datetime('now')
WHERE id = 278
  AND rules_help LIKE '%TERWIJL = mientras. SUBORDINANTE: verbo al final:%';

-- ==============================================================================
-- 2. El bloque de los cuatro «mientras», en la 278 y en la familia temporal
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🕰️ Los cuatro «mientras» — y el truco del subjuntivo
El espanol usa «mientras» para cuatro cosas distintas y el neerlandes las separa. Lo que decide es que viene detras y si hay condicion:

| en espanol | en neerlandes | que es |
|---|---|---|
| **Mientras** yo cocinaba, ella ponia la mesa | **terwijl** | dos acciones A LA VEZ — conjuncion, verbo al final |
| **Mientras** estes aqui, puedes usar mi coche | **zolang** | TODO EL TIEMPO QUE dure, con condicion — conjuncion, verbo al final |
| **Mientras** la cena / durante la reunion | **tijdens** | preposicion + SUSTANTIVO |
| Yo cocino; **mientras tanto**, el pone la mesa | **ondertussen** · **intussen** | adverbio suelto, no conjuncion |

🔑 El truco que casi nunca falla: mira el MODO del verbo espanol. «Mientras + SUBJUNTIVO» (mientras estes, mientras llueva, mientras yo viva) lleva condicion y duracion → zolang. «Mientras + INDICATIVO» (mientras cocinaba, mientras cocino) es simultaneidad pura → terwijl.

🔀 terwijl — dos cosas a la vez, y tambien el contraste:
• Terwijl ik kookte, dekte zij de tafel. — Mientras yo cocinaba, ella ponia la mesa.
• Hij belde terwijl ik onder de douche stond. — Llamo mientras yo estaba en la ducha.
• Ik werk hard, terwijl hij niets doet. — Yo trabajo duro, mientras que el no hace nada. (este es el uso de CONTRASTE, «mientras que»)

⏳ zolang — todo el tiempo que dure, con condicion dentro:
• Zolang het regent, blijven we binnen. — Mientras llueva, nos quedamos dentro.
• Je mag blijven zolang je wilt. — Puedes quedarte todo el tiempo que quieras.
• Zolang ik leef, gebeurt dat niet. — Mientras yo viva, eso no pasa.
• Zolang je hier bent, mag je mijn auto gebruiken. — Mientras estes aqui, puedes usar mi coche.

📅 tijdens — preposicion, y por tanto SIEMPRE con un sustantivo detras (con su articulo): tijdens het eten (durante la comida) · tijdens de pauze (en el descanso) · tijdens de vergadering · tijdens de vakantie. La variante formal, para un periodo largo entero, es gedurende: gedurende de hele zomer.

⏸️ ondertussen · intussen — «mientras tanto». Es ADVERBIO, no conjuncion: no manda ningun verbo al final, y si lo pones delante arrastra la inversion. Ik kook; ondertussen dekt zij de tafel. Tambien vale in de tussentijd.

⚠️ La trampa ortografica: zolang JUNTO es la conjuncion (mientras dure) y zo lang SEPARADO es «tan largo» o «tanto tiempo». Zolang je hier bent… frente a Het duurde zo lang! (¡duro tanto!) y Een touw dat zo lang is (una cuerda tan larga).

⚠️ Y no confundas terwijl con als / toen / wanneer: terwijl marca la DURACION simultanea y los otros el MOMENTO. Toen ik binnenkwam, ging de telefoon (cuando entre, justo entonces) frente a Terwijl ik binnenkwam, ging de telefoon (mientras entraba, durante ese rato).

🏋️ Ejercicio: (a) «Mientras llueva, no salgo» → ___ het regent, ga ik niet naar buiten. (b) «Mientras cocinaba, escuchaba la radio» → ___ ik kookte, luisterde ik naar de radio. (c) «Durante la reunion no hay cafe» → ___ de vergadering is er geen koffie. (d) «Mientras tanto, ella pone la mesa» → ___ dekt zij de tafel. (Respuestas: Zolang · Terwijl · Tijdens · Ondertussen o Intussen.)',
    updated_at = datetime('now')
WHERE id IN (278, 502, 524, 731, 772, 807, 808, 837)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🕰️ Los cuatro «mientras»%';
