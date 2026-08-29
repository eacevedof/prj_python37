-- Learn Languages App - Desambigua el posesivo "su" en frases sin sujeto explicito
-- Migration: 20260829000004-disambiguate-possessive-gender-816-820-825.sql
-- Description: En espanol "su" no marca genero (podria ser hij/haar/het en neerlandes), pero
--   la traduccion NL ya eligio uno concreto (haar/zijn). Se anade al texto ES, entre
--   parentesis y al final, una aclaracion de contexto (ella)/(el) para saber que posesivo
--   producir en neerlandes — NO se traduce, es solo la pista de a quien se refiere "su":
--   • 816 "Su padre fue un político destacado." → NL "Haar vader" → (ella)
--   • 820 "Estuvo al lado de su madre hasta el final." → NL "Ze stond haar moeder bij" → (ella)
--   • 825 "Esconde sus sentimientos ante todos." → NL "Hij verbergt zijn gevoelens" → (él)
--   100% aditiva e idempotente: solo UPDATE con guard (coincide el texto anterior exacto).

UPDATE words_es
SET text = 'Su padre fue un político destacado. (ella)',
    updated_at = datetime('now')
WHERE id = 816
  AND text = 'Su padre fue un político destacado.';

UPDATE words_es
SET text = 'Estuvo al lado de su madre hasta el final. (ella)',
    updated_at = datetime('now')
WHERE id = 820
  AND text = 'Estuvo al lado de su madre hasta el final.';

UPDATE words_es
SET text = 'Esconde sus sentimientos ante todos. (él)',
    updated_at = datetime('now')
WHERE id = 825
  AND text = 'Esconde sus sentimientos ante todos.';
