-- Learn Languages App - Ayuda: perfecto = auxiliar en presente + doble infinitivo (tarjeta 630)
-- Migration: 20260811000002-help-perfect-present-aux-double-infinitive-630.sql
-- Description: Eduardo (630 "Ik ben even gaan liggen" = me he echado un rato) se lia: en
--   espanol es pret. perfecto pero el NL "parece presente" porque ben es presente y gaan
--   liggen son infinitivos. Bloque 🔨: el perfecto se construye IGUAL en los dos idiomas
--   (auxiliar EN PRESENTE + verbo): ES he+echado, NL ben+gaan liggen; que ben este en
--   presente es lo normal (= tu "he"). + regla del DOBLE INFINITIVO / IPP (gaan, no gegaan,
--   porque lleva otro infinitivo detras). + contraste presente (Ik ga liggen) vs perfecto
--   (Ik ben gaan liggen). Card ya aplicada -> migracion nueva. Keyeada por id, idempotente
--   por 🔨, solo rules_help.

PRAGMA foreign_keys = ON;

-- 630 · perfecto: auxiliar en presente (= "he") + doble infinitivo (gaan, no gegaan)
UPDATE words_es SET rules_help = rules_help || '

🔨 ¿Por que "Ik ben even gaan liggen" parece presente si significa "me HE echado"?
El perfecto se construye IGUAL en los dos idiomas: auxiliar EN PRESENTE + verbo.
- ES: he (presente de haber) + echado.
- NL: ben (presente de zijn) + gaan liggen.
Que ben este en presente es NORMAL y obligatorio: es el equivalente EXACTO de tu "he". Nadie dice que "me he echado" sea presente; es pret. perfecto, y se forma con el auxiliar en presente + el verbo. En NL igual: presente de zijn/hebben (ben/heb) + verbo = perfecto. Eso lo hace pasado, no presente.

Doble infinitivo (por que gaan y no el participio gegaan): cuando el verbo que iria en participio (gaan) lleva OTRO infinitivo detras (liggen), NO va en participio -> se queda en infinitivo. Por eso ben + gaan + liggen (dos infinitivos), literal "he ido a tumbarme". Pasa igual con komen / laten / zien / horen y los modales: Ik heb hem zien komen (no gezien), Ik heb het laten vallen (no gelaten). Es la regla IPP (infinitivus pro participio / vervangende infinitief).
Auxiliar zijn (ben) porque gaan = movimiento / cambio de posicion.

Contraste presente vs perfecto (para fijarlo):
- Presente / futuro cercano: Ik ga even liggen = me echo / voy a echarme (ahora). UN solo verbo conjugado: ga.
- Perfecto: Ik ben even gaan liggen = me he echado (ya hecho). Auxiliar ben + doble infinitivo.
El chivato de que es perfecto NO es el tiempo de ben, sino la presencia del auxiliar ben/heb + la forma no conjugada detras (como tu "he" + participio).'
WHERE id = 630 AND COALESCE(rules_help,'') NOT LIKE '%🔨%';
