-- Learn Languages App - Migration
-- Migration: 20260907000011-fix-ejemplos-bloque-zal-zou
-- Description: Eduardo, leyendo la ayuda de la 310: "Propuesta u ofrecimiento, en pregunta
--   — Zullen we…? Zal ik…? pon algun ejemplo, esto no lo veo".
--
--   Tiene razon y el fallo es mio: en el bloque "⚖️ zal o zou" de la migracion
--   20260907000006, esa viñeta daba solo los esqueletos (Zullen we…? Zal ik…?) sin frase
--   completa ni traduccion, mientras las de al lado si las traen. Revisando el bloque
--   entero aparecen otras dos con el mismo defecto: la de cortesia, que trae dos frases
--   pero ninguna traducida, y la de futuro formal, que trae la frase sin traducir. Se
--   arreglan las tres.
--
--   La 0006 YA ESTA APLICADA (el runner la registro al arrancar la app), asi que no se
--   puede corregir editandola: va esta migracion nueva con el patron REPLACE del texto
--   viejo exacto por el nuevo. Al aplicarse desaparece el texto viejo, de modo que la
--   segunda pasada no encuentra nada que sustituir y la migracion es idempotente sola.
--   Afecta a las 83 tarjetas que llevan el bloque.
--   No se toca ningun texto ni traduccion de tarjeta: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. La viñeta que señalo Eduardo: propuesta y ofrecimiento, ahora con ejemplos
-- =============================================================================
UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '• Propuesta u ofrecimiento, en pregunta — Zullen we…? Zal ik…?',
    '• Propuesta, con we — Zullen we koffie drinken? (¿tomamos un cafe?) Zullen we morgen afspreken? (¿quedamos mañana?)
• Ofrecimiento, con ik — Zal ik het raam opendoen? (¿abro la ventana?) Zal ik je helpen? (¿te ayudo?)'
)
WHERE rules_help LIKE '%• Propuesta u ofrecimiento, en pregunta — Zullen we…? Zal ik…?%';

-- =============================================================================
-- 2. La de cortesia, que traia las frases sin traducir
-- =============================================================================
UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '• Cortesia — Zou je me kunnen helpen? Ik zou graag een koffie willen.',
    '• Cortesia — Zou je me kunnen helpen? (¿podrias ayudarme?) Ik zou graag een koffie willen. (querria un cafe)'
)
WHERE rules_help LIKE '%• Cortesia — Zou je me kunnen helpen? Ik zou graag een koffie willen.%';

-- =============================================================================
-- 3. La de futuro formal, tambien sin traducir
-- =============================================================================
UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '• Futuro formal o enfatico — De vergadering zal om drie uur beginnen.',
    '• Futuro formal o enfatico — De vergadering zal om drie uur beginnen. (la reunion empezara a las tres)'
)
WHERE rules_help LIKE '%• Futuro formal o enfatico — De vergadering zal om drie uur beginnen.%'
  AND rules_help NOT LIKE '%(la reunion empezara a las tres)%';

-- =============================================================================
-- 4. El encabezado decia "cuatro usos" y al partir la viñeta ya son cinco
-- =============================================================================
UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '🎯 Los cuatro usos de ZAL, lo que se da por hecho:',
    '🎯 Los cinco usos de ZAL, lo que se da por hecho:'
)
WHERE rules_help LIKE '%🎯 Los cuatro usos de ZAL, lo que se da por hecho:%';
