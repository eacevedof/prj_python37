-- Learn Languages App - Regla hebben/zijn (sujeto vs objeto) en las tarjetas de perfecto
-- Migration: 20260721000002-add-hebben-zijn-subject-object-rule-to-perfect-cards.sql
-- Description: Anade un bloque ⚠️ «hebben o zijn - el test del complemento» al rules_help de
--   TODAS las tarjetas que eligen auxiliar en el pretérito perfecto, aclarando la confusion
--   frecuente (nace de la duda en id 668 opruimen): zijn NO se dispara porque «cambie de
--   estado algo», sino porque cambia de lugar/estado EL SUJETO y el verbo es intransitivo;
--   un verbo con complemento directo (lijdend voorwerp) es transitivo y va SIEMPRE con hebben
--   aunque el objeto acabe cambiado. Incluye el test rapido y pares de contraste (ijs smelten,
--   fietsen con/sin destino).
--   Alcance (26 tarjetas):
--     • Grupo 18 «perfecto hebben/zijn - voltooide tijd»: las 18 tarjetas (613-630).
--     • Grupo 21 «verbos separables»: solo las 8 en perfecto (notes LIKE '...(perfecto...'):
--       657, 658, 659, 664, 665, 666, 667, 668. Las de presente/pasado/imperativo no eligen
--       auxiliar y quedan fuera.
--   Idempotente (guarda NOT LIKE con la cabecera del bloque). Solo UPDATE de words_es.rules_help;
--   no toca words_lang/audio, imagenes ni notes.

PRAGMA foreign_keys = ON;

-- Grupo 18: perfecto hebben/zijn (las 18 tarjetas)
UPDATE words_es SET rules_help = rules_help || '

⚠️ hebben o zijn — el test del complemento:
La regla de zijn NO es «cambia de estado algo», sino que cambia de lugar o de estado EL SUJETO y el verbo es intransitivo (sin complemento directo): Ik ben opgestaan · De vaas is gevallen · Ze is dokter geworden.
• Si el verbo lleva complemento directo (lijdend voorwerp: je kamer, een boek, het huis) es TRANSITIVO y va SIEMPRE con hebben, aunque el objeto acabe cambiado: Ik heb mijn kamer opgeruimd · Ze hebben hun huis verkocht. El cambio del OBJETO no cuenta; solo dispara zijn el cambio del SUJETO.
• Test rapido: ¿hay algo sobre lo que actúas (complemento directo)? → hebben. ¿El sujeto se mueve o se transforma él mismo, sin objeto? → zijn.
• Mismo verbo, distinto auxiliar: Het ijs is gesmolten (intransitivo, cambia el hielo = sujeto) vs Ik heb het ijs gesmolten (transitivo, het ijs = objeto). Ik ben naar school gefietst (con destino = movimiento del sujeto) vs Ik heb twee uur gefietst (actividad, sin destino).'
WHERE id IN (SELECT word_es_id FROM word_es_groups WHERE group_id = 18)
  AND rules_help NOT LIKE '%hebben o zijn — el test del complemento%';

-- Grupo 21: separables SOLO en perfecto (8 tarjetas)
UPDATE words_es SET rules_help = rules_help || '

⚠️ hebben o zijn — el test del complemento:
La regla de zijn NO es «cambia de estado algo», sino que cambia de lugar o de estado EL SUJETO y el verbo es intransitivo (sin complemento directo): Ik ben opgestaan · De vaas is gevallen · Ze is dokter geworden.
• Si el verbo lleva complemento directo (lijdend voorwerp: je kamer, een boek, het huis) es TRANSITIVO y va SIEMPRE con hebben, aunque el objeto acabe cambiado: Ik heb mijn kamer opgeruimd · Ze hebben hun huis verkocht. El cambio del OBJETO no cuenta; solo dispara zijn el cambio del SUJETO.
• Test rapido: ¿hay algo sobre lo que actúas (complemento directo)? → hebben. ¿El sujeto se mueve o se transforma él mismo, sin objeto? → zijn.
• Mismo verbo, distinto auxiliar: Het ijs is gesmolten (intransitivo, cambia el hielo = sujeto) vs Ik heb het ijs gesmolten (transitivo, het ijs = objeto). Ik ben naar school gefietst (con destino = movimiento del sujeto) vs Ik heb twee uur gefietst (actividad, sin destino).'
WHERE notes LIKE 'Verbo separable: %(perfecto%'
  AND rules_help NOT LIKE '%hebben o zijn — el test del complemento%';
