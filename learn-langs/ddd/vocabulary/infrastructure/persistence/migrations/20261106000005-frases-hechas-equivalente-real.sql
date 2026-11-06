-- Learn Languages App - Migration
-- Migration: 20261106000005-frases-hechas-equivalente-real
-- Description: Eduardo (2026-11-06): «esa correccion es muy valida, repasa el resto de expresiones y siempre pon
--   su equivalente no su traduccion mas cercana».
--
--   Repaso de las 99 restantes con ese criterio (lo que diría un neerlandés, no el calco ni la descripción).
--   Cambian cuatro, PHRASE + su SENTENCE, con ayuda nueva hasta el 📚 compartido (que se conserva por su ancla):
--   met je gedachten ergens anders zijn -> er met je hoofd niet bij zijn
--   zo rood als een tomaat worden -> een kop als een boei krijgen
--   goed van pas komen -> als geroepen komen
--   als een boemerang terugkomen -> zichzelf in de vingers snijden
--   La forma vieja queda en la ayuda como alternativa (🔁), y en las nubes lleva el ⚠️ de in de wolken zijn.
--   Fichas §2 de krijgen y snijden, que entran en la respuesta. Los mp3 nl viejos se retiran a mano.

-- met je gedachten ergens anders zijn -> er met je hoofd niet bij zijn
UPDATE words_lang SET text = 'Elke keer als ik tegen haar praat, is ze er met haar hoofd niet bij.', pronunciation = 'elke keer als ik téjen haar praat, is se er met haar hoft nit bei', notes = '• [imperf.] Sorry, ik was er even met mijn hoofd niet bij. — Perdona, estaba en las nubes.
• [can.] Hij is er vandaag met zijn hoofd niet bij. — Hoy está en las nubes.
• [bijzin] Ik merk dat je er met je hoofd niet bij bent. — Noto que estás en las nubes.
• [vraag] Ben je er wel met je hoofd bij? — ¿Te estás enterando?
• [geb.] Blijf er met je hoofd bij! — ¡No te despistes!', audio_path = NULL
 WHERE lang_code = 'nl_NL' AND word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: met je gedachten ergens anders zijn' AND word_type = 'PHRASE' LIMIT 1);
UPDATE words_lang SET text = 'Sorry, ik was er even met mijn hoofd niet bij.', pronunciation = 'sóri, ik uas er éfen met mein hoft nit bei', audio_path = NULL
 WHERE lang_code = 'nl_NL' AND word_es_id = (SELECT id FROM words_es WHERE notes = 'Ejemplo de "met je gedachten ergens anders zijn" (can.)' AND word_type = 'SENTENCE' LIMIT 1);
DELETE FROM word_es_media WHERE lang_code = 'nl_NL' AND word_es_id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: met je gedachten ergens anders zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM words_es WHERE notes = 'Ejemplo de "met je gedachten ergens anders zijn" (can.)' AND word_type = 'SENTENCE' LIMIT 1));
UPDATE words_es SET rules_help = 'ER MET JE HOOFD NIET BIJ ZIJN = estar en las nubes, no prestar atención porque piensas en otra cosa.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar en las nubes = er met je hoofd niet bij zijn.
• en esta tarjeta — je pasa a haar, porque es ella; tras elke keer als … invierte, is ze; y er … bij abrazan el resto, is ze ER met haar hoofd niet BIJ.

📖 Palabra a palabra:

• het hoofd — la cabeza, la palabra neutra; de kop es la coloquial o la de un animal.
• er … bij — ahí, en lo que está pasando. bij es junto a, y er señala la cosa, la clase o la conversación. erbij zijn es estar presente, estar en ello.

🧩 Expresión fija — er met je hoofd niet bij zijn:

• literal — no estar con la cabeza ahí.
• significa — estar distraído, con la mente en otra parte.
• piezas fijas — er … bij se separan y abrazan el resto; je cambia por el posesivo del sujeto, met mijn, zijn o haar hoofd.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pasado | Sorry, ik was er even met mijn hoofd niet bij. | Perdona, estaba en las nubes. |
| 2 | principal | Hij is er vandaag met zijn hoofd niet bij. | Hoy está en las nubes. |
| 3 | subordinada | Ik merk dat je er met je hoofd niet bij bent. | Noto que estás en las nubes. |
| 4 | imperativo | Blijf er met je hoofd bij! | ¡No te despistes! |

🎯 En qué contexto se usa:

• clase, reuniones o conversaciones en las que alguien no se entera
• disculparse, Sorry, ik was er even niet bij
• muy coloquial, de todas las edades

🔁 Alternativas que también oirás:

• met je gedachten ergens anders zijn — con los pensamientos en otra parte. Correcta y se entiende, pero describe, no es el modismo.
• zitten te dromen — estar soñando despierto, Zit je te dromen? (¿estás en las nubes?).

⚠️ in de wolken zijn NO es estar en las nubes: es estar contentísimo. Ze is in de wolken met haar nieuwe baan, está feliz con su trabajo nuevo.

🔑 El truco que casi nunca falla: En neerlandés no se está en las nubes, la cabeza no está donde toca, er met je hoofd niet bij.' || substr(rules_help, instr(rules_help, '

📚 Uitdrukking o spreekwoord')),
       notes = 'frases hechas: er met je hoofd niet bij zijn', updated_at = datetime('now')
 WHERE notes = 'frases hechas: met je gedachten ergens anders zijn' AND word_type = 'PHRASE' AND instr(rules_help, '

📚 Uitdrukking o spreekwoord') > 0;
UPDATE words_es SET rules_help = 'ER MET JE HOOFD NIET BIJ ZIJN = estar en las nubes, no prestar atención porque piensas en otra cosa.

📖 Palabra a palabra:

• het hoofd — la cabeza, la palabra neutra; de kop es la coloquial o la de un animal.
• er … bij — ahí, en lo que está pasando. bij es junto a, y er señala la cosa, la clase o la conversación. erbij zijn es estar presente, estar en ello.

🧩 Expresión fija — er met je hoofd niet bij zijn:

• literal — no estar con la cabeza ahí.
• significa — estar distraído, con la mente en otra parte.
• piezas fijas — er … bij se separan y abrazan el resto; je cambia por el posesivo del sujeto, met mijn, zijn o haar hoofd.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pasado | Sorry, ik was er even met mijn hoofd niet bij. | Perdona, estaba en las nubes. |
| 2 | principal | Hij is er vandaag met zijn hoofd niet bij. | Hoy está en las nubes. |
| 3 | subordinada | Ik merk dat je er met je hoofd niet bij bent. | Noto que estás en las nubes. |
| 4 | imperativo | Blijf er met je hoofd bij! | ¡No te despistes! |

🎯 En qué contexto se usa:

• clase, reuniones o conversaciones en las que alguien no se entera
• disculparse, Sorry, ik was er even niet bij
• muy coloquial, de todas las edades

🔁 Alternativas que también oirás:

• met je gedachten ergens anders zijn — con los pensamientos en otra parte. Correcta y se entiende, pero describe, no es el modismo.
• zitten te dromen — estar soñando despierto, Zit je te dromen? (¿estás en las nubes?).

⚠️ in de wolken zijn NO es estar en las nubes: es estar contentísimo. Ze is in de wolken met haar nieuwe baan, está feliz con su trabajo nuevo.

🔑 El truco que casi nunca falla: En neerlandés no se está en las nubes, la cabeza no está donde toca, er met je hoofd niet bij.' || substr(rules_help, instr(rules_help, '

📚 Uitdrukking o spreekwoord')),
       notes = 'Ejemplo de "er met je hoofd niet bij zijn" (imperf.)', updated_at = datetime('now')
 WHERE notes = 'Ejemplo de "met je gedachten ergens anders zijn" (can.)' AND word_type = 'SENTENCE' AND instr(rules_help, '

📚 Uitdrukking o spreekwoord') > 0;

-- zo rood als een tomaat worden -> een kop als een boei krijgen
UPDATE words_lang SET text = 'Toen hij haar zag, kreeg hij een kop als een boei.', pronunciation = 'tun hei haar saj, kreej hei en kop als en búi', notes = '• [imperf.] Ik kreeg een kop als een boei. — Me puse rojo como un tomate.
• [perf.] Ze heeft een kop als een boei gekregen. — Se ha puesto roja como un tomate.
• [can.] Hij krijgt altijd een kop als een boei. — Siempre se pone rojo como un tomate.
• [bijzin] Ik zag dat hij een kop als een boei kreeg. — Vi que se ponía rojo como un tomate.
• [uitdr.] met een kop als een boei — rojo como un tomate.', audio_path = NULL
 WHERE lang_code = 'nl_NL' AND word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: zo rood als een tomaat worden' AND word_type = 'PHRASE' LIMIT 1);
UPDATE words_lang SET text = 'Ik kreeg een kop als een boei.', pronunciation = 'ik kreej en kop als en búi', audio_path = NULL
 WHERE lang_code = 'nl_NL' AND word_es_id = (SELECT id FROM words_es WHERE notes = 'Ejemplo de "zo rood als een tomaat worden" (imperf.)' AND word_type = 'SENTENCE' LIMIT 1);
DELETE FROM word_es_media WHERE lang_code = 'nl_NL' AND word_es_id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: zo rood als een tomaat worden' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM words_es WHERE notes = 'Ejemplo de "zo rood als een tomaat worden" (imperf.)' AND word_type = 'SENTENCE' LIMIT 1));
UPDATE words_es SET rules_help = 'EEN KOP ALS EEN BOEI KRIJGEN = ponerse rojo como un tomate, de vergüenza, de esfuerzo o de rabia.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ponerse rojo como un tomate = een kop als een boei krijgen.
• en esta tarjeta — tras toen hij haar zag invierte, kreeg hij; krijgen va en imperfecto, kreeg.

📖 Palabra a palabra:

• de kop — la cabeza en registro coloquial; en la expresión es la cara. La neutra es het hoofd, y la cara es het gezicht.
• de boei — la boya, las de señalización del mar, que son rojas. Fuera de la expresión casi solo la oirás en barcos y playas.
• krijgen — recibir, conseguir; aquí es ponerse, een rode kop krijgen. Ficha completa debajo.

📐 Conjugacion de krijgen (fuerte · simple):

| persona | presente | imperfecto |
|---|---|---|
| ik | krijg | kreeg |
| jij / je | krijgt | kreeg |
| u | krijgt | kreeg |
| hij / zij / het | krijgt | kreeg |
| wij | krijgen | kregen |
| jullie | krijgen | kregen |
| zij (plural) | krijgen | kregen |

• participio — gekregen, con hebben: Ik heb een cadeau gekregen.
• al invertir, jij pierde la -t: Krijg je het? — no «krijgt je».
• preposicion — ninguna fija, iets krijgen; de quién, van: Ik kreeg het van mijn moeder.
• antonimo — geven, dar.
• sustantivo — no tiene uno propio de uso diario.
• separable — no, es un verbo simple.

🧩 Expresión fija — een kop als een boei krijgen:

• literal — recibir una cabeza como una boya.
• significa — ponerse muy rojo de cara.
• piezas fijas — een kop als een boei; con krijgen es ponerse, con hebben es estar, Hij had een kop als een boei.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pasado | Ik kreeg een kop als een boei. | Me puse rojo como un tomate. |
| 2 | perfecto | Ze heeft een kop als een boei gekregen. | Se ha puesto roja como un tomate. |
| 3 | principal | Hij krijgt altijd een kop als een boei. | Siempre se pone rojo como un tomate. |
| 4 | estado | Hij had een kop als een boei. | Estaba rojo como un tomate. |

🎯 En qué contexto se usa:

• vergüenza, cuando te pillan o te echan un piropo
• esfuerzo, tras correr o subir escaleras
• rabia, alguien que se enciende
• coloquial, de todas las edades

🔁 Alternativas que también oirás:

• zo rood als een tomaat — se entiende y se oye, pero es la imagen española; la holandesa es la boya.
• een rode kop krijgen — más neutro, sin comparación.
• blozen — ruborizarse, solo de vergüenza: Ze bloosde.

🔑 El truco que casi nunca falla: En Holanda el rojo de referencia está en el mar, la boya.' || substr(rules_help, instr(rules_help, '

📚 Uitdrukking o spreekwoord')),
       notes = 'frases hechas: een kop als een boei krijgen', updated_at = datetime('now')
 WHERE notes = 'frases hechas: zo rood als een tomaat worden' AND word_type = 'PHRASE' AND instr(rules_help, '

📚 Uitdrukking o spreekwoord') > 0;
UPDATE words_es SET rules_help = 'EEN KOP ALS EEN BOEI KRIJGEN = ponerse rojo como un tomate, de vergüenza, de esfuerzo o de rabia.

📖 Palabra a palabra:

• de kop — la cabeza en registro coloquial; en la expresión es la cara. La neutra es het hoofd, y la cara es het gezicht.
• de boei — la boya, las de señalización del mar, que son rojas. Fuera de la expresión casi solo la oirás en barcos y playas.
• krijgen — recibir, conseguir; aquí es ponerse, een rode kop krijgen. Ficha completa debajo.

📐 Conjugacion de krijgen (fuerte · simple):

| persona | presente | imperfecto |
|---|---|---|
| ik | krijg | kreeg |
| jij / je | krijgt | kreeg |
| u | krijgt | kreeg |
| hij / zij / het | krijgt | kreeg |
| wij | krijgen | kregen |
| jullie | krijgen | kregen |
| zij (plural) | krijgen | kregen |

• participio — gekregen, con hebben: Ik heb een cadeau gekregen.
• al invertir, jij pierde la -t: Krijg je het? — no «krijgt je».
• preposicion — ninguna fija, iets krijgen; de quién, van: Ik kreeg het van mijn moeder.
• antonimo — geven, dar.
• sustantivo — no tiene uno propio de uso diario.
• separable — no, es un verbo simple.

🧩 Expresión fija — een kop als een boei krijgen:

• literal — recibir una cabeza como una boya.
• significa — ponerse muy rojo de cara.
• piezas fijas — een kop als een boei; con krijgen es ponerse, con hebben es estar, Hij had een kop als een boei.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pasado | Ik kreeg een kop als een boei. | Me puse rojo como un tomate. |
| 2 | perfecto | Ze heeft een kop als een boei gekregen. | Se ha puesto roja como un tomate. |
| 3 | principal | Hij krijgt altijd een kop als een boei. | Siempre se pone rojo como un tomate. |
| 4 | estado | Hij had een kop als een boei. | Estaba rojo como un tomate. |

🎯 En qué contexto se usa:

• vergüenza, cuando te pillan o te echan un piropo
• esfuerzo, tras correr o subir escaleras
• rabia, alguien que se enciende
• coloquial, de todas las edades

🔁 Alternativas que también oirás:

• zo rood als een tomaat — se entiende y se oye, pero es la imagen española; la holandesa es la boya.
• een rode kop krijgen — más neutro, sin comparación.
• blozen — ruborizarse, solo de vergüenza: Ze bloosde.

🔑 El truco que casi nunca falla: En Holanda el rojo de referencia está en el mar, la boya.' || substr(rules_help, instr(rules_help, '

📚 Uitdrukking o spreekwoord')),
       notes = 'Ejemplo de "een kop als een boei krijgen" (imperf.)', updated_at = datetime('now')
 WHERE notes = 'Ejemplo de "zo rood als een tomaat worden" (imperf.)' AND word_type = 'SENTENCE' AND instr(rules_help, '

📚 Uitdrukking o spreekwoord') > 0;

-- goed van pas komen -> als geroepen komen
UPDATE words_lang SET text = 'Jouw telefoontje komt als geroepen.', pronunciation = 'iau telefóontie komt als jerúpen', notes = '• [can.] Dat geld komt als geroepen. — Ese dinero me viene como anillo al dedo.
• [imperf.] Jouw hulp kwam als geroepen. — Tu ayuda vino como anillo al dedo.
• [perf.] Die vakantie is als geroepen gekomen. — Esas vacaciones han venido como anillo al dedo.
• [bijzin] Ik zei dat zijn aanbod als geroepen kwam. — Dije que su oferta venía como anillo al dedo.
• [uitdr.] Je komt als geroepen! — ¡Llegas en el momento justo!', audio_path = NULL
 WHERE lang_code = 'nl_NL' AND word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: goed van pas komen' AND word_type = 'PHRASE' LIMIT 1);
UPDATE words_lang SET text = 'Dat geld komt als geroepen.', pronunciation = 'dat jelt komt als jerúpen', audio_path = NULL
 WHERE lang_code = 'nl_NL' AND word_es_id = (SELECT id FROM words_es WHERE notes = 'Ejemplo de "goed van pas komen" (can.)' AND word_type = 'SENTENCE' LIMIT 1);
DELETE FROM word_es_media WHERE lang_code = 'nl_NL' AND word_es_id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: goed van pas komen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM words_es WHERE notes = 'Ejemplo de "goed van pas komen" (can.)' AND word_type = 'SENTENCE' LIMIT 1));
UPDATE words_es SET rules_help = 'ALS GEROEPEN KOMEN = venir como anillo al dedo, llegar justo cuando hacía falta.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — venir como anillo al dedo = als geroepen komen.
• en esta tarjeta — el sujeto es lo que llega, jouw telefoontje, y no lleva me: el «me viene» español queda implícito.

📖 Palabra a palabra:

• geroepen — llamado, participio de roepen (llamar, gritar). Literal, «como llamado».
• komen — venir.
• het telefoontje — la llamada, el diminutivo de de telefoon, que es como se dice en la calle.

🧩 Expresión fija — als geroepen komen:

• literal — venir como si lo hubieran llamado.
• significa — algo o alguien llega justo en el momento en que hacía falta.
• piezas fijas — als geroepen no cambia nunca; komen va con zijn, is als geroepen gekomen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dat geld komt als geroepen. | Ese dinero me viene como anillo al dedo. |
| 2 | pasado | Jouw hulp kwam als geroepen. | Tu ayuda vino como anillo al dedo. |
| 3 | perfecto | Die vakantie is als geroepen gekomen. | Esas vacaciones han venido como anillo al dedo. |
| 4 | exclamación | Je komt als geroepen! | ¡Llegas en el momento justo! |

🎯 En qué contexto se usa:

• alguien que aparece justo cuando lo necesitas, Je komt als geroepen!
• dinero, ayuda u ofertas que llegan en buen momento
• coloquial y neutro, vale en casa y en el trabajo

🔁 Alternativas que también oirás:

• goed van pas komen — venir bien, ser útil; más neutro y sin la idea del momento justo, Een extra jas komt altijd goed van pas (una chaqueta de más siempre viene bien).

🔑 El truco que casi nunca falla: Si en español cabe «justo a tiempo», es als geroepen; si solo es «viene bien», goed van pas.' || substr(rules_help, instr(rules_help, '

📚 Uitdrukking o spreekwoord')),
       notes = 'frases hechas: als geroepen komen', updated_at = datetime('now')
 WHERE notes = 'frases hechas: goed van pas komen' AND word_type = 'PHRASE' AND instr(rules_help, '

📚 Uitdrukking o spreekwoord') > 0;
UPDATE words_es SET rules_help = 'ALS GEROEPEN KOMEN = venir como anillo al dedo, llegar justo cuando hacía falta.

📖 Palabra a palabra:

• geroepen — llamado, participio de roepen (llamar, gritar). Literal, «como llamado».
• komen — venir.
• het telefoontje — la llamada, el diminutivo de de telefoon, que es como se dice en la calle.

🧩 Expresión fija — als geroepen komen:

• literal — venir como si lo hubieran llamado.
• significa — algo o alguien llega justo en el momento en que hacía falta.
• piezas fijas — als geroepen no cambia nunca; komen va con zijn, is als geroepen gekomen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dat geld komt als geroepen. | Ese dinero me viene como anillo al dedo. |
| 2 | pasado | Jouw hulp kwam als geroepen. | Tu ayuda vino como anillo al dedo. |
| 3 | perfecto | Die vakantie is als geroepen gekomen. | Esas vacaciones han venido como anillo al dedo. |
| 4 | exclamación | Je komt als geroepen! | ¡Llegas en el momento justo! |

🎯 En qué contexto se usa:

• alguien que aparece justo cuando lo necesitas, Je komt als geroepen!
• dinero, ayuda u ofertas que llegan en buen momento
• coloquial y neutro, vale en casa y en el trabajo

🔁 Alternativas que también oirás:

• goed van pas komen — venir bien, ser útil; más neutro y sin la idea del momento justo, Een extra jas komt altijd goed van pas (una chaqueta de más siempre viene bien).

🔑 El truco que casi nunca falla: Si en español cabe «justo a tiempo», es als geroepen; si solo es «viene bien», goed van pas.' || substr(rules_help, instr(rules_help, '

📚 Uitdrukking o spreekwoord')),
       notes = 'Ejemplo de "als geroepen komen" (can.)', updated_at = datetime('now')
 WHERE notes = 'Ejemplo de "goed van pas komen" (can.)' AND word_type = 'SENTENCE' AND instr(rules_help, '

📚 Uitdrukking o spreekwoord') > 0;

-- als een boemerang terugkomen -> zichzelf in de vingers snijden
UPDATE words_lang SET text = 'Hij wilde slim doen, maar hij sneed zichzelf in de vingers.', pronunciation = 'hei uílde slim dun, maar hei sneet sijsélf in de fíngers', notes = '• [perf.] Met die grap heeft hij zichzelf in de vingers gesneden. — Con la broma le ha salido el tiro por la culata.
• [can.] Daarmee snijd je jezelf in de vingers. — Con eso te va a salir el tiro por la culata.
• [imperf.] Ze sneed zichzelf flink in de vingers. — Le salió el tiro por la culata, y bien.
• [bijzin] Pas op dat je jezelf niet in de vingers snijdt. — Cuidado, que no te salga el tiro por la culata.
• [inv.] Met die leugen snijdt hij zichzelf in de vingers. — Con esa mentira le sale el tiro por la culata.', audio_path = NULL
 WHERE lang_code = 'nl_NL' AND word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: als een boemerang terugkomen' AND word_type = 'PHRASE' LIMIT 1);
UPDATE words_lang SET text = 'Met die grap heeft hij zichzelf in de vingers gesneden.', pronunciation = 'met di jrap heeft hei sijsélf in de fíngers jesnéden', audio_path = NULL
 WHERE lang_code = 'nl_NL' AND word_es_id = (SELECT id FROM words_es WHERE notes = 'Ejemplo de "als een boemerang terugkomen" (perf.)' AND word_type = 'SENTENCE' LIMIT 1);
DELETE FROM word_es_media WHERE lang_code = 'nl_NL' AND word_es_id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: als een boemerang terugkomen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM words_es WHERE notes = 'Ejemplo de "als een boemerang terugkomen" (perf.)' AND word_type = 'SENTENCE' LIMIT 1));
UPDATE words_es SET rules_help = 'ZICHZELF IN DE VINGERS SNIJDEN = salir el tiro por la culata, perjudicarte con tu propio plan.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — salir el tiro por la culata = zichzelf in de vingers snijden.
• en esta tarjeta — el sujeto es la persona, no el plan, hij sneed zichzelf; zichzelf cambia con el sujeto, ik mezelf, jij jezelf, hij zichzelf.

📖 Palabra a palabra:

• zichzelf — a sí mismo; aquí no basta zich, va la forma enfática.
• de vinger — el dedo de la mano, plural vingers; el del pie es de teen.
• snijden — cortar. Ficha completa debajo.

📐 Conjugacion de snijden (fuerte · simple):

| persona | presente | imperfecto |
|---|---|---|
| ik | snijd | sneed |
| jij / je | snijdt | sneed |
| u | snijdt | sneed |
| hij / zij / het | snijdt | sneed |
| wij | snijden | sneden |
| jullie | snijden | sneden |
| zij (plural) | snijden | sneden |

• participio — gesneden, con hebben: Ik heb het brood gesneden.
• al invertir, jij pierde la -t: Snijd je het brood? — no «snijdt je».
• preposicion — in, cortar en trozos, iets in stukjes snijden.
• antonimo — no tiene uno claro.
• sustantivo — de snee, el corte: een snee in je vinger.
• separable — no, es un verbo simple.

🧩 Expresión fija — zichzelf in de vingers snijden:

• literal — cortarse uno mismo en los dedos.
• significa — un plan, una mentira o una broma se vuelve contra quien la hizo.
• piezas fijas — in de vingers, siempre en plural; zichzelf se adapta al sujeto; snijden es fuerte, sneed, gesneden.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Met die grap heeft hij zichzelf in de vingers gesneden. | Con la broma le ha salido el tiro por la culata. |
| 2 | principal | Daarmee snijd je jezelf in de vingers. | Con eso te va a salir el tiro por la culata. |
| 3 | subordinada | Pas op dat je jezelf niet in de vingers snijdt. | Cuidado, que no te salga el tiro por la culata. |

🎯 En qué contexto se usa:

• planes, mentiras o bromas que se vuelven contra su autor
• trabajo y política, decisiones que salen caras a quien las toma
• coloquial y neutro

🔁 Alternativas que también oirás:

• als een boemerang terugkomen — volver como un bumerán. Existe, pero el sujeto es lo que hiciste, no tú, y suena a prensa: De maatregel kwam als een boemerang terug.
• het pakte verkeerd uit — salió mal, sin más.

🔑 El truco que casi nunca falla: En español el tiro sale por la culata; en neerlandés te cortas los dedos con tu propio cuchillo.' || substr(rules_help, instr(rules_help, '

📚 Uitdrukking o spreekwoord')),
       notes = 'frases hechas: zichzelf in de vingers snijden', updated_at = datetime('now')
 WHERE notes = 'frases hechas: als een boemerang terugkomen' AND word_type = 'PHRASE' AND instr(rules_help, '

📚 Uitdrukking o spreekwoord') > 0;
UPDATE words_es SET rules_help = 'ZICHZELF IN DE VINGERS SNIJDEN = salir el tiro por la culata, perjudicarte con tu propio plan.

📖 Palabra a palabra:

• zichzelf — a sí mismo; aquí no basta zich, va la forma enfática.
• de vinger — el dedo de la mano, plural vingers; el del pie es de teen.
• snijden — cortar. Ficha completa debajo.

📐 Conjugacion de snijden (fuerte · simple):

| persona | presente | imperfecto |
|---|---|---|
| ik | snijd | sneed |
| jij / je | snijdt | sneed |
| u | snijdt | sneed |
| hij / zij / het | snijdt | sneed |
| wij | snijden | sneden |
| jullie | snijden | sneden |
| zij (plural) | snijden | sneden |

• participio — gesneden, con hebben: Ik heb het brood gesneden.
• al invertir, jij pierde la -t: Snijd je het brood? — no «snijdt je».
• preposicion — in, cortar en trozos, iets in stukjes snijden.
• antonimo — no tiene uno claro.
• sustantivo — de snee, el corte: een snee in je vinger.
• separable — no, es un verbo simple.

🧩 Expresión fija — zichzelf in de vingers snijden:

• literal — cortarse uno mismo en los dedos.
• significa — un plan, una mentira o una broma se vuelve contra quien la hizo.
• piezas fijas — in de vingers, siempre en plural; zichzelf se adapta al sujeto; snijden es fuerte, sneed, gesneden.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Met die grap heeft hij zichzelf in de vingers gesneden. | Con la broma le ha salido el tiro por la culata. |
| 2 | principal | Daarmee snijd je jezelf in de vingers. | Con eso te va a salir el tiro por la culata. |
| 3 | subordinada | Pas op dat je jezelf niet in de vingers snijdt. | Cuidado, que no te salga el tiro por la culata. |

🎯 En qué contexto se usa:

• planes, mentiras o bromas que se vuelven contra su autor
• trabajo y política, decisiones que salen caras a quien las toma
• coloquial y neutro

🔁 Alternativas que también oirás:

• als een boemerang terugkomen — volver como un bumerán. Existe, pero el sujeto es lo que hiciste, no tú, y suena a prensa: De maatregel kwam als een boemerang terug.
• het pakte verkeerd uit — salió mal, sin más.

🔑 El truco que casi nunca falla: En español el tiro sale por la culata; en neerlandés te cortas los dedos con tu propio cuchillo.' || substr(rules_help, instr(rules_help, '

📚 Uitdrukking o spreekwoord')),
       notes = 'Ejemplo de "zichzelf in de vingers snijden" (perf.)', updated_at = datetime('now')
 WHERE notes = 'Ejemplo de "als een boemerang terugkomen" (perf.)' AND word_type = 'SENTENCE' AND instr(rules_help, '

📚 Uitdrukking o spreekwoord') > 0;

