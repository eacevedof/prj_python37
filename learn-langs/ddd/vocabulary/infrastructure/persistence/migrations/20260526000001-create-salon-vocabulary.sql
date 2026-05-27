-- Learn Languages App - Vocabulario del salón
-- Migration: 20260526000001-create-salon-vocabulary.sql
-- Description: Crea grupo "salon" con vocabulario de objetos de la sala de estar

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. CREAR GRUPO: salon
-- ==============================================================================

INSERT INTO word_groups (title, description, source)
VALUES (
    'salon',
    'Vocabulario de objetos y elementos del salón / sala de estar',
    'Migración inicial - objetos comunes del salón'
);

-- ==============================================================================
-- 2. INSERTAR PALABRAS NUEVAS EN ESPAÑOL (con artículos)
-- ==============================================================================

-- El salón
INSERT INTO words_es (text, word_type, notes)
VALUES ('el salón', 'WORD', 'elementos del salón');

-- El sofá
INSERT INTO words_es (text, word_type, notes)
VALUES ('el sofá', 'WORD', 'elementos del salón');

-- El sillón
INSERT INTO words_es (text, word_type, notes)
VALUES ('el sillón', 'WORD', 'elementos del salón');

-- La mesa de centro
INSERT INTO words_es (text, word_type, notes)
VALUES ('la mesa de centro', 'WORD', 'elementos del salón');

-- La estantería
INSERT INTO words_es (text, word_type, notes)
VALUES ('la estantería', 'WORD', 'elementos del salón');

-- El aparador
INSERT INTO words_es (text, word_type, notes)
VALUES ('el aparador', 'WORD', 'elementos del salón');

-- El control remoto
INSERT INTO words_es (text, word_type, notes)
VALUES ('el control remoto', 'WORD', 'elementos del salón');

-- El equipo de música
INSERT INTO words_es (text, word_type, notes)
VALUES ('el equipo de música', 'WORD', 'elementos del salón');

-- Los altavoces
INSERT INTO words_es (text, word_type, notes)
VALUES ('los altavoces', 'WORD', 'elementos del salón');

-- El espejo
INSERT INTO words_es (text, word_type, notes)
VALUES ('el espejo', 'WORD', 'elementos del salón');

-- El florero
INSERT INTO words_es (text, word_type, notes)
VALUES ('el florero', 'WORD', 'elementos del salón');

-- Las velas
INSERT INTO words_es (text, word_type, notes)
VALUES ('las velas', 'WORD', 'elementos del salón');

-- El candelabro
INSERT INTO words_es (text, word_type, notes)
VALUES ('el candelabro', 'WORD', 'elementos del salón');

-- La planta
INSERT INTO words_es (text, word_type, notes)
VALUES ('la planta', 'WORD', 'elementos del salón');

-- La lámpara de pie
INSERT INTO words_es (text, word_type, notes)
VALUES ('la lámpara de pie', 'WORD', 'elementos del salón');

-- La lámpara de techo
INSERT INTO words_es (text, word_type, notes)
VALUES ('la lámpara de techo', 'WORD', 'elementos del salón');

-- El cojín
INSERT INTO words_es (text, word_type, notes)
VALUES ('el cojín', 'WORD', 'elementos del salón');

-- La ventana
INSERT INTO words_es (text, word_type, notes)
VALUES ('la ventana', 'WORD', 'elementos del salón');

-- El marco de la ventana
INSERT INTO words_es (text, word_type, notes)
VALUES ('el marco de la ventana', 'WORD', 'elementos del salón');

-- La repisa
INSERT INTO words_es (text, word_type, notes)
VALUES ('la repisa', 'WORD', 'elementos del salón');

-- La calefacción
INSERT INTO words_es (text, word_type, notes)
VALUES ('la calefacción', 'WORD', 'elementos del salón');

-- El radiador
INSERT INTO words_es (text, word_type, notes)
VALUES ('el radiador', 'WORD', 'elementos del salón');

-- El aire acondicionado
INSERT INTO words_es (text, word_type, notes)
VALUES ('el aire acondicionado', 'WORD', 'elementos del salón');

-- El ventilador
INSERT INTO words_es (text, word_type, notes)
VALUES ('el ventilador', 'WORD', 'elementos del salón');

-- Los libros
INSERT INTO words_es (text, word_type, notes)
VALUES ('los libros', 'WORD', 'elementos del salón');

-- La chimenea
INSERT INTO words_es (text, word_type, notes)
VALUES ('la chimenea', 'WORD', 'elementos del salón');

-- ==============================================================================
-- 3. INSERTAR TRADUCCIONES AL HOLANDÉS (SOLO PALABRAS NUEVAS)
-- ==============================================================================

-- El salón -> de woonkamer
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el salón'),
    'nl_NL',
    'de woonkamer',
    'de woon-kaa-mer'
);

-- El sofá -> de bank
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el sofá'),
    'nl_NL',
    'de bank',
    'de bank'
);

-- El sillón -> de fauteuil
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el sillón'),
    'nl_NL',
    'de fauteuil',
    'de fo-teuil'
);

-- La mesa de centro -> de salontafel
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la mesa de centro'),
    'nl_NL',
    'de salontafel',
    'de sa-lon-taa-fel'
);

-- La estantería -> de boekenkast
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la estantería'),
    'nl_NL',
    'de boekenkast',
    'de boe-ken-kast'
);

-- El aparador -> het dressoir
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el aparador'),
    'nl_NL',
    'het dressoir',
    'het dres-soar'
);

-- El control remoto -> de afstandsbediening
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el control remoto'),
    'nl_NL',
    'de afstandsbediening',
    'de af-stants-be-dee-ning'
);

-- El equipo de música -> de stereo-installatie
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el equipo de música'),
    'nl_NL',
    'de stereo-installatie',
    'de ste-ree-o in-sta-laa-tie'
);

-- Los altavoces -> de luidsprekers
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'los altavoces'),
    'nl_NL',
    'de luidsprekers',
    'de luit-spree-kers'
);

-- El espejo -> de spiegel
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el espejo'),
    'nl_NL',
    'de spiegel',
    'de spee-gel'
);

-- El florero -> de vaas
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el florero'),
    'nl_NL',
    'de vaas',
    'de vaas'
);

-- Las velas -> de kaarsen
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'las velas'),
    'nl_NL',
    'de kaarsen',
    'de kaar-sen'
);

-- El candelabro -> de kandelaar
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el candelabro'),
    'nl_NL',
    'de kandelaar',
    'de kan-de-laar'
);

-- La planta -> de plant
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la planta'),
    'nl_NL',
    'de plant',
    'de plant'
);

-- La lámpara de pie -> de staande lamp
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la lámpara de pie'),
    'nl_NL',
    'de staande lamp',
    'de staan-de lamp'
);

-- La lámpara de techo -> de plafondlamp
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la lámpara de techo'),
    'nl_NL',
    'de plafondlamp',
    'de pla-fon-lamp'
);

-- El cojín -> het kussen
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el cojín'),
    'nl_NL',
    'het kussen',
    'het kus-sen'
);

-- La ventana -> het raam
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la ventana'),
    'nl_NL',
    'het raam',
    'het raam'
);

-- El marco de la ventana -> het raamkozijn
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el marco de la ventana'),
    'nl_NL',
    'het raamkozijn',
    'het raam-ko-zein'
);

-- La repisa -> de plank
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la repisa'),
    'nl_NL',
    'de plank',
    'de plank'
);

-- La calefacción -> de verwarming
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la calefacción'),
    'nl_NL',
    'de verwarming',
    'de ver-war-ming'
);

-- El radiador -> de radiator
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el radiador'),
    'nl_NL',
    'de radiator',
    'de raa-di-aa-tor'
);

-- El aire acondicionado -> de airconditioning
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el aire acondicionado'),
    'nl_NL',
    'de airconditioning',
    'de air-con-di-shoo-ning'
);

-- El ventilador -> de ventilator
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el ventilador'),
    'nl_NL',
    'de ventilator',
    'de ven-ti-laa-tor'
);

-- Los libros -> de boeken
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'los libros'),
    'nl_NL',
    'de boeken',
    'de boe-ken'
);

-- La chimenea -> de open haard
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES (
    (SELECT id FROM words_es WHERE text = 'la chimenea'),
    'nl_NL',
    'de open haard',
    'de oo-pen haart'
);

-- ==============================================================================
-- 4. ASOCIAR PALABRAS CON GRUPO "salon"
-- ==============================================================================
-- Incluye NUEVAS palabras Y palabras EXISTENTES de otras migraciones

INSERT INTO word_es_groups (word_es_id, group_id)
SELECT
    we.id,
    (SELECT id FROM word_groups WHERE title = 'salon')
FROM words_es we
WHERE we.text IN (
    -- PALABRAS NUEVAS
    'el salón',
    'el sofá',
    'el sillón',
    'la mesa de centro',
    'la estantería',
    'el aparador',
    'el control remoto',
    'el equipo de música',
    'los altavoces',
    'el espejo',
    'el florero',
    'las velas',
    'el candelabro',
    'la planta',
    'la lámpara de pie',
    'la lámpara de techo',
    'el cojín',
    'la ventana',
    'el marco de la ventana',
    'la repisa',
    'la calefacción',
    'el radiador',
    'el aire acondicionado',
    'el ventilador',
    'los libros',
    'la chimenea',
    -- PALABRAS EXISTENTES (de migración habitacion)
    'la puerta',
    'la televisión',
    'el cuadro',
    'las cortinas',
    'la persiana',
    'la alfombra',
    'el reloj de pared',
    'el interruptor',
    'la manta'
);

-- ==============================================================================
-- RESUMEN
-- ==============================================================================
-- Grupo creado: salon
-- Palabras NUEVAS agregadas: 26
-- Palabras EXISTENTES reutilizadas: 9 (puerta, televisión, cuadro, cortinas,
--                                       persiana, alfombra, reloj de pared,
--                                       interruptor, manta)
-- Total palabras en grupo "salon": 35
-- Traducciones al holandés (solo nuevas): 26
-- Todas las palabras incluyen artículo (la/el/las/los)
-- Todas las notas: "elementos del salón"
--
-- Categorías incluidas:
-- - Muebles principales (sofá, sillón, mesa de centro, estantería, aparador)
-- - Entretenimiento (TV, control remoto, equipo de música, altavoces)
-- - Decoración (cuadro, espejo, florero, velas, candelabro, planta)
-- - Iluminación (lámpara de pie, lámpara de techo, interruptor)
-- - Textiles (alfombra, cortinas, cojín, manta)
-- - Ventanas (ventana, persiana, marco de ventana)
-- - Climatización (calefacción, radiador, aire acondicionado, ventilador)
-- - Otros (libros, chimenea, puerta, repisa, reloj de pared)
-- ==============================================================================
