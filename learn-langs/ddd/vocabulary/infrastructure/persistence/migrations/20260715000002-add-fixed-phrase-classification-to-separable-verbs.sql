-- Learn Languages App - Clasificación frase hecha / patrón productivo en verbos separables
-- Migration: 20260715000002-add-fixed-phrase-classification-to-separable-verbs.sql
-- Description: Añade a las 15 tarjetas del grupo "verbos separables - scheidbare werkwoorden"
--   (creadas en 20260715000001) un bloque 💎 que completa la ayuda "tipo": indica si la
--   frase es FRASE HECHA (memorízala tal cual) o PATRÓN PRODUCTIVO (aplica la fórmula y
--   cambia las piezas), y fija la colocación clave y/o el participio que conviene memorizar.
--   Se suma a los bloques ya presentes 📐 (fórmula) y 🧭 (contexto). Keyeada por notes
--   (único), idempotente (guarda NOT LIKE '%💎%'). Solo UPDATE de words_es.rules_help;
--   no toca words_lang/audio, imágenes ni notes. Corre después de 20260715000001.

PRAGMA foreign_keys = ON;

-- opbellen
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: PATRÓN PRODUCTIVO (no es frase hecha) — cambia sujeto/objeto/tiempo con la fórmula. Colocación que sí conviene fijar: iemand opbellen = llamar a alguien. Memoriza de carrerilla el participio: op-ge-beld.'
WHERE notes = 'Verbo separable: opbellen (perfecto)' AND rules_help NOT LIKE '%💎%';

-- opstaan
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: PATRÓN PRODUCTIVO. Lo que hay que memorizar de este verbo es su AUXILIAR: opstaan va con zijn (ben opgestaan), no hebben. Chunks útiles: vroeg opstaan (madrugar), laat opstaan (levantarse tarde).'
WHERE notes = 'Verbo separable: opstaan (perfecto, zijn)' AND rules_help NOT LIKE '%💎%';

-- aankomen
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: colocación fija que conviene MEMORIZAR tal cual → net aangekomen = recién llegado / acabar de llegar. Verbo de movimiento → zijn (is/zijn aangekomen). El resto de la frase, patrón productivo.'
WHERE notes = 'Verbo separable: aankomen (perfecto, zijn)' AND rules_help NOT LIKE '%💎%';

-- afspreken
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: PATRÓN PRODUCTIVO con chunks muy útiles para fijar de memoria: Zullen we afspreken? (¿quedamos?), met iemand afspreken (quedar con alguien), afgesproken! (¡trato hecho!). Cambia hora y lugar con la fórmula.'
WHERE notes = 'Verbo separable: afspreken (presente)' AND rules_help NOT LIKE '%💎%';

-- opnemen
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: COLOCACIÓN FIJA a memorizar → de telefoon opnemen = coger el teléfono (opnemen a secas = contestar; también = grabar). Memoriza la colocación; tiempo y sujeto son patrón productivo.'
WHERE notes = 'Verbo separable: opnemen (pasado)' AND rules_help NOT LIKE '%💎%';

-- meenemen
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: PATRÓN PRODUCTIVO. Colocación base: iets/iemand meenemen = llevarse algo / a alguien. Chunk típico de cafetería para memorizar: om mee te nemen (para llevar). Cambia objeto y tiempo con la fórmula.'
WHERE notes = 'Verbo separable: meenemen (pasado)' AND rules_help NOT LIKE '%💎%';

-- ophalen
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: COLOCACIÓN FIJA a memorizar → iemand ophalen = ir a buscar / recoger a alguien (van school, van het station). Fija «iemand van … ophalen»; la hora y el sujeto, con la fórmula.'
WHERE notes = 'Verbo separable: ophalen (presente)' AND rules_help NOT LIKE '%💎%';

-- uitnodigen
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: PATRÓN PRODUCTIVO. Colocación: iemand uitnodigen voor iets = invitar a alguien a algo. Memoriza el participio uit-ge-nodigd. Trampa: lleva objeto DIRECTO sin preposición (ons uitnodigen), nunca «aan».'
WHERE notes = 'Verbo separable: uitnodigen (perfecto)' AND rules_help NOT LIKE '%💎%';

-- terugbellen
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: PATRÓN PRODUCTIVO típico de teléfono/trabajo. Chunk para fijar: Ik bel u zo terug (ahora le devuelvo la llamada). Memoriza el participio terug-ge-beld.'
WHERE notes = 'Verbo separable: terugbellen (perfecto)' AND rules_help NOT LIKE '%💎%';

-- uitgeven
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: COLOCACIÓN FIJA a memorizar → geld uitgeven = gastar dinero (uitgeven también = publicar un libro). Fija «geld uitgeven» y el participio uit-ge-geven; cantidad y tiempo, con la fórmula.'
WHERE notes = 'Verbo separable: uitgeven (perfecto)' AND rules_help NOT LIKE '%💎%';

-- weggaan
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: PATRÓN PRODUCTIVO. Lo que se memoriza: verbo de movimiento → zijn (zijn weggegaan) y el participio weg-ge-gaan. Chunk cotidiano: Ik moet weg (me tengo que ir).'
WHERE notes = 'Verbo separable: weggaan (perfecto, zijn)' AND rules_help NOT LIKE '%💎%';

-- opruimen
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: PATRÓN PRODUCTIVO. Chunk doméstico clásico para fijar: Ruim je kamer op! (¡ordena tu cuarto!). Memoriza «iets opruimen» y el participio op-ge-ruimd.'
WHERE notes = 'Verbo separable: opruimen (perfecto)' AND rules_help NOT LIKE '%💎%';

-- aantrekken
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: COLOCACIÓN FIJA de la ropa a memorizar → iets aantrekken = ponerse una prenda (jas, schoenen, trui). Su opuesto: uittrekken (quitarse). Fija «je jas aantrekken»; la prenda cambia.'
WHERE notes = 'Verbo separable: aantrekken (imperativo)' AND rules_help NOT LIKE '%💎%';

-- opschieten
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: FRASE HECHA — memorízala tal cual → Schiet op! = ¡date prisa! / ¡venga! NO la traduzcas pieza a pieza (schieten = disparar) ni cambies el orden. Variante enfática: Schiet eens op!'
WHERE notes = 'Verbo separable: opschieten (imperativo)' AND rules_help NOT LIKE '%💎%';

-- uitzetten
UPDATE words_es SET rules_help = rules_help || '

💎 Frase hecha o patrón: COLOCACIÓN FIJA de aparatos a memorizar en PAR → iets uitzetten = apagar / iets aanzetten = encender (tv, licht, telefoon, motor). Fija el par aan/uit + zetten; el objeto cambia.'
WHERE notes = 'Verbo separable: uitzetten (imperativo)' AND rules_help NOT LIKE '%💎%';
