-- Learn Languages App - Migration
-- Migration: 20260908000005-marca-de-persona-en-mis-tarjetas
-- Description: Eduardo, sobre la 1059 (We wachten op zijn komst = esperamos su llegada):
--   "te he pedido q cuando hay ambiguedad en el pronombre agreges entre parentesis en
--   español el pronombre, esperamos su llegada ¿de quien? ¿el, de ellos? de ellos seria
--   we wachten op hun komst?".
--
--   Tiene razon y es un incumplimiento mio: la norma ya estaba escrita (learn-langs-howto
--   §3.2, la marca entre parentesis al final para persona, tiempo o registro) y el mazo ya
--   la usaba en 42 tarjetas — «estara cansado (el)», «Estara en el atasco (ella, atona)»,
--   «¿Podria preguntarle algo? (formal, con u)». Yo no la apliqué al crear los grupos 35
--   a 40.
--
--   Y si: de ellos seria We wachten op HUN komst. El paradigma completo va en la ayuda de
--   la 1059.
--
--   Auditadas las tarjetas que cree (id >= 943), 16 llevan tercera persona en neerlandes.
--   De esas, cinco NO necesitan marca y se dejan como estan: la 964 y la 1017 ya dicen «el»
--   y «ella» en el propio texto, la 978 dice «usted», y la 952 (me han quitado el movil) y
--   la 1068 (aqui venden buen queso) son impersonales tambien en español, con lo que no hay
--   ambiguedad que resolver. Las once restantes reciben su marca.
--
--   ⚠️ AUDIO: cambia words_es.text, y la cache va por id, asi que los mp3 en español de las
--   tarjetas que ya tenian audio quedan desincronizados. Son tres (981, 1038 y 1059) y sus
--   ficheros word-<id>-es-es-castellano.mp3 se borran a mano fuera de esta migracion para
--   que se regeneren solos en la siguiente reproduccion. El audio NEERLANDES no se toca,
--   porque la traduccion no cambia. Ninguna esta subida al CDN (0 filas en word_es_media).

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. Las once tarjetas ambiguas reciben su marca de persona
-- =============================================================================
UPDATE words_es SET text = 'me agarró del brazo (él)'
WHERE id = 957 AND text = 'me agarró del brazo';

UPDATE words_es SET text = '¿de qué lo conoces? (a él)'
WHERE id = 969 AND text = '¿de qué lo conoces?';

UPDATE words_es SET text = 'ojalá venga mañana (él)'
WHERE id = 981 AND text = 'ojalá venga mañana';

UPDATE words_es SET text = 'no creo que venga (él)'
WHERE id = 990 AND text = 'no creo que venga';

UPDATE words_es SET text = 'de ahí que no viniera (él)'
WHERE id = 1005 AND text = 'de ahí que no viniera';

UPDATE words_es SET text = 'está enfermo, por eso no viene (él)'
WHERE id = 1009 AND text = 'está enfermo, por eso no viene';

UPDATE words_es SET text = 'tiene más dinero que yo (él)'
WHERE id = 1022 AND text = 'tiene más dinero que yo';

UPDATE words_es SET text = 'todavía vive (él)'
WHERE id = 1038 AND text = 'todavía vive';

UPDATE words_es SET text = 'conduce demasiado rápido (él)'
WHERE id = 1052 AND text = 'conduce demasiado rápido';

UPDATE words_es SET text = 'esperamos su llegada (de él)'
WHERE id = 1059 AND text = 'esperamos su llegada';

UPDATE words_es SET text = 'tiene una cara amable (él)'
WHERE id = 1063 AND text = 'tiene una cara amable';

-- =============================================================================
-- 2. La 1059: el paradigma de los posesivos, que es lo que trajo la duda
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: «Esperamos su llegada», ¿de quien? ¿De el, de ellos? ¿De ellos seria We wachten op hun komst?

🔑 Exacto, hun komst es la de ELLOS. El español dice su para cinco personas distintas y el neerlandes las separa todas, asi que aqui hay que elegir. Por eso esta tarjeta lleva ahora la marca (de el): sin ella no se puede resolver.

| en español | en neerlandes | de quien |
|---|---|---|
| su llegada | **zijn** komst | de el |
| su llegada | **haar** komst | de ella |
| su llegada | **hun** komst | de ellos |
| su llegada | **uw** komst | de usted |
| nuestra llegada | **onze** komst | de nosotros |
| vuestra llegada | **jullie** komst | de vosotros |
| mi llegada | **mijn** komst | de mi |
| tu llegada | **jouw** of **je** komst | de ti |

⚠️ Fijate en que zijn sirve para el Y para het: zijn komst es la de el, pero tambien la de un sustantivo neutro. Y haar sirve para ella y para los plurales de cosas en registro cuidado, aunque en el habla normal para plural se usa hun.

📐 Y ons u onze, que es la unica pareja que cambia de forma: onze con palabra de y con todos los plurales (onze komst, onze sleutels), ons con palabra het (ons huis).

🗣️ jouw o je: jouw es tonico y se usa cuando contrastas (Is dat JOUW auto?), je es atono y es el normal (je auto). Igual que el par mij/me y zij/ze.

🏋️ Ejercicio: «esperamos su llegada» dicho de ella y luego de ellos → We wachten op ___ komst. We wachten op ___ komst. (Respuestas: haar · hun.)'
WHERE id = 1059
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';
