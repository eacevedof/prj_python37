-- Learn Languages App - Ayuda: wakker liggen = expresion fija (tarjeta 628)
-- Migration: 20260811000003-help-wakker-liggen-fixed-expression-628.sql
-- Description: Eduardo (628 "Ik heb de hele nacht wakker gelegen") pregunta si "wakker
--   gelegen" es una expresion fija. Si: wakker liggen (van iets) = uitdrukking =
--   desvelarse / pasar la noche en vela por una preocupacion; NO es combinacion libre.
--   Bloque 🌙: la expresion base, la construccion causal con "van", el uso ironico en
--   negativo (Daar lig ik niet wakker van = eso no me quita el sueno) y el contraste con
--   wakker worden / wakker maken / wakker zijn. Card ya aplicada -> migracion nueva.
--   Keyeada por id, idempotente por 🌙, solo rules_help.

PRAGMA foreign_keys = ON;

-- 628 · wakker liggen = expresion fija (desvelarse)
UPDATE words_es SET rules_help = rules_help || '

🌙 ¿"wakker gelegen" es expresion fija? SI. wakker liggen es una uitdrukking (expresion hecha), no la suma literal de las palabras: significa estar despierto en la cama SIN poder dormir, normalmente por preocupacion = desvelarse / pasar la noche en vela. wakker (despierto) + liggen (estar tumbado) juntos = no dormir dandole vueltas a algo.

- Presente: Ik lig er wakker van. Perfecto: Ik heb er wakker van gelegen (participio gelegen, con HEBBEN por ser postura, ver arriba).
- La CAUSA (lo que te quita el sueno) va con van: ergens wakker van liggen / wakker liggen van iets. Ej.: Ik heb wakker gelegen van dat examen = me desvelo ese examen.
- Uso ironico muy comun en NEGATIVO para decir que algo NO te importa nada: Daar lig ik niet wakker van = eso no me quita el sueno / me trae sin cuidado. Perfecto: Daar heb ik niet wakker van gelegen.

⚠️ No confundir con la familia de "despertar(se)":
- wakker worden = despertarse (cambio de estado, dejar de dormir) -> con ZIJN: Ik ben om zes uur wakker geworden.
- wakker maken = despertar A alguien (transitivo) -> con HEBBEN: Het lawaai heeft me wakker gemaakt.
- wakker zijn = estar despierto (estado, ya sin dormir), sin el matiz de insomnio de wakker liggen.'
WHERE id = 628 AND COALESCE(rules_help,'') NOT LIKE '%🌙%';
