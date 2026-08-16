-- Learn Languages App - Ayuda: bellen vs opbellen (tarjeta 633)
-- Migration: 20260810000008-help-bellen-vs-opbellen-633.sql
-- Description: Eduardo (633 "Ik bel je straks" = te llamo luego) pregunta si vale
--   "Ik bel je straks op". SI. Bloque 📞: bellen (llamar, el normal hoy, objeto directo
--   sin naar) y opbellen (op+bellen, separable, mismo significado, un pelin mas explicito/
--   anticuado) son ambas correctas; opbellen lleva op al final. Mismo LOTE pendiente
--   (version 1.1.1). Keyeada por id, idempotente por emoji-guarda 📞, solo UPDATE de rules_help.

PRAGMA foreign_keys = ON;

-- 633 · bellen vs opbellen
UPDATE words_es SET rules_help = rules_help || '

📞 ¿Vale "Ik bel je straks op"? SI.
"Ik bel je straks" y "Ik bel je straks op" son las dos correctas y significan lo mismo (te llamo luego).
- bellen = llamar (por telefono). Es el verbo NORMAL y mas usado hoy: Ik bel je. Toma objeto directo (iemand bellen), SIN naar: no "ik bel naar je".
- opbellen (op + bellen) = llamar por telefono, verbo separable; MISMO significado, un pelin mas explicito/formal (y algo mas anticuado para muchos). El prefijo op se va al FINAL: Ik bel je straks op.
En el dia a dia se dice mas "Ik bel je straks" (sin op); "Ik bel je straks op" no esta mal, solo suena algo mas marcado.
Ojo (perfecto): las dos valen -> Ik heb je gebeld / Ik heb je opgebeld (op+ge+beld = opgebeld).'
WHERE id = 633 AND COALESCE(rules_help,'') NOT LIKE '%📞%';
