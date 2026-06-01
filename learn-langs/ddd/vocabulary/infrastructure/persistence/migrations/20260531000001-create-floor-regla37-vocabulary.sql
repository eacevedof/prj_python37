-- Learn Languages App - Vocabulario de Floor - Regla 37
-- Migration: 20260531000001-create-floor-regla37-vocabulary.sql
-- Description: Crea grupo "floor-regla37" con vocabulario del diálogo "Iets weggeven is niet altijd een goed idee"
-- Source: https://www.youtube.com/watch?v=5GjEH-5TXtw

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. CREAR GRUPO: floor-regla37
-- ==============================================================================

INSERT INTO word_groups (title, description, source)
VALUES (
    'floor-regla37',
    'Vocabulario del diálogo "Iets weggeven is niet altijd een goed idee" - Regla 37 de Floor',
    'https://www.youtube.com/watch?v=5GjEH-5TXtw'
);

-- ==============================================================================
-- 2. INSERTAR PALABRAS NUEVAS EN ESPAÑOL
-- ==============================================================================

-- Regalar algo
INSERT INTO words_es (text, word_type, notes)
VALUES ('regalar algo', 'PHRASE', 'Floor - Regla 37');

-- No siempre
INSERT INTO words_es (text, word_type, notes)
VALUES ('no siempre', 'PHRASE', 'Floor - Regla 37');

-- Una buena idea
INSERT INTO words_es (text, word_type, notes)
VALUES ('una buena idea', 'PHRASE', 'Floor - Regla 37');

-- El refugiado / la refugiada
INSERT INTO words_es (text, word_type, notes)
VALUES ('el refugiado', 'WORD', 'Floor - Regla 37');

INSERT INTO words_es (text, word_type, notes)
VALUES ('la refugiada', 'WORD', 'Floor - Regla 37');

-- ¿De dónde?
INSERT INTO words_es (text, word_type, notes)
VALUES ('¿de dónde?', 'PHRASE', 'Floor - Regla 37');

-- No lo sé
INSERT INTO words_es (text, word_type, notes)
VALUES ('no lo sé', 'PHRASE', 'Floor - Regla 37');

-- En absoluto
INSERT INTO words_es (text, word_type, notes)
VALUES ('en absoluto', 'PHRASE', 'Floor - Regla 37');

-- Parecerse a
INSERT INTO words_es (text, word_type, notes)
VALUES ('parecerse a', 'PHRASE', 'Floor - Regla 37');

-- El jersey / el suéter
INSERT INTO words_es (text, word_type, notes)
VALUES ('el jersey', 'WORD', 'Floor - Regla 37');

-- El hoverboard
INSERT INTO words_es (text, word_type, notes)
VALUES ('el hoverboard', 'WORD', 'Floor - Regla 37');

-- Déjame en paz
INSERT INTO words_es (text, word_type, notes)
VALUES ('déjame en paz', 'PHRASE', 'Floor - Regla 37');

-- Han entrado a robar
INSERT INTO words_es (text, word_type, notes)
VALUES ('han entrado a robar', 'PHRASE', 'Floor - Regla 37');

-- Han robado
INSERT INTO words_es (text, word_type, notes)
VALUES ('han robado', 'PHRASE', 'Floor - Regla 37');

-- Lo regalé
INSERT INTO words_es (text, word_type, notes)
VALUES ('lo regalé', 'PHRASE', 'Floor - Regla 37');

-- Por caridad
INSERT INTO words_es (text, word_type, notes)
VALUES ('por caridad', 'PHRASE', 'Floor - Regla 37');

-- La caridad
INSERT INTO words_es (text, word_type, notes)
VALUES ('la caridad', 'WORD', 'Floor - Regla 37');

-- ¿No tienes hambre?
INSERT INTO words_es (text, word_type, notes)
VALUES ('¿no tienes hambre?', 'PHRASE', 'Floor - Regla 37');

-- Deberías comer algo
INSERT INTO words_es (text, word_type, notes)
VALUES ('deberías comer algo', 'PHRASE', 'Floor - Regla 37');

-- De vuelta
INSERT INTO words_es (text, word_type, notes)
VALUES ('de vuelta', 'PHRASE', 'Floor - Regla 37');

-- Supéralo
INSERT INTO words_es (text, word_type, notes)
VALUES ('supéralo', 'WORD', 'Floor - Regla 37');

-- Acaban de llegar
INSERT INTO words_es (text, word_type, notes)
VALUES ('acaban de llegar', 'PHRASE', 'Floor - Regla 37');

-- No tienen mucho
INSERT INTO words_es (text, word_type, notes)
VALUES ('no tienen mucho', 'PHRASE', 'Floor - Regla 37');

-- Prescindir de
INSERT INTO words_es (text, word_type, notes)
VALUES ('prescindir de', 'PHRASE', 'Floor - Regla 37');

-- Algunas cosas
INSERT INTO words_es (text, word_type, notes)
VALUES ('algunas cosas', 'PHRASE', 'Floor - Regla 37');

-- Consultar / hablar antes
INSERT INTO words_es (text, word_type, notes)
VALUES ('consultar', 'WORD', 'Floor - Regla 37');

-- Con buena intención
INSERT INTO words_es (text, word_type, notes)
VALUES ('con buena intención', 'PHRASE', 'Floor - Regla 37');

-- Ya nunca
INSERT INTO words_es (text, word_type, notes)
VALUES ('ya nunca', 'PHRASE', 'Floor - Regla 37');

-- Muchísimo
INSERT INTO words_es (text, word_type, notes)
VALUES ('muchísimo', 'WORD', 'Floor - Regla 37');

-- Echar de menos
INSERT INTO words_es (text, word_type, notes)
VALUES ('echar de menos', 'PHRASE', 'Floor - Regla 37');

-- El tobillo
INSERT INTO words_es (text, word_type, notes)
VALUES ('el tobillo', 'WORD', 'Floor - Regla 37');

-- Ridículo
INSERT INTO words_es (text, word_type, notes)
VALUES ('ridículo', 'WORD', 'Floor - Regla 37');

-- La consola de juegos
INSERT INTO words_es (text, word_type, notes)
VALUES ('la consola de juegos', 'WORD', 'Floor - Regla 37');

-- Basta
INSERT INTO words_es (text, word_type, notes)
VALUES ('basta', 'WORD', 'Floor - Regla 37');

-- Pensar en los demás
INSERT INTO words_es (text, word_type, notes)
VALUES ('pensar en los demás', 'PHRASE', 'Floor - Regla 37');

-- Quien hace el bien, recibe el bien
INSERT INTO words_es (text, word_type, notes)
VALUES ('quien hace el bien, recibe el bien', 'SENTENCE', 'Floor - Regla 37');

-- Patético
INSERT INTO words_es (text, word_type, notes)
VALUES ('patético', 'WORD', 'Floor - Regla 37');

-- El monopatín
INSERT INTO words_es (text, word_type, notes)
VALUES ('el monopatín', 'WORD', 'Floor - Regla 37');

-- El kickflip
INSERT INTO words_es (text, word_type, notes)
VALUES ('el kickflip', 'WORD', 'Floor - Regla 37');

-- La galletita
INSERT INTO words_es (text, word_type, notes)
VALUES ('la galletita', 'WORD', 'Floor - Regla 37');

-- La guerra
INSERT INTO words_es (text, word_type, notes)
VALUES ('la guerra', 'WORD', 'Floor - Regla 37');

-- Muchísimo peor
INSERT INTO words_es (text, word_type, notes)
VALUES ('muchísimo peor', 'PHRASE', 'Floor - Regla 37');

-- El mercado inmobiliario
INSERT INTO words_es (text, word_type, notes)
VALUES ('el mercado inmobiliario', 'WORD', 'Floor - Regla 37');

-- Completamente
INSERT INTO words_es (text, word_type, notes)
VALUES ('completamente', 'WORD', 'Floor - Regla 37');

-- Destrozado
INSERT INTO words_es (text, word_type, notes)
VALUES ('destrozado', 'WORD', 'Floor - Regla 37');

-- Los yuppies
INSERT INTO words_es (text, word_type, notes)
VALUES ('los yuppies', 'WORD', 'Floor - Regla 37');

-- Los expatriados
INSERT INTO words_es (text, word_type, notes)
VALUES ('los expatriados', 'WORD', 'Floor - Regla 37');

-- Los turistas
INSERT INTO words_es (text, word_type, notes)
VALUES ('los turistas', 'WORD', 'Floor - Regla 37');

-- Agradecido / agradecida
INSERT INTO words_es (text, word_type, notes)
VALUES ('agradecido', 'WORD', 'Floor - Regla 37');

INSERT INTO words_es (text, word_type, notes)
VALUES ('agradecida', 'WORD', 'Floor - Regla 37');

-- Robar / robado
INSERT INTO words_es (text, word_type, notes)
VALUES ('robado', 'WORD', 'Floor - Regla 37');

-- ¿Todavía sabes?
INSERT INTO words_es (text, word_type, notes)
VALUES ('¿todavía sabes?', 'PHRASE', 'Floor - Regla 37');

-- Cambiar / intercambiar
INSERT INTO words_es (text, word_type, notes)
VALUES ('cambiar', 'WORD', 'Floor - Regla 37');

INSERT INTO words_es (text, word_type, notes)
VALUES ('intercambiar', 'WORD', 'Floor - Regla 37');

-- El malentendido
INSERT INTO words_es (text, word_type, notes)
VALUES ('el malentendido', 'WORD', 'Floor - Regla 37');

-- Aparentemente
INSERT INTO words_es (text, word_type, notes)
VALUES ('aparentemente', 'WORD', 'Floor - Regla 37');

-- Privilegiado / privilegiada
INSERT INTO words_es (text, word_type, notes)
VALUES ('privilegiado', 'WORD', 'Floor - Regla 37');

INSERT INTO words_es (text, word_type, notes)
VALUES ('privilegiada', 'WORD', 'Floor - Regla 37');

-- Compartir
INSERT INTO words_es (text, word_type, notes)
VALUES ('compartir', 'WORD', 'Floor - Regla 37');

-- Me da pena
INSERT INTO words_es (text, word_type, notes)
VALUES ('me da pena', 'PHRASE', 'Floor - Regla 37');

-- Amable
INSERT INTO words_es (text, word_type, notes)
VALUES ('amable', 'WORD', 'Floor - Regla 37');

-- Enseñar
INSERT INTO words_es (text, word_type, notes)
VALUES ('enseñar', 'WORD', 'Floor - Regla 37');

-- Mantener el equilibrio
INSERT INTO words_es (text, word_type, notes)
VALUES ('mantener el equilibrio', 'PHRASE', 'Floor - Regla 37');

-- Inclinarse
INSERT INTO words_es (text, word_type, notes)
VALUES ('inclinarse', 'WORD', 'Floor - Regla 37');

-- Hacia adelante
INSERT INTO words_es (text, word_type, notes)
VALUES ('hacia adelante', 'PHRASE', 'Floor - Regla 37');

-- Girar
INSERT INTO words_es (text, word_type, notes)
VALUES ('girar', 'WORD', 'Floor - Regla 37');

-- El cuerpo
INSERT INTO words_es (text, word_type, notes)
VALUES ('el cuerpo', 'WORD', 'Floor - Regla 37');

-- Hacer feliz a alguien
INSERT INTO words_es (text, word_type, notes)
VALUES ('hacer feliz a alguien', 'PHRASE', 'Floor - Regla 37');

-- Recibir a cambio
INSERT INTO words_es (text, word_type, notes)
VALUES ('recibir a cambio', 'PHRASE', 'Floor - Regla 37');

-- Tienes razón
INSERT INTO words_es (text, word_type, notes)
VALUES ('tienes razón', 'PHRASE', 'Floor - Regla 37');

-- Me queda perfecto
INSERT INTO words_es (text, word_type, notes)
VALUES ('me queda perfecto', 'PHRASE', 'Floor - Regla 37');

-- Te queda muy bien
INSERT INTO words_es (text, word_type, notes)
VALUES ('te queda muy bien', 'PHRASE', 'Floor - Regla 37');

-- Excepto
INSERT INTO words_es (text, word_type, notes)
VALUES ('excepto', 'WORD', 'Floor - Regla 37');

-- Suscribirse
INSERT INTO words_es (text, word_type, notes)
VALUES ('suscribirse', 'WORD', 'Floor - Regla 37');

-- El canal
INSERT INTO words_es (text, word_type, notes)
VALUES ('el canal', 'WORD', 'Floor - Regla 37');

-- ==============================================================================
-- 3. INSERTAR TRADUCCIONES AL HOLANDÉS
-- ==============================================================================

-- Regalar algo -> iets weggeven
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'regalar algo'),
    'nl_NL',
    'iets weggeven',
    'iets wej-khee-ven'
);

-- No siempre -> niet altijd
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'no siempre'),
    'nl_NL',
    'niet altijd',
    'niet al-teit'
);

-- Una buena idea -> een goed idee
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'una buena idea'),
    'nl_NL',
    'een goed idee',
    'een khoot i-dee'
);

-- El refugiado -> de vluchteling
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el refugiado'),
    'nl_NL',
    'de vluchteling',
    'de flukh-te-ling'
);

-- La refugiada -> de vluchteling
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la refugiada'),
    'nl_NL',
    'de vluchteling',
    'de flukh-te-ling'
);

-- ¿De dónde? -> Waarvandaan?
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿de dónde?'),
    'nl_NL',
    'waarvandaan?',
    'waar-fan-daan'
);

-- No lo sé -> weet ik veel
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'no lo sé'),
    'nl_NL',
    'weet ik veel',
    'weet ik feel'
);

-- En absoluto -> helemaal niet
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'en absoluto'),
    'nl_NL',
    'helemaal niet',
    'hee-le-maal neet'
);

-- Parecerse a -> lijken op
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'parecerse a'),
    'nl_NL',
    'lijken op',
    'lei-ken op'
);

-- El jersey -> de trui
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el jersey'),
    'nl_NL',
    'de trui',
    'de trui'
);

-- El hoverboard -> het hoverboard
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el hoverboard'),
    'nl_NL',
    'het hoverboard',
    'het ho-ver-bort'
);

-- Déjame en paz -> rot op
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'déjame en paz'),
    'nl_NL',
    'rot op',
    'rot op'
);

-- Han entrado a robar -> er is ingebroken
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'han entrado a robar'),
    'nl_NL',
    'er is ingebroken',
    'er is in-khe-bro-ken'
);

-- Han robado -> ze hebben gejat
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'han robado'),
    'nl_NL',
    'ze hebben gejat',
    'ze heb-ben khe-yat'
);

-- Lo regalé -> heb ik weggegeven
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'lo regalé'),
    'nl_NL',
    'heb ik weggegeven',
    'hep ik wej-khe-khee-ven'
);

-- Por caridad -> uit liefdadigheid
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'por caridad'),
    'nl_NL',
    'uit liefdadigheid',
    'uit lief-daa-dikh-heit'
);

-- La caridad -> de liefdadigheid
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la caridad'),
    'nl_NL',
    'de liefdadigheid',
    'de lief-daa-dikh-heit'
);

-- ¿No tienes hambre? -> heb je geen honger?
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿no tienes hambre?'),
    'nl_NL',
    'heb je geen honger?',
    'hep ye kheen hon-kher'
);

-- Deberías comer algo -> je moet echt even wat eten
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'deberías comer algo'),
    'nl_NL',
    'je moet echt even wat eten',
    'ye moot ekht ee-ven wat ee-ten'
);

-- De vuelta -> terug
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'de vuelta'),
    'nl_NL',
    'terug',
    'te-rukh'
);

-- Supéralo -> zet je er overheen
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'supéralo'),
    'nl_NL',
    'zet je er overheen',
    'zet ye er o-ver-heen'
);

-- Acaban de llegar -> zijn hier pas nieuw
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'acaban de llegar'),
    'nl_NL',
    'zijn hier pas nieuw',
    'zein heer pas nieuw'
);

-- No tienen mucho -> hebben niet zoveel
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'no tienen mucho'),
    'nl_NL',
    'hebben niet zoveel',
    'heb-ben neet zo-feel'
);

-- Prescindir de -> kunnen missen
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'prescindir de'),
    'nl_NL',
    'kunnen missen',
    'kun-nen mis-sen'
);

-- Algunas cosas -> iets
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'algunas cosas'),
    'nl_NL',
    'iets',
    'iets'
);

-- Consultar -> overlegd
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'consultar'),
    'nl_NL',
    'overlegd',
    'o-ver-lekht'
);

-- Con buena intención -> bedoelt het goed
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'con buena intención'),
    'nl_NL',
    'bedoelt het goed',
    'be-doelt het khoot'
);

-- Ya nunca -> nooit meer
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'ya nunca'),
    'nl_NL',
    'nooit meer',
    'noit meer'
);

-- Muchísimo -> hartstikke vaak
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'muchísimo'),
    'nl_NL',
    'hartstikke vaak',
    'hart-sti-ke vaak'
);

-- Echar de menos -> missen
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'echar de menos'),
    'nl_NL',
    'missen',
    'mis-sen'
);

-- El tobillo -> de enkel
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el tobillo'),
    'nl_NL',
    'de enkel',
    'de en-kel'
);

-- Ridículo -> sneu
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'ridículo'),
    'nl_NL',
    'sneu',
    'sneu'
);

-- La consola de juegos -> het game station
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la consola de juegos'),
    'nl_NL',
    'het game station',
    'het kheem stee-shen'
);

-- Basta -> kappen nou
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'basta'),
    'nl_NL',
    'kappen nou',
    'ka-pen nau'
);

-- Pensar en los demás -> aan iemand anders denken
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'pensar en los demás'),
    'nl_NL',
    'aan iemand anders denken',
    'aan ee-mant an-ders den-ken'
);

-- Quien hace el bien, recibe el bien -> wie goed doet, goed ontmoet
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'quien hace el bien, recibe el bien'),
    'nl_NL',
    'wie goed doet, goed ontmoet',
    'wie khoot doet, khoot ont-moet'
);

-- Patético -> triest
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'patético'),
    'nl_NL',
    'triest',
    'treest'
);

-- El monopatín -> het skateboard
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el monopatín'),
    'nl_NL',
    'het skateboard',
    'het skeyt-bort'
);

-- El kickflip -> de kickflip
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el kickflip'),
    'nl_NL',
    'de kickflip',
    'de kik-flip'
);

-- La galletita -> het bokkenpootje
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la galletita'),
    'nl_NL',
    'het bokkenpootje',
    'het bo-ken-poot-ye'
);

-- La guerra -> de oorlog
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la guerra'),
    'nl_NL',
    'de oorlog',
    'de oor-lokh'
);

-- Muchísimo peor -> nog veel erger
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'muchísimo peor'),
    'nl_NL',
    'nog veel erger',
    'nokh feel er-kher'
);

-- El mercado inmobiliario -> de woningmarkt
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el mercado inmobiliario'),
    'nl_NL',
    'de woningmarkt',
    'de wo-ning-markt'
);

-- Completamente -> totaal
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'completamente'),
    'nl_NL',
    'totaal',
    'to-taal'
);

-- Destrozado -> verziekt
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'destrozado'),
    'nl_NL',
    'verziekt',
    'ver-zeekt'
);

-- Los yuppies -> de yuppen
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'los yuppies'),
    'nl_NL',
    'de yuppen',
    'de yu-pen'
);

-- Los expatriados -> de expats
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'los expatriados'),
    'nl_NL',
    'de expats',
    'de eks-pats'
);

-- Los turistas -> de toeristen
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'los turistas'),
    'nl_NL',
    'de toeristen',
    'de toe-ris-ten'
);

-- Agradecido -> dankbaar
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'agradecido'),
    'nl_NL',
    'dankbaar',
    'dank-baar'
);

-- Agradecida -> dankbaar
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'agradecida'),
    'nl_NL',
    'dankbaar',
    'dank-baar'
);

-- Robado -> gejat
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'robado'),
    'nl_NL',
    'gejat',
    'khe-yat'
);

-- ¿Todavía sabes? -> kan je het nog?
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿todavía sabes?'),
    'nl_NL',
    'kan je het nog?',
    'kan ye het nokh'
);

-- Cambiar -> ruilen
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'cambiar'),
    'nl_NL',
    'ruilen',
    'rui-len'
);

-- Intercambiar -> geruild
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'intercambiar'),
    'nl_NL',
    'geruild',
    'khe-ruilt'
);

-- El malentendido -> het misverstand
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el malentendido'),
    'nl_NL',
    'het misverstand',
    'het mis-ver-stant'
);

-- Aparentemente -> kennelijk
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'aparentemente'),
    'nl_NL',
    'kennelijk',
    'ke-ne-lek'
);

-- Privilegiado -> bevoorrecht
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'privilegiado'),
    'nl_NL',
    'bevoorrecht',
    'be-voor-rekht'
);

-- Privilegiada -> bevoorrecht
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'privilegiada'),
    'nl_NL',
    'bevoorrecht',
    'be-voor-rekht'
);

-- Compartir -> delen
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'compartir'),
    'nl_NL',
    'delen',
    'dee-len'
);

-- Me da pena -> ik vind het zielig
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'me da pena'),
    'nl_NL',
    'ik vind het zielig',
    'ik fint het zee-lekh'
);

-- Amable -> lief
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'amable'),
    'nl_NL',
    'lief',
    'leef'
);

-- Enseñar -> leren
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'enseñar'),
    'nl_NL',
    'leren',
    'lee-ren'
);

-- Mantener el equilibrio -> je evenwicht houden
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'mantener el equilibrio'),
    'nl_NL',
    'je evenwicht houden',
    'ye ee-ven-wikht hou-den'
);

-- Inclinarse -> leunen
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'inclinarse'),
    'nl_NL',
    'leunen',
    'leu-nen'
);

-- Hacia adelante -> naar voren
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'hacia adelante'),
    'nl_NL',
    'naar voren',
    'naar vo-ren'
);

-- Girar -> draaien
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'girar'),
    'nl_NL',
    'draaien',
    'draai-en'
);

-- El cuerpo -> het lichaam
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el cuerpo'),
    'nl_NL',
    'het lichaam',
    'het li-khaam'
);

-- Hacer feliz a alguien -> iemand blij maken
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'hacer feliz a alguien'),
    'nl_NL',
    'iemand blij maken',
    'ee-mant blei maa-ken'
);

-- Recibir a cambio -> krijgen voor terug
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'recibir a cambio'),
    'nl_NL',
    'krijgen voor terug',
    'krei-khen voor te-rukh'
);

-- Tienes razón -> je hebt gelijk
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'tienes razón'),
    'nl_NL',
    'je hebt gelijk',
    'ye hept khe-leik'
);

-- Me queda perfecto -> hij past precies
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'me queda perfecto'),
    'nl_NL',
    'hij past precies',
    'hei past pre-sees'
);

-- Te queda muy bien -> staat je erg goed
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'te queda muy bien'),
    'nl_NL',
    'staat je erg goed',
    'staat ye erkh khoot'
);

-- Excepto -> behalve
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'excepto'),
    'nl_NL',
    'behalve',
    'be-hal-ve'
);

-- Suscribirse -> abonneren
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'suscribirse'),
    'nl_NL',
    'abonneren',
    'a-bo-nee-ren'
);

-- El canal -> het kanaal
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el canal'),
    'nl_NL',
    'het kanaal',
    'het ka-naal'
);

-- ==============================================================================
-- 4. ASOCIAR PALABRAS CON GRUPO "floor-regla37"
-- ==============================================================================

INSERT INTO word_es_groups (word_es_id, group_id)
SELECT
    we.id,
    (SELECT id FROM word_groups WHERE title = 'floor-regla37')
FROM words_es we
WHERE we.notes = 'Floor - Regla 37';

-- ==============================================================================
-- RESUMEN
-- ==============================================================================
-- Grupo creado: floor-regla37
-- Source: https://www.youtube.com/watch?v=5GjEH-5TXtw
-- Tema: Diálogo "Iets weggeven is niet altijd een goed idee" - Regla 37
-- Palabras agregadas: 77
-- Frases: 48
-- Palabras simples: 28
-- Oraciones: 1
-- Traducciones al holandés: 77
--
-- Categorías incluidas:
-- - Expresiones de caridad y solidaridad (regalar, caridad, compartir)
-- - Refugiados y situaciones sociales (refugiado, mercado inmobiliario, expats)
-- - Objetos personales (hoverboard, skateboard, jersey, consola de juegos)
-- - Emociones y actitudes (agradecido, patético, amable, privilegiado)
-- - Acciones cotidianas (consultar, enseñar, girar, inclinarse)
-- - Expresiones idiomáticas (quien hace el bien recibe el bien, déjame en paz)
-- - Comunicación (basta, tienes razón, me da pena)
-- ==============================================================================
