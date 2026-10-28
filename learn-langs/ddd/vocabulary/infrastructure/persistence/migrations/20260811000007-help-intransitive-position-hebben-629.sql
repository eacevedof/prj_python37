-- Learn Languages App - Ayuda: intransitivo de posicion + hebben (tarjeta 629)
-- Migration: 20260811000007-help-intransitive-position-hebben-629.sql
-- Description: Eduardo pregunta como identificar si un verbo lleva hebben o zijn cuando
--   es intransitivo (no responde a "wat?"). Regla: transitivo -> hebben siempre;
--   intransitivo de movimiento/cambio de estado -> zijn; intransitivo de posicion/estado
--   estatico (staan/liggen/zitten/hangen) -> hebben. Bloque 📐.

PRAGMA foreign_keys = ON;

-- 629 · regla transitivo/intransitivo y eleccion de auxiliar
UPDATE words_es SET rules_help = rules_help || '

📐 ¿Por que staan (e.g. 629) usa HEBBEN si es intransitivo (no responde a "wat?")? Porque la regla del auxiliar NO es "transitivo = hebben / intransitivo = zijn". La regla real es:

- Transitivo (tiene CD, responde a "wat?") -> HEBBEN siempre.
  Ik heb een boek gekocht. / Hij heeft de kat gezien.

- Intransitivo de MOVIMIENTO o CAMBIO DE ESTADO -> ZIJN.
  Hij is gevallen. / Ze is vertrokken. / Het water is bevroren.

- Intransitivo de POSICION / ESTADO ESTATICO -> HEBBEN.
  staan / liggen / zitten / hangen -> geen beweging, geen verandering.
  We hebben uren in de file gestaan. (629)
  De kat heeft op de bank gelegen.
  Hij heeft de hele dag gezeten.

Truco mental: pregunta DOS cosas al verbo.
1. ¿Responde a "wat?"? -> SI = hebben (transitivo).
2. ¿No responde? -> ¿Implica movimiento o cambio? -> SI = zijn / NO = hebben.

staan/liggen/zitten no implican ni movimiento ni cambio: el sujeto ya estaba en esa posicion. Por eso hebben, aunque sean intransitivos.'
WHERE id = 629 AND COALESCE(rules_help,'') NOT LIKE '%📐%';
