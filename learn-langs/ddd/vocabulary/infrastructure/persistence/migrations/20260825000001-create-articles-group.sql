-- Learn Languages App - Grupo "articulos - de, het o sin articulo"
-- Migration: 20260825000001-create-articles-group.sql
-- Description: cuando el sustantivo neerlandes lleva articulo y cuando va pelado, que es lo que
--   descoloca al hispanohablante porque el desajuste va en LAS DOS direcciones: el espanol pone
--   articulo donde el NL no (genericos en plural y abstractos: «LOS gatos» -> Katten) y el NL usa
--   POSESIVO donde el espanol usa articulo (partes del cuerpo: «me lavo LAS manos» -> mijn handen).
--   Lo pidio Eduardo a partir de la tarjeta 700 del grupo de «poner»: «Zet de vaas op tafel» lleva
--   articulo en de vaas —ese jarron— y lo pierde en op tafel, donde tafel no es un mueble sino el
--   sitio donde se deja algo. Regla madre: el articulo marca OBJETO IDENTIFICABLE; se cae cuando el
--   sustantivo pasa a nombrar una FUNCION, una CATEGORIA o una MATERIA.
--   Cubre: preposicion + lugar-funcion (op/aan tafel, naar school, in bed, naar huis, op kantoor),
--   plural generico, abstracto generico, incontables, profesiones tras zijn/worden/als, idiomas y
--   asignaturas, partes del cuerpo con posesivo, transporte (met DE trein pero te voet), locuciones
--   fijas (op tijd, in orde, met plezier) y la vuelta del articulo cuando el sustantivo se especifica.
--   NO cubre elegir entre de y het (eso es genero, otra pelea); se dice explicitamente en la ayuda.
--   15 tarjetas. Mapa compartido inyectado con REPLACE sobre @@ARTIKEL@@.
--   100% aditiva e IDEMPOTENTE.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'articulos - de, het o sin articulo',
    'Cuando el sustantivo lleva articulo y cuando va pelado. Regla madre: el articulo marca OBJETO IDENTIFICABLE y se cae cuando el sustantivo nombra una FUNCION, una CATEGORIA o una MATERIA (op tafel, naar school, in bed). Incluye los dos desajustes con el espanol —el espanol pone articulo en genericos y abstractos donde el NL no (Katten zijn onafhankelijk), y el NL usa posesivo en partes del cuerpo donde el espanol usa articulo (Ik was mijn handen)— mas profesiones, idiomas, incontables, transporte (met DE trein pero te voet), locuciones fijas y la vuelta del articulo cuando el sustantivo se especifica. Elegir entre de y het es otra cosa: eso es genero',
    'migracion'
);

-- ==============================================================================
-- 01) preposicion + lugar-funcion: op tafel
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la comida esta en la mesa', 'PHRASE', 'articulo: prep + funcion (op tafel)', 'op tafel va PELADO porque ahi tafel no es un mueble concreto, es el sitio donde se deja algo. Het eten staat op tafel.
@@ARTIKEL@@
📐 Estructura: Het eten (sujeto) + staat (verbo) + op tafel (lugar-funcion, sin articulo).

⚠️ Compara con la tarjeta 700 del grupo de «poner»: Zet DE vaas op tafel. En la misma frase conviven las dos cosas — de vaas es ese jarron concreto, op tafel es la funcion.

⚠️ staat y no ligt porque la comida se pone de pie (platos, fuentes). El par zetten↔staan del grupo 24.

🧭 Cuando usarlo: avisar de que ya esta servido. Ej.: → Het eten staat op tafel, kom maar (la comida esta en la mesa, ven).

🏋️ Ejercicio: «deja el movil en la mesa» → Leg je mobiel ___ ___. (Respuesta: op tafel. Funcion, sin articulo.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la comida esta en la mesa' AND notes = 'articulo: prep + funcion (op tafel)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la comida esta en la mesa' AND notes = 'articulo: prep + funcion (op tafel)' LIMIT 1),
    'nl_NL', 'Het eten staat op tafel.', 'Het eten stat op tafel.',
    '• [can.] Het eten staat op tafel. — La comida está en la mesa.
• [geb.] Zet de vaas maar op tafel. — Pon el jarrón en la mesa.
• [can.] Mijn sleutels liggen op tafel. — Mis llaves están en la mesa.
• [vraag] Mag ik mijn tas op tafel zetten? — ¿Puedo poner el bolso en la mesa?
• [can.] Er staat niets op tafel. — No hay nada en la mesa.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la comida esta en la mesa' AND notes = 'articulo: prep + funcion (op tafel)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la comida esta en la mesa' AND notes = 'articulo: prep + funcion (op tafel)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 02) aan tafel = a comer
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'a la mesa, la cena esta lista', 'PHRASE', 'articulo: aan tafel = a comer', 'aan tafel tambien va pelado, y no significa «junto a la mesa»: significa A COMER. Aan tafel, het eten is klaar!
@@ARTIKEL@@
📐 Estructura: Aan tafel (locucion sin articulo) + het eten (sujeto con articulo) + is klaar.

⚠️ La pareja completa: aan tafel gaan (sentarse a comer) · aan tafel zitten (estar comiendo) · van tafel gaan (levantarse de la mesa). Y de tafel dekken = poner la mesa, que SI lleva articulo porque ahi la mesa es el objeto directo, no una funcion.

⚠️ klaar = listo, terminado. No es «claro»: eso es duidelijk (falso amigo con el aleman klar).

🧭 Cuando usarlo: llamar a la familia a cenar. Ej.: → Aan tafel! (¡a la mesa!).

🏋️ Ejercicio: «vamos a la mesa» → We gaan ___ ___. (Respuesta: aan tafel. Sin articulo.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'a la mesa, la cena esta lista' AND notes = 'articulo: aan tafel = a comer');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'a la mesa, la cena esta lista' AND notes = 'articulo: aan tafel = a comer' LIMIT 1),
    'nl_NL', 'Aan tafel, het eten is klaar!', 'An tafel, het eten is klar!',
    '• [geb.] Aan tafel, het eten is klaar! — ¡A la mesa, la cena está lista!
• [can.] We gaan zo aan tafel. — Nos sentamos a comer enseguida.
• [can.] Hij zit al aan tafel. — Ya está sentado a la mesa.
• [vraag] Mag ik van tafel? — ¿Puedo levantarme de la mesa?
• [geb.] Dek jij even de tafel? — ¿Pones tú la mesa?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a la mesa, la cena esta lista' AND notes = 'articulo: aan tafel = a comer' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a la mesa, la cena esta lista' AND notes = 'articulo: aan tafel = a comer' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 03) naar school pelado pero op DE fiets con articulo
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'los ninos van al colegio en bici', 'PHRASE', 'articulo: naar school sin, op de fiets con', 'La misma frase lleva las dos: naar school PELADO (la institucion) y op DE fiets CON articulo (el vehiculo). De kinderen gaan op de fiets naar school.
@@ARTIKEL@@
📐 Estructura: De kinderen + gaan + op de fiets (modo) + naar school (lugar). Modo antes que lugar, el orden TIEMPO-MODO-LUGAR de siempre.

⚠️ school va pelado cuando es la institucion (naar school gaan = ir a clase, op school zitten = estar escolarizado) y CON articulo cuando es el edificio: De school is dicht.

⚠️ Lo mismo pasa con kerk, universiteit y kantoor: naar de kerk gaan es ir al edificio, naar de kerk gaan como practica religiosa tambien admite pelado en algunas expresiones. La institucion pierde el articulo, el edificio lo conserva.

🧭 Cuando usarlo: contar la rutina de los hijos. Ej.: → Ze gaan op de fiets naar school (van al cole en bici).

🏋️ Ejercicio: «voy a clase» → Ik ga ___ ___. (Respuesta: naar school. Institucion, sin articulo.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'los ninos van al colegio en bici' AND notes = 'articulo: naar school sin, op de fiets con');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'los ninos van al colegio en bici' AND notes = 'articulo: naar school sin, op de fiets con' LIMIT 1),
    'nl_NL', 'De kinderen gaan op de fiets naar school.', 'De kinderen jan op de fits nar sjol.',
    '• [can.] De kinderen gaan op de fiets naar school. — Los niños van al colegio en bici.
• [can.] Mijn dochter zit nog op school. — Mi hija todavía está escolarizada.
• [can.] De school is vandaag dicht. — El colegio hoy está cerrado.
• [vraag] Hoe laat ben je uit school? — ¿A qué hora sales de clase?
• [can.] Ik ga met de bus naar mijn werk. — Voy al trabajo en autobús.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los ninos van al colegio en bici' AND notes = 'articulo: naar school sin, op de fiets con' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los ninos van al colegio en bici' AND notes = 'articulo: naar school sin, op de fiets con' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 04) in bed / naar bed
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ya estoy en la cama, me voy a dormir', 'PHRASE', 'articulo: in bed / naar bed', 'in bed y naar bed van pelados: no es el mueble, es la funcion de dormir. Ik lig al in bed, ik ga slapen.
@@ARTIKEL@@
📐 Estructura: Ik + lig (verbo de postura) + al (tiempo) + in bed (funcion, sin articulo).

⚠️ lig y no ben: en la cama se esta TUMBADO, y el neerlandes obliga a decir la postura. liggen (tumbado) · zitten (sentado) · staan (de pie). «Ik ben in bed» suena raro.

⚠️ Con articulo vuelve a ser el mueble: Het bed is te klein (la cama es pequena). Y naar bed gaan = irse a dormir · uit bed komen = levantarse.

🧭 Cuando usarlo: contestar al telefono cuando ya te habias acostado. Ej.: → Ik lig al in bed (ya estoy acostado).

🏋️ Ejercicio: «me voy a la cama» → Ik ga ___ ___. (Respuesta: naar bed. Funcion, sin articulo.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ya estoy en la cama, me voy a dormir' AND notes = 'articulo: in bed / naar bed');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ya estoy en la cama, me voy a dormir' AND notes = 'articulo: in bed / naar bed' LIMIT 1),
    'nl_NL', 'Ik lig al in bed, ik ga slapen.', 'Ik lij al in bet, ik ja slapen.',
    '• [can.] Ik lig al in bed, ik ga slapen. — Ya estoy en la cama, me voy a dormir.
• [can.] De kinderen gaan om acht uur naar bed. — Los niños se van a la cama a las ocho.
• [vraag] Kom je nog uit bed? — ¿Piensas levantarte?
• [can.] Het bed is te klein voor ons tweeen. — La cama es pequeña para los dos.
• [can.] Hij ligt met griep in bed. — Está en cama con gripe.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ya estoy en la cama, me voy a dormir' AND notes = 'articulo: in bed / naar bed' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ya estoy en la cama, me voy a dormir' AND notes = 'articulo: in bed / naar bed' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 05) naar huis / thuis
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me voy a casa, estoy cansado', 'PHRASE', 'articulo: naar huis / thuis', 'naar huis va pelado, y «en casa» ni siquiera usa huis: es thuis, una palabra. Ik ga naar huis, ik ben moe.
@@ARTIKEL@@
📐 Estructura: Ik + ga + naar huis (destino, sin articulo), y para el estado thuis va solo: Ik ben thuis.

⚠️ El trio que hay que separar: naar huis = a casa (movimiento) · thuis = en casa (estado) · het huis = la casa (el edificio). Ik ben thuis, NUNCA «ik ben in huis» para decir que estas en casa.

⚠️ Y de familia: thuiskomen (llegar a casa), het thuisfront (los de casa), huiswerk (deberes).

🧭 Cuando usarlo: despedirte del trabajo o de una cena. Ej.: → Ik ga naar huis (me voy a casa).

🏋️ Ejercicio: «esta noche estoy en casa» → Vanavond ben ik ___. (Respuesta: thuis. Estado, una sola palabra.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'me voy a casa, estoy cansado' AND notes = 'articulo: naar huis / thuis');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'me voy a casa, estoy cansado' AND notes = 'articulo: naar huis / thuis' LIMIT 1),
    'nl_NL', 'Ik ga naar huis, ik ben moe.', 'Ik ja nar hauis, ik ben mu.',
    '• [can.] Ik ga naar huis, ik ben moe. — Me voy a casa, estoy cansado.
• [can.] Vanavond ben ik thuis. — Esta noche estoy en casa.
• [vraag] Hoe laat kom je thuis? — ¿A qué hora llegas a casa?
• [can.] Het huis is net verkocht. — La casa acaba de venderse.
• [can.] Ik werk twee dagen per week thuis. — Trabajo dos días por semana en casa.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me voy a casa, estoy cansado' AND notes = 'articulo: naar huis / thuis' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me voy a casa, estoy cansado' AND notes = 'articulo: naar huis / thuis' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 06) op kantoor
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hoy trabajo en la oficina', 'PHRASE', 'articulo: op kantoor', 'op kantoor pelado: la oficina como sitio donde se trabaja, no como local. Vandaag werk ik op kantoor.
@@ARTIKEL@@
📐 Estructura: Vandaag (tiempo en la casilla 1) + werk + ik (inversion) + op kantoor. Si el tiempo abre la frase, el sujeto salta detras del verbo.

⚠️ Con articulo cambia a local concreto: Het kantoor is verhuisd (la oficina se ha mudado).

⚠️ La familia del trabajo: op kantoor (en la oficina) · naar mijn werk (a mi trabajo, con posesivo) · aan het werk (trabajando) · op de zaak (en el negocio, con articulo). No hay logica que valga: se aprenden como bloques.

🧭 Cuando usarlo: decir si vas presencial o teletrabajas. Ej.: → Morgen werk ik thuis, vandaag op kantoor.

🏋️ Ejercicio: «esta en la oficina» → Hij is ___ ___. (Respuesta: op kantoor.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hoy trabajo en la oficina' AND notes = 'articulo: op kantoor');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'hoy trabajo en la oficina' AND notes = 'articulo: op kantoor' LIMIT 1),
    'nl_NL', 'Vandaag werk ik op kantoor.', 'Fandaj werk ik op kantor.',
    '• [can.] Vandaag werk ik op kantoor. — Hoy trabajo en la oficina.
• [can.] Hij is nog op kantoor. — Todavía está en la oficina.
• [can.] Het kantoor is verhuisd naar het centrum. — La oficina se ha mudado al centro.
• [vraag] Ben je vandaag op kantoor of thuis? — ¿Hoy estás en la oficina o en casa?
• [can.] Ik ben aan het werk. — Estoy trabajando.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hoy trabajo en la oficina' AND notes = 'articulo: op kantoor' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hoy trabajo en la oficina' AND notes = 'articulo: op kantoor' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 07) plural generico SIN articulo (el gran contraste con el espanol)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'los gatos son independientes', 'PHRASE', 'articulo: plural generico sin articulo', 'ESTE es el desajuste que mas duele: el espanol dice LOS gatos y el neerlandes NO puede poner articulo. Katten zijn onafhankelijk.
@@ARTIKEL@@
📐 Estructura: Katten (plural pelado = la categoria entera) + zijn + onafhankelijk.

⚠️ «De katten zijn onafhankelijk» no esta mal, pero significa OTRA cosa: esos gatos concretos, los de la casa. El plural con de senala un grupo identificable; el plural pelado habla de la especie.

⚠️ Mismo mecanismo con las nacionalidades y los colectivos: Nederlanders eten veel brood · Kinderen hebben structuur nodig. Y el ingles funciona igual (cats are independent), asi que si te ayuda, tira del ingles y no del espanol.

🧭 Cuando usarlo: dar una opinion general. Ej.: → Katten zijn onafhankelijk, honden niet.

🏋️ Ejercicio: «los holandeses comen mucho pan» → ___ eten veel brood. (Respuesta: Nederlanders. Sin articulo.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'los gatos son independientes' AND notes = 'articulo: plural generico sin articulo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'los gatos son independientes' AND notes = 'articulo: plural generico sin articulo' LIMIT 1),
    'nl_NL', 'Katten zijn onafhankelijk.', 'Katen sein onafhankelek.',
    '• [can.] Katten zijn onafhankelijk. — Los gatos son independientes.
• [can.] Nederlanders eten veel brood. — Los holandeses comen mucho pan.
• [can.] Kinderen hebben structuur nodig. — Los niños necesitan estructura.
• [can.] De katten van mijn buurvrouw zijn heel lief. — Los gatos de mi vecina son muy cariñosos.
• [vraag] Hou jij van honden? — ¿Te gustan los perros?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los gatos son independientes' AND notes = 'articulo: plural generico sin articulo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los gatos son independientes' AND notes = 'articulo: plural generico sin articulo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 08) abstracto generico
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el tiempo es oro', 'PHRASE', 'articulo: abstracto generico sin articulo', 'Los abstractos en general van pelados: el espanol dice EL tiempo, EL amor, LA paciencia, y el neerlandes no. Tijd is geld.
@@ARTIKEL@@
📐 Estructura: Tijd (abstracto pelado) + is + geld (otro abstracto pelado). Dos sustantivos sin articulo en cuatro palabras.

⚠️ Mas de la serie: Liefde maakt blind (el amor es ciego) · Geduld is een schone zaak (la paciencia es una virtud) · Werk is werk.

⚠️ Vuelve el articulo en cuanto el abstracto se concreta: DE tijd die we samen hadden (el tiempo que pasamos juntos) · DE liefde van mijn leven. Es la misma regla de siempre: especificado, articulo.

🧭 Cuando usarlo: soltar un refran o justificar una prisa. Ej.: → Tijd is geld, we moeten opschieten.

🏋️ Ejercicio: «el amor es ciego» → ___ maakt blind. (Respuesta: Liefde. Abstracto, sin articulo.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el tiempo es oro' AND notes = 'articulo: abstracto generico sin articulo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el tiempo es oro' AND notes = 'articulo: abstracto generico sin articulo' LIMIT 1),
    'nl_NL', 'Tijd is geld.', 'Teit is jelt.',
    '• [can.] Tijd is geld. — El tiempo es oro.
• [can.] Liefde maakt blind. — El amor es ciego.
• [can.] Geduld is een schone zaak. — La paciencia es una virtud.
• [can.] De tijd die we samen hadden was mooi. — El tiempo que pasamos juntos fue bonito.
• [vraag] Heb je even tijd? — ¿Tienes un momento?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tiempo es oro' AND notes = 'articulo: abstracto generico sin articulo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tiempo es oro' AND notes = 'articulo: abstracto generico sin articulo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 09) incontables
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'por las mananas bebo cafe', 'PHRASE', 'articulo: incontables sin articulo', 'Los incontables (liquidos, materias, dinero, tiempo) van pelados cuando no se especifica cantidad. Ik drink ''s ochtends koffie.
@@ARTIKEL@@
📐 Estructura: Ik + drink + ''s ochtends (tiempo) + koffie (incontable pelado, al final).

⚠️ Aqui el espanol COINCIDE (bebo café, tengo dinero), asi que este caso no suele fallar. Donde si falla es al meter een: «Ik drink een koffie» solo vale si pides UNA taza en un bar.

⚠️ Y el articulo vuelve si el incontable esta identificado: DE koffie is koud (el café este, el de tu taza).

🧭 Cuando usarlo: contar tu rutina de desayuno. Ej.: → Ik drink ''s ochtends koffie, ''s avonds thee.

🏋️ Ejercicio: «¿tienes dinero?» → Heb je ___? (Respuesta: geld. Incontable, sin articulo.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'por las mananas bebo cafe' AND notes = 'articulo: incontables sin articulo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'por las mananas bebo cafe' AND notes = 'articulo: incontables sin articulo' LIMIT 1),
    'nl_NL', 'Ik drink ''s ochtends koffie.', 'Ik drink sojtends kofi.',
    '• [can.] Ik drink ''s ochtends koffie. — Por las mañanas bebo café.
• [vraag] Heb je geld bij je? — ¿Llevas dinero encima?
• [can.] Er zit melk in de koelkast. — Hay leche en la nevera.
• [can.] De koffie is koud geworden. — El café se ha quedado frío.
• [vraag] Wil je een koffie? — ¿Quieres un café? (una taza)');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'por las mananas bebo cafe' AND notes = 'articulo: incontables sin articulo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'por las mananas bebo cafe' AND notes = 'articulo: incontables sin articulo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 10) profesiones tras zijn / worden / als
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'mi hermana es medica', 'PHRASE', 'articulo: profesiones tras zijn/worden/als', 'Las profesiones van peladas tras zijn, worden y als. Mijn zus is arts.
@@ARTIKEL@@
📐 Estructura: Mijn zus + is + arts (profesion pelada). Sin een, igual que en espanol.

⚠️ PERO en cuanto metes un adjetivo, vuelve el een: Mijn zus is EEN goede arts. La razon: con adjetivo ya no nombras la categoria, describes a una persona concreta.

⚠️ Mismo patron con worden (Ze wordt lerares) y con als (Ik werk als vertaler). Y ojo con las formas femeninas, que en NL siguen vivas: arts (neutro), lerares, verpleegkundige, secretaresse.

🧭 Cuando usarlo: presentar a alguien. Ej.: → Mijn zus is arts in Utrecht.

🏋️ Ejercicio: «es un buen médico» → Hij is ___ goede arts. (Respuesta: een. Con adjetivo vuelve el articulo.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'mi hermana es medica' AND notes = 'articulo: profesiones tras zijn/worden/als');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'mi hermana es medica' AND notes = 'articulo: profesiones tras zijn/worden/als' LIMIT 1),
    'nl_NL', 'Mijn zus is arts.', 'Mein sus is arts.',
    '• [can.] Mijn zus is arts. — Mi hermana es médica.
• [can.] Mijn zus is een goede arts. — Mi hermana es una buena médica.
• [can.] Ze wordt lerares. — Va a ser profesora.
• [can.] Ik werk als vertaler. — Trabajo de traductor.
• [vraag] Wat doe je voor werk? — ¿A qué te dedicas?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'mi hermana es medica' AND notes = 'articulo: profesiones tras zijn/worden/als' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'mi hermana es medica' AND notes = 'articulo: profesiones tras zijn/worden/als' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 11) idiomas y asignaturas
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el neerlandes es dificil pero bonito', 'PHRASE', 'articulo: idiomas y asignaturas sin articulo', 'Los idiomas y las asignaturas van pelados, aunque el espanol les ponga EL. Nederlands is moeilijk maar mooi.
@@ARTIKEL@@
📐 Estructura: Nederlands (idioma pelado, sujeto) + is + moeilijk maar mooi.

⚠️ Y con mayuscula SIEMPRE: Nederlands, Spaans, Engels, Duits. Los idiomas y las nacionalidades se escriben con inicial mayuscula, al reves que en espanol.

⚠️ Como complemento tambien pelado: Ik spreek Nederlands · Ik leer Spaans · Ik geef Engels. Ahi el espanol coincide (hablo neerlandes), el problema es solo cuando el idioma es SUJETO.

🧭 Cuando usarlo: hablar de tu progreso con el idioma. Ej.: → Nederlands is moeilijk, maar ik hou vol.

🏋️ Ejercicio: «hablo un poco de neerlandés» → Ik spreek een beetje ___. (Respuesta: Nederlands. Con mayuscula y sin articulo.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el neerlandes es dificil pero bonito' AND notes = 'articulo: idiomas y asignaturas sin articulo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el neerlandes es dificil pero bonito' AND notes = 'articulo: idiomas y asignaturas sin articulo' LIMIT 1),
    'nl_NL', 'Nederlands is moeilijk maar mooi.', 'Nederlants is muilek mar moi.',
    '• [can.] Nederlands is moeilijk maar mooi. — El neerlandés es difícil pero bonito.
• [can.] Ik spreek een beetje Nederlands. — Hablo un poco de neerlandés.
• [can.] Mijn dochter leert Spaans op school. — Mi hija aprende español en el colegio.
• [vraag] Spreekt u Engels? — ¿Habla usted inglés?
• [can.] Wiskunde was nooit mijn sterkste vak. — Las matemáticas nunca fueron lo mío.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el neerlandes es dificil pero bonito' AND notes = 'articulo: idiomas y asignaturas sin articulo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el neerlandes es dificil pero bonito' AND notes = 'articulo: idiomas y asignaturas sin articulo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 12) partes del cuerpo: POSESIVO, no articulo (el desajuste inverso)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me lavo las manos antes de comer', 'PHRASE', 'articulo: partes del cuerpo van con posesivo', 'El desajuste INVERSO: donde el espanol pone articulo, el neerlandes pone POSESIVO. Ik was mijn handen voor het eten.
@@ARTIKEL@@
📐 Estructura: Ik + was + mijn handen (posesivo obligatorio) + voor het eten (infinitivo sustantivado, este SI con articulo).

⚠️ «Ik was de handen» no se dice. El espanol resuelve la pertenencia con el pronombre (ME lavo LAS manos) y el neerlandes con el posesivo (MIJN handen). Mismo caso: Hij trekt ZIJN jas aan (se pone el abrigo) · Ze doet HAAR ogen dicht (cierra los ojos).

⚠️ Excepcion util: tras preposicion en frases hechas si aparece pelado o con articulo — pijn in de rug (dolor de espalda), met open mond. No se generaliza: se aprenden sueltas.

🧭 Cuando usarlo: la rutina de antes de comer, o el medico. Ej.: → Was je handen even (lavate las manos).

🏋️ Ejercicio: «se pone el abrigo» → Hij trekt ___ jas aan. (Respuesta: zijn. Posesivo, no articulo.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'me lavo las manos antes de comer' AND notes = 'articulo: partes del cuerpo van con posesivo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'me lavo las manos antes de comer' AND notes = 'articulo: partes del cuerpo van con posesivo' LIMIT 1),
    'nl_NL', 'Ik was mijn handen voor het eten.', 'Ik was mein handen for het eten.',
    '• [can.] Ik was mijn handen voor het eten. — Me lavo las manos antes de comer.
• [can.] Hij trekt zijn jas aan. — Se pone el abrigo.
• [geb.] Doe je ogen even dicht. — Cierra los ojos un momento.
• [can.] Ik heb pijn in mijn rug. — Me duele la espalda.
• [vraag] Heb je je handen gewassen? — ¿Te has lavado las manos?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me lavo las manos antes de comer' AND notes = 'articulo: partes del cuerpo van con posesivo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me lavo las manos antes de comer' AND notes = 'articulo: partes del cuerpo van con posesivo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 13) transporte: met DE trein pero te voet
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'voy a amsterdam en tren', 'PHRASE', 'articulo: met DE trein pero te voet', 'El transporte con met SI lleva articulo, aunque el espanol diga «en tren» a secas. Ik ga met de trein naar Amsterdam.
@@ARTIKEL@@
📐 Estructura: Ik + ga + met de trein (modo, CON articulo) + naar Amsterdam (lugar).

⚠️ Este es el caso que rompe la intuicion: si el sustantivo pelado fuera la norma, esperarias «met trein». Pero met exige el articulo: met DE trein, met DE auto, met DE bus, op DE fiets.

⚠️ Las formas peladas del transporte son OTRAS construcciones, con te y per: te voet (a pie), per trein / per post (registro formal o escrito). Nunca se mezclan: o met + articulo, o te/per pelado.

🧭 Cuando usarlo: quedar y explicar como llegas. Ej.: → Ik kom met de trein, rond negen uur.

🏋️ Ejercicio: «voy en bici» → Ik ga ___ ___ fiets. (Respuesta: op de. Con articulo.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'voy a amsterdam en tren' AND notes = 'articulo: met DE trein pero te voet');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a amsterdam en tren' AND notes = 'articulo: met DE trein pero te voet' LIMIT 1),
    'nl_NL', 'Ik ga met de trein naar Amsterdam.', 'Ik ja met de trein nar Amsterdam.',
    '• [can.] Ik ga met de trein naar Amsterdam. — Voy a Ámsterdam en tren.
• [can.] Zij komt op de fiets. — Ella viene en bici.
• [can.] Het is tien minuten te voet. — Está a diez minutos a pie.
• [can.] We sturen het per post. — Lo mandamos por correo.
• [vraag] Kom je met de auto of met de bus? — ¿Vienes en coche o en autobús?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a amsterdam en tren' AND notes = 'articulo: met DE trein pero te voet' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a amsterdam en tren' AND notes = 'articulo: met DE trein pero te voet' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 14) locuciones fijas preposicion + sustantivo
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'llego a tiempo, no te preocupes', 'PHRASE', 'articulo: locuciones fijas prep + sustantivo', 'Hay un monton de locuciones prep + sustantivo que van siempre peladas y se aprenden enteras. Ik ben op tijd, maak je geen zorgen.
@@ARTIKEL@@
📐 Estructura: Ik + ben + op tijd (locucion fija). No se analiza, se memoriza como una pieza.

⚠️ Las que mas vas a usar: op tijd (a tiempo) · in orde (en regla, tarjeta 728) · met plezier (con mucho gusto) · zonder twijfel (sin duda) · te koop / te huur (en venta / se alquila) · uit eten (a cenar fuera) · op vakantie (de vacaciones) · met pensioen (jubilado) · in dienst (de servicio, o en plantilla) · op weg (de camino).

⚠️ Trampa: op tijd = a tiempo, pero OP DE tijd no significa nada util. En estas locuciones meter el articulo no matiza, rompe.

🧭 Cuando usarlo: tranquilizar a quien te espera. Ej.: → Ik ben op tijd, geen zorgen.

🏋️ Ejercicio: «estamos de vacaciones» → We zijn ___ ___. (Respuesta: op vakantie.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'llego a tiempo, no te preocupes' AND notes = 'articulo: locuciones fijas prep + sustantivo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'llego a tiempo, no te preocupes' AND notes = 'articulo: locuciones fijas prep + sustantivo' LIMIT 1),
    'nl_NL', 'Ik ben op tijd, maak je geen zorgen.', 'Ik ben op teit, mak ye jen sorjen.',
    '• [can.] Ik ben op tijd, maak je geen zorgen. — Llego a tiempo, no te preocupes.
• [can.] Alles is in orde. — Todo está en regla.
• [can.] Met plezier! — ¡Con mucho gusto!
• [can.] Het huis staat te koop. — La casa está en venta.
• [can.] We gaan vanavond uit eten. — Esta noche cenamos fuera.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'llego a tiempo, no te preocupes' AND notes = 'articulo: locuciones fijas prep + sustantivo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'llego a tiempo, no te preocupes' AND notes = 'articulo: locuciones fijas prep + sustantivo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 15) cuando VUELVE el articulo: sustantivo especificado
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pon el mantel en la mesa que compramos', 'PHRASE', 'articulo: vuelve si el sustantivo se especifica', 'La regla de cierre: en cuanto el sustantivo se especifica, VUELVE el articulo. Leg het kleed op de tafel die we gekocht hebben.
@@ARTIKEL@@
📐 Estructura: Leg + het kleed (objeto) + op DE tafel (ya no es la funcion: es ESA mesa) + die we gekocht hebben (relativa que la especifica).

⚠️ Compara las dos de esta misma serie: op tafel (funcion, pelado) ↔ op de tafel die we gekocht hebben (mesa identificada, con articulo). Lo que devuelve el articulo es la relativa.

⚠️ Leg y no Zet porque el mantel queda PLANO. leggen↔liggen (tumbado) · zetten↔staan (de pie). Es el grupo 24.

⚠️ En la relativa el verbo se va al final (die we gekocht HEBBEN): es el aviso del bloque de orden de palabras.

🧭 Cuando usarlo: distinguir entre dos mesas. Ej.: → Niet op tafel, op DE tafel die we gekocht hebben.

🏋️ Ejercicio: «en la mesa que está fuera» → op ___ tafel die buiten staat. (Respuesta: de. Especificada, con articulo.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pon el mantel en la mesa que compramos' AND notes = 'articulo: vuelve si el sustantivo se especifica');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'pon el mantel en la mesa que compramos' AND notes = 'articulo: vuelve si el sustantivo se especifica' LIMIT 1),
    'nl_NL', 'Leg het kleed op de tafel die we gekocht hebben.', 'Lej het klet op de tafel di we jekojt heben.',
    '• [geb.] Leg het kleed op de tafel die we gekocht hebben. — Pon el mantel en la mesa que compramos.
• [can.] De tafel die buiten staat is van hout. — La mesa que está fuera es de madera.
• [geb.] Zet het maar op tafel. — Ponlo en la mesa.
• [vraag] Bedoel je deze tafel of die daar? — ¿Te refieres a esta mesa o a aquella?
• [can.] De vaas staat al op tafel. — El jarrón ya está en la mesa.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pon el mantel en la mesa que compramos' AND notes = 'articulo: vuelve si el sustantivo se especifica' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pon el mantel en la mesa que compramos' AND notes = 'articulo: vuelve si el sustantivo se especifica' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 2. BLOQUE COMPARTIDO: el mapa entero del articulo, identico en las 15 tarjetas
-- ==============================================================================
UPDATE words_es
SET rules_help = REPLACE(rules_help, '@@ARTIKEL@@', '🏛️ El articulo: cuando si y cuando no (el mapa entero)
Esto es igual en TODAS las tarjetas del grupo, asi que va explicado una sola vez.
Regla madre: el articulo marca que el sustantivo es un OBJETO IDENTIFICABLE. Se cae en cuanto la palabra deja de nombrar una cosa concreta y pasa a nombrar una FUNCION, una CATEGORIA o una MATERIA. Por eso la tarjeta 700 lleva las dos cosas en la misma frase: Zet DE vaas op tafel — de vaas es ESE jarron, y tafel ahi no es un mueble, es el sitio donde se deja algo.

🚫 SIN articulo:
| caso | neerlandes | que pasa en espanol |
|---|---|---|
| preposicion + lugar-funcion | op tafel, aan tafel, naar school, op school, in bed, naar bed, op kantoor, naar huis, op zee, aan boord, in dienst | el espanol SI pone articulo |
| plural generico | Katten zijn onafhankelijk | el espanol SI pone articulo |
| abstracto generico | Tijd is geld · Liefde maakt blind | el espanol SI pone articulo |
| incontables | Ik drink koffie · Heb je geld? | coincide |
| profesion tras zijn/worden/als | Mijn zus is arts · Ik werk als vertaler | coincide |
| idiomas y asignaturas | Ik spreek Nederlands · Nederlands is moeilijk | como sujeto, el espanol SI lo pone |
| locuciones fijas prep + sustantivo | op tijd, in orde, met plezier, te koop, te voet, uit eten, op vakantie, met pensioen | |
| materia y medida | een tafel van hout · twee kilo appels | |

✅ CON articulo:
| caso | ejemplo |
|---|---|
| objeto concreto e identificable | Zet DE vaas op tafel · Leg HET boek op tafel |
| sustantivo especificado (relativa, posesion) | op DE tafel die we gekocht hebben |
| singular generico de categoria | DE mens is een sociaal dier |
| infinitivo sustantivado | voor HET eten · HET lezen kost tijd |
| transporte con met / op | met DE trein, met DE auto, op DE fiets (pero te voet y per post, pelados) |
| el edificio o el objeto, frente a la institucion | DE school is dicht · HET kantoor is verhuisd · HET bed is te klein |

🇪🇸 Los dos desajustes con el espanol, que son la fuente de casi todo el lio:
1️⃣ El espanol PONE articulo donde el neerlandes NO: genericos en plural y abstractos. «LOS gatos son independientes» → Katten zijn onafhankelijk. «EL tiempo es oro» → Tijd is geld. Truco: si te sale el ingles, tira de el (cats are independent), que aqui funciona igual que el neerlandes.
2️⃣ El neerlandes usa POSESIVO donde el espanol usa articulo: partes del cuerpo y prendas. «Me lavo LAS manos» → Ik was MIJN handen. «Se pone EL abrigo» → Hij trekt ZIJN jas aan.

🧪 La prueba de dos segundos: preguntate «¿cual?». Si la respuesta importa (esa mesa, ese jarron, la escuela de mi hijo), va articulo. Si la pregunta no tiene sentido porque hablas de la funcion o de la categoria entera, va pelado.

📌 Y ojo, son dos peleas distintas: decidir SI hay articulo (esto) y decidir CUAL (de o het). La segunda es el genero de la palabra y se aprende con ella; solo hay dos atajos fiables — todos los plurales llevan de, y todos los diminutivos en -je llevan het (het vakje, het nummertje, het biertje).'),
    updated_at = datetime('now')
WHERE id IN (
    SELECT word_es_id FROM word_es_groups
    WHERE group_id = (SELECT id FROM word_groups WHERE title = 'articulos - de, het o sin articulo')
)
AND rules_help LIKE '%@@ARTIKEL@@%';
