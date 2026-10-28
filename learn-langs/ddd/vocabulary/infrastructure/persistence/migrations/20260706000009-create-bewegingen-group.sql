-- Learn Languages App - Grupo "bewegingen-richtingen": adverbios de movimiento
-- Migration: 20260706000009-create-bewegingen-group.sql
-- Description: Crea el grupo "bewegingen-richtingen" con 22 entradas sobre los
--   adverbios de movimiento y direccion (nivel B1/B2): familias -heen
--   (doorheen/omheen/overheen), -door (binnendoor/onderdoor/tussendoor/
--   rechtdoor/ervandoor), omhoog/omlaag, op/af, trafico (linksaf/rechtsaf/
--   vooruit/achteruit) y -langs (voorlangs/achterlangs/bovenlangs/onderlangs).
--   Tema tratado en la leccion de Learn Dutch with Kim (ver source del grupo);
--   frases de ejemplo propias. Incluye rules_help con la mecanica separable/er.
--   Idempotente. No toca ids existentes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'bewegingen-richtingen',
    'Adverbios de movimiento y direccion (B1/B2): doorheen, omheen, overheen, binnendoor, onderdoor, tussendoor, rechtdoor, ervandoor, omhoog/omlaag, op/af, linksaf/rechtsaf, vooruit/achteruit y familia -langs',
    'BEWEGINGEN & RICHTINGEN: 20 Nederlandse bijwoorden (NT2 - B1/B2) - Learn Dutch with Kim - https://www.youtube.com/watch?v=yCVpmciFOrY'
);

-- ==============================================================================
-- 2. PALABRAS EN ESPAÑOL (solo si no existen)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes)
SELECT 'a través de', 'PHRASE', 'doorheen: atravesar algo'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'a través de');

INSERT INTO words_es (text, word_type, notes)
SELECT 'alrededor de', 'PHRASE', 'omheen: rodear algo'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'alrededor de');

INSERT INTO words_es (text, word_type, notes)
SELECT 'por encima de', 'PHRASE', 'overheen: pasar por encima'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'por encima de');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿adónde vas?', 'PHRASE', 'waarheen/heen: direccion'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿adónde vas?');

INSERT INTO words_es (text, word_type, notes)
SELECT 'por dentro (atajo)', 'PHRASE', 'binnendoor vs buitenom'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'por dentro (atajo)');

INSERT INTO words_es (text, word_type, notes)
SELECT 'por debajo de', 'PHRASE', 'onderdoor'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'por debajo de');

INSERT INTO words_es (text, word_type, notes)
SELECT 'entre medias', 'PHRASE', 'tussendoor: entre cosas o entre horas'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'entre medias');

INSERT INTO words_es (text, word_type, notes)
SELECT 'todo recto', 'PHRASE', 'rechtdoor: indicaciones'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'todo recto');

INSERT INTO words_es (text, word_type, notes)
SELECT 'me largo', 'PHRASE', 'ervandoor: marcharse'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'me largo');

INSERT INTO words_es (text, word_type, notes)
SELECT 'hacia arriba', 'PHRASE', 'omhoog'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hacia arriba');

INSERT INTO words_es (text, word_type, notes)
SELECT 'hacia abajo', 'PHRASE', 'omlaag'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hacia abajo');

INSERT INTO words_es (text, word_type, notes)
SELECT 'escaleras arriba', 'PHRASE', 'de trap op: subirse a'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'escaleras arriba');

INSERT INTO words_es (text, word_type, notes)
SELECT 'escaleras abajo', 'PHRASE', 'de trap af: bajarse de'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'escaleras abajo');

INSERT INTO words_es (text, word_type, notes)
SELECT 'girar a la izquierda', 'PHRASE', 'linksaf'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'girar a la izquierda');

INSERT INTO words_es (text, word_type, notes)
SELECT 'girar a la derecha', 'PHRASE', 'rechtsaf'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'girar a la derecha');

INSERT INTO words_es (text, word_type, notes)
SELECT 'hacia delante', 'PHRASE', 'vooruit (tambien figurado: mejorar)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hacia delante');

INSERT INTO words_es (text, word_type, notes)
SELECT 'hacia atrás', 'PHRASE', 'achteruit (tambien figurado: empeorar)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hacia atrás');

INSERT INTO words_es (text, word_type, notes)
SELECT 'por delante (bordeando)', 'PHRASE', 'voorlangs'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'por delante (bordeando)');

INSERT INTO words_es (text, word_type, notes)
SELECT 'por detrás (bordeando)', 'PHRASE', 'achterlangs'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'por detrás (bordeando)');

INSERT INTO words_es (text, word_type, notes)
SELECT 'por la ruta de arriba', 'PHRASE', 'bovenlangs'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'por la ruta de arriba');

INSERT INTO words_es (text, word_type, notes)
SELECT 'por la ruta de abajo', 'PHRASE', 'onderlangs'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'por la ruta de abajo');

INSERT INTO words_es (text, word_type, notes)
SELECT 'el tentempié', 'WORD', 'het tussendoortje: snack entre horas'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el tentempié');

-- ==============================================================================
-- 3. TRADUCCIONES + 5 EJEMPLOS
-- ==============================================================================

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'a través de'),
    'nl_NL',
    'doorheen',
    '• [can.] Ik loop door de menigte heen. — Atravieso la multitud.
• [inv.] Op Koningsdag kom je nergens doorheen. — En el Día del Rey no se puede pasar por ningún lado.
• [perf.] We zijn er goed doorheen gekomen. — Hemos salido bien de ello.
• [vraag] Kun je door dit glas heen kijken? — ¿Se puede ver a través de este cristal?
• [uitdr.] Hij zit er helemaal doorheen. — Está agotado, no puede más (frase hecha).'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'alrededor de'),
    'nl_NL',
    'omheen',
    '• [can.] We lopen om het park heen. — Rodeamos el parque.
• [can.] Er staat een hek om de tuin heen. — Hay una valla alrededor del jardín.
• [inv.] Bij wegwerkzaamheden rijd je eromheen. — Con obras en la vía, lo rodeas.
• [vraag] Zitten we allemaal om de tafel heen? — ¿Estamos todos alrededor de la mesa?
• [uitdr.] Draai er niet omheen! — ¡No te vayas por las ramas! (frase hecha)'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'por encima de'),
    'nl_NL',
    'overheen',
    '• [can.] De bal ging over het hek heen. — El balón pasó por encima de la valla.
• [can.] Ik leg een laken over de stoel heen. — Pongo una sábana por encima de la silla.
• [perf.] Ze is er eindelijk overheen. — Por fin lo ha superado (figurado).
• [vraag] Springen we eroverheen? — ¿Saltamos por encima?
• [bijzin] Er ging een week overheen voordat hij antwoordde. — Pasó una semana hasta que contestó.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿adónde vas?'),
    'nl_NL',
    'waar ga je heen?',
    '• [vraag] Waar ga je heen? — ¿Adónde vas?
• [can.] Ik ga daarheen. — Voy allí.
• [geb.] Kom maar hierheen! — ¡Ven aquí!
• [vraag] Waar gaan jullie dit jaar heen op vakantie? — ¿Adónde vais este año de vacaciones?
• [bijzin] Ik weet nog niet waar we heen gaan. — Aún no sé adónde vamos.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'por dentro (atajo)'),
    'nl_NL',
    'binnendoor',
    '• [can.] We gaan binnendoor, dat is korter. — Vamos por dentro, es más corto.
• [inv.] Via het park gaan we binnendoor. — Por el parque atajamos.
• [perf.] We zijn binnendoor gereden. — Hemos ido por el atajo.
• [vraag] Gaan we binnendoor of buitenom? — ¿Vamos por dentro o bordeando por fuera?
• [bijzin] Elke fietser weet dat je binnendoor sneller bent. — Todo ciclista sabe que por dentro llegas antes.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'por debajo de'),
    'nl_NL',
    'onderdoor',
    '• [can.] We fietsen onder de brug door. — Pasamos en bici por debajo del puente.
• [can.] De kat kruipt onder het hek door. — El gato se cuela por debajo de la valla.
• [inv.] Bij het viaduct ga je eronderdoor. — En el viaducto pasas por debajo.
• [vraag] Kun je daar onderdoor? — ¿Cabes por debajo?
• [uitdr.] Ze ging bijna aan de stress onderdoor. — Casi la hunde el estrés (frase hecha: eraan onderdoor gaan).'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'entre medias'),
    'nl_NL',
    'tussendoor',
    '• [can.] Ik eet tussendoor een appel. — Como una manzana entre horas.
• [can.] De ober liep tussen de tafeltjes door. — El camarero pasaba entre las mesas.
• [inv.] Tussendoor check ik even mijn mail. — Entre medias echo un vistazo al correo.
• [vraag] Heb je tussendoor tijd voor een belletje? — ¿Tienes un hueco entre medias para una llamada?
• [bijzin] De dag is zo vol dat ik tussendoor amper kan eten. — El día está tan lleno que apenas puedo comer entre medias.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'todo recto'),
    'nl_NL',
    'rechtdoor',
    '• [can.] Je gaat hier rechtdoor. — Aquí sigues todo recto.
• [inv.] Bij de rotonde ga je rechtdoor. — En la rotonda sigues recto.
• [geb.] Loop maar gewoon rechtdoor! — ¡Tú sigue todo recto!
• [vraag] Is het rechtdoor of moet ik afslaan? — ¿Es todo recto o tengo que girar?
• [bijzin] De agent zei dat we rechtdoor moesten. — El agente dijo que siguiéramos recto.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'me largo'),
    'nl_NL',
    'ik ga ervandoor',
    '• [uitdr.] Ik ga ervandoor! — ¡Me largo! (despedida informal)
• [can.] We moeten er weer vandoor. — Tenemos que irnos ya.
• [perf.] De kat is ervandoor gegaan. — El gato se ha escapado.
• [can.] De dief ging er met de fiets vandoor. — El ladrón se largó con la bici.
• [bijzin] Hij zei snel doei, omdat hij ervandoor moest. — Dijo adiós rápido porque tenía que largarse.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'hacia arriba'),
    'nl_NL',
    'omhoog',
    '• [can.] De lift gaat omhoog. — El ascensor sube.
• [geb.] Handen omhoog! — ¡Manos arriba!
• [can.] Ik kijk omhoog naar de wolken. — Miro hacia arriba, a las nubes.
• [inv.] In de zomer gaan de prijzen omhoog. — En verano los precios suben (figurado).
• [vraag] Kun je het raam omhoog doen? — ¿Puedes subir la ventanilla?'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'hacia abajo'),
    'nl_NL',
    'omlaag',
    '• [can.] De lift gaat omlaag. — El ascensor baja.
• [can.] Ik kijk omlaag vanaf de brug. — Miro hacia abajo desde el puente.
• [geb.] Doe het volume wat omlaag! — ¡Baja un poco el volumen!
• [inv.] Na de zomer gaan de prijzen weer omlaag. — Tras el verano los precios vuelven a bajar.
• [bijzin] Ik hoop dat de huurprijzen ooit omlaag gaan. — Espero que los alquileres bajen algún día.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'escaleras arriba'),
    'nl_NL',
    'de trap op',
    '• [can.] Ik loop de trap op. — Subo la escalera.
• [can.] Ik stap op mijn fiets. — Me subo a la bici.
• [inv.] Met de boodschappen loop ik de trap op. — Con la compra subo la escalera.
• [vraag] Neem je de lift of loop je de trap op? — ¿Coges el ascensor o subes por la escalera?
• [perf.] Ik ben vier trappen op gelopen. — He subido cuatro tramos de escalera.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'escaleras abajo'),
    'nl_NL',
    'de trap af',
    '• [can.] Ik loop de trap af. — Bajo la escalera.
• [can.] Ik stap van mijn fiets af. — Me bajo de la bici.
• [inv.] Voorzichtig loopt oma de trap af. — Con cuidado baja la abuela la escalera.
• [vraag] Kom je de trap af? Het eten is klaar! — ¿Bajas? ¡La comida está lista!
• [perf.] Hij is van het podium af gestapt. — Se ha bajado del escenario.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'girar a la izquierda'),
    'nl_NL',
    'linksaf',
    '• [can.] Je gaat bij de kruising linksaf. — En el cruce giras a la izquierda.
• [inv.] Bij het stoplicht sla je linksaf. — En el semáforo giras a la izquierda.
• [geb.] Ga hier linksaf! — ¡Gira aquí a la izquierda!
• [vraag] Moet ik hier linksaf of rechtdoor? — ¿Giro aquí a la izquierda o sigo recto?
• [bijzin] De navigatie zegt dat je linksaf moet. — El navegador dice que gires a la izquierda.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'girar a la derecha'),
    'nl_NL',
    'rechtsaf',
    '• [can.] Na de brug ga je rechtsaf. — Después del puente giras a la derecha.
• [inv.] Bij de bakker sla je rechtsaf. — En la panadería giras a la derecha.
• [geb.] Sla hier rechtsaf! — ¡Gira aquí a la derecha!
• [vraag] Mag je hier rechtsaf? — ¿Se puede girar aquí a la derecha?
• [bijzin] Ik mis de afslag altijd, omdat je daar snel rechtsaf moet. — Siempre me paso el desvío porque hay que girar rápido a la derecha.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'hacia delante'),
    'nl_NL',
    'vooruit',
    '• [can.] De auto rijdt langzaam vooruit. — El coche avanza despacio.
• [can.] Ik kijk vooruit, niet achterom. — Miro hacia delante, no hacia atrás.
• [geb.] Vooruit, we gaan! — ¡Venga, vamos! (muletilla común)
• [uitdr.] Je Nederlands gaat echt vooruit! — ¡Tu neerlandés mejora de verdad! (figurado: vooruitgaan = mejorar)
• [bijzin] De trainer zegt dat we goed vooruitgaan. — El entrenador dice que progresamos bien.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'hacia atrás'),
    'nl_NL',
    'achteruit',
    '• [can.] Ik parkeer achteruit in. — Aparco marcha atrás.
• [geb.] Ga even een stapje achteruit. — Da un pasito atrás.
• [inv.] In de trein zit ik liever niet achteruit. — En el tren prefiero no ir de espaldas.
• [uitdr.] Zijn gezondheid gaat achteruit. — Su salud empeora (figurado: achteruitgaan = empeorar).
• [vraag] Kun je een stukje achteruit rijden? — ¿Puedes retroceder un poco?'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'por delante (bordeando)'),
    'nl_NL',
    'voorlangs',
    '• [can.] De bus rijdt voorlangs het station. — El autobús pasa por delante de la estación.
• [can.] Ik loop voorlangs het podium. — Paso por delante del escenario.
• [inv.] Bij gym brengen we de armen voorlangs omhoog. — En gimnasia subimos los brazos por delante.
• [vraag] Ga je voorlangs of achterlangs? — ¿Pasas por delante o por detrás?
• [bijzin] De weg voorlangs is korter, hoewel er meer verkeer is. — El camino por delante es más corto, aunque hay más tráfico.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'por detrás (bordeando)'),
    'nl_NL',
    'achterlangs',
    '• [can.] We lopen achterlangs het huis. — Pasamos por detrás de la casa.
• [can.] De kat komt altijd achterlangs binnen. — El gato siempre entra por detrás.
• [inv.] Op het schoolplein gaan we achterlangs. — En el patio pasamos por detrás.
• [vraag] Kunnen we achterlangs naar de tuin? — ¿Se puede ir por detrás al jardín?
• [can.] De inbreker ontsnapte achterlangs. — El ladrón escapó por la parte de atrás.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'por la ruta de arriba'),
    'nl_NL',
    'bovenlangs',
    '• [can.] We nemen de route bovenlangs. — Tomamos la ruta por arriba.
• [inv.] Door de duinen kun je bovenlangs wandelen. — Por las dunas puedes caminar por arriba.
• [vraag] Gaan we bovenlangs of onderlangs? — ¿Vamos por arriba o por abajo?
• [can.] Het pad bovenlangs heeft mooier uitzicht. — El sendero de arriba tiene mejores vistas.
• [bijzin] De gids zegt dat bovenlangs veiliger is. — El guía dice que por arriba es más seguro.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'por la ruta de abajo'),
    'nl_NL',
    'onderlangs',
    '• [can.] We lopen onderlangs, door het dal. — Vamos por abajo, por el valle.
• [inv.] Bij harde wind fiets je beter onderlangs. — Con viento fuerte mejor ir en bici por abajo.
• [vraag] Is onderlangs sneller? — ¿Por abajo es más rápido?
• [can.] Het pad onderlangs is lekker vlak. — El sendero de abajo es bien llano.
• [bijzin] We gaan onderlangs, omdat het pad bovenlangs glad is. — Vamos por abajo porque el sendero de arriba resbala.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'el tentempié'),
    'nl_NL',
    'het tussendoortje',
    '• [can.] Ik neem een tussendoortje. — Tomo un tentempié.
• [can.] Fruit is een gezond tussendoortje. — La fruta es un tentempié sano.
• [vraag] Wil je een tussendoortje? — ¿Quieres algo de picar?
• [inv.] Rond vier uur eet ik een tussendoortje. — Sobre las cuatro como algo entre horas.
• [bijzin] De kinderen krijgen een tussendoortje, voordat ze gaan sporten. — Los niños toman un tentempié antes de hacer deporte.'
);

-- ==============================================================================
-- 4. ASOCIAR AL GRUPO "bewegingen-richtingen" (y a "generic")
-- ==============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen')
FROM words_es we
WHERE we.text IN (
    'a través de', 'alrededor de', 'por encima de', '¿adónde vas?',
    'por dentro (atajo)', 'por debajo de', 'entre medias', 'todo recto',
    'me largo', 'hacia arriba', 'hacia abajo', 'escaleras arriba',
    'escaleras abajo', 'girar a la izquierda', 'girar a la derecha',
    'hacia delante', 'hacia atrás', 'por delante (bordeando)',
    'por detrás (bordeando)', 'por la ruta de arriba', 'por la ruta de abajo',
    'el tentempié'
);

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, (SELECT id FROM word_groups WHERE title = 'generic')
FROM words_es we
WHERE we.text IN (
    'a través de', 'alrededor de', 'por encima de', '¿adónde vas?',
    'por dentro (atajo)', 'por debajo de', 'entre medias', 'todo recto',
    'me largo', 'hacia arriba', 'hacia abajo', 'escaleras arriba',
    'escaleras abajo', 'girar a la izquierda', 'girar a la derecha',
    'hacia delante', 'hacia atrás', 'por delante (bordeando)',
    'por detrás (bordeando)', 'por la ruta de arriba', 'por la ruta de abajo',
    'el tentempié'
);

-- ==============================================================================
-- 5. REGLAS DE USO (boton de ayuda del Aprendizaje)
-- ==============================================================================

UPDATE words_es SET rules_help = 'DOORHEEN = a través de (movimiento que atraviesa algo).
REGLA DE ORO de los adverbios en dos piezas:
• Con sustantivo se PARTEN: Ik loop DOOR de mensen HEEN.
• Con ER se PEGAN: Ik loop ERDOORHEEN.
• HEEN es opcional con sustantivo, OBLIGATORIO con er.
Figurado: ergens doorheen gaan (pasar por algo duro) · er doorheen zitten (estar quemado, no poder más).' WHERE text = 'a través de';

UPDATE words_es SET rules_help = 'OMHEEN = alrededor de (rodear).
Se parte con sustantivo (OM de lamp HEEN) y se pega con er (EROMHEEN).
Figurado clave: ergens omheen draaien = irse por las ramas, no ir al grano
(Draai er niet omheen!) · niet om iemand heen kunnen = no poder ignorar a alguien
(We kunnen niet om haar heen: es imprescindible).' WHERE text = 'alrededor de';

UPDATE words_es SET rules_help = 'OVERHEEN = por encima de (pasando sobre algo).
Se parte con sustantivo (OVER het hek HEEN) y se pega con er (EROVERHEEN).
HEEN opcional con sustantivo: over het hek (heen); con er, obligatorio.
Figurado importantísimo: ergens overheen zijn = haberlo superado
(Ik ben er nog niet overheen — aún no lo he superado; conecta con "zet je er overheen").
Tiempo: er ging een maand overheen = pasó un mes.' WHERE text = 'por encima de';

UPDATE words_es SET rules_help = 'HEEN a secas = dirección «hacia (algún sitio)».
• Waar ga je heen? = Waar ga je naartoe? — ¿Adónde vas?
• hierheen (hacia aquí) · daarheen (hacia allí) · ergens heen (a algún lado).
Con estos SÍ puedes cambiar heen por naartoe; con doorheen/omheen/overheen NO.
Otros usos de heen: heen en terug (ida y vuelta) · hij is ver heen (está ido, borracho o senil).' WHERE text = '¿adónde vas?';

UPDATE words_es SET rules_help = 'BINNENDOOR = por dentro, atajando (a través de algo en vez de bordearlo).
Su pareja es BUITENOM (bordeando por fuera):
• binnendoor gaan = atajar por dentro (por el centro, por el parque...)
• buitenom gaan = rodear (por la circunvalación, por fuera de la casa).
Típico en indicaciones de ruta: Gaan we binnendoor of buitenom?' WHERE text = 'por dentro (atajo)';

UPDATE words_es SET rules_help = 'ONDERDOOR = por debajo de (pasando).
Se parte: ONDER de brug DOOR · se pega con er: ERONDERDOOR.
Figurado muy usado: ergens aan onderdoor gaan = hundirse por algo, poder con uno
(Ze ging aan de stress onderdoor — el estrés pudo con ella).
Ojo a la estructura del figurado: aan + causa + onderdoor gaan.' WHERE text = 'por debajo de';

UPDATE words_es SET rules_help = 'TUSSENDOOR tiene dos vidas:
1) Espacial: entre cosas — Ik loop TUSSEN de mensen DOOR (ertussendoor).
2) Temporal: entre medias, entre tareas/horas — Tussendoor check ik mijn mail.
De la temporal sale HET TUSSENDOORTJE = el tentempié (lo que comes entre horas).
Se parte con sustantivo, se pega con er, como toda la familia.' WHERE text = 'entre medias';

UPDATE words_es SET rules_help = 'RECHTDOOR = todo recto (sin girar). Palabra clave de indicaciones:
• Bij de rotonde rechtdoor. — En la rotonda, recto.
Trío de supervivencia callejera: RECHTDOOR (recto) · LINKSAF (izquierda) · RECHTSAF (derecha).
Ojo a la ortografía/pronunciación: rechTdoor (recto) vs rechTSaf (a la derecha).
No confundir con rechtop (erguido): zit rechtop = siéntate derecho.' WHERE text = 'todo recto';

UPDATE words_es SET rules_help = 'ERVANDOOR (gaan) = largarse, salir pitando. Siempre con ER.
• Ik ga ervandoor! — ¡Me largo! (despedida informal buenísima)
• er met iets vandoor gaan = largarse llevándose algo:
  De dief ging er met mijn fiets vandoor.
No indica dirección: solo que te marchas. Sinónimos: wegwezen!, ik ben weg.' WHERE text = 'me largo';

UPDATE words_es SET rules_help = 'OMHOOG = hacia arriba (dirección ascendente).
• omhoog kijken/wijzen/gaan — mirar/señalar/ir hacia arriba.
Figurado: prijzen gaan omhoog (los precios suben) · duimpje omhoog (pulgar arriba).
Su antónimo exacto es OMLAAG. La posición estática es BOVEN (arriba):
boven = estar arriba · omhoog = moverse hacia arriba.' WHERE text = 'hacia arriba';

UPDATE words_es SET rules_help = 'OMLAAG = hacia abajo (dirección descendente).
• omlaag kijken/gaan — mirar/ir hacia abajo · het volume omlaag doen.
Figurado: prijzen gaan omlaag (los precios bajan).
Sinónimo frecuente: NAAR BENEDEN (ir abajo): Ik ga naar beneden = bajo (en casa).
Posición estática: BENEDEN/ONDER (abajo) · movimiento: OMLAAG.' WHERE text = 'hacia abajo';

UPDATE words_es SET rules_help = 'DE TRAP OP (lopen) = subir la escalera; el patrón es [objeto] + OP:
• de trap op lopen · de berg op fietsen · op je fiets stappen (subirse a).
Con er: erop stappen. OP indica que acabas ENCIMA del objeto.
Su pareja es AF (bajarse): ver "escaleras abajo".
También: naar boven gaan = subir (en casa, sin nombrar la escalera).' WHERE text = 'escaleras arriba';

UPDATE words_es SET rules_help = 'DE TRAP AF (lopen) = bajar la escalera; el patrón es VAN + [objeto] + AF:
• van de trap af lopen · van je fiets af stappen (bajarse de).
Con er: ervanaf stappen. AF indica que te separas/bajas del objeto.
También: naar beneden gaan = bajar (en casa).
Figurado útil: ergens vanaf zijn = haberse librado de algo (Daar ben ik mooi vanaf!).' WHERE text = 'escaleras abajo';

UPDATE words_es SET rules_help = 'LINKSAF (slaan/gaan) = girar a la izquierda.
El AF viene de AFSLAAN (desviarse de tu dirección): bij de kruising afslaan.
• Bij het stoplicht ga je linksaf. — En el semáforo, a la izquierda.
Posición estática: LINKS (a la izquierda) · movimiento de giro: LINKSAF.
De afslag = el desvío/la salida (también de la autopista).' WHERE text = 'girar a la izquierda';

UPDATE words_es SET rules_help = 'RECHTSAF (slaan/gaan) = girar a la derecha.
• Na de brug rechtsaf. — Después del puente, a la derecha.
Ojo: rechTSaf (derecha) vs rechTdoor (recto) — se confunden al oído.
Posición estática: RECHTS · giro: RECHTSAF.
En bici (país de bicis): rechtsaf slaan bij het fietspad — girar por el carril bici.' WHERE text = 'girar a la derecha';

UPDATE words_es SET rules_help = 'VOORUIT = hacia delante (movimiento o mirada).
Figurado clave: VOORUITGAAN = mejorar, progresar:
• Je Nederlands gaat vooruit! — ¡Tu neerlandés mejora!
Como interjección: Vooruit! = ¡venga, va! (animar o ceder: vooruit dan maar...).
Pareja figurada: achteruitgaan = empeorar. vooruit denken = pensar con antelación.' WHERE text = 'hacia delante';

UPDATE words_es SET rules_help = 'ACHTERUIT = hacia atrás (marcha atrás incluida).
• achteruit rijden/inparkeren — dar marcha atrás/aparcar en batería hacia atrás.
• een stapje achteruit — un pasito atrás.
Figurado: ACHTERUITGAAN = empeorar (salud, negocio, vista...):
Zijn gezondheid gaat achteruit. Mirar atrás (girarse) es ACHTEROM kijken.' WHERE text = 'hacia atrás';

UPDATE words_es SET rules_help = 'VOORLANGS = bordeando por delante de algo.
Familia -LANGS (bordear): VOORLANGS (por delante) · ACHTERLANGS (por detrás) ·
BOVENLANGS (por arriba) · ONDERLANGS (por abajo).
LANGS a secas = pasar junto a: Ik loop langs de winkel.
Ojo: langskomen = pasarse de visita (Kom eens langs! — ¡pásate!).' WHERE text = 'por delante (bordeando)';

UPDATE words_es SET rules_help = 'ACHTERLANGS = bordeando por detrás de algo.
• achterlangs binnenkomen — entrar por detrás (por el jardín/puerta trasera).
• De inbreker ontsnapte achterlangs. — Escapó por la parte de atrás.
Figurado coloquial: iets achterlangs regelen = arreglar algo por detrás (sin que se sepa).
Pareja: voorlangs (por delante).' WHERE text = 'por detrás (bordeando)';

UPDATE words_es SET rules_help = 'BOVENLANGS = tomando la ruta de arriba (bordeando por lo alto).
Típico en rutas de senderismo/ciclismo: over de toppen bovenlangs, door het dal onderlangs.
• Gaan we bovenlangs of onderlangs? — ¿Por arriba o por abajo?
No confundir con OVERHEEN (pasar por encima de UN obstáculo):
bovenlangs es la RUTA alta completa.' WHERE text = 'por la ruta de arriba';

UPDATE words_es SET rules_help = 'ONDERLANGS = tomando la ruta de abajo (bordeando por lo bajo).
• het pad onderlangs, door het dal — el sendero de abajo, por el valle.
No confundir con ONDERDOOR (pasar por debajo de UN obstáculo puntual):
onderdoor = cruzar bajo el puente · onderlangs = toda la ruta baja.
Pareja: bovenlangs.' WHERE text = 'por la ruta de abajo';

UPDATE words_es SET rules_help = 'HET TUSSENDOORTJE = el tentempié/snack: lo que comes TUSSENDOOR (entre horas).
Palabra cotidiana total (colegios, oficinas, súper: pasillo de tussendoortjes).
• een gezond tussendoortje — un tentempié sano.
Formación típica neerlandesa: adverbio + -tje = sustantivo diminutivo
(igual que uitje = excursioncita, de uit). El diminutivo lo hace het-woord: HET tussendoortje.' WHERE text = 'el tentempié';
