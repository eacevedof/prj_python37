-- Learn Languages App - Vocabulario de habitación
-- Migration: 20260518000001-create-bedroom-vocabulary.sql
-- Description: Crea grupo "habitacion" con vocabulario de objetos del dormitorio

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. CREAR GRUPO: habitacion
-- ==============================================================================

INSERT INTO word_groups (title, description, source)
VALUES (
    'habitacion',
    'Vocabulario de objetos y elementos del dormitorio',
    'Migración inicial - objetos comunes de habitación'
);

-- ==============================================================================
-- 2. INSERTAR PALABRAS EN ESPAÑOL (con artículos)
-- ==============================================================================

-- La habitación (la palabra del grupo)
INSERT INTO words_es (text, word_type, notes)
VALUES ('la habitación', 'WORD', 'elementos de una habitación');

-- La cama
INSERT INTO words_es (text, word_type, notes)
VALUES ('la cama', 'WORD', 'elementos de una habitación');

-- La lámpara
INSERT INTO words_es (text, word_type, notes)
VALUES ('la lámpara', 'WORD', 'elementos de una habitación');

-- La mesa de noche
INSERT INTO words_es (text, word_type, notes)
VALUES ('la mesa de noche', 'WORD', 'elementos de una habitación');

-- El edredón
INSERT INTO words_es (text, word_type, notes)
VALUES ('el edredón', 'WORD', 'elementos de una habitación');

-- La sábana
INSERT INTO words_es (text, word_type, notes)
VALUES ('la sábana', 'WORD', 'elementos de una habitación');

-- La almohada
INSERT INTO words_es (text, word_type, notes)
VALUES ('la almohada', 'WORD', 'elementos de una habitación');

-- La frasada
INSERT INTO words_es (text, word_type, notes)
VALUES ('la frasada', 'WORD', 'elementos de una habitación');

-- La manta
INSERT INTO words_es (text, word_type, notes)
VALUES ('la manta', 'WORD', 'elementos de una habitación');

-- Las cortinas
INSERT INTO words_es (text, word_type, notes)
VALUES ('las cortinas', 'WORD', 'elementos de una habitación');

-- La persiana
INSERT INTO words_es (text, word_type, notes)
VALUES ('la persiana', 'WORD', 'elementos de una habitación');

-- El armario
INSERT INTO words_es (text, word_type, notes)
VALUES ('el armario', 'WORD', 'elementos de una habitación');

-- El colchón
INSERT INTO words_es (text, word_type, notes)
VALUES ('el colchón', 'WORD', 'elementos de una habitación');

-- La alfombra
INSERT INTO words_es (text, word_type, notes)
VALUES ('la alfombra', 'WORD', 'elementos de una habitación');

-- El despertador
INSERT INTO words_es (text, word_type, notes)
VALUES ('el despertador', 'WORD', 'elementos de una habitación');

-- La televisión
INSERT INTO words_es (text, word_type, notes)
VALUES ('la televisión', 'WORD', 'elementos de una habitación');

-- El cargador
INSERT INTO words_es (text, word_type, notes)
VALUES ('el cargador', 'WORD', 'elementos de una habitación');

-- Las chanclas
INSERT INTO words_es (text, word_type, notes)
VALUES ('las chanclas', 'WORD', 'elementos de una habitación');

-- El pijama
INSERT INTO words_es (text, word_type, notes)
VALUES ('el pijama', 'WORD', 'elementos de una habitación');

-- Los calcetines
INSERT INTO words_es (text, word_type, notes)
VALUES ('los calcetines', 'WORD', 'elementos de una habitación');

-- El cabecero de la cama
INSERT INTO words_es (text, word_type, notes)
VALUES ('el cabecero de la cama', 'WORD', 'elementos de una habitación');

-- El somier
INSERT INTO words_es (text, word_type, notes)
VALUES ('el somier', 'WORD', 'elementos de una habitación');

-- El cuadro
INSERT INTO words_es (text, word_type, notes)
VALUES ('el cuadro', 'WORD', 'elementos de una habitación');

-- El marco de una foto
INSERT INTO words_es (text, word_type, notes)
VALUES ('el marco de una foto', 'WORD', 'elementos de una habitación');

-- El foco
INSERT INTO words_es (text, word_type, notes)
VALUES ('el foco', 'WORD', 'elementos de una habitación');

-- La puerta
INSERT INTO words_es (text, word_type, notes)
VALUES ('la puerta', 'WORD', 'elementos de una habitación');

-- La cerradura
INSERT INTO words_es (text, word_type, notes)
VALUES ('la cerradura', 'WORD', 'elementos de una habitación');

-- El marco de la puerta
INSERT INTO words_es (text, word_type, notes)
VALUES ('el marco de la puerta', 'WORD', 'elementos de una habitación');

-- Las pantuflas
INSERT INTO words_es (text, word_type, notes)
VALUES ('las pantuflas', 'WORD', 'elementos de una habitación');

-- El borde de la cama
INSERT INTO words_es (text, word_type, notes)
VALUES ('el borde de la cama', 'WORD', 'elementos de una habitación');

-- El tomacorriente
INSERT INTO words_es (text, word_type, notes)
VALUES ('el tomacorriente', 'WORD', 'elementos de una habitación');

-- El enchufe
INSERT INTO words_es (text, word_type, notes)
VALUES ('el enchufe', 'WORD', 'elementos de una habitación');

-- El interruptor
INSERT INTO words_es (text, word_type, notes)
VALUES ('el interruptor', 'WORD', 'elementos de una habitación');

-- El reloj de pared
INSERT INTO words_es (text, word_type, notes)
VALUES ('el reloj de pared', 'WORD', 'elementos de una habitación');

-- El rodapié
INSERT INTO words_es (text, word_type, notes)
VALUES ('el rodapié', 'WORD', 'elementos de una habitación');

-- ==============================================================================
-- 3. INSERTAR TRADUCCIONES AL HOLANDÉS
-- ==============================================================================

-- La habitación -> de slaapkamer
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la habitación'),
    'nl_NL',
    'de slaapkamer',
    'de slaap-kaa-mer'
);

-- La cama -> het bed
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la cama'),
    'nl_NL',
    'het bed',
    'het bet'
);

-- La lámpara -> de lamp
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la lámpara'),
    'nl_NL',
    'de lamp',
    'de lamp'
);

-- La mesa de noche -> het nachtkastje
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la mesa de noche'),
    'nl_NL',
    'het nachtkastje',
    'het nacht-kas-tje'
);

-- El edredón -> het dekbed
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el edredón'),
    'nl_NL',
    'het dekbed',
    'het dek-bet'
);

-- La sábana -> het laken
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la sábana'),
    'nl_NL',
    'het laken',
    'het laa-ken'
);

-- La almohada -> het kussen
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la almohada'),
    'nl_NL',
    'het kussen',
    'het kus-sen'
);

-- La frasada -> de deken
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la frasada'),
    'nl_NL',
    'de deken',
    'de dee-ken'
);

-- La manta -> de deken
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la manta'),
    'nl_NL',
    'de deken',
    'de dee-ken'
);

-- Las cortinas -> de gordijnen
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'las cortinas'),
    'nl_NL',
    'de gordijnen',
    'de gor-dij-nen'
);

-- La persiana -> het rolgordijn
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la persiana'),
    'nl_NL',
    'het rolgordijn',
    'het rol-gor-dijn'
);

-- El armario -> de kast
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el armario'),
    'nl_NL',
    'de kast',
    'de kast'
);

-- El colchón -> de matras
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el colchón'),
    'nl_NL',
    'de matras',
    'de mat-ras'
);

-- La alfombra -> het tapijt
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la alfombra'),
    'nl_NL',
    'het tapijt',
    'het ta-pijt'
);

-- El despertador -> de wekker
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el despertador'),
    'nl_NL',
    'de wekker',
    'de wek-ker'
);

-- La televisión -> de televisie
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la televisión'),
    'nl_NL',
    'de televisie',
    'de te-le-vii-zie'
);

-- El cargador -> de oplader
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el cargador'),
    'nl_NL',
    'de oplader',
    'de op-laa-der'
);

-- Las chanclas -> de slippers
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'las chanclas'),
    'nl_NL',
    'de slippers',
    'de slip-pers'
);

-- El pijama -> de pyjama
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el pijama'),
    'nl_NL',
    'de pyjama',
    'de pij-aa-ma'
);

-- Los calcetines -> de sokken
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'los calcetines'),
    'nl_NL',
    'de sokken',
    'de sok-ken'
);

-- El cabecero de la cama -> het hoofdeinde
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el cabecero de la cama'),
    'nl_NL',
    'het hoofdeinde',
    'het hoofd-ein-de'
);

-- El somier -> de bedbodem
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el somier'),
    'nl_NL',
    'de bedbodem',
    'de bed-boo-dem'
);

-- El cuadro -> het schilderij
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el cuadro'),
    'nl_NL',
    'het schilderij',
    'het schil-de-rij'
);

-- El marco de una foto -> de fotolijst
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el marco de una foto'),
    'nl_NL',
    'de fotolijst',
    'de foo-to-lijst'
);

-- El foco -> de lamp / de gloeilamp
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el foco'),
    'nl_NL',
    'de gloeilamp',
    'de gloei-lamp'
);

-- La puerta -> de deur
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la puerta'),
    'nl_NL',
    'de deur',
    'de dur'
);

-- La cerradura -> het slot
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la cerradura'),
    'nl_NL',
    'het slot',
    'het slot'
);

-- El marco de la puerta -> de deurkozijn
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el marco de la puerta'),
    'nl_NL',
    'de deurkozijn',
    'de dur-ko-zein'
);

-- Las pantuflas -> de pantoffels
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'las pantuflas'),
    'nl_NL',
    'de pantoffels',
    'de pan-tof-fels'
);

-- El borde de la cama -> de bedrand
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el borde de la cama'),
    'nl_NL',
    'de bedrand',
    'de bed-rant'
);

-- El tomacorriente -> het stopcontact
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el tomacorriente'),
    'nl_NL',
    'het stopcontact',
    'het stop-con-tact'
);

-- El enchufe -> de stekker
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el enchufe'),
    'nl_NL',
    'de stekker',
    'de stek-ker'
);

-- El interruptor -> de schakelaar
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el interruptor'),
    'nl_NL',
    'de schakelaar',
    'de schaa-ke-laar'
);

-- El reloj de pared -> de wandklok
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el reloj de pared'),
    'nl_NL',
    'de wandklok',
    'de want-klok'
);

-- El rodapié -> de plint
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el rodapié'),
    'nl_NL',
    'de plint',
    'de plint'
);

-- ==============================================================================
-- 4. ASOCIAR PALABRAS CON GRUPO "habitacion"
-- ==============================================================================

INSERT INTO word_es_groups (word_es_id, group_id)
SELECT
    we.id,
    (SELECT id FROM word_groups WHERE title = 'habitacion')
FROM words_es we
WHERE we.text IN (
    'la habitación',
    'la cama',
    'la lámpara',
    'la mesa de noche',
    'el edredón',
    'la sábana',
    'la almohada',
    'la frasada',
    'la manta',
    'las cortinas',
    'la persiana',
    'el armario',
    'el colchón',
    'la alfombra',
    'el despertador',
    'la televisión',
    'el cargador',
    'las chanclas',
    'el pijama',
    'los calcetines',
    'el cabecero de la cama',
    'el somier',
    'el cuadro',
    'el marco de una foto',
    'el foco',
    'la puerta',
    'la cerradura',
    'el marco de la puerta',
    'las pantuflas',
    'el borde de la cama',
    'el tomacorriente',
    'el enchufe',
    'el interruptor',
    'el reloj de pared',
    'el rodapié'
);

-- ==============================================================================
-- RESUMEN
-- ==============================================================================
-- Grupo creado: habitacion
-- Palabras agregadas: 36
-- Traducciones al holandés: 36
-- Todas las palabras incluyen artículo (la/el/las/los)
-- Todas las notas: "elementos de una habitación"
--
-- Palabras incluidas:
-- - La habitación (palabra principal del grupo)
-- - Muebles principales (cama, armario, mesa de noche)
-- - Ropa de cama (sábana, edredón, almohada, manta, frasada)
-- - Iluminación (lámpara, foco, interruptor)
-- - Ventanas (cortinas, persiana)
-- - Decoración (cuadro, marco de foto, reloj de pared, alfombra)
-- - Ropa y calzado (pijama, calcetines, chanclas, pantuflas)
-- - Electrónica (televisión, cargador, despertador)
-- - Estructura (puerta, marco, cerradura, rodapié, cabecero, somier, borde)
-- - Eléctrico (tomacorriente, enchufe, interruptor)
-- ==============================================================================
