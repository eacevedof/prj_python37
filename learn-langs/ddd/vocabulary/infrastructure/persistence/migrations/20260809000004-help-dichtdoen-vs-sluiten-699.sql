-- Learn Languages App - Ayuda: dichtdoen vs sluiten (tarjeta 699)
-- Migration: 20260809000004-help-dichtdoen-vs-sluiten-699.sql
-- Description: Un bloque a la 699 ("Doe de deur dicht, het wordt koud" = cierra la puerta, que
--   se esta enfriando): 🚪 "sluit de deur" TAMBIEN es correcto; dichtdoen (coloquial, separable
--   doe...dicht) vs sluiten (mas general/formal); pareja opendoen/openen; + recordatorio worden
--   (het wordt koud = se enfria, cambio de estado, no is koud).
--   Keyeada por texto nl_NL, idempotente por emoji-guarda. Solo UPDATE de rules_help.

PRAGMA foreign_keys = ON;

-- 699 · dichtdoen vs sluiten
UPDATE words_es SET rules_help = rules_help || '

🚪 "Doe de deur dicht" vs "Sluit de deur" (¿por que no sluit?)
Tu version SI vale: "Sluit de deur, het wordt koud" es correcta. No es error, es registro/naturalidad:
• de deur dichtdoen (doe ... dicht) = coloquial, hablado; para puertas/ventanas/cajones del dia a dia -> lo mas natural. Es verbo SEPARABLE: el prefijo dicht se va al final (Doe de deur dicht).
• de deur sluiten (sluit ...) = mas general/formal; tambien cerrar tiendas, ojos, un trato, algo definitivamente. Con puertas es correcto pero suena algo mas formal.
En el habla cotidiana: Doe de deur dicht. Pero Sluit de deur no es incorrecto.
Pareja para abrir: opendoen / openmaken (Doe het raam open) coloquial vs openen (formal, ~sluiten).
Recordatorio: het wordt koud = se esta enfriando (worden = cambio de estado), NO is koud (que seria "esta frio", estado ya alcanzado).'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Doe de deur dicht, het wordt koud.')
  AND COALESCE(rules_help,'') NOT LIKE '%🚪%';
