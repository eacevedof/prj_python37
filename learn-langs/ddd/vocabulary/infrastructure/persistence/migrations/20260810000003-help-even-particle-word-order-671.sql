-- Learn Languages App - Ayuda: posicion de "even" (particula modal) en la 671
-- Migration: 20260810000003-help-even-particle-word-order-671.sql
-- Description: Eduardo (671 "Zet je telefoon even uit") pregunta por que no
--   "Zet je even je telefoon uit", creyendo que "even" es tiempo (T) y debe seguir
--   la formula S-V-T-M-P. Dos correcciones (bloque ↔️): (1) "je" aqui es el POSESIVO
--   "tu" (je telefoon), no el sujeto -> el imperativo no lleva sujeto; (2) "even" NO es
--   complemento de tiempo sino PARTICULA MODAL/suavizador (even/maar/eens/nou/toch), no
--   la T de la formula. Orden del middenveld: objeto definido antes de even, pronombre
--   aun mas adelante, objeto indefinido despues de even. Keyeada por id, idempotente por
--   emoji-guarda ↔️, solo UPDATE de rules_help.

PRAGMA foreign_keys = ON;

-- 671 · posicion de "even" (particula modal, no tiempo)
UPDATE words_es SET rules_help = rules_help || '

↔️ ¿Por que "Zet je telefoon even uit" y no "Zet je even je telefoon uit"? (posicion de "even")
Dos cosas que lian aqui:
1) "je" NO es el sujeto: es el POSESIVO "tu" -> je telefoon = tu movil. El imperativo NO lleva sujeto. La frase es: Zet (verbo) + je telefoon (objeto) + even + uit (prefijo). Por eso "Zet je even je telefoon uit" no cuadra (aparecen dos "je").
2) "even" NO es un complemento de TIEMPO (no es la T de la formula S-V-T-M-P). Es una PARTICULA MODAL / suavizador (even, maar, eens, nou, toch) = "un momentito / porfa / sin mas"; quita brusquedad al imperativo. El tiempo de verdad son nu, straks, vandaag, om 8 uur. Por eso la formula S-V-T-M-P no manda sobre "even".

Orden del campo central (middenveld): lo CONOCIDO/definido va delante, lo NUEVO/indefinido detras; "even" marca la frontera y se pega al bloque final (prefijo/verbo):
- Objeto definido/conocido (je telefoon, de tv, het licht) -> ANTES de even: Zet je telefoon even uit · Doe het licht even uit.
- Objeto pronombre -> aun mas adelante: Zet hem even uit (hem = el movil).
- Objeto indefinido (een film, wat muziek) -> DESPUES de even: Zet even een film aan · Zet even wat muziek op.

¿"Zet even je telefoon uit" esta mal? No es agramatical, pero suena menos natural: adelantar "even" da foco al "un momento/porfa" y deja el objeto conocido detras, contra el principio "lo conocido primero". El orden neutro es Zet je telefoon even uit.'
WHERE id = 671 AND COALESCE(rules_help,'') NOT LIKE '%↔️%';
