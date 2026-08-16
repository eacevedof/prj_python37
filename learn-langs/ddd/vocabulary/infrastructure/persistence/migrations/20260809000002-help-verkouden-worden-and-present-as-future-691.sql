-- Learn Languages App - Ayuda: verkouden worden (no reflexivo) + presente como futuro (tarjeta 691)
-- Migration: 20260809000002-help-verkouden-worden-and-present-as-future-691.sql
-- Description: Dos bloques a la 691 ("Straks word je verkouden" = te vas a resfriar):
--   🤧 verkouden worden: resfriarse = cambio de estado (worden), NO reflexivo (no "je gaat je
--     verkouden"); verkouden es adjetivo -> necesita worden (gaan verkouden worden / zult
--     verkouden worden). Enlaza con el grupo worden y con el Grupo A (reflexivo ES, no NL).
--   ⏳ presente = futuro cercano con adverbio de tiempo: straks/morgen/zo hacen que el presente
--     valga como futuro; por eso "Straks word je verkouden" y no hace falta zullen/gaan.
--   Keyeadas por texto nl_NL, idempotentes por emoji-guarda. Solo UPDATE de rules_help.

PRAGMA foreign_keys = ON;

-- 691 · verkouden worden (no reflexivo, necesita worden)
UPDATE words_es SET rules_help = rules_help || '

🤧 verkouden worden = resfriarse (ojo: NO es reflexivo en NL)
"te vas a resfriar" -> Straks word je verkouden. Analisis de las alternativas:
• je wordt verkouden = correcto. verkouden worden = resfriarse, es un CAMBIO DE ESTADO -> worden (como el grupo worden). En presente + contexto de futuro = te vas a resfriar.
• je gaat je verkouden = INCORRECTO por dos motivos: (1) sobra el reflexivo "je": verkouden worden NO es reflexivo en neerlandes (aunque "resfriarSE" si lo sea en español -> caso tipico del Grupo A); (2) falta worden: verkouden es un ADJETIVO, no un verbo. Correcto: je gaat verkouden worden (gaan + infinitivo = ir a).
• jij zult verkouden = incompleta; falta worden: jij zult verkouden worden si es correcto (zullen = futuro), pero suena formal.
Formas naturales: Straks word je verkouden (la mas idiomatica) / Je gaat verkouden worden / Je zult verkouden worden (formal).'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Straks word je verkouden.')
  AND COALESCE(rules_help,'') NOT LIKE '%🤧%';

-- 691 · presente como futuro con adverbio de tiempo
UPDATE words_es SET rules_help = rules_help || '

⏳ ¿por que empieza con "straks"? (presente = futuro cercano)
El neerlandes expresa muy a menudo el FUTURO CERCANO con el PRESENTE + un adverbio de tiempo. La palabra de tiempo ya marca que es futuro, asi que no hace falta zullen ni gaan.
• straks = luego / dentro de un rato (hoy mismo, futuro proximo). Straks word je verkouden = dentro de un rato te resfrias -> te vas a resfriar.
• Igual: Ik bel je straks (te llamo luego), Morgen regent het (mañana llueve/llovera), Zo kom ik (ahora voy).
• Sin straks, "Je wordt verkouden" suena mas a "te estas resfriando (ahora)"; el straks lo empuja al futuro.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Straks word je verkouden.')
  AND COALESCE(rules_help,'') NOT LIKE '%⏳%';
