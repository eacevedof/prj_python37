-- Learn Languages App - Contexto de uso en frases hechas ambiguas (werkwoord-varianten)
-- Migration: 20260713000001-add-context-to-ambiguous-verb-phrases.sql
-- Description: Añade un bloque "🧭 Cuándo usarlo" al rules_help de las frases hechas
--   AMBIGUAS del grupo werkwoord-varianten (Pas op! / Kijk uit!, Ik hou het niet meer uit,
--   Even kijken, Dat bestaat niet!, Hou op!, Afgesproken!, Geef niet op!): cuándo se usan,
--   sinónimos/matices y con qué NO confundirlas.
--   100% aditiva e IDEMPOTENTE: solo UPDATE de words_es.rules_help (APPEND) con guarda
--   NOT LIKE '%🧭%'. NO toca words_lang (audio_path), imágenes, notes, text ni ninguna otra
--   columna -> respeta imágenes/audios ya adjuntos a estas palabras.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- Pas op! (oppassen) — vs Kijk uit!
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: aviso de peligro inmediato y general (¡ojo!, ¡ten cuidado!). Ante un peligro real (un coche, algo que se cae) Pas op! y Kijk uit! valen igual. Matiz: Pas op = ten cuidado / ándate con ojo (precaución general; también cuídate: Pas goed op jezelf); Kijk uit = fíjate, mira por dónde vas (atención visual). Consejo más suave: Wees voorzichtig. Con objeto: Pas op je spullen = vigila tus cosas.'
WHERE notes = 'Variante de passen: oppassen'
  AND rules_help NOT LIKE '%🧭%';

-- ==============================================================================
-- Kijk uit! (uitkijken) — vs Pas op! y otros sentidos de uitkijken
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: casi idéntico a Pas op! ante un peligro inmediato; como literalmente es "mira afuera", insiste en fijarte / mirar por dónde vas. Regla práctica: Pas op = precaución general, Kijk uit = atención visual. NO lo confundas con uitkijken naar (esperar algo con ganas) ni uitkijken op (dar a / tener vistas a).'
WHERE notes = 'Variante de kijken: uitkijken'
  AND rules_help NOT LIKE '%🧭%';

-- ==============================================================================
-- Ik hou het niet meer uit. (uithouden) — figurado vs peso físico
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: sentido FIGURADO — aguantar / soportar una situación, tensión, dolor, la espera o una necesidad (muy típico aguantándose las ganas de ir al baño: Ik hou het niet meer uit!). NO se usa para un peso físico que no puedes cargar: eso es Ik kan het niet meer dragen / tillen. "Es insoportable" = Het is niet uit te houden.'
WHERE notes = 'Variante de houden: uithouden'
  AND rules_help NOT LIKE '%🧭%';

-- ==============================================================================
-- Even kijken. (kijken) — muletilla vs pedir espera
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: muletilla mientras piensas, buscas o compruebas algo (a ver…, déjame ver). Si quieres pedir un momentito de espera, mejor Momentje / Een ogenblik. even = un momento / rápido y se cuela en mil frases: Kom je even? = ¿vienes un momento?'
WHERE notes = 'Variante de kijken: kijken'
  AND rules_help NOT LIKE '%🧭%';

-- ==============================================================================
-- Dat bestaat niet! (bestaan) — exclamación vs literal existir
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: exclamación de incredulidad o negativa rotunda (¡no puede ser!, ¡ni de broma!, ¡de eso nada!), NO el literal "eso no existe". Para el sentido literal: Bestaat dat echt? = ¿eso existe de verdad?'
WHERE notes = 'Variante de staan: bestaan'
  AND rules_help NOT LIKE '%🧭%';

-- ==============================================================================
-- Hou op! (ophouden) — en serio vs en broma
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: ¡para ya!, ¡basta! Puede ser en serio (molesto) o en broma / incrédulo (¡anda ya!, ¡no me digas!), como el "stop it!" inglés. Para dejar de hacer algo: ophouden met + verbo -> Hou op met zeuren = deja de dar la lata.'
WHERE notes = 'Variante de houden: ophouden'
  AND rules_help NOT LIKE '%🧭%';

-- ==============================================================================
-- Afgesproken! (afspreken participio) — cerrar un acuerdo
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: cierra y sella un plan o acuerdo (¡hecho!, ¡trato hecho!, quedamos así). No es un saludo: se dice justo al terminar de acordar algo. Equivale a Deal! / Is goed!'
WHERE notes = 'Variante de spreken: afspreken (participio)'
  AND rules_help NOT LIKE '%🧭%';

-- ==============================================================================
-- Geef niet op! (opgeven) — ánimo, con qué no confundir opgeven
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: ánimo (¡no te rindas!, ¡no tires la toalla!). opgeven aquí = rendirse / abandonar; no lo confundas con weggeven (regalar), aangeven (indicar / declarar) ni uitgeven (gastar).'
WHERE notes = 'Variante de geven: opgeven'
  AND rules_help NOT LIKE '%🧭%';
