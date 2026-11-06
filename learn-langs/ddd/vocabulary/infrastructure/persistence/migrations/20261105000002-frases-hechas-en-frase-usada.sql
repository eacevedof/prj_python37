-- Learn Languages App - Migration
-- Migration: 20261105000002-frases-hechas-en-frase-usada
-- Description: Eduardo (2026-11-05), sobre el grupo 55 recién creado: «esta bien pero mejor prefiero la
--   expresion en una frase muy usada, y en la ayuda si que expliques la construccion original. Pe. 1667
--   Cada vez que le hablo estas en las nubes (a ella) y Als ik tegen haar praat is ze steeds met haar
--   gedachten ergens anders … y en la ayuda pones lo de siempre más: met je gedachten ergens anders zijn».
--
--   Las 100 PHRASE de 20261105000001 cambian el modismo suelto por una frase de uso diario que lo
--   contiene (words_es.text y words_lang.text). Las marcas siguen §3.2/§3.9: (inv) cuando la respuesta
--   abre con complemento o subordinada y el orden neutro también vale, (ella)/(él)/(yo) cuando el español
--   no deja ver la persona. Para la 1667 se elige Elke keer als ik tegen haar praat, is ze met haar
--   gedachten ergens anders (coma tras la subordinada; elke keer als mejor que als … steeds).
--
--   La ayuda conserva todo y gana, delante del 🧩, el bloque '🔤 La construcción original y cómo entra en la frase:' con la frase hecha
--   de diccionario (es = nl) y cómo se adapta en la tarjeta (posesivo, persona, orden). Las 100 SENTENCE de
--   ejemplo no cambian. Se vacía el audio de las 100 PHRASE (audio_path, audio_url, md5 y word_es_media)
--   porque su texto ya no es el mismo; los mp3 locales data/audio/word-<id>-*.mp3 se borran a mano.
--   Generada con C:\projects\claude-tmp\learn-langs-frases-hechas\gen2.py desde data2.py.

PRAGMA foreign_keys = ON;

-- 001. estar en las nubes → Cada vez que le hablo, está en las nubes. (ella, inv)
UPDATE words_es
   SET text = 'Cada vez que le hablo, está en las nubes. (ella, inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar en las nubes = met je gedachten ergens anders zijn.
• en esta tarjeta — je pasa a haar porque el sujeto es ze; la subordinada va delante y empuja el verbo antes del sujeto, is ze; tegen haar praten es hablarle a ella.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: met je gedachten ergens anders zijn' AND word_type = 'PHRASE' AND text = 'estar en las nubes'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Elke keer als ik tegen haar praat, is ze met haar gedachten ergens anders.', pronunciation = 'elke ker als ik tejen haar praat, is se met haar jedajten erjens anders', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: met je gedachten ergens anders zijn' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'met je gedachten ergens anders zijn';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: met je gedachten ergens anders zijn' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 002. tomar el pelo a alguien → ¿Me estás tomando el pelo o lo dices en serio?
UPDATE words_es
   SET text = '¿Me estás tomando el pelo o lo dices en serio?', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — tomar el pelo a alguien = iemand voor de gek houden.
• en esta tarjeta — iemand pasa a me y se coloca entre houden y voor; en la pregunta el verbo va primero y jij pierde la -t, houd je; menen es decirlo en serio.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: iemand voor de gek houden' AND word_type = 'PHRASE' AND text = 'tomar el pelo a alguien'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Houd je me voor de gek of meen je het?', pronunciation = 'haut ie me for de jek of men ie het', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand voor de gek houden' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'iemand voor de gek houden';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand voor de gek houden' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 003. costar un ojo de la cara → Las entradas del concierto cuestan un ojo de la cara.
UPDATE words_es
   SET text = 'Las entradas del concierto cuestan un ojo de la cara.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — costar un ojo de la cara = een rib uit je lijf kosten.
• en esta tarjeta — el sujeto son los kaartjes, en plural, kosten; uit je lijf se queda con el je genérico.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: een rib uit je lijf kosten' AND word_type = 'PHRASE' AND text = 'costar un ojo de la cara'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'De kaartjes voor het concert kosten een rib uit je lijf.', pronunciation = 'de kaarties for het konsert kosten en rib öit ie leif', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een rib uit je lijf kosten' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'een rib uit je lijf kosten';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een rib uit je lijf kosten' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 004. ser pan comido → No te preocupes, eso es pan comido.
UPDATE words_es
   SET text = 'No te preocupes, eso es pan comido.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ser pan comido = een fluitje van een cent zijn.
• en esta tarjeta — zijn se conjuga is con dat de sujeto; maak je geen zorgen es otra frase hecha, no te preocupes.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: een fluitje van een cent zijn' AND word_type = 'PHRASE' AND text = 'ser pan comido'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Maak je geen zorgen, dat is een fluitje van een cent.', pronunciation = 'maak ie jen sorjen, dat is en flöitie fan en sent', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een fluitje van een cent zijn' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'een fluitje van een cent zijn';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een fluitje van een cent zijn' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 005. estar hasta las narices → Estoy hasta las narices de tanta lluvia.
UPDATE words_es
   SET text = 'Estoy hasta las narices de tanta lluvia.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar hasta las narices = er schoon genoeg van hebben.
• en esta tarjeta — con la cosa nombrada desaparece el er y queda van al die regen; hebben se conjuga heb.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: er schoon genoeg van hebben' AND word_type = 'PHRASE' AND text = 'estar hasta las narices'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Ik heb schoon genoeg van al die regen.', pronunciation = 'ik heb sjon jenuj fan al di rejen', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: er schoon genoeg van hebben' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'er schoon genoeg van hebben';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: er schoon genoeg van hebben' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 006. no tener pelos en la lengua → Mi jefe no tiene pelos en la lengua.
UPDATE words_es
   SET text = 'Mi jefe no tiene pelos en la lengua.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no tener pelos en la lengua = geen blad voor de mond nemen.
• en esta tarjeta — nemen se conjuga neemt; voor de mond no cambia aunque la boca sea la suya.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: geen blad voor de mond nemen' AND word_type = 'PHRASE' AND text = 'no tener pelos en la lengua'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Mijn baas neemt geen blad voor de mond.', pronunciation = 'mein baas nemt jen blat for de mont', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: geen blad voor de mond nemen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'geen blad voor de mond nemen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: geen blad voor de mond nemen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 007. meter la pata → Creo que he metido la pata con lo que dije.
UPDATE words_es
   SET text = 'Creo que he metido la pata con lo que dije.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — meter la pata = een flater slaan.
• en esta tarjeta — en la subordinada con dat los verbos van al final, heb geslagen; slaan es fuerte, geslagen.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: een flater slaan' AND word_type = 'PHRASE' AND text = 'meter la pata'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Ik denk dat ik een flater heb geslagen met wat ik zei.', pronunciation = 'ik denk dat ik en flater heb jeslajen met vat ik sei', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een flater slaan' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'een flater slaan';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een flater slaan' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 008. echar una mano → Si necesitas algo, te echo una mano. (inv)
UPDATE words_es
   SET text = 'Si necesitas algo, te echo una mano. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — echar una mano = iemand een handje helpen.
• en esta tarjeta — iemand pasa a je; tras la subordinada el verbo va antes del sujeto, help ik; wel suaviza y ofrece.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: iemand een handje helpen' AND word_type = 'PHRASE' AND text = 'echar una mano'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Als je iets nodig hebt, help ik je wel een handje.', pronunciation = 'als ie its nodij hebt, help ik ie vel en handie', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand een handje helpen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'iemand een handje helpen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand een handje helpen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 009. estar como una cabra → Tu hermano está como una cabra.
UPDATE words_es
   SET text = 'Tu hermano está como una cabra.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar como una cabra = niet goed snik zijn.
• en esta tarjeta — zijn se conjuga is; snik no cambia nunca.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: niet goed snik zijn' AND word_type = 'PHRASE' AND text = 'estar como una cabra'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Je broer is niet goed snik.', pronunciation = 'ie brur is nit jut snik', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: niet goed snik zijn' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'niet goed snik zijn';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: niet goed snik zijn' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 010. llover a cántaros → No salgas ahora, que está lloviendo a cántaros.
UPDATE words_es
   SET text = 'No salgas ahora, que está lloviendo a cántaros.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — llover a cántaros = het regent pijpenstelen.
• en esta tarjeta — la frase entra entera; el neerlandés no usa gerundio, el presente het regent ya es está lloviendo.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: het regent pijpenstelen' AND word_type = 'PHRASE' AND text = 'llover a cántaros'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Ga nu niet naar buiten, het regent pijpenstelen.', pronunciation = 'ja nü nit naar böiten, het rejent peipenstelen', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: het regent pijpenstelen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'het regent pijpenstelen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: het regent pijpenstelen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 011. dar en el clavo → Creo que has dado en el clavo.
UPDATE words_es
   SET text = 'Creo que has dado en el clavo.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — dar en el clavo = de spijker op de kop slaan.
• en esta tarjeta — en la subordinada con dat los verbos van al final, hebt geslagen; con jij el auxiliar es hebt.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: de spijker op de kop slaan' AND word_type = 'PHRASE' AND text = 'dar en el clavo'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Ik denk dat je de spijker op de kop hebt geslagen.', pronunciation = 'ik denk dat ie de speiker op de kop hebt jeslajen', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de spijker op de kop slaan' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'de spijker op de kop slaan';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de spijker op de kop slaan' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 012. levantarse con el pie izquierdo → Mi jefe se ha levantado hoy con el pie izquierdo.
UPDATE words_es
   SET text = 'Mi jefe se ha levantado hoy con el pie izquierdo.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — levantarse con el pie izquierdo = met het verkeerde been uit bed stappen.
• en esta tarjeta — stappen va con zijn, is gestapt; uit bed gestapt cierra la frase y vandaag va justo detrás de is.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: met het verkeerde been uit bed stappen' AND word_type = 'PHRASE' AND text = 'levantarse con el pie izquierdo'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Mijn baas is vandaag met het verkeerde been uit bed gestapt.', pronunciation = 'mein baas is fandaaj met het ferkerde ben öit bet jestapt', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: met het verkeerde been uit bed stappen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'met het verkeerde been uit bed stappen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: met het verkeerde been uit bed stappen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 013. ponerse las pilas → Si quieres aprobar, tienes que ponerte las pilas. (inv)
UPDATE words_es
   SET text = 'Si quieres aprobar, tienes que ponerte las pilas. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ponerse las pilas = een tandje bijzetten.
• en esta tarjeta — tras la subordinada el verbo va delante, moet je; con moeten el separable queda junto al final, bijzetten.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: een tandje bijzetten' AND word_type = 'PHRASE' AND text = 'ponerse las pilas'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Als je wilt slagen, moet je een tandje bijzetten.', pronunciation = 'als ie vilt slajen, mut ie en tandie beiseten', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een tandje bijzetten' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'een tandje bijzetten';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een tandje bijzetten' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 014. no pegar ojo → Con el calor no he pegado ojo. (inv)
UPDATE words_es
   SET text = 'Con el calor no he pegado ojo. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no pegar ojo = geen oog dichtdoen.
• en esta tarjeta — perfecto con hebben y el participio dichtgedaan junto al final, con el ge- dentro; tras door de hitte, heb ik.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: geen oog dichtdoen' AND word_type = 'PHRASE' AND text = 'no pegar ojo'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Door de hitte heb ik geen oog dichtgedaan.', pronunciation = 'dor de hite heb ik jen oj dijtjedaan', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: geen oog dichtdoen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'geen oog dichtdoen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: geen oog dichtdoen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 015. tirar la toalla → Estaba a punto de tirar la toalla. (yo)
UPDATE words_es
   SET text = 'Estaba a punto de tirar la toalla. (yo)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — tirar la toalla = de handdoek in de ring gooien.
• en esta tarjeta — con op het punt staan om, la expresión va con te + infinitivo al final, in de ring te gooien.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: de handdoek in de ring gooien' AND word_type = 'PHRASE' AND text = 'tirar la toalla'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Ik stond op het punt om de handdoek in de ring te gooien.', pronunciation = 'ik stont op het pünt om de handuk in de ring te join', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de handdoek in de ring gooien' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'de handdoek in de ring gooien';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de handdoek in de ring gooien' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 016. matar dos pájaros de un tiro → Si vamos en coche, matamos dos pájaros de un tiro. (inv)
UPDATE words_es
   SET text = 'Si vamos en coche, matamos dos pájaros de un tiro. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — matar dos pájaros de un tiro = twee vliegen in één klap slaan.
• en esta tarjeta — slaan se conjuga en plural; tras la subordinada, slaan we.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: twee vliegen in één klap slaan' AND word_type = 'PHRASE' AND text = 'matar dos pájaros de un tiro'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Als we met de auto gaan, slaan we twee vliegen in één klap.', pronunciation = 'als ve met de auto jaan, slaan ve tue flijen in één klap', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: twee vliegen in één klap slaan' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'twee vliegen in één klap slaan';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: twee vliegen in één klap slaan' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 017. más vale tarde que nunca → Por fin has llegado, más vale tarde que nunca. (inv)
UPDATE words_es
   SET text = 'Por fin has llegado, más vale tarde que nunca. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — más vale tarde que nunca = beter laat dan nooit.
• en esta tarjeta — el refrán no cambia y va detrás de la coma, pegado a la frase.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: beter laat dan nooit' AND word_type = 'PHRASE' AND text = 'más vale tarde que nunca'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Eindelijk ben je er, beter laat dan nooit.', pronunciation = 'eindeleik ben ie er, beter laat dan noit', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: beter laat dan nooit' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'beter laat dan nooit';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: beter laat dan nooit' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 018. no hay mal que por bien no venga → He perdido el tren, pero no hay mal que por bien no venga.
UPDATE words_es
   SET text = 'He perdido el tren, pero no hay mal que por bien no venga.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no hay mal que por bien no venga = elk nadeel heb z''n voordeel.
• en esta tarjeta — el refrán no cambia, ni siquiera el heb sin -t de Cruijff.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: elk nadeel heb z''n voordeel' AND word_type = 'PHRASE' AND text = 'no hay mal que por bien no venga'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Ik heb de trein gemist, maar elk nadeel heb z''n voordeel.', pronunciation = 'ik heb de trein jemist, maar elk nadel heb s''n fordel', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: elk nadeel heb z''n voordeel' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'elk nadeel heb z''n voordeel';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: elk nadeel heb z''n voordeel' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 019. en boca cerrada no entran moscas → Mejor no digas nada, en boca cerrada no entran moscas.
UPDATE words_es
   SET text = 'Mejor no digas nada, en boca cerrada no entran moscas.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — en boca cerrada no entran moscas = spreken is zilver, zwijgen is goud.
• en esta tarjeta — el refrán no cambia; zeg maar niks es el imperativo suave.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: spreken is zilver, zwijgen is goud' AND word_type = 'PHRASE' AND text = 'en boca cerrada no entran moscas'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Zeg maar niks, spreken is zilver, zwijgen is goud.', pronunciation = 'sej maar niks, spreken is silfer, sueijen is jaut', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: spreken is zilver, zwijgen is goud' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'spreken is zilver, zwijgen is goud';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: spreken is zilver, zwijgen is goud' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 020. a caballo regalado no se le mira el diente → Es un regalo, y a caballo regalado no se le mira el diente.
UPDATE words_es
   SET text = 'Es un regalo, y a caballo regalado no se le mira el diente.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — a caballo regalado no se le mira el diente = een gegeven paard niet in de bek kijken.
• en esta tarjeta — esta es la forma más oída del refrán, con el objeto delante y el verbo segundo, moet je; kijken va al final.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: een gegeven paard niet in de bek kijken' AND word_type = 'PHRASE' AND text = 'a caballo regalado no se le mira el diente'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Het is een cadeau, en een gegeven paard moet je niet in de bek kijken.', pronunciation = 'het is en kadeau, en en jejefen paart mut ie nit in de bek keiken', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een gegeven paard niet in de bek kijken' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'een gegeven paard niet in de bek kijken';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een gegeven paard niet in de bek kijken' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 021. cruzar los dedos por alguien → Mañana tengo el examen, cruza los dedos por mí. (inv)
UPDATE words_es
   SET text = 'Mañana tengo el examen, cruza los dedos por mí. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — cruzar los dedos por alguien = duimen voor iemand.
• en esta tarjeta — imperativo duim, sin -t; voor me es por mí.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: duimen voor iemand' AND word_type = 'PHRASE' AND text = 'cruzar los dedos por alguien'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Morgen heb ik mijn examen, duim voor me!', pronunciation = 'morjen heb ik mein eksamen, döim for me', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: duimen voor iemand' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'duimen voor iemand';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: duimen voor iemand' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 022. ojos que no ven, corazón que no siente → No se lo cuentes, ojos que no ven, corazón que no siente.
UPDATE words_es
   SET text = 'No se lo cuentes, ojos que no ven, corazón que no siente.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ojos que no ven, corazón que no siente = wat niet weet, wat niet deert.
• en esta tarjeta — el refrán no cambia.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: wat niet weet, wat niet deert' AND word_type = 'PHRASE' AND text = 'ojos que no ven, corazón que no siente'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Vertel het hem niet, wat niet weet, wat niet deert.', pronunciation = 'fertel het hem nit, vat nit vet, vat nit dert', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: wat niet weet, wat niet deert' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'wat niet weet, wat niet deert';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: wat niet weet, wat niet deert' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 023. más vale pájaro en mano que ciento volando → Acepta la oferta, más vale pájaro en mano que ciento volando.
UPDATE words_es
   SET text = 'Acepta la oferta, más vale pájaro en mano que ciento volando.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — más vale pájaro en mano que ciento volando = beter één vogel in de hand dan tien in de lucht.
• en esta tarjeta — el refrán no cambia; aannemen es separable, neem … aan.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: beter één vogel in de hand dan tien in de lucht' AND word_type = 'PHRASE' AND text = 'más vale pájaro en mano que ciento volando'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Neem het aanbod aan, beter één vogel in de hand dan tien in de lucht.', pronunciation = 'nem het aanbot aan, beter één fojel in de hant dan tin in de lüjt', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: beter één vogel in de hand dan tien in de lucht' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'beter één vogel in de hand dan tien in de lucht';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: beter één vogel in de hand dan tien in de lucht' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 024. cada loco con su tema → A mi tío le encanta la ópera, cada loco con su tema.
UPDATE words_es
   SET text = 'A mi tío le encanta la ópera, cada loco con su tema.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — cada loco con su tema = ieder zijn meug.
• en esta tarjeta — el refrán no cambia; gek zijn op es otra frase hecha, encantarle a uno algo.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: ieder zijn meug' AND word_type = 'PHRASE' AND text = 'cada loco con su tema'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Mijn oom is gek op opera, ieder zijn meug.', pronunciation = 'mein om is jek op opera, ider sein möj', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: ieder zijn meug' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'ieder zijn meug';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: ieder zijn meug' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 025. abarcar demasiado → Con tres trabajos, estás abarcando demasiado. (inv)
UPDATE words_es
   SET text = 'Con tres trabajos, estás abarcando demasiado. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — abarcar demasiado = te veel hooi op je vork nemen.
• en esta tarjeta — je sigue siendo je porque el sujeto es jij; tras met drie banen el verbo va delante, neem je; sin gerundio, el presente basta.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: te veel hooi op je vork nemen' AND word_type = 'PHRASE' AND text = 'abarcar demasiado'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Met drie banen neem je te veel hooi op je vork.', pronunciation = 'met dri banen nem ie te fel hoi op ie fork', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: te veel hooi op je vork nemen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'te veel hooi op je vork nemen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: te veel hooi op je vork nemen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 026. llamar al pan, pan y al vino, vino → Mi abuela siempre llama al pan, pan y al vino, vino.
UPDATE words_es
   SET text = 'Mi abuela siempre llama al pan, pan y al vino, vino.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — llamar al pan, pan y al vino, vino = het beestje bij zijn naam noemen.
• en esta tarjeta — noemen se conjuga noemt; altijd se mete entre het beestje y bij zijn naam.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: het beestje bij zijn naam noemen' AND word_type = 'PHRASE' AND text = 'llamar al pan, pan y al vino, vino'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Mijn oma noemt het beestje altijd bij zijn naam.', pronunciation = 'mein oma numt het bestie alteit bei sein naam', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: het beestje bij zijn naam noemen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'het beestje bij zijn naam noemen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: het beestje bij zijn naam noemen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 027. estar entre la espada y la pared → Con este cliente estoy entre la espada y la pared. (inv)
UPDATE words_es
   SET text = 'Con este cliente estoy entre la espada y la pared. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar entre la espada y la pared = tussen hamer en aambeeld zitten.
• en esta tarjeta — zitten se conjuga zit; tras met deze klant, zit ik.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: tussen hamer en aambeeld zitten' AND word_type = 'PHRASE' AND text = 'estar entre la espada y la pared'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Met deze klant zit ik tussen hamer en aambeeld.', pronunciation = 'met dese klant sit ik tüsen hamer en aambelt', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: tussen hamer en aambeeld zitten' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'tussen hamer en aambeeld zitten';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: tussen hamer en aambeeld zitten' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 028. hablar por los codos → Mi hermana habla por los codos por teléfono.
UPDATE words_es
   SET text = 'Mi hermana habla por los codos por teléfono.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — hablar por los codos = praten als een waterval.
• en esta tarjeta — praten se conjuga praat; aan de telefoon es por teléfono.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: praten als een waterval' AND word_type = 'PHRASE' AND text = 'hablar por los codos'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Mijn zus praat als een waterval aan de telefoon.', pronunciation = 'mein süs praat als en vaterfal aan de telefon', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: praten als een waterval' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'praten als een waterval';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: praten als een waterval' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 029. dormir como un tronco → Después de la excursión, los niños durmieron como un tronco. (inv)
UPDATE words_es
   SET text = 'Después de la excursión, los niños durmieron como un tronco. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — dormir como un tronco = slapen als een roos.
• en esta tarjeta — slapen es fuerte, imperfecto sliepen; tras na het uitstapje el verbo va delante del sujeto.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: slapen als een roos' AND word_type = 'PHRASE' AND text = 'dormir como un tronco'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Na het uitstapje sliepen de kinderen als een roos.', pronunciation = 'na het öitstapie slipen de kinderen als en ros', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: slapen als een roos' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'slapen als een roos';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: slapen als een roos' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 030. buscarle tres pies al gato → No le busques tres pies al gato, está bien así.
UPDATE words_es
   SET text = 'No le busques tres pies al gato, está bien así.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — buscarle tres pies al gato = spijkers op laag water zoeken.
• en esta tarjeta — imperativo zoek, sin sujeto; geen va delante de spijkers.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: spijkers op laag water zoeken' AND word_type = 'PHRASE' AND text = 'buscarle tres pies al gato'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Zoek geen spijkers op laag water, het is goed zo.', pronunciation = 'suk jen speikers op laaj vater, het is jut so', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: spijkers op laag water zoeken' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'spijkers op laag water zoeken';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: spijkers op laag water zoeken' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 031. ser uña y carne → Mi hija y su amiga son uña y carne.
UPDATE words_es
   SET text = 'Mi hija y su amiga son uña y carne.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ser uña y carne = twee handen op één buik zijn.
• en esta tarjeta — zijn en plural porque son dos.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: twee handen op één buik zijn' AND word_type = 'PHRASE' AND text = 'ser uña y carne'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Mijn dochter en haar vriendin zijn twee handen op één buik.', pronunciation = 'mein dojter en haar frindin sein tue handen op één böik', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: twee handen op één buik zijn' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'twee handen op één buik zijn';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: twee handen op één buik zijn' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 032. estar en el quinto pino → Mi suegra vive en el quinto pino.
UPDATE words_es
   SET text = 'Mi suegra vive en el quinto pino.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar en el quinto pino = waar de vos en de haas elkaar goedenacht zeggen.
• en esta tarjeta — la expresión es una subordinada de lugar con waar, y zeggen va al final.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: waar de vos en de haas elkaar goedenacht zeggen' AND word_type = 'PHRASE' AND text = 'estar en el quinto pino'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Mijn schoonmoeder woont waar de vos en de haas elkaar goedenacht zeggen.', pronunciation = 'mein sjonmuder vont vaar de fos en de haas elkaar judenajt sejjen', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: waar de vos en de haas elkaar goedenacht zeggen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'waar de vos en de haas elkaar goedenacht zeggen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: waar de vos en de haas elkaar goedenacht zeggen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 033. salir el tiro por la culata → Quiso hacerse el listo y le salió el tiro por la culata. (él)
UPDATE words_es
   SET text = 'Quiso hacerse el listo y le salió el tiro por la culata. (él)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — salir el tiro por la culata = als een boemerang terugkomen.
• en esta tarjeta — el sujeto es het, lo que hizo; terugkomen se separa en imperfecto, kwam … terug.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: als een boemerang terugkomen' AND word_type = 'PHRASE' AND text = 'salir el tiro por la culata'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Hij wilde slim doen, maar het kwam als een boemerang terug.', pronunciation = 'hei vilde slim dun, maar het kuam als en bumerang terüj', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: als een boemerang terugkomen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'als een boemerang terugkomen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: als een boemerang terugkomen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 034. no dar pie con bola → En la cocina no doy pie con bola. (inv)
UPDATE words_es
   SET text = 'En la cocina no doy pie con bola. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no dar pie con bola = er niets van bakken.
• en esta tarjeta — er … van se queda; tras in de keuken, bak ik, y en la cocina además tiene gracia.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: er niets van bakken' AND word_type = 'PHRASE' AND text = 'no dar pie con bola'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'In de keuken bak ik er niets van.', pronunciation = 'in de köken bak ik er nits fan', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: er niets van bakken' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'er niets van bakken';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: er niets van bakken' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 035. estar como pez en el agua → Desde el primer día estoy como pez en el agua en Holanda. (inv)
UPDATE words_es
   SET text = 'Desde el primer día estoy como pez en el agua en Holanda. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar como pez en el agua = zich als een vis in het water voelen.
• en esta tarjeta — zich pasa a me con ik; tras vanaf de eerste dag, voel ik me.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: zich als een vis in het water voelen' AND word_type = 'PHRASE' AND text = 'estar como pez en el agua'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Vanaf de eerste dag voel ik me in Nederland als een vis in het water.', pronunciation = 'fanaf de erste daj ful ik me in nederlant als en fis in het vater', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zich als een vis in het water voelen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'zich als een vis in het water voelen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zich als een vis in het water voelen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 036. estar en su salsa → Con los niños, mi madre está en su salsa. (inv)
UPDATE words_es
   SET text = 'Con los niños, mi madre está en su salsa. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar en su salsa = in je element zijn.
• en esta tarjeta — je pasa a haar porque es mi madre; tras met kinderen, is mijn moeder.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: in je element zijn' AND word_type = 'PHRASE' AND text = 'estar en su salsa'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Met kinderen is mijn moeder in haar element.', pronunciation = 'met kinderen is mein muder in haar element', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: in je element zijn' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'in je element zijn';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: in je element zijn' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 037. las desgracias nunca vienen solas → Se me ha roto el coche y encima llueve, las desgracias nunca vienen solas.
UPDATE words_es
   SET text = 'Se me ha roto el coche y encima llueve, las desgracias nunca vienen solas.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — las desgracias nunca vienen solas = een ongeluk komt zelden alleen.
• en esta tarjeta — el refrán no cambia y sigue en singular.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: een ongeluk komt zelden alleen' AND word_type = 'PHRASE' AND text = 'las desgracias nunca vienen solas'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Mijn auto is kapot en het regent ook nog, een ongeluk komt zelden alleen.', pronunciation = 'mein auto is kapot en het rejent ok noj, en ongelük komt selden alen', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een ongeluk komt zelden alleen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'een ongeluk komt zelden alleen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een ongeluk komt zelden alleen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 038. a buenas horas, mangas verdes → ¿Ahora me pides perdón? A buenas horas, mangas verdes.
UPDATE words_es
   SET text = '¿Ahora me pides perdón? A buenas horas, mangas verdes.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — a buenas horas, mangas verdes = mosterd na de maaltijd.
• en esta tarjeta — suele ir con dat is delante; excuses aanbieden es pedir perdón, separable.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: mosterd na de maaltijd' AND word_type = 'PHRASE' AND text = 'a buenas horas, mangas verdes'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Nu bied je je excuses aan? Dat is mosterd na de maaltijd.', pronunciation = 'nü bit ie ie eksküses aan dat is mostert na de maalteit', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: mosterd na de maaltijd' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'mosterd na de maaltijd';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: mosterd na de maaltijd' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 039. dar gato por liebre → Cuidado con esa web, te pueden dar gato por liebre.
UPDATE words_es
   SET text = 'Cuidado con esa web, te pueden dar gato por liebre.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — dar gato por liebre = iemand een kat in de zak verkopen.
• en esta tarjeta — iemand pasa a je; con kunnen, verkopen va al final.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: iemand een kat in de zak verkopen' AND word_type = 'PHRASE' AND text = 'dar gato por liebre'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Pas op met die website, ze kunnen je een kat in de zak verkopen.', pronunciation = 'pas op met di vebsite, se künen ie en kat in de sak ferkopen', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand een kat in de zak verkopen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'iemand een kat in de zak verkopen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand een kat in de zak verkopen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 040. la gota que colma el vaso → El último retraso del tren fue la gota que colmó el vaso.
UPDATE words_es
   SET text = 'El último retraso del tren fue la gota que colmó el vaso.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — la gota que colma el vaso = de druppel die de emmer doet overlopen.
• en esta tarjeta — doen en imperfecto, deed, y overlopen al final de la relativa.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: de druppel die de emmer doet overlopen' AND word_type = 'PHRASE' AND text = 'la gota que colma el vaso'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'De laatste vertraging van de trein was de druppel die de emmer deed overlopen.', pronunciation = 'de laatste fertrajing fan de trein vas de drüpel di de emer det oferlopen', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de druppel die de emmer doet overlopen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'de druppel die de emmer doet overlopen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de druppel die de emmer doet overlopen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 041. coger el toro por los cuernos → Al final cogí el toro por los cuernos y hablé con él. (inv)
UPDATE words_es
   SET text = 'Al final cogí el toro por los cuernos y hablé con él. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — coger el toro por los cuernos = de koe bij de hoorns vatten.
• en esta tarjeta — perfecto con hebben, gevat; tras uiteindelijk, heb ik.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: de koe bij de hoorns vatten' AND word_type = 'PHRASE' AND text = 'coger el toro por los cuernos'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Uiteindelijk heb ik de koe bij de hoorns gevat en met hem gepraat.', pronunciation = 'öiteindeleik heb ik de ku bei de horns jefat en met hem jepraat', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de koe bij de hoorns vatten' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'de koe bij de hoorns vatten';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de koe bij de hoorns vatten' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 042. ir al grano → Tengo poco tiempo, así que voy al grano.
UPDATE words_es
   SET text = 'Tengo poco tiempo, así que voy al grano.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ir al grano = ter zake komen.
• en esta tarjeta — tras dus no hace falta invertir, dus ik kom; komen se conjuga kom.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: ter zake komen' AND word_type = 'PHRASE' AND text = 'ir al grano'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Ik heb weinig tijd, dus ik kom meteen ter zake.', pronunciation = 'ik heb veinij teit, düs ik kom meten ter sake', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: ter zake komen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'ter zake komen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: ter zake komen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 043. estar sin blanca → No puedo salir, estoy sin blanca.
UPDATE words_es
   SET text = 'No puedo salir, estoy sin blanca.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar sin blanca = platzak zijn.
• en esta tarjeta — platzak no cambia con la persona; zijn se conjuga ben.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: platzak zijn' AND word_type = 'PHRASE' AND text = 'estar sin blanca'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Ik kan niet uitgaan, ik ben platzak.', pronunciation = 'ik kan nit öitjaan, ik ben platsak', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: platzak zijn' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'platzak zijn';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: platzak zijn' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 044. tirar la casa por la ventana → Mi hermano tira la casa por la ventana con cada sueldo.
UPDATE words_es
   SET text = 'Mi hermano tira la casa por la ventana con cada sueldo.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — tirar la casa por la ventana = geld over de balk gooien.
• en esta tarjeta — het geld se sustituye por lo que se derrocha, elk salaris.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: geld over de balk gooien' AND word_type = 'PHRASE' AND text = 'tirar la casa por la ventana'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Mijn broer gooit elk salaris over de balk.', pronunciation = 'mein brur joit elk salaris ofer de balk', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: geld over de balk gooien' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'geld over de balk gooien';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: geld over de balk gooien' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 045. ponerse rojo como un tomate → Cuando la vio, se puso rojo como un tomate. (inv)
UPDATE words_es
   SET text = 'Cuando la vio, se puso rojo como un tomate. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ponerse rojo como un tomate = zo rood als een tomaat worden.
• en esta tarjeta — worden en imperfecto, werd; tras la subordinada con toen, werd hij.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: zo rood als een tomaat worden' AND word_type = 'PHRASE' AND text = 'ponerse rojo como un tomate'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Toen hij haar zag, werd hij zo rood als een tomaat.', pronunciation = 'tun hei haar saj, vert hei so rot als en tomaat', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zo rood als een tomaat worden' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'zo rood als een tomaat worden';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zo rood als een tomaat worden' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 046. estar hecho polvo → Después de trabajar doce horas, estoy hecho polvo. (inv)
UPDATE words_es
   SET text = 'Después de trabajar doce horas, estoy hecho polvo. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar hecho polvo = doodop zijn.
• en esta tarjeta — doodop no cambia; tras na twaalf uur werken, ben ik.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: doodop zijn' AND word_type = 'PHRASE' AND text = 'estar hecho polvo'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Na twaalf uur werken ben ik doodop.', pronunciation = 'na tuaalf ür verken ben ik dodop', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: doodop zijn' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'doodop zijn';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: doodop zijn' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 047. me importa un pimiento → Lo que digan los vecinos me importa un pimiento. (inv)
UPDATE words_es
   SET text = 'Lo que digan los vecinos me importa un pimiento. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — me importa un pimiento = het kan me geen moer schelen.
• en esta tarjeta — lo que importa ocupa el sitio de het, wat de buren zeggen, y kan va justo detrás; también vale Het kan me geen moer schelen wat de buren zeggen.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: het kan me geen moer schelen' AND word_type = 'PHRASE' AND text = 'me importa un pimiento'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Wat de buren zeggen, kan me geen moer schelen.', pronunciation = 'vat de büren sejjen, kan me jen mur sjelen', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: het kan me geen moer schelen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'het kan me geen moer schelen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: het kan me geen moer schelen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 048. hacer la vista gorda → Esta vez el profesor hizo la vista gorda. (inv)
UPDATE words_es
   SET text = 'Esta vez el profesor hizo la vista gorda. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — hacer la vista gorda = een oogje dichtknijpen.
• en esta tarjeta — dichtknijpen es fuerte y separable, kneep … dicht; tras deze keer, kneep de leraar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: een oogje dichtknijpen' AND word_type = 'PHRASE' AND text = 'hacer la vista gorda'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Deze keer kneep de leraar een oogje dicht.', pronunciation = 'dese ker knep de leraar en ojie dijt', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een oogje dichtknijpen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'een oogje dichtknijpen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een oogje dichtknijpen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 049. tenerlo en la punta de la lengua → ¿Cómo se llama esa actriz? Lo tengo en la punta de la lengua.
UPDATE words_es
   SET text = '¿Cómo se llama esa actriz? Lo tengo en la punta de la lengua.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — tenerlo en la punta de la lengua = op het puntje van je tong liggen.
• en esta tarjeta — je pasa a mijn; el sujeto het es el nombre que no sale.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: op het puntje van je tong liggen' AND word_type = 'PHRASE' AND text = 'tenerlo en la punta de la lengua'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Hoe heet die actrice? Het ligt op het puntje van mijn tong.', pronunciation = 'hu het di aktrise het lijt op het püntie fan mein tong', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: op het puntje van je tong liggen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'op het puntje van je tong liggen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: op het puntje van je tong liggen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 050. ponerse en la piel de otro → Ponte en mi piel por un momento.
UPDATE words_es
   SET text = 'Ponte en mi piel por un momento.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ponerse en la piel de otro = zich in iemand verplaatsen.
• en esta tarjeta — imperativo verplaats; zich pasa a je; la persona va con in, in mij.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: zich in iemand verplaatsen' AND word_type = 'PHRASE' AND text = 'ponerse en la piel de otro'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Verplaats je even in mij.', pronunciation = 'ferplaats ie efen in mei', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zich in iemand verplaatsen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'zich in iemand verplaatsen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zich in iemand verplaatsen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 051. sacar las castañas del fuego → Esta vez no te voy a sacar las castañas del fuego. (inv)
UPDATE words_es
   SET text = 'Esta vez no te voy a sacar las castañas del fuego. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — sacar las castañas del fuego = de kastanjes uit het vuur halen.
• en esta tarjeta — niet va delante de voor je; tras deze keer, haal ik.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: de kastanjes uit het vuur halen' AND word_type = 'PHRASE' AND text = 'sacar las castañas del fuego'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Deze keer haal ik de kastanjes niet voor je uit het vuur.', pronunciation = 'dese ker haal ik de kastanies nit for ie öit het für', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de kastanjes uit het vuur halen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'de kastanjes uit het vuur halen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de kastanjes uit het vuur halen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 052. tener la sartén por el mango → En esta empresa el director tiene la sartén por el mango. (inv)
UPDATE words_es
   SET text = 'En esta empresa el director tiene la sartén por el mango. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — tener la sartén por el mango = de touwtjes in handen hebben.
• en esta tarjeta — hebben se conjuga heeft; tras in dit bedrijf, heeft de directeur.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: de touwtjes in handen hebben' AND word_type = 'PHRASE' AND text = 'tener la sartén por el mango'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'In dit bedrijf heeft de directeur de touwtjes in handen.', pronunciation = 'in dit bedreif heft de direktör de tauuties in handen', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de touwtjes in handen hebben' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'de touwtjes in handen hebben';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de touwtjes in handen hebben' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 053. no tener ni idea → No tengo ni idea de dónde he dejado las llaves.
UPDATE words_es
   SET text = 'No tengo ni idea de dónde he dejado las llaves.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no tener ni idea = geen flauw idee hebben.
• en esta tarjeta — detrás va una subordinada con waar y los verbos al final.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: geen flauw idee hebben' AND word_type = 'PHRASE' AND text = 'no tener ni idea'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Ik heb geen flauw idee waar ik mijn sleutels heb gelaten.', pronunciation = 'ik heb jen flauu ide vaar ik mein slötels heb jelaten', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: geen flauw idee hebben' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'geen flauw idee hebben';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: geen flauw idee hebben' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 054. estar de brazos cruzados → No podemos quedarnos de brazos cruzados.
UPDATE words_es
   SET text = 'No podemos quedarnos de brazos cruzados.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar de brazos cruzados = met de armen over elkaar zitten.
• en esta tarjeta — con kunnen y blijven, zitten va al final.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: met de armen over elkaar zitten' AND word_type = 'PHRASE' AND text = 'estar de brazos cruzados'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'We kunnen niet met de armen over elkaar blijven zitten.', pronunciation = 've künen nit met de armen ofer elkaar bleifen siten', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: met de armen over elkaar zitten' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'met de armen over elkaar zitten';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: met de armen over elkaar zitten' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 055. a la vuelta de la esquina → Hay una panadería a la vuelta de la esquina.
UPDATE words_es
   SET text = 'Hay una panadería a la vuelta de la esquina.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — a la vuelta de la esquina = om de hoek.
• en esta tarjeta — con er is, om de hoek va al final; de bakker es la panadería y el panadero.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: om de hoek' AND word_type = 'PHRASE' AND text = 'a la vuelta de la esquina'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Er is een bakker om de hoek.', pronunciation = 'er is en baker om de huk', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: om de hoek' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'om de hoek';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: om de hoek' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 056. de tal palo, tal astilla → Toca el piano como su madre, de tal palo, tal astilla. (ella)
UPDATE words_es
   SET text = 'Toca el piano como su madre, de tal palo, tal astilla. (ella)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — de tal palo, tal astilla = de appel valt niet ver van de boom.
• en esta tarjeta — el refrán no cambia.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: de appel valt niet ver van de boom' AND word_type = 'PHRASE' AND text = 'de tal palo, tal astilla'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Ze speelt piano net als haar moeder, de appel valt niet ver van de boom.', pronunciation = 'se spelt piano net als haar muder, de apel falt nit fer fan de bom', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de appel valt niet ver van de boom' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'de appel valt niet ver van de boom';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de appel valt niet ver van de boom' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 057. el que la sigue la consigue → Llamé diez veces y al final me atendieron, el que la sigue la consigue.
UPDATE words_es
   SET text = 'Llamé diez veces y al final me atendieron, el que la sigue la consigue.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — el que la sigue la consigue = de aanhouder wint.
• en esta tarjeta — el refrán no cambia.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: de aanhouder wint' AND word_type = 'PHRASE' AND text = 'el que la sigue la consigue'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Ik heb tien keer gebeld en uiteindelijk hielpen ze me, de aanhouder wint.', pronunciation = 'ik heb tin ker jebelt en öiteindeleik hilpen se me, de aanhauder vint', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de aanhouder wint' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'de aanhouder wint';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de aanhouder wint' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 058. no es oro todo lo que reluce → Las redes sociales parecen perfectas, pero no es oro todo lo que reluce.
UPDATE words_es
   SET text = 'Las redes sociales parecen perfectas, pero no es oro todo lo que reluce.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no es oro todo lo que reluce = het is niet alles goud wat er blinkt.
• en esta tarjeta — el refrán no cambia.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: het is niet alles goud wat er blinkt' AND word_type = 'PHRASE' AND text = 'no es oro todo lo que reluce'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Sociale media lijken perfect, maar het is niet alles goud wat er blinkt.', pronunciation = 'sosiale media leiken perfekt, maar het is nit ales jaut vat er blinkt', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: het is niet alles goud wat er blinkt' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'het is niet alles goud wat er blinkt';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: het is niet alles goud wat er blinkt' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 059. a quien madruga, Dios le ayuda → Venga, levántate, que a quien madruga, Dios le ayuda.
UPDATE words_es
   SET text = 'Venga, levántate, que a quien madruga, Dios le ayuda.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — a quien madruga, Dios le ayuda = de morgenstond heeft goud in de mond.
• en esta tarjeta — el refrán no cambia; opstaan es separable, sta op.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: de morgenstond heeft goud in de mond' AND word_type = 'PHRASE' AND text = 'a quien madruga, Dios le ayuda'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Kom op, sta op, de morgenstond heeft goud in de mond.', pronunciation = 'kom op, sta op, de morjenstont heft jaut in de mont', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de morgenstond heeft goud in de mond' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'de morgenstond heeft goud in de mond';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de morgenstond heeft goud in de mond' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 060. perro ladrador, poco mordedor → No te preocupes por sus amenazas, perro ladrador, poco mordedor.
UPDATE words_es
   SET text = 'No te preocupes por sus amenazas, perro ladrador, poco mordedor.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — perro ladrador, poco mordedor = blaffende honden bijten niet.
• en esta tarjeta — el refrán no cambia.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: blaffende honden bijten niet' AND word_type = 'PHRASE' AND text = 'perro ladrador, poco mordedor'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Maak je geen zorgen om zijn dreigementen, blaffende honden bijten niet.', pronunciation = 'maak ie jen sorjen om sein dreijementen, blafende honden beiten nit', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: blaffende honden bijten niet' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'blaffende honden bijten niet';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: blaffende honden bijten niet' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 061. poner el grito en el cielo → Cuando subieron los precios, todo el mundo puso el grito en el cielo. (inv)
UPDATE words_es
   SET text = 'Cuando subieron los precios, todo el mundo puso el grito en el cielo. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — poner el grito en el cielo = moord en brand schreeuwen.
• en esta tarjeta — imperfecto schreeuwde; tras la subordinada con toen, schreeuwde iedereen.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: moord en brand schreeuwen' AND word_type = 'PHRASE' AND text = 'poner el grito en el cielo'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Toen de prijzen stegen, schreeuwde iedereen moord en brand.', pronunciation = 'tun de preisen stejen, sjreöude ideren mort en brant', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: moord en brand schreeuwen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'moord en brand schreeuwen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: moord en brand schreeuwen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 062. hacerse el sueco → Le pido ayuda y se hace el sueco.
UPDATE words_es
   SET text = 'Le pido ayuda y se hace el sueco.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — hacerse el sueco = Oost-Indisch doof zijn.
• en esta tarjeta — zijn se conjuga is; Oost-Indisch doof no cambia.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: Oost-Indisch doof zijn' AND word_type = 'PHRASE' AND text = 'hacerse el sueco'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Ik vraag hem om hulp en hij is Oost-Indisch doof.', pronunciation = 'ik fraaj hem om hülp en hei is ost-indisj dof', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: Oost-Indisch doof zijn' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'Oost-Indisch doof zijn';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: Oost-Indisch doof zijn' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 063. hablando del rey de Roma → Hablando del rey de Roma, ahí viene Pedro.
UPDATE words_es
   SET text = 'Hablando del rey de Roma, ahí viene Pedro.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — hablando del rey de Roma = als je het over de duivel hebt.
• en esta tarjeta — solo la primera mitad; el je es genérico aunque no hables tú solo.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: als je het over de duivel hebt' AND word_type = 'PHRASE' AND text = 'hablando del rey de Roma'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Als je het over de duivel hebt, daar komt Peter.', pronunciation = 'als ie het ofer de döifel hebt, daar komt peter', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: als je het over de duivel hebt' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'als je het over de duivel hebt';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: als je het over de duivel hebt' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 064. aquí hay gato encerrado → Esa oferta es demasiado barata, aquí hay gato encerrado.
UPDATE words_es
   SET text = 'Esa oferta es demasiado barata, aquí hay gato encerrado.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — aquí hay gato encerrado = er zit een luchtje aan.
• en esta tarjeta — er … aan se queda entero.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: er zit een luchtje aan' AND word_type = 'PHRASE' AND text = 'aquí hay gato encerrado'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Die aanbieding is te goedkoop, er zit een luchtje aan.', pronunciation = 'di aanbiding is te judkop, er sit en lüjtie aan', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: er zit een luchtje aan' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'er zit een luchtje aan';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: er zit een luchtje aan' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 065. verlo todo de color de rosa → Desde que está enamorada, lo ve todo de color de rosa. (inv)
UPDATE words_es
   SET text = 'Desde que está enamorada, lo ve todo de color de rosa. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — verlo todo de color de rosa = door een roze bril kijken.
• en esta tarjeta — tras la subordinada con sinds, kijkt ze.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: door een roze bril kijken' AND word_type = 'PHRASE' AND text = 'verlo todo de color de rosa'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Sinds ze verliefd is, kijkt ze door een roze bril.', pronunciation = 'sinds se ferlift is, keikt se dor en rose bril', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: door een roze bril kijken' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'door een roze bril kijken';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: door een roze bril kijken' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 066. pagar el pato → Al final siempre paga el pato el más pequeño. (inv)
UPDATE words_es
   SET text = 'Al final siempre paga el pato el más pequeño. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — pagar el pato = de klos zijn.
• en esta tarjeta — zijn se conjuga is; de klos no cambia.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: de klos zijn' AND word_type = 'PHRASE' AND text = 'pagar el pato'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Uiteindelijk is de jongste altijd de klos.', pronunciation = 'öiteindeleik is de iongste alteit de klos', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de klos zijn' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'de klos zijn';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de klos zijn' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 067. jugarse el cuello → Nadie se jugó el cuello por él.
UPDATE words_es
   SET text = 'Nadie se jugó el cuello por él.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — jugarse el cuello = je nek uitsteken.
• en esta tarjeta — je pasa a zijn; uitsteken se separa en imperfecto, stak … uit.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: je nek uitsteken' AND word_type = 'PHRASE' AND text = 'jugarse el cuello'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Niemand stak zijn nek voor hem uit.', pronunciation = 'nimant stak sein nek for hem öit', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: je nek uitsteken' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'je nek uitsteken';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: je nek uitsteken' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 068. ir de punta en blanco → En la boda todos iban de punta en blanco. (inv)
UPDATE words_es
   SET text = 'En la boda todos iban de punta en blanco. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ir de punta en blanco = op je paasbest zijn.
• en esta tarjeta — je pasa a zijn porque iedereen es singular, igual que was.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: op je paasbest zijn' AND word_type = 'PHRASE' AND text = 'ir de punta en blanco'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Op de bruiloft was iedereen op zijn paasbest.', pronunciation = 'op de bröiloft vas ideren op sein paasbest', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: op je paasbest zijn' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'op je paasbest zijn';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: op je paasbest zijn' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 069. consultarlo con la almohada → Es una oferta interesante, déjame consultarlo con la almohada.
UPDATE words_es
   SET text = 'Es una oferta interesante, déjame consultarlo con la almohada.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — consultarlo con la almohada = er een nachtje over slapen.
• en esta tarjeta — con laten, slapen va al final en infinitivo.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: er een nachtje over slapen' AND word_type = 'PHRASE' AND text = 'consultarlo con la almohada'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Het is een interessant aanbod, laat me er een nachtje over slapen.', pronunciation = 'het is en interesant aanbot, laat me er en najtie ofer slapen', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: er een nachtje over slapen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'er een nachtje over slapen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: er een nachtje over slapen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 070. cortar por lo sano → El nuevo entrenador cortó por lo sano con la falta de disciplina.
UPDATE words_es
   SET text = 'El nuevo entrenador cortó por lo sano con la falta de disciplina.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — cortar por lo sano = korte metten maken met.
• en esta tarjeta — maken en imperfecto, maakte; met + lo que se elimina.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: korte metten maken met' AND word_type = 'PHRASE' AND text = 'cortar por lo sano'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'De nieuwe trainer maakte korte metten met het gebrek aan discipline.', pronunciation = 'de niöue trainer maakte korte meten met het jebrek aan disipline', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: korte metten maken met' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'korte metten maken met';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: korte metten maken met' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 071. vender la piel del oso antes de cazarlo → Todavía no hemos ganado, no vendas la piel del oso antes de cazarlo.
UPDATE words_es
   SET text = 'Todavía no hemos ganado, no vendas la piel del oso antes de cazarlo.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — vender la piel del oso antes de cazarlo = de huid niet verkopen voordat de beer geschoten is.
• en esta tarjeta — imperativo verkoop; niet va detrás de de huid.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: de huid niet verkopen voordat de beer geschoten is' AND word_type = 'PHRASE' AND text = 'vender la piel del oso antes de cazarlo'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'We hebben nog niet gewonnen, verkoop de huid niet voordat de beer geschoten is.', pronunciation = 've heben noj nit jeuonen, ferkop de höit nit fordat de ber jesjoten is', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de huid niet verkopen voordat de beer geschoten is' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'de huid niet verkopen voordat de beer geschoten is';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de huid niet verkopen voordat de beer geschoten is' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 072. estar con el agua al cuello → Con la hipoteca estamos con el agua al cuello. (inv)
UPDATE words_es
   SET text = 'Con la hipoteca estamos con el agua al cuello. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar con el agua al cuello = het water staat je tot aan de lippen.
• en esta tarjeta — la persona pasa a ons; tras door de hypotheek, staat het water.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: het water staat je tot aan de lippen' AND word_type = 'PHRASE' AND text = 'estar con el agua al cuello'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Door de hypotheek staat het water ons tot aan de lippen.', pronunciation = 'dor de hipothek staat het vater ons tot aan de lipen', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: het water staat je tot aan de lippen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'het water staat je tot aan de lippen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: het water staat je tot aan de lippen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 073. dar la lata → Mi hijo me da la lata para que le compre un móvil.
UPDATE words_es
   SET text = 'Mi hijo me da la lata para que le compre un móvil.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — dar la lata = aan iemands kop zeuren.
• en esta tarjeta — zeuren om + lo que se pide; aan mijn kop porque la cabeza es la mía.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: aan iemands kop zeuren' AND word_type = 'PHRASE' AND text = 'dar la lata'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Mijn zoon zeurt aan mijn kop om een mobiel.', pronunciation = 'mein son sört aan mein kop om en mobil', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: aan iemands kop zeuren' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'aan iemands kop zeuren';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: aan iemands kop zeuren' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 074. poner de los nervios a alguien → Me pone de los nervios que llegue siempre tarde. (él)
UPDATE words_es
   SET text = 'Me pone de los nervios que llegue siempre tarde. (él)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — poner de los nervios a alguien = iemand op de zenuwen werken.
• en esta tarjeta — het anticipa la subordinada con dat; iemand pasa a me.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: iemand op de zenuwen werken' AND word_type = 'PHRASE' AND text = 'poner de los nervios a alguien'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Het werkt me op de zenuwen dat hij altijd te laat komt.', pronunciation = 'het verkt me op de senüuen dat hei alteit te laat komt', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand op de zenuwen werken' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'iemand op de zenuwen werken';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand op de zenuwen werken' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 075. tener enchufe → Ha conseguido el puesto porque tiene enchufe. (él)
UPDATE words_es
   SET text = 'Ha conseguido el puesto porque tiene enchufe. (él)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — tener enchufe = een kruiwagen hebben.
• en esta tarjeta — en la subordinada con omdat, heeft va al final.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: een kruiwagen hebben' AND word_type = 'PHRASE' AND text = 'tener enchufe'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Hij heeft de baan gekregen omdat hij een kruiwagen heeft.', pronunciation = 'hei heft de baan jekrejen omdat hei en kröiuajen heft', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een kruiwagen hebben' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'een kruiwagen hebben';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een kruiwagen hebben' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 076. hacer su agosto → Con el calor, las heladerías hacen su agosto. (inv)
UPDATE words_es
   SET text = 'Con el calor, las heladerías hacen su agosto. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — hacer su agosto = je slag slaan.
• en esta tarjeta — je pasa a hun, en plural; tras met de hitte, slaan de ijssalons.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: je slag slaan' AND word_type = 'PHRASE' AND text = 'hacer su agosto'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Met de hitte slaan de ijssalons hun slag.', pronunciation = 'met de hite slaan de eisalons hün slaj', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: je slag slaan' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'je slag slaan';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: je slag slaan' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 077. venir como anillo al dedo → Tu llamada me viene como anillo al dedo.
UPDATE words_es
   SET text = 'Tu llamada me viene como anillo al dedo.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — venir como anillo al dedo = goed van pas komen.
• en esta tarjeta — el sujeto es lo que viene bien, jouw telefoontje; me es para quién.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: goed van pas komen' AND word_type = 'PHRASE' AND text = 'venir como anillo al dedo'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Jouw telefoontje komt me goed van pas.', pronunciation = 'iauu telefontie komt me jut fan pas', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: goed van pas komen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'goed van pas komen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: goed van pas komen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 078. ser harina de otro costal → Hablar holandés es fácil, pero entenderlo es harina de otro costal.
UPDATE words_es
   SET text = 'Hablar holandés es fácil, pero entenderlo es harina de otro costal.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ser harina de otro costal = dat is andere koek.
• en esta tarjeta — andere koek va sin artículo detrás de is.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: dat is andere koek' AND word_type = 'PHRASE' AND text = 'ser harina de otro costal'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Nederlands praten is makkelijk, maar het verstaan is andere koek.', pronunciation = 'nederlands praten is makeleik, maar het ferstaan is andere kuk', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: dat is andere koek' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'dat is andere koek';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: dat is andere koek' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 079. llevarse como el perro y el gato → Mis vecinos se llevan como el perro y el gato.
UPDATE words_es
   SET text = 'Mis vecinos se llevan como el perro y el gato.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — llevarse como el perro y el gato = als kat en hond leven.
• en esta tarjeta — leven en plural; el orden kat en hond no se invierte.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: als kat en hond leven' AND word_type = 'PHRASE' AND text = 'llevarse como el perro y el gato'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Mijn buren leven als kat en hond.', pronunciation = 'mein büren lefen als kat en hont', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: als kat en hond leven' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'als kat en hond leven';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: als kat en hond leven' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 080. quedarse de piedra → Cuando me lo contó, me quedé de piedra. (él, inv)
UPDATE words_es
   SET text = 'Cuando me lo contó, me quedé de piedra. (él, inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — quedarse de piedra = met stomheid geslagen zijn.
• en esta tarjeta — zijn en imperfecto, was ik, tras la subordinada con toen.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: met stomheid geslagen zijn' AND word_type = 'PHRASE' AND text = 'quedarse de piedra'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Toen hij het me vertelde, was ik met stomheid geslagen.', pronunciation = 'tun hei het me fertelde, vas ik met stomheit jeslajen', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: met stomheid geslagen zijn' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'met stomheid geslagen zijn';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: met stomheid geslagen zijn' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 081. por si las moscas → Llévate un abrigo, por si las moscas.
UPDATE words_es
   SET text = 'Llévate un abrigo, por si las moscas.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — por si las moscas = voor de zekerheid.
• en esta tarjeta — voor de zekerheid va al final, tras la coma.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: voor de zekerheid' AND word_type = 'PHRASE' AND text = 'por si las moscas'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Neem een jas mee, voor de zekerheid.', pronunciation = 'nem en ias me, for de sekerheit', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: voor de zekerheid' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'voor de zekerheid';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: voor de zekerheid' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 082. no tener ni pies ni cabeza → Lo que dice el político no tiene ni pies ni cabeza.
UPDATE words_es
   SET text = 'Lo que dice el político no tiene ni pies ni cabeza.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no tener ni pies ni cabeza = kant noch wal raken.
• en esta tarjeta — el sujeto es la subordinada con wat, y raakt va justo detrás.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: kant noch wal raken' AND word_type = 'PHRASE' AND text = 'no tener ni pies ni cabeza'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Wat de politicus zegt, raakt kant noch wal.', pronunciation = 'vat de politiküs sejt, raakt kant noj val', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: kant noch wal raken' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'kant noch wal raken';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: kant noch wal raken' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 083. de buenas a primeras → De buenas a primeras, dejó el trabajo. (él, inv)
UPDATE words_es
   SET text = 'De buenas a primeras, dejó el trabajo. (él, inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — de buenas a primeras = zomaar ineens.
• en esta tarjeta — zomaar ineens va delante y el verbo segundo, nam hij; ontslag nemen es dejar el trabajo.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: zomaar ineens' AND word_type = 'PHRASE' AND text = 'de buenas a primeras'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Zomaar ineens nam hij ontslag.', pronunciation = 'somaar inens nam hei ontslaj', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zomaar ineens' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'zomaar ineens';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zomaar ineens' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 084. tocar madera → El coche nunca me ha fallado, toco madera.
UPDATE words_es
   SET text = 'El coche nunca me ha fallado, toco madera.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — tocar madera = afkloppen.
• en esta tarjeta — afkloppen va solo al final, como fórmula; in de steek laten es otra frase hecha, dejar tirado.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: afkloppen' AND word_type = 'PHRASE' AND text = 'tocar madera'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Mijn auto heeft me nog nooit in de steek gelaten, even afkloppen.', pronunciation = 'mein auto heft me noj noit in de stek jelaten, efen afklopen', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: afkloppen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'afkloppen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: afkloppen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 085. echar leña al fuego → No eches más leña al fuego, por favor.
UPDATE words_es
   SET text = 'No eches más leña al fuego, por favor.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — echar leña al fuego = olie op het vuur gooien.
• en esta tarjeta — geen … meer es no más.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: olie op het vuur gooien' AND word_type = 'PHRASE' AND text = 'echar leña al fuego'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Gooi alsjeblieft geen olie meer op het vuur.', pronunciation = 'joi alsieblift jen oli mer op het für', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: olie op het vuur gooien' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'olie op het vuur gooien';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: olie op het vuur gooien' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 086. ponerse las botas → En la boda de mi prima nos pusimos las botas. (inv)
UPDATE words_es
   SET text = 'En la boda de mi prima nos pusimos las botas. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ponerse las botas = zich te goed doen aan.
• en esta tarjeta — zich pasa a ons; perfecto con hebben y gedaan; aan het eten marca de qué.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: zich te goed doen aan' AND word_type = 'PHRASE' AND text = 'ponerse las botas'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Op de bruiloft van mijn nicht hebben we ons te goed gedaan aan het eten.', pronunciation = 'op de bröiloft fan mein nijt heben ve ons te jut jedaan aan het eten', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zich te goed doen aan' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'zich te goed doen aan';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zich te goed doen aan' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 087. no tener dos dedos de frente → Ese chico es simpático, pero no tiene dos dedos de frente.
UPDATE words_es
   SET text = 'Ese chico es simpático, pero no tiene dos dedos de frente.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no tener dos dedos de frente = het buskruit niet uitgevonden hebben.
• en esta tarjeta — hebben se conjuga heeft y uitgevonden va al final.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: het buskruit niet uitgevonden hebben' AND word_type = 'PHRASE' AND text = 'no tener dos dedos de frente'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Die jongen is aardig, maar hij heeft het buskruit niet uitgevonden.', pronunciation = 'di iongen is aardij, maar hei heft het büskröit nit öitjefonden', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: het buskruit niet uitgevonden hebben' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'het buskruit niet uitgevonden hebben';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: het buskruit niet uitgevonden hebben' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 088. no nací ayer → No intentes engañarme, que no nací ayer.
UPDATE words_es
   SET text = 'No intentes engañarme, que no nací ayer.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no nací ayer = niet van gisteren zijn.
• en esta tarjeta — va en presente, ik ben, aunque el español diga nací.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: niet van gisteren zijn' AND word_type = 'PHRASE' AND text = 'no nací ayer'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Probeer me niet te bedriegen, ik ben niet van gisteren.', pronunciation = 'prober me nit te bedrijen, ik ben nit fan jisteren', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: niet van gisteren zijn' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'niet van gisteren zijn';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: niet van gisteren zijn' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 089. recibir calabazas → Le pidió salir y le dieron calabazas. (él)
UPDATE words_es
   SET text = 'Le pidió salir y le dieron calabazas. (él)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — recibir calabazas = een blauwtje lopen.
• en esta tarjeta — lopen en imperfecto, liep; el sujeto hij sirve para los dos verbos.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: een blauwtje lopen' AND word_type = 'PHRASE' AND text = 'recibir calabazas'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Hij vroeg haar mee uit en liep een blauwtje.', pronunciation = 'hei fruj haar me öit en lip en blauutie', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een blauwtje lopen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'een blauwtje lopen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: een blauwtje lopen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 090. ir sobre ruedas → De momento todo va sobre ruedas. (inv)
UPDATE words_es
   SET text = 'De momento todo va sobre ruedas. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ir sobre ruedas = op rolletjes lopen.
• en esta tarjeta — lopen con alles de sujeto; tras tot nu toe, loopt alles.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: op rolletjes lopen' AND word_type = 'PHRASE' AND text = 'ir sobre ruedas'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Tot nu toe loopt alles op rolletjes.', pronunciation = 'tot nü tu lopt ales op roleties', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: op rolletjes lopen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'op rolletjes lopen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: op rolletjes lopen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 091. caer en la cuenta → Tardé un rato en caer en la cuenta.
UPDATE words_es
   SET text = 'Tardé un rato en caer en la cuenta.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — caer en la cuenta = het kwartje valt.
• en esta tarjeta — het kwartje va en la subordinada con voordat y viel al final.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: het kwartje valt' AND word_type = 'PHRASE' AND text = 'caer en la cuenta'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Het duurde even voordat het kwartje viel.', pronunciation = 'het dürde efen fordat het kuartie fil', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: het kwartje valt' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'het kwartje valt';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: het kwartje valt' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 092. ¡ni hablar! → ¿Prestarle dinero otra vez? ¡Ni hablar!
UPDATE words_es
   SET text = '¿Prestarle dinero otra vez? ¡Ni hablar!', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ¡ni hablar! = geen sprake van.
• en esta tarjeta — fórmula fija que va sola, como respuesta.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: geen sprake van' AND word_type = 'PHRASE' AND text = '¡ni hablar!'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Hem weer geld lenen? Geen sprake van!', pronunciation = 'hem ver jelt lenen jen sprake fan', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: geen sprake van' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'geen sprake van';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: geen sprake van' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 093. ¡manos a la obra! → Ya lo tenemos todo, ¡manos a la obra!
UPDATE words_es
   SET text = 'Ya lo tenemos todo, ¡manos a la obra!', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ¡manos a la obra! = aan de slag.
• en esta tarjeta — fórmula sola, como grito para empezar.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: aan de slag' AND word_type = 'PHRASE' AND text = '¡manos a la obra!'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'We hebben alles, aan de slag!', pronunciation = 've heben ales, aan de slaj', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: aan de slag' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'aan de slag';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: aan de slag' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 094. poner toda la carne en el asador → Para este examen voy a poner toda la carne en el asador. (inv)
UPDATE words_es
   SET text = 'Para este examen voy a poner toda la carne en el asador. (inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — poner toda la carne en el asador = alles op alles zetten.
• en esta tarjeta — con gaan, zetten va al final; tras voor dit examen, ga ik.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: alles op alles zetten' AND word_type = 'PHRASE' AND text = 'poner toda la carne en el asador'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Voor dit examen ga ik alles op alles zetten.', pronunciation = 'for dit eksamen ja ik ales op ales seten', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: alles op alles zetten' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'alles op alles zetten';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: alles op alles zetten' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 095. pillar a alguien con las manos en la masa → La pillaron con las manos en la masa robando en una tienda.
UPDATE words_es
   SET text = 'La pillaron con las manos en la masa robando en una tienda.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — pillar a alguien con las manos en la masa = iemand op heterdaad betrappen.
• en esta tarjeta — pasiva con worden, werd betrapt; iemand desaparece porque pasa a ser el sujeto, ze.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: iemand op heterdaad betrappen' AND word_type = 'PHRASE' AND text = 'pillar a alguien con las manos en la masa'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Ze werd op heterdaad betrapt bij winkeldiefstal.', pronunciation = 'se vert op heterdaat betrapt bei vinkeldifstal', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand op heterdaad betrappen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'iemand op heterdaad betrappen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: iemand op heterdaad betrappen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 096. estar más claro que el agua → Que no quiere venir está más claro que el agua. (él, inv)
UPDATE words_es
   SET text = 'Que no quiere venir está más claro que el agua. (él, inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar más claro que el agua = zo klaar als een klontje zijn.
• en esta tarjeta — la subordinada con dat hace de sujeto y va delante; también vale Het is zo klaar als een klontje dat hij niet wil komen.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: zo klaar als een klontje zijn' AND word_type = 'PHRASE' AND text = 'estar más claro que el agua'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Dat hij niet wil komen, is zo klaar als een klontje.', pronunciation = 'dat hei nit vil komen, is so klaar als en klontie', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zo klaar als een klontje zijn' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'zo klaar als een klontje zijn';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zo klaar als een klontje zijn' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 097. ser más terco que una mula → Mi padre es más terco que una mula, nunca cambia de opinión.
UPDATE words_es
   SET text = 'Mi padre es más terco que una mula, nunca cambia de opinión.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ser más terco que una mula = zo koppig als een ezel zijn.
• en esta tarjeta — zijn se conjuga is; van mening veranderen es cambiar de opinión.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: zo koppig als een ezel zijn' AND word_type = 'PHRASE' AND text = 'ser más terco que una mula'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Mijn vader is zo koppig als een ezel, hij verandert nooit van mening.', pronunciation = 'mein fader is so kopij als en esel, hei ferandert noit fan mening', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zo koppig als een ezel zijn' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'zo koppig als een ezel zijn';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zo koppig als een ezel zijn' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 098. andarse con rodeos → Dime la verdad y no te andes con rodeos.
UPDATE words_es
   SET text = 'Dime la verdad y no te andes con rodeos.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — andarse con rodeos = om de hete brij heen draaien.
• en esta tarjeta — imperativo draai; niet delante de om y heen al final.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: om de hete brij heen draaien' AND word_type = 'PHRASE' AND text = 'andarse con rodeos'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Zeg me de waarheid en draai niet om de hete brij heen.', pronunciation = 'sej me de vaarheit en draai nit om de hete brei hen', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: om de hete brij heen draaien' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'om de hete brij heen draaien';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: om de hete brij heen draaien' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 099. irse por las ramas → Siempre que cuenta algo, se va por las ramas. (él, inv)
UPDATE words_es
   SET text = 'Siempre que cuenta algo, se va por las ramas. (él, inv)', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — irse por las ramas = van de hak op de tak springen.
• en esta tarjeta — tras la subordinada con als, springt hij; steeds es cada vez.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: van de hak op de tak springen' AND word_type = 'PHRASE' AND text = 'irse por las ramas'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Als hij iets vertelt, springt hij steeds van de hak op de tak.', pronunciation = 'als hei its fertelt, springt hei steds fan de hak op de tak', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: van de hak op de tak springen' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'van de hak op de tak springen';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: van de hak op de tak springen' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';

-- 100. el mundo es un pañuelo → ¡Qué casualidad verte aquí! El mundo es un pañuelo.
UPDATE words_es
   SET text = '¡Qué casualidad verte aquí! El mundo es un pañuelo.', rules_help = REPLACE(rules_help, '

🧩 Expresión fija — ', '

🔤 La construcción original y cómo entra en la frase:

• frase hecha — el mundo es un pañuelo = de wereld is klein.
• en esta tarjeta — el refrán no cambia.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE notes = 'frases hechas: de wereld is klein' AND word_type = 'PHRASE' AND text = 'el mundo es un pañuelo'
   AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🔤 La construcción original y cómo entra en la frase%';
UPDATE words_lang
   SET text = 'Wat toevallig dat ik je hier zie! De wereld is klein.', pronunciation = 'vat tufalij dat ik ie hir si de verelt is klein', audio_path = NULL, audio_url = NULL,
       audio_synced_md5 = NULL, updated_at = datetime('now')
 WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de wereld is klein' AND word_type = 'PHRASE' LIMIT 1) AND lang_code = 'nl_NL' AND text = 'de wereld is klein';
DELETE FROM word_es_media WHERE word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de wereld is klein' AND word_type = 'PHRASE' LIMIT 1) AND created_at < '2026-11-06';
