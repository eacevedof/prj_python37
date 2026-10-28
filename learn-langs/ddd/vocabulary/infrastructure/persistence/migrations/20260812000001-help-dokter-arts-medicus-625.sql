-- Learn Languages App - Ayuda: dokter vs arts vs medicus (tarjeta 625)
-- Migration: 20260812000001-help-dokter-arts-medicus-625.sql
-- Description: Eduardo (625 "Ze is dokter geworden" = se ha hecho medica) pregunta si vale
--   medicus en lugar de dokter. Bloque 🩺: medicus existe pero es formal/latinizado y raro
--   aqui; las naturales son dokter (coloquial, ir al medico / tratamiento) y arts
--   (designacion profesional: huisarts/tandarts). "Ze is arts geworden" tan valido como
--   dokter. medicus (pl. medici) = registro culto/colectivo (de medici, medisch
--   personeel). Recordatorio: tras worden/zijn la PROFESION va SIN articulo. Card ya
--   aplicada -> migracion nueva. Keyeada por id, idempotente por 🩺, solo rules_help.

PRAGMA foreign_keys = ON;

-- 625 · dokter vs arts vs medicus
UPDATE words_es SET rules_help = rules_help || '

🩺 ¿Vale "medicus" en lugar de "dokter"? Se entiende, pero NO es lo natural aqui. Hay tres palabras y cambian de registro:
- dokter = medico/doctor, la palabra del DIA A DIA: naar de dokter gaan (ir al medico) y como tratamiento (Dokter, ik heb pijn). Es la de la tarjeta, 100% natural.
- arts = medico como DESIGNACION PROFESIONAL (la mas oficial): huisarts (medico de cabecera), tandarts (dentista), kinderarts, specialist. "Ze is arts geworden" es igual de natural que "dokter geworden", incluso un pelin mas preciso para "sacarse la carrera de medicina".
- medicus (plural medici) = termino FORMAL/culto, de registro escrito o colectivo (de medici = el gremio medico, medisch personeel). "Ze is medicus geworden" se entiende pero suena rigido; un nativo dice dokter o arts.

Resumen: para esta frase -> dokter (coloquial) o arts (profesional). medicus, no.

📝 Recuerda: tras worden/zijn la PROFESION va SIN articulo -> Ze is dokter geworden (no "een dokter"). Igual: Hij is leraar, Ze wordt advocaat.'
WHERE id = 625 AND COALESCE(rules_help,'') NOT LIKE '%🩺%';
