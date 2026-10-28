-- Learn Languages App - Migration
-- Migration: 20260924000003-grupo-paises-y-gentilicios
-- Description: Eduardo: "creame un grupo con los 50 paises mas comunes sus gentilicios en femenino
--   y masculino singular y plural recuerda frases mas usadas variando posesivos reflexivos
--   pronombres y tiempos". Lista de 50 paises aprobada (Europa 25, America 11, Africa y Oriente
--   Medio 8, Asia y Oceania 6) y dos decisiones suyas: «1 por pais pero varia las formas en cada
--   uno» y el plural femenino examinable con «… vrouwen» (de Spaanse vrouwen), dejando la forma
--   suelta (Françaises) en la ayuda.
--
--   50 tarjetas WORD, una por pais. El texto ES pide el pais y UNA forma, que rota por el grupo:
--   13 masculino singular (un español → een Spanjaard), 13 masculino plural (los españoles → de
--   Spanjaarden), 12 femenino singular (una española → een Spaanse) y 12 femenino plural (las
--   españolas → de Spaanse vrouwen). Se escribe «un español» y no «el español» porque, sin
--   parentesis (§3.0), el articulo definido lo confundiria con el idioma. Las que mejor enseñan su
--   forma se eligieron a mano: Zweden y Polen piden el plural (pais = plural), Frankrijk y
--   Suriname el femenino (Française, Surinaamse).
--
--   Ayuda de cada una: regla en la primera linea, que forma pide, tabla de las siete formas (pais,
--   el, ellos, ella, ellas, adjetivo con de keuken, idioma), la trampa propia del pais y el bloque
--   compartido «🌍 Cómo se forma cualquier gentilicio»: familias (-aan, -ees, -er, -iër, cortos,
--   -ijn, por libre), el truco (la mujer = adjetivo + e), ser + adjetivo SIN e (Ze is Duits), el
--   adjetivo delante (de Spaanse wijn / een Spaans restaurant), uit/in/naar, mayuscula y ejercicio.
--
--   67 frases SENTENCE colgadas de su pais con EXAMPLE, variando posesivos (mijn, jouw, zijn,
--   haar, onze, jullie, hun, uw), reflexivos (zich aanpassen, zich kleden, zich vergissen, zich
--   vestigen, zich thuis voelen), pronombres (me, ons, elkaar, ze) y tiempos (presente,
--   perfectum, imperfectum, futuro con gaan). Marcas (presente) en los -amos y (él)/(ella) donde
--   el su no resuelve. Las 5 frases de notes (§3.7) salen de plantillas rotadas.
--   Se suman al grupo las ya existentes 965 (soy de España) y 1092 (¿de qué país eres?).

PRAGMA foreign_keys = ON;

INSERT INTO word_groups (title, description, source)
SELECT 'los paises - landen en nationaliteiten',
       'Los 50 paises mas oidos viviendo en Paises Bajos, cada uno con su gentilicio de hombre y de mujer, en singular y plural, su adjetivo y su idioma. Una tarjeta por pais que pide el pais y una de las cuatro formas, rotando por el grupo. La regla que lo sostiene todo: la mujer sale del adjetivo con una e detras (Spaans → Spaanse, Surinaams → Surinaamse), y varias mujeres son adjetivo + vrouwen (de Spaanse vrouwen). Con ser se usa el adjetivo sin e (Ze is Duits), todo va en mayuscula, y hay dos paises que son tambien su propio plural (Zweden, Polen). Con frases que alternan posesivos, reflexivos, pronombres y tiempos',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'los paises - landen en nationaliteiten');

-- 1. Nederland
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Países Bajos, un neerlandés', 'WORD', 'Paises: Nederland', 'Nederland: el hombre es Nederlander (plural Nederlanders), la mujer Nederlandse y el adjetivo Nederlands. Varias mujeres son de Nederlandse vrouwen.

🎯 Esta tarjeta pide el país y el masculino singular, un neerlandés → een Nederlander. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Nederland:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Países Bajos | Nederland |
| 2 | un hombre | un neerlandés | een **Nederlander** |
| 3 | hombres o grupo mixto | los neerlandeses | de **Nederlanders** |
| 4 | una mujer | una neerlandesa | een **Nederlandse** |
| 5 | varias mujeres | las neerlandesas | de **Nederlandse vrouwen** |
| 6 | adjetivo | la cocina neerlandesa | de **Nederlandse** keuken |
| 7 | idioma | neerlandés | het Nederlands |

⚠️ Holland son solo dos provincias, Noord- y Zuid-Holland. Un Hollander es de allí; el de todo el país es un Nederlander, y su idioma el Nederlands, nunca «Hollands».

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Países Bajos, un neerlandés');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Países Bajos, un neerlandés' LIMIT 1),
    'nl_NL', 'Nederland, een Nederlander', 'néederlant, en néederlander', '• [inv.] In Nederland spreken ze Nederlands. — En Países Bajos se habla neerlandés.
• [perf.] Ik ben nog nooit in Nederland geweest. — Nunca he estado en Países Bajos.
• [can.] Hij is Nederlands, hij komt uit Nederland. — Es neerlandés, es de Países Bajos. (él)
• [vraag] Ken jij veel Nederlanders? — ¿Conoces a muchos neerlandeses?
• [adj.] de Nederlandse keuken — la cocina neerlandesa.');

-- 2. België
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Bélgica, una belga', 'WORD', 'Paises: België', 'België: el hombre es Belg (plural Belgen), la mujer Belgische y el adjetivo Belgisch. Varias mujeres son de Belgische vrouwen.

🎯 Esta tarjeta pide el país y el femenino singular, una belga → een Belgische. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de België:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Bélgica | België |
| 2 | un hombre | un belga | een **Belg** |
| 3 | hombres o grupo mixto | los belgas | de **Belgen** |
| 4 | una mujer | una belga | een **Belgische** |
| 5 | varias mujeres | las belgas | de **Belgische vrouwen** |
| 6 | adjetivo | la cocina belga | de **Belgische** keuken |
| 7 | idioma | neerlandés, francés y alemán | no hay «Belgisch» como idioma, se habla Nederlands, Frans en Duits |

⚠️ En español belga no cambia con el género y es el artículo el que lo marca. En neerlandés sí cambia, Belg para él y Belgische para ella. Y no hay idioma «Belgisch», se habla neerlandés (el Vlaams), francés y alemán.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Bélgica, una belga');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Bélgica, una belga' LIMIT 1),
    'nl_NL', 'België, een Belgische', 'bélji-e, en béljise', '• [inv.] In België spreken ze Nederlands, Frans en Duits. — En Bélgica se habla neerlandés, francés y alemán.
• [perf.] Mijn ouders zijn vorig jaar naar België gereisd. — Mis padres viajaron a Bélgica el año pasado.
• [can.] Ze is Belgisch, maar ze woont in Nederland. — Es belga, pero vive en Países Bajos. (ella)
• [vraag] Werken er Belgische vrouwen bij jou op kantoor? — ¿Trabajan belgas en tu oficina?
• [adj.] de Belgische keuken — la cocina belga.');

-- 3. Duitsland
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Alemania, los alemanes', 'WORD', 'Paises: Duitsland', 'Duitsland: el hombre es Duitser (plural Duitsers), la mujer Duitse y el adjetivo Duits. Varias mujeres son de Duitse vrouwen.

🎯 Esta tarjeta pide el país y el masculino plural, los alemanes → de Duitsers. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Duitsland:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Alemania | Duitsland |
| 2 | un hombre | un alemán | een **Duitser** |
| 3 | hombres o grupo mixto | los alemanes | de **Duitsers** |
| 4 | una mujer | una alemana | een **Duitse** |
| 5 | varias mujeres | las alemanas | de **Duitse vrouwen** |
| 6 | adjetivo | la cocina alemana | de **Duitse** keuken |
| 7 | idioma | alemán | het Duits |

⚠️ Duits se parece al inglés Dutch, pero Dutch es neerlandés. Duits es alemán, y un Duitser es un alemán.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Alemania, los alemanes');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Alemania, los alemanes' LIMIT 1),
    'nl_NL', 'Duitsland, de Duitsers', 'dáutslant, de dáutsers', '• [inv.] In Duitsland spreken ze Duits. — En Alemania se habla alemán.
• [perf.] We hebben twee weken in Duitsland gewoond. — Vivimos dos semanas en Alemania. (pasado)
• [can.] Onze buren zijn Duits. — Nuestros vecinos son alemanes.
• [vraag] Is jouw collega een Duitser? — ¿Tu compañero es alemán?
• [adj.] de Duitse keuken — la cocina alemana.');

-- 4. Frankrijk
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Francia, una francesa', 'WORD', 'Paises: Frankrijk', 'Frankrijk: el hombre es Fransman (plural Fransen), la mujer Française y el adjetivo Frans. Varias mujeres son de Franse vrouwen, o Françaises.

🎯 Esta tarjeta pide el país y el femenino singular, una francesa → een Française. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Frankrijk:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Francia | Frankrijk |
| 2 | un hombre | un francés | een **Fransman** |
| 3 | hombres o grupo mixto | los franceses | de **Fransen** |
| 4 | una mujer | una francesa | een **Française** |
| 5 | varias mujeres | las francesas | de **Française vrouwen** |
| 6 | adjetivo | la cocina francesa | de **Franse** keuken |
| 7 | idioma | francés | het Frans |

⚠️ La excepción del grupo. El hombre es Fransman, pero el plural pierde el man, de Fransen. La mujer es una Française, palabra prestada del francés y con plural Françaises; een Franse también se oye mucho al hablar.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Francia, una francesa');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Francia, una francesa' LIMIT 1),
    'nl_NL', 'Frankrijk, een Française', 'fránkreik, en fransése', '• [inv.] In Frankrijk spreken ze Frans. — En Francia se habla francés.
• [perf.] Ik ben nog nooit in Frankrijk geweest. — Nunca he estado en Francia.
• [can.] Hij is Frans, hij komt uit Frankrijk. — Es francés, es de Francia. (él)
• [vraag] Ken jij veel Fransen? — ¿Conoces a muchos franceses?
• [adj.] de Franse keuken — la cocina francesa.');

-- 5. Spanje
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'España, los españoles', 'WORD', 'Paises: Spanje', 'Spanje: el hombre es Spanjaard (plural Spanjaarden), la mujer Spaanse y el adjetivo Spaans. Varias mujeres son de Spaanse vrouwen.

🎯 Esta tarjeta pide el país y el masculino plural, los españoles → de Spanjaarden. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Spanje:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | España | Spanje |
| 2 | un hombre | un español | een **Spanjaard** |
| 3 | hombres o grupo mixto | los españoles | de **Spanjaarden** |
| 4 | una mujer | una española | een **Spaanse** |
| 5 | varias mujeres | las españolas | de **Spaanse vrouwen** |
| 6 | adjetivo | la cocina española | de **Spaanse** keuken |
| 7 | idioma | español | het Spaans |

⚠️ El hombre lleva -aard (Spanjaard), la mujer no, porque sale del adjetivo, Spaans + e = Spaanse. Nunca «Spanjaardse».

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'España, los españoles');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'España, los españoles' LIMIT 1),
    'nl_NL', 'Spanje, de Spanjaarden', 'spánie, de spaniárden', '• [inv.] In Spanje spreken ze Spaans. — En España se habla español.
• [perf.] Mijn ouders zijn vorig jaar naar Spanje gereisd. — Mis padres viajaron a España el año pasado.
• [can.] Ze is Spaans, maar ze woont in Nederland. — Es española, pero vive en Países Bajos. (ella)
• [vraag] Werken er Spaanse vrouwen bij jou op kantoor? — ¿Trabajan españolas en tu oficina?
• [adj.] de Spaanse keuken — la cocina española.');

-- 6. Portugal
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Portugal, las portuguesas', 'WORD', 'Paises: Portugal', 'Portugal: el hombre es Portugees (plural Portugezen), la mujer Portugese y el adjetivo Portugees. Varias mujeres son de Portugese vrouwen.

🎯 Esta tarjeta pide el país y el femenino plural, las portuguesas → de Portugese vrouwen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Portugal:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Portugal | Portugal |
| 2 | un hombre | un portugués | een **Portugees** |
| 3 | hombres o grupo mixto | los portugueses | de **Portugezen** |
| 4 | una mujer | una portuguesa | een **Portugese** |
| 5 | varias mujeres | las portuguesas | de **Portugese vrouwen** |
| 6 | adjetivo | la cocina portuguesa | de **Portugese** keuken |
| 7 | idioma | portugués | het Portugees |

⚠️ Portugees es tres cosas a la vez, el hombre, el adjetivo y el idioma. En plural la s se vuelve z, Portugezen, y la ee se simplifica al abrirse la sílaba.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Portugal, las portuguesas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Portugal, las portuguesas' LIMIT 1),
    'nl_NL', 'Portugal, de Portugese vrouwen', 'pórtujal, de portujése vráuwen', '• [inv.] In Portugal spreken ze Portugees. — En Portugal se habla portugués.
• [perf.] We hebben twee weken in Portugal gewoond. — Vivimos dos semanas en Portugal. (pasado)
• [can.] Onze buren zijn Portugees. — Nuestros vecinos son portugueses.
• [vraag] Is jouw collega een Portugees? — ¿Tu compañero es portugués?
• [adj.] de Portugese keuken — la cocina portuguesa.');

-- 7. Italië
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Italia, un italiano', 'WORD', 'Paises: Italië', 'Italië: el hombre es Italiaan (plural Italianen), la mujer Italiaanse y el adjetivo Italiaans. Varias mujeres son de Italiaanse vrouwen.

🎯 Esta tarjeta pide el país y el masculino singular, un italiano → een Italiaan. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Italië:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Italia | Italië |
| 2 | un hombre | un italiano | een **Italiaan** |
| 3 | hombres o grupo mixto | los italianos | de **Italianen** |
| 4 | una mujer | una italiana | een **Italiaanse** |
| 5 | varias mujeres | las italianas | de **Italiaanse vrouwen** |
| 6 | adjetivo | la cocina italiana | de **Italiaanse** keuken |
| 7 | idioma | italiano | het Italiaans |

⚠️ Italiaan con dos aes, Italianen con una, porque la sílaba se abre. Es la familia -aan, la más grande del grupo.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Italia, un italiano');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Italia, un italiano' LIMIT 1),
    'nl_NL', 'Italië, een Italiaan', 'itáali-e, en itali-áan', '• [inv.] In Italië spreken ze Italiaans. — En Italia se habla italiano.
• [perf.] Ik ben nog nooit in Italië geweest. — Nunca he estado en Italia.
• [can.] Hij is Italiaans, hij komt uit Italië. — Es italiano, es de Italia. (él)
• [vraag] Ken jij veel Italianen? — ¿Conoces a muchos italianos?
• [adj.] de Italiaanse keuken — la cocina italiana.');

-- 8. het Verenigd Koninkrijk
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'El Reino Unido, los británicos', 'WORD', 'Paises: het Verenigd Koninkrijk', 'het Verenigd Koninkrijk: el hombre es Brit (plural Britten), la mujer Britse y el adjetivo Brits. Varias mujeres son de Britse vrouwen.

🎯 Esta tarjeta pide el país y el masculino plural, los británicos → de Britten. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de het Verenigd Koninkrijk:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | el Reino Unido | het Verenigd Koninkrijk |
| 2 | un hombre | un británico | een **Brit** |
| 3 | hombres o grupo mixto | los británicos | de **Britten** |
| 4 | una mujer | una británica | een **Britse** |
| 5 | varias mujeres | las británicas | de **Britse vrouwen** |
| 6 | adjetivo | la cocina británica | de **Britse** keuken |
| 7 | idioma | inglés | no hay «Brits» como idioma, se habla Engels |

⚠️ El país lleva artículo y lo arrastra, in het Verenigd Koninkrijk. Brit es todo el país; Engelsman, Engelsen y Engelse son solo de Inglaterra (Engeland), como Schot o Welshman.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El Reino Unido, los británicos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'El Reino Unido, los británicos' LIMIT 1),
    'nl_NL', 'het Verenigd Koninkrijk, de Britten', 'et feréenijt kóoninkreik, de bríten', '• [inv.] In het Verenigd Koninkrijk spreken ze Engels. — En el Reino Unido se habla inglés.
• [perf.] Mijn ouders zijn vorig jaar naar het Verenigd Koninkrijk gereisd. — Mis padres viajaron al Reino Unido el año pasado.
• [can.] Ze is Brits, maar ze woont in Nederland. — Es británica, pero vive en Países Bajos. (ella)
• [vraag] Werken er Britse vrouwen bij jou op kantoor? — ¿Trabajan británicas en tu oficina?
• [adj.] de Britse keuken — la cocina británica.');

-- 9. Ierland
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Irlanda, las irlandesas', 'WORD', 'Paises: Ierland', 'Ierland: el hombre es Ier (plural Ieren), la mujer Ierse y el adjetivo Iers. Varias mujeres son de Ierse vrouwen.

🎯 Esta tarjeta pide el país y el femenino plural, las irlandesas → de Ierse vrouwen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Ierland:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Irlanda | Ierland |
| 2 | un hombre | un irlandés | een **Ier** |
| 3 | hombres o grupo mixto | los irlandeses | de **Ieren** |
| 4 | una mujer | una irlandesa | een **Ierse** |
| 5 | varias mujeres | las irlandesas | de **Ierse vrouwen** |
| 6 | adjetivo | la cocina irlandesa | de **Ierse** keuken |
| 7 | idioma | inglés e irlandés | het Iers, y se habla Engels en Iers |

⚠️ Ier es de los gentilicios más cortos del idioma, una sola sílaba, ie = i larga.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Irlanda, las irlandesas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Irlanda, las irlandesas' LIMIT 1),
    'nl_NL', 'Ierland, de Ierse vrouwen', 'íirlant, de íirse vráuwen', '• [inv.] In Ierland spreken ze Engels en Iers. — En Irlanda se habla inglés e irlandés.
• [perf.] We hebben twee weken in Ierland gewoond. — Vivimos dos semanas en Irlanda. (pasado)
• [can.] Onze buren zijn Iers. — Nuestros vecinos son irlandeses.
• [vraag] Is jouw collega een Ier? — ¿Tu compañero es irlandés?
• [adj.] de Ierse keuken — la cocina irlandesa.');

-- 10. Zwitserland
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Suiza, una suiza', 'WORD', 'Paises: Zwitserland', 'Zwitserland: el hombre es Zwitser (plural Zwitsers), la mujer Zwitserse y el adjetivo Zwitsers. Varias mujeres son de Zwitserse vrouwen.

🎯 Esta tarjeta pide el país y el femenino singular, una suiza → een Zwitserse. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Zwitserland:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Suiza | Zwitserland |
| 2 | un hombre | un suizo | een **Zwitser** |
| 3 | hombres o grupo mixto | los suizos | de **Zwitsers** |
| 4 | una mujer | una suiza | een **Zwitserse** |
| 5 | varias mujeres | las suizas | de **Zwitserse vrouwen** |
| 6 | adjetivo | la cocina suiza | de **Zwitserse** keuken |
| 7 | idioma | alemán, francés, italiano y romanche | no hay «Zwitsers» como idioma, se habla Duits, Frans, Italiaans en Reto-Romaans |

⚠️ Zwitsers es a la vez el plural (de Zwitsers) y el adjetivo (Zwitsers geld). Solo el contexto los separa.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Suiza, una suiza');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Suiza, una suiza' LIMIT 1),
    'nl_NL', 'Zwitserland, een Zwitserse', 'suítserlant, en suítserse', '• [inv.] In Zwitserland spreken ze Duits, Frans, Italiaans en Reto-Romaans. — En Suiza se habla alemán, francés, italiano y romanche.
• [perf.] Ik ben nog nooit in Zwitserland geweest. — Nunca he estado en Suiza.
• [can.] Hij is Zwitsers, hij komt uit Zwitserland. — Es suizo, es de Suiza. (él)
• [vraag] Ken jij veel Zwitsers? — ¿Conoces a muchos suizos?
• [adj.] de Zwitserse keuken — la cocina suiza.');

-- 11. Oostenrijk
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Austria, un austriaco', 'WORD', 'Paises: Oostenrijk', 'Oostenrijk: el hombre es Oostenrijker (plural Oostenrijkers), la mujer Oostenrijkse y el adjetivo Oostenrijks. Varias mujeres son de Oostenrijkse vrouwen.

🎯 Esta tarjeta pide el país y el masculino singular, un austriaco → een Oostenrijker. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Oostenrijk:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Austria | Oostenrijk |
| 2 | un hombre | un austriaco | een **Oostenrijker** |
| 3 | hombres o grupo mixto | los austriacos | de **Oostenrijkers** |
| 4 | una mujer | una austriaca | een **Oostenrijkse** |
| 5 | varias mujeres | las austriacas | de **Oostenrijkse vrouwen** |
| 6 | adjetivo | la cocina austriaca | de **Oostenrijkse** keuken |
| 7 | idioma | alemán | no hay «Oostenrijks» como idioma, se habla Duits |

⚠️ Oostenrijk es literalmente el reino del este, oost + rijk, lo mismo que el alemán Österreich.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Austria, un austriaco');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Austria, un austriaco' LIMIT 1),
    'nl_NL', 'Oostenrijk, een Oostenrijker', 'óostenreik, en óostenreiker', '• [inv.] In Oostenrijk spreken ze Duits. — En Austria se habla alemán.
• [perf.] Mijn ouders zijn vorig jaar naar Oostenrijk gereisd. — Mis padres viajaron a Austria el año pasado.
• [can.] Ze is Oostenrijks, maar ze woont in Nederland. — Es austriaca, pero vive en Países Bajos. (ella)
• [vraag] Werken er Oostenrijkse vrouwen bij jou op kantoor? — ¿Trabajan austriacas en tu oficina?
• [adj.] de Oostenrijkse keuken — la cocina austriaca.');

-- 12. Denemarken
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Dinamarca, las danesas', 'WORD', 'Paises: Denemarken', 'Denemarken: el hombre es Deen (plural Denen), la mujer Deense y el adjetivo Deens. Varias mujeres son de Deense vrouwen.

🎯 Esta tarjeta pide el país y el femenino plural, las danesas → de Deense vrouwen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Denemarken:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Dinamarca | Denemarken |
| 2 | un hombre | un danés | een **Deen** |
| 3 | hombres o grupo mixto | los daneses | de **Denen** |
| 4 | una mujer | una danesa | een **Deense** |
| 5 | varias mujeres | las danesas | de **Deense vrouwen** |
| 6 | adjetivo | la cocina danesa | de **Deense** keuken |
| 7 | idioma | danés | het Deens |

⚠️ El país empieza por Dene- y el gentilicio es Deen, con ee, y Denen en plural.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Dinamarca, las danesas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Dinamarca, las danesas' LIMIT 1),
    'nl_NL', 'Denemarken, de Deense vrouwen', 'déenemarken, de déense vráuwen', '• [inv.] In Denemarken spreken ze Deens. — En Dinamarca se habla danés.
• [perf.] We hebben twee weken in Denemarken gewoond. — Vivimos dos semanas en Dinamarca. (pasado)
• [can.] Onze buren zijn Deens. — Nuestros vecinos son daneses.
• [vraag] Is jouw collega een Deen? — ¿Tu compañero es danés?
• [adj.] de Deense keuken — la cocina danesa.');

-- 13. Zweden
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Suecia, los suecos', 'WORD', 'Paises: Zweden', 'Zweden: el hombre es Zweed (plural Zweden), la mujer Zweedse y el adjetivo Zweeds. Varias mujeres son de Zweedse vrouwen.

🎯 Esta tarjeta pide el país y el masculino plural, los suecos → de Zweden. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Zweden:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Suecia | Zweden |
| 2 | un hombre | un sueco | een **Zweed** |
| 3 | hombres o grupo mixto | los suecos | de **Zweden** |
| 4 | una mujer | una sueca | een **Zweedse** |
| 5 | varias mujeres | las suecas | de **Zweedse vrouwen** |
| 6 | adjetivo | la cocina sueca | de **Zweedse** keuken |
| 7 | idioma | sueco | het Zweeds |

⚠️ Zweden es el país y también el plural de Zweed. Lo decide el artículo, in Zweden (el país) frente a de Zweden (los suecos).

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Suecia, los suecos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Suecia, los suecos' LIMIT 1),
    'nl_NL', 'Zweden, de Zweden', 'suéeden, de suéeden', '• [inv.] In Zweden spreken ze Zweeds. — En Suecia se habla sueco.
• [perf.] Ik ben nog nooit in Zweden geweest. — Nunca he estado en Suecia.
• [can.] Hij is Zweeds, hij komt uit Zweden. — Es sueco, es de Suecia. (él)
• [vraag] Ken jij veel Zweden? — ¿Conoces a muchos suecos?
• [adj.] de Zweedse keuken — la cocina sueca.');

-- 14. Noorwegen
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Noruega, una noruega', 'WORD', 'Paises: Noorwegen', 'Noorwegen: el hombre es Noor (plural Noren), la mujer Noorse y el adjetivo Noors. Varias mujeres son de Noorse vrouwen.

🎯 Esta tarjeta pide el país y el femenino singular, una noruega → een Noorse. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Noorwegen:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Noruega | Noorwegen |
| 2 | un hombre | un noruego | een **Noor** |
| 3 | hombres o grupo mixto | los noruegos | de **Noren** |
| 4 | una mujer | una noruega | een **Noorse** |
| 5 | varias mujeres | las noruegas | de **Noorse vrouwen** |
| 6 | adjetivo | la cocina noruega | de **Noorse** keuken |
| 7 | idioma | noruego | het Noors |

⚠️ Noorwegen es el camino del norte (noord + weg). Noor pierde una o en plural, Noren.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Noruega, una noruega');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Noruega, una noruega' LIMIT 1),
    'nl_NL', 'Noorwegen, een Noorse', 'nóorweejen, en nóorse', '• [inv.] In Noorwegen spreken ze Noors. — En Noruega se habla noruego.
• [perf.] Mijn ouders zijn vorig jaar naar Noorwegen gereisd. — Mis padres viajaron a Noruega el año pasado.
• [can.] Ze is Noors, maar ze woont in Nederland. — Es noruega, pero vive en Países Bajos. (ella)
• [vraag] Werken er Noorse vrouwen bij jou op kantoor? — ¿Trabajan noruegas en tu oficina?
• [adj.] de Noorse keuken — la cocina noruega.');

-- 15. Finland
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Finlandia, un finlandés', 'WORD', 'Paises: Finland', 'Finland: el hombre es Fin (plural Finnen), la mujer Finse y el adjetivo Fins. Varias mujeres son de Finse vrouwen.

🎯 Esta tarjeta pide el país y el masculino singular, un finlandés → een Fin. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Finland:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Finlandia | Finland |
| 2 | un hombre | un finlandés | een **Fin** |
| 3 | hombres o grupo mixto | los finlandeses | de **Finnen** |
| 4 | una mujer | una finlandesa | een **Finse** |
| 5 | varias mujeres | las finlandesas | de **Finse vrouwen** |
| 6 | adjetivo | la cocina finlandesa | de **Finse** keuken |
| 7 | idioma | finés y sueco | het Fins, y se habla Fins en Zweeds |

⚠️ Fin dobla la n en plural, Finnen, para que la i siga siendo corta.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Finlandia, un finlandés');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Finlandia, un finlandés' LIMIT 1),
    'nl_NL', 'Finland, een Fin', 'fínlant, en fin', '• [inv.] In Finland spreken ze Fins en Zweeds. — En Finlandia se habla finés y sueco.
• [perf.] We hebben twee weken in Finland gewoond. — Vivimos dos semanas en Finlandia. (pasado)
• [can.] Onze buren zijn Fins. — Nuestros vecinos son finlandeses.
• [vraag] Is jouw collega een Fin? — ¿Tu compañero es finlandés?
• [adj.] de Finse keuken — la cocina finlandesa.');

-- 16. Polen
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Polonia, los polacos', 'WORD', 'Paises: Polen', 'Polen: el hombre es Pool (plural Polen), la mujer Poolse y el adjetivo Pools. Varias mujeres son de Poolse vrouwen.

🎯 Esta tarjeta pide el país y el masculino plural, los polacos → de Polen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Polen:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Polonia | Polen |
| 2 | un hombre | un polaco | een **Pool** |
| 3 | hombres o grupo mixto | los polacos | de **Polen** |
| 4 | una mujer | una polaca | een **Poolse** |
| 5 | varias mujeres | las polacas | de **Poolse vrouwen** |
| 6 | adjetivo | la cocina polaca | de **Poolse** keuken |
| 7 | idioma | polaco | het Pools |

⚠️ Como Zweden, Polen es el país y el plural de Pool. In Polen es el país, de Polen son los polacos.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Polonia, los polacos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Polonia, los polacos' LIMIT 1),
    'nl_NL', 'Polen, de Polen', 'póolen, de póolen', '• [inv.] In Polen spreken ze Pools. — En Polonia se habla polaco.
• [perf.] Ik ben nog nooit in Polen geweest. — Nunca he estado en Polonia.
• [can.] Hij is Pools, hij komt uit Polen. — Es polaco, es de Polonia. (él)
• [vraag] Ken jij veel Polen? — ¿Conoces a muchos polacos?
• [adj.] de Poolse keuken — la cocina polaca.');

-- 17. Tsjechië
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Chequia, las checas', 'WORD', 'Paises: Tsjechië', 'Tsjechië: el hombre es Tsjech (plural Tsjechen), la mujer Tsjechische y el adjetivo Tsjechisch. Varias mujeres son de Tsjechische vrouwen.

🎯 Esta tarjeta pide el país y el femenino plural, las checas → de Tsjechische vrouwen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Tsjechië:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Chequia | Tsjechië |
| 2 | un hombre | un checo | een **Tsjech** |
| 3 | hombres o grupo mixto | los checos | de **Tsjechen** |
| 4 | una mujer | una checa | een **Tsjechische** |
| 5 | varias mujeres | las checas | de **Tsjechische vrouwen** |
| 6 | adjetivo | la cocina checa | de **Tsjechische** keuken |
| 7 | idioma | checo | het Tsjechisch |

⚠️ tsj es el sonido de la ch española, Tsjech = chej. La mujer toma -ische, como Russische o Belgische.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Chequia, las checas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Chequia, las checas' LIMIT 1),
    'nl_NL', 'Tsjechië, de Tsjechische vrouwen', 'chéji-e, de chéjise vráuwen', '• [inv.] In Tsjechië spreken ze Tsjechisch. — En Chequia se habla checo.
• [perf.] Mijn ouders zijn vorig jaar naar Tsjechië gereisd. — Mis padres viajaron a Chequia el año pasado.
• [can.] Ze is Tsjechisch, maar ze woont in Nederland. — Es checa, pero vive en Países Bajos. (ella)
• [vraag] Werken er Tsjechische vrouwen bij jou op kantoor? — ¿Trabajan checas en tu oficina?
• [adj.] de Tsjechische keuken — la cocina checa.');

-- 18. Hongarije
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Hungría, un húngaro', 'WORD', 'Paises: Hongarije', 'Hongarije: el hombre es Hongaar (plural Hongaren), la mujer Hongaarse y el adjetivo Hongaars. Varias mujeres son de Hongaarse vrouwen.

🎯 Esta tarjeta pide el país y el masculino singular, un húngaro → een Hongaar. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Hongarije:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Hungría | Hongarije |
| 2 | un hombre | un húngaro | een **Hongaar** |
| 3 | hombres o grupo mixto | los húngaros | de **Hongaren** |
| 4 | una mujer | una húngara | een **Hongaarse** |
| 5 | varias mujeres | las húngaras | de **Hongaarse vrouwen** |
| 6 | adjetivo | la cocina húngara | de **Hongaarse** keuken |
| 7 | idioma | húngaro | het Hongaars |

⚠️ Hongaar lleva dos aes y Hongaren una, la sílaba se abre en plural.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Hungría, un húngaro');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Hungría, un húngaro' LIMIT 1),
    'nl_NL', 'Hongarije, een Hongaar', 'hongaréie, en hongáar', '• [inv.] In Hongarije spreken ze Hongaars. — En Hungría se habla húngaro.
• [perf.] We hebben twee weken in Hongarije gewoond. — Vivimos dos semanas en Hungría. (pasado)
• [can.] Onze buren zijn Hongaars. — Nuestros vecinos son húngaros.
• [vraag] Is jouw collega een Hongaar? — ¿Tu compañero es húngaro?
• [adj.] de Hongaarse keuken — la cocina húngara.');

-- 19. Roemenië
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Rumanía, una rumana', 'WORD', 'Paises: Roemenië', 'Roemenië: el hombre es Roemeen (plural Roemenen), la mujer Roemeense y el adjetivo Roemeens. Varias mujeres son de Roemeense vrouwen.

🎯 Esta tarjeta pide el país y el femenino singular, una rumana → een Roemeense. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Roemenië:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Rumanía | Roemenië |
| 2 | un hombre | un rumano | een **Roemeen** |
| 3 | hombres o grupo mixto | los rumanos | de **Roemenen** |
| 4 | una mujer | una rumana | een **Roemeense** |
| 5 | varias mujeres | las rumanas | de **Roemeense vrouwen** |
| 6 | adjetivo | la cocina rumana | de **Roemeense** keuken |
| 7 | idioma | rumano | het Roemeens |

⚠️ oe se lee u, Roemeen = rumeen. Plural Roemenen, con una sola e al abrirse la sílaba.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Rumanía, una rumana');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Rumanía, una rumana' LIMIT 1),
    'nl_NL', 'Roemenië, een Roemeense', 'ruméeni-e, en ruméense', '• [inv.] In Roemenië spreken ze Roemeens. — En Rumanía se habla rumano.
• [perf.] Ik ben nog nooit in Roemenië geweest. — Nunca he estado en Rumanía.
• [can.] Hij is Roemeens, hij komt uit Roemenië. — Es rumano, es de Rumanía. (él)
• [vraag] Ken jij veel Roemenen? — ¿Conoces a muchos rumanos?
• [adj.] de Roemeense keuken — la cocina rumana.');

-- 20. Bulgarije
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Bulgaria, las búlgaras', 'WORD', 'Paises: Bulgarije', 'Bulgarije: el hombre es Bulgaar (plural Bulgaren), la mujer Bulgaarse y el adjetivo Bulgaars. Varias mujeres son de Bulgaarse vrouwen.

🎯 Esta tarjeta pide el país y el femenino plural, las búlgaras → de Bulgaarse vrouwen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Bulgarije:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Bulgaria | Bulgarije |
| 2 | un hombre | un búlgaro | een **Bulgaar** |
| 3 | hombres o grupo mixto | los búlgaros | de **Bulgaren** |
| 4 | una mujer | una búlgara | een **Bulgaarse** |
| 5 | varias mujeres | las búlgaras | de **Bulgaarse vrouwen** |
| 6 | adjetivo | la cocina búlgara | de **Bulgaarse** keuken |
| 7 | idioma | búlgaro | het Bulgaars |

⚠️ Mismo patrón que Hongaar, Bulgaar y Bulgaren. Los países en -ije (Hongarije, Bulgarije, Turkije) se leen -eie.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Bulgaria, las búlgaras');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Bulgaria, las búlgaras' LIMIT 1),
    'nl_NL', 'Bulgarije, de Bulgaarse vrouwen', 'bulgaréie, de bulgáarse vráuwen', '• [inv.] In Bulgarije spreken ze Bulgaars. — En Bulgaria se habla búlgaro.
• [perf.] Mijn ouders zijn vorig jaar naar Bulgarije gereisd. — Mis padres viajaron a Bulgaria el año pasado.
• [can.] Ze is Bulgaars, maar ze woont in Nederland. — Es búlgara, pero vive en Países Bajos. (ella)
• [vraag] Werken er Bulgaarse vrouwen bij jou op kantoor? — ¿Trabajan búlgaras en tu oficina?
• [adj.] de Bulgaarse keuken — la cocina búlgara.');

-- 21. Griekenland
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Grecia, los griegos', 'WORD', 'Paises: Griekenland', 'Griekenland: el hombre es Griek (plural Grieken), la mujer Griekse y el adjetivo Grieks. Varias mujeres son de Griekse vrouwen.

🎯 Esta tarjeta pide el país y el masculino plural, los griegos → de Grieken. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Griekenland:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Grecia | Griekenland |
| 2 | un hombre | un griego | een **Griek** |
| 3 | hombres o grupo mixto | los griegos | de **Grieken** |
| 4 | una mujer | una griega | een **Griekse** |
| 5 | varias mujeres | las griegas | de **Griekse vrouwen** |
| 6 | adjetivo | la cocina griega | de **Griekse** keuken |
| 7 | idioma | griego | het Grieks |

⚠️ El país es literalmente la tierra de los griegos, Grieken + land. Y dat is Grieks voor mij = eso me suena a chino.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Grecia, los griegos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Grecia, los griegos' LIMIT 1),
    'nl_NL', 'Griekenland, de Grieken', 'jríikenlant, de jríiken', '• [inv.] In Griekenland spreken ze Grieks. — En Grecia se habla griego.
• [perf.] We hebben twee weken in Griekenland gewoond. — Vivimos dos semanas en Grecia. (pasado)
• [can.] Onze buren zijn Grieks. — Nuestros vecinos son griegos.
• [vraag] Is jouw collega een Griek? — ¿Tu compañero es griego?
• [adj.] de Griekse keuken — la cocina griega.');

-- 22. Kroatië
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Croacia, un croata', 'WORD', 'Paises: Kroatië', 'Kroatië: el hombre es Kroaat (plural Kroaten), la mujer Kroatische y el adjetivo Kroatisch. Varias mujeres son de Kroatische vrouwen.

🎯 Esta tarjeta pide el país y el masculino singular, un croata → een Kroaat. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Kroatië:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Croacia | Kroatië |
| 2 | un hombre | un croata | een **Kroaat** |
| 3 | hombres o grupo mixto | los croatas | de **Kroaten** |
| 4 | una mujer | una croata | een **Kroatische** |
| 5 | varias mujeres | las croatas | de **Kroatische vrouwen** |
| 6 | adjetivo | la cocina croata | de **Kroatische** keuken |
| 7 | idioma | croata | het Kroatisch |

⚠️ Croata no cambia con el género en español; en neerlandés sí, Kroaat para él y Kroatische para ella. El país se lee kroaatsie.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Croacia, un croata');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Croacia, un croata' LIMIT 1),
    'nl_NL', 'Kroatië, een Kroaat', 'kroáatsi-e, en kroáat', '• [inv.] In Kroatië spreken ze Kroatisch. — En Croacia se habla croata.
• [perf.] Ik ben nog nooit in Kroatië geweest. — Nunca he estado en Croacia.
• [can.] Hij is Kroatisch, hij komt uit Kroatië. — Es croata, es de Croacia. (él)
• [vraag] Ken jij veel Kroaten? — ¿Conoces a muchos croatas?
• [adj.] de Kroatische keuken — la cocina croata.');

-- 23. Rusland
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Rusia, una rusa', 'WORD', 'Paises: Rusland', 'Rusland: el hombre es Rus (plural Russen), la mujer Russische y el adjetivo Russisch. Varias mujeres son de Russische vrouwen.

🎯 Esta tarjeta pide el país y el femenino singular, una rusa → een Russische. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Rusland:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Rusia | Rusland |
| 2 | un hombre | un ruso | een **Rus** |
| 3 | hombres o grupo mixto | los rusos | de **Russen** |
| 4 | una mujer | una rusa | een **Russische** |
| 5 | varias mujeres | las rusas | de **Russische vrouwen** |
| 6 | adjetivo | la cocina rusa | de **Russische** keuken |
| 7 | idioma | ruso | het Russisch |

⚠️ Rus dobla la s en plural, Russen, y la mujer es Russische, no «Russe».

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Rusia, una rusa');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Rusia, una rusa' LIMIT 1),
    'nl_NL', 'Rusland, een Russische', 'rúslant, en rúsise', '• [inv.] In Rusland spreken ze Russisch. — En Rusia se habla ruso.
• [perf.] Mijn ouders zijn vorig jaar naar Rusland gereisd. — Mis padres viajaron a Rusia el año pasado.
• [can.] Ze is Russisch, maar ze woont in Nederland. — Es rusa, pero vive en Países Bajos. (ella)
• [vraag] Werken er Russische vrouwen bij jou op kantoor? — ¿Trabajan rusas en tu oficina?
• [adj.] de Russische keuken — la cocina rusa.');

-- 24. Oekraïne
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ucrania, un ucraniano', 'WORD', 'Paises: Oekraïne', 'Oekraïne: el hombre es Oekraïner (plural Oekraïners), la mujer Oekraïense y el adjetivo Oekraïens. Varias mujeres son de Oekraïense vrouwen.

🎯 Esta tarjeta pide el país y el masculino singular, un ucraniano → een Oekraïner. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Oekraïne:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Ucrania | Oekraïne |
| 2 | un hombre | un ucraniano | een **Oekraïner** |
| 3 | hombres o grupo mixto | los ucranianos | de **Oekraïners** |
| 4 | una mujer | una ucraniana | een **Oekraïense** |
| 5 | varias mujeres | las ucranianas | de **Oekraïense vrouwen** |
| 6 | adjetivo | la cocina ucraniana | de **Oekraïense** keuken |
| 7 | idioma | ucraniano | het Oekraïens |

⚠️ La trema de ï separa la a de la i, ukra-ine, y se escribe siempre, también en Oekraïner y Oekraïens.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ucrania, un ucraniano');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Ucrania, un ucraniano' LIMIT 1),
    'nl_NL', 'Oekraïne, een Oekraïner', 'ukra-íine, en ukra-íiner', '• [inv.] In Oekraïne spreken ze Oekraïens. — En Ucrania se habla ucraniano.
• [perf.] We hebben twee weken in Oekraïne gewoond. — Vivimos dos semanas en Ucrania. (pasado)
• [can.] Onze buren zijn Oekraïens. — Nuestros vecinos son ucranianos.
• [vraag] Is jouw collega een Oekraïner? — ¿Tu compañero es ucraniano?
• [adj.] de Oekraïense keuken — la cocina ucraniana.');

-- 25. Turkije
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Turquía, los turcos', 'WORD', 'Paises: Turkije', 'Turkije: el hombre es Turk (plural Turken), la mujer Turkse y el adjetivo Turks. Varias mujeres son de Turkse vrouwen.

🎯 Esta tarjeta pide el país y el masculino plural, los turcos → de Turken. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Turkije:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Turquía | Turkije |
| 2 | un hombre | un turco | een **Turk** |
| 3 | hombres o grupo mixto | los turcos | de **Turken** |
| 4 | una mujer | una turca | een **Turkse** |
| 5 | varias mujeres | las turcas | de **Turkse vrouwen** |
| 6 | adjetivo | la cocina turca | de **Turkse** keuken |
| 7 | idioma | turco | het Turks |

⚠️ El adjetivo pierde la -e delante de un het-woord con een, een Turks restaurant, pero het Turkse restaurant. Pasa con todos los adjetivos del grupo.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Turquía, los turcos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Turquía, los turcos' LIMIT 1),
    'nl_NL', 'Turkije, de Turken', 'turkéie, de túrken', '• [inv.] In Turkije spreken ze Turks. — En Turquía se habla turco.
• [perf.] Ik ben nog nooit in Turkije geweest. — Nunca he estado en Turquía.
• [can.] Hij is Turks, hij komt uit Turkije. — Es turco, es de Turquía. (él)
• [vraag] Ken jij veel Turken? — ¿Conoces a muchos turcos?
• [adj.] de Turkse keuken — la cocina turca.');

-- 26. de Verenigde Staten
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Estados Unidos, los estadounidenses', 'WORD', 'Paises: de Verenigde Staten', 'de Verenigde Staten: el hombre es Amerikaan (plural Amerikanen), la mujer Amerikaanse y el adjetivo Amerikaans. Varias mujeres son de Amerikaanse vrouwen.

🎯 Esta tarjeta pide el país y el masculino plural, los estadounidenses → de Amerikanen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de de Verenigde Staten:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Estados Unidos | de Verenigde Staten |
| 2 | un hombre | un estadounidense | een **Amerikaan** |
| 3 | hombres o grupo mixto | los estadounidenses | de **Amerikanen** |
| 4 | una mujer | una estadounidense | een **Amerikaanse** |
| 5 | varias mujeres | las estadounidenses | de **Amerikaanse vrouwen** |
| 6 | adjetivo | la cocina estadounidense | de **Amerikaanse** keuken |
| 7 | idioma | inglés | no hay «Amerikaans» como idioma, se habla Engels |

⚠️ El país es plural y lleva artículo, de Verenigde Staten zijn groot, con el verbo en plural. Al hablar se dice mucho Amerika, y el gentilicio es siempre Amerikaan.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Estados Unidos, los estadounidenses');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Estados Unidos, los estadounidenses' LIMIT 1),
    'nl_NL', 'de Verenigde Staten, de Amerikanen', 'de feréenijde stáaten, de amerikáanen', '• [inv.] In de Verenigde Staten spreken ze Engels. — En Estados Unidos se habla inglés.
• [perf.] Mijn ouders zijn vorig jaar naar de Verenigde Staten gereisd. — Mis padres viajaron a Estados Unidos el año pasado.
• [can.] Ze is Amerikaans, maar ze woont in Nederland. — Es estadounidense, pero vive en Países Bajos. (ella)
• [vraag] Werken er Amerikaanse vrouwen bij jou op kantoor? — ¿Trabajan estadounidenses en tu oficina?
• [adj.] de Amerikaanse keuken — la cocina estadounidense.');

-- 27. Canada
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Canadá, las canadienses', 'WORD', 'Paises: Canada', 'Canada: el hombre es Canadees (plural Canadezen), la mujer Canadese y el adjetivo Canadees. Varias mujeres son de Canadese vrouwen.

🎯 Esta tarjeta pide el país y el femenino plural, las canadienses → de Canadese vrouwen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Canada:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Canadá | Canada |
| 2 | un hombre | un canadiense | een **Canadees** |
| 3 | hombres o grupo mixto | los canadienses | de **Canadezen** |
| 4 | una mujer | una canadiense | een **Canadese** |
| 5 | varias mujeres | las canadienses | de **Canadese vrouwen** |
| 6 | adjetivo | la cocina canadiense | de **Canadese** keuken |
| 7 | idioma | inglés y francés | no hay «Canadees» como idioma, se habla Engels en Frans |

⚠️ Familia -ees, como Portugees y Chinees, con la s que se vuelve z en plural, Canadezen.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Canadá, las canadienses');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Canadá, las canadienses' LIMIT 1),
    'nl_NL', 'Canada, de Canadese vrouwen', 'kánada, de kanadéese vráuwen', '• [inv.] In Canada spreken ze Engels en Frans. — En Canadá se habla inglés y francés.
• [perf.] We hebben twee weken in Canada gewoond. — Vivimos dos semanas en Canadá. (pasado)
• [can.] Onze buren zijn Canadees. — Nuestros vecinos son canadienses.
• [vraag] Is jouw collega een Canadees? — ¿Tu compañero es canadiense?
• [adj.] de Canadese keuken — la cocina canadiense.');

-- 28. Mexico
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'México, una mexicana', 'WORD', 'Paises: Mexico', 'Mexico: el hombre es Mexicaan (plural Mexicanen), la mujer Mexicaanse y el adjetivo Mexicaans. Varias mujeres son de Mexicaanse vrouwen.

🎯 Esta tarjeta pide el país y el femenino singular, una mexicana → een Mexicaanse. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Mexico:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | México | Mexico |
| 2 | un hombre | un mexicano | een **Mexicaan** |
| 3 | hombres o grupo mixto | los mexicanos | de **Mexicanen** |
| 4 | una mujer | una mexicana | een **Mexicaanse** |
| 5 | varias mujeres | las mexicanas | de **Mexicaanse vrouwen** |
| 6 | adjetivo | la cocina mexicana | de **Mexicaanse** keuken |
| 7 | idioma | español | no hay «Mexicaans» como idioma, se habla Spaans |

⚠️ La x se lee ks, mek-si-ko, nunca con la jota española.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'México, una mexicana');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'México, una mexicana' LIMIT 1),
    'nl_NL', 'Mexico, een Mexicaanse', 'méksiko, en meksikáanse', '• [inv.] In Mexico spreken ze Spaans. — En México se habla español.
• [perf.] Ik ben nog nooit in Mexico geweest. — Nunca he estado en México.
• [can.] Hij is Mexicaans, hij komt uit Mexico. — Es mexicano, es de México. (él)
• [vraag] Ken jij veel Mexicanen? — ¿Conoces a muchos mexicanos?
• [adj.] de Mexicaanse keuken — la cocina mexicana.');

-- 29. Cuba
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Cuba, un cubano', 'WORD', 'Paises: Cuba', 'Cuba: el hombre es Cubaan (plural Cubanen), la mujer Cubaanse y el adjetivo Cubaans. Varias mujeres son de Cubaanse vrouwen.

🎯 Esta tarjeta pide el país y el masculino singular, un cubano → een Cubaan. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Cuba:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Cuba | Cuba |
| 2 | un hombre | un cubano | een **Cubaan** |
| 3 | hombres o grupo mixto | los cubanos | de **Cubanen** |
| 4 | una mujer | una cubana | een **Cubaanse** |
| 5 | varias mujeres | las cubanas | de **Cubaanse vrouwen** |
| 6 | adjetivo | la cocina cubana | de **Cubaanse** keuken |
| 7 | idioma | español | no hay «Cubaans» como idioma, se habla Spaans |

⚠️ Familia -aan, la más productiva con los países latinoamericanos, Cubaan, Mexicaan, Colombiaan, Peruaan.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cuba, un cubano');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuba, un cubano' LIMIT 1),
    'nl_NL', 'Cuba, een Cubaan', 'kúuba, en kubáan', '• [inv.] In Cuba spreken ze Spaans. — En Cuba se habla español.
• [perf.] Mijn ouders zijn vorig jaar naar Cuba gereisd. — Mis padres viajaron a Cuba el año pasado.
• [can.] Ze is Cubaans, maar ze woont in Nederland. — Es cubana, pero vive en Países Bajos. (ella)
• [vraag] Werken er Cubaanse vrouwen bij jou op kantoor? — ¿Trabajan cubanas en tu oficina?
• [adj.] de Cubaanse keuken — la cocina cubana.');

-- 30. Colombia
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Colombia, las colombianas', 'WORD', 'Paises: Colombia', 'Colombia: el hombre es Colombiaan (plural Colombianen), la mujer Colombiaanse y el adjetivo Colombiaans. Varias mujeres son de Colombiaanse vrouwen.

🎯 Esta tarjeta pide el país y el femenino plural, las colombianas → de Colombiaanse vrouwen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Colombia:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Colombia | Colombia |
| 2 | un hombre | un colombiano | een **Colombiaan** |
| 3 | hombres o grupo mixto | los colombianos | de **Colombianen** |
| 4 | una mujer | una colombiana | een **Colombiaanse** |
| 5 | varias mujeres | las colombianas | de **Colombiaanse vrouwen** |
| 6 | adjetivo | la cocina colombiana | de **Colombiaanse** keuken |
| 7 | idioma | español | no hay «Colombiaans» como idioma, se habla Spaans |

⚠️ El plural femenino se hace con vrouwen detrás del adjetivo, de Colombiaanse vrouwen; «Colombiaansen» casi no se usa.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Colombia, las colombianas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Colombia, las colombianas' LIMIT 1),
    'nl_NL', 'Colombia, de Colombiaanse vrouwen', 'kolómbia, de kolombiáanse vráuwen', '• [inv.] In Colombia spreken ze Spaans. — En Colombia se habla español.
• [perf.] We hebben twee weken in Colombia gewoond. — Vivimos dos semanas en Colombia. (pasado)
• [can.] Onze buren zijn Colombiaans. — Nuestros vecinos son colombianos.
• [vraag] Is jouw collega een Colombiaan? — ¿Tu compañero es colombiano?
• [adj.] de Colombiaanse keuken — la cocina colombiana.');

-- 31. Venezuela
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Venezuela, los venezolanos', 'WORD', 'Paises: Venezuela', 'Venezuela: el hombre es Venezolaan (plural Venezolanen), la mujer Venezolaanse y el adjetivo Venezolaans. Varias mujeres son de Venezolaanse vrouwen.

🎯 Esta tarjeta pide el país y el masculino plural, los venezolanos → de Venezolanen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Venezuela:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Venezuela | Venezuela |
| 2 | un hombre | un venezolano | een **Venezolaan** |
| 3 | hombres o grupo mixto | los venezolanos | de **Venezolanen** |
| 4 | una mujer | una venezolana | een **Venezolaanse** |
| 5 | varias mujeres | las venezolanas | de **Venezolaanse vrouwen** |
| 6 | adjetivo | la cocina venezolana | de **Venezolaanse** keuken |
| 7 | idioma | español | no hay «Venezolaans» como idioma, se habla Spaans |

⚠️ El gentilicio va con o, Venezolaan, igual que venezolano, no «Venezuelaan». La v inicial suena casi f.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Venezuela, los venezolanos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Venezuela, los venezolanos' LIMIT 1),
    'nl_NL', 'Venezuela, de Venezolanen', 'fenesuéela, de fenesoláanen', '• [inv.] In Venezuela spreken ze Spaans. — En Venezuela se habla español.
• [perf.] Ik ben nog nooit in Venezuela geweest. — Nunca he estado en Venezuela.
• [can.] Hij is Venezolaans, hij komt uit Venezuela. — Es venezolano, es de Venezuela. (él)
• [vraag] Ken jij veel Venezolanen? — ¿Conoces a muchos venezolanos?
• [adj.] de Venezolaanse keuken — la cocina venezolana.');

-- 32. Peru
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Perú, una peruana', 'WORD', 'Paises: Peru', 'Peru: el hombre es Peruaan (plural Peruanen), la mujer Peruaanse y el adjetivo Peruaans. Varias mujeres son de Peruaanse vrouwen.

🎯 Esta tarjeta pide el país y el femenino singular, una peruana → een Peruaanse. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Peru:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Perú | Peru |
| 2 | un hombre | un peruano | een **Peruaan** |
| 3 | hombres o grupo mixto | los peruanos | de **Peruanen** |
| 4 | una mujer | una peruana | een **Peruaanse** |
| 5 | varias mujeres | las peruanas | de **Peruaanse vrouwen** |
| 6 | adjetivo | la cocina peruana | de **Peruaanse** keuken |
| 7 | idioma | español y quechua | no hay «Peruaans» como idioma, se habla Spaans en Quechua |

⚠️ El país no lleva tilde en neerlandés, Peru, y el acento va al final como en español.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Perú, una peruana');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Perú, una peruana' LIMIT 1),
    'nl_NL', 'Peru, een Peruaanse', 'perúu, en peruáanse', '• [inv.] In Peru spreken ze Spaans en Quechua. — En Perú se habla español y quechua.
• [perf.] Mijn ouders zijn vorig jaar naar Peru gereisd. — Mis padres viajaron a Perú el año pasado.
• [can.] Ze is Peruaans, maar ze woont in Nederland. — Es peruana, pero vive en Países Bajos. (ella)
• [vraag] Werken er Peruaanse vrouwen bij jou op kantoor? — ¿Trabajan peruanas en tu oficina?
• [adj.] de Peruaanse keuken — la cocina peruana.');

-- 33. Chili
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Chile, un chileno', 'WORD', 'Paises: Chili', 'Chili: el hombre es Chileen (plural Chilenen), la mujer Chileense y el adjetivo Chileens. Varias mujeres son de Chileense vrouwen.

🎯 Esta tarjeta pide el país y el masculino singular, un chileno → een Chileen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Chili:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Chile | Chili |
| 2 | un hombre | un chileno | een **Chileen** |
| 3 | hombres o grupo mixto | los chilenos | de **Chilenen** |
| 4 | una mujer | una chilena | een **Chileense** |
| 5 | varias mujeres | las chilenas | de **Chileense vrouwen** |
| 6 | adjetivo | la cocina chilena | de **Chileense** keuken |
| 7 | idioma | español | no hay «Chileens» como idioma, se habla Spaans |

⚠️ El país se escribe Chili, igual que el chile picante (de chilipeper), y la ch suena sh. El gentilicio va en -een, Chileen y Chilenen.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Chile, un chileno');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Chile, un chileno' LIMIT 1),
    'nl_NL', 'Chili, een Chileen', 'shíili, en shiléen', '• [inv.] In Chili spreken ze Spaans. — En Chile se habla español.
• [perf.] We hebben twee weken in Chili gewoond. — Vivimos dos semanas en Chile. (pasado)
• [can.] Onze buren zijn Chileens. — Nuestros vecinos son chilenos.
• [vraag] Is jouw collega een Chileen? — ¿Tu compañero es chileno?
• [adj.] de Chileense keuken — la cocina chilena.');

-- 34. Argentinië
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Argentina, las argentinas', 'WORD', 'Paises: Argentinië', 'Argentinië: el hombre es Argentijn (plural Argentijnen), la mujer Argentijnse y el adjetivo Argentijns. Varias mujeres son de Argentijnse vrouwen.

🎯 Esta tarjeta pide el país y el femenino plural, las argentinas → de Argentijnse vrouwen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Argentinië:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Argentina | Argentinië |
| 2 | un hombre | un argentino | een **Argentijn** |
| 3 | hombres o grupo mixto | los argentinos | de **Argentijnen** |
| 4 | una mujer | una argentina | een **Argentijnse** |
| 5 | varias mujeres | las argentinas | de **Argentijnse vrouwen** |
| 6 | adjetivo | la cocina argentina | de **Argentijnse** keuken |
| 7 | idioma | español | no hay «Argentijns» como idioma, se habla Spaans |

⚠️ Familia -ijn, como Algerijn. La ij suena ei, Argentijn = arjentein.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Argentina, las argentinas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Argentina, las argentinas' LIMIT 1),
    'nl_NL', 'Argentinië, de Argentijnse vrouwen', 'arjentíini-e, de arjentéinse vráuwen', '• [inv.] In Argentinië spreken ze Spaans. — En Argentina se habla español.
• [perf.] Ik ben nog nooit in Argentinië geweest. — Nunca he estado en Argentina.
• [can.] Hij is Argentijns, hij komt uit Argentinië. — Es argentino, es de Argentina. (él)
• [vraag] Ken jij veel Argentijnen? — ¿Conoces a muchos argentinos?
• [adj.] de Argentijnse keuken — la cocina argentina.');

-- 35. Brazilië
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Brasil, una brasileña', 'WORD', 'Paises: Brazilië', 'Brazilië: el hombre es Braziliaan (plural Brazilianen), la mujer Braziliaanse y el adjetivo Braziliaans. Varias mujeres son de Braziliaanse vrouwen.

🎯 Esta tarjeta pide el país y el femenino singular, una brasileña → een Braziliaanse. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Brazilië:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Brasil | Brazilië |
| 2 | un hombre | un brasileño | een **Braziliaan** |
| 3 | hombres o grupo mixto | los brasileños | de **Brazilianen** |
| 4 | una mujer | una brasileña | een **Braziliaanse** |
| 5 | varias mujeres | las brasileñas | de **Braziliaanse vrouwen** |
| 6 | adjetivo | la cocina brasileña | de **Braziliaanse** keuken |
| 7 | idioma | portugués | no hay «Braziliaans» como idioma, se habla Portugees |

⚠️ Se escribe con z, Brazilië y Braziliaan, al contrario que el español Brasil. Y se habla Portugees.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Brasil, una brasileña');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Brasil, una brasileña' LIMIT 1),
    'nl_NL', 'Brazilië, een Braziliaanse', 'brasíili-e, en brasiliáanse', '• [inv.] In Brazilië spreken ze Portugees. — En Brasil se habla portugués.
• [perf.] Mijn ouders zijn vorig jaar naar Brazilië gereisd. — Mis padres viajaron a Brasil el año pasado.
• [can.] Ze is Braziliaans, maar ze woont in Nederland. — Es brasileña, pero vive en Países Bajos. (ella)
• [vraag] Werken er Braziliaanse vrouwen bij jou op kantoor? — ¿Trabajan brasileñas en tu oficina?
• [adj.] de Braziliaanse keuken — la cocina brasileña.');

-- 36. Suriname
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Surinam, una surinamesa', 'WORD', 'Paises: Suriname', 'Suriname: el hombre es Surinamer (plural Surinamers), la mujer Surinaamse y el adjetivo Surinaams. Varias mujeres son de Surinaamse vrouwen.

🎯 Esta tarjeta pide el país y el femenino singular, una surinamesa → een Surinaamse. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Suriname:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Surinam | Suriname |
| 2 | un hombre | un surinamés | een **Surinamer** |
| 3 | hombres o grupo mixto | los surinameses | de **Surinamers** |
| 4 | una mujer | una surinamesa | een **Surinaamse** |
| 5 | varias mujeres | las surinamesas | de **Surinaamse vrouwen** |
| 6 | adjetivo | la cocina surinamesa | de **Surinaamse** keuken |
| 7 | idioma | neerlandés y sranan tongo | no hay «Surinaams» como idioma, se habla Nederlands en Sranantongo |

⚠️ El caso que demuestra el truco. El hombre es Surinamer, pero la mujer no es «Surinamerse», sale del adjetivo, Surinaams + e = Surinaamse. Antigua colonia, con una comunidad enorme en Países Bajos.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Surinam, una surinamesa');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Surinam, una surinamesa' LIMIT 1),
    'nl_NL', 'Suriname, een Surinaamse', 'surináame, en surináamse', '• [inv.] In Suriname spreken ze Nederlands en Sranantongo. — En Surinam se habla neerlandés y sranan tongo.
• [perf.] We hebben twee weken in Suriname gewoond. — Vivimos dos semanas en Surinam. (pasado)
• [can.] Onze buren zijn Surinaams. — Nuestros vecinos son surinameses.
• [vraag] Is jouw collega een Surinamer? — ¿Tu compañero es surinamés?
• [adj.] de Surinaamse keuken — la cocina surinamesa.');

-- 37. Marokko
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Marruecos, los marroquíes', 'WORD', 'Paises: Marokko', 'Marokko: el hombre es Marokkaan (plural Marokkanen), la mujer Marokkaanse y el adjetivo Marokkaans. Varias mujeres son de Marokkaanse vrouwen.

🎯 Esta tarjeta pide el país y el masculino plural, los marroquíes → de Marokkanen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Marokko:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Marruecos | Marokko |
| 2 | un hombre | un marroquí | een **Marokkaan** |
| 3 | hombres o grupo mixto | los marroquíes | de **Marokkanen** |
| 4 | una mujer | una marroquí | een **Marokkaanse** |
| 5 | varias mujeres | las marroquíes | de **Marokkaanse vrouwen** |
| 6 | adjetivo | la cocina marroquí | de **Marokkaanse** keuken |
| 7 | idioma | árabe y bereber | no hay «Marokkaans» como idioma, se habla Arabisch en Berbers |

⚠️ Doble k en todo, Marokko, Marokkaan, Marokkaans. En español marroquí no cambia con el género; en neerlandés sí.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Marruecos, los marroquíes');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Marruecos, los marroquíes' LIMIT 1),
    'nl_NL', 'Marokko, de Marokkanen', 'maróoko, de marokáanen', '• [inv.] In Marokko spreken ze Arabisch en Berbers. — En Marruecos se habla árabe y bereber.
• [perf.] Ik ben nog nooit in Marokko geweest. — Nunca he estado en Marruecos.
• [can.] Hij is Marokkaans, hij komt uit Marokko. — Es marroquí, es de Marruecos. (él)
• [vraag] Ken jij veel Marokkanen? — ¿Conoces a muchos marroquíes?
• [adj.] de Marokkaanse keuken — la cocina marroquí.');

-- 38. Algerije
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Argelia, las argelinas', 'WORD', 'Paises: Algerije', 'Algerije: el hombre es Algerijn (plural Algerijnen), la mujer Algerijnse y el adjetivo Algerijns. Varias mujeres son de Algerijnse vrouwen.

🎯 Esta tarjeta pide el país y el femenino plural, las argelinas → de Algerijnse vrouwen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Algerije:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Argelia | Algerije |
| 2 | un hombre | un argelino | een **Algerijn** |
| 3 | hombres o grupo mixto | los argelinos | de **Algerijnen** |
| 4 | una mujer | una argelina | een **Algerijnse** |
| 5 | varias mujeres | las argelinas | de **Algerijnse vrouwen** |
| 6 | adjetivo | la cocina argelina | de **Algerijnse** keuken |
| 7 | idioma | árabe y bereber | no hay «Algerijns» como idioma, se habla Arabisch en Berbers |

⚠️ El país acaba en -ije y el gentilicio en -ijn, los dos con el sonido ei.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Argelia, las argelinas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Argelia, las argelinas' LIMIT 1),
    'nl_NL', 'Algerije, de Algerijnse vrouwen', 'aljeréie, de aljeréinse vráuwen', '• [inv.] In Algerije spreken ze Arabisch en Berbers. — En Argelia se habla árabe y bereber.
• [perf.] Mijn ouders zijn vorig jaar naar Algerije gereisd. — Mis padres viajaron a Argelia el año pasado.
• [can.] Ze is Algerijns, maar ze woont in Nederland. — Es argelina, pero vive en Países Bajos. (ella)
• [vraag] Werken er Algerijnse vrouwen bij jou op kantoor? — ¿Trabajan argelinas en tu oficina?
• [adj.] de Algerijnse keuken — la cocina argelina.');

-- 39. Egypte
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Egipto, un egipcio', 'WORD', 'Paises: Egypte', 'Egypte: el hombre es Egyptenaar (plural Egyptenaren), la mujer Egyptische y el adjetivo Egyptisch. Varias mujeres son de Egyptische vrouwen.

🎯 Esta tarjeta pide el país y el masculino singular, un egipcio → een Egyptenaar. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Egypte:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Egipto | Egypte |
| 2 | un hombre | un egipcio | een **Egyptenaar** |
| 3 | hombres o grupo mixto | los egipcios | de **Egyptenaren** |
| 4 | una mujer | una egipcia | een **Egyptische** |
| 5 | varias mujeres | las egipcias | de **Egyptische vrouwen** |
| 6 | adjetivo | la cocina egipcia | de **Egyptische** keuken |
| 7 | idioma | árabe | no hay «Egyptisch» como idioma, se habla Arabisch |

⚠️ Egyptenaar lleva -enaar, un final raro que se aprende tal cual, y plural Egyptenaren. La y suena i y la g es gutural.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Egipto, un egipcio');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Egipto, un egipcio' LIMIT 1),
    'nl_NL', 'Egypte, een Egyptenaar', 'eejípte, en eejíptenaar', '• [inv.] In Egypte spreken ze Arabisch. — En Egipto se habla árabe.
• [perf.] We hebben twee weken in Egypte gewoond. — Vivimos dos semanas en Egipto. (pasado)
• [can.] Onze buren zijn Egyptisch. — Nuestros vecinos son egipcios.
• [vraag] Is jouw collega een Egyptenaar? — ¿Tu compañero es egipcio?
• [adj.] de Egyptische keuken — la cocina egipcia.');

-- 40. Zuid-Afrika
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Sudáfrica, las sudafricanas', 'WORD', 'Paises: Zuid-Afrika', 'Zuid-Afrika: el hombre es Zuid-Afrikaan (plural Zuid-Afrikanen), la mujer Zuid-Afrikaanse y el adjetivo Zuid-Afrikaans. Varias mujeres son de Zuid-Afrikaanse vrouwen.

🎯 Esta tarjeta pide el país y el femenino plural, las sudafricanas → de Zuid-Afrikaanse vrouwen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Zuid-Afrika:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Sudáfrica | Zuid-Afrika |
| 2 | un hombre | un sudafricano | een **Zuid-Afrikaan** |
| 3 | hombres o grupo mixto | los sudafricanos | de **Zuid-Afrikanen** |
| 4 | una mujer | una sudafricana | een **Zuid-Afrikaanse** |
| 5 | varias mujeres | las sudafricanas | de **Zuid-Afrikaanse vrouwen** |
| 6 | adjetivo | la cocina sudafricana | de **Zuid-Afrikaanse** keuken |
| 7 | idioma | entre otros afrikáans, zulú e inglés | no hay «Zuid-Afrikaans» como idioma, se habla onder andere Afrikaans, Zoeloe en Engels |

⚠️ Zuid-Afrikaans es el adjetivo; el idioma hermano del neerlandés es het Afrikaans, sin Zuid. Guion siempre, Zuid-Afrika.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Sudáfrica, las sudafricanas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Sudáfrica, las sudafricanas' LIMIT 1),
    'nl_NL', 'Zuid-Afrika, de Zuid-Afrikaanse vrouwen', 'sáut-áafrika, de sáut-afrikáanse vráuwen', '• [inv.] In Zuid-Afrika spreken ze onder andere Afrikaans, Zoeloe en Engels. — En Sudáfrica se habla entre otros afrikáans, zulú e inglés.
• [perf.] Ik ben nog nooit in Zuid-Afrika geweest. — Nunca he estado en Sudáfrica.
• [can.] Hij is Zuid-Afrikaans, hij komt uit Zuid-Afrika. — Es sudafricano, es de Sudáfrica. (él)
• [vraag] Ken jij veel Zuid-Afrikanen? — ¿Conoces a muchos sudafricanos?
• [adj.] de Zuid-Afrikaanse keuken — la cocina sudafricana.');

-- 41. Nigeria
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Nigeria, los nigerianos', 'WORD', 'Paises: Nigeria', 'Nigeria: el hombre es Nigeriaan (plural Nigerianen), la mujer Nigeriaanse y el adjetivo Nigeriaans. Varias mujeres son de Nigeriaanse vrouwen.

🎯 Esta tarjeta pide el país y el masculino plural, los nigerianos → de Nigerianen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Nigeria:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Nigeria | Nigeria |
| 2 | un hombre | un nigeriano | een **Nigeriaan** |
| 3 | hombres o grupo mixto | los nigerianos | de **Nigerianen** |
| 4 | una mujer | una nigeriana | een **Nigeriaanse** |
| 5 | varias mujeres | las nigerianas | de **Nigeriaanse vrouwen** |
| 6 | adjetivo | la cocina nigeriana | de **Nigeriaanse** keuken |
| 7 | idioma | inglés | no hay «Nigeriaans» como idioma, se habla Engels |

⚠️ Familia -aan. La g es gutural, niguéria no, nijeeria.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Nigeria, los nigerianos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Nigeria, los nigerianos' LIMIT 1),
    'nl_NL', 'Nigeria, de Nigerianen', 'nijéeria, de nijeriáanen', '• [inv.] In Nigeria spreken ze Engels. — En Nigeria se habla inglés.
• [perf.] Mijn ouders zijn vorig jaar naar Nigeria gereisd. — Mis padres viajaron a Nigeria el año pasado.
• [can.] Ze is Nigeriaans, maar ze woont in Nederland. — Es nigeriana, pero vive en Países Bajos. (ella)
• [vraag] Werken er Nigeriaanse vrouwen bij jou op kantoor? — ¿Trabajan nigerianas en tu oficina?
• [adj.] de Nigeriaanse keuken — la cocina nigeriana.');

-- 42. Israël
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Israel, un israelí', 'WORD', 'Paises: Israël', 'Israël: el hombre es Israëliër (plural Israëliërs), la mujer Israëlische y el adjetivo Israëlisch. Varias mujeres son de Israëlische vrouwen.

🎯 Esta tarjeta pide el país y el masculino singular, un israelí → een Israëliër. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Israël:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Israel | Israël |
| 2 | un hombre | un israelí | een **Israëliër** |
| 3 | hombres o grupo mixto | los israelíes | de **Israëliërs** |
| 4 | una mujer | una israelí | een **Israëlische** |
| 5 | varias mujeres | las israelíes | de **Israëlische vrouwen** |
| 6 | adjetivo | la cocina israelí | de **Israëlische** keuken |
| 7 | idioma | hebreo y árabe | no hay «Israëlisch» como idioma, se habla Hebreeuws en Arabisch |

⚠️ Dos tremas, Israëliër. Familia -iër para el hombre y -ische para la mujer, como Australiër y Australische.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Israel, un israelí');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Israel, un israelí' LIMIT 1),
    'nl_NL', 'Israël, een Israëliër', 'ísra-el, en isra-éelier', '• [inv.] In Israël spreken ze Hebreeuws en Arabisch. — En Israel se habla hebreo y árabe.
• [perf.] We hebben twee weken in Israël gewoond. — Vivimos dos semanas en Israel. (pasado)
• [can.] Onze buren zijn Israëlisch. — Nuestros vecinos son israelíes.
• [vraag] Is jouw collega een Israëliër? — ¿Tu compañero es israelí?
• [adj.] de Israëlische keuken — la cocina israelí.');

-- 43. Iran
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Irán, una iraní', 'WORD', 'Paises: Iran', 'Iran: el hombre es Iraniër (plural Iraniërs), la mujer Iraanse y el adjetivo Iraans. Varias mujeres son de Iraanse vrouwen.

🎯 Esta tarjeta pide el país y el femenino singular, una iraní → een Iraanse. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Iran:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Irán | Iran |
| 2 | un hombre | un iraní | een **Iraniër** |
| 3 | hombres o grupo mixto | los iraníes | de **Iraniërs** |
| 4 | una mujer | una iraní | een **Iraanse** |
| 5 | varias mujeres | las iraníes | de **Iraanse vrouwen** |
| 6 | adjetivo | la cocina iraní | de **Iraanse** keuken |
| 7 | idioma | persa | no hay «Iraans» como idioma, se habla Perzisch |

⚠️ El hombre es Iraniër, pero la mujer sale del adjetivo Iraans, así que Iraanse, sin la -iër. Y no se habla «Iraans» sino het Perzisch.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Irán, una iraní');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Irán, una iraní' LIMIT 1),
    'nl_NL', 'Iran, een Iraanse', 'iiráan, en iiráanse', '• [inv.] In Iran spreken ze Perzisch. — En Irán se habla persa.
• [perf.] Ik ben nog nooit in Iran geweest. — Nunca he estado en Irán.
• [can.] Hij is Iraans, hij komt uit Iran. — Es iraní, es de Irán. (él)
• [vraag] Ken jij veel Iraniërs? — ¿Conoces a muchos iraníes?
• [adj.] de Iraanse keuken — la cocina iraní.');

-- 44. Syrië
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Siria, las sirias', 'WORD', 'Paises: Syrië', 'Syrië: el hombre es Syriër (plural Syriërs), la mujer Syrische y el adjetivo Syrisch. Varias mujeres son de Syrische vrouwen.

🎯 Esta tarjeta pide el país y el femenino plural, las sirias → de Syrische vrouwen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Syrië:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Siria | Syrië |
| 2 | un hombre | un sirio | een **Syriër** |
| 3 | hombres o grupo mixto | los sirios | de **Syriërs** |
| 4 | una mujer | una siria | een **Syrische** |
| 5 | varias mujeres | las sirias | de **Syrische vrouwen** |
| 6 | adjetivo | la cocina siria | de **Syrische** keuken |
| 7 | idioma | árabe | no hay «Syrisch» como idioma, se habla Arabisch |

⚠️ La y suena i, Syriër = siriër. Familia -iër, con la mujer en -ische.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Siria, las sirias');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Siria, las sirias' LIMIT 1),
    'nl_NL', 'Syrië, de Syrische vrouwen', 'síiri-e, de síirise vráuwen', '• [inv.] In Syrië spreken ze Arabisch. — En Siria se habla árabe.
• [perf.] Mijn ouders zijn vorig jaar naar Syrië gereisd. — Mis padres viajaron a Siria el año pasado.
• [can.] Ze is Syrisch, maar ze woont in Nederland. — Es siria, pero vive en Países Bajos. (ella)
• [vraag] Werken er Syrische vrouwen bij jou op kantoor? — ¿Trabajan sirias en tu oficina?
• [adj.] de Syrische keuken — la cocina siria.');

-- 45. China
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'China, los chinos', 'WORD', 'Paises: China', 'China: el hombre es Chinees (plural Chinezen), la mujer Chinese y el adjetivo Chinees. Varias mujeres son de Chinese vrouwen.

🎯 Esta tarjeta pide el país y el masculino plural, los chinos → de Chinezen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de China:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | China | China |
| 2 | un hombre | un chino | een **Chinees** |
| 3 | hombres o grupo mixto | los chinos | de **Chinezen** |
| 4 | una mujer | una china | een **Chinese** |
| 5 | varias mujeres | las chinas | de **Chinese vrouwen** |
| 6 | adjetivo | la cocina china | de **Chinese** keuken |
| 7 | idioma | chino | het Chinees |

⚠️ De Chinees es también el restaurante chino, we gaan naar de Chinees = vamos al chino. La ch suena sh.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'China, los chinos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'China, los chinos' LIMIT 1),
    'nl_NL', 'China, de Chinezen', 'shíina, de shinéesen', '• [inv.] In China spreken ze Chinees. — En China se habla chino.
• [perf.] We hebben twee weken in China gewoond. — Vivimos dos semanas en China. (pasado)
• [can.] Onze buren zijn Chinees. — Nuestros vecinos son chinos.
• [vraag] Is jouw collega een Chinees? — ¿Tu compañero es chino?
• [adj.] de Chinese keuken — la cocina china.');

-- 46. Japan
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Japón, un japonés', 'WORD', 'Paises: Japan', 'Japan: el hombre es Japanner (plural Japanners), la mujer Japanse y el adjetivo Japans. Varias mujeres son de Japanse vrouwen.

🎯 Esta tarjeta pide el país y el masculino singular, un japonés → een Japanner. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Japan:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Japón | Japan |
| 2 | un hombre | un japonés | een **Japanner** |
| 3 | hombres o grupo mixto | los japoneses | de **Japanners** |
| 4 | una mujer | una japonesa | een **Japanse** |
| 5 | varias mujeres | las japonesas | de **Japanse vrouwen** |
| 6 | adjetivo | la cocina japonesa | de **Japanse** keuken |
| 7 | idioma | japonés | het Japans |

⚠️ Japanner con doble n, pero Japanse y Japans con una sola. La j suena y.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Japón, un japonés');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Japón, un japonés' LIMIT 1),
    'nl_NL', 'Japan, een Japanner', 'yáapan, en yapáner', '• [inv.] In Japan spreken ze Japans. — En Japón se habla japonés.
• [perf.] Ik ben nog nooit in Japan geweest. — Nunca he estado en Japón.
• [can.] Hij is Japans, hij komt uit Japan. — Es japonés, es de Japón. (él)
• [vraag] Ken jij veel Japanners? — ¿Conoces a muchos japoneses?
• [adj.] de Japanse keuken — la cocina japonesa.');

-- 47. India
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'India, una india', 'WORD', 'Paises: India', 'India: el hombre es Indiër (plural Indiërs), la mujer Indiase y el adjetivo Indiaas. Varias mujeres son de Indiase vrouwen.

🎯 Esta tarjeta pide el país y el femenino singular, una india → een Indiase. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de India:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | India | India |
| 2 | un hombre | un indio | een **Indiër** |
| 3 | hombres o grupo mixto | los indios | de **Indiërs** |
| 4 | una mujer | una india | een **Indiase** |
| 5 | varias mujeres | las indias | de **Indiase vrouwen** |
| 6 | adjetivo | la cocina india | de **Indiase** keuken |
| 7 | idioma | hindi e inglés | no hay «Indiaas» como idioma, se habla Hindi en Engels |

⚠️ Tres palabras que no se mezclan. Indiër es de la India; Indiaan es un indígena de América; Indisch es lo de las antiguas Indias Neerlandesas, Indonesia (de Indische keuken).

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'India, una india');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'India, una india' LIMIT 1),
    'nl_NL', 'India, een Indiase', 'índia, en indiáase', '• [inv.] In India spreken ze Hindi en Engels. — En India se habla hindi e inglés.
• [perf.] Mijn ouders zijn vorig jaar naar India gereisd. — Mis padres viajaron a India el año pasado.
• [can.] Ze is Indiaas, maar ze woont in Nederland. — Es india, pero vive en Países Bajos. (ella)
• [vraag] Werken er Indiase vrouwen bij jou op kantoor? — ¿Trabajan indias en tu oficina?
• [adj.] de Indiase keuken — la cocina india.');

-- 48. Indonesië
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Indonesia, las indonesias', 'WORD', 'Paises: Indonesië', 'Indonesië: el hombre es Indonesiër (plural Indonesiërs), la mujer Indonesische y el adjetivo Indonesisch. Varias mujeres son de Indonesische vrouwen.

🎯 Esta tarjeta pide el país y el femenino plural, las indonesias → de Indonesische vrouwen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Indonesië:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Indonesia | Indonesië |
| 2 | un hombre | un indonesio | een **Indonesiër** |
| 3 | hombres o grupo mixto | los indonesios | de **Indonesiërs** |
| 4 | una mujer | una indonesia | een **Indonesische** |
| 5 | varias mujeres | las indonesias | de **Indonesische vrouwen** |
| 6 | adjetivo | la cocina indonesia | de **Indonesische** keuken |
| 7 | idioma | indonesio | het Indonesisch |

⚠️ Antigua colonia; de ahí la rijsttafel y los Indische Nederlanders, los neerlandeses nacidos allí. Indonesisch es lo de hoy, Indisch lo colonial.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Indonesia, las indonesias');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Indonesia, las indonesias' LIMIT 1),
    'nl_NL', 'Indonesië, de Indonesische vrouwen', 'indonéesi-e, de indonéesise vráuwen', '• [inv.] In Indonesië spreken ze Indonesisch. — En Indonesia se habla indonesio.
• [perf.] We hebben twee weken in Indonesië gewoond. — Vivimos dos semanas en Indonesia. (pasado)
• [can.] Onze buren zijn Indonesisch. — Nuestros vecinos son indonesios.
• [vraag] Is jouw collega een Indonesiër? — ¿Tu compañero es indonesio?
• [adj.] de Indonesische keuken — la cocina indonesia.');

-- 49. Pakistan
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Pakistán, los paquistaníes', 'WORD', 'Paises: Pakistan', 'Pakistan: el hombre es Pakistaan (plural Pakistanen), la mujer Pakistaanse y el adjetivo Pakistaans. Varias mujeres son de Pakistaanse vrouwen.

🎯 Esta tarjeta pide el país y el masculino plural, los paquistaníes → de Pakistanen. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Pakistan:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Pakistán | Pakistan |
| 2 | un hombre | un paquistaní | een **Pakistaan** |
| 3 | hombres o grupo mixto | los paquistaníes | de **Pakistanen** |
| 4 | una mujer | una paquistaní | een **Pakistaanse** |
| 5 | varias mujeres | las paquistaníes | de **Pakistaanse vrouwen** |
| 6 | adjetivo | la cocina paquistaní | de **Pakistaanse** keuken |
| 7 | idioma | urdu e inglés | no hay «Pakistaans» como idioma, se habla Urdu en Engels |

⚠️ Pakistaan, con dos aes, y el país Pakistan, con una. El paquistaní español no cambia con el género; el neerlandés sí.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Pakistán, los paquistaníes');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Pakistán, los paquistaníes' LIMIT 1),
    'nl_NL', 'Pakistan, de Pakistanen', 'páakistan, de pakistáanen', '• [inv.] In Pakistan spreken ze Urdu en Engels. — En Pakistán se habla urdu e inglés.
• [perf.] Ik ben nog nooit in Pakistan geweest. — Nunca he estado en Pakistán.
• [can.] Hij is Pakistaans, hij komt uit Pakistan. — Es paquistaní, es de Pakistán. (él)
• [vraag] Ken jij veel Pakistanen? — ¿Conoces a muchos paquistaníes?
• [adj.] de Pakistaanse keuken — la cocina paquistaní.');

-- 50. Australië
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Australia, un australiano', 'WORD', 'Paises: Australië', 'Australië: el hombre es Australiër (plural Australiërs), la mujer Australische y el adjetivo Australisch. Varias mujeres son de Australische vrouwen.

🎯 Esta tarjeta pide el país y el masculino singular, un australiano → een Australiër. Las otras formas salen en la tabla y en las demás tarjetas del grupo, que van rotando.

🗺️ Las siete formas de Australië:

| # | qué | español | neerlandés |
|---|---|---|---|
| 1 | el país | Australia | Australië |
| 2 | un hombre | un australiano | een **Australiër** |
| 3 | hombres o grupo mixto | los australianos | de **Australiërs** |
| 4 | una mujer | una australiana | een **Australische** |
| 5 | varias mujeres | las australianas | de **Australische vrouwen** |
| 6 | adjetivo | la cocina australiana | de **Australische** keuken |
| 7 | idioma | inglés | no hay «Australisch» como idioma, se habla Engels |

⚠️ No confundir con Oostenrijk (Austria). Australiër para él, Australische para ella.

🌍 Cómo se forma cualquier gentilicio:

| # | familia | hombre · plural | mujer | adjetivo |
|---|---|---|---|---|
| 1 | -aan → -anen | Italiaan · Italianen | Italiaanse | Italiaans |
| 2 | -ees → -ezen | Chinees · Chinezen | Chinese | Chinees |
| 3 | -er → -ers | Duitser · Duitsers | Duitse | Duits |
| 4 | -iër → -iërs | Australiër · Australiërs | Australische | Australisch |
| 5 | corto → -en | Belg · Belgen · Griek · Grieken | Belgische · Griekse | Belgisch · Grieks |
| 6 | -ijn → -ijnen | Argentijn · Argentijnen | Argentijnse | Argentijns |
| 7 | por libre | Spanjaard · Fransman · Egyptenaar | Spaanse · Française · Egyptische | Spaans · Frans · Egyptisch |

🔑 El truco que casi nunca falla: La mujer no sale del hombre sino del adjetivo, con una e detrás. Spaans → Spaanse, Duits → Duitse, Surinaams → Surinaamse, y la aa o la ee se simplifican al abrirse la sílaba (Portugees → Portugese, Indiaas → Indiase). Si sabes decir la cocina X (de Spaanse keuken), ya tienes a la mujer. La única excepción del grupo es Frankrijk, con Française.

📌 Regla de bolsillo:
• ¿Un hombre, o un grupo mixto? → la forma de hombre, een Spanjaard, de Spanjaarden.
• ¿Una mujer? → adjetivo + e, een Spaanse.
• ¿Varias mujeres? → adjetivo + e + vrouwen, de Spaanse vrouwen.
• ¿El idioma? → het + adjetivo, het Spaans, y sin artículo detrás de spreken, Ik spreek Spaans.

| # | con ser, el adjetivo SIN e | ejemplo | traducción |
|---|---|---|---|
| 1 | él | Hij is **Duits**. | Es alemán. |
| 2 | ella | Ze is **Duits**. | Es alemana. |
| 3 | ellos | Ze zijn **Duits**. | Son alemanes. |

💡 Ik ben een Spanjaard también vale, pero con ser lo más frecuente es el adjetivo, igual para él, ella y ellos, y sin la e porque va detrás del verbo.

| # | el adjetivo delante del sustantivo | ejemplo |
|---|---|---|
| 1 | de-woord | de **Spaanse** wijn |
| 2 | het-woord con het | het **Spaanse** eten |
| 3 | het-woord con een, SIN e | een **Spaans** restaurant |

📍 Tres preposiciones con el país:
• Ik kom uit Spanje. — Soy de España, el origen.
• Ik woon in Nederland. — Vivo en Países Bajos.
• We gaan naar Marokko. — Vamos a Marruecos.
• in de Verenigde Staten — el país con artículo lo arrastra, uit het Verenigd Koninkrijk.

⚠️ Mayúscula siempre, al revés que en español. Spanjaard, de Spaanse keuken, Ik spreek Spaans, también el adjetivo y el idioma.

🏋️ Ejercicio:
• Mijn buurvrouw komt uit Turkije. Ze is ___. (Turks)
• Hij komt uit Italië, hij is een ___. (Italiaan)
• In Polen wonen veel ___. (Polen)
• We eten in een ___ restaurant. (Frankrijk → Frans)
• Ze komen allebei uit Marokko, het zijn twee ___. (Marokkaanse vrouwen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Australia, un australiano');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Australia, un australiano' LIMIT 1),
    'nl_NL', 'Australië, een Australiër', 'austráali-e, en austráalier', '• [inv.] In Australië spreken ze Engels. — En Australia se habla inglés.
• [perf.] Mijn ouders zijn vorig jaar naar Australië gereisd. — Mis padres viajaron a Australia el año pasado.
• [can.] Ze is Australisch, maar ze woont in Nederland. — Es australiana, pero vive en Países Bajos. (ella)
• [vraag] Werken er Australische vrouwen bij jou op kantoor? — ¿Trabajan australianas en tu oficina?
• [adj.] de Australische keuken — la cocina australiana.');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mis vecinos son neerlandeses y me ayudan mucho.', 'SENTENCE', 'Ejemplo de "Nederland" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mis vecinos son neerlandeses y me ayudan mucho.' AND notes = 'Ejemplo de "Nederland" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mis vecinos son neerlandeses y me ayudan mucho.' AND notes = 'Ejemplo de "Nederland" (can.)' LIMIT 1),
    'nl_NL', 'Mijn buren zijn Nederlands en ze helpen me veel.', 'méin búuren sein néederlants en se hélpen me feel');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Países Bajos, un neerlandés' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mis vecinos son neerlandeses y me ayudan mucho.' AND notes = 'Ejemplo de "Nederland" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me he adaptado bien a la vida neerlandesa.', 'SENTENCE', 'Ejemplo de "Nederland" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me he adaptado bien a la vida neerlandesa.' AND notes = 'Ejemplo de "Nederland" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me he adaptado bien a la vida neerlandesa.' AND notes = 'Ejemplo de "Nederland" (perf.)' LIMIT 1),
    'nl_NL', 'Ik heb me goed aangepast aan het Nederlandse leven.', 'ik hep me jut áanjepast aan et néederlandse léefen');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Países Bajos, un neerlandés' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me he adaptado bien a la vida neerlandesa.' AND notes = 'Ejemplo de "Nederland" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Tu novio es belga?', 'SENTENCE', 'Ejemplo de "België" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Tu novio es belga?' AND notes = 'Ejemplo de "België" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tu novio es belga?' AND notes = 'Ejemplo de "België" (vraag)' LIMIT 1),
    'nl_NL', 'Is jouw vriend Belgisch?', 'is yáu frint béljis');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Bélgica, una belga' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿Tu novio es belga?' AND notes = 'Ejemplo de "België" (vraag)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Vuestro profesor es belga?', 'SENTENCE', 'Ejemplo de "België" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Vuestro profesor es belga?' AND notes = 'Ejemplo de "België" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Vuestro profesor es belga?' AND notes = 'Ejemplo de "België" (vraag)' LIMIT 1),
    'nl_NL', 'Is jullie leraar Belgisch?', 'is yúlie léeraar béljis');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Bélgica, una belga' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿Vuestro profesor es belga?' AND notes = 'Ejemplo de "België" (vraag)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Cuando vivía en Bruselas, tenía muchos amigos belgas.', 'SENTENCE', 'Ejemplo de "België" (imperf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cuando vivía en Bruselas, tenía muchos amigos belgas.' AND notes = 'Ejemplo de "België" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuando vivía en Bruselas, tenía muchos amigos belgas.' AND notes = 'Ejemplo de "België" (imperf.)' LIMIT 1),
    'nl_NL', 'Toen ik in Brussel woonde, had ik veel Belgische vrienden.', 'tun ik in brúsel wóonde, hat ik feel béljise frínden');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Bélgica, una belga' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Cuando vivía en Bruselas, tenía muchos amigos belgas.' AND notes = 'Ejemplo de "België" (imperf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi jefe es alemán y habla muy rápido.', 'SENTENCE', 'Ejemplo de "Duitsland" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi jefe es alemán y habla muy rápido.' AND notes = 'Ejemplo de "Duitsland" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi jefe es alemán y habla muy rápido.' AND notes = 'Ejemplo de "Duitsland" (can.)' LIMIT 1),
    'nl_NL', 'Mijn baas is Duits en hij praat heel snel.', 'méin baas is dáuts en hei praat heel snel');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Alemania, los alemanes' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi jefe es alemán y habla muy rápido.' AND notes = 'Ejemplo de "Duitsland" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Dice que los alemanes siempre llegan puntuales. (ella)', 'SENTENCE', 'Ejemplo de "Duitsland" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Dice que los alemanes siempre llegan puntuales. (ella)' AND notes = 'Ejemplo de "Duitsland" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que los alemanes siempre llegan puntuales. (ella)' AND notes = 'Ejemplo de "Duitsland" (bijzin)' LIMIT 1),
    'nl_NL', 'Ze zegt dat Duitsers altijd op tijd komen.', 'se sejt dat dáutsers álteit op teit kóomen');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Alemania, los alemanes' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Dice que los alemanes siempre llegan puntuales. (ella)' AND notes = 'Ejemplo de "Duitsland" (bijzin)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Su pasaporte es alemán? (formal, con "u")', 'SENTENCE', 'Ejemplo de "Duitsland" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Su pasaporte es alemán? (formal, con "u")' AND notes = 'Ejemplo de "Duitsland" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Su pasaporte es alemán? (formal, con "u")' AND notes = 'Ejemplo de "Duitsland" (vraag)' LIMIT 1),
    'nl_NL', 'Is uw paspoort Duits?', 'is uu páspoort dáuts');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Alemania, los alemanes' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿Su pasaporte es alemán? (formal, con "u")' AND notes = 'Ejemplo de "Duitsland" (vraag)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'El verano que viene iremos a Francia con nuestros hijos.', 'SENTENCE', 'Ejemplo de "Frankrijk" (fut.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El verano que viene iremos a Francia con nuestros hijos.' AND notes = 'Ejemplo de "Frankrijk" (fut.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El verano que viene iremos a Francia con nuestros hijos.' AND notes = 'Ejemplo de "Frankrijk" (fut.)' LIMIT 1),
    'nl_NL', 'Volgende zomer gaan we met onze kinderen naar Frankrijk.', 'fóljende sóomer jaan we met ónse kínderen naar fránkreik');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Francia, una francesa' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'El verano que viene iremos a Francia con nuestros hijos.' AND notes = 'Ejemplo de "Frankrijk" (fut.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Su mujer es francesa. (él)', 'SENTENCE', 'Ejemplo de "Frankrijk" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Su mujer es francesa. (él)' AND notes = 'Ejemplo de "Frankrijk" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Su mujer es francesa. (él)' AND notes = 'Ejemplo de "Frankrijk" (can.)' LIMIT 1),
    'nl_NL', 'Zijn vrouw is Frans.', 'sein fráu is frans');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Francia, una francesa' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Su mujer es francesa. (él)' AND notes = 'Ejemplo de "Frankrijk" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me he encontrado con un español en el tren.', 'SENTENCE', 'Ejemplo de "Spanje" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me he encontrado con un español en el tren.' AND notes = 'Ejemplo de "Spanje" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me he encontrado con un español en el tren.' AND notes = 'Ejemplo de "Spanje" (perf.)' LIMIT 1),
    'nl_NL', 'Ik ben in de trein een Spanjaard tegengekomen.', 'ik ben in de trein en spaniárt téejenjekoomen');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'España, los españoles' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me he encontrado con un español en el tren.' AND notes = 'Ejemplo de "Spanje" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'En España cenamos muy tarde. (presente)', 'SENTENCE', 'Ejemplo de "Spanje" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'En España cenamos muy tarde. (presente)' AND notes = 'Ejemplo de "Spanje" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'En España cenamos muy tarde. (presente)' AND notes = 'Ejemplo de "Spanje" (inv.)' LIMIT 1),
    'nl_NL', 'In Spanje eten we heel laat.', 'in spánie éeten we heel laat');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'España, los españoles' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'En España cenamos muy tarde. (presente)' AND notes = 'Ejemplo de "Spanje" (inv.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Echas de menos a tu familia española?', 'SENTENCE', 'Ejemplo de "Spanje" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Echas de menos a tu familia española?' AND notes = 'Ejemplo de "Spanje" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Echas de menos a tu familia española?' AND notes = 'Ejemplo de "Spanje" (vraag)' LIMIT 1),
    'nl_NL', 'Mis je je Spaanse familie?', 'mis ye ye spáanse famílie');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'España, los españoles' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿Echas de menos a tu familia española?' AND notes = 'Ejemplo de "Spanje" (vraag)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi abuela era portuguesa.', 'SENTENCE', 'Ejemplo de "Portugal" (imperf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi abuela era portuguesa.' AND notes = 'Ejemplo de "Portugal" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi abuela era portuguesa.' AND notes = 'Ejemplo de "Portugal" (imperf.)' LIMIT 1),
    'nl_NL', 'Mijn oma was Portugees.', 'méin óoma was portujées');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Portugal, las portuguesas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi abuela era portuguesa.' AND notes = 'Ejemplo de "Portugal" (imperf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Los portugueses entienden bien el español.', 'SENTENCE', 'Ejemplo de "Portugal" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los portugueses entienden bien el español.' AND notes = 'Ejemplo de "Portugal" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Los portugueses entienden bien el español.' AND notes = 'Ejemplo de "Portugal" (can.)' LIMIT 1),
    'nl_NL', 'Portugezen verstaan goed Spaans.', 'portujéesen ferstáan jut spaans');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Portugal, las portuguesas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Los portugueses entienden bien el español.' AND notes = 'Ejemplo de "Portugal" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Nos hemos enamorado de la cocina italiana.', 'SENTENCE', 'Ejemplo de "Italië" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Nos hemos enamorado de la cocina italiana.' AND notes = 'Ejemplo de "Italië" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Nos hemos enamorado de la cocina italiana.' AND notes = 'Ejemplo de "Italië" (perf.)' LIMIT 1),
    'nl_NL', 'We zijn verliefd geworden op de Italiaanse keuken.', 'we sein ferlíift jewórden op de itali-áanse kéuken');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Italia, un italiano' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Nos hemos enamorado de la cocina italiana.' AND notes = 'Ejemplo de "Italië" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me preguntó si su marido era italiano. (ella)', 'SENTENCE', 'Ejemplo de "Italië" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me preguntó si su marido era italiano. (ella)' AND notes = 'Ejemplo de "Italië" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me preguntó si su marido era italiano. (ella)' AND notes = 'Ejemplo de "Italië" (bijzin)' LIMIT 1),
    'nl_NL', 'Ze vroeg me of haar man Italiaans was.', 'se frooj me of haar man itali-áans was');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Italia, un italiano' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me preguntó si su marido era italiano. (ella)' AND notes = 'Ejemplo de "Italië" (bijzin)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Los británicos conducen por la izquierda.', 'SENTENCE', 'Ejemplo de "het Verenigd Koninkrijk" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los británicos conducen por la izquierda.' AND notes = 'Ejemplo de "het Verenigd Koninkrijk" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Los británicos conducen por la izquierda.' AND notes = 'Ejemplo de "het Verenigd Koninkrijk" (can.)' LIMIT 1),
    'nl_NL', 'Britten rijden links.', 'bríten réiden links');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'El Reino Unido, los británicos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Los británicos conducen por la izquierda.' AND notes = 'Ejemplo de "het Verenigd Koninkrijk" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Se ha mudado a Londres con su novia inglesa. (él)', 'SENTENCE', 'Ejemplo de "het Verenigd Koninkrijk" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Se ha mudado a Londres con su novia inglesa. (él)' AND notes = 'Ejemplo de "het Verenigd Koninkrijk" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Se ha mudado a Londres con su novia inglesa. (él)' AND notes = 'Ejemplo de "het Verenigd Koninkrijk" (perf.)' LIMIT 1),
    'nl_NL', 'Hij is met zijn Engelse vriendin naar Londen verhuisd.', 'hei is met sein éngelse frindín naar lónden ferháust');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'El Reino Unido, los británicos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Se ha mudado a Londres con su novia inglesa. (él)' AND notes = 'Ejemplo de "het Verenigd Koninkrijk" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Las irlandesas del curso eran muy simpáticas.', 'SENTENCE', 'Ejemplo de "Ierland" (imperf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Las irlandesas del curso eran muy simpáticas.' AND notes = 'Ejemplo de "Ierland" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Las irlandesas del curso eran muy simpáticas.' AND notes = 'Ejemplo de "Ierland" (imperf.)' LIMIT 1),
    'nl_NL', 'De Ierse vrouwen van de cursus waren heel aardig.', 'de íirse vráuwen fan de kúrsus wáaren heel áardej');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Irlanda, las irlandesas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Las irlandesas del curso eran muy simpáticas.' AND notes = 'Ejemplo de "Ierland" (imperf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi cuñada es suiza y habla cuatro idiomas.', 'SENTENCE', 'Ejemplo de "Zwitserland" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi cuñada es suiza y habla cuatro idiomas.' AND notes = 'Ejemplo de "Zwitserland" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi cuñada es suiza y habla cuatro idiomas.' AND notes = 'Ejemplo de "Zwitserland" (can.)' LIMIT 1),
    'nl_NL', 'Mijn schoonzus is Zwitsers en ze spreekt vier talen.', 'méin sjóonsus is suítsers en se spreekt fiir táalen');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Suiza, una suiza' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi cuñada es suiza y habla cuatro idiomas.' AND notes = 'Ejemplo de "Zwitserland" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mañana viene un austriaco a la oficina.', 'SENTENCE', 'Ejemplo de "Oostenrijk" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mañana viene un austriaco a la oficina.' AND notes = 'Ejemplo de "Oostenrijk" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mañana viene un austriaco a la oficina.' AND notes = 'Ejemplo de "Oostenrijk" (can.)' LIMIT 1),
    'nl_NL', 'Morgen komt er een Oostenrijker naar kantoor.', 'mórjen komt er en óostenreiker naar kantóor');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Austria, un austriaco' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mañana viene un austriaco a la oficina.' AND notes = 'Ejemplo de "Oostenrijk" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Habéis estado alguna vez en Dinamarca?', 'SENTENCE', 'Ejemplo de "Denemarken" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Habéis estado alguna vez en Dinamarca?' AND notes = 'Ejemplo de "Denemarken" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Habéis estado alguna vez en Dinamarca?' AND notes = 'Ejemplo de "Denemarken" (perf.)' LIMIT 1),
    'nl_NL', 'Zijn jullie weleens in Denemarken geweest?', 'sein yúlie wéelens in déenemarken jewéest');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Dinamarca, las danesas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿Habéis estado alguna vez en Dinamarca?' AND notes = 'Ejemplo de "Denemarken" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Los suecos se visten de forma muy sencilla.', 'SENTENCE', 'Ejemplo de "Zweden" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los suecos se visten de forma muy sencilla.' AND notes = 'Ejemplo de "Zweden" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Los suecos se visten de forma muy sencilla.' AND notes = 'Ejemplo de "Zweden" (can.)' LIMIT 1),
    'nl_NL', 'Zweden kleden zich heel eenvoudig.', 'suéeden kléeden sij heel éenfaudej');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Suecia, los suecos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Los suecos se visten de forma muy sencilla.' AND notes = 'Ejemplo de "Zweden" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Creo que su novia es noruega. (él)', 'SENTENCE', 'Ejemplo de "Noorwegen" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Creo que su novia es noruega. (él)' AND notes = 'Ejemplo de "Noorwegen" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Creo que su novia es noruega. (él)' AND notes = 'Ejemplo de "Noorwegen" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik denk dat zijn vriendin Noors is.', 'ik denk dat sein frindín noors is');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Noruega, una noruega' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Creo que su novia es noruega. (él)' AND notes = 'Ejemplo de "Noorwegen" (bijzin)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Cuando éramos niños, teníamos un vecino finlandés.', 'SENTENCE', 'Ejemplo de "Finland" (imperf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cuando éramos niños, teníamos un vecino finlandés.' AND notes = 'Ejemplo de "Finland" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuando éramos niños, teníamos un vecino finlandés.' AND notes = 'Ejemplo de "Finland" (imperf.)' LIMIT 1),
    'nl_NL', 'Toen we klein waren, hadden we een Finse buurman.', 'tun we klein wáaren, háden we en fínse búurman');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Finlandia, un finlandés' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Cuando éramos niños, teníamos un vecino finlandés.' AND notes = 'Ejemplo de "Finland" (imperf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Muchos polacos trabajan en la construcción.', 'SENTENCE', 'Ejemplo de "Polen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Muchos polacos trabajan en la construcción.' AND notes = 'Ejemplo de "Polen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Muchos polacos trabajan en la construcción.' AND notes = 'Ejemplo de "Polen" (can.)' LIMIT 1),
    'nl_NL', 'Veel Polen werken in de bouw.', 'feel póolen wérken in de báu');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Polonia, los polacos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Muchos polacos trabajan en la construcción.' AND notes = 'Ejemplo de "Polen" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me he equivocado: no es polaca, es checa. (ella)', 'SENTENCE', 'Ejemplo de "Polen" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me he equivocado: no es polaca, es checa. (ella)' AND notes = 'Ejemplo de "Polen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me he equivocado: no es polaca, es checa. (ella)' AND notes = 'Ejemplo de "Polen" (perf.)' LIMIT 1),
    'nl_NL', 'Ik heb me vergist: ze is niet Pools, ze is Tsjechisch.', 'ik hep me ferjíst, se is niit pools, se is chéjis');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Polonia, los polacos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me he equivocado: no es polaca, es checa. (ella)' AND notes = 'Ejemplo de "Polen" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Conoces a algún húngaro?', 'SENTENCE', 'Ejemplo de "Hongarije" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Conoces a algún húngaro?' AND notes = 'Ejemplo de "Hongarije" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Conoces a algún húngaro?' AND notes = 'Ejemplo de "Hongarije" (vraag)' LIMIT 1),
    'nl_NL', 'Ken je een Hongaar?', 'ken ye en hongáar');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Hungría, un húngaro' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿Conoces a algún húngaro?' AND notes = 'Ejemplo de "Hongarije" (vraag)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Nuestra canguro rumana se ha vuelto a su país.', 'SENTENCE', 'Ejemplo de "Roemenië" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Nuestra canguro rumana se ha vuelto a su país.' AND notes = 'Ejemplo de "Roemenië" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Nuestra canguro rumana se ha vuelto a su país.' AND notes = 'Ejemplo de "Roemenië" (perf.)' LIMIT 1),
    'nl_NL', 'Onze Roemeense oppas is teruggegaan naar haar land.', 'ónse ruméense ópas is terújejaan naar haar lant');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Rumanía, una rumana' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Nuestra canguro rumana se ha vuelto a su país.' AND notes = 'Ejemplo de "Roemenië" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi profesora de piano era búlgara.', 'SENTENCE', 'Ejemplo de "Bulgarije" (imperf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi profesora de piano era búlgara.' AND notes = 'Ejemplo de "Bulgarije" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi profesora de piano era búlgara.' AND notes = 'Ejemplo de "Bulgarije" (imperf.)' LIMIT 1),
    'nl_NL', 'Mijn pianolerares was Bulgaars.', 'méin piánoleeraares was bulgáars');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Bulgaria, las búlgaras' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi profesora de piano era búlgara.' AND notes = 'Ejemplo de "Bulgarije" (imperf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Este verano vamos a Grecia con unos amigos griegos.', 'SENTENCE', 'Ejemplo de "Griekenland" (fut.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Este verano vamos a Grecia con unos amigos griegos.' AND notes = 'Ejemplo de "Griekenland" (fut.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Este verano vamos a Grecia con unos amigos griegos.' AND notes = 'Ejemplo de "Griekenland" (fut.)' LIMIT 1),
    'nl_NL', 'Deze zomer gaan we met een paar Griekse vrienden naar Griekenland.', 'déese sóomer jaan we met en paar jríikse frínden naar jríikenlant');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Grecia, los griegos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Este verano vamos a Grecia con unos amigos griegos.' AND notes = 'Ejemplo de "Griekenland" (fut.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Ese chico es croata; sus padres viven en Zagreb.', 'SENTENCE', 'Ejemplo de "Kroatië" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ese chico es croata; sus padres viven en Zagreb.' AND notes = 'Ejemplo de "Kroatië" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ese chico es croata; sus padres viven en Zagreb.' AND notes = 'Ejemplo de "Kroatië" (can.)' LIMIT 1),
    'nl_NL', 'Die jongen is Kroatisch; zijn ouders wonen in Zagreb.', 'di yóngen is kroáatis, sein áuders wóonen in sáajrep');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Croacia, un croata' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Ese chico es croata; sus padres viven en Zagreb.' AND notes = 'Ejemplo de "Kroatië" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi abuelo hablaba ruso con su vecina rusa.', 'SENTENCE', 'Ejemplo de "Rusland" (imperf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi abuelo hablaba ruso con su vecina rusa.' AND notes = 'Ejemplo de "Rusland" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi abuelo hablaba ruso con su vecina rusa.' AND notes = 'Ejemplo de "Rusland" (imperf.)' LIMIT 1),
    'nl_NL', 'Mijn opa sprak Russisch met zijn Russische buurvrouw.', 'méin ópa sprak rúsis met sein rúsise búurfrau');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Rusia, una rusa' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi abuelo hablaba ruso con su vecina rusa.' AND notes = 'Ejemplo de "Rusland" (imperf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Muchos ucranianos se han instalado en Países Bajos.', 'SENTENCE', 'Ejemplo de "Oekraïne" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Muchos ucranianos se han instalado en Países Bajos.' AND notes = 'Ejemplo de "Oekraïne" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Muchos ucranianos se han instalado en Países Bajos.' AND notes = 'Ejemplo de "Oekraïne" (perf.)' LIMIT 1),
    'nl_NL', 'Veel Oekraïners hebben zich in Nederland gevestigd.', 'feel ukra-íiners hében sij in néederlant jeféstijt');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Ucrania, un ucraniano' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Muchos ucranianos se han instalado en Países Bajos.' AND notes = 'Ejemplo de "Oekraïne" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'El panadero de mi calle es turco y nos conoce a todos.', 'SENTENCE', 'Ejemplo de "Turkije" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El panadero de mi calle es turco y nos conoce a todos.' AND notes = 'Ejemplo de "Turkije" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El panadero de mi calle es turco y nos conoce a todos.' AND notes = 'Ejemplo de "Turkije" (can.)' LIMIT 1),
    'nl_NL', 'De bakker in mijn straat is Turks en hij kent ons allemaal.', 'de báker in méin straat is turks en hei kent ons álemaal');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Turquía, los turcos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'El panadero de mi calle es turco y nos conoce a todos.' AND notes = 'Ejemplo de "Turkije" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Los domingos comemos en un restaurante turco. (presente)', 'SENTENCE', 'Ejemplo de "Turkije" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los domingos comemos en un restaurante turco. (presente)' AND notes = 'Ejemplo de "Turkije" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Los domingos comemos en un restaurante turco. (presente)' AND notes = 'Ejemplo de "Turkije" (inv.)' LIMIT 1),
    'nl_NL', 'Op zondag eten we in een Turks restaurant.', 'op sóndaj éeten we in en turks restoránt');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Turquía, los turcos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Los domingos comemos en un restaurante turco. (presente)' AND notes = 'Ejemplo de "Turkije" (inv.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Tu hermana se ha casado con un estadounidense?', 'SENTENCE', 'Ejemplo de "de Verenigde Staten" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Tu hermana se ha casado con un estadounidense?' AND notes = 'Ejemplo de "de Verenigde Staten" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tu hermana se ha casado con un estadounidense?' AND notes = 'Ejemplo de "de Verenigde Staten" (perf.)' LIMIT 1),
    'nl_NL', 'Is jouw zus met een Amerikaan getrouwd?', 'is yáu sus met en amerikáan jetráut');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Estados Unidos, los estadounidenses' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿Tu hermana se ha casado con un estadounidense?' AND notes = 'Ejemplo de "de Verenigde Staten" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Los estadounidenses dicen que Países Bajos es muy pequeño.', 'SENTENCE', 'Ejemplo de "de Verenigde Staten" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los estadounidenses dicen que Países Bajos es muy pequeño.' AND notes = 'Ejemplo de "de Verenigde Staten" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Los estadounidenses dicen que Países Bajos es muy pequeño.' AND notes = 'Ejemplo de "de Verenigde Staten" (bijzin)' LIMIT 1),
    'nl_NL', 'Amerikanen zeggen dat Nederland heel klein is.', 'amerikáanen séjen dat néederlant heel klein is');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Estados Unidos, los estadounidenses' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Los estadounidenses dicen que Países Bajos es muy pequeño.' AND notes = 'Ejemplo de "de Verenigde Staten" (bijzin)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi primo se irá a vivir a Canadá.', 'SENTENCE', 'Ejemplo de "Canada" (fut.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi primo se irá a vivir a Canadá.' AND notes = 'Ejemplo de "Canada" (fut.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi primo se irá a vivir a Canadá.' AND notes = 'Ejemplo de "Canada" (fut.)' LIMIT 1),
    'nl_NL', 'Mijn neef gaat in Canada wonen.', 'méin neef jaat in kánada wóonen');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Canadá, las canadienses' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi primo se irá a vivir a Canadá.' AND notes = 'Ejemplo de "Canada" (fut.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi compañera mexicana hace unos tacos buenísimos.', 'SENTENCE', 'Ejemplo de "Mexico" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi compañera mexicana hace unos tacos buenísimos.' AND notes = 'Ejemplo de "Mexico" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi compañera mexicana hace unos tacos buenísimos.' AND notes = 'Ejemplo de "Mexico" (can.)' LIMIT 1),
    'nl_NL', 'Mijn Mexicaanse collega maakt heerlijke taco''s.', 'méin meksikáanse koléeja maakt héerleke tákos');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'México, una mexicana' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi compañera mexicana hace unos tacos buenísimos.' AND notes = 'Ejemplo de "Mexico" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi padre tenía un amigo cubano que tocaba la guitarra.', 'SENTENCE', 'Ejemplo de "Cuba" (imperf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi padre tenía un amigo cubano que tocaba la guitarra.' AND notes = 'Ejemplo de "Cuba" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi padre tenía un amigo cubano que tocaba la guitarra.' AND notes = 'Ejemplo de "Cuba" (imperf.)' LIMIT 1),
    'nl_NL', 'Mijn vader had een Cubaanse vriend die gitaar speelde.', 'méin fáader hat en kubáanse frint di jitáar spéelde');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuba, un cubano' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi padre tenía un amigo cubano que tocaba la guitarra.' AND notes = 'Ejemplo de "Cuba" (imperf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Las colombianas del grupo nos han invitado a su fiesta.', 'SENTENCE', 'Ejemplo de "Colombia" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Las colombianas del grupo nos han invitado a su fiesta.' AND notes = 'Ejemplo de "Colombia" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Las colombianas del grupo nos han invitado a su fiesta.' AND notes = 'Ejemplo de "Colombia" (perf.)' LIMIT 1),
    'nl_NL', 'De Colombiaanse vrouwen van de groep hebben ons voor hun feest uitgenodigd.', 'de kolombiáanse vráuwen fan de jrup hében ons foor hun feest áutjenoodijt');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Colombia, las colombianas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Las colombianas del grupo nos han invitado a su fiesta.' AND notes = 'Ejemplo de "Colombia" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Muchos venezolanos viven ahora en España.', 'SENTENCE', 'Ejemplo de "Venezuela" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Muchos venezolanos viven ahora en España.' AND notes = 'Ejemplo de "Venezuela" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Muchos venezolanos viven ahora en España.' AND notes = 'Ejemplo de "Venezuela" (can.)' LIMIT 1),
    'nl_NL', 'Veel Venezolanen wonen nu in Spanje.', 'feel fenesoláanen wóonen nu in spánie');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Venezuela, los venezolanos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Muchos venezolanos viven ahora en España.' AND notes = 'Ejemplo de "Venezuela" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Vosotros sois peruanos?', 'SENTENCE', 'Ejemplo de "Peru" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Vosotros sois peruanos?' AND notes = 'Ejemplo de "Peru" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Vosotros sois peruanos?' AND notes = 'Ejemplo de "Peru" (vraag)' LIMIT 1),
    'nl_NL', 'Zijn jullie Peruaans?', 'sein yúlie peruáans');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Perú, una peruana' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿Vosotros sois peruanos?' AND notes = 'Ejemplo de "Peru" (vraag)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me he olvidado del nombre de ese chileno.', 'SENTENCE', 'Ejemplo de "Chili" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me he olvidado del nombre de ese chileno.' AND notes = 'Ejemplo de "Chili" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me he olvidado del nombre de ese chileno.' AND notes = 'Ejemplo de "Chili" (perf.)' LIMIT 1),
    'nl_NL', 'Ik ben de naam van die Chileen vergeten.', 'ik ben de naam fan di shiléen ferjéeten');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Chile, un chileno' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me he olvidado del nombre de ese chileno.' AND notes = 'Ejemplo de "Chili" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Los argentinos se toman el fútbol muy en serio.', 'SENTENCE', 'Ejemplo de "Argentinië" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los argentinos se toman el fútbol muy en serio.' AND notes = 'Ejemplo de "Argentinië" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Los argentinos se toman el fútbol muy en serio.' AND notes = 'Ejemplo de "Argentinië" (can.)' LIMIT 1),
    'nl_NL', 'Argentijnen nemen voetbal heel serieus.', 'arjentéinen néemen fútbal heel seriús');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Argentina, las argentinas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Los argentinos se toman el fútbol muy en serio.' AND notes = 'Ejemplo de "Argentinië" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'El año que viene celebraremos el carnaval con nuestra amiga brasileña.', 'SENTENCE', 'Ejemplo de "Brazilië" (fut.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El año que viene celebraremos el carnaval con nuestra amiga brasileña.' AND notes = 'Ejemplo de "Brazilië" (fut.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El año que viene celebraremos el carnaval con nuestra amiga brasileña.' AND notes = 'Ejemplo de "Brazilië" (fut.)' LIMIT 1),
    'nl_NL', 'Volgend jaar vieren we carnaval met onze Braziliaanse vriendin.', 'fóljent yaar fíiren we kárnafal met ónse brasiliáanse frindín');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Brasil, una brasileña' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'El año que viene celebraremos el carnaval con nuestra amiga brasileña.' AND notes = 'Ejemplo de "Brazilië" (fut.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi vecina es surinamesa y cocina roti los sábados.', 'SENTENCE', 'Ejemplo de "Suriname" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi vecina es surinamesa y cocina roti los sábados.' AND notes = 'Ejemplo de "Suriname" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi vecina es surinamesa y cocina roti los sábados.' AND notes = 'Ejemplo de "Suriname" (can.)' LIMIT 1),
    'nl_NL', 'Mijn buurvrouw is Surinaams en ze kookt op zaterdag roti.', 'méin búurfrau is surináams en se kookt op sáaterdaj róoti');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Surinam, una surinamesa' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi vecina es surinamesa y cocina roti los sábados.' AND notes = 'Ejemplo de "Suriname" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Antes vivían muchos surinameses en este barrio.', 'SENTENCE', 'Ejemplo de "Suriname" (imperf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Antes vivían muchos surinameses en este barrio.' AND notes = 'Ejemplo de "Suriname" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Antes vivían muchos surinameses en este barrio.' AND notes = 'Ejemplo de "Suriname" (imperf.)' LIMIT 1),
    'nl_NL', 'Vroeger woonden er veel Surinamers in deze wijk.', 'frúujer wóonden er feel surináamers in déese weik');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Surinam, una surinamesa' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Antes vivían muchos surinameses en este barrio.' AND notes = 'Ejemplo de "Suriname" (imperf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Nos hemos alojado en casa de una familia marroquí.', 'SENTENCE', 'Ejemplo de "Marokko" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Nos hemos alojado en casa de una familia marroquí.' AND notes = 'Ejemplo de "Marokko" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Nos hemos alojado en casa de una familia marroquí.' AND notes = 'Ejemplo de "Marokko" (perf.)' LIMIT 1),
    'nl_NL', 'We hebben bij een Marokkaanse familie gelogeerd.', 'we hében bei en marokáanse famílie jeloshéert');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Marruecos, los marroquíes' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Nos hemos alojado en casa de una familia marroquí.' AND notes = 'Ejemplo de "Marokko" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Sé que tus suegros son marroquíes.', 'SENTENCE', 'Ejemplo de "Marokko" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Sé que tus suegros son marroquíes.' AND notes = 'Ejemplo de "Marokko" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Sé que tus suegros son marroquíes.' AND notes = 'Ejemplo de "Marokko" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik weet dat jouw schoonouders Marokkaans zijn.', 'ik weet dat yáu sjóonauders marokáans sein');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Marruecos, los marroquíes' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Sé que tus suegros son marroquíes.' AND notes = 'Ejemplo de "Marokko" (bijzin)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi compañero argelino me ayuda con el francés.', 'SENTENCE', 'Ejemplo de "Algerije" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi compañero argelino me ayuda con el francés.' AND notes = 'Ejemplo de "Algerije" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi compañero argelino me ayuda con el francés.' AND notes = 'Ejemplo de "Algerije" (can.)' LIMIT 1),
    'nl_NL', 'Mijn Algerijnse collega helpt me met Frans.', 'méin aljeréinse koléeja helpt me met frans');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Argelia, las argelinas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi compañero argelino me ayuda con el francés.' AND notes = 'Ejemplo de "Algerije" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'El guía era egipcio y nos lo explicaba todo.', 'SENTENCE', 'Ejemplo de "Egypte" (imperf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El guía era egipcio y nos lo explicaba todo.' AND notes = 'Ejemplo de "Egypte" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El guía era egipcio y nos lo explicaba todo.' AND notes = 'Ejemplo de "Egypte" (imperf.)' LIMIT 1),
    'nl_NL', 'De gids was Egyptisch en hij legde ons alles uit.', 'de jits was eejíptis en hei léjde ons áles áut');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Egipto, un egipcio' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'El guía era egipcio y nos lo explicaba todo.' AND notes = 'Ejemplo de "Egypte" (imperf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Los sudafricanos entienden bastante bien el neerlandés.', 'SENTENCE', 'Ejemplo de "Zuid-Afrika" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los sudafricanos entienden bastante bien el neerlandés.' AND notes = 'Ejemplo de "Zuid-Afrika" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Los sudafricanos entienden bastante bien el neerlandés.' AND notes = 'Ejemplo de "Zuid-Afrika" (can.)' LIMIT 1),
    'nl_NL', 'Zuid-Afrikanen verstaan redelijk goed Nederlands.', 'sáut-afrikáanen ferstáan réedelek jut néederlants');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Sudáfrica, las sudafricanas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Los sudafricanos entienden bastante bien el neerlandés.' AND notes = 'Ejemplo de "Zuid-Afrika" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Su marido nigeriano ha encontrado trabajo en Róterdam. (ella)', 'SENTENCE', 'Ejemplo de "Nigeria" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Su marido nigeriano ha encontrado trabajo en Róterdam. (ella)' AND notes = 'Ejemplo de "Nigeria" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Su marido nigeriano ha encontrado trabajo en Róterdam. (ella)' AND notes = 'Ejemplo de "Nigeria" (perf.)' LIMIT 1),
    'nl_NL', 'Haar Nigeriaanse man heeft werk gevonden in Rotterdam.', 'haar nijeriáanse man heeft werk jefónden in róterdam');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Nigeria, los nigerianos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Su marido nigeriano ha encontrado trabajo en Róterdam. (ella)' AND notes = 'Ejemplo de "Nigeria" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Tus amigos israelíes hablan inglés?', 'SENTENCE', 'Ejemplo de "Israël" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Tus amigos israelíes hablan inglés?' AND notes = 'Ejemplo de "Israël" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tus amigos israelíes hablan inglés?' AND notes = 'Ejemplo de "Israël" (vraag)' LIMIT 1),
    'nl_NL', 'Spreken jouw Israëlische vrienden Engels?', 'spréeken yáu isra-éelise frínden éngels');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Israel, un israelí' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿Tus amigos israelíes hablan inglés?' AND notes = 'Ejemplo de "Israël" (vraag)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi compañera iraní me ha enseñado a hacer arroz.', 'SENTENCE', 'Ejemplo de "Iran" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi compañera iraní me ha enseñado a hacer arroz.' AND notes = 'Ejemplo de "Iran" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi compañera iraní me ha enseñado a hacer arroz.' AND notes = 'Ejemplo de "Iran" (perf.)' LIMIT 1),
    'nl_NL', 'Mijn Iraanse collega heeft me geleerd hoe je rijst maakt.', 'méin iiráanse koléeja heeft me jeléert hu ye reist maakt');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Irán, una iraní' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi compañera iraní me ha enseñado a hacer arroz.' AND notes = 'Ejemplo de "Iran" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Las sirias del curso de idiomas se ayudan entre ellas.', 'SENTENCE', 'Ejemplo de "Syrië" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Las sirias del curso de idiomas se ayudan entre ellas.' AND notes = 'Ejemplo de "Syrië" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Las sirias del curso de idiomas se ayudan entre ellas.' AND notes = 'Ejemplo de "Syrië" (can.)' LIMIT 1),
    'nl_NL', 'De Syrische vrouwen van de taalcursus helpen elkaar.', 'de síirise vráuwen fan de táalkursus hélpen elkáar');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Siria, las sirias' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Las sirias del curso de idiomas se ayudan entre ellas.' AND notes = 'Ejemplo de "Syrië" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Esta noche cenamos en el chino. (presente)', 'SENTENCE', 'Ejemplo de "China" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Esta noche cenamos en el chino. (presente)' AND notes = 'Ejemplo de "China" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta noche cenamos en el chino. (presente)' AND notes = 'Ejemplo de "China" (inv.)' LIMIT 1),
    'nl_NL', 'Vanavond eten we bij de Chinees.', 'fanáafont éeten we bei de shinées');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'China, los chinos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Esta noche cenamos en el chino. (presente)' AND notes = 'Ejemplo de "China" (inv.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Los chinos celebran su año nuevo en enero o febrero.', 'SENTENCE', 'Ejemplo de "China" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los chinos celebran su año nuevo en enero o febrero.' AND notes = 'Ejemplo de "China" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Los chinos celebran su año nuevo en enero o febrero.' AND notes = 'Ejemplo de "China" (can.)' LIMIT 1),
    'nl_NL', 'Chinezen vieren hun nieuwjaar in januari of februari.', 'shinéesen fíiren hun níiwyaar in yánuwari of fébruwari');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'China, los chinos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Los chinos celebran su año nuevo en enero o febrero.' AND notes = 'Ejemplo de "China" (can.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mi hijo se ha hecho amigo de un japonés.', 'SENTENCE', 'Ejemplo de "Japan" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi hijo se ha hecho amigo de un japonés.' AND notes = 'Ejemplo de "Japan" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi hijo se ha hecho amigo de un japonés.' AND notes = 'Ejemplo de "Japan" (perf.)' LIMIT 1),
    'nl_NL', 'Mijn zoon is bevriend geraakt met een Japanner.', 'méin soon is befríint jeráakt met en yapáner');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Japón, un japonés' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi hijo se ha hecho amigo de un japonés.' AND notes = 'Ejemplo de "Japan" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'No sabía que tu mujer era india.', 'SENTENCE', 'Ejemplo de "India" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No sabía que tu mujer era india.' AND notes = 'Ejemplo de "India" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No sabía que tu mujer era india.' AND notes = 'Ejemplo de "India" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik wist niet dat jouw vrouw Indiaas was.', 'ik wist niit dat yáu fráu indiáas was');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'India, una india' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No sabía que tu mujer era india.' AND notes = 'Ejemplo de "India" (bijzin)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mis abuelos vinieron de Indonesia en los años cincuenta.', 'SENTENCE', 'Ejemplo de "Indonesië" (imperf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mis abuelos vinieron de Indonesia en los años cincuenta.' AND notes = 'Ejemplo de "Indonesië" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mis abuelos vinieron de Indonesia en los años cincuenta.' AND notes = 'Ejemplo de "Indonesië" (imperf.)' LIMIT 1),
    'nl_NL', 'Mijn grootouders kwamen in de jaren vijftig uit Indonesië.', 'méin jróotauders kwáamen in de yáaren féiftej áut indonéesi-e');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Indonesia, las indonesias' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mis abuelos vinieron de Indonesia en los años cincuenta.' AND notes = 'Ejemplo de "Indonesië" (imperf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Los paquistaníes del barrio han abierto una tienda.', 'SENTENCE', 'Ejemplo de "Pakistan" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los paquistaníes del barrio han abierto una tienda.' AND notes = 'Ejemplo de "Pakistan" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Los paquistaníes del barrio han abierto una tienda.' AND notes = 'Ejemplo de "Pakistan" (perf.)' LIMIT 1),
    'nl_NL', 'De Pakistanen uit de buurt hebben een winkel geopend.', 'de pakistáanen áut de buurt hében en wínkel jeóopent');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Pakistán, los paquistaníes' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Los paquistaníes del barrio han abierto una tienda.' AND notes = 'Ejemplo de "Pakistan" (perf.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Nos mudaremos a Australia cuando nos jubilemos.', 'SENTENCE', 'Ejemplo de "Australië" (fut.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Nos mudaremos a Australia cuando nos jubilemos.' AND notes = 'Ejemplo de "Australië" (fut.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Nos mudaremos a Australia cuando nos jubilemos.' AND notes = 'Ejemplo de "Australië" (fut.)' LIMIT 1),
    'nl_NL', 'We verhuizen naar Australië als we met pensioen gaan.', 'we ferháusen naar austráali-e als we met penshún jaan');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Australia, un australiano' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Nos mudaremos a Australia cuando nos jubilemos.' AND notes = 'Ejemplo de "Australië" (fut.)' LIMIT 1),
        'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Ya te sientes en casa en Australia?', 'SENTENCE', 'Ejemplo de "Australië" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Ya te sientes en casa en Australia?' AND notes = 'Ejemplo de "Australië" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Ya te sientes en casa en Australia?' AND notes = 'Ejemplo de "Australië" (vraag)' LIMIT 1),
    'nl_NL', 'Voel je je al thuis in Australië?', 'ful ye ye al taus in austráali-e');

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'Australia, un australiano' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿Ya te sientes en casa en Australia?' AND notes = 'Ejemplo de "Australië" (vraag)' LIMIT 1),
        'EXAMPLE');

-- grupos: el nuevo y generic, para las tarjetas de pais, sus frases y 965/1092
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT e.id, g.id FROM words_es e, word_groups g
WHERE g.title IN ('los paises - landen en nationaliteiten', 'generic')
  AND (e.notes LIKE 'Paises: %'
       OR e.id IN (SELECT r.word_es_id_b FROM word_es_relations r
                   JOIN words_es p ON p.id = r.word_es_id_a
                   WHERE p.notes LIKE 'Paises: %' AND r.relation_type = 'EXAMPLE')
       OR e.text IN ('soy de España', '¿de qué país eres?'));
