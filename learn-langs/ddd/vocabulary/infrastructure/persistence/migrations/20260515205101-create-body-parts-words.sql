-- Learn Languages App - Body Parts Vocabulary
-- Migration: 003_body_parts_vocabulary.sql
-- Description: 57 palabras de partes del cuerpo con traducciones al neerlandes

PRAGMA foreign_keys = ON;

-- Tags especificos para partes del cuerpo
INSERT OR IGNORE INTO tags (name, color) VALUES
    ('cuerpo', '#FF6B6B'),
    ('anatomia', '#4ECDC4');

-- ==============================================================================
-- CUERPO GENERAL (20 palabras)
-- ==============================================================================

-- 1. la cabeza
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la cabeza', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'het hoofd', 'het hoft', datetime('now'), datetime('now'));

-- 2. el cuello
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el cuello', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de nek', 'de nek', datetime('now'), datetime('now'));

-- 3. el hombro
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el hombro', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de schouder', 'de sxauder', datetime('now'), datetime('now'));

-- 4. el pecho
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el pecho', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de borst', 'de borst', datetime('now'), datetime('now'));

-- 5. la espalda
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la espalda', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de rug', 'de ryx', datetime('now'), datetime('now'));

-- 6. la zona lumbar
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la zona lumbar', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de lendenen', 'de lendenen', datetime('now'), datetime('now'));

-- 7. el brazo
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el brazo', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de arm', 'de arm', datetime('now'), datetime('now'));

-- 8. el antebrazo
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el antebrazo', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de onderarm', 'de onderarm', datetime('now'), datetime('now'));

-- 9. el codo
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el codo', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de elleboog', 'de eleboxh', datetime('now'), datetime('now'));

-- 10. la muneca
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la muneca', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de pols', 'de pols', datetime('now'), datetime('now'));

-- 11. la mano
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la mano', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de hand', 'de hant', datetime('now'), datetime('now'));

-- 12. el dedo
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el dedo', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de vinger', 'de vinger', datetime('now'), datetime('now'));

-- 13. la pierna
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la pierna', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'het been', 'het ben', datetime('now'), datetime('now'));

-- 14. el muslo
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el muslo', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de dij', 'de dei', datetime('now'), datetime('now'));

-- 15. la rodilla
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la rodilla', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de knie', 'de kni', datetime('now'), datetime('now'));

-- 16. la pantorrilla
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la pantorrilla', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de kuit', 'de kœyt', datetime('now'), datetime('now'));

-- 17. el tobillo
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el tobillo', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de enkel', 'de enkel', datetime('now'), datetime('now'));

-- 18. el empeine
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el empeine', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de wreef', 'de wreyf', datetime('now'), datetime('now'));

-- 19. el pie
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el pie', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de voet', 'de vut', datetime('now'), datetime('now'));

-- 20. el dedo del pie
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el dedo del pie', 'WORD', 'partes del cuerpo, cuerpo general', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de teen', 'de teyn', datetime('now'), datetime('now'));

-- ==============================================================================
-- DEDOS DE LA MANO (5 palabras)
-- ==============================================================================

-- 21. el pulgar
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el pulgar', 'WORD', 'partes del cuerpo, dedos de la mano', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de duim', 'de dœym', datetime('now'), datetime('now'));

-- 22. el indice
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el indice', 'WORD', 'partes del cuerpo, dedos de la mano', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de wijsvinger', 'de weysvinger', datetime('now'), datetime('now'));

-- 23. el dedo medio
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el dedo medio', 'WORD', 'partes del cuerpo, dedos de la mano', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de middelvinger', 'de midelvinger', datetime('now'), datetime('now'));

-- 24. el anular
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el anular', 'WORD', 'partes del cuerpo, dedos de la mano', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de ringvinger', 'de ringvinger', datetime('now'), datetime('now'));

-- 25. el menique
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el menique', 'WORD', 'partes del cuerpo, dedos de la mano', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de pink', 'de pink', datetime('now'), datetime('now'));

-- ==============================================================================
-- DEDOS DEL PIE (5 palabras)
-- ==============================================================================

-- 26. el dedo gordo del pie
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el dedo gordo del pie', 'WORD', 'partes del cuerpo, dedos del pie', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de grote teen', 'de xrote teyn', datetime('now'), datetime('now'));

-- 27. el segundo dedo del pie
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el segundo dedo del pie', 'WORD', 'partes del cuerpo, dedos del pie', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de tweede teen', 'de tweyde teyn', datetime('now'), datetime('now'));

-- 28. el tercer dedo del pie
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el tercer dedo del pie', 'WORD', 'partes del cuerpo, dedos del pie', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de derde teen', 'de derde teyn', datetime('now'), datetime('now'));

-- 29. el cuarto dedo del pie
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el cuarto dedo del pie', 'WORD', 'partes del cuerpo, dedos del pie', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de vierde teen', 'de virde teyn', datetime('now'), datetime('now'));

-- 30. el dedo pequeno del pie
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el dedo pequeno del pie', 'WORD', 'partes del cuerpo, dedos del pie', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de kleine teen', 'de kleyne teyn', datetime('now'), datetime('now'));

-- ==============================================================================
-- CABEZA Y CARA (18 palabras)
-- ==============================================================================

-- 31. el cabello
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el cabello', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'het haar', 'het har', datetime('now'), datetime('now'));

-- 32. la frente
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la frente', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'het voorhoofd', 'het vorhofd', datetime('now'), datetime('now'));

-- 33. la ceja
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la ceja', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de wenkbrauw', 'de wenkbrau', datetime('now'), datetime('now'));

-- 34. el parpado
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el parpado', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'het ooglid', 'het oxlit', datetime('now'), datetime('now'));

-- 35. la pestana
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la pestana', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de wimper', 'de wimper', datetime('now'), datetime('now'));

-- 36. el ojo
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el ojo', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'het oog', 'het oxh', datetime('now'), datetime('now'));

-- 37. la nariz
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la nariz', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de neus', 'de noys', datetime('now'), datetime('now'));

-- 38. la oreja
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la oreja', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'het oor', 'het or', datetime('now'), datetime('now'));

-- 39. la mejilla
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la mejilla', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de wang', 'de wang', datetime('now'), datetime('now'));

-- 40. la boca
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la boca', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de mond', 'de mont', datetime('now'), datetime('now'));

-- 41. el labio
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el labio', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de lip', 'de lip', datetime('now'), datetime('now'));

-- 42. el diente
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el diente', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de tand', 'de tant', datetime('now'), datetime('now'));

-- 43. la encia
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la encia', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'het tandvlees', 'het tantvleys', datetime('now'), datetime('now'));

-- 44. el paladar
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el paladar', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'het gehemelte', 'het xehemelte', datetime('now'), datetime('now'));

-- 45. la lengua
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la lengua', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de tong', 'de tong', datetime('now'), datetime('now'));

-- 46. la barbilla
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la barbilla', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de kin', 'de kin', datetime('now'), datetime('now'));

-- 47. la barba
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la barba', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de baard', 'de bart', datetime('now'), datetime('now'));

-- 48. el bigote
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el bigote', 'WORD', 'partes del cuerpo, cabeza y cara', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de snor', 'de snor', datetime('now'), datetime('now'));

-- ==============================================================================
-- MUSCULOS (4 palabras)
-- ==============================================================================

-- 49. el biceps
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el biceps', 'WORD', 'partes del cuerpo, musculos', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de biceps', 'de bayseps', datetime('now'), datetime('now'));

-- 50. el triceps
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el triceps', 'WORD', 'partes del cuerpo, musculos', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de triceps', 'de trayseps', datetime('now'), datetime('now'));

-- 51. los gluteos
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('los gluteos', 'WORD', 'partes del cuerpo, musculos', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de billen', 'de bilen', datetime('now'), datetime('now'));

-- 52. el culo
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el culo', 'WORD', 'partes del cuerpo, musculos', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de kont', 'de kont', datetime('now'), datetime('now'));

-- ==============================================================================
-- OTROS (5 palabras)
-- ==============================================================================

-- 53. la una
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la una', 'WORD', 'partes del cuerpo, otros', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de nagel', 'de naxel', datetime('now'), datetime('now'));

-- 54. la piel
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('la piel', 'WORD', 'partes del cuerpo, otros', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de huid', 'de hœyt', datetime('now'), datetime('now'));

-- 55. el hueso
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el hueso', 'WORD', 'partes del cuerpo, otros', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'het bot', 'het bot', datetime('now'), datetime('now'));

-- 56. el musculo
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('el musculo', 'WORD', 'partes del cuerpo, otros', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de spier', 'de spir', datetime('now'), datetime('now'));

-- 57. los genitales
INSERT INTO words_es (text, word_type, notes, created_at, updated_at)
VALUES ('los genitales', 'WORD', 'partes del cuerpo, otros', datetime('now'), datetime('now'));
INSERT INTO words_lang (word_es_id, lang_code, text, pronunciation, created_at, updated_at)
VALUES (last_insert_rowid(), 'nl_NL', 'de geslachtsdelen', 'de xeslaxtsdeyle', datetime('now'), datetime('now'));

-- ==============================================================================
-- ASOCIAR TAGS A TODAS LAS PALABRAS
-- ==============================================================================

INSERT INTO word_es_tags (word_es_id, tag_id)
SELECT we.id, t.id
FROM words_es we
CROSS JOIN tags t
WHERE we.notes LIKE 'partes del cuerpo%'
  AND t.name IN ('cuerpo', 'anatomia', 'sustantivos');
