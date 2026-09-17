-- Learn Languages App - Migration
-- Migration: 20260912000003-grupo-numeros
-- Description: Eduardo: "crea un grupo con numeros del 1 al 20 y numeros random de 2, 3, 4, 5, 6,
--   7 cifras (en texto) de dificil pronunciacion unos 3 de cada". Listado enumerado presentado y
--   aprobado antes de escribir la migracion.
--
--   El mazo no tenia NI UN numero suelto: solo el grupo 26 (la hora) usaba digitos dentro de sus
--   frases. Hueco completo.
--
--   Grupo 'los numeros - de getallen y como se leen' con 38 tarjetas WORD:
--     - 1-20, los cimientos, cada uno con su ordinal, su familia (-tien / -tig) y su trampa.
--     - 3 de dos cifras: 33 (trema), 88 (dos jotas guturales), 97 (doble n en la costura).
--     - 3 de tres cifras: 365, 748, 999 (el trabalenguas de los tres negen).
--     - 3 de cuatro: 3847, 4688, 7512 (donde se ve que del 11 al 19 NO se invierte).
--     - 3 de cinco: 12345, 67890, 85376 (el multiplicador de duizend tambien se invierte).
--     - 3 de seis: 123456, 749813 (la dd de achthonderddertien), 908077 (el cero mudo).
--     - 3 de siete: 1234567 (miljoen suelto, y el desfase miljard/billion), 3500000 (anderhalf),
--       8642913 (todas las reglas en una sola frase).
--
--   Decisiones acordadas con Eduardo antes de escribir:
--     - El texto ES va en CIFRA y sin puntos de millar (85376), para que el TTS del examen lo
--       locute en español ("ochenta y cinco mil trescientos setenta y seis") y se teclee el
--       neerlandes en letra. Con punto, algun TTS lo leeria como decimal.
--     - Todas WORD, y el grupo se llama 'los numeros - de getallen y como se leen'.
--
--   Bloque compartido '🔢 Como se construye cualquier numero' (§3.3): tabla de los siete tramos
--   (1-12, 13-19, decenas, 21-99, centenas, miles, millones), las cinco reglas (inversion
--   unidad-decena, todo junto hasta duizend y suelto desde miljoen, honderd/duizend sin een, sin
--   plural cuando cuentan, y cuando toca la trema), el truco de partir por la derecha en grupos de
--   tres, el aviso de que el punto y la coma van como en español y al reves que en ingles, como se
--   leen los años segun el siglo, y el vocabulario (het getal, het nummer, het cijfer, de helft).

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'los numeros - de getallen y como se leen',
       'Los numeros neerlandeses del 1 al 20 y dieciocho numeros largos de pronunciacion dificil, de dos a siete cifras. La regla que lo gobierna todo es que la UNIDAD va delante de la decena con en en medio (21 = eenentwintig, uno-y-veinte), y que se escribe TODO junto hasta duizend: por debajo de mil no hay espacios por larga que quede la palabra (negenhonderdnegenennegentig), duizend se pega a su multiplicador y se separa del resto (drieduizend achthonderdzevenenveertig), y miljoen va suelto con espacios a los dos lados (acht miljoen). Incluye los irregulares (dertien, veertien y achttien; dertig, veertig y tachtig), la trema de drie y twee al unirse con en (drieëndertig, tweeënveertig), la trampa de pronunciacion de zes y zeven (se escriben con z pero zestien, zestig, zeventien y zeventig suenan con s sorda), los ordinales (eerste, tweede, derde irregulares; -de hasta 19 y -ste desde 20), el cero mudo de los bloques (908077 = negenhonderdachtduizend zevenenzeventig), el punto y la coma que funcionan como en español y al reves que en ingles, los años segun el siglo (negentienvijfentachtig frente a tweeduizend zesentwintig), el desfase miljard/billion que arruina traducciones, y anderhalf para el 1,5. El metodo para leer cualquier cifra larga: partir por la derecha en grupos de tres y pegarle a cada bloque su multiplicador',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'los numeros - de getallen y como se leen');

-- =============================================================================
-- 2. Del 1 al 20
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '1', 'WORD', 'Numeros: 1',
'1 = een. Se dice con la e larga, een, y se escribe igual que el articulo indefinido een (un, una): el contexto los separa.

📐 Cuando hay riesgo de confusion, el numero se escribe con acentos: één. Ik heb één broer (tengo UN hermano, solo uno) frente a Ik heb een broer (tengo un hermano).

📐 El ordinal es eerste (primero), que es irregular y no sale de een: de eerste dag, de eerste keer.

📋 Donde lo oiras:
• Het is een uur. — Es la una.
• Nummer een, alstublieft. — El número uno, por favor.
• Ik kom over een uur. — Vengo dentro de una hora.

🔑 El truco de een: Si puedes sustituirlo por «uno solo» y sigue teniendo sentido, es numero y lleva acentos; si es «un» a secas, es articulo.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 1');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '2', 'WORD', 'Numeros: 2',
'2 = twee. La w neerlandesa es suave, entre v y u: tuee.

📐 El ordinal es tweede (segundo), con -de: de tweede verdieping (la segunda planta).

📋 Donde lo oiras:
• Twee koffie, alstublieft. — Dos cafés, por favor.
• Ik heb het twee keer gedaan. — Lo he hecho dos veces.
• De tweeling is geboren. — Han nacido los gemelos.

🧮 De la familia de twee: de tweeling (los gemelos), tweemaal (dos veces), het tweede (el segundo) y twintig, que es 20 y viene de dos decenas.

⚠️ Y ojo al contar cosas en una tienda: twee koffie va en singular, porque las unidades no se pluralizan detras de un numero — twee bier, drie kilo, vier jaar.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 2');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '3', 'WORD', 'Numeros: 3',
'3 = drie. La ie neerlandesa es una i larga: drii.

📐 El ordinal es derde (tercero), y es IRREGULAR: Pierde la i de drie. La trampa clasica es decir «driede», que no existe.

📋 Donde lo oiras:
• Driemaal is scheepsrecht. — A la tercera va la vencida.
• Ik heb drie kinderen. — Tengo tres hijos.
• Op de derde dinsdag van september… — El tercer martes de septiembre…

⚠️ drie es de los que piden TREMA al unirse con en: drieëntwintig (23), drieëndertig (33), drieënveertig (43). Sin la trema, la ee se leeria como una sola vocal larga.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 3');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '4', 'WORD', 'Numeros: 4',
'4 = vier. La v neerlandesa suena a f, asi que vier se dice fiir.

📐 El ordinal es vierde (cuarto): het vierde kwartaal (el cuarto trimestre).

📋 Donde lo oiras:
• Een kwart is een vierde. — Un cuarto es una cuarta parte.
• Ik werk vier dagen per week. — Trabajo cuatro días por semana.
• Om de vier jaar is het een schrikkeljaar. — Cada cuatro años es bisiesto.

⚠️ No lo confundas con el verbo vieren (celebrar) ni con vuur (fuego), que suena feur. Y la decena, veertig (40), lleva DOBLE e aunque vier solo tenga una: veertien y veertig son las dos excepciones.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 4');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '5', 'WORD', 'Numeros: 5',
'5 = vijf. El diptongo ij suena ai, y la v suena f: faif.

📐 El ordinal es vijfde (quinto): de vijfde mei, el dia de la Liberacion.

📋 Donde lo oiras:
• Vijf euro, alstublieft. — Cinco euros, por favor.
• Het is vijf over half tien. — Son las nueve y treinta y cinco.
• Ik ben er over vijf minuten. — Llego en cinco minutos.

🧮 La familia de vijf: vijftien (15), vijftig (50), het vijfje (el billete de cinco) y de vijfde (el quinto).

⚠️ Fijate en que vijftien y vijftig pierden la v sonora y suenan con f clara: fáiftiin, fáiftej.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 5');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '6', 'WORD', 'Numeros: 6',
'6 = zes. La z inicial es sonora, como el zumbido de un mosquito: zes, nunca ses.

📐 El ordinal es zesde (sexto): de zesde verdieping.

⚠️ Pero atencion a la trampa de pronunciacion: zestien (16) y zestig (60) SI empiezan con s sorda en el neerlandes estandar — se dicen séstiin y séstej, aunque se escriban con z. Lo mismo le pasa a zeventien y zeventig.

📋 Donde lo oiras:
• Zes uur. — Las seis.
• Een half dozijn is zes. — Media docena son seis.
• Ik heb er nog zes. — Me quedan seis.

🧮 De la familia: zestien (16), zestig (60), het zesje (un seis raspado, la nota mas holandesa que existe — de zesjescultuur es conformarse con aprobar).

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 6');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '7', 'WORD', 'Numeros: 7',
'7 = zeven. Con z sonora y acento en la primera silaba: ZÉE-ven.

📐 El ordinal es zevende (septimo): de zevende dag.

⚠️ La trampa de siempre: zeventien (17) y zeventig (70) se pronuncian con S SORDA, séeventiin y séeventej, aunque se escriban con z. Es un rasgo del estandar del norte que delata al extranjero.

📋 Donde lo oiras:
• Ik sta om zeven uur op. — Me levanto a las siete.
• De week heeft zeven dagen. — La semana tiene siete días.
• In de zevende hemel zijn. — Estar en el séptimo cielo.

🧮 La familia: zeventien (17), zeventig (70), de zevende (el septimo).

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 7');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '8', 'WORD', 'Numeros: 8',
'8 = acht. La ch es la jota fuerte holandesa, la misma de goed y dag: ajt.

📐 El ordinal es achtste (octavo), y es de los pocos que lleva -ste en vez de -de, porque la raiz ya acaba en t.

📋 Donde lo oiras:
• Om acht uur eten we. — A las ocho comemos.
• Ik heb acht uur geslapen. — He dormido ocho horas.
• De bus van acht over half negen. — El autobús de las ocho treinta y ocho.

⚠️ No lo confundas con acht(en) en achter (detras) ni con echt (de verdad). Y achttien (18) lleva DOS t al escribirse (acht + tien) aunque solo se oiga una.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 8');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '9', 'WORD', 'Numeros: 9',
'9 = negen. Las dos g son jota suave aspirada: NÉE-jen.

📐 El ordinal es negende (noveno).

📋 Donde lo oiras:
• Het is negen uur. — Son las nueve.
• Negen van de tien keer. — Nueve de cada diez veces.
• Ik werk van negen tot vijf. — Trabajo de nueve a cinco.

🧮 La familia: negentien (19), negentig (90), de jaren negentig (los años noventa).

⚠️ Y el trabalenguas que sale de aqui: 999 es negenhonderdnegenennegentig, con tres negen seguidos. Si lo dices sin trabarte, la g ya la tienes.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 9');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '10', 'WORD', 'Numeros: 10',
'10 = tien. Es la pieza que forma del 13 al 19: der-tien, veer-tien, vijf-tien.

📐 El ordinal es tiende (decimo): de tiende keer.

📋 Donde lo oiras:
• Ik heb om tien uur een afspraak. — Tengo cita a las diez.
• Reken op acht tot tien weken. — Cuente con ocho a diez semanas.
• Een tientje, alstublieft. — Un billete de diez, por favor.

🧮 het tientje es el billete de 10 euros, y de tien es el diez de la nota escolar: la maxima, que en Holanda casi no se da.

⚠️ No lo confundas con teen (el dedo del pie): tien lleva ie larga y teen lleva ee.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 10');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '11', 'WORD', 'Numeros: 11',
'11 = elf. Se sale del patron: no es «eentien». Del 11 y el 12 no hay regla, se aprenden.

📐 El ordinal es elfde (undecimo): de elfde november, que es Sint-Maarten.

📋 Donde lo oiras:
• Het is elf voor half tien. — Son las nueve y diecinueve.
• Om elf uur. — A las once.
• De Elfstedentocht. — La carrera de las Once Ciudades, en patines por Frisia.

🧮 Y el otro elf: de elf es tambien el duende o elfo, y het elftal es el once de futbol, o sea el equipo — het Nederlands elftal es la seleccion.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 11');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '12', 'WORD', 'Numeros: 12',
'12 = twaalf. El otro irregular: tampoco es «tweetien».

📐 El ordinal es twaalfde (duodecimo).

📋 Donde lo oiras:
• Het is twaalf uur. — Son las doce.
• Een dozijn is twaalf. — Una docena son doce.
• De trein van twaalf uur. — El tren de las doce.

🧮 het dozijn es la docena, y se usa poco: En la tienda se dice twaalf stuks (doce unidades).

⚠️ Fijate en el orden de las vocales: twaalf, no «twalf» ni «twaafl». Y en los numeros largos no se invierte nunca — 7512 es zevenduizend vijfhonderdtwaalf, con el twaalf entero al final.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 12');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '13', 'WORD', 'Numeros: 13',
'13 = dertien. Empieza la serie de los -tien, pero con una sorpresa: no es «drietien», sino dertien.

📐 Los tres irregulares de la serie son 13, 14 y 18: dertien (no drietien), veertien (con doble e) y achttien (con doble t). Del 15 al 19 el resto es regular: vijftien, zestien, zeventien, negentien.

📐 El ordinal es dertiende (decimotercero).

📋 Donde lo oiras:
• Het is dertien over negen. — Son las nueve y trece.
• Vrijdag de dertiende. — Viernes trece.
• Ik zit op nummer dertien. — Estoy en el número trece.

⚠️ En Holanda el 13 tambien es het ongeluksgetal, el numero de la mala suerte, y en muchos edificios y aviones se lo saltan.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 13');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '14', 'WORD', 'Numeros: 14',
'14 = veertien. Con DOBLE e, aunque vier solo tenga una. Es una de las dos excepciones de la serie, junto con veertig (40).

📐 El ordinal es veertiende (decimocuarto).

🔑 El dato que se usa a diario: veertien dagen es como el holandes dice DOS SEMANAS. Ik ben veertien dagen weg (me voy dos semanas), over veertien dagen (dentro de dos semanas). Se oye mas que twee weken.

📋 Donde lo oiras:
• Over veertien dagen ben ik terug. — Vuelvo dentro de dos semanas.
• Op 14 februari is het Valentijnsdag. — El 14 de febrero es San Valentín.
• Hij is veertien jaar. — Tiene catorce años.

⚠️ Y el par de la trampa: vier (4) con una e, veertien (14) y veertig (40) con dos.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 14');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '15', 'WORD', 'Numeros: 15',
'15 = vijftien. Regular: vijf + tien, y con la f bien clara.

📐 El ordinal es vijftiende (decimoquinto).

🕒 El dato practico: vijftien minuten es un cuarto de hora, pero eso casi nadie lo dice — se dice een kwartier. Y media hora es een half uur, no «dertig minuten».

📋 Donde lo oiras:
• Het duurt een kwartier. — Dura un cuarto de hora.
• Ik ben er over vijftien minuten. — Llego en quince minutos.
• Vijftien euro per uur. — Quince euros la hora.

⚠️ No confundas vijftien (15) con vijftig (50): la diferencia es -tien contra -tig, y en el habla rapida se juega dinero en esa silaba. Si dudas, pregunta: Vijftien of vijftig?

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 15');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '16', 'WORD', 'Numeros: 16',
'16 = zestien. Se escribe con z pero se pronuncia con S SORDA: séstiin.

📐 El ordinal es zestiende (decimosexto).

⚠️ Esta es la trampa de pronunciacion de todo el grupo: zes se dice con z sonora (zes), pero zestien y zestig pasan a s sorda. Lo mismo con zeven → zeventien y zeventig. No hay logica: es uso.

📋 Donde lo oiras:
• Ik ben zestien jaar. — Tengo dieciséis años.
• Zestien uur is vier uur ''s middags. — Las dieciséis son las cuatro de la tarde.
• Bladzijde zestien. — Página dieciséis.

🧮 Y fijate en que el español dieciseis tambien es un compuesto (diez y seis): la logica es la misma, solo cambia el orden.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 16');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '17', 'WORD', 'Numeros: 17',
'17 = zeventien. Regular en la escritura, tramposo en la boca: se dice con s sorda, séeventiin.

📐 El ordinal es zeventiende (decimoseptimo).

📋 Donde lo oiras:
• Zeventien jaar oud. — Diecisiete años.
• Kamer zeventien. — Habitación diecisiete.
• Om zeventien uur sluiten we. — Cerramos a las diecisiete.

🕔 El reloj de 24 horas se usa en horarios, trenes y citas oficiales: zeventien uur dertig son las 17:30. En la conversacion se vuelve a half zes.

⚠️ Y la pareja del error: zeventien (17) frente a zeventig (70).

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 17');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '18', 'WORD', 'Numeros: 18',
'18 = achttien. Con DOS t al escribirse (acht + tien) aunque solo se oiga una: ájtiin.

📐 El ordinal es achttiende (decimoctavo).

📋 Donde lo oiras:
• Vanaf achttien jaar. — A partir de los dieciocho años.
• Je moet achttien zijn. — Tienes que tener dieciocho.
• De achttiende eeuw. — El siglo XVIII.

🧮 A los 18 se es meerderjarig (mayor de edad) y volwassen (adulto), y es cuando llegan het stemrecht (el derecho a voto) y el rijbewijs (el carnet de conducir).

⚠️ Las dos t no son opcionales: «achtien» esta mal escrito, aunque suene igual.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 18');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '19', 'WORD', 'Numeros: 19',
'19 = negentien. Regular: negen + tien, con las dos g aspiradas.

📐 El ordinal es negentiende (decimonoveno).

📋 Donde lo oiras:
• Het is negentien over negen. — Son las nueve y diecinueve.
• De negentiende eeuw. — El siglo XIX.
• Ik was negentien toen ik verhuisde. — Tenía diecinueve cuando me mudé.

📐 Y aqui esta la clave de los años del siglo XX: 1985 se lee negentienvijfentachtig, o sea el negentien de 19 pegado al resto. 1914 es negentienveertien.

⚠️ La pareja de siempre: negentien (19) frente a negentig (90).

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 19');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '20', 'WORD', 'Numeros: 20',
'20 = twintig. Aqui empiezan las decenas en -tig, y la g final se dice suave, casi como una j española floja: tuíntej.

📐 Las decenas completas: twintig (20), dertig (30), veertig (40), vijftig (50), zestig (60), zeventig (70), tachtig (80), negentig (90). Las tres que se salen del patron son dertig (no drietig), veertig (doble e) y tachtig (no achttig).

📐 El ordinal es twintigste, y de 20 en adelante todos acaban en -ste: dertigste, veertigste, honderdste.

📋 Donde lo oiras:
• Ik ben twintig jaar. — Tengo veinte años.
• De jaren twintig. — Los años veinte.
• Twintig procent korting. — Un veinte por ciento de descuento.

🔑 Y a partir de aqui empieza LA regla del grupo: La unidad va delante. 21 no es «twintig-een» sino eenentwintig, uno-y-veinte.

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 20');

-- =============================================================================
-- 3. Los dieciocho largos (3 por cada longitud, de 2 a 7 cifras)
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '33', 'WORD', 'Numeros: 33',
'33 = drieëndertig. Se lee al reves que en español: tres-y-treinta, todo junto y con TREMA.

📐 El desglose: drie (3) + en + dertig (30) → drieëndertig. La trema va sobre la e de en porque, pegada a la e de drie, se leeria como una sola vocal larga.

🔑 Quienes piden trema: Solo drie y twee, que acaban en e — drieëntwintig (23), drieënveertig (43), tweeëntachtig (82), tweeënnegentig (92). Los demas se pegan sin nada: vierentwintig, vijfendertig, zevenennegentig.

📋 La serie entera del 31 al 35, para ver el patron:
• eenendertig (31) · tweeëndertig (32) · drieëndertig (33) · vierendertig (34) · vijfendertig (35).

⚠️ Y dertig (30) es irregular: no es «drietig». Lo mismo que dertien no es «drietien».

🏋️ Ejercicio: 43 → ___. (Respuesta: drieënveertig.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 33');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '88', 'WORD', 'Numeros: 88',
'88 = achtentachtig. Dos jotas guturales seguidas: ÁJ-ten-TÁJ-tej. Es el mejor ejercicio de garganta del neerlandes.

📐 El desglose: acht (8) + en + tachtig (80) → achtentachtig, todo junto y sin trema, porque acht no acaba en e.

⚠️ tachtig (80) es irregular: no es «achttig». Se perdio la a inicial hace siglos y quedo tachtig, que ademas empieza con t y no con a.

📋 Los numeros con mas ch seguidas, para practicar:
• achtentachtig (88) · achtenzeventig (78) · achtendertig (38) · achthonderdachtentachtig (888).

🔑 La ch neerlandesa es la misma jota de acht, nacht, licht y goed: Sale del fondo de la garganta, no de la punta de la lengua.

🏋️ Ejercicio: 78 → ___. (Respuesta: achtenzeventig.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 88');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '97', 'WORD', 'Numeros: 97',
'97 = zevenennegentig. Siete-y-noventa, con DOBLE n en la costura: zeven + en + negentig.

📐 De donde sale la doble n: De unidad acabada en n mas el en de la union — zeven + en + negentig. Pasa igual en negenennegentig (99) y en negenentachtig (89), y las dos n se escriben siempre.

⚠️ Y la pronunciacion: zeven se dice con z sonora, pero negentig lleva las dos g aspiradas. La palabra entera es un ejercicio de los dos sonidos que no existen en español.

📋 La serie de los noventa:
• eenennegentig (91) · vijfennegentig (95) · zevenennegentig (97) · negenennegentig (99).

🏋️ Ejercicio: 99 → ___. (Respuesta: negenennegentig.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 97');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '365', 'WORD', 'Numeros: 365',
'365 = driehonderdvijfenzestig. Todo en UNA palabra: por debajo de mil no hay espacios.

📐 El desglose: driehonderd (300) + vijfenzestig (65). Y dentro del 65, otra vez la inversion: vijf + en + zestig.

🔑 El orden de lectura es el mismo que en español hasta la centena, y se invierte solo en la ultima pareja: tres-cientos + cinco-y-sesenta.

📋 Los numeros de tres cifras mas usados:
• honderd (100) · tweehonderdvijftig (250) · driehonderdvijfenzestig (365) · vijfhonderd (500).

⚠️ honderd no lleva een delante: 100 es honderd, no «een honderd». Y no tiene plural cuando cuenta: driehonderd, nunca «driehonderden».

📅 Y el dato: 365 son de dagen van het jaar, los dias del año — 366 en het schrikkeljaar.

🏋️ Ejercicio: 250 → ___. (Respuesta: tweehonderdvijftig.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 365');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '748', 'WORD', 'Numeros: 748',
'748 = zevenhonderdachtenveertig. Una sola palabra de veinticinco letras: zevenhonderd + achtenveertig.

📐 El desglose: zeven (7) + honderd (100) + acht (8) + en + veertig (40).

⚠️ veertig (40) lleva DOBLE e, igual que veertien (14), aunque vier (4) tenga una sola. Escribir «vertig» es el error mas repetido.

📋 Los centenares en fila, para oir el patron:
• zevenhonderd (700) · zevenhonderdtien (710) · zevenhonderdachtenveertig (748) · zevenhonderdnegenennegentig (799).

🔑 Truco para escribirlos sin equivocarte: Escribe primero la centena entera y luego la pareja invertida. Nunca al reves.

🏋️ Ejercicio: 642 → ___. (Respuesta: zeshonderdtweeënveertig.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 748');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '999', 'WORD', 'Numeros: 999',
'999 = negenhonderdnegenennegentig. Tres negen seguidos y seis g aspiradas: es EL trabalenguas del neerlandes.

📐 El desglose: negenhonderd (900) + negen (9) + en + negentig (90).

🔑 Si consigues decirlo entero sin trabarte, la g holandesa ya la tienes dominada. Va despacio: néejen-hónderd · néejen-en-néejentej.

📋 Sus vecinos, igual de largos:
• achthonderdachtentachtig (888) · negenhonderdnegenennegentig (999) · zevenhonderdzevenenzeventig (777).

⚠️ Y no lo cortes en dos palabras: por debajo de mil TODO va junto, por larga que quede la palabra. Es lo que hace que el neerlandes tenga palabras de treinta letras.

🏋️ Ejercicio: 777 → ___. (Respuesta: zevenhonderdzevenenzeventig.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 999');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '3847', 'WORD', 'Numeros: 3847',
'3847 = drieduizend achthonderdzevenenveertig. Aqui aparece el ESPACIO: a partir de duizend el numero se parte en dos palabras.

📐 El desglose: drieduizend (3000) + achthonderdzevenenveertig (847). El multiplicador se pega a duizend (drieduizend, junto), y lo que sobra va suelto detras.

🔑 La regla oficial: Se escribe junto todo lo que esta por debajo de mil; duizend se pega a su multiplicador y se separa del resto. Por eso drieduizend achthonderd… lleva un solo espacio, ni cero ni dos.

📋 Los miles, en fila:
• duizend (1000) · tweeduizend (2000) · drieduizend achthonderd (3800) · drieduizend achthonderdzevenenveertig (3847).

⚠️ duizend tampoco lleva een cuando va solo: 1000 es duizend, no «een duizend». Con miljoen si: een miljoen.

🏋️ Ejercicio: 2500 → ___. (Respuesta: tweeduizend vijfhonderd.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 3847');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '4688', 'WORD', 'Numeros: 4688',
'4688 = vierduizend zeshonderdachtentachtig. El mismo molde: unidad + duizend, espacio, y el resto de tres cifras.

📐 El desglose: vierduizend (4000) + zeshonderd (600) + achtentachtig (88).

⚠️ Fijate en la costura zeshonderd: la z suena sonora aqui (zes), pero si fuera zestig sonaria sorda. En el mismo numero puedes tener los dos sonidos.

📋 Para ver como cambia solo la ultima pieza:
• vierduizend zeshonderd (4600) · vierduizend zeshonderdtien (4610) · vierduizend zeshonderdachtentachtig (4688).

🔑 Al dictar un numero asi por telefono, los holandeses lo parten igual que tu lo escribes: vierduizend… zeshonderd… achtentachtig, con pausas en las costuras.

🏋️ Ejercicio: 4600 → ___. (Respuesta: vierduizend zeshonderd.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 4688');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '7512', 'WORD', 'Numeros: 7512',
'7512 = zevenduizend vijfhonderdtwaalf. Aqui esta la excepcion util: el 12 NO se invierte, porque los numeros del 11 al 19 son una pieza entera.

📐 El desglose: zevenduizend (7000) + vijfhonderd (500) + twaalf (12). Al no haber pareja unidad-decena, no hay en ni inversion.

🔑 La regla: La inversion solo ocurre del 21 al 99. Del 11 al 19 el numero va tal cual al final — vijfhonderdtwaalf (512), vijfhonderddertien (513), vijfhonderdnegentien (519).

📋 Compara las dos formas en el mismo hueco:
• vijfhonderdtwaalf (512) — pieza entera, sin en.
• vijfhonderdtweeëntwintig (522) — pareja invertida, con en y trema.

⚠️ Por eso «vijfhonderdtweetien» no existe: 12 es twaalf y punto.

🏋️ Ejercicio: 7519 → ___. (Respuesta: zevenduizend vijfhonderdnegentien.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 7512');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '12345', 'WORD', 'Numeros: 12345',
'12345 = twaalfduizend driehonderdvijfenveertig. El multiplicador de duizend puede ser cualquier numero, tambien uno de dos cifras.

📐 El desglose: twaalf (12) + duizend → twaalfduizend (12000), espacio, y driehonderdvijfenveertig (345).

🔑 El truco para leer cifras largas: Parte por la DERECHA en grupos de tres — 12 | 345 — y nombra cada bloque con su multiplicador. El de la izquierda lleva duizend pegado.

📋 El mismo bloque con multiplicadores distintos:
• tweeduizend (2000) · twaalfduizend (12000) · twintigduizend (20000) · honderdduizend (100000).

⚠️ Y todo el multiplicador va PEGADO a duizend, por largo que sea: vijfentachtigduizend, no «vijfentachtig duizend».

🏋️ Ejercicio: 12000 → ___. (Respuesta: twaalfduizend.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 12345');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '67890', 'WORD', 'Numeros: 67890',
'67890 = zevenenzestigduizend achthonderdnegentig. El multiplicador de duizend tambien se INVIERTE: 67 es zevenenzestig, y se pega entero a duizend.

📐 El desglose: zevenenzestig (67) + duizend → zevenenzestigduizend (67000), espacio, achthonderdnegentig (890).

🔑 Regla de oro: Cada bloque de tres cifras se lee como un numero normal, con sus inversiones dentro, y luego se le pega el multiplicador.

📋 Las costuras de esta palabra, despacio:
• zeven-en-zestig · duizend · acht-honderd · negentig.

⚠️ Y el 90 del final no se invierte con nada: cuando la decena va sola, va sola — achthonderdnegentig, no «achthonderdnulennegentig».

🏋️ Ejercicio: 67000 → ___. (Respuesta: zevenenzestigduizend.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 67890');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '85376', 'WORD', 'Numeros: 85376',
'85376 = vijfentachtigduizend driehonderdzesenzeventig. Dos inversiones en el mismo numero: una en el multiplicador (85) y otra al final (76).

📐 El desglose: vijfentachtig (85) + duizend, espacio, driehonderd (300) + zesenzeventig (76).

⚠️ Dos trampas de pronunciacion juntas: tachtig empieza con t (no con a) y zeventig se dice con s sorda. La palabra entera es faif-en-TÁJ-tej-DÉU-zent.

📋 Como se dicta por telefono, que es donde de verdad se falla:
• vijfentachtig… duizend… driehonderd… zesenzeventig.

🔑 Si te pierden, pide el numero cifra a cifra: Kunt u het cijfer voor cijfer zeggen? — Y te lo diran acht, vijf, drie, zeven, zes.

🏋️ Ejercicio: 85000 → ___. (Respuesta: vijfentachtigduizend.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 85376');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '123456', 'WORD', 'Numeros: 123456',
'123456 = honderddrieëntwintigduizend vierhonderdzesenvijftig. El multiplicador de duizend llega aqui a las tres cifras, y sigue yendo PEGADO.

📐 El desglose: honderddrieëntwintig (123) + duizend, espacio, vierhonderdzesenvijftig (456).

⚠️ honderd va sin een delante tambien aqui: es honderddrieëntwintigduizend, no «eenhonderddrieëntwintigduizend». Y la trema de drieëntwintig se mantiene dentro de la palabra larga.

📋 La escalera de los cien mil:
• honderdduizend (100000) · honderdtienduizend (110000) · honderddrieëntwintigduizend (123000).

🔑 Cuenta las costuras: honderd + drieëntwintig + duizend | vierhonderd + zesenvijftig. Son cinco piezas y un solo espacio.

🏋️ Ejercicio: 100000 → ___. (Respuesta: honderdduizend.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 123456');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '749813', 'WORD', 'Numeros: 749813',
'749813 = zevenhonderdnegenenveertigduizend achthonderddertien. La palabra mas larga del grupo: treinta y siete letras del tiron.

📐 El desglose: zevenhonderdnegenenveertig (749) + duizend, espacio, achthonderddertien (813).

⚠️ Fijate en la triple d de achthonderddertien: acht-honderd + dertien deja honderd y dertien pegados, y las dos d se escriben las dos. Igual pasa en honderdduizend.

📋 Las tres consonantes dobles que salen al pegar numeros:
• achthonderddertien (813) — dd.
• honderdduizend (100000) — dd.
• zevenennegentig (97) — nn.

🔑 Y la regla que lo explica: Al componer no se pierde ninguna letra, aunque queden dos iguales seguidas. El neerlandes escribe las dos y pronuncia una.

🏋️ Ejercicio: 813 → ___. (Respuesta: achthonderddertien.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 749813');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '908077', 'WORD', 'Numeros: 908077',
'908077 = negenhonderdachtduizend zevenenzeventig. Aqui esta el CERO mudo: el 0 de las centenas del segundo bloque no se dice, simplemente desaparece.

📐 El desglose: negenhonderdacht (908) + duizend, espacio, zevenenzeventig (77). El 077 se lee solo zevenenzeventig, sin nada que marque el cero.

⚠️ Ese es el error tipico al dictar: se oye …duizend zevenenzeventig y se escribe 908.77 o 908.770. El cero no suena, asi que hay que contar las cifras del bloque: siempre son tres.

📋 Los ceros mudos, de menos a mas:
• tweeduizend zeven (2007) — dos ceros mudos.
• negenhonderdachtduizend zevenenzeventig (908077) — uno en cada bloque.
• vijfhonderdduizend (500000) — el bloque entero a cero, y ni se menciona.

🔑 Truco de dictado: Si te dan un numero de seis cifras, escribe tres huecos por bloque y rellena de derecha a izquierda. Lo que falte, es cero.

🏋️ Ejercicio: 2007 → ___. (Respuesta: tweeduizend zeven.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 908077');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '1234567', 'WORD', 'Numeros: 1234567',
'1234567 = een miljoen tweehonderdvierendertigduizend vijfhonderdzevenenzestig. Desde el millon, las piezas se SEPARAN: miljoen va suelto, con espacio delante y detras.

📐 El desglose en tres bloques: een miljoen (1000000) | tweehonderdvierendertigduizend (234000) | vijfhonderdzevenenzestig (567).

⚠️ Y al reves que honderd y duizend, miljoen SI lleva een delante: een miljoen, twee miljoen, drie miljoen. Tampoco se pluraliza cuando cuenta: twee miljoen euro, no «twee miljoenen».

📋 La escala grande, que no es la inglesa:
• een miljoen — un millón (10⁶).
• een miljard — mil millones (10⁹), que en ingles es a billion.
• een biljoen — un billón (10¹²), que en ingles es a trillion.

🔑 Ese desfase con el ingles es el que arruina traducciones de prensa: Un billion ingles son mil miljoen, o sea een miljard.

🏋️ Ejercicio: 2000000 → ___. (Respuesta: twee miljoen.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 1234567');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '3500000', 'WORD', 'Numeros: 3500000',
'3500000 = drie miljoen vijfhonderdduizend. Los bloques a cero no se nombran: el ultimo grupo de tres es 000 y desaparece entero.

📐 El desglose: drie miljoen (3000000) + vijfhonderdduizend (500000). Y fijate en vijfhonderdduizend, con las dos d pegadas, todo junto porque el multiplicador va pegado a duizend.

🔑 Como se dice de verdad en la calle: drie en een half miljoen (tres millones y medio) es mucho mas frecuente que el numero entero. Igual que 1500 se suele decir anderhalfduizend o vijftienhonderd.

📋 Las formas cortas que se oyen:
• anderhalf miljoen — un millón y medio.
• drie en een half miljoen — tres millones y medio.
• vijftienhonderd — mil quinientos.

⚠️ anderhalf es una palabra propia para 1,5 y no tiene equivalente español de una pieza: anderhalf uur (hora y media), anderhalve week (semana y media, con -e porque week es de-woord).

🏋️ Ejercicio: 1500000 → ___. (Respuesta: anderhalf miljoen.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 3500000');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '8642913', 'WORD', 'Numeros: 8642913',
'8642913 = acht miljoen zeshonderdtweeënveertigduizend negenhonderddertien. El numero completo del grupo: los tres bloques llenos y todas las reglas a la vez.

📐 El desglose, partiendo por la derecha en grupos de tres: 8 | 642 | 913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien.

📐 Lo que aparece en esta sola frase:
• miljoen suelto, con espacios (acht miljoen).
• la trema de tweeënveertig, porque twee acaba en e.
• el multiplicador pegado a duizend (zeshonderdtweeënveertigduizend).
• la dd de negenhonderddertien.
• la inversion unidad-decena en tweeënveertig.

🔑 El metodo, paso a paso: Parte por la derecha en tres, lee cada bloque como un numero de tres cifras y pegale su multiplicador. Nunca leas de izquierda a derecha cifra a cifra.

⚠️ Y si te lo dictan y no llegas: Kunt u het langzamer herhalen? (¿puede repetirlo más despacio?) o Cijfer voor cijfer, alstublieft (cifra a cifra, por favor).

🏋️ Ejercicio: parte 5.310.284 en bloques → ___ miljoen ___ duizend ___. (Respuesta: vijf · driehonderdtien · tweehonderdvierentachtig.)

🔢 Como se construye cualquier numero:

| tramo | como se forma | ejemplo |
|---|---|---|
| 1-12 | palabra propia, hay que aprenderlas | **zeven**, **twaalf** |
| 13-19 | unidad + **tien**, sin invertir nada | **dertien**, **negentien** |
| decenas | unidad + **tig**, con tres irregulares | **twintig**, **dertig**, **veertig** |
| 21-99 | unidad + **en** + decena, TODO JUNTO | 21 = **eenentwintig** |
| centenas | unidad + **honderd**, sin een y sin plural | 300 = **driehonderd** |
| miles | unidad + **duizend**, y espacio antes del resto | 3847 = **drieduizend achthonderdzevenenveertig** |
| millones | **miljoen** va SUELTO, con espacio a los dos lados | 2000000 = **twee miljoen** |

📌 Las cinco reglas que lo resuelven todo:
• La unidad va DELANTE de la decena, con en en medio: eenentwintig es literalmente uno-y-veinte. Es el orden del aleman, y el mismo de nuestro dieciseis.
• Se escribe TODO junto hasta duizend. Desde duizend se separa del resto (drieduizend achthonderd…), y miljoen y miljard van sueltos.
• honderd y duizend no llevan een delante cuando van solos: honderd euro (cien euros), duizend mensen (mil personas).
• Y no tienen plural cuando cuentan: driehonderd, vijfduizend. El plural honderden y duizenden solo existe para decir centenares y millares.
• La trema sale cuando la union deja dos e juntas que se leerian como una sola: drie + en → drieëntwintig, twee + en → tweeënveertig. Con las demas unidades no hace falta: vierentwintig, zevenentachtig.

🔑 El truco para leer un numero largo: Parte por la DERECHA en grupos de tres y ve nombrando de izquierda a derecha, pegandole a cada bloque su multiplicador. 8642913 → acht miljoen · zeshonderdtweeënveertigduizend · negenhonderddertien. Cada bloque se lee como un numero de tres cifras normal.

⚠️ El punto y la coma funcionan como en español y al reves que en ingles: 1.000,50 son mil euros con cincuenta centimos, y se lee duizend euro vijftig. Si copias el formato ingles, multiplicas por mil sin querer.

📐 Los años se leen segun el siglo: Hasta 1999 se parten en dos mitades, como en ingles (1985 = negentienvijfentachtig, diecinueve-ochenta y cinco); a partir de 2000 se dicen enteros (2026 = tweeduizend zesentwintig).

🧮 Y el vocabulario que los acompaña: het getal es el numero como cantidad, het nummer es el numero de orden (de telefono, de casa, de ventanilla), het cijfer es la cifra o el digito, de helft es la mitad, het dubbele el doble, ongeveer es aproximadamente y bijna es casi.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Numeros: 8642913');

-- =============================================================================
-- 4. Traducciones
-- =============================================================================
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
SELECT we.id, 'nl_NL', v.nl, v.pron
FROM (
    SELECT 'Numeros: 1' AS k, 'een' AS nl, 'een' AS pron
    UNION ALL SELECT 'Numeros: 2', 'twee', 'tuee'
    UNION ALL SELECT 'Numeros: 3', 'drie', 'drii'
    UNION ALL SELECT 'Numeros: 4', 'vier', 'fiir'
    UNION ALL SELECT 'Numeros: 5', 'vijf', 'faif'
    UNION ALL SELECT 'Numeros: 6', 'zes', 'zes'
    UNION ALL SELECT 'Numeros: 7', 'zeven', 'zéeven'
    UNION ALL SELECT 'Numeros: 8', 'acht', 'ajt'
    UNION ALL SELECT 'Numeros: 9', 'negen', 'néejen'
    UNION ALL SELECT 'Numeros: 10', 'tien', 'tiin'
    UNION ALL SELECT 'Numeros: 11', 'elf', 'elf'
    UNION ALL SELECT 'Numeros: 12', 'twaalf', 'tuaalf'
    UNION ALL SELECT 'Numeros: 13', 'dertien', 'dértiin'
    UNION ALL SELECT 'Numeros: 14', 'veertien', 'féertiin'
    UNION ALL SELECT 'Numeros: 15', 'vijftien', 'fáiftiin'
    UNION ALL SELECT 'Numeros: 16', 'zestien', 'séstiin'
    UNION ALL SELECT 'Numeros: 17', 'zeventien', 'zéeventiin'
    UNION ALL SELECT 'Numeros: 18', 'achttien', 'ájtiin'
    UNION ALL SELECT 'Numeros: 19', 'negentien', 'néejentiin'
    UNION ALL SELECT 'Numeros: 20', 'twintig', 'tuíntej'
    UNION ALL SELECT 'Numeros: 33', 'drieëndertig', 'drii-en-dértej'
    UNION ALL SELECT 'Numeros: 88', 'achtentachtig', 'ájten-tájtej'
    UNION ALL SELECT 'Numeros: 97', 'zevenennegentig', 'zéeven-en-néejentej'
    UNION ALL SELECT 'Numeros: 365', 'driehonderdvijfenzestig', 'drii-hónderd-faif-en-séstej'
    UNION ALL SELECT 'Numeros: 748', 'zevenhonderdachtenveertig', 'zéeven-hónderd-ájten-féertej'
    UNION ALL SELECT 'Numeros: 999', 'negenhonderdnegenennegentig', 'néejen-hónderd-néejen-en-néejentej'
    UNION ALL SELECT 'Numeros: 3847', 'drieduizend achthonderdzevenenveertig', 'drii-déuzent ájt-hónderd-zéeven-en-féertej'
    UNION ALL SELECT 'Numeros: 4688', 'vierduizend zeshonderdachtentachtig', 'fiir-déuzent zes-hónderd-ájten-tájtej'
    UNION ALL SELECT 'Numeros: 7512', 'zevenduizend vijfhonderdtwaalf', 'zéeven-déuzent faif-hónderd-tuaalf'
    UNION ALL SELECT 'Numeros: 12345', 'twaalfduizend driehonderdvijfenveertig', 'tuaalf-déuzent drii-hónderd-faif-en-féertej'
    UNION ALL SELECT 'Numeros: 67890', 'zevenenzestigduizend achthonderdnegentig', 'zéeven-en-séstej-déuzent ájt-hónderd-néejentej'
    UNION ALL SELECT 'Numeros: 85376', 'vijfentachtigduizend driehonderdzesenzeventig', 'faif-en-tájtej-déuzent drii-hónderd-zes-en-zéeventej'
    UNION ALL SELECT 'Numeros: 123456', 'honderddrieëntwintigduizend vierhonderdzesenvijftig', 'hónderd-drii-en-tuíntej-déuzent fiir-hónderd-zes-en-faiftej'
    UNION ALL SELECT 'Numeros: 749813', 'zevenhonderdnegenenveertigduizend achthonderddertien', 'zéeven-hónderd-néejen-en-féertej-déuzent ájt-hónderd-dértiin'
    UNION ALL SELECT 'Numeros: 908077', 'negenhonderdachtduizend zevenenzeventig', 'néejen-hónderd-ájt-déuzent zéeven-en-zéeventej'
    UNION ALL SELECT 'Numeros: 1234567', 'een miljoen tweehonderdvierendertigduizend vijfhonderdzevenenzestig', 'en miljún tuee-hónderd-fiir-en-dértej-déuzent faif-hónderd-zéeven-en-séstej'
    UNION ALL SELECT 'Numeros: 3500000', 'drie miljoen vijfhonderdduizend', 'drii miljún faif-hónderd-déuzent'
    UNION ALL SELECT 'Numeros: 8642913', 'acht miljoen zeshonderdtweeënveertigduizend negenhonderddertien', 'ajt miljún zes-hónderd-tuee-en-féertej-déuzent néejen-hónderd-dértiin'
) v
JOIN words_es we ON we.notes = v.k;

-- =============================================================================
-- 5. Al grupo nuevo y a generic
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Numeros: %' AND g.title = 'los numeros - de getallen y como se leen';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Numeros: %' AND g.title = 'generic';
