-- Learn Languages App - Alternancia g / h en el grupo de pronunciacion (6 tarjetas)
-- Migration: 20260831000004-add-g-vs-h-pronunciacion-cards.sql
-- Description: Eduardo: «otra que me cuesta mucho es cuando hay g y h alternas», con su ejemplo
--   «het grote muis die gaat niet horen», y el diagnostico que da el la clave: «arrastro la g
--   garganta y todo suena como g». La causa es de inventario: el espanol NO tiene [h] (la h
--   escrita es muda), asi que al ver una h la boca coge lo unico que tiene en esa zona, la jota,
--   y todo sale velar. Se anaden 6 tarjetas al grupo con un segundo bloque compartido 🔀
--   (IDENTICO byte a byte en las 6): la tabla g/h por posicion de la LENGUA (sube y raspa vs no
--   se mueve nada), los cuatro trucos fisicos para desengancharse de la g (jadear, el papelito,
--   construir desde la vocal en vez de suavizar la jota, empanar un cristal), las seis parejas
--   minimas que lo demuestran (hout/goud, heel/geel, hoed/goed, haar/gaar, hier/gier,
--   hoor/goor) y el drill de las palabras que llevan las DOS (hoog, haag, gehoord, geheim,
--   geheugen). Las 6 llevan tambien el bloque 🗣️ del grupo, copiado byte a byte.
--   La ultima tarjeta corrige la frase original: «de» y no «het» (muis es de-woord, la trampa es
--   que huis SI es het), «die» sobra en principal, y horen pide objeto -> De grote muis hoort
--   het niet.
--   La transcripcion de la g es «j» en todo el grupo (convencion de DutchToSpanishPhoneticService)
--   y la h se escribe «h», que en un grupo de pronunciacion no se puede omitir; lo documenta el
--   bloque 🔀.
--   100% aditiva e IDEMPOTENTE (INSERT ... WHERE NOT EXISTS / OR IGNORE, REPLACE con guard).

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1) pronunciacion: g/h alternando (hoe gaat het)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Qué tal?', 'PHRASE', 'pronunciacion: g/h alternando (hoe gaat het)', 'La alternancia g/h de todos los dias, y por eso la mejor para automatizarla: soplo (Hoe), jota (gaat), nada (het, que se queda en ''t). Tres piezas distintas en tres palabras. Si arrastras la garganta en las tres sale «JU-JAAT-JET», que es el acento espanol mas reconocible.

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔀 g y h alternando: dos sonidos que el espanol mete en el mismo cajon
En espanol solo existe UNO de los dos: la jota. La h escrita es muda SIEMPRE. Asi que cuando aparece una h y sabes que algo hay que hacer, la boca coge lo unico que tiene en esa zona — la jota — y todo acaba sonando a g. No es que pronuncies mal la h: es que no la tienes y la sustituyes.

| letra | donde se hace | que hace la lengua | ejemplos |
|---|---|---|---|
| **g / ch** | dorso contra el velo, raspa | **sube y se queda arriba** | gaat, goed, geen, hoog, gezien |
| **h** | glotis, solo aire | **no se mueve nada** | het, heb, horen, hoor, hond |

📌 La clave: la h neerlandesa NO es un sonido de garganta. Es la vocal siguiente dicha con aire antes de la voz, con la lengua ya colocada para esa vocal y sin tocar nada. Si notas raspado, has dicho g.

🧰 Cuatro trucos fisicos para desengancharse de la g:
1. Jadea, como un perro o como tu al subir escaleras: ha-ha-ha. Eso es exactamente la h.
2. Papelito delante de la boca: con h se mueve (sale aire), con jota se queda casi quieto (hace ruido pero mueve poco aire).
3. Construye desde la VOCAL, nunca suavizando la jota: oo → hoo → hoor · aa → haa → haar · ee → hee → heel. La lengua no se mueve en los tres pasos.
4. Empana un cristal: ese soplo es la h.

⚠️ Las parejas que lo demuestran — la palabra cambia entera segun cual pongas:
hout (madera) / goud (oro) · heel (entero) / geel (amarillo) · hoed (sombrero) / goed (bien) · haar (pelo) / gaar (hecho) · hier (aqui) / gier (buitre) · hoor (oigo) / goor (asqueroso)

🏋️ El drill que obliga a encender y apagar la lengua, porque llevan las DOS:
hoog (HOJ) · haag (HAJ) · gehoord (je-HORT) · geheim (je-HEIM) · geheugen (je-HEU-je). Si sale «jejeim» o «hehoord», has pegado los dos sonidos en uno.

⚠️ Y una g que NO es jota: la de -ng-. En honger, angst, mening o jongen la g forma con la n una sola nasal velar, la misma de «tengo» en espanol, y ahi no hay raspado ninguno. Decir «hon-jer» no existe.

🔤 En las transcripciones de este grupo, la j es la g neerlandesa (la jota) y la h es el soplo: «Hoe gaat het?» se escribe hu-JAAT-et, con jota solo en el medio.

🔊 Como suena de verdad: hu-JAAT-et (jota SOLO en el medio, acento en GAAT)

📐 Formula: Palabra interrogativa + verbo (2a casilla) + sujeto.

🧭 Cuando usarlo: saludar a cualquiera, todos los dias. Ej.: → Hoi, hoe gaat het?

🏋️ Ejercicio: Di la frase con el papelito delante: ¿cuantas veces se mueve? (Respuesta: una, en Hoe. En gaat no debe moverse.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Qué tal?' AND notes = 'pronunciacion: g/h alternando (hoe gaat het)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué tal?' AND notes = 'pronunciacion: g/h alternando (hoe gaat het)' LIMIT 1),
    'nl_NL', 'Hoe gaat het?', 'Hu jat et?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué tal?' AND notes = 'pronunciacion: g/h alternando (hoe gaat het)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué tal?' AND notes = 'pronunciacion: g/h alternando (hoe gaat het)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 2) pronunciacion: g/h alternando (heb geen honger)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No tengo hambre.', 'PHRASE', 'pronunciacion: g/h alternando (heb geen honger)', 'Tres palabras seguidas que alternan: heb (soplo), geen (jota), honger (soplo al empezar, y su g NO es jota). Porque aqui esta la trampa fina: la g de -ng- no raspa, forma con la n una sola nasal velar, la misma de «tengo» en espanol. Asi que la frase tiene soplo, jota, soplo y nasal — cuatro cosas distintas y ni una repetida.

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔀 g y h alternando: dos sonidos que el espanol mete en el mismo cajon
En espanol solo existe UNO de los dos: la jota. La h escrita es muda SIEMPRE. Asi que cuando aparece una h y sabes que algo hay que hacer, la boca coge lo unico que tiene en esa zona — la jota — y todo acaba sonando a g. No es que pronuncies mal la h: es que no la tienes y la sustituyes.

| letra | donde se hace | que hace la lengua | ejemplos |
|---|---|---|---|
| **g / ch** | dorso contra el velo, raspa | **sube y se queda arriba** | gaat, goed, geen, hoog, gezien |
| **h** | glotis, solo aire | **no se mueve nada** | het, heb, horen, hoor, hond |

📌 La clave: la h neerlandesa NO es un sonido de garganta. Es la vocal siguiente dicha con aire antes de la voz, con la lengua ya colocada para esa vocal y sin tocar nada. Si notas raspado, has dicho g.

🧰 Cuatro trucos fisicos para desengancharse de la g:
1. Jadea, como un perro o como tu al subir escaleras: ha-ha-ha. Eso es exactamente la h.
2. Papelito delante de la boca: con h se mueve (sale aire), con jota se queda casi quieto (hace ruido pero mueve poco aire).
3. Construye desde la VOCAL, nunca suavizando la jota: oo → hoo → hoor · aa → haa → haar · ee → hee → heel. La lengua no se mueve en los tres pasos.
4. Empana un cristal: ese soplo es la h.

⚠️ Las parejas que lo demuestran — la palabra cambia entera segun cual pongas:
hout (madera) / goud (oro) · heel (entero) / geel (amarillo) · hoed (sombrero) / goed (bien) · haar (pelo) / gaar (hecho) · hier (aqui) / gier (buitre) · hoor (oigo) / goor (asqueroso)

🏋️ El drill que obliga a encender y apagar la lengua, porque llevan las DOS:
hoog (HOJ) · haag (HAJ) · gehoord (je-HORT) · geheim (je-HEIM) · geheugen (je-HEU-je). Si sale «jejeim» o «hehoord», has pegado los dos sonidos en uno.

⚠️ Y una g que NO es jota: la de -ng-. En honger, angst, mening o jongen la g forma con la n una sola nasal velar, la misma de «tengo» en espanol, y ahi no hay raspado ninguno. Decir «hon-jer» no existe.

🔤 En las transcripciones de este grupo, la j es la g neerlandesa (la jota) y la h es el soplo: «Hoe gaat het?» se escribe hu-JAAT-et, con jota solo en el medio.

🔊 Como suena de verdad: ik hep JEN HON-ger (acento en GEEN y en HON-, y la -ng- NO es jota)

📐 Formula: Sujeto + heb (2a casilla) + geen + sustantivo.

🧭 Cuando usarlo: rechazar comida sin ofender. Ej.: → Nee dank je, ik heb geen honger.

🏋️ Ejercicio: ¿La g de «honger» es jota? (Respuesta: no — es la nasal velar de «tengo». Jota solo en «geen».)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No tengo hambre.' AND notes = 'pronunciacion: g/h alternando (heb geen honger)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No tengo hambre.' AND notes = 'pronunciacion: g/h alternando (heb geen honger)' LIMIT 1),
    'nl_NL', 'Ik heb geen honger.', 'Ik hep jen honger.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No tengo hambre.' AND notes = 'pronunciacion: g/h alternando (heb geen honger)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No tengo hambre.' AND notes = 'pronunciacion: g/h alternando (heb geen honger)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 3) pronunciacion: g/h alternando (goed gehoord)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Lo ha oído bien.', 'PHRASE', 'pronunciacion: g/h alternando (goed gehoord)', 'La cadena mas dura del grupo: hij-heeft-het son tres h seguidas (y las tres atonas, que se reducen), y luego goed-gehoord son dos jotas, la segunda con un soplo dentro («je-HORT»). O sea: apagar la lengua tres veces y encenderla dos.

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔀 g y h alternando: dos sonidos que el espanol mete en el mismo cajon
En espanol solo existe UNO de los dos: la jota. La h escrita es muda SIEMPRE. Asi que cuando aparece una h y sabes que algo hay que hacer, la boca coge lo unico que tiene en esa zona — la jota — y todo acaba sonando a g. No es que pronuncies mal la h: es que no la tienes y la sustituyes.

| letra | donde se hace | que hace la lengua | ejemplos |
|---|---|---|---|
| **g / ch** | dorso contra el velo, raspa | **sube y se queda arriba** | gaat, goed, geen, hoog, gezien |
| **h** | glotis, solo aire | **no se mueve nada** | het, heb, horen, hoor, hond |

📌 La clave: la h neerlandesa NO es un sonido de garganta. Es la vocal siguiente dicha con aire antes de la voz, con la lengua ya colocada para esa vocal y sin tocar nada. Si notas raspado, has dicho g.

🧰 Cuatro trucos fisicos para desengancharse de la g:
1. Jadea, como un perro o como tu al subir escaleras: ha-ha-ha. Eso es exactamente la h.
2. Papelito delante de la boca: con h se mueve (sale aire), con jota se queda casi quieto (hace ruido pero mueve poco aire).
3. Construye desde la VOCAL, nunca suavizando la jota: oo → hoo → hoor · aa → haa → haar · ee → hee → heel. La lengua no se mueve en los tres pasos.
4. Empana un cristal: ese soplo es la h.

⚠️ Las parejas que lo demuestran — la palabra cambia entera segun cual pongas:
hout (madera) / goud (oro) · heel (entero) / geel (amarillo) · hoed (sombrero) / goed (bien) · haar (pelo) / gaar (hecho) · hier (aqui) / gier (buitre) · hoor (oigo) / goor (asqueroso)

🏋️ El drill que obliga a encender y apagar la lengua, porque llevan las DOS:
hoog (HOJ) · haag (HAJ) · gehoord (je-HORT) · geheim (je-HEIM) · geheugen (je-HEU-je). Si sale «jejeim» o «hehoord», has pegado los dos sonidos en uno.

⚠️ Y una g que NO es jota: la de -ng-. En honger, angst, mening o jongen la g forma con la n una sola nasal velar, la misma de «tengo» en espanol, y ahi no hay raspado ninguno. Decir «hon-jer» no existe.

🔤 En las transcripciones de este grupo, la j es la g neerlandesa (la jota) y la h es el soplo: «Hoe gaat het?» se escribe hu-JAAT-et, con jota solo en el medio.

🔊 Como suena de verdad: ei-hef-t-''t JUT je-HORT (acento en GOED y en -HOORD)

📐 Formula: Sujeto + heeft (2a casilla) + het + goed + participio al final.

🧭 Cuando usarlo: confirmar que alguien entendio bien. Ej.: → Hij heeft het goed gehoord, we gaan niet.

🏋️ Ejercicio: En «gehoord» hay jota y soplo: ¿en que orden? (Respuesta: primero jota (ge-), luego soplo (-hoord).)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Lo ha oído bien.' AND notes = 'pronunciacion: g/h alternando (goed gehoord)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo ha oído bien.' AND notes = 'pronunciacion: g/h alternando (goed gehoord)' LIMIT 1),
    'nl_NL', 'Hij heeft het goed gehoord.', 'Ei heft et jut jehort.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo ha oído bien.' AND notes = 'pronunciacion: g/h alternando (goed gehoord)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo ha oído bien.' AND notes = 'pronunciacion: g/h alternando (goed gehoord)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 4) pronunciacion: g/h alternando (gaat goed hoor)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Va bien, ¿eh?', 'PHRASE', 'pronunciacion: g/h alternando (gaat goed hoor)', 'Dos jotas seguidas y luego el soplo, justo al reves que en «Hoe gaat het». Sirve para practicar el corte: gaat-goed van pegadas y con la lengua arriba, y en «hoor» hay que soltarla del todo. Y de propina, «hoor» aqui es la particula que tranquiliza, no el verbo oir.

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔀 g y h alternando: dos sonidos que el espanol mete en el mismo cajon
En espanol solo existe UNO de los dos: la jota. La h escrita es muda SIEMPRE. Asi que cuando aparece una h y sabes que algo hay que hacer, la boca coge lo unico que tiene en esa zona — la jota — y todo acaba sonando a g. No es que pronuncies mal la h: es que no la tienes y la sustituyes.

| letra | donde se hace | que hace la lengua | ejemplos |
|---|---|---|---|
| **g / ch** | dorso contra el velo, raspa | **sube y se queda arriba** | gaat, goed, geen, hoog, gezien |
| **h** | glotis, solo aire | **no se mueve nada** | het, heb, horen, hoor, hond |

📌 La clave: la h neerlandesa NO es un sonido de garganta. Es la vocal siguiente dicha con aire antes de la voz, con la lengua ya colocada para esa vocal y sin tocar nada. Si notas raspado, has dicho g.

🧰 Cuatro trucos fisicos para desengancharse de la g:
1. Jadea, como un perro o como tu al subir escaleras: ha-ha-ha. Eso es exactamente la h.
2. Papelito delante de la boca: con h se mueve (sale aire), con jota se queda casi quieto (hace ruido pero mueve poco aire).
3. Construye desde la VOCAL, nunca suavizando la jota: oo → hoo → hoor · aa → haa → haar · ee → hee → heel. La lengua no se mueve en los tres pasos.
4. Empana un cristal: ese soplo es la h.

⚠️ Las parejas que lo demuestran — la palabra cambia entera segun cual pongas:
hout (madera) / goud (oro) · heel (entero) / geel (amarillo) · hoed (sombrero) / goed (bien) · haar (pelo) / gaar (hecho) · hier (aqui) / gier (buitre) · hoor (oigo) / goor (asqueroso)

🏋️ El drill que obliga a encender y apagar la lengua, porque llevan las DOS:
hoog (HOJ) · haag (HAJ) · gehoord (je-HORT) · geheim (je-HEIM) · geheugen (je-HEU-je). Si sale «jejeim» o «hehoord», has pegado los dos sonidos en uno.

⚠️ Y una g que NO es jota: la de -ng-. En honger, angst, mening o jongen la g forma con la n una sola nasal velar, la misma de «tengo» en espanol, y ahi no hay raspado ninguno. Decir «hon-jer» no existe.

🔤 En las transcripciones de este grupo, la j es la g neerlandesa (la jota) y la h es el soplo: «Hoe gaat het?» se escribe hu-JAAT-et, con jota solo en el medio.

🔊 Como suena de verdad: et JAT JUT hoor (las dos jotas juntas, la lengua baja solo al final)

📐 Formula: Het + gaat (2a casilla) + goed + hoor al final.

🧭 Cuando usarlo: tranquilizar a quien pregunta que tal va algo. Ej.: → Het gaat goed hoor, maak je geen zorgen.

🏋️ Ejercicio: ¿Cuantas jotas hay y donde? (Respuesta: dos, gaat y goed. En hoor NO hay jota.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Va bien, ¿eh?' AND notes = 'pronunciacion: g/h alternando (gaat goed hoor)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Va bien, ¿eh?' AND notes = 'pronunciacion: g/h alternando (gaat goed hoor)' LIMIT 1),
    'nl_NL', 'Het gaat goed hoor.', 'Et jat jut hor.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Va bien, ¿eh?' AND notes = 'pronunciacion: g/h alternando (gaat goed hoor)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Va bien, ¿eh?' AND notes = 'pronunciacion: g/h alternando (gaat goed hoor)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 5) pronunciacion: g/h dentro de la misma palabra
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Tengo mala memoria.', 'PHRASE', 'pronunciacion: g/h dentro de la misma palabra', 'Aqui la alternancia esta DENTRO de una sola palabra: geheugen = jota + soplo + jota (je-HEU-je). Es el mejor ejercicio que existe para esto, porque no puedes resolverla con un solo sonido. Su familia hace lo mismo: geheim (je-HEIM), gehoord (je-HORT), gehaald (je-HALT).

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔀 g y h alternando: dos sonidos que el espanol mete en el mismo cajon
En espanol solo existe UNO de los dos: la jota. La h escrita es muda SIEMPRE. Asi que cuando aparece una h y sabes que algo hay que hacer, la boca coge lo unico que tiene en esa zona — la jota — y todo acaba sonando a g. No es que pronuncies mal la h: es que no la tienes y la sustituyes.

| letra | donde se hace | que hace la lengua | ejemplos |
|---|---|---|---|
| **g / ch** | dorso contra el velo, raspa | **sube y se queda arriba** | gaat, goed, geen, hoog, gezien |
| **h** | glotis, solo aire | **no se mueve nada** | het, heb, horen, hoor, hond |

📌 La clave: la h neerlandesa NO es un sonido de garganta. Es la vocal siguiente dicha con aire antes de la voz, con la lengua ya colocada para esa vocal y sin tocar nada. Si notas raspado, has dicho g.

🧰 Cuatro trucos fisicos para desengancharse de la g:
1. Jadea, como un perro o como tu al subir escaleras: ha-ha-ha. Eso es exactamente la h.
2. Papelito delante de la boca: con h se mueve (sale aire), con jota se queda casi quieto (hace ruido pero mueve poco aire).
3. Construye desde la VOCAL, nunca suavizando la jota: oo → hoo → hoor · aa → haa → haar · ee → hee → heel. La lengua no se mueve en los tres pasos.
4. Empana un cristal: ese soplo es la h.

⚠️ Las parejas que lo demuestran — la palabra cambia entera segun cual pongas:
hout (madera) / goud (oro) · heel (entero) / geel (amarillo) · hoed (sombrero) / goed (bien) · haar (pelo) / gaar (hecho) · hier (aqui) / gier (buitre) · hoor (oigo) / goor (asqueroso)

🏋️ El drill que obliga a encender y apagar la lengua, porque llevan las DOS:
hoog (HOJ) · haag (HAJ) · gehoord (je-HORT) · geheim (je-HEIM) · geheugen (je-HEU-je). Si sale «jejeim» o «hehoord», has pegado los dos sonidos en uno.

⚠️ Y una g que NO es jota: la de -ng-. En honger, angst, mening o jongen la g forma con la n una sola nasal velar, la misma de «tengo» en espanol, y ahi no hay raspado ninguno. Decir «hon-jer» no existe.

🔤 En las transcripciones de este grupo, la j es la g neerlandesa (la jota) y la h es el soplo: «Hoe gaat het?» se escribe hu-JAAT-et, con jota solo en el medio.

🔊 Como suena de verdad: mein je-HEU-je is SLEJT (jota, soplo, jota — y otra jota en slecht)

📐 Formula: Posesivo + sustantivo + is (2a casilla) + adjetivo.

🧭 Cuando usarlo: disculparte por no acordarte. Ej.: → Sorry, mijn geheugen is slecht.

🏋️ Ejercicio: Parte «geheugen» en sus tres sonidos de atras. (Respuesta: ge- jota · -heu- soplo · -gen jota.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Tengo mala memoria.' AND notes = 'pronunciacion: g/h dentro de la misma palabra');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Tengo mala memoria.' AND notes = 'pronunciacion: g/h dentro de la misma palabra' LIMIT 1),
    'nl_NL', 'Mijn geheugen is slecht.', 'Mein jeheujen is slejt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tengo mala memoria.' AND notes = 'pronunciacion: g/h dentro de la misma palabra' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tengo mala memoria.' AND notes = 'pronunciacion: g/h dentro de la misma palabra' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 6) pronunciacion: g/h alternando + de/het (muis vs huis)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'El ratón grande no lo oye.', 'PHRASE', 'pronunciacion: g/h alternando + de/het (muis vs huis)', 'La frase de partida era «het grote muis die gaat niet horen» y tenia tres cosas que arreglar, todas clasicas. 1) muis es DE-woord (de muis), y la trampa es que huis, que se diferencia en una letra, si es het-woord: het grote huis / de grote muis. 2) «die» sobra: en una frase principal no se pone; si quieres relativa, el verbo se va al final (de muis die het niet hoort). 3) «horen» pide objeto (het) y aqui lo natural es el presente, no «gaat niet horen». La alternancia que preguntabas esta en GROte (jota) y HOORT (soplo).

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔀 g y h alternando: dos sonidos que el espanol mete en el mismo cajon
En espanol solo existe UNO de los dos: la jota. La h escrita es muda SIEMPRE. Asi que cuando aparece una h y sabes que algo hay que hacer, la boca coge lo unico que tiene en esa zona — la jota — y todo acaba sonando a g. No es que pronuncies mal la h: es que no la tienes y la sustituyes.

| letra | donde se hace | que hace la lengua | ejemplos |
|---|---|---|---|
| **g / ch** | dorso contra el velo, raspa | **sube y se queda arriba** | gaat, goed, geen, hoog, gezien |
| **h** | glotis, solo aire | **no se mueve nada** | het, heb, horen, hoor, hond |

📌 La clave: la h neerlandesa NO es un sonido de garganta. Es la vocal siguiente dicha con aire antes de la voz, con la lengua ya colocada para esa vocal y sin tocar nada. Si notas raspado, has dicho g.

🧰 Cuatro trucos fisicos para desengancharse de la g:
1. Jadea, como un perro o como tu al subir escaleras: ha-ha-ha. Eso es exactamente la h.
2. Papelito delante de la boca: con h se mueve (sale aire), con jota se queda casi quieto (hace ruido pero mueve poco aire).
3. Construye desde la VOCAL, nunca suavizando la jota: oo → hoo → hoor · aa → haa → haar · ee → hee → heel. La lengua no se mueve en los tres pasos.
4. Empana un cristal: ese soplo es la h.

⚠️ Las parejas que lo demuestran — la palabra cambia entera segun cual pongas:
hout (madera) / goud (oro) · heel (entero) / geel (amarillo) · hoed (sombrero) / goed (bien) · haar (pelo) / gaar (hecho) · hier (aqui) / gier (buitre) · hoor (oigo) / goor (asqueroso)

🏋️ El drill que obliga a encender y apagar la lengua, porque llevan las DOS:
hoog (HOJ) · haag (HAJ) · gehoord (je-HORT) · geheim (je-HEIM) · geheugen (je-HEU-je). Si sale «jejeim» o «hehoord», has pegado los dos sonidos en uno.

⚠️ Y una g que NO es jota: la de -ng-. En honger, angst, mening o jongen la g forma con la n una sola nasal velar, la misma de «tengo» en espanol, y ahi no hay raspado ninguno. Decir «hon-jer» no existe.

🔤 En las transcripciones de este grupo, la j es la g neerlandesa (la jota) y la h es el soplo: «Hoe gaat het?» se escribe hu-JAAT-et, con jota solo en el medio.

🔊 Como suena de verdad: de JRO-te meus HORT-et nit (jota en GRO-, soplo en HOORT)

📐 Formula: Articulo + adjetivo + sustantivo + verbo (2a casilla) + objeto + niet.

🧭 Cuando usarlo: describir lo que alguien no percibe. Ej.: → De grote muis hoort het niet, hij slaapt.

🏋️ Ejercicio: «___ grote muis» y «___ grote huis». (Respuestas: de / het. Se parecen en una letra y son de generos distintos.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El ratón grande no lo oye.' AND notes = 'pronunciacion: g/h alternando + de/het (muis vs huis)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El ratón grande no lo oye.' AND notes = 'pronunciacion: g/h alternando + de/het (muis vs huis)' LIMIT 1),
    'nl_NL', 'De grote muis hoort het niet.', 'De jrote meus hort et nit.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El ratón grande no lo oye.' AND notes = 'pronunciacion: g/h alternando + de/het (muis vs huis)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El ratón grande no lo oye.' AND notes = 'pronunciacion: g/h alternando + de/het (muis vs huis)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
