-- Learn Languages App - Regla hem = persona o cosa de-woord, en las tarjetas con hem
-- Migration: 20260721000003-add-hem-de-woord-disambiguation-to-pronoun-cards.sql
-- Description: Anade un bloque ⚠️ «hem = él (persona) o una cosa de-woord» al rules_help de
--   las tarjetas donde hem es el pronombre objeto, aclarando que hem no es solo «él»: tambien
--   es «lo/la» para cualquier COSA de-woord (de auto, de sleutel...), que het solo vale para
--   het-woorden, que por el pronombre NO se distingue persona de cosa (lo decide el antecedente/
--   contexto) y el truco de hablante (die para cosas de-woord, dat/dit para het-woord). Incluye
--   el matiz de que tras preposicion las cosas usan formas con er- (eraan, ermee), no «aan hem».
--   Nace de la duda en id 662 (Ik nam hem mee naar huis: ¿persona o cosa?).
--   Alcance (4 tarjetas): 553 (hem persona), 635 (hem tras preposicion), 636 (hem directo) y
--   662 (separable meenemen). Se EXCLUYE la 552, que ya es la tarjeta dedicada «hem cosa
--   de-woord» y ya explica la regla.
--   Idempotente (guarda NOT LIKE con la cabecera del bloque). Solo UPDATE de words_es.rules_help;
--   no toca words_lang/audio, imagenes ni notes.

PRAGMA foreign_keys = ON;

UPDATE words_es SET rules_help = rules_help || '

⚠️ hem = él (persona) o una cosa de-woord:
hem no significa solo «él»: también es «lo/la» para cualquier COSA de-woord (de auto, de sleutel, de hond → hem). Solo las cosas het-woord usan het (het boek → het). Por el pronombre NO distingues persona de cosa: los dos son hem; lo decide el antecedente y el contexto → Ik ken hem (a él) · De sleutel? Ik heb hem verloren (lo perdí).
• Truco de hablante: para una cosa de-woord se usa mucho die (Waar is de sleutel? — Die ligt op tafel) y para het-woord dat/dit; así se evita que hem/het suene a persona.
• Tras preposición, para cosas se usan las formas con er- (eraan, ermee, erop, ervan), no «aan hem»: «aan hem» queda para personas.'
WHERE id IN (553, 635, 636, 662)
  AND rules_help NOT LIKE '%hem = él (persona) o una cosa de-woord%';
