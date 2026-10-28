-- Learn Languages App - La posicion de tenslotte y los «solo» del neerlandes (duda de la 809)
-- Migration: 20260831000015-help-tenslotte-positie-en-alleen-maar.sql
-- Description: Eduardo en la 809 («Hij is tenslotte nog maar een kind»): «¿por que no puede ser
--   Tenslotte is hij alleen maar een kind?». SI puede, es correcto, pero cambia DOS cosas a la vez
--   y hay que separarlas: (1) la POSICION de tenslotte, que admite la casilla 1 con inversion
--   —justo lo que hace la 810, «Tenslotte was het jouw idee»— o el medio de la frase, y eso es
--   cuestion de peso y no de correccion; (2) alleen maar frente a nog maar, que si cambia el
--   significado — nog maar een kind lo excusa porque TODAVIA es pequeno, alleen maar een kind
--   dice que no es otra cosa. Para disculpar a un crio el neerlandes usa casi siempre nog maar.
--   Bloque 📍 IDENTICO byte a byte con las dos posiciones y su matiz, la trampa ortografica
--   tenslotte (junto, razon) frente a ten slotte (separado, orden en una enumeracion), los
--   parientes (per slot van rekening, immers, uiteindelijk, eindelijk) y los antonimos
--   (desondanks, aanvankelijk, ten eerste). Va a 773, 809 y 810.
--   Bloque 1️⃣ IDENTICO byte a byte con los seis «solo» en tabla (maar · alleen maar · nog maar ·
--   pas · slechts · alleen) y las dos vidas de alleen segun su posicion, mas el par pas ↔ al.
--   Va a 150, 402, 677, 762 y 809.
--   Las tarjetas 809 y 810 no tenian rules_help y se crean enteras; la 810 explica ademas el
--   posesivo independiente het mijne y su concordancia de genero.
--   100% aditiva e idempotente: UPDATE con guard por marca y por rules_help IS NULL.


-- ==============================================================================
-- 1. Tarjeta 809: no tenia ayuda, se crea con su explicacion
-- ==============================================================================
UPDATE words_es
SET rules_help = 'La pregunta que plantea esta tarjeta es si valdria «Tenslotte is hij alleen maar een kind». Y la respuesta es que SI, es neerlandes correcto, pero cambia dos cosas a la vez y conviene separarlas.

📌 Lo primero, la POSICION. Poner tenslotte en la casilla 1 obliga a la inversion (is hij) y es igual de valido: la tarjeta 810 hace exactamente eso. Delante enlaza con lo dicho y pesa mas; en medio, como aqui, va atono e integrado.

⚠️ Lo segundo, y esto si cambia el significado: alleen maar NO es lo mismo que nog maar. nog maar een kind dice que TODAVIA es un nino, lo excusa porque ya crecera. alleen maar een kind dice que no es mas que un nino y nada mas, sin ese «aun». Para disculpar a un crio, el neerlandes usa casi siempre nog maar, que es lo que hace esta frase.

🔤 Los sustantivos, con su articulo: het kind (el nino), plural de kinderen. Antonimos: het kind ↔ de volwassene (el adulto), y el adjetivo kinderlijk (infantil) ↔ volwassen (adulto).',
    updated_at = datetime('now')
WHERE id = 809
  AND rules_help IS NULL;

-- ==============================================================================
-- 2. Tarjeta 810: no tenia ayuda, se crea con su explicacion
-- ==============================================================================
UPDATE words_es
SET rules_help = 'Aqui tenslotte va en la casilla 1, y por eso el verbo se queda en la 2 y el sujeto pasa detras: was het, no «het was». Es la inversion de siempre, la que provoca cualquier cosa que ocupe el primer hueco. La tarjeta 809 usa la misma palabra en el medio de la frase, sin mover nada, y las dos son correctas.

📌 El otro punto de la frase es het mijne (el mio), que es el posesivo independiente, el que va SIN sustantivo detras. Concuerda con el genero de aquello a lo que se refiere: het idee es het-woord, asi que het mijne; si fuera een de-woord seria de mijne. La serie completa es het mijne, het jouwe, het zijne, het hare, het onze, het jullie of van jullie, het hunne.

🔤 Los sustantivos, con su articulo: het idee (la idea), plural de ideeen. Antonimos del par de la frase: jouw ↔ mijn, y het jouwe ↔ het mijne.',
    updated_at = datetime('now')
WHERE id = 810
  AND rules_help IS NULL;

-- ==============================================================================
-- 3. Bloque de la posicion de tenslotte
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

📍 tenslotte puede ir delante o en medio, y las dos frases son correctas
tenslotte es un adverbio de enlace, de los que admiten dos posiciones, y el mazo tiene un ejemplo de cada una:
• en la casilla 1, y entonces el verbo se queda en la 2 y el sujeto pasa detras, que es la inversion de siempre. Tenslotte was het jouw idee. — Al fin y al cabo fue idea tuya.
• en el medio de la frase, detras del verbo y del sujeto, sin mover nada. Hij is tenslotte nog maar een kind. — Al fin y al cabo no es mas que un nino.

📌 La diferencia no es de correccion sino de peso. Delante, tenslotte encabeza y enlaza con lo que se acaba de decir, y suena a argumento que cierra la discusion. En el medio va atono e integrado, como un inciso. Si dudas, el del medio es el neutro.

⚠️ Y la trampa ortografica, que si cambia el significado: tenslotte JUNTO es «al fin y al cabo, despues de todo», o sea una razon; ten slotte SEPARADO es «por ultimo, finalmente», o sea orden en una enumeracion. Ten slotte wil ik iedereen bedanken. — Por ultimo, quiero dar las gracias a todos.

🗺️ Los parientes que hacen un trabajo parecido: per slot van rekening (al fin y al cabo, mas enfatico) · immers (es que, ya que, de lengua escrita) · uiteindelijk (al final, despues de un proceso) · eindelijk (por fin, con alivio). Los sustantivos, con su articulo: het slot (el final, y tambien la cerradura), de rekening (la cuenta).

↔️ Antonimos utiles: tenslotte (al fin y al cabo) ↔ desondanks (a pesar de eso) · uiteindelijk (al final) ↔ aanvankelijk (al principio) · ten slotte (por ultimo) ↔ ten eerste (en primer lugar).',
    updated_at = datetime('now')
WHERE id IN (773, 809, 810)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%📍 tenslotte puede ir delante o en medio%';

-- ==============================================================================
-- 4. Bloque de los «solo» del neerlandes
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

1️⃣ Los «solo» del neerlandes, que no son intercambiables

| en espanol | en NL | que anade |
|---|---|---|
| solo, nada mas | **maar** | el mas neutro. Hij is **maar** een kind. |
| solo, y nada mas que eso | **alleen maar** | refuerza la restriccion. Je hoeft **alleen maar** te bellen. |
| solo, TODAVIA solo | **nog maar** | anade el «aun»: es pequeno y ya crecera. Hij is **nog maar** een kind. |
| solo, no antes de (tiempo) | **pas** | marca que es mas tarde de lo esperado. Hij komt **pas** om acht uur. |
| solo, unicamente (formal) | **slechts** | de lengua escrita. **Slechts** een enkele keer. |
| solo, a solas | **alleen** | aqui no restringe, dice «sin nadie». Hij reist **alleen**. |

📌 El par que de verdad se confunde es nog maar y alleen maar. Los dos son correctos hablando de un nino, pero dicen cosas distintas: nog maar een kind lo excusa porque TODAVIA es pequeno y ya crecera, mientras que alleen maar een kind dice que no es otra cosa mas que un nino. Para disculpar a un crio, el neerlandes usa casi siempre nog maar.

⚠️ Y ojo con alleen, que tiene dos vidas segun donde caiga: delante de un sustantivo o pegado a maar es restrictivo y significa «solo»; detras del verbo y sin maar significa «a solas, sin compania». Hij reist alleen. — Viaja solo, sin nadie.

↔️ Antonimos: alleen (a solas) ↔ samen (juntos) · alleen maar ↔ ook y bovendien (ademas) · pas ↔ al (ya), que es el par mas util: Hij komt pas om acht uur frente a Hij is er al.',
    updated_at = datetime('now')
WHERE id IN (150, 402, 677, 762, 809)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%1️⃣ Los «solo» del neerlandes%';
