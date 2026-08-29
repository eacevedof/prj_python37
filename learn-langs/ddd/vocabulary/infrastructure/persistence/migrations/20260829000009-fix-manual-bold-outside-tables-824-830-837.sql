-- Learn Languages App - Corrige negrita manual (**) fuera de tablas en 824, 830 y 837
-- Migration: 20260829000009-fix-manual-bold-outside-tables-824-830-837.sql
-- Description: RulesHelpMarkdownFormatter escapa TODO `*`/`_` fuera de las filas de tabla
--   (rules_help_markdown_formatter.py:_ESCAPE_PATTERN aplicado antes de procesar la linea),
--   asi que una negrita manual con ** en un item de lista o parrafo se ve como asteriscos
--   literales escapados en el modal — la norma documentada en learn-langs-code.md (2026-08-20)
--   es: dentro de "termino = definicion" el conversor ya pone negrita solo (con solo quitar
--   los **), y para enfatizar a mano se usa MAYUSCULAS, nunca **. Se corrigen las 3 tarjetas
--   de esta sesion que rompian la norma (824 zwaar/hard, 830 worden/zijn/toen/gisteren/vorige
--   week, 837 voor/voordat). Las tablas markdown (filas con "|") no se tocan: ahi ** es
--   correcto porque se copian literales sin escapar.
--   100% aditiva e idempotente: solo UPDATE con REPLACE, no-op si ya esta corregido.

UPDATE words_es
SET rules_help = REPLACE(REPLACE(rules_help, '**zwaar**', 'zwaar'), '**hard**', 'hard'),
    updated_at = datetime('now')
WHERE id = 824
  AND rules_help LIKE '%**zwaar**%';

UPDATE words_es
SET rules_help = REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(rules_help, '**worden**', 'worden'),
                    '**zijn**', 'zijn'
                ),
                '**toen**', 'TOEN'
            ),
            '**gisteren**', 'GISTEREN'
        ),
        '**vorige week**', 'VORIGE WEEK'
    ),
    updated_at = datetime('now')
WHERE id = 830
  AND rules_help LIKE '%**worden**%';

UPDATE words_es
SET rules_help = REPLACE(REPLACE(rules_help, '**voor**', 'voor'), '**voordat**', 'voordat'),
    updated_at = datetime('now')
WHERE id = 837
  AND rules_help LIKE '%**voor**%';
