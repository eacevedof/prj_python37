-- Learn Languages App - Grupo "er" y todas sus variantes
-- Migration: 20260707000001-create-er-group.sql
-- Description: Crea el grupo "er" con 12 entradas que cubren las cuatro vidas
--   de er: existencial (er is/zijn = hay), locativo atono (= alli/aqui),
--   cantidad (ik heb er drie), preposicional (ervan/erin/eraan/ermee) y el
--   pasivo impersonal (er wordt...), mas expresiones cotidianas de altisima
--   frecuencia (wat is er, ik heb er zin in, ik kan er niets aan doen...).
--   Incluye rules_help por entrada. Idempotente. No toca ids existentes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'er',
    'Las cuatro vidas de er: existencial (er is/zijn = hay), locativo (alli atono), cantidad (ik heb er drie), preposicional (ervan/erin/eraan/ermee) y pasivo impersonal (er wordt...), con las expresiones diarias mas usadas',
    'migracion'
);

-- ==============================================================================
-- 2. PALABRAS EN ESPAÑOL (solo si no existen)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes)
SELECT 'hay', 'PHRASE', 'er existencial: er is / er zijn'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hay');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿qué pasa?', 'PHRASE', 'wat is er: existencial en pregunta'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿qué pasa?');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿qué está pasando?', 'PHRASE', 'wat is er aan de hand: frase hecha'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿qué está pasando?');

INSERT INTO words_es (text, word_type, notes)
SELECT 'ya estoy aquí', 'PHRASE', 'ik ben er: presencia/llegada'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ya estoy aquí');

INSERT INTO words_es (text, word_type, notes)
SELECT 'nunca he estado allí', 'PHRASE', 'er locativo atono'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'nunca he estado allí');

INSERT INTO words_es (text, word_type, notes)
SELECT 'tengo tres (de esos)', 'PHRASE', 'er de cantidad'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'tengo tres (de esos)');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿qué te parece?', 'PHRASE', 'wat vind je ervan: er+van'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿qué te parece?');

INSERT INTO words_es (text, word_type, notes)
SELECT '¡qué ganas!', 'PHRASE', 'ik heb er zin in: er+in'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡qué ganas!');

INSERT INTO words_es (text, word_type, notes)
SELECT 'no puedo hacer nada', 'PHRASE', 'ik kan er niets aan doen: er+aan'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no puedo hacer nada');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿cómo te va?', 'PHRASE', 'hoe gaat het ermee: er+mee'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿cómo te va?');

INSERT INTO words_es (text, word_type, notes)
SELECT 'llaman a la puerta', 'PHRASE', 'er wordt...: pasivo impersonal'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'llaman a la puerta');

INSERT INTO words_es (text, word_type, notes)
SELECT '¡a por ello!', 'PHRASE', 'we gaan ertegenaan: motivacional'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡a por ello!');
