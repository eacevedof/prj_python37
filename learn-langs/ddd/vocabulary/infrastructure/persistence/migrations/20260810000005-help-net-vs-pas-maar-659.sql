-- Learn Languages App - Ayuda: net vs pas vs maar (tarjeta 659)
-- Migration: 20260810000005-help-net-vs-pas-maar-659.sql
-- Description: Eduardo (659 "We zijn net aangekomen" = acabamos de llegar) pregunta por
--   que "net" y no "pas" ni "maar". Bloque 🕐: net = justo ahora, hace un instante (el
--   "acabar de" inmediato); pas = recien en marco amplio (dias/semanas) o "no...hasta/solo"
--   con tiempo; maar = "pero" / "solo-nada mas" (restriccion) / suavizador, no expresa
--   "recien" -> no encaja por significado. Va al mismo LOTE pendiente (version se mantiene
--   1.1.1, sin bump). Keyeada por id, idempotente por emoji-guarda 🕐, solo UPDATE de rules_help.

PRAGMA foreign_keys = ON;

-- 659 · net vs pas vs maar
UPDATE words_es SET rules_help = rules_help || '

🕐 ¿Por que "net" y no "pas" ni "maar"?
Las tres palabras existen, pero solo "net" da el sentido de "acabar de (ahora mismo)":
- net = justo ahora, hace un instante (segundos/minutos). Es el "acabar de" INMEDIATO: We zijn net aangekomen = acabamos de llegar (en este momento). (Ademas net = exacto/justo: net op tijd = justo a tiempo; net zoals = igual que.)
- pas = "recien" pero en marco MAS AMPLIO (hace poco: dias/semanas), o "no ... hasta / solo" con tiempo. We zijn pas verhuisd = nos mudamos hace poco (no hace mucho, pero no "en este segundo"). Hij komt pas om 8 uur = no viene hasta las 8. Con aangekomen sonaria a "recien llegados hace un rato" o "no ... hasta ahora": cambia el matiz. Para "justo ahora" -> net.
- maar = NO encaja aqui, por significado: es "pero" (conjuncion), o "solo / nada mas" (restriccion: Ik heb maar een euro = solo tengo un euro), o suavizador (Doe maar = venga, hazlo). No expresa "recien / acabar de".

Regla rapida: acabar de + AHORA MISMO -> net · hace poco (marco amplio) / no...hasta -> pas · pero / solo (cantidad) -> maar (otro significado).'
WHERE id = 659 AND COALESCE(rules_help,'') NOT LIKE '%🕐%';
