-- Learn Languages App - Migration
-- Migration: 20260907000013-grupo-comparativos
-- Description: Eduardo: "crea otro grupo con los comparativos pequeño el mas pequeño es
--   mas pequeño que etc con los adjetivos mas usados".
--
--   No habia grupo de comparativos y en el mazo solo existian tres sueltos (827 eerder
--   dan, 890 kouder dan, 892 steeds minder). Se crea el grupo con los tres grados, las
--   reglas de formacion y los adjetivos mas frecuentes.
--
--   18 tarjetas PHRASE: el positivo con la regla de la -e, el comparativo con -er y dan,
--   el superlativo con sustantivo (de kleinste huis van…), el superlativo predicativo
--   (het grootst, sin -e, que es la distincion que casi nadie explica), la igualdad con
--   net zo … als y even … als, la edad con oud, hoe … hoe … en version corta y con frase
--   entera, steeds + comparativo, los cuatro irregulares (goed/veel/weinig/graag), de
--   beste con van, meer dan, minder dan, liever (que es como se dice preferir), la regla
--   de la -der tras -r, el meest de los adjetivos largos, el superlativo geografico y
--   lekkerder con toda la familia de lekker.
--
--   Un bloque compartido con la tabla de los tres grados, las reglas ortograficas (que son
--   las mismas del plural), el meest de los largos, la distincion het -st / de -ste, el
--   dan frente a als y las tres escaleras (hoe…hoe, steeds, veel/iets + comparativo).
--
--   Recoge ademas el dan COMPARATIVO que se dejo apuntado en el grupo de consecuencia
--   (20260907000012), para que los tres dan queden separados: el consecutivo, el
--   comparativo y el de las locuciones (wat dan ook).

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'comparativos - klein, kleiner, het kleinst',
       'Los tres grados del adjetivo en neerlandes, que se forman pegando letras y no con palabras sueltas como el mas del español: klein, kleiner, het kleinst. Con las reglas ortograficas (que son las mismas del plural: groot pierde una o, dik dobla la k, lief pasa a liever y los acabados en -r meten una d, duurder), los cuatro irregulares goed/beter/best, veel/meer/meest, weinig/minder/minst y graag/liever/liefst, el meest de los adjetivos largos, la distincion entre het grootst sin sustantivo y de grootste con el, la comparacion de igualdad con net zo … als frente a la de desigualdad con dan, y las escaleras hoe … hoe … y steeds + comparativo. Incluye los adjetivos mas usados y el aviso de que el superlativo compara siempre con van y nunca con in',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'comparativos - klein, kleiner, het kleinst');

-- =============================================================================
-- 2. Las 18 tarjetas
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'mi casa es pequeña', 'PHRASE', 'Comparativo: positivo',
'Mijn huis is klein = mi casa es pequeña. Es el grado POSITIVO, el adjetivo tal cual, y es el punto de partida de los otros dos: klein, kleiner, het kleinst.

📐 Aqui el adjetivo va detras del verbo (predicativo) y por eso NO lleva -e: Mijn huis is klein. Si fuera delante del sustantivo (atributivo) si la llevaria: een klein huis, mijn kleine huis.

⚠️ La regla de la -e es de las que mas se falla y va aparte del comparativo:
• Detras del verbo, nunca -e: Het huis is klein.
• Delante del sustantivo con de o con posesivo, siempre -e: de kleine kamer, mijn kleine huis.
• Delante de un sustantivo HET con een, sin -e: een klein huis.
• Delante de un sustantivo DE con een, con -e: een kleine kamer.

📋 Los adjetivos que mas vas a usar, con su pareja: groot/klein (grande/pequeño), goed/slecht (bueno/malo), mooi/lelijk (bonito/feo), duur/goedkoop (caro/barato), snel/langzaam (rapido/lento), oud/jong (viejo/joven), lang/kort (largo/corto), hoog/laag (alto/bajo), warm/koud (caliente/frio), moeilijk/makkelijk (dificil/facil), druk/rustig (ajetreado/tranquilo), sterk/zwak (fuerte/debil).

🏋️ Ejercicio: «una habitacion pequeña» → een ___ kamer. (Respuesta: kleine. Es palabra de, asi que lleva -e con een.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: positivo');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'mi casa es más pequeña que la tuya', 'PHRASE', 'Comparativo: mas que',
'Mijn huis is kleiner dan het jouwe = mi casa es mas pequeña que la tuya. El comparativo se hace con -ER pegado al adjetivo, y el que se dice con DAN.

📐 La formula entera: adjetivo + -er + dan + con quien comparas. klein → kleiner dan. Sin mas, mucho mas facil que en español, donde hay que poner mas … que.

⚠️ Es dan y NO als. En el habla popular se oye groter als en algunas zonas, pero esta considerado incorrecto y chirria: es el error clasico que los propios neerlandeses se corrigen entre ellos. Con als se comparan cosas IGUALES, con dan cosas DISTINTAS.

📋 Los posesivos independientes, ya que salen aqui: het jouwe (el tuyo), het mijne (el mio), het zijne (el suyo de el), het hare (el suyo de ella), het onze (el nuestro), het hunne (el suyo de ellos). En el habla se sustituyen por die van jou, die van mij, que suena mas natural: Mijn huis is kleiner dan dat van jou.

🏋️ Ejercicio: «esta bici es mas rapida que la mia» → Deze fiets is ___ ___ die van mij. (Respuesta: sneller dan.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: mas que');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'esta es la casa más pequeña de la calle', 'PHRASE', 'Comparativo: superlativo con sustantivo',
'Dit is het kleinste huis van de straat = esta es la casa mas pequeña de la calle. El superlativo se hace con -ST, y delante de un sustantivo lleva ademas la -E y su articulo: het kleinste huis.

📐 La formula: het of de + adjetivo + -ste + sustantivo + VAN + el conjunto. Fijate en que el de del español es VAN y no in: de mooiste stad van Nederland, het kleinste huis van de straat.

⚠️ El articulo lo manda el SUSTANTIVO, no el superlativo: het huis → het kleinste huis; de straat → de kleinste straat. Es la misma regla de siempre.

🎭 Y la distincion fina que casi nadie explica: het kleinst frente a de kleinste.
• Con sustantivo detras, o sustantivado, va con -e y su articulo: Dit is de grootste auto. Hij is de grootste.
• Sin sustantivo, comparando estados, va het + -st sin -e: Deze auto is het grootst. In juli is het het warmst.

🏋️ Ejercicio: «el libro mas caro de la tienda» → het ___ boek ___ de winkel. (Respuesta: duurste … van.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: superlativo con sustantivo');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'este es el más grande', 'PHRASE', 'Comparativo: het grootst predicativo',
'Deze is het grootst = este es el mas grande. Aqui no hay sustantivo detras, solo se compara, y por eso el superlativo va con HET + -st y SIN -e, aunque el sujeto sea de-woord.

🎭 Las dos formas del superlativo, que es lo que mas despista:
• het + -st, sin -e — cuando comparas estados y no hay sustantivo. Deze is het grootst. In juli is het het warmst. Dat vind ik het lekkerst.
• de of het + -ste, con -e — cuando hay sustantivo detras o el adjetivo se sustantiva. Dit is de grootste auto. Hij is de grootste van de klas.

⚠️ Fijate en que el het de het grootst es fijo y no depende del genero: Deze auto is het grootst aunque auto sea de-woord. No es un articulo, es parte de la formula.

📋 Las que oiras a diario con esta forma:
• Wat vind je het lekkerst? — ¿Qué es lo que más te gusta?
• Dat doet het meest pijn. — Eso es lo que más duele.
• In de winter is het het koudst. — En invierno es cuando más frío hace.

🏋️ Ejercicio: «en agosto es cuando mas calor hace» → In augustus is het ___ ___. (Respuesta: het warmst.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: het grootst predicativo');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'este bolso es igual de caro que ese', 'PHRASE', 'Comparativo: igualdad net zo als',
'Deze tas is net zo duur als die = este bolso es igual de caro que ese. Cuando las dos cosas son IGUALES, el adjetivo se queda en positivo y el que pasa a ser ALS.

📐 Las dos formulas de la igualdad, intercambiables:
• net zo + adjetivo + als — Deze tas is net zo duur als die.
• even + adjetivo + als — Deze tas is even duur als die.

⚠️ Aqui esta la clave de dan o als, que es la pregunta que todo el mundo se hace:
• Cosas DISTINTAS, comparativo con -er → dan. Deze tas is duurder DAN die.
• Cosas IGUALES, adjetivo en positivo → als. Deze tas is net zo duur ALS die.
La regla se recuerda sola: si el adjetivo lleva -er, detras va dan; si va pelado, detras va als.

📋 Y la desigualdad por abajo: minder … dan. Deze tas is minder duur dan die (este bolso es menos caro que ese), aunque en neerlandes suena mas natural darle la vuelta: Die tas is duurder.

🏋️ Ejercicio: «soy tan alto como tu» → Ik ben ___ ___ lang ___ jij. (Respuesta: net zo … als.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: igualdad net zo als');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ella tiene la misma edad que yo', 'PHRASE', 'Comparativo: even oud als',
'Zij is even oud als ik = ella tiene la misma edad que yo. Literalmente es igual de vieja que yo, porque el neerlandes mide la edad con oud y no con tener años.

⚠️ La edad NO se dice con hebben. No existe «Ik heb dertig jaar». Se dice Ik ben dertig, o Ik ben dertig jaar oud si quieres ser explicito. Y se pregunta Hoe oud ben je?, literalmente ¿cuan viejo eres?

📋 Todo lo que necesitas para hablar de edad:
• Hoe oud ben je? — ¿Cuántos años tienes?
• Ik ben vijfendertig. — Tengo treinta y cinco.
• Zij is even oud als ik. — Tiene mi misma edad.
• Hij is twee jaar ouder dan ik. — Es dos años mayor que yo.
• Ze is de jongste van ons drieën. — Es la más joven de las tres.
• Ik ben in 1990 geboren. — Nací en 1990.

📐 Y el detalle del comparativo con medida: la cantidad va DELANTE, twee jaar ouder dan ik, igual que en español dos años mayor que yo. Tambien iets ouder (algo mayor), veel ouder (mucho mayor), net iets jonger (un pelin mas joven).

🏋️ Ejercicio: «es tres años menor que yo» → Hij is drie jaar ___ ___ ik. (Respuesta: jonger dan.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: even oud als');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cuanto antes, mejor', 'PHRASE', 'Comparativo: hoe hoe',
'Hoe eerder, hoe beter = cuanto antes, mejor. Es la formula de la proporcion: cuanto mas de una cosa, mas de la otra. Y es de las que se dicen enteras, sin pensarlas.

📐 El molde es hoe + comparativo, hoe + comparativo. Los dos miembros llevan comparativo, y en la version corta no hay ni verbo: Hoe eerder, hoe beter. Hoe meer, hoe beter. Hoe sneller, hoe beter.

📋 Con frase completa, el primer miembro manda el verbo al final y el segundo invierte:
• Hoe langer je wacht, hoe duurder het wordt. — Cuanto más esperes, más caro será.
• Hoe meer je oefent, hoe beter je wordt. — Cuanto más practiques, mejor serás.
• Hoe ouder ik word, hoe minder ik weet. — Cuanto más viejo me hago, menos sé.

🎭 La variante formal es hoe … des te …: Hoe meer hij las, des te minder begreep hij. Se ve escrita, pero al hablar se usa hoe … hoe.

⚠️ Y no lo confundas con el hoe de pregunta (Hoe gaat het?) ni con el de manera (Hoe doe je dat?). Aqui hoe siempre viene en pareja y siempre con comparativo detras.

🏋️ Ejercicio: «cuanto mas duermo, mejor me siento» → ___ meer ik slaap, ___ beter voel ik me. (Respuesta: Hoe … hoe.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: hoe hoe');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cada vez hace más frío', 'PHRASE', 'Comparativo: steeds',
'Het wordt steeds kouder = cada vez hace mas frio. steeds + comparativo es la formula del proceso: algo que va aumentando poco a poco.

📐 El molde: steeds + comparativo. steeds kouder (cada vez mas frio), steeds beter (cada vez mejor), steeds minder (cada vez menos), steeds duurder (cada vez mas caro).

📋 Las variantes, que dicen lo mismo con distinto tono:
• steeds kouder — cada vez más frío. La normal.
• steeds maar kouder — cada vez más y más frío, con insistencia.
• alsmaar kouder — lo mismo, algo más coloquial.
• hoe langer hoe kouder — literalmente cuanto más tiempo más frío, muy usada.

⚠️ Ojo con el verbo: para el cambio de estado se usa worden y no zijn. Het WORDT steeds kouder es se está poniendo cada vez más frío; Het IS koud es hace frío, sin proceso. Es la misma diferencia de ser y ponerse.

💬 Y steeds tiene otra vida sin comparativo: nog steeds es todavía. Hij woont er nog steeds (todavía vive ahí). No lo mezcles con el steeds del proceso.

🏋️ Ejercicio: «cada vez leo menos» → Ik lees ___ ___. (Respuesta: steeds minder.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: steeds');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'este libro es mejor que la película', 'PHRASE', 'Comparativo: beter irregular',
'Dit boek is beter dan de film = este libro es mejor que la pelicula. goed no hace «goeder»: es irregular y hace beter, best. Es el irregular que mas vas a usar.

📊 Los cuatro irregulares, que hay que aprenderse de memoria porque no siguen ninguna regla:

| positivo | comparativo | superlativo | que significa |
|---|---|---|---|
| **goed** | **beter** | **best** | bueno, mejor, el mejor |
| **veel** | **meer** | **meest** | mucho, mas, lo mas |
| **weinig** | **minder** | **minst** | poco, menos, lo menos |
| **graag** | **liever** | **liefst** | con gusto, preferir, lo que mas |

⚠️ graag es el mas raro para un hispanohablante porque no es un adjetivo sino un adverbio, y su comparativo liever se traduce por el verbo preferir: Ik drink liever thee es prefiero te, literalmente bebo mas a gusto te.

💬 Y best tiene una segunda vida muy holandesa como adverbio de atenuacion: Het is best lekker es está bastante bueno, no lo mejor. Igual que wel, baja la intensidad en vez de subirla.

🏋️ Ejercicio: «esto es mejor que aquello» → Dit is ___ ___ dat. (Respuesta: beter dan.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: beter irregular');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'es la mejor película del año', 'PHRASE', 'Comparativo: de beste',
'Dit is de beste film van het jaar = es la mejor pelicula del año. best con sustantivo detras se convierte en de beste, con su -e y su articulo.

📐 Otra vez el VAN del superlativo: de beste film VAN het jaar, no «in het jaar». El conjunto con el que comparas siempre va con van: van de klas, van Nederland, van allemaal, van het jaar.

📋 Los superlativos que se dicen sin pensarlos:
• de beste — el mejor. Hij is de beste van de klas.
• het beste — lo mejor, y tambien la despedida Het beste! (que te vaya bien)
• op zijn best — en su mejor momento.
• best wel — bastante, en realidad. Het is best wel duur.
• Doe je best! — ¡Haz lo que puedas!, ¡esfuérzate!

⚠️ Cuidado con het beste y het best, que se parecen: het beste is lo mejor como cosa (Ik wens je het beste) y het best es adverbial (Dat vind ik het best).

🏋️ Ejercicio: «el mejor de la clase» → de ___ ___ de klas. (Respuesta: beste van.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: de beste');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tiene más dinero que yo', 'PHRASE', 'Comparativo: meer dan',
'Hij heeft meer geld dan ik = tiene mas dinero que yo. meer es el comparativo irregular de veel, y con sustantivos incontables como geld va tal cual, sin nada mas.

📋 veel y su familia con sustantivos, que cambia segun sean contables o no:
• veel geld — mucho dinero. (incontable)
• veel mensen — mucha gente. (contable, plural)
• meer geld dan ik — más dinero que yo.
• de meeste mensen — la mayoría de la gente.
• het meeste geld — la mayor parte del dinero.

⚠️ Fijate en que detras de dan va el pronombre en forma de SUJETO: dan IK, dan JIJ, dan HIJ. En español dirias que yo, tambien sujeto, asi que aqui coinciden. Lo que no se dice es «dan mij».

💬 meer aparece en un monton de formulas: niet meer (ya no), nooit meer (nunca mas), steeds meer (cada vez mas), hoe meer hoe beter, onder meer (entre otras cosas), meer dan genoeg (mas que suficiente).

🏋️ Ejercicio: «tengo mas tiempo que el» → Ik heb ___ tijd ___ hij. (Respuesta: meer … dan.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: meer dan');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tengo menos tiempo que el año pasado', 'PHRASE', 'Comparativo: minder dan',
'Ik heb minder tijd dan vorig jaar = tengo menos tiempo que el año pasado. minder es el comparativo irregular de weinig, y es el menos de todo: cantidad, calidad e intensidad.

📋 minder en sus tres usos:
• Con sustantivo — minder tijd, minder mensen, minder geld.
• Con adjetivo, como el menos … de la comparacion — minder duur (menos caro), minder gezond (menos sano).
• Solo, como adverbio — Ik lees steeds minder (cada vez leo menos).

⚠️ Con adjetivos, el neerlandes prefiere darle la vuelta antes que usar minder: en vez de Deze is minder duur dan die, se dice Die is duurder. minder + adjetivo existe y es correcto, pero suena mas a traduccion; con sustantivos, en cambio, es lo normal.

📋 Y las expresiones de tiempo que salen aqui: vorig jaar (el año pasado), vorige week (la semana pasada), vorige maand (el mes pasado), volgend jaar (el año que viene), afgelopen zomer (el verano pasado).

🏋️ Ejercicio: «cada vez tengo menos ganas» → Ik heb ___ ___ zin. (Respuesta: steeds minder.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: minder dan');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'prefiero té a café', 'PHRASE', 'Comparativo: liever',
'Ik drink liever thee dan koffie = prefiero te a cafe. liever es el comparativo de graag, y es la manera normal de decir preferir en neerlandes: no hay un verbo preferir de uso diario.

📐 El molde: sujeto + VERBO + liever + lo que prefieres + dan + lo otro. Ik drink liever thee dan koffie. Fijate en que el verbo es el de la accion (drink, eet, ga), no un verbo de preferir.

📊 graag, liever, liefst en accion:
• Ik drink graag thee. — Me gusta el té. (positivo)
• Ik drink liever thee. — Prefiero el té. (comparativo)
• Ik drink het liefst thee. — Lo que más me gusta es el té. (superlativo)

📋 Y sus formulas mas usadas:
• Ik zou graag… willen — Querría… La formula estrella para pedir con educación.
• Graag! — ¡Sí, gracias! Es como se acepta algo que te ofrecen.
• Graag gedaan. — De nada.
• Liever niet. — Mejor no.
• Het liefst zou ik… — Lo que más me gustaría sería…

⚠️ Liever niet es de las respuestas mas utiles y educadas para decir que no: literalmente preferiblemente no. Suena mucho mejor que un nee seco.

🏋️ Ejercicio: «prefiero ir en bici» → Ik ga ___ met de fiets. (Respuesta: liever.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: liever');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'esta bici es más cara que esa', 'PHRASE', 'Comparativo: duurder der',
'Deze fiets is duurder dan die = esta bici es mas cara que esa. Fijate en duurDER, con una D de mas: los adjetivos acabados en -R hacen el comparativo con -DER y no con -er.

⚠️ Es una regla pequeña pero que se falla siempre. Sin la d saldria «duurer», que no existe y suena fatal.

📋 Los acabados en -r que vas a usar, todos con -der:
• duur → duurder (caro)
• ver → verder (lejos)
• lekker → lekkerder (rico)
• zwaar → zwaarder (pesado)
• zuur → zuurder (agrio)
• helder → helderder (claro)

📊 Y las demas reglas ortograficas del comparativo, que son las mismas del plural:
• Vocal larga en silaba abierta, se quita una: groot → groter, laat → later.
• Consonante final tras vocal corta, se dobla: dik → dikker, dun → dunner.
• La f se vuelve v y la s se vuelve z: lief → liever, vies → viezer.
• Todo lo demas, -er a secas: klein → kleiner, mooi → mooier.

🏋️ Ejercicio: «este es mas pesado que aquel» → Deze is ___ dan die. (Respuesta: zwaarder.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: duurder der');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'es el libro más interesante que he leído', 'PHRASE', 'Comparativo: meest largos',
'Dit is het meest interessante boek dat ik heb gelezen = es el libro mas interesante que he leido. Con adjetivos LARGOS el superlativo no se hace con -st sino con MEEST delante.

📐 La regla practica: si el adjetivo tiene tres silabas o mas, o acaba en -s, -sch, -st o -isch, se usa meest. interessant → meest interessant. Y el comparativo tambien puede ir con meer: meer interessant, aunque interessanter tambien se dice.

📋 Los que veras con meest:
• meest interessant — el más interesante.
• meest gebruikte — el más usado.
• meest voorkomende — el más frecuente.
• meest logisch — el más lógico.
• meest praktisch — el más práctico.

⚠️ Con adjetivos cortos NO se usa meest: es grootst y no «meest groot», mooist y no «meest mooi». meest se reserva para los largos, igual que el most del ingles frente a -est.

📐 Y fijate en la -e de meest interessantE boek: aunque el superlativo vaya con meest, el adjetivo sigue declinandose delante del sustantivo.

🏋️ Ejercicio: «la solucion mas practica» → de ___ ___ oplossing. (Respuesta: meest praktische.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: meest largos');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ámsterdam es la ciudad más bonita de Países Bajos', 'PHRASE', 'Comparativo: mooiste stad',
'Amsterdam is de mooiste stad van Nederland = Amsterdam es la ciudad mas bonita de Paises Bajos. Superlativo de manual: de + adjetivo + -ste + sustantivo + van + el conjunto.

📐 Otra vez el VAN, que es el error mas repetido: de mooiste stad VAN Nederland, nunca «in Nederland». Con superlativos, el ambito de comparacion va siempre con van.

📋 Los superlativos geograficos y de grupo, que salen todo el rato:
• de mooiste stad van Nederland — la ciudad más bonita del país.
• de grootste stad van de wereld — la ciudad más grande del mundo.
• de beste van de klas — el mejor de la clase.
• de jongste van ons drieën — la más joven de las tres.
• de eerste van de rij — el primero de la fila.

🇳🇱 Y de propina, el vocabulario del pais: Nederland es el pais, Holland son solo dos de sus doce provincias (Noord-Holland y Zuid-Holland) y a mucha gente le molesta que se use por el todo. El gentilicio es Nederlands (el idioma y el adjetivo) y een Nederlander (una persona).

🏋️ Ejercicio: «el rio mas largo de Europa» → de ___ rivier ___ Europa. (Respuesta: langste … van.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: mooiste stad');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'esto está más rico que ayer', 'PHRASE', 'Comparativo: lekkerder',
'Dit is lekkerder dan gisteren = esto esta mas rico que ayer. lekker acaba en -r, asi que hace lekkerDER, con la d de la regla.

📋 lekker es de las palabras mas holandesas y no solo vale para la comida:
• Het eten is lekker. — La comida está rica.
• Lekker weer! — ¡Qué buen tiempo!
• Lekker slapen! — ¡Que duermas bien!
• Ik voel me niet lekker. — No me encuentro bien.
• Lekker bezig! — ¡Bien hecho! (a veces con ironía)
• Een lekker warm bad. — Un baño calentito y agradable.

⚠️ Y el aviso de siempre: lekker aplicado a una persona significa que esta buena en sentido fisico, asi que no lo uses para decir que alguien es agradable. Para eso, aardig (majo) o leuk (simpatico).

🎚️ La escala del gusto por la comida: niet te eten (incomible) → matig (regular) → best lekker (bastante bueno) → lekker (rico) → heerlijk (delicioso) → verrukkelijk (exquisito).

🏋️ Ejercicio: «esta sopa esta mas rica que la de ayer» → Deze soep is ___ dan die van gisteren. (Respuesta: lekkerder.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: lekkerder');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cuanto más esperes, más caro será', 'PHRASE', 'Comparativo: hoe langer hoe duurder',
'Hoe langer je wacht, hoe duurder het wordt = cuanto mas esperes, mas caro sera. Es el molde hoe … hoe … con frase completa, y tiene una peculiaridad de orden que conviene ver.

📐 El reparto exacto: en el PRIMER miembro el verbo se va al final, como en cualquier subordinada — hoe langer je WACHT. En el SEGUNDO el verbo tambien cierra — hoe duurder het WORDT. Los dos miembros llevan comparativo pegado a hoe.

⚠️ Fijate en que el español usa subjuntivo (cuanto mas ESPERES) y el neerlandes indicativo (je wacht), como en todo el grupo del subjuntivo. Aqui no hay ninguna forma especial que buscar.

📋 Las mas usadas con frase entera:
• Hoe meer je oefent, hoe beter je wordt. — Cuanto más practicas, mejor te vuelves.
• Hoe ouder je wordt, hoe sneller de tijd gaat. — Cuanto mayor te haces, más rápido pasa el tiempo.
• Hoe eerder je begint, hoe eerder je klaar bent. — Cuanto antes empieces, antes acabas.

💬 Y la version corta, sin verbos, es la que se dice a diario: Hoe eerder, hoe beter. Hoe meer, hoe beter. Hoe sneller, hoe beter.

🏋️ Ejercicio: «cuanto mas lo pienso, menos lo entiendo» → Hoe meer ik erover nadenk, ___ ___ ik het begrijp. (Respuesta: hoe minder.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Comparativo: hoe langer hoe duurder');

-- =============================================================================
-- 3. Traducciones
-- =============================================================================
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
SELECT we.id, 'nl_NL', v.nl, v.pron
FROM (
    SELECT 'Comparativo: positivo' AS k, 'Mijn huis is klein.' AS nl, 'main hais is klain' AS pron
    UNION ALL SELECT 'Comparativo: mas que', 'Mijn huis is kleiner dan het jouwe.', 'main hais is klainer dan het yaue'
    UNION ALL SELECT 'Comparativo: superlativo con sustantivo', 'Dit is het kleinste huis van de straat.', 'dit is het klainste hais fan de straat'
    UNION ALL SELECT 'Comparativo: het grootst predicativo', 'Deze is het grootst.', 'deeze is het jrootst'
    UNION ALL SELECT 'Comparativo: igualdad net zo als', 'Deze tas is net zo duur als die.', 'deeze tas is net zo duur als di'
    UNION ALL SELECT 'Comparativo: even oud als', 'Zij is even oud als ik.', 'zai is eefen aut als ik'
    UNION ALL SELECT 'Comparativo: hoe hoe', 'Hoe eerder, hoe beter.', 'hu eerder, hu beeter'
    UNION ALL SELECT 'Comparativo: steeds', 'Het wordt steeds kouder.', 'het vort steets kauder'
    UNION ALL SELECT 'Comparativo: beter irregular', 'Dit boek is beter dan de film.', 'dit buk is beeter dan de film'
    UNION ALL SELECT 'Comparativo: de beste', 'Dit is de beste film van het jaar.', 'dit is de beste film fan het yaar'
    UNION ALL SELECT 'Comparativo: meer dan', 'Hij heeft meer geld dan ik.', 'hai heeft meer jelt dan ik'
    UNION ALL SELECT 'Comparativo: minder dan', 'Ik heb minder tijd dan vorig jaar.', 'ik hep minder tait dan fórej yaar'
    UNION ALL SELECT 'Comparativo: liever', 'Ik drink liever thee dan koffie.', 'ik drink liifer tee dan kofi'
    UNION ALL SELECT 'Comparativo: duurder der', 'Deze fiets is duurder dan die.', 'deeze fits is duurder dan di'
    UNION ALL SELECT 'Comparativo: meest largos', 'Dit is het meest interessante boek dat ik heb gelezen.', 'dit is het meest interesante buk dat ik hep jeleezen'
    UNION ALL SELECT 'Comparativo: mooiste stad', 'Amsterdam is de mooiste stad van Nederland.', 'ámsterdam is de mooiste stat fan neederlant'
    UNION ALL SELECT 'Comparativo: lekkerder', 'Dit is lekkerder dan gisteren.', 'dit is lekkerder dan jísteren'
    UNION ALL SELECT 'Comparativo: hoe langer hoe duurder', 'Hoe langer je wacht, hoe duurder het wordt.', 'hu langer ye vajt, hu duurder het vort'
) v
JOIN words_es we ON we.notes = v.k;

-- =============================================================================
-- 4. Al grupo nuevo y a generic
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Comparativo: %' AND g.title = 'comparativos - klein, kleiner, het kleinst';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Comparativo: %' AND g.title = 'generic';

-- =============================================================================
-- 5. Las tres que ya existian y son de esta familia, tambien al grupo
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE g.title = 'comparativos - klein, kleiner, het kleinst' AND we.id IN (827, 890, 892);
