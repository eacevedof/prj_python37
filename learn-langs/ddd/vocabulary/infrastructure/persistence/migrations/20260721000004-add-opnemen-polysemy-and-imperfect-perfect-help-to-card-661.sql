-- Learn Languages App - Ayuda opnemen (polisemia + ∅/het/hem) e imperfectum vs perfecto (id 661)
-- Migration: 20260721000004-add-opnemen-polysemy-and-imperfect-perfect-help-to-card-661.sql
-- Description: Anade a la tarjeta "Waarom nam je niet op?" (grupo separables, id 661):
--   • un bloque ⚠️ con la polisemia de opnemen (teléfono / grabar / ingresar / sacar dinero /
--     contacto / temperatura) y como el objeto ∅ / het / hem cambia lo que se entiende
--     (het = grabar het-woord, NO el teléfono; hem = de telefoon de-woord -> coger el teléfono,
--     o grabar una cosa de-woord, o ingresar a una persona). Enlaza con la regla hem/het de 662.
--   • un bloque ⏳ explicando por que aqui va pasado simple (imperfectum) y no perfecto:
--     el perfecto es el default para un hecho suelto; el imperfectum, para narracion/escena,
--     habitos, estados y verbos frecuentes/modales.
--   Keyeada por notes (unico), idempotente (guarda con la cabecera del bloque ⚠️). Solo UPDATE
--   de words_es.rules_help; no toca words_lang/audio, imagenes ni notes.

PRAGMA foreign_keys = ON;

UPDATE words_es SET rules_help = rules_help || '

⚠️ opnemen: teléfono / grabar / ingresar — el objeto lo decide:
opnemen es polisémico; el sentido lo fija el objeto o el contexto → de telefoon opnemen = coger/contestar el teléfono · iets/een gesprek opnemen = grabar · iemand opnemen (in het ziekenhuis) = ingresar · geld opnemen = sacar dinero · contact opnemen = ponerse en contacto · de temperatuur opnemen = tomar la temperatura. Sin objeto y en contexto de llamada = contestar el teléfono (por eso esta tarjeta no lleva objeto).
El objeto ∅ / het / hem cambia lo que se entiende:
• Waarom nam je niet op? (sin objeto) = ¿por qué no cogiste el teléfono?
• Waarom heb je het niet opgenomen? → het (het-woord o genérico) = ¿por qué no lo GRABASTE? (het gesprek). het NO es el teléfono.
• Waarom heb je hem niet opgenomen? → hem = ¿por qué no lo COGISTE (de telefoon)? / lo grabaste (de film) / lo ingresaste (persona). de telefoon es de-woord → su pronombre es hem, nunca het; por eso el teléfono con pronombre vuelve con hem.

⏳ ¿Por qué pasado simple (nam op) y no perfecto (heb opgenomen)?
Para un hecho pasado suelto, el default hablado es el PERFECTO (Ik heb je gebeld). El IMPERFECTUM (nam, belde) se usa para: narración/cadena de sucesos y describir la escena, hábitos/acciones repetidas, estados y descripciones (het regende, het was koud), y los verbos frecuentes/modales (was, had, kon, wilde, moest, zou, vond, dacht). Aquí es escena narrada → Ik belde je, waarom nam je niet op? (yo llamaba, el teléfono sonaba, tú no cogías): describe ese momento, con matiz durativo. El perfecto lo trataría como hecho completado con relevancia ahora.
Regla mental: ¿cuentas/describes una escena o encadenas sucesos? → imperfectum. ¿preguntas por un hecho suelto o su resultado ahora? → perfecto.'
WHERE notes = 'Verbo separable: opnemen (pasado)'
  AND rules_help NOT LIKE '%opnemen: teléfono / grabar / ingresar%';
