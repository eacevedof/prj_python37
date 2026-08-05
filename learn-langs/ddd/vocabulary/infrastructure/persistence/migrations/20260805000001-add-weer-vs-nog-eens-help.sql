-- Learn Languages App - Ayuda weer vs nog eens / nog een keer / opnieuw / alweer
-- Migration: 20260805000001-add-weer-vs-nog-eens-help.sql
-- Description: Anade un bloque 🔄 al rules_help de las 3 tarjetas cuyo neerlandes usa "weer"
--   (otra vez / de nuevo) explicando por que se usa weer y no otra forma de "otra vez"
--   (nog eens, nog een keer, opnieuw, alweer), y si es intercambiable en cada caso:
--     - id 302  Hij zal wel weer te laat zijn        (recurrencia habitual / resignacion)
--     - id 304  Het zal wel weer aan mij liggen       (recurrencia / ironia)
--     - id 682  Ik hoop je snel weer te zien          (weer = volver a, reencuentro)
--   Keyeada por el texto nl_NL (rebuild-robusto, notes no siempre unico), idempotente
--   (guarda NOT LIKE '%🔄%'). Solo UPDATE de words_es.rules_help; no toca words_lang/audio,
--   imagenes ni notes.

PRAGMA foreign_keys = ON;

-- 302 · Hij zal wel weer te laat zijn (Seguro que llega tarde otra vez)
UPDATE words_es SET rules_help = rules_help || '

🔄 weer vs nog eens / nog een keer / opnieuw / alweer:
Aqui weer = "otra vez" con sentido de RECURRENCIA habitual (vuelve a pasar lo de siempre), reforzado por el "zal wel" de resignacion.
• weer = de nuevo / otra vez → algo VUELVE a ocurrir (vuelta a un estado anterior). Es la forma natural para habitos y repeticiones molestas.
• alweer = weer + fastidio/sorpresa ("ya otra vez, tan pronto"): Hij is alweer te laat encaja perfecto y suena aun mas harto. INTERCAMBIABLE aqui, subiendo el tono de queja.
• nog eens / nog een keer = "una vez mas" (repeticion CONTADA o que se pide): Doe het nog eens = hazlo una vez mas. NO sirve aqui: no cuentas ni pides repeticiones, describes que el patron se repite. ✗ Hij zal wel nog een keer te laat zijn suena a "llegara tarde una vez mas" (contando), no a "otra vez, como siempre".
• opnieuw = de cero / desde el principio (rehacer algo entero). ✗ No aplica a "llegar tarde".
Regla: recurrencia / vuelta a lo de siempre → weer (o alweer si te quejas); "una vez mas" contada o pedida → nog eens / nog een keer; "desde cero" → opnieuw.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Hij zal wel weer te laat zijn.')
  AND COALESCE(rules_help,'') NOT LIKE '%🔄%';

-- 304 · Het zal wel weer aan mij liggen (Seguro que otra vez es culpa mia, ironico)
UPDATE words_es SET rules_help = rules_help || '

🔄 por que weer (y no nog eens / opnieuw):
weer = "otra vez" marcando la RECURRENCIA ("como siempre me toca a mi") — encaja con la ironia de "zal wel".
• weer → vuelve a repetirse el patron. Correcto y natural.
• alweer → sube la queja ("ya otra vez culpa mia"). INTERCAMBIABLE, mas enfatico.
• nog eens / nog een keer = "una vez mas" (repeticion contada/pedida) → ✗ no describe un patron que se repite, sino un conteo.
• opnieuw = desde cero → ✗ no encaja con "ser culpa mia".
Regla: recurrencia habitual → weer / alweer; "una vez mas" contada → nog eens; "de cero" → opnieuw.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Het zal wel weer aan mij liggen.')
  AND COALESCE(rules_help,'') NOT LIKE '%🔄%';

-- 682 · Ik hoop je snel weer te zien (espero volver a verte pronto)
UPDATE words_es SET rules_help = rules_help || '

🔄 weer vs opnieuw / nog eens / nog een keer:
Aqui weer = "volver a" (weer zien = volver a verse, reencontrarse). Es la forma natural de una despedida afectuosa.
• weer + zien = volver a ver(se), reunirse otra vez. Con ese matiz de reencuentro existen tambien elkaar terugzien y het weerzien (el reencuentro).
• opnieuw = de nuevo desde cero, como si nunca os hubierais visto → ✗ opnieuw zien no significa "reencontrarse", suena erroneo aqui.
• nog eens / nog een keer zien = "verte una vez mas" (contando una repeticion). Gramaticalmente posible, pero enfria el tono: parece que cuentas los encuentros en vez del calido "volver a verte". Para la despedida, weer.
Regla: "volver a (reunirse/repetir)" → weer; "una vez mas" contada → nog eens / nog een keer; "desde cero" → opnieuw.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Ik hoop je snel weer te zien.')
  AND COALESCE(rules_help,'') NOT LIKE '%🔄%';
