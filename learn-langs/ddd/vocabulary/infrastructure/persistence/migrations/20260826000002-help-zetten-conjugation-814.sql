-- Learn Languages App - Conjugacion de zetten en la ayuda de la tarjeta 814
-- Migration: 20260826000002-help-zetten-conjugation-814.sql
-- Description: La tarjeta 814 ("Apago el motor y se bajo.") es un ejemplo de uitzetten
--   (apagar), separable de zetten (poner, colocar). Se anade a su rules_help la conjugacion
--   de zetten (presente, pasado, participio) y como se comporta el separable uitzetten en
--   cada tiempo, para que el pasado "zette ... uit" de la frase quede justificado.
--   100% aditiva e idempotente: solo UPDATE con guard (rules_help IS NULL).

UPDATE words_es
SET rules_help = 'Esta frase usa el pasado de uitzetten (apagar), separable de zetten (poner, colocar). zetten es un verbo debil (regular): raiz zet + t del ''t kofschip → -te/-ten en pasado, ge-...-t en participio.

📐 Conjugacion de zetten:
• presente — ik zet · jij/hij zet · wij/jullie/zij zetten
• pasado (imperfecto) — ik/jij/hij zette · wij/jullie/zij zetten
• participio — gezet (heeft gezet)

Con el separable uitzetten (apagar) el uit se va al final en presente y pasado, y se cuela entre ge- y -zet en el participio:
• presente — Hij zet de motor uit. — Apaga el motor.
• pasado — Hij zette de motor uit. — Apago el motor. (esta frase)
• participio — Hij heeft de motor uitgezet. — Ha apagado el motor.',
    updated_at = datetime('now')
WHERE id = 814
  AND rules_help IS NULL;
