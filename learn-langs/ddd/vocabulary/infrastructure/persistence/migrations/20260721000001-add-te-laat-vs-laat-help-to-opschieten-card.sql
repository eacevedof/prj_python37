-- Learn Languages App - Aviso te laat vs laat en la tarjeta opschieten (id 670)
-- Migration: 20260721000001-add-te-laat-vs-laat-help-to-opschieten-card.sql
-- Description: Anade un bloque ⚠️ al rules_help de la tarjeta "Schiet op, we komen te laat!"
--   (grupo verbos separables, id 670) aclarando la diferencia:
--   • te laat = demasiado tarde / con retraso -> «te laat komen» es la formula fija para
--     llegar tarde a una hora limite (cita, tren, clase). Es lo que justifica la prisa.
--   • laat (sin te) = a una hora tardia, neutro; no implica retraso ni justifica meter prisa,
--     por eso «Schiet op, we komen laat» suena contradictorio.
--   Keyeada por notes (unico), idempotente (guarda NOT LIKE '%⚠️%'). Solo UPDATE de
--   words_es.rules_help; no toca words_lang/audio, imagenes ni notes.

PRAGMA foreign_keys = ON;

UPDATE words_es SET rules_help = rules_help || '

⚠️ te laat vs laat:
• we komen te laat = llegamos DEMASIADO TARDE / con retraso. te es el intensificador «demasiado» (te duur, te groot, te laat). «te laat komen» es la fórmula FIJA para llegar tarde respecto a una hora límite (una cita, el tren, la clase, el trabajo): implica «más tarde de lo que deberíamos / vamos a perderlo». Es lo que justifica meter prisa.
• we komen laat = llegamos a una HORA TARDÍA (neutro), solo describe el momento del día; no implica retraso ni incumplir una hora → We komen laat thuis = llegaremos tarde a casa (un dato, no un problema).
Por eso «Schiet op, we komen laat» suena contradictorio (¿date prisa… para llegar a hora tardía?): la prisa la justifica te laat, no laat.
Regla mental: si hay una hora que cumplir (cita, tren, empezar algo) → te laat; si solo describes que será de noche/hora tardía → laat.'
WHERE notes = 'Verbo separable: opschieten (imperativo)' AND rules_help NOT LIKE '%⚠️%';
