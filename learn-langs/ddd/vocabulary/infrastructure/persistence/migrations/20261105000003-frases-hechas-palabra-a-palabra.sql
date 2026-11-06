-- Learn Languages App - Migration
-- Migration: 20261105000003-frases-hechas-palabra-a-palabra
-- Description: Eduardo (2026-11-05), sobre la 1671: «esta bien la ayuda pero desgrana las palabras por su
--   significado een rib uit je lijf kosten rib = costilla, lijf = cuerpo? no era lichaam? … quiza hay
--   palabras de poco uso pero en expresiones si aplica … traducelas de modo aislado y explica el contexto,
--   porfa asegurate que sean expresiones muy usadas en el habla cotidiana en los tiempos actuales … hay
--   expresiones q se van perdiendo con el tiempo y esas las dejamos para mas adelante».
--
--   1) Bloque '📖 Palabra a palabra:' delante del 🧩 en las 91 frases hechas que se quedan, en su PHRASE y en su
--      SENTENCE de ejemplo: cada palabra con su de/het y su significado aislado, avisando cuando solo vive
--      dentro de la expresión (aambeeld, brij, heterdaad, pijpenstelen) o cuando no es la palabra neutra
--      (lijf frente a lichaam, bek frente a mond, nek frente a hals).
--   2) 9 expresiones que se oyen sobre todo a mayores o por escrito salen del grupo 55 y de generic
--      y pasan, con su SENTENCE, al grupo nuevo 'frases hechas - para más adelante': niet goed snik zijn, ieder zijn meug, waar de vos en de haas elkaar goedenacht zeggen, de morgenstond heeft goud in de mond, op je paasbest zijn, met stomheid geslagen zijn, kant noch wal raken, het buskruit niet uitgevonden hebben, een blauwtje lopen.
--      Criterio de uso propio (no hay corpus de expresiones); wordfreq solo como pista de las palabras raras.

PRAGMA foreign_keys = ON;

INSERT INTO word_groups (title, description, source)
SELECT 'frases hechas - para más adelante',
       'Frases hechas del grupo 55 que hoy se oyen sobre todo a gente mayor o por escrito. Aparcadas para estudiarlas más adelante; en cada ayuda está la alternativa actual.',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'frases hechas - para más adelante');

-- 001. met je gedachten ergens anders zijn
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de gedachte — el pensamiento, plural gedachten.
• ergens anders — en otra parte, muy usado solo, Ik woon nu ergens anders.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: met je gedachten ergens anders zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: met je gedachten ergens anders zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 002. iemand voor de gek houden
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• iemand — alguien.
• de gek — el loco, muy usado solo, Ben je gek?.
• houden voor — tomar por, Ik hield hem voor een Duitser.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: iemand voor de gek houden' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand voor de gek houden' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 003. een rib uit je lijf kosten
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de rib — la costilla, palabra normal, también la del carnicero.
• het lijf — el cuerpo, pero no es la palabra neutra, que es het lichaam, la del médico y la de los libros. het lijf es más coloquial y físico y vive sobre todo en frases hechas, uit je lijf, een strak lijf (un cuerpo en forma), iets aan den lijve ondervinden (vivirlo en carne propia).
• uit — de, fuera de.
• kosten — costar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: een rib uit je lijf kosten' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: een rib uit je lijf kosten' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 004. een fluitje van een cent zijn
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het fluitje — el silbatito, diminutivo de de fluit, la flauta o el silbato.
• de cent — el céntimo, la moneda más pequeña; un silbato de juguete costaba eso.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: een fluitje van een cent zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: een fluitje van een cent zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 005. er schoon genoeg van hebben
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• schoon — limpio en el uso normal; aquí es un adverbio antiguo que significa del todo, y así solo vive en esta frase.
• genoeg — bastante, suficiente.
• er … van — de ello.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: er schoon genoeg van hebben' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: er schoon genoeg van hebben' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 006. geen blad voor de mond nemen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het blad — la hoja de un árbol o de papel, y también la bandeja.
• de mond — la boca de una persona.
• nemen — tomar, coger.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: geen blad voor de mond nemen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: geen blad voor de mond nemen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 007. een flater slaan
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de flater — la metedura de pata, el error torpe; casi solo se usa con slaan.
• slaan — golpear, pegar.
• hoy se oyen igual o más een blunder maken y de mist ingaan.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: een flater slaan' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: een flater slaan' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 008. iemand een handje helpen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het handje — la manita, diminutivo de de hand.
• helpen — ayudar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: iemand een handje helpen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand een handje helpen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 009. APARCADA — niet goed snik zijn (niet goed snik, los jóvenes dicen gestoord o niet normaal)
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'frases hechas: niet goed snik zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: niet goed snik zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
DELETE FROM word_es_groups WHERE word_es_id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: niet goed snik zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: niet goed snik zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1))
   AND group_id IN (SELECT id FROM word_groups WHERE title IN ('frases hechas - uitdrukkingen en spreekwoorden', 'generic'));

-- 010. het regent pijpenstelen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de pijpensteel — la caña de una pipa de fumar, plural pijpenstelen; solo vive en esta frase.
• la imagen es la lluvia que cae en chorros rectos y gruesos como cañas.
• hablando también se dice het regent keihard o het giet.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: het regent pijpenstelen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: het regent pijpenstelen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 011. de spijker op de kop slaan
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de spijker — el clavo.
• de kop — la cabeza de un clavo o de un animal, y coloquial la de una persona.
• slaan — golpear.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: de spijker op de kop slaan' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: de spijker op de kop slaan' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 012. met het verkeerde been uit bed stappen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• verkeerd — equivocado, mal, de verkeerde kant op (en la dirección equivocada).
• het been — la pierna; el pie es de voet.
• het bed — la cama.
• stappen — dar un paso, pisar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: met het verkeerde been uit bed stappen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: met het verkeerde been uit bed stappen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 013. een tandje bijzetten
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het tandje — el dientecito, diminutivo de de tand; aquí el diente de un engranaje.
• bijzetten — añadir, poner al lado.
• lo contrario también se dice, een tandje minder, bajar el ritmo.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: een tandje bijzetten' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: een tandje bijzetten' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 014. geen oog dichtdoen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het oog — el ojo, plural ogen.
• dichtdoen — cerrar, de dicht (cerrado) más doen, de deur dichtdoen.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: geen oog dichtdoen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: geen oog dichtdoen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 015. de handdoek in de ring gooien
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de handdoek — la toalla.
• de ring — el ring de boxeo, y también el anillo.
• gooien — tirar, lanzar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: de handdoek in de ring gooien' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: de handdoek in de ring gooien' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 016. twee vliegen in één klap slaan
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de vlieg — la mosca, plural vliegen, que es también el verbo volar.
• de klap — el golpe, la palmada, y también el bofetón.
• één — uno, con acentos para no confundirlo con een, un.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: twee vliegen in één klap slaan' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: twee vliegen in één klap slaan' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 017. beter laat dan nooit
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• beter — mejor.
• laat — tarde.
• nooit — nunca.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: beter laat dan nooit' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: beter laat dan nooit' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 018. elk nadeel heb z'n voordeel
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het nadeel — la desventaja, el inconveniente.
• het voordeel — la ventaja, y en una tienda la oferta.
• z''n — forma hablada de zijn, su.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: elk nadeel heb z''n voordeel' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: elk nadeel heb z''n voordeel' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 019. spreken is zilver, zwijgen is goud
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• spreken — hablar, algo más formal que praten.
• zwijgen — callar, guardar silencio.
• het zilver — la plata.
• het goud — el oro.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: spreken is zilver, zwijgen is goud' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: spreken is zilver, zwijgen is goud' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 020. een gegeven paard niet in de bek kijken
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het paard — el caballo.
• gegeven — dado, regalado, participio de geven.
• de bek — la boca de un animal; dicho de una persona es grosero, Houd je bek, cierra el pico.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: een gegeven paard niet in de bek kijken' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: een gegeven paard niet in de bek kijken' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 021. duimen voor iemand
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• duimen — viene de de duim, el pulgar; como verbo solo significa desear suerte.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: duimen voor iemand' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: duimen voor iemand' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 022. wat niet weet, wat niet deert
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• weten — saber.
• deren — hacer daño; verbo antiguo que hoy solo vive aquí y en Het deert me niet, no me afecta.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: wat niet weet, wat niet deert' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: wat niet weet, wat niet deert' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 023. beter één vogel in de hand dan tien in de lucht
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de vogel — el pájaro.
• de hand — la mano.
• de lucht — el aire, el cielo.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: beter één vogel in de hand dan tien in de lucht' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: beter één vogel in de hand dan tien in de lucht' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 024. APARCADA — ieder zijn meug (ieder zijn meug, hoy se dice ieder z'n ding)
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'frases hechas: ieder zijn meug' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: ieder zijn meug' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
DELETE FROM word_es_groups WHERE word_es_id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: ieder zijn meug' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: ieder zijn meug' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1))
   AND group_id IN (SELECT id FROM word_groups WHERE title IN ('frases hechas - uitdrukkingen en spreekwoorden', 'generic'));

-- 025. te veel hooi op je vork nemen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het hooi — el heno.
• de vork — el tenedor, y también la horca del heno.
• te veel — demasiado.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: te veel hooi op je vork nemen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: te veel hooi op je vork nemen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 026. het beestje bij zijn naam noemen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het beestje — el bichito, diminutivo de het beest.
• de naam — el nombre.
• noemen — llamar, nombrar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: het beestje bij zijn naam noemen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: het beestje bij zijn naam noemen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 027. tussen hamer en aambeeld zitten
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de hamer — el martillo.
• het aambeeld — el yunque del herrero; casi solo vive en esta frase.
• tussen — entre.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: tussen hamer en aambeeld zitten' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: tussen hamer en aambeeld zitten' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 028. praten als een waterval
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• praten — hablar, charlar, el de todos los días.
• de waterval — la cascada, de het water más de val, la caída.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: praten als een waterval' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: praten als een waterval' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 029. slapen als een roos
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• slapen — dormir.
• de roos — la rosa.
• también se oye slapen als een os, de os, el buey.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: slapen als een roos' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: slapen als een roos' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 030. spijkers op laag water zoeken
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de spijker — el clavo.
• laag water — la marea baja, laag es bajo.
• zoeken — buscar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: spijkers op laag water zoeken' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: spijkers op laag water zoeken' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 031. twee handen op één buik zijn
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de hand — la mano.
• de buik — la barriga, el vientre.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: twee handen op één buik zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: twee handen op één buik zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 032. APARCADA — waar de vos en de haas elkaar goedenacht zeggen (waar de vos en de haas elkaar goedenacht zeggen, hoy in the middle of nowhere o in een gat)
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'frases hechas: waar de vos en de haas elkaar goedenacht zeggen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: waar de vos en de haas elkaar goedenacht zeggen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
DELETE FROM word_es_groups WHERE word_es_id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: waar de vos en de haas elkaar goedenacht zeggen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: waar de vos en de haas elkaar goedenacht zeggen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1))
   AND group_id IN (SELECT id FROM word_groups WHERE title IN ('frases hechas - uitdrukkingen en spreekwoorden', 'generic'));

-- 033. als een boemerang terugkomen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de boemerang — el bumerán.
• terugkomen — volver, terug es de vuelta, hacia atrás.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: als een boemerang terugkomen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: als een boemerang terugkomen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 034. er niets van bakken
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• bakken — hornear, freír, cocer el pan.
• niets o niks — nada; niks es el de hablar.
• er … van — de ello.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: er niets van bakken' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: er niets van bakken' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 035. zich als een vis in het water voelen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de vis — el pez y también el pescado.
• het water — el agua.
• zich voelen — sentirse.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: zich als een vis in het water voelen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: zich als een vis in het water voelen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 036. in je element zijn
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het element — el elemento, como en español.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: in je element zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: in je element zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 037. een ongeluk komt zelden alleen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het ongeluk — la desgracia, y también el accidente, een auto-ongeluk.
• zelden — rara vez.
• alleen — solo.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: een ongeluk komt zelden alleen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: een ongeluk komt zelden alleen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 038. mosterd na de maaltijd
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de mosterd — la mostaza.
• de maaltijd — la comida, cualquiera de las del día.
• na — después de.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: mosterd na de maaltijd' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: mosterd na de maaltijd' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 039. iemand een kat in de zak verkopen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de kat — el gato.
• de zak — el saco, la bolsa y también el bolsillo.
• verkopen — vender.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: iemand een kat in de zak verkopen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand een kat in de zak verkopen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 040. de druppel die de emmer doet overlopen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de druppel — la gota.
• de emmer — el cubo.
• overlopen — rebosar, desbordarse.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: de druppel die de emmer doet overlopen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: de druppel die de emmer doet overlopen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 041. de koe bij de hoorns vatten
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de koe — la vaca, plural koeien.
• de hoorn — el cuerno, plural hoorns o horens.
• vatten — agarrar, algo formal; hoy vive en frases hechas y con el sentido de pillar, Vat je ''m? ¿Lo pillas?.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: de koe bij de hoorns vatten' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: de koe bij de hoorns vatten' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 042. ter zake komen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de zaak — el asunto, y también el negocio o la tienda.
• ter — forma antigua de te de, que solo sobrevive en fórmulas, ter zake, ter plaatse (en el sitio).

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: ter zake komen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: ter zake komen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 043. platzak zijn
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• platzak — de plat, plano, más de zak, el bolsillo.
• blut — sin blanca, lo que más dicen los jóvenes.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: platzak zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: platzak zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 044. geld over de balk gooien
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het geld — el dinero.
• de balk — la viga del techo.
• gooien — tirar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: geld over de balk gooien' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: geld over de balk gooien' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 045. zo rood als een tomaat worden
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• rood — rojo.
• de tomaat — el tomate.
• worden — ponerse, volverse.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: zo rood als een tomaat worden' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: zo rood als een tomaat worden' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 046. doodop zijn
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• doodop — de dood, muerto, más op, gastado o acabado, Het brood is op, se ha acabado el pan.
• hoy se oye igual o más kapot y bekaf.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: doodop zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: doodop zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 047. het kan me geen moer schelen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• schelen — importar, con het de sujeto; también diferenciarse, Dat scheelt veel, eso cambia mucho.
• de moer — la tuerca; geen moer es coloquial para nada.
• los jóvenes dicen mucho Het boeit me niet, me da igual.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: het kan me geen moer schelen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: het kan me geen moer schelen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 048. een oogje dichtknijpen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het oogje — el ojito, diminutivo de het oog.
• dichtknijpen — cerrar apretando; knijpen es pellizcar o apretar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: een oogje dichtknijpen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: een oogje dichtknijpen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 049. op het puntje van je tong liggen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het puntje — la puntita, diminutivo de de punt.
• de tong — la lengua del cuerpo; el idioma es de taal.
• liggen — estar tumbado.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: op het puntje van je tong liggen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: op het puntje van je tong liggen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 050. zich in iemand verplaatsen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• zich verplaatsen — desplazarse; en sentido literal, Hij verplaatst de stoel, mueve la silla.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: zich in iemand verplaatsen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: zich in iemand verplaatsen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 051. de kastanjes uit het vuur halen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de kastanje — la castaña.
• het vuur — el fuego.
• halen — ir a buscar, traer, sacar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: de kastanjes uit het vuur halen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: de kastanjes uit het vuur halen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 052. de touwtjes in handen hebben
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het touwtje — la cuerdecita, diminutivo de het touw.
• de handen — las manos.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: de touwtjes in handen hebben' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: de touwtjes in handen hebben' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 053. geen flauw idee hebben
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• flauw — flojo, soso; también sin gracia o injusto, Doe niet zo flauw, no seas tan soso.
• het idee — la idea.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: geen flauw idee hebben' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: geen flauw idee hebben' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 054. met de armen over elkaar zitten
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de arm — el brazo.
• over elkaar — uno sobre otro.
• zitten — estar sentado.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: met de armen over elkaar zitten' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: met de armen over elkaar zitten' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 055. om de hoek
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de hoek — la esquina y también el rincón.
• om — alrededor de.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: om de hoek' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: om de hoek' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 056. de appel valt niet ver van de boom
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de appel — la manzana.
• vallen — caer.
• ver — lejos.
• de boom — el árbol.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: de appel valt niet ver van de boom' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: de appel valt niet ver van de boom' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 057. de aanhouder wint
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de aanhouder — el que persiste, de aanhouden, no soltar; la palabra sola casi no se usa, el refrán sí.
• winnen — ganar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: de aanhouder wint' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: de aanhouder wint' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 058. het is niet alles goud wat er blinkt
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het goud — el oro.
• blinken — brillar, relucir.
• er — de relleno, no se traduce.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: het is niet alles goud wat er blinkt' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: het is niet alles goud wat er blinkt' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 059. APARCADA — de morgenstond heeft goud in de mond (de morgenstond heeft goud in de mond, refrán de abuelo)
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'frases hechas: de morgenstond heeft goud in de mond' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: de morgenstond heeft goud in de mond' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
DELETE FROM word_es_groups WHERE word_es_id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: de morgenstond heeft goud in de mond' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: de morgenstond heeft goud in de mond' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1))
   AND group_id IN (SELECT id FROM word_groups WHERE title IN ('frases hechas - uitdrukkingen en spreekwoorden', 'generic'));

-- 060. blaffende honden bijten niet
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• blaffen — ladrar.
• de hond — el perro.
• bijten — morder.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: blaffende honden bijten niet' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: blaffende honden bijten niet' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 061. moord en brand schreeuwen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de moord — el asesinato.
• de brand — el incendio, y Brand! es ¡fuego!.
• schreeuwen — gritar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: moord en brand schreeuwen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: moord en brand schreeuwen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 062. Oost-Indisch doof zijn
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• Oost-Indisch — de las Indias Orientales, la antigua colonia de Indonesia.
• doof — sordo.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: Oost-Indisch doof zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: Oost-Indisch doof zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 063. als je het over de duivel hebt
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de duivel — el diablo.
• de staart — la cola.
• trappen op — pisar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: als je het over de duivel hebt' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: als je het over de duivel hebt' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 064. er zit een luchtje aan
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het luchtje — el olorcillo, diminutivo de de lucht, que es el aire y también el olor.
• zitten aan — estar pegado a.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: er zit een luchtje aan' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: er zit een luchtje aan' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 065. door een roze bril kijken
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• roze — rosa, el color.
• de bril — las gafas, en singular en neerlandés.
• kijken door — mirar a través de.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: door een roze bril kijken' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: door een roze bril kijken' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 066. de klos zijn
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de klos — el carrete, la bobina; con ese sentido apenas se usa, pero la frase está muy viva entre jóvenes y adultos.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: de klos zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: de klos zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 067. je nek uitsteken
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de nek — la nuca, el cuello por detrás; el de delante o el de la camisa es de hals o de kraag.
• uitsteken — sacar hacia fuera, asomar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: je nek uitsteken' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: je nek uitsteken' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 068. APARCADA — op je paasbest zijn (op je paasbest, hoy helemaal opgedoft o netjes gekleed)
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'frases hechas: op je paasbest zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: op je paasbest zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
DELETE FROM word_es_groups WHERE word_es_id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: op je paasbest zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: op je paasbest zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1))
   AND group_id IN (SELECT id FROM word_groups WHERE title IN ('frases hechas - uitdrukkingen en spreekwoorden', 'generic'));

-- 069. er een nachtje over slapen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het nachtje — la nochecita, diminutivo de de nacht.
• slapen over — dormir sobre.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: er een nachtje over slapen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: er een nachtje over slapen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 070. korte metten maken met
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• kort — corto.
• de metten — los maitines, el rezo de la noche en los monasterios; sola ya no se usa.
• maken — hacer.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: korte metten maken met' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: korte metten maken met' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 071. de huid niet verkopen voordat de beer geschoten is
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de huid — la piel de personas y animales.
• de beer — el oso.
• schieten — disparar, participio geschoten.
• voordat — antes de que.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: de huid niet verkopen voordat de beer geschoten is' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: de huid niet verkopen voordat de beer geschoten is' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 072. het water staat je tot aan de lippen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het water — el agua.
• de lip — el labio, plural lippen.
• staan tot aan — llegar hasta.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: het water staat je tot aan de lippen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: het water staat je tot aan de lippen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 073. aan iemands kop zeuren
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• zeuren — dar la tabarra, quejarse sin parar; un pesado quejica es een zeur o een zeurpiet.
• de kop — la cabeza, coloquial; con personas suena algo brusco.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: aan iemands kop zeuren' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: aan iemands kop zeuren' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 074. iemand op de zenuwen werken
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de zenuw — el nervio, plural zenuwen.
• werken op — actuar sobre, afectar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: iemand op de zenuwen werken' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand op de zenuwen werken' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 075. een kruiwagen hebben
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de kruiwagen — la carretilla, la que te empuja hacia arriba.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: een kruiwagen hebben' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: een kruiwagen hebben' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 076. je slag slaan
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de slag — el golpe, y también la batalla.
• slaan — golpear.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: je slag slaan' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: je slag slaan' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 077. goed van pas komen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• van pas — en el momento justo; viene de het pas, el paso.
• goed — bien.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: goed van pas komen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: goed van pas komen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 078. dat is andere koek
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de koek — el bizcocho, la galleta.
• ander — otro, con -e delante del sustantivo, andere.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: dat is andere koek' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: dat is andere koek' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 079. als kat en hond leven
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de kat — el gato.
• de hond — el perro.
• leven — vivir.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: als kat en hond leven' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: als kat en hond leven' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 080. APARCADA — met stomheid geslagen zijn (met stomheid geslagen, sobre todo escrito; hablando, ik was sprakeloos)
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'frases hechas: met stomheid geslagen zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: met stomheid geslagen zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
DELETE FROM word_es_groups WHERE word_es_id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: met stomheid geslagen zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: met stomheid geslagen zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1))
   AND group_id IN (SELECT id FROM word_groups WHERE title IN ('frases hechas - uitdrukkingen en spreekwoorden', 'generic'));

-- 081. voor de zekerheid
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de zekerheid — la seguridad, la certeza, de zeker, seguro.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: voor de zekerheid' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: voor de zekerheid' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 082. APARCADA — kant noch wal raken (kant noch wal raken, sobre todo escrito; hablando, het slaat nergens op)
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'frases hechas: kant noch wal raken' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: kant noch wal raken' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
DELETE FROM word_es_groups WHERE word_es_id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: kant noch wal raken' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: kant noch wal raken' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1))
   AND group_id IN (SELECT id FROM word_groups WHERE title IN ('frases hechas - uitdrukkingen en spreekwoorden', 'generic'));

-- 083. zomaar ineens
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• zomaar — así sin más, porque sí, muy usado solo, Zomaar! ¡Porque sí!.
• ineens — de repente, de in más eens.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: zomaar ineens' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: zomaar ineens' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 084. afkloppen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• afkloppen — de af, quitar, más kloppen, golpear o llamar a la puerta.
• kloppen también es cuadrar, Dat klopt, es correcto.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: afkloppen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: afkloppen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 085. olie op het vuur gooien
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de olie — el aceite.
• het vuur — el fuego.
• gooien — tirar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: olie op het vuur gooien' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: olie op het vuur gooien' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 086. zich te goed doen aan
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• goed — bien.
• doen — hacer.
• aan — con, de, marca la comida.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: zich te goed doen aan' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: zich te goed doen aan' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 087. APARCADA — het buskruit niet uitgevonden hebben (het buskruit niet uitgevonden hebben, anticuada)
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'frases hechas: het buskruit niet uitgevonden hebben' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: het buskruit niet uitgevonden hebben' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
DELETE FROM word_es_groups WHERE word_es_id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: het buskruit niet uitgevonden hebben' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: het buskruit niet uitgevonden hebben' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1))
   AND group_id IN (SELECT id FROM word_groups WHERE title IN ('frases hechas - uitdrukkingen en spreekwoorden', 'generic'));

-- 088. niet van gisteren zijn
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• gisteren — ayer.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: niet van gisteren zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: niet van gisteren zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 089. APARCADA — een blauwtje lopen (een blauwtje lopen, anticuada; hoy afgewezen worden)
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'frases hechas: een blauwtje lopen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: een blauwtje lopen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - para más adelante'));
DELETE FROM word_es_groups WHERE word_es_id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: een blauwtje lopen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: een blauwtje lopen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1))
   AND group_id IN (SELECT id FROM word_groups WHERE title IN ('frases hechas - uitdrukkingen en spreekwoorden', 'generic'));

-- 090. op rolletjes lopen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het rolletje — la ruedita, diminutivo de de rol.
• lopen — andar, y también funcionar, De machine loopt.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: op rolletjes lopen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: op rolletjes lopen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 091. het kwartje valt
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• het kwartje — la moneda de 25 céntimos de florín; la moneda ya no existe, la frase sigue muy viva.
• vallen — caer.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: het kwartje valt' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: het kwartje valt' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 092. geen sprake van
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de sprake — la mención, el hablar de algo; sola no se usa, pero er is sprake van, se habla de, sí.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: geen sprake van' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: geen sprake van' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 093. aan de slag
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de slag — el golpe; aan de slag es al trabajo.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: aan de slag' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: aan de slag' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 094. alles op alles zetten
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• alles — todo.
• zetten — poner, de pie o en posición.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: alles op alles zetten' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: alles op alles zetten' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 095. iemand op heterdaad betrappen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de heterdaad — el hecho en caliente, de heet, caliente, más de daad, el acto; solo vive en esta frase.
• betrappen — pillar, sorprender.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: iemand op heterdaad betrappen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand op heterdaad betrappen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 096. zo klaar als een klontje zijn
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• klaar — claro aquí, pero lo normal es listo o terminado, Ik ben klaar, he terminado.
• het klontje — el terrón, sobre todo de azúcar, een klontje suiker.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: zo klaar als een klontje zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: zo klaar als een klontje zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 097. zo koppig als een ezel zijn
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• koppig — terco, de de kop, la cabeza.
• de ezel — el burro.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: zo koppig als een ezel zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: zo koppig als een ezel zijn' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 098. om de hete brij heen draaien
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• heet — muy caliente.
• de brij — la papilla espesa; casi solo vive en esta frase.
• draaien — girar, dar vueltas.
• om … heen — alrededor de.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: om de hete brij heen draaien' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: om de hete brij heen draaien' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 099. van de hak op de tak springen
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de hak — el talón, y el tacón del zapato.
• de tak — la rama.
• springen — saltar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: van de hak op de tak springen' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: van de hak op de tak springen' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';

-- 100. de wereld is klein
UPDATE words_es SET rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

📖 Palabra a palabra:

• de wereld — el mundo.
• klein — pequeño.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: de wereld is klein' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'frases hechas: de wereld is klein' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%📖 Palabra a palabra%';
