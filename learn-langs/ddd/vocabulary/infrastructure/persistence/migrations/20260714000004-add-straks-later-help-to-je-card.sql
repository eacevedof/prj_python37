-- Learn Languages App - Ayuda straks/zo/later en la tarjeta "Ik bel je straks" (id 633)
-- Migration: 20260714000004-add-straks-later-help-to-je-card.sql
-- Description: Añade un bloque 🕒 con la distinción temporal straks / zo / later (línea de
--   tiempo y despedidas) al rules_help de la tarjeta "te llamo luego" / "Ik bel je straks."
--   del grupo pronombres átono/tónico. 100% aditiva e IDEMPOTENTE: solo UPDATE de
--   words_es.rules_help (APPEND) con guarda NOT LIKE '%🕒%'. Keyeada por notes + text
--   (no por id, robusto ante reconstrucciones). No toca words_lang, imágenes ni notes.

PRAGMA foreign_keys = ON;

UPDATE words_es SET rules_help = rules_help || '

🕒 straks vs zo vs later: straks = luego, en un rato pero HOY (cercano y concreto). Más inmediato: zo / zo meteen = enseguida, ahora mismo. Más vago o lejano: later = más tarde, sin concretar (incluso otro día). Línea de tiempo: nu → zo/zo meteen → straks → later → morgen. Despedidas: Tot zo! (ahora te veo) · Tot straks! (hasta luego, hoy) · Tot later! (hasta luego, general). Ej.: Ik ben nu druk, ik bel je straks (hoy, en un rato) vs Ik bel je later wel (más tarde, sin concretar).'
WHERE notes = 'Átono/tónico: je (jij átono)' AND text = 'te llamo luego' AND rules_help NOT LIKE '%🕒%';
