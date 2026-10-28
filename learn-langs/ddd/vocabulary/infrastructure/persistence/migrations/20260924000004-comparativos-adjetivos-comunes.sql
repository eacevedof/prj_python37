-- Learn Languages App - Migration
-- Migration: 20260924000004-comparativos-adjetivos-comunes
-- Description: Eduardo: "hay que crear un grupo con los comparativos (creo tenemos uno?) sino
--   creemos uno con los djetivos mas comunes".
--
--   El grupo existe: 39 «comparativos - klein, kleiner, het kleinst» (20260907000013), pero sus 21 tarjetas son
--   ESTRUCTURAS (kleiner dan, net zo … als, hoe … hoe, het -st / de -ste) y en todo el mazo no
--   habia una sola tarjeta WORD de adjetivo. No se crea grupo nuevo: se completa el 39.
--
--   46 tarjetas WORD, 23 parejas de contrarios, las mas frecuentes: groot/klein, goed/slecht,
--   oud/jong, lang/kort, duur/goedkoop, snel/langzaam, warm/koud, hoog/laag, makkelijk/moeilijk,
--   zwaar/licht, dik/dun, sterk/zwak, rijk/arm, blij/verdrietig, vol/leeg, nat/droog,
--   vroeg/laat, breed/smal, mooi/lelijk, lekker/smerig, leuk/saai, druk/rustig, veel/weinig.
--   Se eligio smerig y no vies como contrario de lekker porque vies acaba en -s y su superlativo
--   choca con la regla del meest que ya enseña el bloque del grupo.
--
--   El texto ES da los tres grados («pequeño, más pequeño, el más pequeño») y la respuesta
--   tambien, sin articulo («klein, kleiner, kleinst»). Ayuda de cada una: primera linea con los
--   grados y la forma con -e; tabla de uso con un sustantivo real (suelto, delante con -e, con
--   een + het-woord SIN -e cuando el sustantivo es het, comparativo con dan, superlativo con y sin
--   sustantivo); cual de las cinco reglas del -er aplica (tal cual, vocal larga que pierde letra,
--   consonante doblada, -r que pide -d-, irregular); su contrario; la trampa propia (lang = alto
--   de persona, vroeger = antes, laatst = ultimo, Ik heb het warm/druk, leger = ejercito…) y el
--   bloque compartido del grupo «📊 Los tres grados del adjetivo:» copiado byte a byte de la BD (§3.3).
--
--   46 frases SENTENCE, una por adjetivo con EXAMPLE, rotando comparativo, superlativo,
--   igualdad, steeds, hoe … hoe, perfecto, imperfecto, reflexivos (zich voelen, opstaan) e
--   imperativo. Marcas (presente) en los -amos, (él)/(ella)/(ellos) y (sin inv) en «Nunca la he
--   visto tan contenta» (§3.9). notes de cada palabra con 5 ejemplos por plantilla (can., comp.,
--   sup., gelijk, attr.) y a mano para vroeg, laat, veel y weinig, que no van con sustantivo.

PRAGMA foreign_keys = ON;

-- groot
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'grande, más grande, el más grande', 'WORD', 'Comparativos: groot', 'GROOT = grande. Grados groot · groter · grootst, y delante del sustantivo, con la -e, grote.

📏 Las formas de groot:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | Het huis is **groot**. |
| 2 | delante del sustantivo | het **grote** huis |
| 3 | con een y het-woord, SIN -e | een **groot** huis |
| 4 | comparativo + dan | Dit huis is **groter** dan dat. |
| 5 | superlativo con sustantivo | het **grootste** huis |
| 6 | superlativo suelto | Dit is het **grootst**. |

🔤 La regla que aplica: La vocal larga pierde una letra al abrirse la silaba, como en el plural, groot → groter. En el superlativo la silaba sigue cerrada y la vuelve a llevar, grootst.

🔄 Su contrario, con tarjeta propia en el grupo: klein · kleiner · kleinst. Se aprenden en pareja.

⚠️ Mayor de edad es ouder, no groter. Con personas groot es adulto o alto de niño, als ik groot ben = cuando sea mayor.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'grande, más grande, el más grande');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'grande, más grande, el más grande' LIMIT 1),
    'nl_NL', 'groot, groter, grootst', 'jroot, jróoter, jrootst', '• [can.] Het huis is groot. — La casa es grande.
• [comp.] Dit huis is groter dan dat. — Esta casa es más grande que esa.
• [sup.] Dit is het grootste huis. — Es la casa más grande.
• [gelijk] Dat is net zo groot als dit. — Esa es igual de grande que esta.
• [attr.] het grote huis · een groot huis — la casa grande · una casa grande');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Nuestro piso nuevo es más grande que el antiguo.', 'SENTENCE', 'Ejemplo de "groot" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Nuestro piso nuevo es más grande que el antiguo.' AND notes = 'Ejemplo de "groot" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Nuestro piso nuevo es más grande que el antiguo.' AND notes = 'Ejemplo de "groot" (comp.)' LIMIT 1),
    'nl_NL', 'Onze nieuwe flat is groter dan de oude.', 'ónse níiwe flet is jróoter dan de áude');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'grande, más grande, el más grande' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Nuestro piso nuevo es más grande que el antiguo.' AND notes = 'Ejemplo de "groot" (comp.)' LIMIT 1),
        'EXAMPLE');

-- klein
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pequeño, más pequeño, el más pequeño', 'WORD', 'Comparativos: klein', 'KLEIN = pequeño. Grados klein · kleiner · kleinst, y delante del sustantivo, con la -e, kleine.

📏 Las formas de klein:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De kamer is **klein**. |
| 2 | delante del sustantivo | de **kleine** kamer |
| 3 | comparativo + dan | Deze kamer is **kleiner** dan die. |
| 4 | superlativo con sustantivo | de **kleinste** kamer |
| 5 | superlativo suelto | Deze is het **kleinst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, klein → kleiner, y el superlativo con -st, kleinst.

🔄 Su contrario, con tarjeta propia en el grupo: groot · groter · grootst. Se aprenden en pareja.

⚠️ Una persona baja es klein, no kort. Y el diminutivo -je suma pequeñez, een klein huisje.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pequeño, más pequeño, el más pequeño');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'pequeño, más pequeño, el más pequeño' LIMIT 1),
    'nl_NL', 'klein, kleiner, kleinst', 'klein, kléiner, kleinst', '• [can.] De kamer is klein. — La habitación es pequeña.
• [comp.] Deze kamer is kleiner dan die. — Esta habitación es más pequeña que esa.
• [sup.] Dit is de kleinste kamer. — Es la habitación más pequeña.
• [gelijk] Die is net zo klein als deze. — Esa es igual de pequeña que esta.
• [attr.] de kleine kamer · een kleine kamer — la habitación pequeña · una habitación pequeña');

INSERT INTO words_es (text, word_type, notes)
SELECT 'De pequeño vivía en un pueblo muy pequeño. (él)', 'SENTENCE', 'Ejemplo de "klein" (imperf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'De pequeño vivía en un pueblo muy pequeño. (él)' AND notes = 'Ejemplo de "klein" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'De pequeño vivía en un pueblo muy pequeño. (él)' AND notes = 'Ejemplo de "klein" (imperf.)' LIMIT 1),
    'nl_NL', 'Als kind woonde hij in een heel klein dorp.', 'als kint wóonde hei in en heel klein dorp');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'pequeño, más pequeño, el más pequeño' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'De pequeño vivía en un pueblo muy pequeño. (él)' AND notes = 'Ejemplo de "klein" (imperf.)' LIMIT 1),
        'EXAMPLE');

-- goed
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'bueno, mejor, el mejor', 'WORD', 'Comparativos: goed', 'GOED = bueno. Grados goed · beter · best, y delante del sustantivo, con la -e, goede.

📏 Las formas de goed:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | Het idee is **goed**. |
| 2 | delante del sustantivo | het **goede** idee |
| 3 | con een y het-woord, SIN -e | een **goed** idee |
| 4 | comparativo + dan | Dit idee is **beter** dan dat. |
| 5 | superlativo con sustantivo | het **beste** idee |
| 6 | superlativo suelto | Dit is het **best**. |

🔤 La regla que aplica: Irregular del todo, goed → beter → best. Se aprende de memoria, como en español bueno → mejor.

🔄 Su contrario, con tarjeta propia en el grupo: slecht · slechter · slechtst. Se aprenden en pareja.

⚠️ Nunca «goeder». Y Het beste! = ¡que te vaya bien!, despedida de todos los días.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'bueno, mejor, el mejor');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'bueno, mejor, el mejor' LIMIT 1),
    'nl_NL', 'goed, beter, best', 'jut, béeter, best', '• [can.] Het idee is goed. — La idea es buena.
• [comp.] Dit idee is beter dan dat. — Esta idea es mejor que esa.
• [sup.] Dit is het beste idee. — Es la mejor idea.
• [gelijk] Dat is net zo goed als dit. — Esa es igual de buena que esta.
• [attr.] het goede idee · een goed idee — la idea buena · una idea buena');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Hoy me siento mucho mejor que ayer.', 'SENTENCE', 'Ejemplo de "goed" (refl.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Hoy me siento mucho mejor que ayer.' AND notes = 'Ejemplo de "goed" (refl.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Hoy me siento mucho mejor que ayer.' AND notes = 'Ejemplo de "goed" (refl.)' LIMIT 1),
    'nl_NL', 'Vandaag voel ik me veel beter dan gisteren.', 'fandáaj ful ik me feel béeter dan jísteren');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'bueno, mejor, el mejor' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Hoy me siento mucho mejor que ayer.' AND notes = 'Ejemplo de "goed" (refl.)' LIMIT 1),
        'EXAMPLE');

-- slecht
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'malo, peor, el peor', 'WORD', 'Comparativos: slecht', 'SLECHT = malo. Grados slecht · slechter · slechtst, y delante del sustantivo, con la -e, slechte.

📏 Las formas de slecht:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De film is **slecht**. |
| 2 | delante del sustantivo | de **slechte** film |
| 3 | comparativo + dan | Deze film is **slechter** dan die. |
| 4 | superlativo con sustantivo | de **slechtste** film |
| 5 | superlativo suelto | Deze is het **slechtst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, slecht → slechter, y el superlativo con -st, slechtst.

🔄 Su contrario, con tarjeta propia en el grupo: goed · beter · best. Se aprenden en pareja.

⚠️ slecht es malo de calidad. Malo de enfermo es ziek, y malo de malvado, gemeen.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'malo, peor, el peor');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'malo, peor, el peor' LIMIT 1),
    'nl_NL', 'slecht, slechter, slechtst', 'slejt, sléjter, slejtst', '• [can.] De film is slecht. — La película es mala.
• [comp.] Deze film is slechter dan die. — Esta película es peor que esa.
• [sup.] Dit is de slechtste film. — Es la peor película.
• [gelijk] Die is net zo slecht als deze. — Esa es igual de mala que esta.
• [attr.] de slechte film · een slechte film — la película mala · una película mala');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Fue la peor semana de mi vida.', 'SENTENCE', 'Ejemplo de "slecht" (sup.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Fue la peor semana de mi vida.' AND notes = 'Ejemplo de "slecht" (sup.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Fue la peor semana de mi vida.' AND notes = 'Ejemplo de "slecht" (sup.)' LIMIT 1),
    'nl_NL', 'Het was de slechtste week van mijn leven.', 'et was de sléjtste week fan méin léefen');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'malo, peor, el peor' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Fue la peor semana de mi vida.' AND notes = 'Ejemplo de "slecht" (sup.)' LIMIT 1),
        'EXAMPLE');

-- oud
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'viejo, más viejo, el más viejo', 'WORD', 'Comparativos: oud', 'OUD = viejo. Grados oud · ouder · oudst, y delante del sustantivo, con la -e, oude.

📏 Las formas de oud:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De fiets is **oud**. |
| 2 | delante del sustantivo | de **oude** fiets |
| 3 | comparativo + dan | Deze fiets is **ouder** dan die. |
| 4 | superlativo con sustantivo | de **oudste** fiets |
| 5 | superlativo suelto | Deze is het **oudst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, oud → ouder, y el superlativo con -st, oudst.

🔄 Su contrario, con tarjeta propia en el grupo: jong · jonger · jongst. Se aprenden en pareja.

⚠️ Con la edad oud hace de mayor: ouder dan = mayor que, mijn oudere broer = mi hermano mayor. Y la edad se pregunta con oud, Hoe oud ben je?

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'viejo, más viejo, el más viejo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'viejo, más viejo, el más viejo' LIMIT 1),
    'nl_NL', 'oud, ouder, oudst', 'aut, áuder, autst', '• [can.] De fiets is oud. — La bici es vieja.
• [comp.] Deze fiets is ouder dan die. — Esta bici es más vieja que esa.
• [sup.] Dit is de oudste fiets. — Es la bici más vieja.
• [gelijk] Die is net zo oud als deze. — Esa es igual de vieja que esta.
• [attr.] de oude fiets · een oude fiets — la bici vieja · una bici vieja');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi hermano es tres años mayor que yo.', 'SENTENCE', 'Ejemplo de "oud" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi hermano es tres años mayor que yo.' AND notes = 'Ejemplo de "oud" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi hermano es tres años mayor que yo.' AND notes = 'Ejemplo de "oud" (comp.)' LIMIT 1),
    'nl_NL', 'Mijn broer is drie jaar ouder dan ik.', 'méin brur is drii yaar áuder dan ik');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'viejo, más viejo, el más viejo' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi hermano es tres años mayor que yo.' AND notes = 'Ejemplo de "oud" (comp.)' LIMIT 1),
        'EXAMPLE');

-- jong
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'joven, más joven, el más joven', 'WORD', 'Comparativos: jong', 'JONG = joven. Grados jong · jonger · jongst, y delante del sustantivo, con la -e, jonge.

📏 Las formas de jong:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De hond is **jong**. |
| 2 | delante del sustantivo | de **jonge** hond |
| 3 | comparativo + dan | Deze hond is **jonger** dan die. |
| 4 | superlativo con sustantivo | de **jongste** hond |
| 5 | superlativo suelto | Deze is het **jongst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, jong → jonger, y el superlativo con -st, jongst.

🔄 Su contrario, con tarjeta propia en el grupo: oud · ouder · oudst. Se aprenden en pareja.

⚠️ De jongste es el más joven y, en una familia, el pequeño. Mijn jongere zus = mi hermana menor.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'joven, más joven, el más joven');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'joven, más joven, el más joven' LIMIT 1),
    'nl_NL', 'jong, jonger, jongst', 'yong, yónger, yongst', '• [can.] De hond is jong. — El perro es joven.
• [comp.] Deze hond is jonger dan die. — Este perro es más joven que ese.
• [sup.] Dit is de jongste hond. — Es el perro más joven.
• [gelijk] Die is net zo jong als deze. — Ese es igual de joven que este.
• [attr.] de jonge hond · een jonge hond — el perro joven · un perro joven');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Es la más joven de la familia. (ella)', 'SENTENCE', 'Ejemplo de "jong" (sup.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Es la más joven de la familia. (ella)' AND notes = 'Ejemplo de "jong" (sup.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Es la más joven de la familia. (ella)' AND notes = 'Ejemplo de "jong" (sup.)' LIMIT 1),
    'nl_NL', 'Ze is de jongste van de familie.', 'se is de yóngste fan de famílie');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'joven, más joven, el más joven' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Es la más joven de la familia. (ella)' AND notes = 'Ejemplo de "jong" (sup.)' LIMIT 1),
        'EXAMPLE');

-- lang
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'largo, más largo, el más largo', 'WORD', 'Comparativos: lang', 'LANG = largo. Grados lang · langer · langst, y delante del sustantivo, con la -e, lange.

📏 Las formas de lang:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De weg is **lang**. |
| 2 | delante del sustantivo | de **lange** weg |
| 3 | comparativo + dan | Deze weg is **langer** dan die. |
| 4 | superlativo con sustantivo | de **langste** weg |
| 5 | superlativo suelto | Deze is het **langst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, lang → langer, y el superlativo con -st, langst.

🔄 Su contrario, con tarjeta propia en el grupo: kort · korter · kortst. Se aprenden en pareja.

⚠️ ¡Trampa! lang es largo Y alto de persona, Hij is lang = es alto. hoog es para cosas; nunca «hij is hoog».

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'largo, más largo, el más largo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'largo, más largo, el más largo' LIMIT 1),
    'nl_NL', 'lang, langer, langst', 'lang, lánger, langst', '• [can.] De weg is lang. — El camino es largo.
• [comp.] Deze weg is langer dan die. — Este camino es más largo que ese.
• [sup.] Dit is de langste weg. — Es el camino más largo.
• [gelijk] Die is net zo lang als deze. — Ese es igual de largo que este.
• [attr.] de lange weg · een lange weg — el camino largo · un camino largo');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi hijo ya es tan alto como yo.', 'SENTENCE', 'Ejemplo de "lang" (gelijk)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi hijo ya es tan alto como yo.' AND notes = 'Ejemplo de "lang" (gelijk)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi hijo ya es tan alto como yo.' AND notes = 'Ejemplo de "lang" (gelijk)' LIMIT 1),
    'nl_NL', 'Mijn zoon is al net zo lang als ik.', 'méin soon is al net soo lang als ik');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'largo, más largo, el más largo' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi hijo ya es tan alto como yo.' AND notes = 'Ejemplo de "lang" (gelijk)' LIMIT 1),
        'EXAMPLE');

-- kort
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'corto, más corto, el más corto', 'WORD', 'Comparativos: kort', 'KORT = corto. Grados kort · korter · kortst, y delante del sustantivo, con la -e, korte.

📏 Las formas de kort:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De broek is **kort**. |
| 2 | delante del sustantivo | de **korte** broek |
| 3 | comparativo + dan | Deze broek is **korter** dan die. |
| 4 | superlativo con sustantivo | de **kortste** broek |
| 5 | superlativo suelto | Deze is het **kortst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, kort → korter, y el superlativo con -st, kortst.

🔄 Su contrario, con tarjeta propia en el grupo: lang · langer · langst. Se aprenden en pareja.

⚠️ kort es de longitud o de tiempo. Una persona baja no es kort sino klein.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'corto, más corto, el más corto');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'corto, más corto, el más corto' LIMIT 1),
    'nl_NL', 'kort, korter, kortst', 'kort, kórter, kortst', '• [can.] De broek is kort. — El pantalón es corto.
• [comp.] Deze broek is korter dan die. — Este pantalón es más corto que ese.
• [sup.] Dit is de kortste broek. — Es el pantalón más corto.
• [gelijk] Die is net zo kort als deze. — Ese es igual de corto que este.
• [attr.] de korte broek · een korte broek — el pantalón corto · un pantalón corto');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Los días se hacen cada vez más cortos.', 'SENTENCE', 'Ejemplo de "kort" (steeds)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los días se hacen cada vez más cortos.' AND notes = 'Ejemplo de "kort" (steeds)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Los días se hacen cada vez más cortos.' AND notes = 'Ejemplo de "kort" (steeds)' LIMIT 1),
    'nl_NL', 'De dagen worden steeds korter.', 'de dáajen wórden steets kórter');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'corto, más corto, el más corto' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Los días se hacen cada vez más cortos.' AND notes = 'Ejemplo de "kort" (steeds)' LIMIT 1),
        'EXAMPLE');

-- duur
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'caro, más caro, el más caro', 'WORD', 'Comparativos: duur', 'DUUR = caro. Grados duur · duurder · duurst, y delante del sustantivo, con la -e, dure.

📏 Las formas de duur:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De tas is **duur**. |
| 2 | delante del sustantivo | de **dure** tas |
| 3 | comparativo + dan | Deze tas is **duurder** dan die. |
| 4 | superlativo con sustantivo | de **duurste** tas |
| 5 | superlativo suelto | Deze is het **duurst**. |

🔤 La regla que aplica: Acaba en -r, y la -r pide una d en medio, duur → duurder, nunca «duurer». El superlativo va normal, duurst.

🔄 Su contrario, con tarjeta propia en el grupo: goedkoop · goedkoper · goedkoopst. Se aprenden en pareja.

⚠️ Delante del sustantivo, dure con una sola u, de dure tas; en el comparativo vuelve la uu con la d, duurder.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'caro, más caro, el más caro');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'caro, más caro, el más caro' LIMIT 1),
    'nl_NL', 'duur, duurder, duurst', 'duur, dúurder, duurst', '• [can.] De tas is duur. — El bolso es caro.
• [comp.] Deze tas is duurder dan die. — Este bolso es más caro que ese.
• [sup.] Dit is de duurste tas. — Es el bolso más caro.
• [gelijk] Die is net zo duur als deze. — Ese es igual de caro que este.
• [attr.] de dure tas · een dure tas — el bolso caro · un bolso caro');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Todo se ha vuelto más caro este año.', 'SENTENCE', 'Ejemplo de "duur" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Todo se ha vuelto más caro este año.' AND notes = 'Ejemplo de "duur" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo se ha vuelto más caro este año.' AND notes = 'Ejemplo de "duur" (perf.)' LIMIT 1),
    'nl_NL', 'Alles is dit jaar duurder geworden.', 'áles is dit yaar dúurder jewórden');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'caro, más caro, el más caro' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Todo se ha vuelto más caro este año.' AND notes = 'Ejemplo de "duur" (perf.)' LIMIT 1),
        'EXAMPLE');

-- goedkoop
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'barato, más barato, el más barato', 'WORD', 'Comparativos: goedkoop', 'GOEDKOOP = barato. Grados goedkoop · goedkoper · goedkoopst, y delante del sustantivo, con la -e, goedkope.

📏 Las formas de goedkoop:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | Het hotel is **goedkoop**. |
| 2 | delante del sustantivo | het **goedkope** hotel |
| 3 | con een y het-woord, SIN -e | een **goedkoop** hotel |
| 4 | comparativo + dan | Dit hotel is **goedkoper** dan dat. |
| 5 | superlativo con sustantivo | het **goedkoopste** hotel |
| 6 | superlativo suelto | Dit is het **goedkoopst**. |

🔤 La regla que aplica: La vocal larga pierde una letra al abrirse la silaba, como en el plural, goedkoop → goedkoper. En el superlativo la silaba sigue cerrada y la vuelve a llevar, goedkoopst.

🔄 Su contrario, con tarjeta propia en el grupo: duur · duurder · duurst. Se aprenden en pareja.

⚠️ goed + koop, literalmente buena compra. Y también cutre, Dat ziet er goedkoop uit = eso parece barato.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'barato, más barato, el más barato');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'barato, más barato, el más barato' LIMIT 1),
    'nl_NL', 'goedkoop, goedkoper, goedkoopst', 'jutkóop, jutkóoper, jutkóopst', '• [can.] Het hotel is goedkoop. — El hotel es barato.
• [comp.] Dit hotel is goedkoper dan dat. — Este hotel es más barato que ese.
• [sup.] Dit is het goedkoopste hotel. — Es el hotel más barato.
• [gelijk] Dat is net zo goedkoop als dit. — Ese es igual de barato que este.
• [attr.] het goedkope hotel · een goedkoop hotel — el hotel barato · un hotel barato');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Compramos siempre la opción más barata. (presente)', 'SENTENCE', 'Ejemplo de "goedkoop" (sup.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Compramos siempre la opción más barata. (presente)' AND notes = 'Ejemplo de "goedkoop" (sup.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Compramos siempre la opción más barata. (presente)' AND notes = 'Ejemplo de "goedkoop" (sup.)' LIMIT 1),
    'nl_NL', 'We kopen altijd de goedkoopste optie.', 'we kóopen álteit de jutkóopste ópsi');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'barato, más barato, el más barato' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Compramos siempre la opción más barata. (presente)' AND notes = 'Ejemplo de "goedkoop" (sup.)' LIMIT 1),
        'EXAMPLE');

-- snel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'rápido, más rápido, el más rápido', 'WORD', 'Comparativos: snel', 'SNEL = rápido. Grados snel · sneller · snelst, y delante del sustantivo, con la -e, snelle.

📏 Las formas de snel:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De trein is **snel**. |
| 2 | delante del sustantivo | de **snelle** trein |
| 3 | comparativo + dan | Deze trein is **sneller** dan die. |
| 4 | superlativo con sustantivo | de **snelste** trein |
| 5 | superlativo suelto | Deze is het **snelst**. |

🔤 La regla que aplica: Vocal corta + una consonante, y la consonante se DOBLA para que la vocal siga corta, snel → sneller. En el superlativo no hace falta, snelst.

🔄 Su contrario, con tarjeta propia en el grupo: langzaam · langzamer · langzaamst. Se aprenden en pareja.

⚠️ El adjetivo sirve de adverbio sin tocarlo, Hij rijdt snel = conduce rápido. No hay -mente.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'rápido, más rápido, el más rápido');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'rápido, más rápido, el más rápido' LIMIT 1),
    'nl_NL', 'snel, sneller, snelst', 'snel, snéler, snelst', '• [can.] De trein is snel. — El tren es rápido.
• [comp.] Deze trein is sneller dan die. — Este tren es más rápido que ese.
• [sup.] Dit is de snelste trein. — Es el tren más rápido.
• [gelijk] Die is net zo snel als deze. — Ese es igual de rápido que este.
• [attr.] de snelle trein · een snelle trein — el tren rápido · un tren rápido');

INSERT INTO words_es (text, word_type, notes)
SELECT 'El tren es más rápido que el coche.', 'SENTENCE', 'Ejemplo de "snel" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El tren es más rápido que el coche.' AND notes = 'Ejemplo de "snel" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El tren es más rápido que el coche.' AND notes = 'Ejemplo de "snel" (comp.)' LIMIT 1),
    'nl_NL', 'De trein is sneller dan de auto.', 'de trein is snéler dan de áuto');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'rápido, más rápido, el más rápido' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'El tren es más rápido que el coche.' AND notes = 'Ejemplo de "snel" (comp.)' LIMIT 1),
        'EXAMPLE');

-- langzaam
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'lento, más lento, el más lento', 'WORD', 'Comparativos: langzaam', 'LANGZAAM = lento. Grados langzaam · langzamer · langzaamst, y delante del sustantivo, con la -e, langzame.

📏 Las formas de langzaam:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De computer is **langzaam**. |
| 2 | delante del sustantivo | de **langzame** computer |
| 3 | comparativo + dan | Deze computer is **langzamer** dan die. |
| 4 | superlativo con sustantivo | de **langzaamste** computer |
| 5 | superlativo suelto | Deze is het **langzaamst**. |

🔤 La regla que aplica: La vocal larga pierde una letra al abrirse la silaba, como en el plural, langzaam → langzamer. En el superlativo la silaba sigue cerrada y la vuelve a llevar, langzaamst.

🔄 Su contrario, con tarjeta propia en el grupo: snel · sneller · snelst. Se aprenden en pareja.

⚠️ Para pedir que hablen despacio, iets langzamer. Y rustig aan = con calma.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'lento, más lento, el más lento');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'lento, más lento, el más lento' LIMIT 1),
    'nl_NL', 'langzaam, langzamer, langzaamst', 'lángsaam, lángsaamer, lángsaamst', '• [can.] De computer is langzaam. — El ordenador es lento.
• [comp.] Deze computer is langzamer dan die. — Este ordenador es más lento que ese.
• [sup.] Dit is de langzaamste computer. — Es el ordenador más lento.
• [gelijk] Die is net zo langzaam als deze. — Ese es igual de lento que este.
• [attr.] de langzame computer · een langzame computer — el ordenador lento · un ordenador lento');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Puede hablar un poco más despacio? (formal, con "u")', 'SENTENCE', 'Ejemplo de "langzaam" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Puede hablar un poco más despacio? (formal, con "u")' AND notes = 'Ejemplo de "langzaam" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Puede hablar un poco más despacio? (formal, con "u")' AND notes = 'Ejemplo de "langzaam" (vraag)' LIMIT 1),
    'nl_NL', 'Kunt u iets langzamer praten?', 'kunt uu iits lángsaamer práaten');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'lento, más lento, el más lento' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿Puede hablar un poco más despacio? (formal, con "u")' AND notes = 'Ejemplo de "langzaam" (vraag)' LIMIT 1),
        'EXAMPLE');

-- warm
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cálido, más cálido, el más cálido', 'WORD', 'Comparativos: warm', 'WARM = cálido. Grados warm · warmer · warmst, y delante del sustantivo, con la -e, warme.

📏 Las formas de warm:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De jas is **warm**. |
| 2 | delante del sustantivo | de **warme** jas |
| 3 | comparativo + dan | Deze jas is **warmer** dan die. |
| 4 | superlativo con sustantivo | de **warmste** jas |
| 5 | superlativo suelto | Deze is het **warmst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, warm → warmer, y el superlativo con -st, warmst.

🔄 Su contrario, con tarjeta propia en el grupo: koud · kouder · koudst. Se aprenden en pareja.

⚠️ Tener calor es Ik heb het warm, con het. «Ik ben warm» no se dice así.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'cálido, más cálido, el más cálido');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'cálido, más cálido, el más cálido' LIMIT 1),
    'nl_NL', 'warm, warmer, warmst', 'warm, wármer, warmst', '• [can.] De jas is warm. — El abrigo es cálido.
• [comp.] Deze jas is warmer dan die. — Este abrigo es más cálido que ese.
• [sup.] Dit is de warmste jas. — Es el abrigo más cálido.
• [gelijk] Die is net zo warm als deze. — Ese es igual de cálido que este.
• [attr.] de warme jas · een warme jas — el abrigo cálido · un abrigo cálido');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Ayer fue el día más caluroso del año.', 'SENTENCE', 'Ejemplo de "warm" (sup.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ayer fue el día más caluroso del año.' AND notes = 'Ejemplo de "warm" (sup.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer fue el día más caluroso del año.' AND notes = 'Ejemplo de "warm" (sup.)' LIMIT 1),
    'nl_NL', 'Gisteren was de warmste dag van het jaar.', 'jísteren was de wármste daj fan et yaar');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'cálido, más cálido, el más cálido' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Ayer fue el día más caluroso del año.' AND notes = 'Ejemplo de "warm" (sup.)' LIMIT 1),
        'EXAMPLE');

-- koud
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'frío, más frío, el más frío', 'WORD', 'Comparativos: koud', 'KOUD = frío. Grados koud · kouder · koudst, y delante del sustantivo, con la -e, koude.

📏 Las formas de koud:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | Het bier is **koud**. |
| 2 | delante del sustantivo | het **koude** bier |
| 3 | con een y het-woord, SIN -e | een **koud** bier |
| 4 | comparativo + dan | Dit bier is **kouder** dan dat. |
| 5 | superlativo con sustantivo | het **koudste** bier |
| 6 | superlativo suelto | Dit is het **koudst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, koud → kouder, y el superlativo con -st, koudst.

🔄 Su contrario, con tarjeta propia en el grupo: warm · warmer · warmst. Se aprenden en pareja.

⚠️ Tener frío es Ik heb het koud. Ik ben koud diría que eres frío de carácter.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'frío, más frío, el más frío');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'frío, más frío, el más frío' LIMIT 1),
    'nl_NL', 'koud, kouder, koudst', 'kaut, káuder, kautst', '• [can.] Het bier is koud. — La cerveza es fría.
• [comp.] Dit bier is kouder dan dat. — Esta cerveza es más fría que esa.
• [sup.] Dit is het koudste bier. — Es la cerveza más fría.
• [gelijk] Dat is net zo koud als dit. — Esa es igual de fría que esta.
• [attr.] het koude bier · een koud bier — la cerveza fría · una cerveza fría');

INSERT INTO words_es (text, word_type, notes)
SELECT 'En enero hace más frío que en diciembre.', 'SENTENCE', 'Ejemplo de "koud" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'En enero hace más frío que en diciembre.' AND notes = 'Ejemplo de "koud" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'En enero hace más frío que en diciembre.' AND notes = 'Ejemplo de "koud" (comp.)' LIMIT 1),
    'nl_NL', 'In januari is het kouder dan in december.', 'in yánuwari is et káuder dan in desémber');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'frío, más frío, el más frío' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'En enero hace más frío que en diciembre.' AND notes = 'Ejemplo de "koud" (comp.)' LIMIT 1),
        'EXAMPLE');

-- hoog
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'alto, más alto, el más alto', 'WORD', 'Comparativos: hoog', 'HOOG = alto. Grados hoog · hoger · hoogst, y delante del sustantivo, con la -e, hoge.

📏 Las formas de hoog:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De berg is **hoog**. |
| 2 | delante del sustantivo | de **hoge** berg |
| 3 | comparativo + dan | Deze berg is **hoger** dan die. |
| 4 | superlativo con sustantivo | de **hoogste** berg |
| 5 | superlativo suelto | Deze is het **hoogst**. |

🔤 La regla que aplica: La vocal larga pierde una letra al abrirse la silaba, como en el plural, hoog → hoger. En el superlativo la silaba sigue cerrada y la vuelve a llevar, hoogst.

🔄 Su contrario, con tarjeta propia en el grupo: laag · lager · laagst. Se aprenden en pareja.

⚠️ hoog es alto para cosas, montañas, edificios y precios. Una persona alta es lang.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'alto, más alto, el más alto');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'alto, más alto, el más alto' LIMIT 1),
    'nl_NL', 'hoog, hoger, hoogst', 'hooj, hóojer, hoojst', '• [can.] De berg is hoog. — La montaña es alta.
• [comp.] Deze berg is hoger dan die. — Esta montaña es más alta que esa.
• [sup.] Dit is de hoogste berg. — Es la montaña más alta.
• [gelijk] Die is net zo hoog als deze. — Esa es igual de alta que esta.
• [attr.] de hoge berg · een hoge berg — la montaña alta · una montaña alta');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Esa torre es la más alta de la ciudad.', 'SENTENCE', 'Ejemplo de "hoog" (sup.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Esa torre es la más alta de la ciudad.' AND notes = 'Ejemplo de "hoog" (sup.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Esa torre es la más alta de la ciudad.' AND notes = 'Ejemplo de "hoog" (sup.)' LIMIT 1),
    'nl_NL', 'Die toren is de hoogste van de stad.', 'di tóoren is de hóojste fan de stat');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'alto, más alto, el más alto' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Esa torre es la más alta de la ciudad.' AND notes = 'Ejemplo de "hoog" (sup.)' LIMIT 1),
        'EXAMPLE');

-- laag
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'bajo, más bajo, el más bajo', 'WORD', 'Comparativos: laag', 'LAAG = bajo. Grados laag · lager · laagst, y delante del sustantivo, con la -e, lage.

📏 Las formas de laag:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De tafel is **laag**. |
| 2 | delante del sustantivo | de **lage** tafel |
| 3 | comparativo + dan | Deze tafel is **lager** dan die. |
| 4 | superlativo con sustantivo | de **laagste** tafel |
| 5 | superlativo suelto | Deze is het **laagst**. |

🔤 La regla que aplica: La vocal larga pierde una letra al abrirse la silaba, como en el plural, laag → lager. En el superlativo la silaba sigue cerrada y la vuelve a llevar, laagst.

🔄 Su contrario, con tarjeta propia en el grupo: hoog · hoger · hoogst. Se aprenden en pareja.

⚠️ laag también para precios y notas, lage prijzen. Una persona baja es klein.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'bajo, más bajo, el más bajo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'bajo, más bajo, el más bajo' LIMIT 1),
    'nl_NL', 'laag, lager, laagst', 'laaj, láajer, laajst', '• [can.] De tafel is laag. — La mesa es baja.
• [comp.] Deze tafel is lager dan die. — Esta mesa es más baja que esa.
• [sup.] Dit is de laagste tafel. — Es la mesa más baja.
• [gelijk] Die is net zo laag als deze. — Esa es igual de baja que esta.
• [attr.] de lage tafel · een lage tafel — la mesa baja · una mesa baja');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Los precios son más bajos en el mercado.', 'SENTENCE', 'Ejemplo de "laag" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los precios son más bajos en el mercado.' AND notes = 'Ejemplo de "laag" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Los precios son más bajos en el mercado.' AND notes = 'Ejemplo de "laag" (comp.)' LIMIT 1),
    'nl_NL', 'De prijzen zijn lager op de markt.', 'de préisen sein láajer op de markt');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'bajo, más bajo, el más bajo' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Los precios son más bajos en el mercado.' AND notes = 'Ejemplo de "laag" (comp.)' LIMIT 1),
        'EXAMPLE');

-- makkelijk
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'fácil, más fácil, el más fácil', 'WORD', 'Comparativos: makkelijk', 'MAKKELIJK = fácil. Grados makkelijk · makkelijker · makkelijkst, y delante del sustantivo, con la -e, makkelijke.

📏 Las formas de makkelijk:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De vraag is **makkelijk**. |
| 2 | delante del sustantivo | de **makkelijke** vraag |
| 3 | comparativo + dan | Deze vraag is **makkelijker** dan die. |
| 4 | superlativo con sustantivo | de **makkelijkste** vraag |
| 5 | superlativo suelto | Deze is het **makkelijkst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, makkelijk → makkelijker, y el superlativo con -st, makkelijkst.

🔄 Su contrario, con tarjeta propia en el grupo: moeilijk · moeilijker · moeilijkst. Se aprenden en pareja.

⚠️ En registro cuidado se escribe gemakkelijk; makkelijk es lo que se oye.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'fácil, más fácil, el más fácil');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'fácil, más fácil, el más fácil' LIMIT 1),
    'nl_NL', 'makkelijk, makkelijker, makkelijkst', 'mákelek, mákeleker, mákelekst', '• [can.] De vraag is makkelijk. — La pregunta es fácil.
• [comp.] Deze vraag is makkelijker dan die. — Esta pregunta es más fácil que esa.
• [sup.] Dit is de makkelijkste vraag. — Es la pregunta más fácil.
• [gelijk] Die is net zo makkelijk als deze. — Esa es igual de fácil que esta.
• [attr.] de makkelijke vraag · een makkelijke vraag — la pregunta fácil · una pregunta fácil');

INSERT INTO words_es (text, word_type, notes)
SELECT 'El neerlandés es más fácil de lo que pensaba.', 'SENTENCE', 'Ejemplo de "makkelijk" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El neerlandés es más fácil de lo que pensaba.' AND notes = 'Ejemplo de "makkelijk" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El neerlandés es más fácil de lo que pensaba.' AND notes = 'Ejemplo de "makkelijk" (comp.)' LIMIT 1),
    'nl_NL', 'Nederlands is makkelijker dan ik dacht.', 'néederlants is mákeleker dan ik dajt');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'fácil, más fácil, el más fácil' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'El neerlandés es más fácil de lo que pensaba.' AND notes = 'Ejemplo de "makkelijk" (comp.)' LIMIT 1),
        'EXAMPLE');

-- moeilijk
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'difícil, más difícil, el más difícil', 'WORD', 'Comparativos: moeilijk', 'MOEILIJK = difícil. Grados moeilijk · moeilijker · moeilijkst, y delante del sustantivo, con la -e, moeilijke.

📏 Las formas de moeilijk:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | Het examen is **moeilijk**. |
| 2 | delante del sustantivo | het **moeilijke** examen |
| 3 | con een y het-woord, SIN -e | een **moeilijk** examen |
| 4 | comparativo + dan | Dit examen is **moeilijker** dan dat. |
| 5 | superlativo con sustantivo | het **moeilijkste** examen |
| 6 | superlativo suelto | Dit is het **moeilijkst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, moeilijk → moeilijker, y el superlativo con -st, moeilijkst.

🔄 Su contrario, con tarjeta propia en el grupo: makkelijk · makkelijker · makkelijkst. Se aprenden en pareja.

⚠️ Detrás de un superlativo, lo que se dice con wat, no con dat: het moeilijkste wat ik ooit heb gedaan.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'difícil, más difícil, el más difícil');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'difícil, más difícil, el más difícil' LIMIT 1),
    'nl_NL', 'moeilijk, moeilijker, moeilijkst', 'múilek, múileker, múilekst', '• [can.] Het examen is moeilijk. — El examen es difícil.
• [comp.] Dit examen is moeilijker dan dat. — Este examen es más difícil que ese.
• [sup.] Dit is het moeilijkste examen. — Es el examen más difícil.
• [gelijk] Dat is net zo moeilijk als dit. — Ese es igual de difícil que este.
• [attr.] het moeilijke examen · een moeilijk examen — el examen difícil · un examen difícil');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Es lo más difícil que he hecho nunca.', 'SENTENCE', 'Ejemplo de "moeilijk" (sup.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Es lo más difícil que he hecho nunca.' AND notes = 'Ejemplo de "moeilijk" (sup.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Es lo más difícil que he hecho nunca.' AND notes = 'Ejemplo de "moeilijk" (sup.)' LIMIT 1),
    'nl_NL', 'Het is het moeilijkste wat ik ooit heb gedaan.', 'et is et múilekste wat ik óoit hep jedáan');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'difícil, más difícil, el más difícil' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Es lo más difícil que he hecho nunca.' AND notes = 'Ejemplo de "moeilijk" (sup.)' LIMIT 1),
        'EXAMPLE');

-- zwaar
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pesado, más pesado, el más pesado', 'WORD', 'Comparativos: zwaar', 'ZWAAR = pesado. Grados zwaar · zwaarder · zwaarst, y delante del sustantivo, con la -e, zware.

📏 Las formas de zwaar:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De koffer is **zwaar**. |
| 2 | delante del sustantivo | de **zware** koffer |
| 3 | comparativo + dan | Deze koffer is **zwaarder** dan die. |
| 4 | superlativo con sustantivo | de **zwaarste** koffer |
| 5 | superlativo suelto | Deze is het **zwaarst**. |

🔤 La regla que aplica: Acaba en -r, y la -r pide una d en medio, zwaar → zwaarder, nunca «zwaarer». El superlativo va normal, zwaarst.

🔄 Su contrario, con tarjeta propia en el grupo: licht · lichter · lichtst. Se aprenden en pareja.

⚠️ zwaar es también duro, een zware dag = un día duro.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pesado, más pesado, el más pesado');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'pesado, más pesado, el más pesado' LIMIT 1),
    'nl_NL', 'zwaar, zwaarder, zwaarst', 'suaar, suáarder, suaarst', '• [can.] De koffer is zwaar. — La maleta es pesada.
• [comp.] Deze koffer is zwaarder dan die. — Esta maleta es más pesada que esa.
• [sup.] Dit is de zwaarste koffer. — Es la maleta más pesada.
• [gelijk] Die is net zo zwaar als deze. — Esa es igual de pesada que esta.
• [attr.] de zware koffer · een zware koffer — la maleta pesada · una maleta pesada');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Tu maleta pesa más que la mía.', 'SENTENCE', 'Ejemplo de "zwaar" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Tu maleta pesa más que la mía.' AND notes = 'Ejemplo de "zwaar" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Tu maleta pesa más que la mía.' AND notes = 'Ejemplo de "zwaar" (comp.)' LIMIT 1),
    'nl_NL', 'Jouw koffer is zwaarder dan de mijne.', 'yáu kófer is suáarder dan de méine');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'pesado, más pesado, el más pesado' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Tu maleta pesa más que la mía.' AND notes = 'Ejemplo de "zwaar" (comp.)' LIMIT 1),
        'EXAMPLE');

-- licht
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ligero, más ligero, el más ligero', 'WORD', 'Comparativos: licht', 'LICHT = ligero. Grados licht · lichter · lichtst, y delante del sustantivo, con la -e, lichte.

📏 Las formas de licht:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De doos is **licht**. |
| 2 | delante del sustantivo | de **lichte** doos |
| 3 | comparativo + dan | Deze doos is **lichter** dan die. |
| 4 | superlativo con sustantivo | de **lichtste** doos |
| 5 | superlativo suelto | Deze is het **lichtst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, licht → lichter, y el superlativo con -st, lichtst.

🔄 Su contrario, con tarjeta propia en el grupo: zwaar · zwaarder · zwaarst. Se aprenden en pareja.

⚠️ licht es también claro de color, lichtblauw, y het licht es la luz.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ligero, más ligero, el más ligero');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ligero, más ligero, el más ligero' LIMIT 1),
    'nl_NL', 'licht, lichter, lichtst', 'lijt, líjter, lijtst', '• [can.] De doos is licht. — La caja es ligera.
• [comp.] Deze doos is lichter dan die. — Esta caja es más ligera que esa.
• [sup.] Dit is de lichtste doos. — Es la caja más ligera.
• [gelijk] Die is net zo licht als deze. — Esa es igual de ligera que esta.
• [attr.] de lichte doos · een lichte doos — la caja ligera · una caja ligera');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Llévate la bolsa más ligera.', 'SENTENCE', 'Ejemplo de "licht" (geb.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Llévate la bolsa más ligera.' AND notes = 'Ejemplo de "licht" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Llévate la bolsa más ligera.' AND notes = 'Ejemplo de "licht" (geb.)' LIMIT 1),
    'nl_NL', 'Neem de lichtste tas maar.', 'neem de líjtste tas maar');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ligero, más ligero, el más ligero' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Llévate la bolsa más ligera.' AND notes = 'Ejemplo de "licht" (geb.)' LIMIT 1),
        'EXAMPLE');

-- dik
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'gordo, más gordo, el más gordo', 'WORD', 'Comparativos: dik', 'DIK = gordo. Grados dik · dikker · dikst, y delante del sustantivo, con la -e, dikke.

📏 Las formas de dik:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | Het boek is **dik**. |
| 2 | delante del sustantivo | het **dikke** boek |
| 3 | con een y het-woord, SIN -e | een **dik** boek |
| 4 | comparativo + dan | Dit boek is **dikker** dan dat. |
| 5 | superlativo con sustantivo | het **dikste** boek |
| 6 | superlativo suelto | Dit is het **dikst**. |

🔤 La regla que aplica: Vocal corta + una consonante, y la consonante se DOBLA para que la vocal siga corta, dik → dikker. En el superlativo no hace falta, dikst.

🔄 Su contrario, con tarjeta propia en el grupo: dun · dunner · dunst. Se aprenden en pareja.

⚠️ dik es gordo de persona y grueso de cosa. Dicho a alguien, igual de directo que en español.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'gordo, más gordo, el más gordo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'gordo, más gordo, el más gordo' LIMIT 1),
    'nl_NL', 'dik, dikker, dikst', 'dik, díker, dikst', '• [can.] Het boek is dik. — El libro es gordo.
• [comp.] Dit boek is dikker dan dat. — Este libro es más gordo que ese.
• [sup.] Dit is het dikste boek. — Es el libro más gordo.
• [gelijk] Dat is net zo dik als dit. — Ese es igual de gordo que este.
• [attr.] het dikke boek · een dik boek — el libro gordo · un libro gordo');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Este libro es más gordo que aquel.', 'SENTENCE', 'Ejemplo de "dik" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Este libro es más gordo que aquel.' AND notes = 'Ejemplo de "dik" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Este libro es más gordo que aquel.' AND notes = 'Ejemplo de "dik" (comp.)' LIMIT 1),
    'nl_NL', 'Dit boek is dikker dan dat.', 'dit buk is díker dan dat');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'gordo, más gordo, el más gordo' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Este libro es más gordo que aquel.' AND notes = 'Ejemplo de "dik" (comp.)' LIMIT 1),
        'EXAMPLE');

-- dun
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'fino, más fino, el más fino', 'WORD', 'Comparativos: dun', 'DUN = fino. Grados dun · dunner · dunst, y delante del sustantivo, con la -e, dunne.

📏 Las formas de dun:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De muur is **dun**. |
| 2 | delante del sustantivo | de **dunne** muur |
| 3 | comparativo + dan | Deze muur is **dunner** dan die. |
| 4 | superlativo con sustantivo | de **dunste** muur |
| 5 | superlativo suelto | Deze is het **dunst**. |

🔤 La regla que aplica: Vocal corta + una consonante, y la consonante se DOBLA para que la vocal siga corta, dun → dunner. En el superlativo no hace falta, dunst.

🔄 Su contrario, con tarjeta propia en el grupo: dik · dikker · dikst. Se aprenden en pareja.

⚠️ dun es para cosas. Una persona delgada es slank, que es un elogio, o mager, que es flaca.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'fino, más fino, el más fino');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'fino, más fino, el más fino' LIMIT 1),
    'nl_NL', 'dun, dunner, dunst', 'dun, dúner, dunst', '• [can.] De muur is dun. — La pared es fina.
• [comp.] Deze muur is dunner dan die. — Esta pared es más fina que esa.
• [sup.] Dit is de dunste muur. — Es la pared más fina.
• [gelijk] Die is net zo dun als deze. — Esa es igual de fina que esta.
• [attr.] de dunne muur · een dunne muur — la pared fina · una pared fina');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Corta el pan más fino, por favor.', 'SENTENCE', 'Ejemplo de "dun" (geb.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Corta el pan más fino, por favor.' AND notes = 'Ejemplo de "dun" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Corta el pan más fino, por favor.' AND notes = 'Ejemplo de "dun" (geb.)' LIMIT 1),
    'nl_NL', 'Snijd het brood wat dunner, alsjeblieft.', 'sneit et broot wat dúner, alsyeblíift');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'fino, más fino, el más fino' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Corta el pan más fino, por favor.' AND notes = 'Ejemplo de "dun" (geb.)' LIMIT 1),
        'EXAMPLE');

-- sterk
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'fuerte, más fuerte, el más fuerte', 'WORD', 'Comparativos: sterk', 'STERK = fuerte. Grados sterk · sterker · sterkst, y delante del sustantivo, con la -e, sterke.

📏 Las formas de sterk:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De koffie is **sterk**. |
| 2 | delante del sustantivo | de **sterke** koffie |
| 3 | comparativo + dan | Deze koffie is **sterker** dan die. |
| 4 | superlativo con sustantivo | de **sterkste** koffie |
| 5 | superlativo suelto | Deze is het **sterkst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, sterk → sterker, y el superlativo con -st, sterkst.

🔄 Su contrario, con tarjeta propia en el grupo: zwak · zwakker · zwakst. Se aprenden en pareja.

⚠️ sterk vale para personas y bebidas, sterke koffie.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'fuerte, más fuerte, el más fuerte');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'fuerte, más fuerte, el más fuerte' LIMIT 1),
    'nl_NL', 'sterk, sterker, sterkst', 'sterk, stérker, sterkst', '• [can.] De koffie is sterk. — El café es fuerte.
• [comp.] Deze koffie is sterker dan die. — Este café es más fuerte que ese.
• [sup.] Dit is de sterkste koffie. — Es el café más fuerte.
• [gelijk] Die is net zo sterk als deze. — Ese es igual de fuerte que este.
• [attr.] de sterke koffie · een sterke koffie — el café fuerte · un café fuerte');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Él es más fuerte que su hermano mayor.', 'SENTENCE', 'Ejemplo de "sterk" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Él es más fuerte que su hermano mayor.' AND notes = 'Ejemplo de "sterk" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Él es más fuerte que su hermano mayor.' AND notes = 'Ejemplo de "sterk" (comp.)' LIMIT 1),
    'nl_NL', 'Hij is sterker dan zijn oudere broer.', 'hei is stérker dan sein áudere brur');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'fuerte, más fuerte, el más fuerte' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Él es más fuerte que su hermano mayor.' AND notes = 'Ejemplo de "sterk" (comp.)' LIMIT 1),
        'EXAMPLE');

-- zwak
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'débil, más débil, el más débil', 'WORD', 'Comparativos: zwak', 'ZWAK = débil. Grados zwak · zwakker · zwakst, y delante del sustantivo, con la -e, zwakke.

📏 Las formas de zwak:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | Het signaal is **zwak**. |
| 2 | delante del sustantivo | het **zwakke** signaal |
| 3 | con een y het-woord, SIN -e | een **zwak** signaal |
| 4 | comparativo + dan | Dit signaal is **zwakker** dan dat. |
| 5 | superlativo con sustantivo | het **zwakste** signaal |
| 6 | superlativo suelto | Dit is het **zwakst**. |

🔤 La regla que aplica: Vocal corta + una consonante, y la consonante se DOBLA para que la vocal siga corta, zwak → zwakker. En el superlativo no hace falta, zwakst.

🔄 Su contrario, con tarjeta propia en el grupo: sterk · sterker · sterkst. Se aprenden en pareja.

⚠️ zwak es también flojo en algo, Ik ben zwak in wiskunde = voy flojo en mates.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'débil, más débil, el más débil');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'débil, más débil, el más débil' LIMIT 1),
    'nl_NL', 'zwak, zwakker, zwakst', 'suak, suáker, suakst', '• [can.] Het signaal is zwak. — La señal es débil.
• [comp.] Dit signaal is zwakker dan dat. — Esta señal es más débil que esa.
• [sup.] Dit is het zwakste signaal. — Es la señal más débil.
• [gelijk] Dat is net zo zwak als dit. — Esa es igual de débil que esta.
• [attr.] het zwakke signaal · een zwak signaal — la señal débil · una señal débil');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi punto más débil es la gramática.', 'SENTENCE', 'Ejemplo de "zwak" (sup.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi punto más débil es la gramática.' AND notes = 'Ejemplo de "zwak" (sup.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi punto más débil es la gramática.' AND notes = 'Ejemplo de "zwak" (sup.)' LIMIT 1),
    'nl_NL', 'Mijn zwakste punt is de grammatica.', 'méin suákste punt is de jramátika');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'débil, más débil, el más débil' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi punto más débil es la gramática.' AND notes = 'Ejemplo de "zwak" (sup.)' LIMIT 1),
        'EXAMPLE');

-- rijk
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'rico, más rico, el más rico', 'WORD', 'Comparativos: rijk', 'RIJK = rico. Grados rijk · rijker · rijkst, y delante del sustantivo, con la -e, rijke.

📏 Las formas de rijk:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | Het land is **rijk**. |
| 2 | delante del sustantivo | het **rijke** land |
| 3 | con een y het-woord, SIN -e | een **rijk** land |
| 4 | comparativo + dan | Dit land is **rijker** dan dat. |
| 5 | superlativo con sustantivo | het **rijkste** land |
| 6 | superlativo suelto | Dit is het **rijkst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, rijk → rijker, y el superlativo con -st, rijkst.

🔄 Su contrario, con tarjeta propia en el grupo: arm · armer · armst. Se aprenden en pareja.

⚠️ rijk es rico de dinero. Rico de sabor es lekker. Y het rijk es el reino, Oostenrijk.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'rico, más rico, el más rico');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'rico, más rico, el más rico' LIMIT 1),
    'nl_NL', 'rijk, rijker, rijkst', 'reik, réiker, reikst', '• [can.] Het land is rijk. — El país es rico.
• [comp.] Dit land is rijker dan dat. — Este país es más rico que ese.
• [sup.] Dit is het rijkste land. — Es el país más rico.
• [gelijk] Dat is net zo rijk als dit. — Ese es igual de rico que este.
• [attr.] het rijke land · een rijk land — el país rico · un país rico');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Se han hecho ricos con su empresa. (ellos)', 'SENTENCE', 'Ejemplo de "rijk" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Se han hecho ricos con su empresa. (ellos)' AND notes = 'Ejemplo de "rijk" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Se han hecho ricos con su empresa. (ellos)' AND notes = 'Ejemplo de "rijk" (perf.)' LIMIT 1),
    'nl_NL', 'Ze zijn rijk geworden met hun bedrijf.', 'se sein reik jewórden met hun bedréif');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'rico, más rico, el más rico' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Se han hecho ricos con su empresa. (ellos)' AND notes = 'Ejemplo de "rijk" (perf.)' LIMIT 1),
        'EXAMPLE');

-- arm
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pobre, más pobre, el más pobre', 'WORD', 'Comparativos: arm', 'ARM = pobre. Grados arm · armer · armst, y delante del sustantivo, con la -e, arme.

📏 Las formas de arm:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De buurt is **arm**. |
| 2 | delante del sustantivo | de **arme** buurt |
| 3 | comparativo + dan | Deze buurt is **armer** dan die. |
| 4 | superlativo con sustantivo | de **armste** buurt |
| 5 | superlativo suelto | Deze is het **armst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, arm → armer, y el superlativo con -st, armst.

🔄 Su contrario, con tarjeta propia en el grupo: rijk · rijker · rijkst. Se aprenden en pareja.

⚠️ arm es también el brazo, de arm. Het arme kind = el pobre niño, de pena.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pobre, más pobre, el más pobre');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'pobre, más pobre, el más pobre' LIMIT 1),
    'nl_NL', 'arm, armer, armst', 'arm, ármer, armst', '• [can.] De buurt is arm. — El barrio es pobre.
• [comp.] Deze buurt is armer dan die. — Este barrio es más pobre que ese.
• [sup.] Dit is de armste buurt. — Es el barrio más pobre.
• [gelijk] Die is net zo arm als deze. — Ese es igual de pobre que este.
• [attr.] de arme buurt · een arme buurt — el barrio pobre · un barrio pobre');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Es uno de los países más pobres del mundo.', 'SENTENCE', 'Ejemplo de "arm" (sup.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Es uno de los países más pobres del mundo.' AND notes = 'Ejemplo de "arm" (sup.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Es uno de los países más pobres del mundo.' AND notes = 'Ejemplo de "arm" (sup.)' LIMIT 1),
    'nl_NL', 'Het is een van de armste landen van de wereld.', 'et is éen fan de ármste lánden fan de wéerelt');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'pobre, más pobre, el más pobre' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Es uno de los países más pobres del mundo.' AND notes = 'Ejemplo de "arm" (sup.)' LIMIT 1),
        'EXAMPLE');

-- blij
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'contento, más contento, el más contento', 'WORD', 'Comparativos: blij', 'BLIJ = contento. Grados blij · blijer · blijst, y delante del sustantivo, con la -e, blije.

📏 Las formas de blij:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | Het kind is **blij**. |
| 2 | delante del sustantivo | het **blije** kind |
| 3 | con een y het-woord, SIN -e | een **blij** kind |
| 4 | comparativo + dan | Dit kind is **blijer** dan dat. |
| 5 | superlativo con sustantivo | het **blijste** kind |
| 6 | superlativo suelto | Dit is het **blijst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, blij → blijer, y el superlativo con -st, blijst.

🔄 Su contrario, con tarjeta propia en el grupo: verdrietig · verdrietiger · verdrietigst. Se aprenden en pareja.

⚠️ blij es contento por algo concreto; gelukkig es feliz, de fondo.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'contento, más contento, el más contento');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'contento, más contento, el más contento' LIMIT 1),
    'nl_NL', 'blij, blijer, blijst', 'blei, bléier, bleist', '• [can.] Het kind is blij. — El niño es contento.
• [comp.] Dit kind is blijer dan dat. — Este niño es más contento que ese.
• [sup.] Dit is het blijste kind. — Es el niño más contento.
• [gelijk] Dat is net zo blij als dit. — Ese es igual de contento que este.
• [attr.] het blije kind · een blij kind — el niño contento · un niño contento');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Nunca la he visto tan contenta. (sin inv)', 'SENTENCE', 'Ejemplo de "blij" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Nunca la he visto tan contenta. (sin inv)' AND notes = 'Ejemplo de "blij" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Nunca la he visto tan contenta. (sin inv)' AND notes = 'Ejemplo de "blij" (perf.)' LIMIT 1),
    'nl_NL', 'Ik heb haar nog nooit zo blij gezien.', 'ik hep haar noj noit soo blei jesíin');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'contento, más contento, el más contento' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Nunca la he visto tan contenta. (sin inv)' AND notes = 'Ejemplo de "blij" (perf.)' LIMIT 1),
        'EXAMPLE');

-- verdrietig
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'triste, más triste, el más triste', 'WORD', 'Comparativos: verdrietig', 'VERDRIETIG = triste. Grados verdrietig · verdrietiger · verdrietigst, y delante del sustantivo, con la -e, verdrietige.

📏 Las formas de verdrietig:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | Het liedje is **verdrietig**. |
| 2 | delante del sustantivo | het **verdrietige** liedje |
| 3 | con een y het-woord, SIN -e | een **verdrietig** liedje |
| 4 | comparativo + dan | Dit liedje is **verdrietiger** dan dat. |
| 5 | superlativo con sustantivo | het **verdrietigste** liedje |
| 6 | superlativo suelto | Dit is het **verdrietigst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, verdrietig → verdrietiger, y el superlativo con -st, verdrietigst.

🔄 Su contrario, con tarjeta propia en el grupo: blij · blijer · blijst. Se aprenden en pareja.

⚠️ verdrietig es triste de persona. Para situaciones se dice triest, dat is triest.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'triste, más triste, el más triste');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'triste, más triste, el más triste' LIMIT 1),
    'nl_NL', 'verdrietig, verdrietiger, verdrietigst', 'ferdríitej, ferdríitejer, ferdríitejst', '• [can.] Het liedje is verdrietig. — La canción es triste.
• [comp.] Dit liedje is verdrietiger dan dat. — Esta canción es más triste que esa.
• [sup.] Dit is het verdrietigste liedje. — Es la canción más triste.
• [gelijk] Dat is net zo verdrietig als dit. — Esa es igual de triste que esta.
• [attr.] het verdrietige liedje · een verdrietig liedje — la canción triste · una canción triste');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Se puso triste cuando nos fuimos. (él)', 'SENTENCE', 'Ejemplo de "verdrietig" (imperf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Se puso triste cuando nos fuimos. (él)' AND notes = 'Ejemplo de "verdrietig" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Se puso triste cuando nos fuimos. (él)' AND notes = 'Ejemplo de "verdrietig" (imperf.)' LIMIT 1),
    'nl_NL', 'Hij werd verdrietig toen we weggingen.', 'hei wert ferdríitej tun we wéjingen');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'triste, más triste, el más triste' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Se puso triste cuando nos fuimos. (él)' AND notes = 'Ejemplo de "verdrietig" (imperf.)' LIMIT 1),
        'EXAMPLE');

-- vol
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'lleno, más lleno, el más lleno', 'WORD', 'Comparativos: vol', 'VOL = lleno. Grados vol · voller · volst, y delante del sustantivo, con la -e, volle.

📏 Las formas de vol:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De bus is **vol**. |
| 2 | delante del sustantivo | de **volle** bus |
| 3 | comparativo + dan | Deze bus is **voller** dan die. |
| 4 | superlativo con sustantivo | de **volste** bus |
| 5 | superlativo suelto | Deze is het **volst**. |

🔤 La regla que aplica: Vocal corta + una consonante, y la consonante se DOBLA para que la vocal siga corta, vol → voller. En el superlativo no hace falta, volst.

🔄 Su contrario, con tarjeta propia en el grupo: leeg · leger · leegst. Se aprenden en pareja.

⚠️ Lleno de comer es Ik zit vol, con zitten.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'lleno, más lleno, el más lleno');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'lleno, más lleno, el más lleno' LIMIT 1),
    'nl_NL', 'vol, voller, volst', 'fol, fóler, folst', '• [can.] De bus is vol. — El autobús es lleno.
• [comp.] Deze bus is voller dan die. — Este autobús es más lleno que ese.
• [sup.] Dit is de volste bus. — Es el autobús más lleno.
• [gelijk] Die is net zo vol als deze. — Ese es igual de lleno que este.
• [attr.] de volle bus · een volle bus — el autobús lleno · un autobús lleno');

INSERT INTO words_es (text, word_type, notes)
SELECT 'El tren estaba más lleno que nunca.', 'SENTENCE', 'Ejemplo de "vol" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El tren estaba más lleno que nunca.' AND notes = 'Ejemplo de "vol" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El tren estaba más lleno que nunca.' AND notes = 'Ejemplo de "vol" (comp.)' LIMIT 1),
    'nl_NL', 'De trein was voller dan ooit.', 'de trein was fóler dan óoit');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'lleno, más lleno, el más lleno' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'El tren estaba más lleno que nunca.' AND notes = 'Ejemplo de "vol" (comp.)' LIMIT 1),
        'EXAMPLE');

-- leeg
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'vacío, más vacío, el más vacío', 'WORD', 'Comparativos: leeg', 'LEEG = vacío. Grados leeg · leger · leegst, y delante del sustantivo, con la -e, lege.

📏 Las formas de leeg:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De fles is **leeg**. |
| 2 | delante del sustantivo | de **lege** fles |
| 3 | comparativo + dan | Deze fles is **leger** dan die. |
| 4 | superlativo con sustantivo | de **leegste** fles |
| 5 | superlativo suelto | Deze is het **leegst**. |

🔤 La regla que aplica: La vocal larga pierde una letra al abrirse la silaba, como en el plural, leeg → leger. En el superlativo la silaba sigue cerrada y la vuelve a llevar, leegst.

🔄 Su contrario, con tarjeta propia en el grupo: vol · voller · volst. Se aprenden en pareja.

⚠️ leger es más vacío y también el ejército, het leger. Lo decide el contexto.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'vacío, más vacío, el más vacío');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'vacío, más vacío, el más vacío' LIMIT 1),
    'nl_NL', 'leeg, leger, leegst', 'leej, léejer, leejst', '• [can.] De fles is leeg. — La botella es vacía.
• [comp.] Deze fles is leger dan die. — Esta botella es más vacía que esa.
• [sup.] Dit is de leegste fles. — Es la botella más vacía.
• [gelijk] Die is net zo leeg als deze. — Esa es igual de vacía que esta.
• [attr.] de lege fles · een lege fles — la botella vacía · una botella vacía');

INSERT INTO words_es (text, word_type, notes)
SELECT 'El frigorífico está más vacío que la semana pasada.', 'SENTENCE', 'Ejemplo de "leeg" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El frigorífico está más vacío que la semana pasada.' AND notes = 'Ejemplo de "leeg" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El frigorífico está más vacío que la semana pasada.' AND notes = 'Ejemplo de "leeg" (comp.)' LIMIT 1),
    'nl_NL', 'De koelkast is leger dan vorige week.', 'de kúlkast is léejer dan fóoreje week');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'vacío, más vacío, el más vacío' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'El frigorífico está más vacío que la semana pasada.' AND notes = 'Ejemplo de "leeg" (comp.)' LIMIT 1),
        'EXAMPLE');

-- nat
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'mojado, más mojado, el más mojado', 'WORD', 'Comparativos: nat', 'NAT = mojado. Grados nat · natter · natst, y delante del sustantivo, con la -e, natte.

📏 Las formas de nat:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De handdoek is **nat**. |
| 2 | delante del sustantivo | de **natte** handdoek |
| 3 | comparativo + dan | Deze handdoek is **natter** dan die. |
| 4 | superlativo con sustantivo | de **natste** handdoek |
| 5 | superlativo suelto | Deze is het **natst**. |

🔤 La regla que aplica: Vocal corta + una consonante, y la consonante se DOBLA para que la vocal siga corta, nat → natter. En el superlativo no hace falta, natst.

🔄 Su contrario, con tarjeta propia en el grupo: droog · droger · droogst. Se aprenden en pareja.

⚠️ nat es mojado; húmedo es vochtig.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'mojado, más mojado, el más mojado');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'mojado, más mojado, el más mojado' LIMIT 1),
    'nl_NL', 'nat, natter, natst', 'nat, náter, natst', '• [can.] De handdoek is nat. — La toalla es mojada.
• [comp.] Deze handdoek is natter dan die. — Esta toalla es más mojada que esa.
• [sup.] Dit is de natste handdoek. — Es la toalla más mojada.
• [gelijk] Die is net zo nat als deze. — Esa es igual de mojada que esta.
• [attr.] de natte handdoek · een natte handdoek — la toalla mojada · una toalla mojada');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me he mojado más que tú.', 'SENTENCE', 'Ejemplo de "nat" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me he mojado más que tú.' AND notes = 'Ejemplo de "nat" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me he mojado más que tú.' AND notes = 'Ejemplo de "nat" (perf.)' LIMIT 1),
    'nl_NL', 'Ik ben natter geworden dan jij.', 'ik ben náter jewórden dan yei');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'mojado, más mojado, el más mojado' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me he mojado más que tú.' AND notes = 'Ejemplo de "nat" (perf.)' LIMIT 1),
        'EXAMPLE');

-- droog
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'seco, más seco, el más seco', 'WORD', 'Comparativos: droog', 'DROOG = seco. Grados droog · droger · droogst, y delante del sustantivo, con la -e, droge.

📏 Las formas de droog:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | Het brood is **droog**. |
| 2 | delante del sustantivo | het **droge** brood |
| 3 | con een y het-woord, SIN -e | een **droog** brood |
| 4 | comparativo + dan | Dit brood is **droger** dan dat. |
| 5 | superlativo con sustantivo | het **droogste** brood |
| 6 | superlativo suelto | Dit is het **droogst**. |

🔤 La regla que aplica: La vocal larga pierde una letra al abrirse la silaba, como en el plural, droog → droger. En el superlativo la silaba sigue cerrada y la vuelve a llevar, droogst.

🔄 Su contrario, con tarjeta propia en el grupo: nat · natter · natst. Se aprenden en pareja.

⚠️ droog es también seco de humor, droge humor, muy holandés. Y de droger es la secadora.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'seco, más seco, el más seco');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'seco, más seco, el más seco' LIMIT 1),
    'nl_NL', 'droog, droger, droogst', 'drooj, dróojer, droojst', '• [can.] Het brood is droog. — El pan es seco.
• [comp.] Dit brood is droger dan dat. — Este pan es más seco que ese.
• [sup.] Dit is het droogste brood. — Es el pan más seco.
• [gelijk] Dat is net zo droog als dit. — Ese es igual de seco que este.
• [attr.] het droge brood · een droog brood — el pan seco · un pan seco');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Este verano ha sido el más seco en años.', 'SENTENCE', 'Ejemplo de "droog" (sup.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Este verano ha sido el más seco en años.' AND notes = 'Ejemplo de "droog" (sup.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Este verano ha sido el más seco en años.' AND notes = 'Ejemplo de "droog" (sup.)' LIMIT 1),
    'nl_NL', 'Deze zomer was de droogste in jaren.', 'déese sóomer was de dróojste in yáaren');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'seco, más seco, el más seco' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Este verano ha sido el más seco en años.' AND notes = 'Ejemplo de "droog" (sup.)' LIMIT 1),
        'EXAMPLE');

-- vroeg
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'temprano, más temprano, lo más temprano', 'WORD', 'Comparativos: vroeg', 'VROEG = temprano. Grados vroeg · vroeger · vroegst, y delante del sustantivo, con la -e, vroege.

📏 Las formas de vroeg:

| # | grado | forma |
|---|---|---|
| 1 | positivo | **vroeg** |
| 2 | comparativo | **vroeger** |
| 3 | superlativo | **vroegst** |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, vroeg → vroeger, y el superlativo con -st, vroegst.

🔄 Su contrario, con tarjeta propia en el grupo: laat · later · laatst. Se aprenden en pareja.

⚠️ ¡Trampa! vroeger es más temprano y también antes, antiguamente: Vroeger woonde ik er = antes vivía allí.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'temprano, más temprano, lo más temprano');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'temprano, más temprano, lo más temprano' LIMIT 1),
    'nl_NL', 'vroeg, vroeger, vroegst', 'fruj, frúujer, frujst', '• [can.] Ik sta altijd vroeg op. — Siempre me levanto temprano.
• [comp.] Kun je iets vroeger komen? — ¿Puedes venir un poco antes?
• [sup.] Wat is de vroegste trein? — ¿Cuál es el tren más temprano?
• [vroeger] Vroeger rookte ik. — Antes fumaba.
• [uitdr.] vroeg of laat — tarde o temprano.');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mañana tengo que levantarme más temprano.', 'SENTENCE', 'Ejemplo de "vroeg" (refl.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mañana tengo que levantarme más temprano.' AND notes = 'Ejemplo de "vroeg" (refl.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mañana tengo que levantarme más temprano.' AND notes = 'Ejemplo de "vroeg" (refl.)' LIMIT 1),
    'nl_NL', 'Morgen moet ik vroeger opstaan.', 'mórjen mut ik frúujer ópstaan');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'temprano, más temprano, lo más temprano' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mañana tengo que levantarme más temprano.' AND notes = 'Ejemplo de "vroeg" (refl.)' LIMIT 1),
        'EXAMPLE');

-- laat
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tarde, más tarde, lo más tarde', 'WORD', 'Comparativos: laat', 'LAAT = tarde. Grados laat · later · laatst, y delante del sustantivo, con la -e, late.

📏 Las formas de laat:

| # | grado | forma |
|---|---|---|
| 1 | positivo | **laat** |
| 2 | comparativo | **later** |
| 3 | superlativo | **laatst** |

🔤 La regla que aplica: La vocal larga pierde una letra al abrirse la silaba, como en el plural, laat → later. En el superlativo la silaba sigue cerrada y la vuelve a llevar, laatst.

🔄 Su contrario, con tarjeta propia en el grupo: vroeg · vroeger · vroegst. Se aprenden en pareja.

⚠️ ¡Trampa! laatst es lo más tarde y también último o el otro día. Y Hoe laat is het? = ¿qué hora es?

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'tarde, más tarde, lo más tarde');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'tarde, más tarde, lo más tarde' LIMIT 1),
    'nl_NL', 'laat, later, laatst', 'laat, láater, laatst', '• [can.] Het is al laat. — Ya es tarde.
• [comp.] We zien elkaar later. — Nos vemos luego.
• [sup.] Dit is de laatste keer. — Es la última vez.
• [vraag] Hoe laat is het? — ¿Qué hora es?
• [uitdr.] Beter laat dan nooit. — Más vale tarde que nunca.');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Te llamo más tarde.', 'SENTENCE', 'Ejemplo de "laat" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Te llamo más tarde.' AND notes = 'Ejemplo de "laat" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Te llamo más tarde.' AND notes = 'Ejemplo de "laat" (can.)' LIMIT 1),
    'nl_NL', 'Ik bel je later.', 'ik bel ye láater');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'tarde, más tarde, lo más tarde' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Te llamo más tarde.' AND notes = 'Ejemplo de "laat" (can.)' LIMIT 1),
        'EXAMPLE');

-- breed
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ancho, más ancho, el más ancho', 'WORD', 'Comparativos: breed', 'BREED = ancho. Grados breed · breder · breedst, y delante del sustantivo, con la -e, brede.

📏 Las formas de breed:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De straat is **breed**. |
| 2 | delante del sustantivo | de **brede** straat |
| 3 | comparativo + dan | Deze straat is **breder** dan die. |
| 4 | superlativo con sustantivo | de **breedste** straat |
| 5 | superlativo suelto | Deze is het **breedst**. |

🔤 La regla que aplica: La vocal larga pierde una letra al abrirse la silaba, como en el plural, breed → breder. En el superlativo la silaba sigue cerrada y la vuelve a llevar, breedst.

🔄 Su contrario, con tarjeta propia en el grupo: smal · smaller · smalst. Se aprenden en pareja.

⚠️ Ancho de ropa que queda grande se dice wijd; breed es de medida.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ancho, más ancho, el más ancho');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ancho, más ancho, el más ancho' LIMIT 1),
    'nl_NL', 'breed, breder, breedst', 'breet, bréeder, breetst', '• [can.] De straat is breed. — La calle es ancha.
• [comp.] Deze straat is breder dan die. — Esta calle es más ancha que esa.
• [sup.] Dit is de breedste straat. — Es la calle más ancha.
• [gelijk] Die is net zo breed als deze. — Esa es igual de ancha que esta.
• [attr.] de brede straat · een brede straat — la calle ancha · una calle ancha');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Esta calle es más ancha que la nuestra.', 'SENTENCE', 'Ejemplo de "breed" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Esta calle es más ancha que la nuestra.' AND notes = 'Ejemplo de "breed" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta calle es más ancha que la nuestra.' AND notes = 'Ejemplo de "breed" (comp.)' LIMIT 1),
    'nl_NL', 'Deze straat is breder dan de onze.', 'déese straat is bréeder dan de ónse');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ancho, más ancho, el más ancho' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Esta calle es más ancha que la nuestra.' AND notes = 'Ejemplo de "breed" (comp.)' LIMIT 1),
        'EXAMPLE');

-- smal
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estrecho, más estrecho, el más estrecho', 'WORD', 'Comparativos: smal', 'SMAL = estrecho. Grados smal · smaller · smalst, y delante del sustantivo, con la -e, smalle.

📏 Las formas de smal:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De gang is **smal**. |
| 2 | delante del sustantivo | de **smalle** gang |
| 3 | comparativo + dan | Deze gang is **smaller** dan die. |
| 4 | superlativo con sustantivo | de **smalste** gang |
| 5 | superlativo suelto | Deze is het **smalst**. |

🔤 La regla que aplica: Vocal corta + una consonante, y la consonante se DOBLA para que la vocal siga corta, smal → smaller. En el superlativo no hace falta, smalst.

🔄 Su contrario, con tarjeta propia en el grupo: breed · breder · breedst. Se aprenden en pareja.

⚠️ Las casas de los canales son smal y hoog, porque se pagaba impuesto por la fachada.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estrecho, más estrecho, el más estrecho');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'estrecho, más estrecho, el más estrecho' LIMIT 1),
    'nl_NL', 'smal, smaller, smalst', 'smal, smáler, smalst', '• [can.] De gang is smal. — El pasillo es estrecho.
• [comp.] Deze gang is smaller dan die. — Este pasillo es más estrecho que ese.
• [sup.] Dit is de smalste gang. — Es el pasillo más estrecho.
• [gelijk] Die is net zo smal als deze. — Ese es igual de estrecho que este.
• [attr.] de smalle gang · een smalle gang — el pasillo estrecho · un pasillo estrecho');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Las casas de Ámsterdam son muy estrechas.', 'SENTENCE', 'Ejemplo de "smal" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Las casas de Ámsterdam son muy estrechas.' AND notes = 'Ejemplo de "smal" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Las casas de Ámsterdam son muy estrechas.' AND notes = 'Ejemplo de "smal" (can.)' LIMIT 1),
    'nl_NL', 'De huizen in Amsterdam zijn heel smal.', 'de háusen in ámsterdam sein heel smal');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'estrecho, más estrecho, el más estrecho' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Las casas de Ámsterdam son muy estrechas.' AND notes = 'Ejemplo de "smal" (can.)' LIMIT 1),
        'EXAMPLE');

-- mooi
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'bonito, más bonito, el más bonito', 'WORD', 'Comparativos: mooi', 'MOOI = bonito. Grados mooi · mooier · mooist, y delante del sustantivo, con la -e, mooie.

📏 Las formas de mooi:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De stad is **mooi**. |
| 2 | delante del sustantivo | de **mooie** stad |
| 3 | comparativo + dan | Deze stad is **mooier** dan die. |
| 4 | superlativo con sustantivo | de **mooiste** stad |
| 5 | superlativo suelto | Deze is het **mooist**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, mooi → mooier, y el superlativo con -st, mooist.

🔄 Su contrario, con tarjeta propia en el grupo: lelijk · lelijker · lelijkst. Se aprenden en pareja.

⚠️ mooi es bonito y también ¡genial!, Dat is mooi! Y mooi weer = buen tiempo.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'bonito, más bonito, el más bonito');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'bonito, más bonito, el más bonito' LIMIT 1),
    'nl_NL', 'mooi, mooier, mooist', 'mooi, móoier, mooist', '• [can.] De stad is mooi. — La ciudad es bonita.
• [comp.] Deze stad is mooier dan die. — Esta ciudad es más bonita que esa.
• [sup.] Dit is de mooiste stad. — Es la ciudad más bonita.
• [gelijk] Die is net zo mooi als deze. — Esa es igual de bonita que esta.
• [attr.] de mooie stad · een mooie stad — la ciudad bonita · una ciudad bonita');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Hoy estás más guapa que nunca.', 'SENTENCE', 'Ejemplo de "mooi" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Hoy estás más guapa que nunca.' AND notes = 'Ejemplo de "mooi" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Hoy estás más guapa que nunca.' AND notes = 'Ejemplo de "mooi" (comp.)' LIMIT 1),
    'nl_NL', 'Vandaag ben je mooier dan ooit.', 'fandáaj ben ye móoier dan óoit');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'bonito, más bonito, el más bonito' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Hoy estás más guapa que nunca.' AND notes = 'Ejemplo de "mooi" (comp.)' LIMIT 1),
        'EXAMPLE');

-- lelijk
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'feo, más feo, el más feo', 'WORD', 'Comparativos: lelijk', 'LELIJK = feo. Grados lelijk · lelijker · lelijkst, y delante del sustantivo, con la -e, lelijke.

📏 Las formas de lelijk:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | Het gebouw is **lelijk**. |
| 2 | delante del sustantivo | het **lelijke** gebouw |
| 3 | con een y het-woord, SIN -e | een **lelijk** gebouw |
| 4 | comparativo + dan | Dit gebouw is **lelijker** dan dat. |
| 5 | superlativo con sustantivo | het **lelijkste** gebouw |
| 6 | superlativo suelto | Dit is het **lelijkst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, lelijk → lelijker, y el superlativo con -st, lelijkst.

🔄 Su contrario, con tarjeta propia en el grupo: mooi · mooier · mooist. Se aprenden en pareja.

⚠️ lelijk es de aspecto. Feo de comportamiento es gemeen.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'feo, más feo, el más feo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'feo, más feo, el más feo' LIMIT 1),
    'nl_NL', 'lelijk, lelijker, lelijkst', 'léelek, léeleker, léelekst', '• [can.] Het gebouw is lelijk. — El edificio es feo.
• [comp.] Dit gebouw is lelijker dan dat. — Este edificio es más feo que ese.
• [sup.] Dit is het lelijkste gebouw. — Es el edificio más feo.
• [gelijk] Dat is net zo lelijk als dit. — Ese es igual de feo que este.
• [attr.] het lelijke gebouw · een lelijk gebouw — el edificio feo · un edificio feo');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Es el jersey más feo que tengo.', 'SENTENCE', 'Ejemplo de "lelijk" (sup.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Es el jersey más feo que tengo.' AND notes = 'Ejemplo de "lelijk" (sup.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Es el jersey más feo que tengo.' AND notes = 'Ejemplo de "lelijk" (sup.)' LIMIT 1),
    'nl_NL', 'Het is de lelijkste trui die ik heb.', 'et is de léelekste trui di ik hep');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'feo, más feo, el más feo' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Es el jersey más feo que tengo.' AND notes = 'Ejemplo de "lelijk" (sup.)' LIMIT 1),
        'EXAMPLE');

-- lekker
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'sabroso, más sabroso, el más sabroso', 'WORD', 'Comparativos: lekker', 'LEKKER = sabroso. Grados lekker · lekkerder · lekkerst, y delante del sustantivo, con la -e, lekkere.

📏 Las formas de lekker:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De taart is **lekker**. |
| 2 | delante del sustantivo | de **lekkere** taart |
| 3 | comparativo + dan | Deze taart is **lekkerder** dan die. |
| 4 | superlativo con sustantivo | de **lekkerste** taart |
| 5 | superlativo suelto | Deze is het **lekkerst**. |

🔤 La regla que aplica: Acaba en -r, y la -r pide una d en medio, lekker → lekkerder, nunca «lekkerer». El superlativo va normal, lekkerst.

🔄 Su contrario, con tarjeta propia en el grupo: smerig · smeriger · smerigst. Se aprenden en pareja.

⚠️ lekker no es solo comida: lekker weer = buen tiempo, lekker slapen = dormir a gusto.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'sabroso, más sabroso, el más sabroso');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'sabroso, más sabroso, el más sabroso' LIMIT 1),
    'nl_NL', 'lekker, lekkerder, lekkerst', 'léker, lékerder, lékerst', '• [can.] De taart is lekker. — La tarta es sabrosa.
• [comp.] Deze taart is lekkerder dan die. — Esta tarta es más sabrosa que esa.
• [sup.] Dit is de lekkerste taart. — Es la tarta más sabrosa.
• [gelijk] Die is net zo lekker als deze. — Esa es igual de sabrosa que esta.
• [attr.] de lekkere taart · een lekkere taart — la tarta sabrosa · una tarta sabrosa');

INSERT INTO words_es (text, word_type, notes)
SELECT 'La sopa de tu madre está más rica que la mía.', 'SENTENCE', 'Ejemplo de "lekker" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'La sopa de tu madre está más rica que la mía.' AND notes = 'Ejemplo de "lekker" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'La sopa de tu madre está más rica que la mía.' AND notes = 'Ejemplo de "lekker" (comp.)' LIMIT 1),
    'nl_NL', 'De soep van je moeder is lekkerder dan de mijne.', 'de sup fan ye múder is lékerder dan de méine');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'sabroso, más sabroso, el más sabroso' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'La sopa de tu madre está más rica que la mía.' AND notes = 'Ejemplo de "lekker" (comp.)' LIMIT 1),
        'EXAMPLE');

-- smerig
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'sucio, más sucio, el más sucio', 'WORD', 'Comparativos: smerig', 'SMERIG = sucio. Grados smerig · smeriger · smerigst, y delante del sustantivo, con la -e, smerige.

📏 Las formas de smerig:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De keuken is **smerig**. |
| 2 | delante del sustantivo | de **smerige** keuken |
| 3 | comparativo + dan | Deze keuken is **smeriger** dan die. |
| 4 | superlativo con sustantivo | de **smerigste** keuken |
| 5 | superlativo suelto | Deze is het **smerigst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, smerig → smeriger, y el superlativo con -st, smerigst.

🔄 Su contrario, con tarjeta propia en el grupo: lekker · lekkerder · lekkerst. Se aprenden en pareja.

⚠️ smerig es sucio y asqueroso. Su sinónimo vies es más frecuente al hablar.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'sucio, más sucio, el más sucio');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'sucio, más sucio, el más sucio' LIMIT 1),
    'nl_NL', 'smerig, smeriger, smerigst', 'sméerej, sméerejer, sméerejst', '• [can.] De keuken is smerig. — La cocina es sucia.
• [comp.] Deze keuken is smeriger dan die. — Esta cocina es más sucia que esa.
• [sup.] Dit is de smerigste keuken. — Es la cocina más sucia.
• [gelijk] Die is net zo smerig als deze. — Esa es igual de sucia que esta.
• [attr.] de smerige keuken · een smerige keuken — la cocina sucia · una cocina sucia');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Tu coche está aún más sucio que el mío.', 'SENTENCE', 'Ejemplo de "smerig" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Tu coche está aún más sucio que el mío.' AND notes = 'Ejemplo de "smerig" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Tu coche está aún más sucio que el mío.' AND notes = 'Ejemplo de "smerig" (comp.)' LIMIT 1),
    'nl_NL', 'Jouw auto is nog smeriger dan de mijne.', 'yáu áuto is noj sméerejer dan de méine');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'sucio, más sucio, el más sucio' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Tu coche está aún más sucio que el mío.' AND notes = 'Ejemplo de "smerig" (comp.)' LIMIT 1),
        'EXAMPLE');

-- leuk
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'divertido, más divertido, el más divertido', 'WORD', 'Comparativos: leuk', 'LEUK = divertido. Grados leuk · leuker · leukst, y delante del sustantivo, con la -e, leuke.

📏 Las formas de leuk:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | Het spel is **leuk**. |
| 2 | delante del sustantivo | het **leuke** spel |
| 3 | con een y het-woord, SIN -e | een **leuk** spel |
| 4 | comparativo + dan | Dit spel is **leuker** dan dat. |
| 5 | superlativo con sustantivo | het **leukste** spel |
| 6 | superlativo suelto | Dit is het **leukst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, leuk → leuker, y el superlativo con -st, leukst.

🔄 Su contrario, con tarjeta propia en el grupo: saai · saaier · saaist. Se aprenden en pareja.

⚠️ leuk es la palabra comodín, divertido, agradable, mono. Leuk je te ontmoeten = encantado de conocerte.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'divertido, más divertido, el más divertido');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'divertido, más divertido, el más divertido' LIMIT 1),
    'nl_NL', 'leuk, leuker, leukst', 'léuk, léuker, léukst', '• [can.] Het spel is leuk. — El juego es divertido.
• [comp.] Dit spel is leuker dan dat. — Este juego es más divertido que ese.
• [sup.] Dit is het leukste spel. — Es el juego más divertido.
• [gelijk] Dat is net zo leuk als dit. — Ese es igual de divertido que este.
• [attr.] het leuke spel · een leuk spel — el juego divertido · un juego divertido');

INSERT INTO words_es (text, word_type, notes)
SELECT 'La fiesta fue más divertida de lo que esperábamos.', 'SENTENCE', 'Ejemplo de "leuk" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'La fiesta fue más divertida de lo que esperábamos.' AND notes = 'Ejemplo de "leuk" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'La fiesta fue más divertida de lo que esperábamos.' AND notes = 'Ejemplo de "leuk" (comp.)' LIMIT 1),
    'nl_NL', 'Het feest was leuker dan we hadden verwacht.', 'et feest was léuker dan we háden ferwájt');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'divertido, más divertido, el más divertido' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'La fiesta fue más divertida de lo que esperábamos.' AND notes = 'Ejemplo de "leuk" (comp.)' LIMIT 1),
        'EXAMPLE');

-- saai
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'aburrido, más aburrido, el más aburrido', 'WORD', 'Comparativos: saai', 'SAAI = aburrido. Grados saai · saaier · saaist, y delante del sustantivo, con la -e, saaie.

📏 Las formas de saai:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De les is **saai**. |
| 2 | delante del sustantivo | de **saaie** les |
| 3 | comparativo + dan | Deze les is **saaier** dan die. |
| 4 | superlativo con sustantivo | de **saaiste** les |
| 5 | superlativo suelto | Deze is het **saaist**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, saai → saaier, y el superlativo con -st, saaist.

🔄 Su contrario, con tarjeta propia en el grupo: leuk · leuker · leukst. Se aprenden en pareja.

⚠️ saai es aburrido de cosa. Aburrirse es zich vervelen, Ik verveel me.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'aburrido, más aburrido, el más aburrido');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'aburrido, más aburrido, el más aburrido' LIMIT 1),
    'nl_NL', 'saai, saaier, saaist', 'saai, sáaier, saaist', '• [can.] De les is saai. — La clase es aburrida.
• [comp.] Deze les is saaier dan die. — Esta clase es más aburrida que esa.
• [sup.] Dit is de saaiste les. — Es la clase más aburrida.
• [gelijk] Die is net zo saai als deze. — Esa es igual de aburrida que esta.
• [attr.] de saaie les · een saaie les — la clase aburrida · una clase aburrida');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Es la clase más aburrida de la semana.', 'SENTENCE', 'Ejemplo de "saai" (sup.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Es la clase más aburrida de la semana.' AND notes = 'Ejemplo de "saai" (sup.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Es la clase más aburrida de la semana.' AND notes = 'Ejemplo de "saai" (sup.)' LIMIT 1),
    'nl_NL', 'Het is de saaiste les van de week.', 'et is de sáaiste les fan de week');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'aburrido, más aburrido, el más aburrido' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Es la clase más aburrida de la semana.' AND notes = 'Ejemplo de "saai" (sup.)' LIMIT 1),
        'EXAMPLE');

-- druk
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ajetreado, más ajetreado, el más ajetreado', 'WORD', 'Comparativos: druk', 'DRUK = ajetreado. Grados druk · drukker · drukst, y delante del sustantivo, con la -e, drukke.

📏 Las formas de druk:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | De dag is **druk**. |
| 2 | delante del sustantivo | de **drukke** dag |
| 3 | comparativo + dan | Deze dag is **drukker** dan die. |
| 4 | superlativo con sustantivo | de **drukste** dag |
| 5 | superlativo suelto | Deze is het **drukst**. |

🔤 La regla que aplica: Vocal corta + una consonante, y la consonante se DOBLA para que la vocal siga corta, druk → drukker. En el superlativo no hace falta, drukst.

🔄 Su contrario, con tarjeta propia en el grupo: rustig · rustiger · rustigst. Se aprenden en pareja.

⚠️ Estar liado es Ik heb het druk, con het. Ik ben druk dice que eres movido de carácter.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ajetreado, más ajetreado, el más ajetreado');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ajetreado, más ajetreado, el más ajetreado' LIMIT 1),
    'nl_NL', 'druk, drukker, drukst', 'druk, drúker, drukst', '• [can.] De dag is druk. — El día es ajetreado.
• [comp.] Deze dag is drukker dan die. — Este día es más ajetreado que ese.
• [sup.] Dit is de drukste dag. — Es el día más ajetreado.
• [gelijk] Die is net zo druk als deze. — Ese es igual de ajetreado que este.
• [attr.] de drukke dag · een drukke dag — el día ajetreado · un día ajetreado');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Esta semana estoy más liado que nunca.', 'SENTENCE', 'Ejemplo de "druk" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Esta semana estoy más liado que nunca.' AND notes = 'Ejemplo de "druk" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta semana estoy más liado que nunca.' AND notes = 'Ejemplo de "druk" (comp.)' LIMIT 1),
    'nl_NL', 'Deze week heb ik het drukker dan ooit.', 'déese week hep ik et drúker dan óoit');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ajetreado, más ajetreado, el más ajetreado' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Esta semana estoy más liado que nunca.' AND notes = 'Ejemplo de "druk" (comp.)' LIMIT 1),
        'EXAMPLE');

-- rustig
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tranquilo, más tranquilo, el más tranquilo', 'WORD', 'Comparativos: rustig', 'RUSTIG = tranquilo. Grados rustig · rustiger · rustigst, y delante del sustantivo, con la -e, rustige.

📏 Las formas de rustig:

| # | uso | ejemplo |
|---|---|---|
| 1 | suelto, detrás del verbo | Het dorp is **rustig**. |
| 2 | delante del sustantivo | het **rustige** dorp |
| 3 | con een y het-woord, SIN -e | een **rustig** dorp |
| 4 | comparativo + dan | Dit dorp is **rustiger** dan dat. |
| 5 | superlativo con sustantivo | het **rustigste** dorp |
| 6 | superlativo suelto | Dit is het **rustigst**. |

🔤 La regla que aplica: Se añade -er tal cual, sin tocar nada, rustig → rustiger, y el superlativo con -st, rustigst.

🔄 Su contrario, con tarjeta propia en el grupo: druk · drukker · drukst. Se aprenden en pareja.

⚠️ Rustig aan! = ¡con calma!, y Doe rustig = tranquilízate.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'tranquilo, más tranquilo, el más tranquilo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'tranquilo, más tranquilo, el más tranquilo' LIMIT 1),
    'nl_NL', 'rustig, rustiger, rustigst', 'rústej, rústejer, rústejst', '• [can.] Het dorp is rustig. — El pueblo es tranquilo.
• [comp.] Dit dorp is rustiger dan dat. — Este pueblo es más tranquilo que ese.
• [sup.] Dit is het rustigste dorp. — Es el pueblo más tranquilo.
• [gelijk] Dat is net zo rustig als dit. — Ese es igual de tranquilo que este.
• [attr.] het rustige dorp · een rustig dorp — el pueblo tranquilo · un pueblo tranquilo');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Vivimos en el barrio más tranquilo de la ciudad. (presente)', 'SENTENCE', 'Ejemplo de "rustig" (sup.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Vivimos en el barrio más tranquilo de la ciudad. (presente)' AND notes = 'Ejemplo de "rustig" (sup.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Vivimos en el barrio más tranquilo de la ciudad. (presente)' AND notes = 'Ejemplo de "rustig" (sup.)' LIMIT 1),
    'nl_NL', 'We wonen in de rustigste wijk van de stad.', 'we wóonen in de rústejste weik fan de stat');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'tranquilo, más tranquilo, el más tranquilo' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Vivimos en el barrio más tranquilo de la ciudad. (presente)' AND notes = 'Ejemplo de "rustig" (sup.)' LIMIT 1),
        'EXAMPLE');

-- veel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'mucho, más, el que más', 'WORD', 'Comparativos: veel', 'VEEL = mucho. Grados veel · meer · meest, y delante del sustantivo va SIN -e, veel mensen, veel tijd.

📏 Las formas de veel:

| # | grado | forma |
|---|---|---|
| 1 | positivo | **veel** |
| 2 | comparativo | **meer** |
| 3 | superlativo | **meest** |

🔤 La regla que aplica: Irregular del todo, veel → meer → meest. Se aprende de memoria, como en español bueno → mejor.

🔄 Su contrario, con tarjeta propia en el grupo: weinig · minder · minst. Se aprenden en pareja.

⚠️ meer es más y también el lago, het meer. Y met z''n velen = siendo muchos, la única forma frecuente con -e.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'mucho, más, el que más');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'mucho, más, el que más' LIMIT 1),
    'nl_NL', 'veel, meer, meest', 'feel, meer, meest', '• [can.] Ik heb veel werk. — Tengo mucho trabajo.
• [comp.] Hij verdient meer dan ik. — Gana más que yo.
• [sup.] Wie heeft de meeste punten? — ¿Quién tiene más puntos?
• [adv.] Dat is veel beter. — Eso es mucho mejor.
• [uitdr.] Veel plezier! — ¡Que te diviertas!');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Cuanto más practicas, más aprendes.', 'SENTENCE', 'Ejemplo de "veel" (hoe hoe)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cuanto más practicas, más aprendes.' AND notes = 'Ejemplo de "veel" (hoe hoe)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuanto más practicas, más aprendes.' AND notes = 'Ejemplo de "veel" (hoe hoe)' LIMIT 1),
    'nl_NL', 'Hoe meer je oefent, hoe meer je leert.', 'hu meer ye úfent, hu meer ye leert');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'mucho, más, el que más' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Cuanto más practicas, más aprendes.' AND notes = 'Ejemplo de "veel" (hoe hoe)' LIMIT 1),
        'EXAMPLE');

-- weinig
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'poco, menos, el que menos', 'WORD', 'Comparativos: weinig', 'WEINIG = poco. Grados weinig · minder · minst, y delante del sustantivo va SIN -e, weinig mensen, weinig tijd.

📏 Las formas de weinig:

| # | grado | forma |
|---|---|---|
| 1 | positivo | **weinig** |
| 2 | comparativo | **minder** |
| 3 | superlativo | **minst** |

🔤 La regla que aplica: Irregular del todo, weinig → minder → minst. Se aprende de memoria, como en español bueno → mejor.

🔄 Su contrario, con tarjeta propia en el grupo: veel · meer · meest. Se aprenden en pareja.

⚠️ Te weinig = demasiado poco. Y minder también es peor de salud, Het gaat minder met haar.

📊 Los tres grados del adjetivo:

El neerlandes forma el comparativo y el superlativo pegando letras al adjetivo, sin las palabras sueltas mas y el mas del español.

| positivo | comparativo | superlativo | |
|---|---|---|---|
| klein | klein**er** | (het) klein**st** | pequeño |
| groot | gro**ter** | groot**st** | grande, con una o menos |
| mooi | mooi**er** | mooi**st** | bonito |
| duur | duur**der** | duur**st** | caro, la -r pide -der |
| dik | dik**ker** | dik**st** | gordo, consonante doblada |
| lief | lie**ver** | lief**st** | dulce, la f se vuelve v |
| **goed** | **beter** | **best** | irregular |
| **veel** | **meer** | **meest** | irregular |
| **weinig** | **minder** | **minst** | irregular |
| **graag** | **liever** | **liefst** | irregular |

📐 Las reglas ortograficas del comparativo son las mismas del plural: vocal larga en silaba abierta pierde una letra (groot → groter), consonante tras vocal corta se dobla (dik → dikker), la f pasa a v y la s a z (lief → liever, vies → viezer), y los acabados en -r meten una d (duur → duurder).

⚠️ Con adjetivos LARGOS o acabados en -s, -sch, -st o -isch, el superlativo va con meest delante: het meest interessante boek, de meest logische oplossing. Con los cortos nunca: es grootst y no «meest groot».

🎭 het -st o de -ste, la distincion que casi nadie explica:
• Sin sustantivo, comparando estados — het + -st, sin -e. Deze is het grootst. In juli is het het warmst.
• Con sustantivo detras o sustantivado — de of het + -ste. Dit is de grootste auto. Hij is de beste van de klas.

⚖️ Y comparar: dan o als, que es la duda de siempre:
• Cosas DISTINTAS, con -er detras → dan. Deze is duurder DAN die.
• Cosas IGUALES, adjetivo pelado → als. Deze is net zo duur ALS die, of even duur als die.

🔑 El truco que casi nunca falla: Mira el adjetivo. Si lleva -er pegado, detras va dan. Si va pelado con net zo o even delante, detras va als. Nunca «duurder als», por mucho que se oiga en la calle.

📌 Y las tres escaleras que van con comparativo:
• hoe … hoe … — cuanto mas… mas… Hoe eerder, hoe beter.
• steeds … — cada vez mas… Het wordt steeds kouder.
• veel, iets, net iets + comparativo — mucho, algo, un pelin mas. veel duurder, iets ouder, net iets beter.

⚠️ El superlativo compara siempre con VAN, nunca con in: de mooiste stad van Nederland, de beste van de klas, de jongste van ons drieen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'poco, menos, el que menos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'poco, menos, el que menos' LIMIT 1),
    'nl_NL', 'weinig, minder, minst', 'wéinej, mínder, minst', '• [can.] We hebben weinig tijd. — Tenemos poco tiempo.
• [comp.] Ik eet minder vlees dan vroeger. — Como menos carne que antes.
• [sup.] Wie heeft het minst betaald? — ¿Quién ha pagado menos?
• [te] Ik heb te weinig geslapen. — He dormido demasiado poco.
• [uitdr.] op z''n minst — como mínimo.');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Este mes he gastado menos que el anterior.', 'SENTENCE', 'Ejemplo de "weinig" (comp.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Este mes he gastado menos que el anterior.' AND notes = 'Ejemplo de "weinig" (comp.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Este mes he gastado menos que el anterior.' AND notes = 'Ejemplo de "weinig" (comp.)' LIMIT 1),
    'nl_NL', 'Deze maand heb ik minder uitgegeven dan vorige maand.', 'déese maant hep ik mínder áutjejeefen dan fóoreje maant');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'poco, menos, el que menos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Este mes he gastado menos que el anterior.' AND notes = 'Ejemplo de "weinig" (comp.)' LIMIT 1),
        'EXAMPLE');

-- grupos: el 39 y generic, para las palabras y sus frases
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT e.id, g.id FROM words_es e, word_groups g
WHERE g.title IN ('comparativos - klein, kleiner, het kleinst', 'generic')
  AND (e.notes LIKE 'Comparativos: %'
       OR e.id IN (SELECT r.word_es_id_b FROM word_es_relations r
                   JOIN words_es p ON p.id = r.word_es_id_a
                   WHERE p.notes LIKE 'Comparativos: %' AND r.relation_type = 'EXAMPLE'));
