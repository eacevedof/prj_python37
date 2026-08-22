-- Learn Languages App - Grupo "palabras dificiles - moeilijke woorden" (13 tarjetas)
-- Migration: 20260822000001-create-hard-words-group.sql
-- Description: el cajon de palabras que se le resisten a Eduardo. Lo pidio el 2026-08-20 con
--   doce palabras (zodra · tenslotte · tenzij · uitzetten · vooraanstaande · nogmaals ·
--   bijstaan · afvallen · afschrikking · verbergen · bespeuren · benaderen), cambio de tema
--   antes de que se escribiera la migracion, y el 2026-08-22 pidio meter verwijderen: se crea
--   el grupo con las trece.
--   Formato que pidio: la palabra, su significado y CINCO ejemplos de habla cotidiana
--   alternando tiempos y pronombres. Los cinco van en TABLA dentro de la ayuda —con una
--   columna que dice el tiempo y la persona de cada uno, para que se vea la alternancia— y
--   ademas en words_lang.notes, que es lo que pinta el slider al final de cada tarjeta.
--   Cada tarjeta lleva tambien el mapa de sus rivales (que es donde estan casi todas las
--   trampas: tenslotte/ten slotte, afvallen con zijn y sus cuatro sentidos, afschrikken vs
--   schrikken, verwijderen vs wissen vs schrappen, benaderen vs naderen...), la formula de
--   construccion y un ejercicio.
--   Comprobado antes: ninguna de las trece estaba en la BD (uitzetten y nogmaals solo se
--   mencionaban de pasada en la ayuda de otras tarjetas).
--   100% aditiva e IDEMPOTENTE (INSERT ... WHERE NOT EXISTS / OR IGNORE).
--   Generada por script y escrita fuera de migrations/, movida ya terminada.

PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'palabras dificiles - moeilijke woorden',
    'Cajon de palabras que se resisten a la memoria. Cada tarjeta trae el significado, el mapa de los verbos o adverbios con los que compite, la trampa tipica y cinco ejemplos de habla cotidiana alternando tiempo y persona (en tabla dentro de la ayuda y tambien como ejemplos del slider). Grupo abierto: se le van anadiendo palabras segun se atraganten',
    'migracion'
);

-- ==============================================================================
-- 01) zodra = en cuanto, tan pronto como
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'en cuanto, tan pronto como', 'WORD', 'dificil: zodra (en cuanto, tan pronto como)', 'zodra = en cuanto, tan pronto como. Es conjunción SUBORDINANTE: manda el verbo al final de su propia frase.
🗺️ Los rivales de «cuando»:
• zodra = en cuanto: el momento justo en que pasa A empieza B. Subordinante.
• als = cuando, y también si. Para el presente, el futuro y lo repetido.
• wanneer = cuándo (en pregunta) y cuando (formal o escrito).
• toen = cuando, pero solo para un momento ÚNICO del pasado.
• nadat = después de que: A termina y luego empieza B; suele pedir perfecto.
• meteen, direct = enseguida. Son adverbios, no conjunciones: no mandan el verbo al final.

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandés | español |
|---|---|---|
| presente · ik | Zodra ik thuis ben, bel ik je. | En cuanto llegue a casa, te llamo. |
| imperfecto · hij | Zodra hij klaar was, ging hij naar buiten. | En cuanto terminó, salió. |
| imperativo · je | Bel me zodra je iets weet. | Llámame en cuanto sepas algo. |
| perfecto · we | Zodra we het pakket hebben ontvangen, sturen we een mail. | En cuanto recibamos el paquete, mandamos un correo. |
| imperfecto · ze | Ze ging weg zodra het begon te regenen. | Se marchó en cuanto empezó a llover. |

📐 Estructura: Zodra + sujeto + resto + VERBO (final), coma, y la principal con inversión: verbo + sujeto.

⚠️ El verbo se va al FINAL: «Zodra ik thuis ben», nunca «Zodra ik ben thuis».

⚠️ Lo que en español es subjuntivo, aquí es PRESENTE: Zodra ik het weet, bel ik je (en cuanto lo sepa, te llamo). El neerlandés no tiene subjuntivo.

🏋️ Ejercicio: «en cuanto llegue, te aviso» → ___ ik aankom, laat ik het je weten. (Respuesta: Zodra.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'en cuanto, tan pronto como' AND notes = 'dificil: zodra (en cuanto, tan pronto como)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'en cuanto, tan pronto como' AND notes = 'dificil: zodra (en cuanto, tan pronto como)' LIMIT 1),
    'nl_NL', 'zodra', 'sodra',
    '• [inv.] Zodra ik thuis ben, bel ik je. — En cuanto llegue a casa, te llamo.
• [inv.] Zodra hij klaar was, ging hij naar buiten. — En cuanto terminó, salió.
• [geb.] Bel me zodra je iets weet. — Llámame en cuanto sepas algo.
• [inv.] Zodra we het pakket hebben ontvangen, sturen we een mail. — En cuanto recibamos el paquete, mandamos un correo.
• [can.] Ze ging weg zodra het begon te regenen. — Se marchó en cuanto empezó a llover.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'en cuanto, tan pronto como' AND notes = 'dificil: zodra (en cuanto, tan pronto como)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'en cuanto, tan pronto como' AND notes = 'dificil: zodra (en cuanto, tan pronto como)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 02) tenslotte = al fin y al cabo
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'al fin y al cabo', 'WORD', 'dificil: tenslotte (al fin y al cabo)', 'tenslotte, todo junto = al fin y al cabo, después de todo: introduce la razón que lo explica todo. Separado, ten slotte = por último, para terminar.
🗺️ La familia del «al final»:
• tenslotte = al fin y al cabo (da la razón). Sinónimos: immers, per slot van rekening.
• ten slotte = por último, en último lugar (marca el orden). Sinónimos: tot slot, als laatste.
• uiteindelijk = al final, finalmente: el resultado después de un proceso.
• eindelijk = por fin, con alivio, porque se hizo esperar.
• op het laatst = al final del todo, en el último momento.

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandés | español |
|---|---|---|
| presente · hij | Hij is tenslotte nog maar een kind. | Al fin y al cabo no es más que un niño. |
| presente · we | Je hoeft je niet te schamen; we maken tenslotte allemaal fouten. | No tienes por qué avergonzarte; al fin y al cabo todos cometemos errores. |
| imperfecto · het | Tenslotte was het jouw idee, niet het mijne. | Al fin y al cabo fue idea tuya, no mía. |
| presente · ik | Ten slotte wil ik iedereen bedanken voor de hulp. | Por último, quiero daros las gracias por la ayuda. |
| perfecto · we | We hebben lang gewacht, maar ten slotte kwam de bus. | Esperamos mucho, pero al final vino el autobús. |

📐 Estructura: es un adverbio. Si abre la frase, inversión — Tenslotte was het jouw idee.

⚠️ La grafía cambia el significado: junto es «al fin y al cabo», separado es «por último». Mucha gente los mezcla al escribir, pero no son lo mismo.

⚠️ No confundas uiteindelijk (al final, el resultado) con eindelijk (por fin, el alivio): Uiteindelijk kwam hij niet · Eindelijk ben je er!

🏋️ Ejercicio: «por último quiero dar las gracias a todos» → ___ ___ wil ik iedereen bedanken. (Respuesta: Ten slotte, separado.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'al fin y al cabo' AND notes = 'dificil: tenslotte (al fin y al cabo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'al fin y al cabo' AND notes = 'dificil: tenslotte (al fin y al cabo)' LIMIT 1),
    'nl_NL', 'tenslotte', 'tenslotte',
    '• [can.] Hij is tenslotte nog maar een kind. — Al fin y al cabo no es más que un niño.
• [can.] Je hoeft je niet te schamen; we maken tenslotte allemaal fouten. — No tienes por qué avergonzarte; al fin y al cabo todos cometemos errores.
• [inv.] Tenslotte was het jouw idee, niet het mijne. — Al fin y al cabo fue idea tuya, no mía.
• [inv.] Ten slotte wil ik iedereen bedanken voor de hulp. — Por último, quiero daros las gracias por la ayuda.
• [perf.] We hebben lang gewacht, maar ten slotte kwam de bus. — Esperamos mucho, pero al final vino el autobús.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'al fin y al cabo' AND notes = 'dificil: tenslotte (al fin y al cabo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'al fin y al cabo' AND notes = 'dificil: tenslotte (al fin y al cabo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 03) tenzij = a menos que
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'a menos que', 'WORD', 'dificil: tenzij (a menos que)', 'tenzij = a menos que, salvo que. Subordinante, con el verbo al final. Y ojo: el neerlandés lo dice en INDICATIVO, donde el español pide subjuntivo.
🗺️ Cómo poner una condición:
• tenzij = a menos que: la única excepción que impediría lo dicho.
• als ... niet = si no...
• behalve als = excepto si.
• mits = siempre que, con tal de que. Condición en POSITIVO.
• op voorwaarde dat = a condición de que (formal).

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandés | español |
|---|---|---|
| presente · ik | Ik kom morgen, tenzij het regent. | Voy mañana, a menos que llueva. |
| presente · jij | We gaan door, tenzij jij iets anders wilt. | Seguimos, a menos que tú quieras otra cosa. |
| perfecto · er | Hij belt nooit, tenzij er iets ergs is gebeurd. | No llama nunca, salvo que haya pasado algo grave. |
| presente · je | Tenzij je een beter idee hebt, doen we het zo. | A menos que tengas una idea mejor, lo hacemos así. |
| imperfecto · ze | Vroeger ging ze nooit naar buiten, tenzij de zon scheen. | Antes no salía nunca, a menos que hiciera sol. |

📐 Estructura: frase principal + tenzij + sujeto + resto + VERBO al final.

⚠️ tenzij YA es negativo: no le añadas niet. «Ik kom, tenzij het niet regent» dice justo lo contrario de lo que quieres.

⚠️ Nada de subjuntivo, que en neerlandés no existe: tenzij het regent, no «tenzij het zou regenen».

🏋️ Ejercicio: «voy mañana, a menos que llueva» → Ik kom morgen, ___ het regent. (Respuesta: tenzij.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'a menos que' AND notes = 'dificil: tenzij (a menos que)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'a menos que' AND notes = 'dificil: tenzij (a menos que)' LIMIT 1),
    'nl_NL', 'tenzij', 'tensei',
    '• [can.] Ik kom morgen, tenzij het regent. — Voy mañana, a menos que llueva.
• [can.] We gaan door, tenzij jij iets anders wilt. — Seguimos, a menos que tú quieras otra cosa.
• [perf.] Hij belt nooit, tenzij er iets ergs is gebeurd. — No llama nunca, salvo que haya pasado algo grave.
• [inv.] Tenzij je een beter idee hebt, doen we het zo. — A menos que tengas una idea mejor, lo hacemos así.
• [can.] Vroeger ging ze nooit naar buiten, tenzij de zon scheen. — Antes no salía nunca, a menos que hiciera sol.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a menos que' AND notes = 'dificil: tenzij (a menos que)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a menos que' AND notes = 'dificil: tenzij (a menos que)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 04) uitzetten = apagar
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'apagar', 'WORD', 'dificil: uitzetten (apagar)', 'uitzetten = apagar, desconectar. Separable: zet … uit. Perfecto con hebben: heeft uitgezet.
🗺️ Encender, apagar y sus vecinos:
• aanzetten y aandoen = encender ↔ uitzetten y uitdoen = apagar.
• uitdoen tira más a la luz y a la ropa; uitzetten, a los aparatos.
• uitschakelen = desconectar, en registro técnico o formal.
• afzetten = quitar el motor, la radio o el despertador.
• uitgaan = apagarse solo, sin que nadie lo haga: het licht gaat uit.
• stopzetten = detener un proceso o una máquina.

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandés | español |
|---|---|---|
| imperativo · je | Zet je telefoon even uit. | Apaga el móvil un momento. |
| perfecto · ik | Ik heb de verwarming uitgezet, want het is warm. | He apagado la calefacción, hace calor. |
| imperfecto · hij | Hij zette de motor uit en stapte uit. | Apagó el motor y se bajó. |
| te + separable | Vergeet niet de wekker uit te zetten. | No te olvides de apagar el despertador. |
| presente · otro sentido | Bij warmte zet metaal uit. | Con el calor el metal se dilata. |

📐 Estructura: sujeto + zet (2ª posición) + objeto + uit, al final del todo.

⚠️ uitzetten tiene más vidas: dilatarse (metaal zet uit), expulsar de un país (iemand het land uitzetten) y encargar una tarea (een taak uitzetten bij iemand).

⚠️ Con te, el separable se parte en tres: vergeet niet de wekker uit te zetten.

🏋️ Ejercicio: «apaga la tele» → ___ de tv ___. (Respuesta: Zet … uit.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'apagar' AND notes = 'dificil: uitzetten (apagar)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'apagar' AND notes = 'dificil: uitzetten (apagar)' LIMIT 1),
    'nl_NL', 'uitzetten', 'autsetten',
    '• [geb.] Zet je telefoon even uit. — Apaga el móvil un momento.
• [perf.] Ik heb de verwarming uitgezet, want het is warm. — He apagado la calefacción, hace calor.
• [can.] Hij zette de motor uit en stapte uit. — Apagó el motor y se bajó.
• [uitdr.] Vergeet niet de wekker uit te zetten. — No te olvides de apagar el despertador.
• [inv.] Bij warmte zet metaal uit. — Con el calor el metal se dilata.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'apagar' AND notes = 'dificil: uitzetten (apagar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'apagar' AND notes = 'dificil: uitzetten (apagar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 05) vooraanstaande = destacado, de primera fila
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'destacado, de primera fila', 'WORD', 'dificil: vooraanstaande (destacado, de primera fila)', 'vooraanstaand = destacado, prominente, de primer nivel. Literalmente «que está delante». Es palabra de periódico y de discurso, no de conversación.
🗺️ Vecinos de «destacado»:
• vooraanstaand = destacado, de primera fila (personas e instituciones).
• toonaangevend = que marca la pauta, referente del sector.
• prominent = prominente, muy visible.
• gerenommeerd = de renombre · bekend = conocido, sin más.
• leidinggevend = directivo, con gente a su cargo.
• Ojo: voorstaan es otro verbo, defender una idea, y no tiene que ver.

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandés | español |
|---|---|---|
| presente · hij | Hij is een vooraanstaande advocaat in Amsterdam. | Es un abogado destacado en Ámsterdam. |
| pasiva imperfecto · ze | Ze werd geciteerd door verschillende vooraanstaande kranten. | La citaron varios periódicos importantes. |
| imperfecto · plural | Op het congres spraken vooraanstaande wetenschappers uit heel Europa. | En el congreso hablaron científicos destacados de toda Europa. |
| het-woord, sin -e | Het gaat om een vooraanstaand bedrijf in de sector. | Se trata de una empresa destacada del sector. |
| imperfecto · haar vader | Haar vader was vroeger een vooraanstaande politicus. | Su padre fue un político destacado. |

📐 Estructura: artículo + vooraanstaand(e) + sustantivo.

⚠️ La -e es la flexión del adjetivo: een vooraanstaande advocaat (de-woord) pero een vooraanstaand bedrijf (het-woord con een). Con artículo definido siempre -e: het vooraanstaande bedrijf.

⚠️ Casi solo se usa DELANTE del sustantivo. De predicado suena raro: «Hij is vooraanstaand» ✗ → Hij is een vooraanstaande arts.

🏋️ Ejercicio: «una empresa destacada» (bedrijf es het-woord) → een ___ bedrijf. (Respuesta: vooraanstaand, sin -e.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'destacado, de primera fila' AND notes = 'dificil: vooraanstaande (destacado, de primera fila)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'destacado, de primera fila' AND notes = 'dificil: vooraanstaande (destacado, de primera fila)' LIMIT 1),
    'nl_NL', 'vooraanstaande', 'foranstande',
    '• [can.] Hij is een vooraanstaande advocaat in Amsterdam. — Es un abogado destacado en Ámsterdam.
• [can.] Ze werd geciteerd door verschillende vooraanstaande kranten. — La citaron varios periódicos importantes.
• [inv.] Op het congres spraken vooraanstaande wetenschappers uit heel Europa. — En el congreso hablaron científicos destacados de toda Europa.
• [can.] Het gaat om een vooraanstaand bedrijf in de sector. — Se trata de una empresa destacada del sector.
• [can.] Haar vader was vroeger een vooraanstaande politicus. — Su padre fue un político destacado.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'destacado, de primera fila' AND notes = 'dificil: vooraanstaande (destacado, de primera fila)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'destacado, de primera fila' AND notes = 'dificil: vooraanstaande (destacado, de primera fila)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 06) nogmaals = una vez más, de nuevo
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'una vez más, de nuevo', 'WORD', 'dificil: nogmaals (una vez más, de nuevo)', 'nogmaals = una vez más, de nuevo. Es el «otra vez» cortés: vive en los agradecimientos y en las disculpas.
🗺️ Las maneras de decir «otra vez»:
• nog een keer = una vez más. Lo neutro y lo coloquial.
• nogmaals = una vez más, en tono cortés: al dar las gracias o al disculparse.
• opnieuw = de nuevo, empezando otra vez desde el principio.
• weer = otra vez. Lo más común al hablar.
• alweer = otra vez ya, con fastidio o sorpresa.
• wederom = de nuevo, muy formal y escrito.
• herhalen = repetir, que es el verbo.

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandés | español |
|---|---|---|
| fórmula fija | Nogmaals bedankt voor je hulp. | Gracias otra vez por tu ayuda. |
| presente · je | Sorry, kun je dat nogmaals zeggen? | Perdona, ¿puedes decirlo una vez más? |
| perfecto · ik | Ik heb het nogmaals geprobeerd, maar het lukte niet. | Lo he intentado una vez más, pero no salió. |
| imperfecto · hij | Hij legde het nogmaals uit, rustig en langzaam. | Lo explicó otra vez, con calma y despacio. |
| fórmula fija | Nogmaals mijn excuses voor het late antwoord. | De nuevo, mis disculpas por responder tarde. |

📐 Estructura: adverbio. Puede abrir la frase (con inversión) o ir junto al verbo.

⚠️ No lo confundas con nog maar, separado, que significa «solo, no más que»: Hij is nog maar een kind (no es más que un niño).

⚠️ nogmaals no lleva artículo ni preposición: Nogmaals bedankt, nunca «een nogmaals».

🏋️ Ejercicio: «gracias otra vez por tu ayuda» → ___ bedankt voor je hulp. (Respuesta: Nogmaals.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'una vez más, de nuevo' AND notes = 'dificil: nogmaals (una vez más, de nuevo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'una vez más, de nuevo' AND notes = 'dificil: nogmaals (una vez más, de nuevo)' LIMIT 1),
    'nl_NL', 'nogmaals', 'nojmals',
    '• [uitdr.] Nogmaals bedankt voor je hulp. — Gracias otra vez por tu ayuda.
• [vraag] Sorry, kun je dat nogmaals zeggen? — Perdona, ¿puedes decirlo una vez más?
• [perf.] Ik heb het nogmaals geprobeerd, maar het lukte niet. — Lo he intentado una vez más, pero no salió.
• [can.] Hij legde het nogmaals uit, rustig en langzaam. — Lo explicó otra vez, con calma y despacio.
• [uitdr.] Nogmaals mijn excuses voor het late antwoord. — De nuevo, mis disculpas por responder tarde.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'una vez más, de nuevo' AND notes = 'dificil: nogmaals (una vez más, de nuevo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'una vez más, de nuevo' AND notes = 'dificil: nogmaals (una vez más, de nuevo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 07) bijstaan = asistir, apoyar a alguien
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'asistir, apoyar a alguien', 'WORD', 'dificil: bijstaan (asistir, apoyar a alguien)', 'bijstaan = asistir, estar al lado de alguien en un momento difícil. Separable: staat … bij. El objeto es la PERSONA, directo y sin preposición.
🗺️ Las maneras de arrimar el hombro:
• helpen = ayudar, lo general.
• bijstaan = asistir, arropar: jurídico, médico o personal.
• steunen = apoyar, moral o económicamente.
• bijspringen = echar un cable puntual, sacar de un apuro.
• ondersteunen = respaldar, en registro técnico o institucional.
• verdedigen = defender.

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandés | español |
|---|---|---|
| futuro · je | Een advocaat zal je bijstaan tijdens de rechtszaak. | Un abogado te asistirá durante el juicio. |
| perfecto · mijn buren | Mijn buren hebben me bijgestaan toen ik ziek was. | Mis vecinos me arroparon cuando estuve enfermo. |
| presente · ik | Ik sta je bij, wat er ook gebeurt. | Estoy a tu lado, pase lo que pase. |
| expresión · het | Het staat me bij dat we elkaar al eens hebben ontmoet. | Me suena que ya nos conocemos de algo. |
| imperfecto · ze | Ze stond haar moeder bij tot het einde. | Estuvo al lado de su madre hasta el final. |

📐 Estructura: sujeto + staat (2ª posición) + objeto persona + resto + bij, al final.

⚠️ Expresión que despista y se oye mucho: «Het staat me bij dat…» = me suena que…, creo recordar que… No tiene nada que ver con ayudar.

⚠️ de bijstand es la ayuda social del Estado: in de bijstand zitten = cobrar el subsidio.

🏋️ Ejercicio: «me asistió un abogado» → Een advocaat heeft me ___. (Respuesta: bijgestaan.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'asistir, apoyar a alguien' AND notes = 'dificil: bijstaan (asistir, apoyar a alguien)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'asistir, apoyar a alguien' AND notes = 'dificil: bijstaan (asistir, apoyar a alguien)' LIMIT 1),
    'nl_NL', 'bijstaan', 'beistan',
    '• [can.] Een advocaat zal je bijstaan tijdens de rechtszaak. — Un abogado te asistirá durante el juicio.
• [perf.] Mijn buren hebben me bijgestaan toen ik ziek was. — Mis vecinos me arroparon cuando estuve enfermo.
• [can.] Ik sta je bij, wat er ook gebeurt. — Estoy a tu lado, pase lo que pase.
• [uitdr.] Het staat me bij dat we elkaar al eens hebben ontmoet. — Me suena que ya nos conocemos de algo.
• [can.] Ze stond haar moeder bij tot het einde. — Estuvo al lado de su madre hasta el final.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'asistir, apoyar a alguien' AND notes = 'dificil: bijstaan (asistir, apoyar a alguien)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'asistir, apoyar a alguien' AND notes = 'dificil: bijstaan (asistir, apoyar a alguien)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 08) afvallen = adelgazar
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'adelgazar', 'WORD', 'dificil: afvallen (adelgazar)', 'afvallen = adelgazar. Separable y con ZIJN en el perfecto: ik ben afgevallen. Pero tiene tres vidas más, y por eso confunde.
🗺️ Los cuatro afvallen:
• adelgazar: Ik ben vijf kilo afgevallen ↔ aankomen = engordar.
• caerse, desprenderse: In de herfst vallen de bladeren af.
• quedar eliminado: Twee kandidaten vielen af. De ahí de afvaller, el eliminado.
• iemand afvallen = desautorizar a alguien, dejarlo tirado ↔ iemand bijvallen = darle la razón.

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandés | español |
|---|---|---|
| perfecto · ik | Ik ben vijf kilo afgevallen. | He adelgazado cinco kilos. |
| presente · ze | Ze wil afvallen voor de zomer. | Quiere adelgazar para el verano. |
| presente · plural | In de herfst vallen alle bladeren af. | En otoño se caen todas las hojas. |
| imperfecto · plural | Twee kandidaten vielen af na de eerste ronde. | Dos candidatos quedaron eliminados tras la primera ronda. |
| imperativo · figurado | Val me nou niet af waar iedereen bij is. | No me dejes tirado delante de todo el mundo. |

📐 Estructura: sujeto + val (2ª posición) + resto + af, al final. Perfecto: ben + afgevallen.

⚠️ Auxiliar ZIJN, siempre: «Ik heb afgevallen» ✗ → Ik ben afgevallen.

⚠️ No lo mezcles con het afval, que es la BASURA. Se parecen al escribirlos y no tienen nada que ver.

🏋️ Ejercicio: «he adelgazado tres kilos» → Ik ___ drie kilo ___. (Respuesta: ben … afgevallen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'adelgazar' AND notes = 'dificil: afvallen (adelgazar)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'adelgazar' AND notes = 'dificil: afvallen (adelgazar)' LIMIT 1),
    'nl_NL', 'afvallen', 'affallen',
    '• [perf.] Ik ben vijf kilo afgevallen. — He adelgazado cinco kilos.
• [can.] Ze wil afvallen voor de zomer. — Quiere adelgazar para el verano.
• [inv.] In de herfst vallen alle bladeren af. — En otoño se caen todas las hojas.
• [can.] Twee kandidaten vielen af na de eerste ronde. — Dos candidatos quedaron eliminados tras la primera ronda.
• [geb.] Val me nou niet af waar iedereen bij is. — No me dejes tirado delante de todo el mundo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'adelgazar' AND notes = 'dificil: afvallen (adelgazar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'adelgazar' AND notes = 'dificil: afvallen (adelgazar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 09) afschrikking = la disuasión
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la disuasión', 'WORD', 'dificil: afschrikking (la disuasión)', 'de afschrikking = la disuasión: asustar para que algo no llegue a pasar. Del verbo afschrikken, disuadir o espantar.
🗺️ La familia del susto:
• afschrikken = disuadir, echar para atrás. Transitivo: asusta A alguien.
• schrikken = asustarse uno mismo. Intransitivo y con zijn: ik ben geschrokken.
• afschrikwekkend, afschrikkend = disuasorio, que echa para atrás.
• ter afschrikking = a modo de disuasión. Fórmula fija.
• ontmoedigen = desanimar · waarschuwen = advertir · de preventie = la prevención.

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandés | español |
|---|---|---|
| presente · plural | Kernwapens dienen vooral als afschrikking. | Las armas nucleares sirven sobre todo como disuasión. |
| presente · de boetes | De hoge boetes werken als afschrikking. | Las multas altas funcionan como disuasión. |
| presente · er | Ter afschrikking hangt er een camera bij de ingang. | A modo de disuasión hay una cámara en la entrada. |
| perfecto · de actie | Volgens de politie heeft de actie een afschrikkende werking gehad. | Según la policía la acción ha tenido un efecto disuasorio. |
| imperfecto · men | Vroeger dacht men dat zware straffen de beste afschrikking waren. | Antes se creía que las penas duras eran la mejor disuasión. |

📐 Estructura: de + afschrikking. Como sustantivo va con als o con ter: als afschrikking, ter afschrikking.

⚠️ afschrikken y schrikken no se intercambian: el primero lo haces tú a otro, el segundo te pasa a ti.

⚠️ Es palabra de informe y de periódico. Al hablar se dice más «Dat schrikt af».

🏋️ Ejercicio: «las multas altas disuaden» → Hoge boetes ___ ___. (Respuesta: schrikken af.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la disuasión' AND notes = 'dificil: afschrikking (la disuasión)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la disuasión' AND notes = 'dificil: afschrikking (la disuasión)' LIMIT 1),
    'nl_NL', 'afschrikking', 'afsjrikkinj',
    '• [can.] Kernwapens dienen vooral als afschrikking. — Las armas nucleares sirven sobre todo como disuasión.
• [can.] De hoge boetes werken als afschrikking. — Las multas altas funcionan como disuasión.
• [inv.] Ter afschrikking hangt er een camera bij de ingang. — A modo de disuasión hay una cámara en la entrada.
• [perf.] Volgens de politie heeft de actie een afschrikkende werking gehad. — Según la policía la acción ha tenido un efecto disuasorio.
• [can.] Vroeger dacht men dat zware straffen de beste afschrikking waren. — Antes se creía que las penas duras eran la mejor disuasión.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la disuasión' AND notes = 'dificil: afschrikking (la disuasión)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la disuasión' AND notes = 'dificil: afschrikking (la disuasión)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 10) verbergen = ocultar, esconder
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ocultar, esconder', 'WORD', 'dificil: verbergen (ocultar, esconder)', 'verbergen = ocultar, esconder, sobre todo sentimientos e información. Verbo fuerte: verbergen – verborg – heeft verborgen. Reflexivo, zich verbergen = esconderse.
🗺️ Esconder, según qué escondas y de quién:

| qué escondes | verbo | ejemplo |
|---|---|---|
| una cosa, en el día a día | **verstoppen** | Ik heb de sleutel **verstopt**. |
| una cosa o un sentimiento, más formal | **verbergen** | Hij **verbergt** zijn gevoelens. |
| algo que sabes, callándotelo | **verzwijgen** | Hij **verzweeg** de waarheid. |
| información, reteniéndola aposta | **achterhouden** | Ze **houden** documenten **achter**. |
| algo, metiéndolo de cualquier manera | **wegstoppen** | Ze **stopt** haar verdriet **weg**. |
| la verdad, disfrazándola con palabras | **verhullen** | **verhullende** taal |
| tú mismo, de la lluvia | **schuilen** | We **schuilen** onder een boom. |
| tú mismo, de quien te busca | **zich schuilhouden** | De dader **houdt zich schuil**. |
| tú mismo, pasando a la clandestinidad | **onderduiken** | In de oorlog moesten ze **onderduiken**. |

Los tres que vas a usar de verdad: verstoppen para las cosas, verbergen para lo que sientes y verzwijgen para lo que no cuentas.

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandés | español |
|---|---|---|
| presente · hij | Hij verbergt zijn gevoelens voor iedereen. | Esconde sus sentimientos ante todos. |
| fórmula · ik | Ik heb niets te verbergen. | No tengo nada que ocultar. |
| imperfecto reflexivo · het kind | Het kind verborg zich achter de bank. | El niño se escondió detrás del sofá. |
| perfecto · we | We hebben de cadeaus in de kast verborgen. | Hemos escondido los regalos en el armario. |
| presente · je | Waarom verberg je dat voor mij? | ¿Por qué me ocultas eso? |

📐 Estructura: sujeto + verbergt + objeto + voor + persona (a quien se lo ocultas).

⚠️ El participio no lleva ge-: ver- es prefijo átono inseparable → verborgen, nunca «geverbergd».

⚠️ verborgen también funciona de adjetivo: een verborgen gebrek (un defecto oculto), een verborgen camera.

⚠️ Trampa gorda de verstoppen. Además de esconder, significa ATASCAR: de afvoer is verstopt (el desagüe está atascado) y ik ben verstopt o ik zit verstopt (tengo la nariz taponada). Por el contexto se distingue, pero la primera vez descoloca.

🕳️ onderduiken es palabra con historia: pasar a la clandestinidad. En Países Bajos suena directamente a la guerra y a los onderduikers escondidos, como Ana Frank. No la uses para el escondite de un juego.

🤫 Y para el «a escondidas»: stiekem (a la chita callando, lo coloquial) · heimelijk (formal) · in het geheim (en secreto) · iets onder de pet houden (mantenerlo callado, muy coloquial).

🏋️ Ejercicio: «no tengo nada que ocultar» → Ik heb niets te ___. (Respuesta: verbergen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ocultar, esconder' AND notes = 'dificil: verbergen (ocultar, esconder)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ocultar, esconder' AND notes = 'dificil: verbergen (ocultar, esconder)' LIMIT 1),
    'nl_NL', 'verbergen', 'ferberjen',
    '• [can.] Hij verbergt zijn gevoelens voor iedereen. — Esconde sus sentimientos ante todos.
• [uitdr.] Ik heb niets te verbergen. — No tengo nada que ocultar.
• [can.] Het kind verborg zich achter de bank. — El niño se escondió detrás del sofá.
• [perf.] We hebben de cadeaus in de kast verborgen. — Hemos escondido los regalos en el armario.
• [vraag] Waarom verberg je dat voor mij? — ¿Por qué me ocultas eso?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ocultar, esconder' AND notes = 'dificil: verbergen (ocultar, esconder)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ocultar, esconder' AND notes = 'dificil: verbergen (ocultar, esconder)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 11) bespeuren = percibir, detectar
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'percibir, detectar', 'WORD', 'dificil: bespeuren (percibir, detectar)', 'bespeuren = percibir, detectar un indicio de algo. Es de registro escrito, y se usa muchísimo en negativo: geen … te bespeuren = ni rastro de.
🗺️ Del notar al observar:
• merken = notar. El normal del habla, el que dirías tú.
• bespeuren = percibir un indicio sutil. Escrito o literario.
• opmerken = advertir, fijarse, y también comentar.
• waarnemen = observar, en registro técnico.
• ontdekken = descubrir · signaleren = detectar, formal.
• Familia: speuren = rastrear · de speurhond = el perro rastreador · het spoor = el rastro.

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandés | español |
|---|---|---|
| imperfecto · er | Er was geen enkele beweging te bespeuren. | No se percibía ni un solo movimiento. |
| imperfecto · ik | Ik bespeurde twijfel in zijn stem. | Percibí duda en su voz. |
| imperfecto · van… | Van enthousiasme was weinig te bespeuren. | De entusiasmo había poco rastro. |
| presente · de hond | De hond bespeurt gevaar eerder dan wij. | El perro detecta el peligro antes que nosotros. |
| perfecto · ze | Ze heeft nooit enige spijt bij hem bespeurd. | Nunca ha percibido en él ningún arrepentimiento. |

📐 Estructura: muy frecuente con er … te bespeuren — Er was niets te bespeuren.

⚠️ Participio sin ge-: be- es prefijo inseparable → bespeurd.

⚠️ Al hablar, di merken. Soltar bespeuren en una conversación suena a documental doblado.

🏋️ Ejercicio: «no se percibía ni un movimiento» → Er was geen beweging te ___. (Respuesta: bespeuren.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'percibir, detectar' AND notes = 'dificil: bespeuren (percibir, detectar)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'percibir, detectar' AND notes = 'dificil: bespeuren (percibir, detectar)' LIMIT 1),
    'nl_NL', 'bespeuren', 'besperen',
    '• [can.] Er was geen enkele beweging te bespeuren. — No se percibía ni un solo movimiento.
• [can.] Ik bespeurde twijfel in zijn stem. — Percibí duda en su voz.
• [inv.] Van enthousiasme was weinig te bespeuren. — De entusiasmo había poco rastro.
• [can.] De hond bespeurt gevaar eerder dan wij. — El perro detecta el peligro antes que nosotros.
• [perf.] Ze heeft nooit enige spijt bij hem bespeurd. — Nunca ha percibido en él ningún arrepentimiento.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'percibir, detectar' AND notes = 'dificil: bespeuren (percibir, detectar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'percibir, detectar' AND notes = 'dificil: bespeuren (percibir, detectar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 12) benaderen = abordar, contactar
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'abordar, contactar', 'WORD', 'dificil: benaderen (abordar, contactar)', 'benaderen = acercarse a algo o a alguien con una intención: contactar, tantear, abordar. También enfocar un problema y aproximar una cifra. Participio sin ge-: benaderd.
🗺️ Acercarse, según para qué:
• contact opnemen met = ponerse en contacto. Lo neutro.
• benaderen = abordar o tantear a alguien; y enfocar un asunto.
• aanspreken = dirigirse a alguien en persona, allí mismo.
• naderen = acercarse en el espacio o en el tiempo: de trein nadert. Sin persona de por medio.
• aanpakken = abordar un problema, ponerse con ello.
• schatten = estimar una cifra.

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandés | español |
|---|---|---|
| perfecto · we | We hebben drie bedrijven benaderd voor een offerte. | Hemos contactado con tres empresas para pedir presupuesto. |
| imperfecto · hij | Hij benaderde me na de vergadering. | Me abordó después de la reunión. |
| presente · niemand | Niemand benadert haar niveau. | Nadie se acerca a su nivel. |
| presente · jij | Hoe benader jij dit probleem? | ¿Cómo enfocas tú este problema? |
| pasiva perfecto · ik | Ik ben benaderd door een recruiter. | Me ha contactado un cazatalentos. |

📐 Estructura: sujeto + benadert + objeto (persona o problema). En pasiva: ik ben benaderd door…

⚠️ benaderen no es naderen: el segundo es acercarse físicamente y no lleva a nadie como objeto.

⚠️ moeilijk te benaderen, dicho de una persona, es «poco accesible, difícil de tratar».

🏋️ Ejercicio: «me ha contactado un cazatalentos» → Ik ___ benaderd door een recruiter. (Respuesta: ben, que la pasiva va con zijn.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'abordar, contactar' AND notes = 'dificil: benaderen (abordar, contactar)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'abordar, contactar' AND notes = 'dificil: benaderen (abordar, contactar)' LIMIT 1),
    'nl_NL', 'benaderen', 'benaderen',
    '• [perf.] We hebben drie bedrijven benaderd voor een offerte. — Hemos contactado con tres empresas para pedir presupuesto.
• [can.] Hij benaderde me na de vergadering. — Me abordó después de la reunión.
• [can.] Niemand benadert haar niveau. — Nadie se acerca a su nivel.
• [vraag] Hoe benader jij dit probleem? — ¿Cómo enfocas tú este problema?
• [perf.] Ik ben benaderd door een recruiter. — Me ha contactado un cazatalentos.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'abordar, contactar' AND notes = 'dificil: benaderen (abordar, contactar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'abordar, contactar' AND notes = 'dificil: benaderen (abordar, contactar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 13) verwijderen = eliminar, borrar
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'eliminar, borrar', 'WORD', 'dificil: verwijderen (eliminar, borrar)', 'verwijderen = eliminar, borrar, retirar. Es el verbo de los botones: ficheros, apps, mensajes, manchas, y también sacar a alguien de un grupo. Participio sin ge-: verwijderd.
🗺️ Las maneras de quitar algo:
• verwijderen = eliminar, retirar. El formal y el de las interfaces.
• wissen = borrar lo que estaba grabado o escrito: een bericht wissen, het bord wissen.
• weghalen = quitar de en medio, físico y coloquial: Haal die doos weg.
• weggooien = tirar a la basura.
• schrappen = tachar, suprimir de una lista o de un plan.
• uitschrijven y afmelden = dar de baja de un registro o una lista.
• deleten se oye mucho, pero es anglicismo de andar por casa.

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandés | español |
|---|---|---|
| imperativo · je | Verwijder die app maar, je gebruikt hem toch niet. | Borra esa app, total no la usas. |
| perfecto · ik | Ik heb de foto''s van mijn telefoon verwijderd. | He borrado las fotos del móvil. |
| presente · hij | Hij verwijdert elke week de oude bestanden. | Borra los archivos viejos todas las semanas. |
| pasiva imperfecto · hij | Gisteren werd hij uit de groep verwijderd. | Ayer lo sacaron del grupo. |
| presente · je | Kun je die vlek verwijderen? | ¿Puedes quitar esa mancha? |

📐 Estructura: sujeto + verwijdert + objeto + uit/van + lugar. Perfecto con hebben: heb verwijderd.

⚠️ Sus preposiciones: verwijderen UIT cuando es de dentro de algo (uit de groep) y VAN cuando es de un soporte o superficie (van je telefoon).

⚠️ de verwijdering es «la eliminación», pero también el distanciamiento entre personas. Y verwijderd de adjetivo es «alejado»: ver verwijderd van huis.

🏋️ Ejercicio: «he borrado las fotos del móvil» → Ik heb de foto''s ___ mijn telefoon verwijderd. (Respuesta: van.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'eliminar, borrar' AND notes = 'dificil: verwijderen (eliminar, borrar)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'eliminar, borrar' AND notes = 'dificil: verwijderen (eliminar, borrar)' LIMIT 1),
    'nl_NL', 'verwijderen', 'ferueideren',
    '• [geb.] Verwijder die app maar, je gebruikt hem toch niet. — Borra esa app, total no la usas.
• [perf.] Ik heb de foto''s van mijn telefoon verwijderd. — He borrado las fotos del móvil.
• [can.] Hij verwijdert elke week de oude bestanden. — Borra los archivos viejos todas las semanas.
• [inv.] Gisteren werd hij uit de groep verwijderd. — Ayer lo sacaron del grupo.
• [vraag] Kun je die vlek verwijderen? — ¿Puedes quitar esa mancha?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'eliminar, borrar' AND notes = 'dificil: verwijderen (eliminar, borrar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'eliminar, borrar' AND notes = 'dificil: verwijderen (eliminar, borrar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
