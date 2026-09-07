-- Learn Languages App - Migration
-- Migration: 20260907000009-leuk-fijn-prima-gezellig
-- Description: Eduardo, sobre la tarjeta 213 (dat zou leuk zijn = seria genial): "no puede
--   ser dat zou prima zijn?".
--
--   Si se puede y se dice, pero significa otra cosa: leuk es entusiasmo (chulo, divertido,
--   agradable) y prima es conformidad (perfecto, sin problema, me viene bien). A la
--   pregunta ¿quedamos el martes?, Dat zou leuk zijn es me haria ilusion y Dat zou prima
--   zijn es me viene perfecto, sin emocion ninguna. prima es funcional y algo frio, el
--   normal en contexto de trabajo; leuk es social.
--   Y de paso se corrige un matiz de la propia tarjeta: «seria genial» es mas entusiasta
--   que leuk. Dat zou leuk zijn es mas bien estaria bien o seria chulo; genial de verdad
--   seria Dat zou geweldig zijn.
--
--   La duda destapa que el mazo tiene leuk (213, 367, 531), fijn (315) y lekker (340, 501,
--   598, 615) sueltos, CERO prima, CERO gezellig y nada que los compare. Se escribe el
--   bloque compartido "😊 leuk, fijn, prima o gezellig" con la escala completa por
--   intensidad y por tipo de agrado, y se inyecta en las ocho tarjetas que usan alguno.
--   Incluye gezellig, que es la palabra holandesa por excelencia y no estaba en el mazo, y
--   los avisos de que prima es invariable y de que Ik vind hem leuk puede leerse como me
--   gusta en sentido romantico.
--
--   Pendiente, no entra aqui: gezellig y prima no existen como tarjetas WORD propias y
--   merecerian una cada una. Se deja apuntado.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. La 213: la duda concreta
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: ¿No puede ser Dat zou prima zijn?

🔑 La diferencia: Si se puede, y se dice, pero dice otra cosa. leuk es ENTUSIASMO y prima es CONFORMIDAD. A la pregunta Zullen we dinsdag afspreken?, Dat zou leuk zijn es me haria ilusion, y Dat zou prima zijn es me viene perfecto, sin emocion ninguna. prima es funcional y algo frio, el que usarias con un cliente; leuk es el social, el de los amigos.

⚠️ Y un matiz de esta misma tarjeta: «seria genial» en español es mas entusiasta que leuk. Dat zou leuk zijn es en realidad estaria bien o seria chulo. Para genial de verdad, Dat zou geweldig zijn of Dat zou super zijn.

📋 La misma respuesta, en los cuatro registros:
• Dat zou prima zijn. — Me viene perfecto. (conformidad seca)
• Dat zou fijn zijn. — Estaria bien. (alivio, bienestar)
• Dat zou leuk zijn. — Seria chulo. (entusiasmo normal)
• Dat zou geweldig zijn. — Seria genial. (entusiasmo alto)

🏋️ Ejercicio: te proponen una reunion que te va bien pero que no te hace ilusion → Dat zou ___ zijn. (Respuesta: prima.)'
WHERE id = 213
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';

-- =============================================================================
-- 2. Bloque compartido: la escala de leuk, fijn, prima y compañia
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

😊 leuk, fijn, prima o gezellig, que no son intercambiables:

El español tira de bien, bueno y genial para casi todo. El neerlandes reparte por TIPO de agrado, no solo por intensidad.

| palabra | que dice | cuando la usas |
|---|---|---|
| **prima** | perfecto, sin problema | conformidad seca. Dat is **prima**. |
| **goed** | bien | neutro, valorativo. Het is **goed** zo. |
| **fijn** | agradable, que sienta bien | bienestar o alivio. Wat **fijn** dat je er bent. |
| **leuk** | chulo, divertido, majo | entusiasmo social. Een **leuk** idee. |
| **gezellig** | a gusto, en buena compañia | ambiente. Het was heel **gezellig**. |
| **mooi** | bonito | estetico. Een **mooie** foto. |
| **lekker** | rico, o a gusto | sensorial. **Lekker** weer. |
| **geweldig** | genial, estupendo | entusiasmo alto. Dat is **geweldig**! |

🇳🇱 gezellig es LA palabra holandesa y no se puede traducir de una pieza: es lo agradable de estar con gente, el ambiente acogedor de una casa, una cena o un bar. Het was gezellig es lo que se dice al despedirse de una cena, y Doe niet zo ongezellig es no seas aguafiestas. Si te preguntan como estuvo algo social y contestas gezellig, has contestado como un nativo.

⚠️ Tres avisos que evitan errores:
• prima es INVARIABLE: een prima idee, nunca «een primaa idee». Y va sola como respuesta: Prima!
• Ik vind hem leuk con una persona puede entenderse como me gusta en sentido romantico. Para decir que alguien te cae bien sin equivoco, Ik vind hem aardig.
• lekker es sobre todo comida, pero tambien lekker weer (buen tiempo), lekker slapen (dormir a gusto) y Ik voel me niet lekker (no me encuentro bien). No es un elogio de belleza.

🔑 El truco para elegir: Pregunta que tipo de agrado es. ¿Te conformas? prima. ¿Te sienta bien? fijn. ¿Te divierte? leuk. ¿Es el ambiente con gente? gezellig. ¿Entra por los ojos? mooi. ¿Por la boca o el cuerpo? lekker. ¿Te emociona? geweldig.'
WHERE id IN (213, 315, 340, 367, 501, 531, 598, 615)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%😊 leuk, fijn, prima o gezellig%';
