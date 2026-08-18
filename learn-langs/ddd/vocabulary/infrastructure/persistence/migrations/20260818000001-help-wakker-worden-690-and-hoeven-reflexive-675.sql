-- Learn Languages App - Ayuda: perfecto/imperfecto (690) + reflexivo con hoeven (675)
-- Migration: 20260818000001-help-wakker-worden-690-and-hoeven-reflexive-675.sql
-- Description: Eduardo (690 "Ik werd vroeg wakker" = me desperte temprano) pregunta si no
--   podria ser "Ik ben vroeg wakker geworden". Si: las dos son correctas. Bloque 🗓️ con el
--   reparto: worden pertenece al grupo (zijn/hebben/worden/modales) que MANTIENE el
--   imperfecto en el neerlandes hablado, asi que "werd" es lo normal; el perfecto es
--   correcto pero pide un complemento de tiempo o una consecuencia detras. Auxiliar ZIJN
--   (cambio de estado) y "wakker" suelto delante del participio. Aviso: no confundir con
--   opstaan (salir de la cama). El bloque se inserta ANTES del cierre 📐/🧭/🏋️ para que la
--   tarjeta conserve su estructura, y el ejercicio final absorbe el caso nuevo.
--   De paso, la 680 (vergeten, mismo eje perfecto/imperfecto) listaba los verbos que se
--   quedan en imperfecto sin incluir worden: se anade worden/werd para que las dos ayudas
--   cuenten lo mismo.
--   Ademas (675 "Je hoeft niet te komen als je moe bent"): Eduardo pregunta por que la 676
--   dice "Je hoeft je geen zorgen te maken" y esta no lleva ese segundo je, si es
--   reflexivo en una y no en otra. Bloque 🪞: el reflexivo NO lo pone hoeven, lo pide el
--   verbo principal (komen no es reflexivo; zich zorgen maken si). Truco: quitar hoeven y
--   mirar la frase base. Y niet niega el verbo mientras geen niega un sustantivo (zorgen).
--   La 676 ya tenia su bloque 🪞 desde el lado reflexivo; este es el lado contrario.
--   Ultima migracion ya aplicada -> migracion nueva, con los tres UPDATE fusionados en el
--   mismo .sql (sigue pendiente). Keyeadas por id, idempotentes (guarda por texto), solo
--   UPDATE de rules_help.

PRAGMA foreign_keys = ON;

-- 690 · el bloque nuevo entra justo antes del cierre "📐 Pasado:"
UPDATE words_es SET rules_help = REPLACE(
    rules_help,
    '📐 Pasado:',
    '🗓️ ¿Y «Ik ben vroeg wakker geworden»? — también es correcto.
Las dos formas valen; cambia el registro, no la gramática.
• Auxiliar: wakker worden es CAMBIO DE ESTADO → perfecto con ZIJN. Ik BEN vroeg wakker geworden ✓ · Ik heb ... geworden ✗.
• Orden: wakker va suelto, delante del participio, al final de la frase → Ik ben vroeg wakker geworden.
• Ik werd vroeg wakker = imperfectum. Es lo normal aquí, por dos motivos: (a) worden entra en el grupo que MANTIENE el imperfecto al hablar (zijn, hebben, worden y los modales: was, had, werd, kon, moest, wilde), donde otros verbos saltarían al perfecto; (b) sirve para narrar: Ik werd vroeg wakker, ik stond op en ik zette koffie.
• Ik ben vroeg wakker geworden = perfecto. Correcto, pero pide algo alrededor: un complemento de tiempo concreto o una consecuencia detrás. Ik ben vanochtend vroeg wakker geworden, dus ik ben moe (me he despertado pronto esta mañana, así que estoy cansado).
• En español: werd ≈ me desperté · ben ... geworden ≈ me he despertado.
⚠️ No lo mezcles con opstaan (levantarse, salir de la cama), que también va con zijn: Ik ben vroeg opgestaan = me levanté pronto · Ik werd vroeg wakker = abrí los ojos pronto (puedes seguir en la cama).

📐 Pasado:'
)
WHERE id = 690 AND COALESCE(rules_help,'') NOT LIKE '%wakker geworden»?%';

-- 690 · el ejercicio final pasa a pedir tambien el perfecto
UPDATE words_es SET rules_help = REPLACE(
    rules_help,
    '🏋️ Ejercicio: «Estoy despierto» → Ik ___ wakker. · «Me desperte» → Ik ___ wakker. (Respuestas: ben / werd.)',
    '🏋️ Ejercicio: «Estoy despierto» → Ik ___ wakker. · «Me desperte» → Ik ___ wakker. · «Me he despertado pronto esta manana» → Ik ___ vanochtend vroeg wakker ___. (Respuestas: ben / werd / ben ... geworden.)'
)
WHERE id = 690 AND COALESCE(rules_help,'') LIKE '%🏋️ Ejercicio: «Estoy despierto» → Ik ___ wakker. · «Me desperte» → Ik ___ wakker. (Respuestas: ben / werd.)%';

-- 680 · worden entra en la lista de verbos que se quedan en imperfecto al hablar
UPDATE words_es SET rules_help = REPLACE(
    rules_help,
    'hebben/zijn/modales — was, had, kon, moest, wilde',
    'hebben/zijn/worden/modales — was, had, werd, kon, moest, wilde'
)
WHERE id = 680 AND COALESCE(rules_help,'') LIKE '%hebben/zijn/modales — was, had, kon, moest, wilde%';

-- 675 · por que hoeven no arrastra reflexivo (contraste con la 676)
UPDATE words_es SET rules_help = rules_help || '

🪞 ¿Por qué la 676 lleva un «je» de más (Je hoeft JE geen zorgen te maken) y esta no?
Porque el reflexivo NO lo pone hoeven: lo pide el VERBO principal. hoeven solo añade «no hace falta» + te; no toca los pronombres.
• komen (venir) no es reflexivo → Je hoeft niet te komen. Un solo je, el SUJETO.
• zich zorgen maken (preocuparse) sí lo es, el pronombre es parte fija del verbo → Je hoeft je geen zorgen te maken. Dos je: 1º sujeto (jij) y 2º reflexivo (zich → je para jij).
Truco: quita hoeven y mira la frase base. Je komt (sin reflexivo) · Je maakt je zorgen (con reflexivo). Lo que había en la base, sigue estando.
⚠️ Y ojo a la negación, que también cambia: niet niega el verbo (niet te komen); geen niega un SUSTANTIVO (geen zorgen). Por eso aquí va niet y en la 676 geen.
Reflexivos frecuentes que se comportan igual: zich haasten (darse prisa), zich vergissen (equivocarse), zich voelen (sentirse), zich herinneren (acordarse), zich aankleden (vestirse), zich vervelen (aburrirse). Con hoeven: Je hoeft je niet te haasten (no hace falta que te des prisa).'
WHERE id = 675 AND COALESCE(rules_help,'') NOT LIKE '%🪞%';
