-- Learn Languages App - Ayuda 641: dagelijks vs elke dag
-- Migration: 20260820000009-help-dagelijks-vs-elke-dag-641.sql
-- Description: Eduardo pregunta por que no se puede decir «Ik zie ze bijna dagelijks».
--   Matiz importante: SI se puede — es correcto y se lee a diario en prensa —, lo que pasa
--   es que dagelijks es de registro ESCRITO/formal y su sitio natural es el de ADJETIVO
--   (het dagelijks leven, de dagelijkse routine, het dagelijks bestuur). Hablando se dice
--   elke dag, que es lo que trae la tarjeta. Bloque 🗓️ con la aclaracion, la familia entera
--   (wekelijks/maandelijks/jaarlijks, igual de formales), la escala de frecuencia hablada
--   (elke dag · iedere dag · bijna elke dag · om de dag · dag in dag uit) y la flexion del
--   adjetivo, con la excepcion fosilizada het dagelijks leven / het dagelijks bestuur.
--   El bloque entra ANTES del cierre 📐 para no romper la estructura de la tarjeta.
--   Solo UPDATE de rules_help. IDEMPOTENTE por emoji-guarda (NOT LIKE '%🗓️%').
--   Escrita fuera de migrations/ y movida ya terminada (leccion del 2026-08-20).

UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '📐 Oración principal (hoofdzin)',
    '🗓️ ¿Y «Ik zie ze bijna dagelijks»? Sí se puede, pero suena a papel:
No está mal: es correcto y lo lees a diario en prensa e informes. Lo que pasa es que dagelijks es de registro ESCRITO y formal; hablando, un neerlandés dice bijna elke dag.
• El sitio natural de dagelijks es el de ADJETIVO: het dagelijks leven (la vida cotidiana) · de dagelijkse routine · het dagelijks bestuur (la junta directiva) · de dagelijkse boodschappen.
• Toda su familia va igual — wekelijks, maandelijks, jaarlijks son de papel; al hablar se dice elke week, elke maand, elk jaar.
📊 La escala de frecuencia, de lo hablado a lo formal:
• elke dag = todos los días (lo neutro y lo que dirías tú).
• iedere dag = lo mismo, un punto más enfático o más cuidado.
• bijna elke dag = casi a diario (el de esta tarjeta).
• om de dag = un día sí y otro no. Ojo, NO es «cada día».
• dag in dag uit = día tras día, con hartazgo.
• dagelijks = a diario, formal y escrito.
⚠️ Cuidado con la flexión: de adverbio va pelado (Hij belt dagelijks); de adjetivo delante del sustantivo lleva -e (de dagelijkse routine), salvo en las expresiones fijas het dagelijks leven y het dagelijks bestuur, que se quedaron sin -e.

📐 Oración principal (hoofdzin)'
)
WHERE id = 641
  AND rules_help LIKE '%📐 Oración principal (hoofdzin)%'
  AND rules_help NOT LIKE '%🗓️%';
