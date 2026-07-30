-- Learn Languages App - Grupo "verbos de obligación con te - moeten of hoeven te"
-- Migration: 20260726000001-create-obligation-verbs-te-group.sql
-- Description: 13 frases cotidianas sobre la obligación/necesidad y el uso del «te».
--   Eje central: moeten (MODAL, SIN te = tener que) frente a hoeven (SEMIMODAL, CON te,
--   casi siempre en negativo = no hacer falta). Nace de la duda "Nee, ik moet morgen
--   niet werken" (mal) vs "Nee, ik hoef morgen niet te werken" (bien). Se añaden los
--   verbos que encadenan infinitivo con te (proberen, vergeten, beloven, hopen, durven)
--   y la finalidad om … te, para fijar la regla del te. rules_help = nota de la tarjeta +
--   bloque compartido (moeten vs hoeven + por qué hoeven y no moeten + regla del te +
--   separables con te + TRUCO MENTAL) + 📐 fórmula + 🧭 ejemplo. La tarjeta estrella lleva
--   la frase pedida (Nee, ik hoef morgen niet te werken). Pronunciation con
--   DutchToSpanishPhoneticService. 100% aditiva e IDEMPOTENTE (INSERT ... WHERE NOT EXISTS
--   / OR IGNORE). No toca audios ni imágenes existentes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'verbos de obligación con te - moeten of hoeven te',
    'Obligación y necesidad y el uso del te: moeten (modal, SIN te = tener que) frente a hoeven (semimodal, CON te y en negativo = no hacer falta); más los verbos que encadenan infinitivo con te (proberen, vergeten, beloven, hopen, durven) y la finalidad om … te. Responde a la duda moeten vs hoeven (Nee, ik hoef morgen niet te werken)',
    'migracion'
);

-- ==============================================================================
-- moeten (presente, sin te): Ik moet nu naar huis.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tengo que irme a casa ahora', 'PHRASE', 'Obligación con te: moeten (presente, sin te)', 'moeten = tener que / deber (obligación); verbo MODAL, SIN te. Con «naar + lugar» y sin verbo pleno significa tener que ir allí → Ik moet naar huis = tengo que ir a casa. nu = ahora.

Obligación y el «te» en neerlandés:
• moeten = tener que / deber (obligación). Es MODAL → NO lleva te: Ik moet werken.
• hoeven = la versión NEGATIVA de moeten: no hacer falta / no tener por qué. SIEMPRE lleva te y casi siempre va con negación (niet, geen, nooit) o restricción (alleen maar): Ik hoef niet te werken.
  ¿Por qué hoeven y no «moeten niet»? Porque cambia el significado: Je moet niet werken = no DEBES trabajar (casi prohibición) · Je hoeft niet te werken = no HACE FALTA que trabajes (no hay obligación). Para negar la obligación se cambia a hoeven + niet + te; no se niega moeten.
• La regla del «te»: los MODALES (moeten, kunnen, mogen, willen, zullen) NUNCA llevan te. hoeven SÍ (es semimodal). Los verbos que encadenan otro infinitivo (proberen, vergeten, beloven, hopen, durven, besluiten, weigeren…) van con te. La finalidad (para…) se dice con om … te.
• Separables con te: el te se cuela DENTRO → opbellen → op te bellen, terugbellen → terug te bellen, meenemen → mee te nemen.
Truco mental: si dices «tengo que» → moeten (sin te); si dices «no hace falta / no tengo por qué» → hoeven … niet te (con te). hoeven ya lleva la negación dentro y arrastra el te.

📐 Presente (frase principal): sujeto + moet (2ª posición) + tiempo + destino (naar huis) al final. Modal SIN te.

🧭 Cuándo usarlo: despedirte porque te tienes que ir. Ej.: → Sorry, ik moet nu naar huis (perdona, tengo que irme a casa ahora).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'tengo que irme a casa ahora' AND notes = 'Obligación con te: moeten (presente, sin te)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'tengo que irme a casa ahora' AND notes = 'Obligación con te: moeten (presente, sin te)' LIMIT 1),
    'nl_NL', 'Ik moet nu naar huis.', 'Ik mut nu nar aus.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tengo que irme a casa ahora' AND notes = 'Obligación con te: moeten (presente, sin te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos de obligación con te - moeten of hoeven te'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tengo que irme a casa ahora' AND notes = 'Obligación con te: moeten (presente, sin te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- ★ hoeven (negativo, con te): Nee, ik hoef morgen niet te werken.  [FRASE PEDIDA]
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no hace falta que trabaje mañana', 'PHRASE', 'Obligación con te: hoeven (negativo, con te)', 'hoeven = (no) hacer falta; es la versión NEGATIVA de moeten y SIEMPRE lleva te. Responde a Ga je morgen naar kantoor? (¿vas mañana a la oficina?) → Nee, ik hoef morgen niet te werken (no, no hace falta que trabaje mañana). OJO: no se dice «Nee, ik moet morgen niet werken» — eso significaría no DEBES trabajar (casi prohibición) y además le falta el te. morgen = mañana.

Obligación y el «te» en neerlandés:
• moeten = tener que / deber (obligación). Es MODAL → NO lleva te: Ik moet werken.
• hoeven = la versión NEGATIVA de moeten: no hacer falta / no tener por qué. SIEMPRE lleva te y casi siempre va con negación (niet, geen, nooit) o restricción (alleen maar): Ik hoef niet te werken.
  ¿Por qué hoeven y no «moeten niet»? Porque cambia el significado: Je moet niet werken = no DEBES trabajar (casi prohibición) · Je hoeft niet te werken = no HACE FALTA que trabajes (no hay obligación). Para negar la obligación se cambia a hoeven + niet + te; no se niega moeten.
• La regla del «te»: los MODALES (moeten, kunnen, mogen, willen, zullen) NUNCA llevan te. hoeven SÍ (es semimodal). Los verbos que encadenan otro infinitivo (proberen, vergeten, beloven, hopen, durven, besluiten, weigeren…) van con te. La finalidad (para…) se dice con om … te.
• Separables con te: el te se cuela DENTRO → opbellen → op te bellen, terugbellen → terug te bellen, meenemen → mee te nemen.
Truco mental: si dices «tengo que» → moeten (sin te); si dices «no hace falta / no tengo por qué» → hoeven … niet te (con te). hoeven ya lleva la negación dentro y arrastra el te.

📐 Negación de la obligación: sujeto + hoef (2ª posición) + tiempo (morgen) + niet + te + infinitivo (werken) al final.

🧭 Cuándo usarlo: decir que no tienes obligación de algo. Ej.: → Ga je morgen naar kantoor? – Nee, ik hoef morgen niet te werken (¿vas mañana a la oficina? – No, no hace falta que trabaje mañana).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no hace falta que trabaje mañana' AND notes = 'Obligación con te: hoeven (negativo, con te)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'no hace falta que trabaje mañana' AND notes = 'Obligación con te: hoeven (negativo, con te)' LIMIT 1),
    'nl_NL', 'Nee, ik hoef morgen niet te werken.', 'Ne, ik uf morjen nit te uerken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no hace falta que trabaje mañana' AND notes = 'Obligación con te: hoeven (negativo, con te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos de obligación con te - moeten of hoeven te'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no hace falta que trabaje mañana' AND notes = 'Obligación con te: hoeven (negativo, con te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- moeten (pregunta, sin te): Moet je vandaag werken?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿tienes que trabajar hoy?', 'PHRASE', 'Obligación con te: moeten (pregunta, sin te)', 'moeten en pregunta sí/no: el verbo modal va DELANTE, SIN te. vandaag = hoy. Fíjate en que la respuesta negativa no usa moeten sino hoeven → Nee, ik hoef niet te werken.

Obligación y el «te» en neerlandés:
• moeten = tener que / deber (obligación). Es MODAL → NO lleva te: Ik moet werken.
• hoeven = la versión NEGATIVA de moeten: no hacer falta / no tener por qué. SIEMPRE lleva te y casi siempre va con negación (niet, geen, nooit) o restricción (alleen maar): Ik hoef niet te werken.
  ¿Por qué hoeven y no «moeten niet»? Porque cambia el significado: Je moet niet werken = no DEBES trabajar (casi prohibición) · Je hoeft niet te werken = no HACE FALTA que trabajes (no hay obligación). Para negar la obligación se cambia a hoeven + niet + te; no se niega moeten.
• La regla del «te»: los MODALES (moeten, kunnen, mogen, willen, zullen) NUNCA llevan te. hoeven SÍ (es semimodal). Los verbos que encadenan otro infinitivo (proberen, vergeten, beloven, hopen, durven, besluiten, weigeren…) van con te. La finalidad (para…) se dice con om … te.
• Separables con te: el te se cuela DENTRO → opbellen → op te bellen, terugbellen → terug te bellen, meenemen → mee te nemen.
Truco mental: si dices «tengo que» → moeten (sin te); si dices «no hace falta / no tengo por qué» → hoeven … niet te (con te). hoeven ya lleva la negación dentro y arrastra el te.

📐 Pregunta sí/no: moet (1ª posición) + sujeto + tiempo (vandaag) + infinitivo (werken) al final. Modal SIN te.

🧭 Cuándo usarlo: preguntar por la obligación de alguien. Ej.: → Moet je vandaag werken? – Nee, ik hoef niet (¿tienes que trabajar hoy? – No, no hace falta).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿tienes que trabajar hoy?' AND notes = 'Obligación con te: moeten (pregunta, sin te)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿tienes que trabajar hoy?' AND notes = 'Obligación con te: moeten (pregunta, sin te)' LIMIT 1),
    'nl_NL', 'Moet je vandaag werken?', 'Mut ye fandaj uerken?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿tienes que trabajar hoy?' AND notes = 'Obligación con te: moeten (pregunta, sin te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos de obligación con te - moeten of hoeven te'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿tienes que trabajar hoy?' AND notes = 'Obligación con te: moeten (pregunta, sin te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- hoeven (negativo, jij + subordinada als): Je hoeft niet te komen als je moe bent.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no hace falta que vengas si estás cansado', 'PHRASE', 'Obligación con te: hoeven (negativo, jij)', 'hoeft = forma de jij/hij/zij de hoeven. niet te komen = no hace falta venir (con te). La subordinada con als (si) manda su verbo al FINAL: … als je moe bent. Contraste: «je moet niet komen» = no DEBES venir.

Obligación y el «te» en neerlandés:
• moeten = tener que / deber (obligación). Es MODAL → NO lleva te: Ik moet werken.
• hoeven = la versión NEGATIVA de moeten: no hacer falta / no tener por qué. SIEMPRE lleva te y casi siempre va con negación (niet, geen, nooit) o restricción (alleen maar): Ik hoef niet te werken.
  ¿Por qué hoeven y no «moeten niet»? Porque cambia el significado: Je moet niet werken = no DEBES trabajar (casi prohibición) · Je hoeft niet te werken = no HACE FALTA que trabajes (no hay obligación). Para negar la obligación se cambia a hoeven + niet + te; no se niega moeten.
• La regla del «te»: los MODALES (moeten, kunnen, mogen, willen, zullen) NUNCA llevan te. hoeven SÍ (es semimodal). Los verbos que encadenan otro infinitivo (proberen, vergeten, beloven, hopen, durven, besluiten, weigeren…) van con te. La finalidad (para…) se dice con om … te.
• Separables con te: el te se cuela DENTRO → opbellen → op te bellen, terugbellen → terug te bellen, meenemen → mee te nemen.
Truco mental: si dices «tengo que» → moeten (sin te); si dices «no hace falta / no tengo por qué» → hoeven … niet te (con te). hoeven ya lleva la negación dentro y arrastra el te.

📐 hoeven + subordinada als: sujeto + hoeft + niet + te + infinitivo (komen) … + [als + sujeto + … + verbo (bent) al final].

🧭 Cuándo usarlo: liberar a alguien de una obligación. Ej.: → Je hoeft niet te komen als je moe bent (no hace falta que vengas si estás cansado).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no hace falta que vengas si estás cansado' AND notes = 'Obligación con te: hoeven (negativo, jij)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'no hace falta que vengas si estás cansado' AND notes = 'Obligación con te: hoeven (negativo, jij)' LIMIT 1),
    'nl_NL', 'Je hoeft niet te komen als je moe bent.', 'Ye uft nit te komen als ye mu bent.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no hace falta que vengas si estás cansado' AND notes = 'Obligación con te: hoeven (negativo, jij)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos de obligación con te - moeten of hoeven te'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no hace falta que vengas si estás cansado' AND notes = 'Obligación con te: hoeven (negativo, jij)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- hoeven (geen + frase hecha reflexiva): Je hoeft je geen zorgen te maken.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no tienes que preocuparte', 'PHRASE', 'Obligación con te: hoeven (geen, frase hecha zorgen)', 'zich zorgen maken = preocuparse (frase hecha, reflexiva). Con hoeven la negación puede ser geen (ningún): geen zorgen. Sigue llevando te → te maken. = no tienes que preocuparte.

Obligación y el «te» en neerlandés:
• moeten = tener que / deber (obligación). Es MODAL → NO lleva te: Ik moet werken.
• hoeven = la versión NEGATIVA de moeten: no hacer falta / no tener por qué. SIEMPRE lleva te y casi siempre va con negación (niet, geen, nooit) o restricción (alleen maar): Ik hoef niet te werken.
  ¿Por qué hoeven y no «moeten niet»? Porque cambia el significado: Je moet niet werken = no DEBES trabajar (casi prohibición) · Je hoeft niet te werken = no HACE FALTA que trabajes (no hay obligación). Para negar la obligación se cambia a hoeven + niet + te; no se niega moeten.
• La regla del «te»: los MODALES (moeten, kunnen, mogen, willen, zullen) NUNCA llevan te. hoeven SÍ (es semimodal). Los verbos que encadenan otro infinitivo (proberen, vergeten, beloven, hopen, durven, besluiten, weigeren…) van con te. La finalidad (para…) se dice con om … te.
• Separables con te: el te se cuela DENTRO → opbellen → op te bellen, terugbellen → terug te bellen, meenemen → mee te nemen.
Truco mental: si dices «tengo que» → moeten (sin te); si dices «no hace falta / no tengo por qué» → hoeven … niet te (con te). hoeven ya lleva la negación dentro y arrastra el te.

📐 hoeven + geen + frase hecha reflexiva: sujeto + hoeft + reflexivo (je) + geen + objeto (zorgen) + te + infinitivo (maken) al final.

🧭 Cuándo usarlo: tranquilizar a alguien. Ej.: → Je hoeft je geen zorgen te maken, het komt goed (no tienes que preocuparte, todo saldrá bien).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no tienes que preocuparte' AND notes = 'Obligación con te: hoeven (geen, frase hecha zorgen)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'no tienes que preocuparte' AND notes = 'Obligación con te: hoeven (geen, frase hecha zorgen)' LIMIT 1),
    'nl_NL', 'Je hoeft je geen zorgen te maken.', 'Ye uft ye jen sorjen te maken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no tienes que preocuparte' AND notes = 'Obligación con te: hoeven (geen, frase hecha zorgen)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos de obligación con te - moeten of hoeven te'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no tienes que preocuparte' AND notes = 'Obligación con te: hoeven (geen, frase hecha zorgen)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- hoeven (alleen maar, restrictivo afirmativo): Je hoeft alleen maar te bellen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'solo tienes que llamar', 'PHRASE', 'Obligación con te: hoeven (alleen maar, restrictivo)', 'Único caso en que hoeven aparece en AFIRMATIVA: con alleen (maar) = solo tienes que… / no hace falta más que… Sigue llevando te → te bellen.

Obligación y el «te» en neerlandés:
• moeten = tener que / deber (obligación). Es MODAL → NO lleva te: Ik moet werken.
• hoeven = la versión NEGATIVA de moeten: no hacer falta / no tener por qué. SIEMPRE lleva te y casi siempre va con negación (niet, geen, nooit) o restricción (alleen maar): Ik hoef niet te werken.
  ¿Por qué hoeven y no «moeten niet»? Porque cambia el significado: Je moet niet werken = no DEBES trabajar (casi prohibición) · Je hoeft niet te werken = no HACE FALTA que trabajes (no hay obligación). Para negar la obligación se cambia a hoeven + niet + te; no se niega moeten.
• La regla del «te»: los MODALES (moeten, kunnen, mogen, willen, zullen) NUNCA llevan te. hoeven SÍ (es semimodal). Los verbos que encadenan otro infinitivo (proberen, vergeten, beloven, hopen, durven, besluiten, weigeren…) van con te. La finalidad (para…) se dice con om … te.
• Separables con te: el te se cuela DENTRO → opbellen → op te bellen, terugbellen → terug te bellen, meenemen → mee te nemen.
Truco mental: si dices «tengo que» → moeten (sin te); si dices «no hace falta / no tengo por qué» → hoeven … niet te (con te). hoeven ya lleva la negación dentro y arrastra el te.

📐 hoeven restrictivo: sujeto + hoeft + alleen maar + te + infinitivo (bellen) al final.

🧭 Cuándo usarlo: decir que basta con hacer una cosa. Ej.: → Als je hulp nodig hebt, hoef je alleen maar te bellen (si necesitas ayuda, solo tienes que llamar).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'solo tienes que llamar' AND notes = 'Obligación con te: hoeven (alleen maar, restrictivo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'solo tienes que llamar' AND notes = 'Obligación con te: hoeven (alleen maar, restrictivo)' LIMIT 1),
    'nl_NL', 'Je hoeft alleen maar te bellen.', 'Ye uft alen mar te bellen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'solo tienes que llamar' AND notes = 'Obligación con te: hoeven (alleen maar, restrictivo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos de obligación con te - moeten of hoeven te'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'solo tienes que llamar' AND notes = 'Obligación con te: hoeven (alleen maar, restrictivo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- moeten (pasado moest, sin te): Ik moest gisteren overwerken.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ayer tuve que hacer horas extra', 'PHRASE', 'Obligación con te: moeten (pasado moest, sin te)', 'moest = pasado de moeten (tuve que). Sigue SIN te aunque sea pasado. overwerken = hacer horas extra. gisteren = ayer.

Obligación y el «te» en neerlandés:
• moeten = tener que / deber (obligación). Es MODAL → NO lleva te: Ik moet werken.
• hoeven = la versión NEGATIVA de moeten: no hacer falta / no tener por qué. SIEMPRE lleva te y casi siempre va con negación (niet, geen, nooit) o restricción (alleen maar): Ik hoef niet te werken.
  ¿Por qué hoeven y no «moeten niet»? Porque cambia el significado: Je moet niet werken = no DEBES trabajar (casi prohibición) · Je hoeft niet te werken = no HACE FALTA que trabajes (no hay obligación). Para negar la obligación se cambia a hoeven + niet + te; no se niega moeten.
• La regla del «te»: los MODALES (moeten, kunnen, mogen, willen, zullen) NUNCA llevan te. hoeven SÍ (es semimodal). Los verbos que encadenan otro infinitivo (proberen, vergeten, beloven, hopen, durven, besluiten, weigeren…) van con te. La finalidad (para…) se dice con om … te.
• Separables con te: el te se cuela DENTRO → opbellen → op te bellen, terugbellen → terug te bellen, meenemen → mee te nemen.
Truco mental: si dices «tengo que» → moeten (sin te); si dices «no hace falta / no tengo por qué» → hoeven … niet te (con te). hoeven ya lleva la negación dentro y arrastra el te.

📐 Pasado (frase principal): sujeto + moest (2ª posición) + tiempo (gisteren) + infinitivo (overwerken) al final. Modal SIN te.

🧭 Cuándo usarlo: contar una obligación pasada. Ej.: → Ik kon niet komen, ik moest gisteren overwerken (no pude venir, ayer tuve que hacer horas extra).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ayer tuve que hacer horas extra' AND notes = 'Obligación con te: moeten (pasado moest, sin te)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ayer tuve que hacer horas extra' AND notes = 'Obligación con te: moeten (pasado moest, sin te)' LIMIT 1),
    'nl_NL', 'Ik moest gisteren overwerken.', 'Ik must jisteren oferuerken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ayer tuve que hacer horas extra' AND notes = 'Obligación con te: moeten (pasado moest, sin te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos de obligación con te - moeten of hoeven te'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ayer tuve que hacer horas extra' AND notes = 'Obligación con te: moeten (pasado moest, sin te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- proberen te: Ik probeer gezond te eten.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'intento comer sano', 'PHRASE', 'Obligación con te: proberen te', 'proberen = intentar. Verbo normal que encadena un infinitivo → CON te: proberen te + infinitivo. gezond = sano. Confirma la regla del te (no es modal, así que lleva te).

Obligación y el «te» en neerlandés:
• moeten = tener que / deber (obligación). Es MODAL → NO lleva te: Ik moet werken.
• hoeven = la versión NEGATIVA de moeten: no hacer falta / no tener por qué. SIEMPRE lleva te y casi siempre va con negación (niet, geen, nooit) o restricción (alleen maar): Ik hoef niet te werken.
  ¿Por qué hoeven y no «moeten niet»? Porque cambia el significado: Je moet niet werken = no DEBES trabajar (casi prohibición) · Je hoeft niet te werken = no HACE FALTA que trabajes (no hay obligación). Para negar la obligación se cambia a hoeven + niet + te; no se niega moeten.
• La regla del «te»: los MODALES (moeten, kunnen, mogen, willen, zullen) NUNCA llevan te. hoeven SÍ (es semimodal). Los verbos que encadenan otro infinitivo (proberen, vergeten, beloven, hopen, durven, besluiten, weigeren…) van con te. La finalidad (para…) se dice con om … te.
• Separables con te: el te se cuela DENTRO → opbellen → op te bellen, terugbellen → terug te bellen, meenemen → mee te nemen.
Truco mental: si dices «tengo que» → moeten (sin te); si dices «no hace falta / no tengo por qué» → hoeven … niet te (con te). hoeven ya lleva la negación dentro y arrastra el te.

📐 Verbo + te + infinitivo: sujeto + probeer (2ª posición) + complemento (gezond) + te + infinitivo (eten) al final.

🧭 Cuándo usarlo: hablar de un propósito o esfuerzo. Ej.: → Ik probeer gezond te eten, maar het lukt niet altijd (intento comer sano, pero no siempre lo consigo).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'intento comer sano' AND notes = 'Obligación con te: proberen te');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'intento comer sano' AND notes = 'Obligación con te: proberen te' LIMIT 1),
    'nl_NL', 'Ik probeer gezond te eten.', 'Ik prober jesond te eten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'intento comer sano' AND notes = 'Obligación con te: proberen te' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos de obligación con te - moeten of hoeven te'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'intento comer sano' AND notes = 'Obligación con te: proberen te' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- vergeten te (con separable terug te bellen): Ik ben vergeten je terug te bellen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'olvidé devolverte la llamada', 'PHRASE', 'Obligación con te: vergeten te (separable)', 'vergeten = olvidar; con infinitivo lleva te (vergeten te + infinitivo) y en el perfecto usa zijn (ben vergeten). terugbellen es SEPARABLE, así que el te se cuela DENTRO → terug te bellen. = olvidé devolverte la llamada.

Obligación y el «te» en neerlandés:
• moeten = tener que / deber (obligación). Es MODAL → NO lleva te: Ik moet werken.
• hoeven = la versión NEGATIVA de moeten: no hacer falta / no tener por qué. SIEMPRE lleva te y casi siempre va con negación (niet, geen, nooit) o restricción (alleen maar): Ik hoef niet te werken.
  ¿Por qué hoeven y no «moeten niet»? Porque cambia el significado: Je moet niet werken = no DEBES trabajar (casi prohibición) · Je hoeft niet te werken = no HACE FALTA que trabajes (no hay obligación). Para negar la obligación se cambia a hoeven + niet + te; no se niega moeten.
• La regla del «te»: los MODALES (moeten, kunnen, mogen, willen, zullen) NUNCA llevan te. hoeven SÍ (es semimodal). Los verbos que encadenan otro infinitivo (proberen, vergeten, beloven, hopen, durven, besluiten, weigeren…) van con te. La finalidad (para…) se dice con om … te.
• Separables con te: el te se cuela DENTRO → opbellen → op te bellen, terugbellen → terug te bellen, meenemen → mee te nemen.
Truco mental: si dices «tengo que» → moeten (sin te); si dices «no hace falta / no tengo por qué» → hoeven … niet te (con te). hoeven ya lleva la negación dentro y arrastra el te.

📐 Perfecto de vergeten (zijn) + separable con te: sujeto + ben + vergeten + objeto (je) + [prefijo + te + verbo] (terug te bellen) al final.

🧭 Cuándo usarlo: disculparte por un olvido. Ej.: → Sorry, ik ben vergeten je terug te bellen (perdona, olvidé devolverte la llamada).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'olvidé devolverte la llamada' AND notes = 'Obligación con te: vergeten te (separable)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'olvidé devolverte la llamada' AND notes = 'Obligación con te: vergeten te (separable)' LIMIT 1),
    'nl_NL', 'Ik ben vergeten je terug te bellen.', 'Ik ben ferjeten ye teruj te bellen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'olvidé devolverte la llamada' AND notes = 'Obligación con te: vergeten te (separable)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos de obligación con te - moeten of hoeven te'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'olvidé devolverte la llamada' AND notes = 'Obligación con te: vergeten te (separable)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- beloven te (imperativo): Beloof me op tijd te zijn.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'prométeme llegar puntual', 'PHRASE', 'Obligación con te: beloven te', 'beloven = prometer; con infinitivo lleva te (beloven te + infinitivo). Beloof… = imperativo. op tijd = a tiempo / puntual. = prométeme llegar puntual.

Obligación y el «te» en neerlandés:
• moeten = tener que / deber (obligación). Es MODAL → NO lleva te: Ik moet werken.
• hoeven = la versión NEGATIVA de moeten: no hacer falta / no tener por qué. SIEMPRE lleva te y casi siempre va con negación (niet, geen, nooit) o restricción (alleen maar): Ik hoef niet te werken.
  ¿Por qué hoeven y no «moeten niet»? Porque cambia el significado: Je moet niet werken = no DEBES trabajar (casi prohibición) · Je hoeft niet te werken = no HACE FALTA que trabajes (no hay obligación). Para negar la obligación se cambia a hoeven + niet + te; no se niega moeten.
• La regla del «te»: los MODALES (moeten, kunnen, mogen, willen, zullen) NUNCA llevan te. hoeven SÍ (es semimodal). Los verbos que encadenan otro infinitivo (proberen, vergeten, beloven, hopen, durven, besluiten, weigeren…) van con te. La finalidad (para…) se dice con om … te.
• Separables con te: el te se cuela DENTRO → opbellen → op te bellen, terugbellen → terug te bellen, meenemen → mee te nemen.
Truco mental: si dices «tengo que» → moeten (sin te); si dices «no hace falta / no tengo por qué» → hoeven … niet te (con te). hoeven ya lleva la negación dentro y arrastra el te.

📐 Imperativo + te + infinitivo: verbo (Beloof, 1ª posición) + objeto (me) + complemento (op tijd) + te + infinitivo (zijn) al final.

🧭 Cuándo usarlo: pedir una promesa. Ej.: → Beloof me op tijd te zijn, we mogen niet te laat komen (prométeme llegar puntual, no podemos llegar tarde).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'prométeme llegar puntual' AND notes = 'Obligación con te: beloven te');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'prométeme llegar puntual' AND notes = 'Obligación con te: beloven te' LIMIT 1),
    'nl_NL', 'Beloof me op tijd te zijn.', 'Belof me op teid te sein.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'prométeme llegar puntual' AND notes = 'Obligación con te: beloven te' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos de obligación con te - moeten of hoeven te'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'prométeme llegar puntual' AND notes = 'Obligación con te: beloven te' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- hopen te: Ik hoop je snel weer te zien.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'espero volver a verte pronto', 'PHRASE', 'Obligación con te: hopen te', 'hopen = esperar (desear); con infinitivo lleva te (hopen te + infinitivo). snel = pronto, weer = otra vez. = espero volver a verte pronto.

Obligación y el «te» en neerlandés:
• moeten = tener que / deber (obligación). Es MODAL → NO lleva te: Ik moet werken.
• hoeven = la versión NEGATIVA de moeten: no hacer falta / no tener por qué. SIEMPRE lleva te y casi siempre va con negación (niet, geen, nooit) o restricción (alleen maar): Ik hoef niet te werken.
  ¿Por qué hoeven y no «moeten niet»? Porque cambia el significado: Je moet niet werken = no DEBES trabajar (casi prohibición) · Je hoeft niet te werken = no HACE FALTA que trabajes (no hay obligación). Para negar la obligación se cambia a hoeven + niet + te; no se niega moeten.
• La regla del «te»: los MODALES (moeten, kunnen, mogen, willen, zullen) NUNCA llevan te. hoeven SÍ (es semimodal). Los verbos que encadenan otro infinitivo (proberen, vergeten, beloven, hopen, durven, besluiten, weigeren…) van con te. La finalidad (para…) se dice con om … te.
• Separables con te: el te se cuela DENTRO → opbellen → op te bellen, terugbellen → terug te bellen, meenemen → mee te nemen.
Truco mental: si dices «tengo que» → moeten (sin te); si dices «no hace falta / no tengo por qué» → hoeven … niet te (con te). hoeven ya lleva la negación dentro y arrastra el te.

📐 Verbo + te + infinitivo: sujeto + hoop (2ª posición) + objeto (je) + adverbios (snel weer) + te + infinitivo (zien) al final.

🧭 Cuándo usarlo: despedirte con ganas de repetir. Ej.: → Het was leuk! Ik hoop je snel weer te zien (¡fue genial! Espero volver a verte pronto).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'espero volver a verte pronto' AND notes = 'Obligación con te: hopen te');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'espero volver a verte pronto' AND notes = 'Obligación con te: hopen te' LIMIT 1),
    'nl_NL', 'Ik hoop je snel weer te zien.', 'Ik op ye snel uer te sien.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'espero volver a verte pronto' AND notes = 'Obligación con te: hopen te' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos de obligación con te - moeten of hoeven te'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'espero volver a verte pronto' AND notes = 'Obligación con te: hopen te' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- durven te (negativo): Ik durf het niet te vragen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no me atrevo a preguntarlo', 'PHRASE', 'Obligación con te: durven te', 'durven = atreverse; con infinitivo lleva te (durven te + infinitivo). En negativo: durf … niet te. het = lo. = no me atrevo a preguntarlo.

Obligación y el «te» en neerlandés:
• moeten = tener que / deber (obligación). Es MODAL → NO lleva te: Ik moet werken.
• hoeven = la versión NEGATIVA de moeten: no hacer falta / no tener por qué. SIEMPRE lleva te y casi siempre va con negación (niet, geen, nooit) o restricción (alleen maar): Ik hoef niet te werken.
  ¿Por qué hoeven y no «moeten niet»? Porque cambia el significado: Je moet niet werken = no DEBES trabajar (casi prohibición) · Je hoeft niet te werken = no HACE FALTA que trabajes (no hay obligación). Para negar la obligación se cambia a hoeven + niet + te; no se niega moeten.
• La regla del «te»: los MODALES (moeten, kunnen, mogen, willen, zullen) NUNCA llevan te. hoeven SÍ (es semimodal). Los verbos que encadenan otro infinitivo (proberen, vergeten, beloven, hopen, durven, besluiten, weigeren…) van con te. La finalidad (para…) se dice con om … te.
• Separables con te: el te se cuela DENTRO → opbellen → op te bellen, terugbellen → terug te bellen, meenemen → mee te nemen.
Truco mental: si dices «tengo que» → moeten (sin te); si dices «no hace falta / no tengo por qué» → hoeven … niet te (con te). hoeven ya lleva la negación dentro y arrastra el te.

📐 Verbo + te + infinitivo (negativo): sujeto + durf (2ª posición) + objeto (het) + niet + te + infinitivo (vragen) al final.

🧭 Cuándo usarlo: expresar que algo te da reparo. Ej.: → Ik wil het weten, maar ik durf het niet te vragen (quiero saberlo, pero no me atrevo a preguntarlo).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no me atrevo a preguntarlo' AND notes = 'Obligación con te: durven te');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'no me atrevo a preguntarlo' AND notes = 'Obligación con te: durven te' LIMIT 1),
    'nl_NL', 'Ik durf het niet te vragen.', 'Ik durf et nit te frajen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no me atrevo a preguntarlo' AND notes = 'Obligación con te: durven te' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos de obligación con te - moeten of hoeven te'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no me atrevo a preguntarlo' AND notes = 'Obligación con te: durven te' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- om … te (finalidad): Ik ga naar de winkel om brood te kopen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'voy a la tienda a comprar pan', 'PHRASE', 'Obligación con te: om ... te (finalidad)', 'Finalidad (para…) = om … te + infinitivo. Aquí no basta un te suelto: para expresar propósito hace falta om. brood = pan. = voy a la tienda a comprar pan.

Obligación y el «te» en neerlandés:
• moeten = tener que / deber (obligación). Es MODAL → NO lleva te: Ik moet werken.
• hoeven = la versión NEGATIVA de moeten: no hacer falta / no tener por qué. SIEMPRE lleva te y casi siempre va con negación (niet, geen, nooit) o restricción (alleen maar): Ik hoef niet te werken.
  ¿Por qué hoeven y no «moeten niet»? Porque cambia el significado: Je moet niet werken = no DEBES trabajar (casi prohibición) · Je hoeft niet te werken = no HACE FALTA que trabajes (no hay obligación). Para negar la obligación se cambia a hoeven + niet + te; no se niega moeten.
• La regla del «te»: los MODALES (moeten, kunnen, mogen, willen, zullen) NUNCA llevan te. hoeven SÍ (es semimodal). Los verbos que encadenan otro infinitivo (proberen, vergeten, beloven, hopen, durven, besluiten, weigeren…) van con te. La finalidad (para…) se dice con om … te.
• Separables con te: el te se cuela DENTRO → opbellen → op te bellen, terugbellen → terug te bellen, meenemen → mee te nemen.
Truco mental: si dices «tengo que» → moeten (sin te); si dices «no hace falta / no tengo por qué» → hoeven … niet te (con te). hoeven ya lleva la negación dentro y arrastra el te.

📐 Finalidad: [oración principal] + om + complemento (brood) + te + infinitivo (kopen) al final.

🧭 Cuándo usarlo: expresar el propósito de algo. Ej.: → Ik ga naar de winkel om brood te kopen (voy a la tienda a comprar pan).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'voy a la tienda a comprar pan' AND notes = 'Obligación con te: om ... te (finalidad)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a la tienda a comprar pan' AND notes = 'Obligación con te: om ... te (finalidad)' LIMIT 1),
    'nl_NL', 'Ik ga naar de winkel om brood te kopen.', 'Ik ja nar de uinkel om brod te kopen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a la tienda a comprar pan' AND notes = 'Obligación con te: om ... te (finalidad)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos de obligación con te - moeten of hoeven te'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a la tienda a comprar pan' AND notes = 'Obligación con te: om ... te (finalidad)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
