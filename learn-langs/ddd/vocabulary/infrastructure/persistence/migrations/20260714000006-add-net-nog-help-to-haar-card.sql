-- Learn Languages App - Ayuda net / net nog / nog en la tarjeta haar (id 637)
-- Migration: 20260714000006-add-net-nog-help-to-haar-card.sql
-- Description: Añade un bloque ⏳ al rules_help de la tarjeta "Ik heb haar net nog gesproken"
--   (grupo pronombres átono/tónico) resumiendo las partículas de tiempo: net = acabar de
--   (recencia neutra), net nog = acabar de + hace nada + contraste, nog (sin net) = todavía
--   / llegué a (antes de algo), con dos micro-escenas de la vida real.
--   Keyeada por notes (único), idempotente (guarda NOT LIKE '%⏳%'). Solo UPDATE de
--   words_es.rules_help; no toca words_lang/audio, imágenes ni notes.

PRAGMA foreign_keys = ON;

UPDATE words_es SET rules_help = rules_help || '

⏳ net / net nog / nog (partículas de tiempo):
• net + perfecto = ACABAR DE (recencia neutra): Ik heb haar net gesproken = acabo de hablar con ella. Sinónimos: zojuist, zonet, daarnet.
• net nog = acabar de + HACE NADA + contraste implícito (…y ahora): Ik heb haar net nog gesproken = justo he hablado con ella hace nada (…y mira ahora). No hay una sola palabra equivalente: net→justo, nog→el matiz de sorpresa/contraste; el español lo reparte (justo / hace nada / si… / y ahora).
• nog (sin net) = todavía / llegué a (una vez más, antes de algo): Ik heb haar nog gesproken voordat ze vertrok = todavía llegué a hablar con ella antes de que se fuera.

Ejemplos de la vida real:
• net (neutro) — Wil je koffie? → Nee, ik heb net koffie gehad (no, acabo de tomar café). Solo informas de algo reciente.
• net nog (contraste) — Anna is naar het ziekenhuis gebracht. → Wat?! Ik heb haar net nog gesproken! (¿¿qué?? ¡si acabo de hablar con ella hace nada!) …en toen was alles nog normaal.
Regla mental: si la frase pide un "…y ahora / en toen" detrás, usa net nog; si no, basta con net.'
WHERE notes = 'Átono/tónico: haar (zij ella)' AND rules_help NOT LIKE '%⏳%';
