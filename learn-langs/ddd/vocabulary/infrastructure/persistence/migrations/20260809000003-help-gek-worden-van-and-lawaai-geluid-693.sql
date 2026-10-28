-- Learn Languages App - Ayuda: gek worden VAN (causa) + lawaai vs geluid (tarjeta 693)
-- Migration: 20260809000003-help-gek-worden-van-and-lawaai-geluid-693.sql
-- Description: Un bloque a la 693 ("Ik word gek van dit lawaai" = me vuelvo loco con este ruido):
--   🔊 preposicion VAN (no met) para la CAUSA de un estado con worden (gek/moe/ziek/blij
--     worden van...); y lawaai (ruido molesto/jaleo, negativo) vs geluid (sonido neutro) vs
--     herrie (jaleo coloquial). Por que no "gek met dit geluid".
--   Keyeada por texto nl_NL, idempotente por emoji-guarda. Solo UPDATE de rules_help.

PRAGMA foreign_keys = ON;

-- 693 · gek worden VAN + lawaai vs geluid
UPDATE words_es SET rules_help = rules_help || '

🔊 gek worden VAN (no "met") + lawaai vs geluid (¿por que no "gek met dit geluid"?)
Dos correcciones sobre "ik word gek met dit geluid":
1) Preposicion: para la CAUSA de un estado/reaccion con worden se usa VAN (= de/por), NO met. gek worden van = volverse loco por/de algo. Igual: moe worden van (cansarse de), ziek worden van, blij worden van. "met" = con (compañia/instrumento), no expresa causa -> "gek met dit geluid" no cuadra. (Es del tipo de preposiciones que difieren del español, como verliefd worden OP.)
2) lawaai vs geluid:
   • lawaai = RUIDO molesto, jaleo, estruendo, alboroto (negativo) -> lo que te vuelve loco.
   • geluid = SONIDO (cualquiera), neutro. "van dit geluid" es correcto pero significa "de este sonido" (sin matiz de molestia).
   • herrie = sinonimo coloquial de lawaai (jaleo/bulla).
Frase natural: Ik word gek van dit lawaai (con VAN y con lawaai por el matiz de ruido molesto).'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Ik word gek van dit lawaai.')
  AND COALESCE(rules_help,'') NOT LIKE '%🔊%';
