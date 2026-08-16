-- Learn Languages App - Fix: tarjeta 714 «pon la mesa» (grupo 24, variantes de poner)
-- Migration: 20260816000001-fix-714-pon-la-mesa-split-imperative.sql
-- Description: La 714 no casaba en persona: el lado ES iba en IMPERATIVO («pon la mesa»)
--   y el NL en 1a persona («Ik dek de tafel»). El verbo era correcto (dekken, el falso
--   amigo); lo que fallaba era el modo. Su rules_help ya estaba escrito entero para la
--   1a persona (📐 "sujeto + dek en 2a posicion" y el 🏋️ «pongo la mesa» → Ik ___ de
--   tafel), asi que se arregla el lado ES y el imperativo pasa a tarjeta propia.
--   1) UPDATE 714: text 'pon la mesa' -> 'pongo la mesa' (rules_help INTACTO, ya encajaba).
--   2) INSERT tarjeta nueva 'pon la mesa' -> 'Dek de tafel.' con su rules_help en
--      imperativo (mismo bloque 🗺️ compartido del grupo, 📐/🧭/🏋️ propios), en los
--      grupos 24 y generic.
--   Keyeada por id (714) y por text+notes (la nueva). IDEMPOTENTE. No toca audios ni
--   imagenes (714 no tenia mp3 generado ni fila en word_es_media).

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. 714: el lado ES pasa a 1a persona (el NL 'Ik dek de tafel.' se queda igual)
-- ==============================================================================
UPDATE words_es
SET text = 'pongo la mesa',
    updated_at = datetime('now')
WHERE id = 714 AND text = 'pon la mesa';

-- ==============================================================================
-- 2. Tarjeta nueva: el imperativo «pon la mesa» -> Dek de tafel.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pon la mesa', 'PHRASE', 'poner: de tafel dekken (imperativo, falso amigo)', 'FALSO AMIGO: «poner la mesa» = de tafel DEKKEN, NO «de tafel zetten» ni «leggen». dekken = poner / preparar la mesa (mantel, platos, cubiertos). Aqui en IMPERATIVO: Dek de tafel = pon la mesa. Su tarjeta hermana es «pongo la mesa» → Ik dek de tafel (1a persona).

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Imperativo: Dek (1a posicion, SIN sujeto) + de tafel. El imperativo neerlandes es la raiz pelada: dekken → dek (sin -t y sin ik). Igual que Zet de vaas op tafel o Leg het boek op tafel.

🧭 Cuando usarlo: pedirle a alguien que prepare la mesa antes de comer. Ej.: → Dek de tafel, het eten is bijna klaar (pon la mesa, la comida esta casi lista). Mas suave: Kun je de tafel dekken?

🏋️ Ejercicio: «pon la mesa» (se lo pides a otro) → ___ de tafel. (Respuesta: Dek. Imperativo: sin ik y sin -t. Y OJO: dekken, no zetten ni leggen.)'
WHERE NOT EXISTS (
    SELECT 1 FROM words_es
    WHERE text = 'pon la mesa' AND notes = 'poner: de tafel dekken (imperativo, falso amigo)'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'pon la mesa' AND notes = 'poner: de tafel dekken (imperativo, falso amigo)' LIMIT 1),
    'nl_NL', 'Dek de tafel.', 'Dek de tafel.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pon la mesa' AND notes = 'poner: de tafel dekken (imperativo, falso amigo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pon la mesa' AND notes = 'poner: de tafel dekken (imperativo, falso amigo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
