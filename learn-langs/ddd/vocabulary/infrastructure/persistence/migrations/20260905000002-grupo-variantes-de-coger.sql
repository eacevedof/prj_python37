-- Learn Languages App - Migration
-- Migration: 20260905000002-grupo-variantes-de-coger
-- Description: Eduardo pidio crear el grupo que quedo apuntado como pendiente en la
--   migracion 20260905000001 (ayuda de pakken en la tarjeta 75): "ok, crea un grupo como
--   indicas". Se crea "variantes de coger - pakken nemen grijpen vatten" replicando el
--   patron del grupo 24 (variantes de poner - zetten leggen stoppen stellen): tarjetas
--   PHRASE contrastivas, una por verbo, cada una con su regla, su estructura, cuando
--   usarla y su ejercicio, mas la teoria compartida inyectada byte a byte.
--   16 tarjetas nuevas, una por uso: pakken (la mano sobre el objeto), nemen x2
--   (transporte y la expresion fija een beslissing nemen), oprapen (del suelo), oppakken
--   x2 (levantar y detener), vastpakken, afpakken, inpakken, uitpakken x2 (desenvolver y
--   "resultar"), aanpakken, grijpen, meenemen, verpakken (inseparable) y samenvatten.
--   Se anaden ademas al grupo tres tarjetas que ya existian y son de esta familia: la 661
--   (opnemen, el telefono), y las que creo la 0001: "soltar" = loslaten y su frase.
--   Teoria compartida (norma: un solo bloque, inyectado identico, nunca reescrito):
--     A) "🗺️ Coger, segun que cojas y como" — el mapa + regla de bolsillo + el truco +
--        el aviso de donde nemen no admite pakken. Es EXACTAMENTE el mismo texto que ya
--        lleva la 75, para que no haya dos versiones de la misma teoria.
--     B) "📊 El paradigma de pakken" — conjugacion de 7 personas + participio + las
--        cuatro posiciones del separable. Va a las 9 tarjetas construidas con pakken.
--     C) "📊 El paradigma de nemen" — idem para el verbo fuerte nemen. Va a las 3 suyas.
--   Cada bloque abre con su emoji-marca, que es el guard de idempotencia.
--   Coordinada con la 661: se respeta su reparto oprapen (del suelo) / oppakken (agarrar
--   y levantar) / opnemen (el telefono y nunca un objeto).

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'variantes de coger - pakken nemen grijpen vatten',
       'El espanol «coger» es un solo verbo, pero el neerlandes lo reparte por lo que hace la mano y por donde estaba la cosa: pakken (la mano se cierra sobre algo fisico), nemen (tomar en abstracto: transporte, decisiones, pausas), oprapen (del suelo, algo caido), oppakken (agarrar y levantar, y tambien detener), vastpakken (agarrar y no soltar), afpakken (quitarselo a alguien), inpakken (envolver, hacer la maleta), uitpakken (desenvolver, y tambien resultar), aanpakken (abordar un asunto), meenemen (llevarselo), grijpen (agarrar de golpe), verpakken (envasar, inseparable), samenvatten (resumir, captar) y opnemen (el telefono, nunca un objeto). Con la regla de bolsillo, el paradigma de pakken y de nemen, y ejercicios para elegir el verbo correcto',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups
                  WHERE title = 'variantes de coger - pakken nemen grijpen vatten');

-- =============================================================================
-- 2. Las 16 tarjetas PHRASE, una por uso
--    notes = 'Variante de coger: <verbo>' identifica la tarjeta y sirve de guard
--    para inyectar despues la teoria compartida.
-- =============================================================================

-- --- 2.01 pakken: la mano se cierra sobre algo fisico -------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'coge una manta', 'PHRASE', 'Variante de coger: pakken',
'pakken = coger con la mano, cerrarla sobre algo fisico que esta ahi al lado. Pak een deken = coge una manta. Es el coger mas corriente y el que usa la tarjeta 75, de deken.

📐 Estructura del imperativo: Pak (1a posicion) + objeto (een deken). Para suavizarlo se cuela even o maar: Pak even een deken (coge una mantita), Pak maar een deken (coge una manta, anda).

🧭 Cuando usarlo: pedir que alguien agarre algo que tiene a mano. Ej.: → Pak even een stoel (coge una silla).

🏋️ Ejercicio: «coge una galleta» → ___ een koekje. (Respuesta: Pak. Tambien vale Neem, que suena algo mas cortes.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: pakken');

-- --- 2.02 nemen: el transporte ------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cojo el tren de las ocho', 'PHRASE', 'Variante de coger: nemen transporte',
'nemen = tomar, en el sentido amplio en que no hay ninguna mano agarrando. Ik neem de trein van acht uur = cojo el tren de las ocho. Con transportes manda nemen siempre: de trein, de bus, de metro, de tram, een taxi, het vliegtuig.

📐 Estructura: sujeto + neem + el transporte + van + la hora. Ik neem de trein van acht uur.

🧭 Cuando usarlo: decir en que vas a un sitio. Ej.: → Neem je de bus of de fiets? (¿coges el bus o la bici?).

⚠️ Con la bici hay trampa: para ir en bici lo normal es el verbo fietsen (Ik fiets naar mijn werk) o met de fiets gaan, no «de fiets nemen», que suena a que te la llevas. Con coche, met de auto gaan.

🏋️ Ejercicio: «cojo un taxi» → Ik ___ een taxi. (Respuesta: neem. Ningun taxi se agarra con la mano.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: nemen transporte');

-- --- 2.03 nemen: la expresion fija --------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tengo que tomar una decisión', 'PHRASE', 'Variante de coger: nemen expresion',
'een beslissing nemen = tomar una decision. Es COLOCACION FIJA: aqui nemen no se puede cambiar por pakken por mucho que en la calle se oiga pakken para casi todo.

📋 Las colocaciones con nemen que hay que memorizar enteras:
• een beslissing nemen — tomar una decision.
• een besluit nemen — lo mismo, algo mas formal.
• pauze nemen — hacer una pausa.
• de tijd nemen — tomarse su tiempo. Neem de tijd.
• een douche nemen — ducharse.
• afscheid nemen van — despedirse de.
• contact opnemen met — ponerse en contacto con.
• het woord nemen — tomar la palabra.
• iets serieus nemen — tomarse algo en serio.

📐 Estructura: modal + objeto + infinitivo al final. Ik moet een beslissing nemen.

🧭 Cuando usarlo: cuando en español dirias "tomar" y no "agarrar". Ej.: → We moeten vandaag een besluit nemen (hoy tenemos que decidir).

🔑 El truco: si el objeto es abstracto y no lo puedes soltar de la mano, es nemen.

🏋️ Ejercicio: «vamos a hacer una pausa» → We ___ even pauze. (Respuesta: nemen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: nemen expresion');

-- --- 2.04 oprapen: del suelo ---------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'recoge el bolígrafo del suelo', 'PHRASE', 'Variante de coger: oprapen',
'oprapen = recoger del SUELO algo que se ha caido. Raap de pen van de grond op. Separable, debil: oprapen – raapte op – heeft opgeraapt. Es el unico verbo para lo que esta por el suelo; oppakken sirve para agarrar y levantar este donde este.

📊 Conjugacion de oprapen (debil, separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | raap op | raapte op |
| jij / je | raapt op | raapte op |
| u | raapt op | raapte op |
| hij / zij / het | raapt op | raapte op |
| wij | rapen op | raapten op |
| jullie | rapen op | raapten op |
| zij (plural) | rapen op | raapten op |

• participio — opgeraapt, con hebben. El ge- se cuela dentro, como en todo separable.
• ojo a la ortografia, que cambia de aa a a: raap en singular, rapen en plural. La silaba abierta ya alarga la vocal sola, asi que la segunda a sobra.
• al invertir, jij pierde la -t: Raap jij de pen op?
• preposicion — transitivo directo. El sitio se marca con van de grond (del suelo).

📐 Estructura del imperativo separable: Raap + objeto + lugar + op al final. Raap de pen van de grond op.

🧭 Cuando usarlo: pedir que recojan algo caido. Ej.: → Raap je jas op (recoge tu abrigo del suelo).

💬 De aqui sale opraapwerk y, sobre todo, el sustantivo de raap, que es el nabo: nada que ver, pero se parecen y confunde.

🏋️ Ejercicio: «recogi el boligrafo» → Ik ___ de pen ___. (Respuesta: raapte … op.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: oprapen');

-- --- 2.05 oppakken: agarrar y levantar -----------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'coge la caja', 'PHRASE', 'Variante de coger: oppakken levantar',
'oppakken = agarrar algo y levantarlo, este donde este. Pak de doos op = coge la caja. Frente a oprapen, que es solo lo que se ha caido al suelo, oppakken vale para la mesa, la estanteria o los brazos: Pak de baby op (coge al bebe en brazos).

📐 Estructura del imperativo separable: Pak + objeto + op al final. Pak de doos op.

🧭 Cuando usarlo: pedir que levanten algo. Ej.: → Kun je die tas even oppakken? (¿puedes coger esa bolsa?).

🔁 El antonimo es neerzetten (dejar en el suelo o en la mesa) o neerleggen si queda tumbado: Zet de doos maar neer. Y si lo sueltas de la mano, loslaten, que esta en el mazo como tarjeta propia.

🏋️ Ejercicio: «he cogido al bebe» → Ik heb de baby ___. (Respuesta: opgepakt.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: oppakken levantar');

-- --- 2.06 oppakken: detener ----------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la policía ha detenido al culpable', 'PHRASE', 'Variante de coger: oppakken detener',
'oppakken = detener, echar el guante. De politie heeft de dader opgepakt. Es el mismo verbo de agarrar y levantar, aplicado a personas: la policia te "levanta" de la calle.

🎭 Las tres maneras de decir que te detienen, de menos a mas formal:
• oppakken — echar el guante, lo que dice la gente y la prensa. Ze hebben hem opgepakt.
• aanhouden — detener, el termino neutro y el que usa la policia. De verdachte is aangehouden.
• arresteren — arrestar, el mas formal y juridico.

⚠️ Y pakken a secas hace lo mismo en coloquial, pillar: De politie heeft hem gepakt, Ik ben gepakt (me han pillado). De ahi sale de pakkans, la probabilidad de que te pillen.

📐 Estructura del perfecto: sujeto + heeft + objeto + participio al final, con el ge- dentro. De politie heeft de dader opgepakt.

🧭 Cuando usarlo: contar una detencion. Ej.: → Hij werd gisteren opgepakt (lo detuvieron ayer, en pasiva).

📦 Los sustantivos, con su articulo: de dader (el culpable, el autor), de verdachte (el sospechoso), de aanhouding (la detencion), de politie (la policia, siempre en singular y con de).

🏋️ Ejercicio: «detuvieron a dos personas» → Ze hebben twee mensen ___. (Respuesta: opgepakt.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: oppakken detener');

-- --- 2.07 vastpakken -----------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'agarra bien la cuerda', 'PHRASE', 'Variante de coger: vastpakken',
'vastpakken = agarrar y NO soltar. Pak het touw goed vast. El vast es el mismo de vasthouden (sujetar) y de vastzitten (estar atascado): marca que la cosa queda sujeta.

🎭 vastpakken, vasthouden y beetpakken, que se confunden:
• vastpakken — el gesto de agarrar, el momento en que cierras la mano.
• vasthouden — mantenerlo agarrado, la duracion. Hou mijn hand vast (dame la mano y no la sueltes).
• beetpakken — agarrar por una parte concreta, echarle mano. Pak hem bij zijn arm beet.

📐 Estructura del imperativo separable con adverbio: Pak + objeto + goed + vast. El goed (bien, fuerte) va justo antes de la particula.

🧭 Cuando usarlo: avisar de que se agarre fuerte. Ej.: → Pak je moeder goed vast (agarrate bien a tu madre).

🔁 El antonimo es loslaten (soltar), que esta en el mazo como tarjeta propia. Pak het touw vast ↔ Laat het touw los.

🏋️ Ejercicio: «me agarre a la barandilla» → Ik ___ de leuning ___. (Respuesta: pakte … vast. Tambien vale Ik hield me vast aan de leuning.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: vastpakken');

-- --- 2.08 afpakken -------------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me han quitado el móvil', 'PHRASE', 'Variante de coger: afpakken',
'afpakken = quitarle algo a alguien, cogerselo. Ze hebben mijn telefoon afgepakt. El af marca que la cosa se separa de su dueno, asi que siempre hay una victima.

📐 Estructura: al que se lo quitan va en dativo, sin preposicion, delante del objeto. Ze pakken hem zijn telefoon af (le quitan el movil). Con van tambien vale y es mas explicito: Ze pakken de telefoon van hem af.

🧭 Cuando usarlo: quejarse de que te han quitado algo. Ej.: → Ze hebben me mijn fiets afgepakt (me han quitado la bici).

🎭 Quitar, segun como se quite:
• afpakken — quitarselo a alguien, con las manos y a la cara.
• afnemen — retirar, mas neutro y formal: een examen afnemen es hacer un examen a alguien.
• stelen — robar. Mijn fiets is gestolen.
• wegnemen — retirar algo de en medio, y tambien disipar: twijfels wegnemen (disipar dudas).

🔁 El antonimo es teruggeven (devolver): Geef me mijn telefoon terug.

🏋️ Ejercicio: «no me quites el libro» → ___ mijn boek niet ___. (Respuesta: Pak … af.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: afpakken');

-- --- 2.09 inpakken -------------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estoy haciendo la maleta', 'PHRASE', 'Variante de coger: inpakken',
'inpakken = meter dentro: hacer la maleta y tambien envolver un regalo. Ik ben mijn koffer aan het inpakken. El in dice que la cosa entra en algo, sea una maleta o un papel.

📐 Estructura del presente continuo: sujeto + ben/bent/is + aan het + infinitivo. Ik ben mijn koffer aan het inpakken. Es la forma de decir "estoy haciendo X" ahora mismo; sin ella, Ik pak mijn koffer in vale igual.

🧭 Cuando usarlo: preparar el equipaje o envolver algo. Ej.: → Kun je dit cadeau inpakken? (¿me lo envuelve para regalo?).

🎁 En la tienda te lo preguntan asi: Zal ik het inpakken? (¿se lo envuelvo?) o Is het een cadeautje? (¿es para regalo?). Se contesta Ja, graag.

🔁 El antonimo es uitpakken (desenvolver, deshacer la maleta), que tiene su propia tarjeta en este grupo. Es el par mas limpio del grupo: in ↔ uit.

🏋️ Ejercicio: «he envuelto los regalos» → Ik heb de cadeaus ___. (Respuesta: ingepakt.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: inpakken');

-- --- 2.10 uitpakken: desenvolver ------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'los niños abren los regalos', 'PHRASE', 'Variante de coger: uitpakken abrir',
'uitpakken = sacar de su envoltorio: abrir los regalos, deshacer la maleta. De kinderen pakken de cadeaus uit. Es el reverso exacto de inpakken.

📐 Estructura de la frase principal: sujeto + verbo conjugado en 2a posicion + objeto + particula al final. De kinderen pakken de cadeaus uit.

🧭 Cuando usarlo: en Sinterklaas y en los cumpleanos, que es cuando toca. Ej.: → Mag ik het nu uitpakken? (¿lo puedo abrir ya?).

⚠️ uitpakken tiene una segunda vida que no tiene nada que ver con abrir paquetes: RESULTAR. Tiene su propia tarjeta en este grupo, porque es la acepcion que descoloca.

🔁 El antonimo es inpakken, que tambien esta en el grupo.

🏋️ Ejercicio: «ya he deshecho la maleta» → Ik heb mijn koffer al ___. (Respuesta: uitgepakt.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: uitpakken abrir');

-- --- 2.11 uitpakken: resultar ---------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'al final salió bien', 'PHRASE', 'Variante de coger: uitpakken resultar',
'uitpakken = resultar, salir de una manera. Het pakte uiteindelijk goed uit = al final salio bien. Aqui no se abre ningun paquete: es la acepcion figurada, y va SIEMPRE con un adverbio de como sale la cosa.

📋 Las combinaciones que se oyen:
• goed uitpakken — salir bien. Dat pakt goed uit.
• slecht / verkeerd uitpakken — salir mal.
• anders uitpakken — salir de otra manera de la prevista.
• gunstig uitpakken — resultar favorable.
• voor iemand uitpakken — salirle a alguien de tal manera. Het pakte slecht voor hem uit.

📐 Estructura: sujeto (casi siempre het o dat) + verbo + adverbio de modo + uit al final. Het pakte uiteindelijk goed uit.

🧭 Cuando usarlo: valorar como acabo algo que estaba en el aire. Ej.: → We waren bang, maar het pakte goed uit.

🖼️ La imagen ayuda a que se quede: es literalmente "desempaquetarse". La situacion estaba envuelta, no sabias que habia dentro, y al abrirse resulto ser buena o mala.

🎭 Rivales para "resultar": uitpakken (como acaba saliendo algo), blijken (resultar ser, revelarse: het blijkt dat…), aflopen (acabar: het liep goed af).

🏋️ Ejercicio: «salio mal» → Het ___ slecht ___. (Respuesta: pakte … uit.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: uitpakken resultar');

-- --- 2.12 aanpakken -------------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tenemos que abordar esto de otra manera', 'PHRASE', 'Variante de coger: aanpakken',
'aanpakken = abordar, meterle mano a un asunto. We moeten dit anders aanpakken. Lo que se "coge" aqui no es un objeto sino un problema, una tarea o una persona.

📐 Estructura con modal: el separable NO se separa detras de un modal, va entero al final. We moeten dit anders aanpakken. Solo el te se colaria dentro: om dit anders aan te pakken.

🧭 Cuando usarlo: hablar de metodo, de como se enfoca algo. Ej.: → Hoe gaan we dit aanpakken? (¿como lo enfocamos?).

📦 El sustantivo es de aanpak (el enfoque, la manera de hacerlo), siempre con de: een harde aanpak (mano dura), een andere aanpak (otro enfoque).

⚠️ Con persona como objeto, aanpakken se vuelve duro: iemand hard aanpakken es apretarle las clavijas a alguien. Y Pak aan! con exclamacion es otra cosa distinta: ¡toma!, al darle algo a alguien en la mano.

💬 Y una expresion que se oye mucho: de koe bij de horens vatten, coger el toro por los cuernos — aqui la vaca por los cuernos, que es lo que hay en Holanda.

🏋️ Ejercicio: «¿como lo vas a abordar?» → Hoe ga je het ___? (Respuesta: aanpakken.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: aanpakken');

-- --- 2.13 grijpen ----------------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me agarró del brazo', 'PHRASE', 'Variante de coger: grijpen',
'grijpen = agarrar de golpe y con fuerza, echar la zarpa. Hij greep me bij mijn arm. Verbo fuerte: grijpen – greep – heeft gegrepen. Frente a pakken, que es neutro, grijpen tiene siempre brusquedad.

📊 Conjugacion de grijpen (fuerte, NO separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | grijp | greep |
| jij / je | grijpt | greep |
| u | grijpt | greep |
| hij / zij / het | grijpt | greep |
| wij | grijpen | grepen |
| jullie | grijpen | grepen |
| zij (plural) | grijpen | grepen |

• participio — gegrepen, con hebben. Hij heeft me gegrepen.
• el cambio de vocal es el del grupo ij → ee → e: grijpen, greep, gegrepen. Igual que blijven (bleef, gebleven) y kijken (keek, gekeken).
• preposicion — con parte del cuerpo, bij: iemand bij de arm grijpen. Y con objeto abstracto, naar: naar de macht grijpen (hacerse con el poder), naar de fles grijpen (darse a la bebida).

📐 Estructura: sujeto + greep + objeto persona + bij + parte del cuerpo con posesivo. Hij greep me bij mijn arm.

🧭 Cuando usarlo: contar algo brusco o violento. Ej.: → Ze greep haar tas en rende weg.

📦 Los sustantivos, con su articulo: de greep (el agarre, y tambien el pomo), het begrip (el concepto, de begrijpen), de ingreep (la intervencion quirurgica).

💬 Expresiones: de macht grijpen (tomar el poder), zijn kans grijpen (aprovechar la ocasion), uit de lucht gegrepen (sacado de la manga, sin fundamento).

🏋️ Ejercicio: «aproveche mi oportunidad» → Ik ___ mijn kans. (Respuesta: greep.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: grijpen');

-- --- 2.14 meenemen -----------------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿te llevas una manta?', 'PHRASE', 'Variante de coger: meenemen',
'meenemen = llevarse consigo. Neem je een deken mee? = ¿te llevas una manta? Es mee (con) + nemen, asi que el foco no es agarrar sino trasladar: la cosa se va contigo a otro sitio.

📐 Estructura de la pregunta: verbo en 1a posicion + sujeto + objeto + mee al final. Neem je een deken mee? Fijate en que la particula se va al final aunque sea pregunta.

🧭 Cuando usarlo: preguntar o avisar de que algo se lleva. Ej.: → Neem je paraplu mee, het gaat regenen.

🍔 Y la frase que oiras en cualquier mostrador: Om mee te nemen? (¿para llevar?). Ahi esta la regla del te en medio de un separable, y ya esta en el mazo como tarjeta.

🎭 Llevar, que en neerlandes tampoco es un solo verbo:
• meenemen — llevarse algo consigo.
• brengen — llevar algo A alguien o a un sitio. Ik breng je naar het station.
• dragen — llevar puesto (ropa) o llevar en brazos, cargar.
• meebrengen — traer consigo (hacia donde esta el que habla).

🔁 El antonimo es achterlaten (dejar atras): Laat je tas hier achter.

🏋️ Ejercicio: «me he llevado el paraguas» → Ik heb mijn paraplu ___. (Respuesta: meegenomen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: meenemen');

-- --- 2.15 verpakken ------------------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'viene envuelto en plástico', 'PHRASE', 'Variante de coger: verpakken',
'verpakken = envasar, embalar de fabrica. Het is in plastic verpakt. Es el unico de la familia que NO se separa: ver- es prefijo atono inseparable, asi que el participio va sin ge-.

⚠️ La prueba de que es inseparable, en las tres formas donde se notaria: participio verpakt y nunca «geverpakt» · frase principal Ze verpakken het in plastic, con el verbo entero y sin nada al final · con te, om het te verpakken, con el te DELANTE y no en medio. Compara con inpakken, que hace ingepakt, pakt het in y om het in te pakken.

📊 Conjugacion de verpakken (debil, inseparable):

| persona | presente | imperfecto |
|---|---|---|
| ik | verpak | verpakte |
| jij / je | verpakt | verpakte |
| u | verpakt | verpakte |
| hij / zij / het | verpakt | verpakte |
| wij | verpakken | verpakten |
| jullie | verpakken | verpakten |
| zij (plural) | verpakken | verpakten |

• participio — verpakt, con hebben, y sin ge-.
• ojo al solape: verpakt es a la vez la forma de jij/u/hij y el participio. Se distinguen por el sitio y por el auxiliar: Hij verpakt het (presente, en 2a posicion) frente a Het is verpakt (participio, al final y con is).

📐 Estructura de la pasiva de estado: sujeto + is + in + material + participio al final. Het is in plastic verpakt.

🧭 Cuando usarlo: hablar de envases y embalajes. Ej.: → Alles is apart verpakt (todo viene envasado por separado).

📦 El sustantivo es de verpakking (el envase, el embalaje), y en el supermercado veras verpakkingsmateriaal y statiegeld (el deposito que te devuelven por el envase).

🏋️ Ejercicio: «lo envasan en carton» → Ze ___ het in karton. (Respuesta: verpakken. Sin separar: no existe «pakken het ver».)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: verpakken');

-- --- 2.16 samenvatten ------------------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'resúmelo brevemente', 'PHRASE', 'Variante de coger: samenvatten',
'samenvatten = resumir, literalmente "coger junto". Vat het kort samen. El verbo base es vatten, que es coger o captar, y es el que da el vatten del titulo de este grupo.

🧠 De donde sale: vatten es el mismo coger de begrijpen pero por dentro de la cabeza — captar. De ahi salen begrip (el concepto), bevatten (contener) y het is niet te vatten (es incomprensible). Cuando lo coges TODO y lo juntas, samenvatten: lo resumes.

📋 La familia de vatten, que aparece por todas partes:
• vatten — captar, entender. Ik vat het niet (no lo pillo). Tambien coger frio: kou vatten.
• samenvatten — resumir.
• opvatten — interpretar, tomarse algo de una manera. Vat het niet verkeerd op (no te lo tomes a mal).
• bevatten — contener. De fles bevat een liter.
• aanvatten — emprender.

📊 Conjugacion de samenvatten (debil, separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | vat samen | vatte samen |
| jij / je | vat samen | vatte samen |
| u | vat samen | vatte samen |
| hij / zij / het | vat samen | vatte samen |
| wij | vatten samen | vatten samen |
| jullie | vatten samen | vatten samen |
| zij (plural) | vatten samen | vatten samen |

• participio — samengevat, con hebben. El ge- se cuela dentro.
• jij NO añade -t aqui: la raiz ya acaba en t (vat), asi que es jij vat samen, nunca «vatt».
• ojo al solape gordo: en plural, el presente (wij vatten samen) y el imperfecto (wij vatten samen) son IDENTICOS. Solo el contexto los distingue; si hace falta precisar, se tira del perfecto: wij hebben samengevat.

📐 Estructura del imperativo separable: Vat + objeto + adverbio + samen al final. Vat het kort samen.

🧭 Cuando usarlo: pedir un resumen. Ej.: → Kun je het even samenvatten? (¿lo resumes?).

📦 El sustantivo es de samenvatting (el resumen), con de porque acaba en -ing. Y en television, de samenvatting es el resumen del partido.

🏋️ Ejercicio: «no lo pillo» → Ik ___ het niet. (Respuesta: vat. Tambien, y mas corriente, Ik snap het niet.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Variante de coger: samenvatten');

-- =============================================================================
-- 3. Traducciones de las 16
-- =============================================================================
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
SELECT we.id, 'nl_NL', v.nl, v.pron
FROM (
    SELECT 'Variante de coger: pakken' AS k, 'Pak een deken.' AS nl, 'pak en deeken' AS pron
    UNION ALL SELECT 'Variante de coger: nemen transporte', 'Ik neem de trein van acht uur.', 'ik neem de train fan ajt uur'
    UNION ALL SELECT 'Variante de coger: nemen expresion', 'Ik moet een beslissing nemen.', 'ik mut en beslísing neemen'
    UNION ALL SELECT 'Variante de coger: oprapen', 'Raap de pen van de grond op.', 'raap de pen fan de jront op'
    UNION ALL SELECT 'Variante de coger: oppakken levantar', 'Pak de doos op.', 'pak de doos op'
    UNION ALL SELECT 'Variante de coger: oppakken detener', 'De politie heeft de dader opgepakt.', 'de politsi heeft de daader opjepakt'
    UNION ALL SELECT 'Variante de coger: vastpakken', 'Pak het touw goed vast.', 'pak het tau jut fast'
    UNION ALL SELECT 'Variante de coger: afpakken', 'Ze hebben mijn telefoon afgepakt.', 'ze hebben main teelefoon afjepakt'
    UNION ALL SELECT 'Variante de coger: inpakken', 'Ik ben mijn koffer aan het inpakken.', 'ik ben main kofer aan het inpaken'
    UNION ALL SELECT 'Variante de coger: uitpakken abrir', 'De kinderen pakken de cadeaus uit.', 'de kínderen paken de kadoos aut'
    UNION ALL SELECT 'Variante de coger: uitpakken resultar', 'Het pakte uiteindelijk goed uit.', 'het pakte auteindelek jut aut'
    UNION ALL SELECT 'Variante de coger: aanpakken', 'We moeten dit anders aanpakken.', 've muten dit anders aanpaken'
    UNION ALL SELECT 'Variante de coger: grijpen', 'Hij greep me bij mijn arm.', 'hai jreep me bai main arm'
    UNION ALL SELECT 'Variante de coger: meenemen', 'Neem je een deken mee?', 'neem ye en deeken mee'
    UNION ALL SELECT 'Variante de coger: verpakken', 'Het is in plastic verpakt.', 'het is in plastik ferpakt'
    UNION ALL SELECT 'Variante de coger: samenvatten', 'Vat het kort samen.', 'fat het kort saamen'
) v
JOIN words_es we ON we.notes = v.k;

-- =============================================================================
-- 4. Las 16 al grupo nuevo y a generic
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id
FROM words_es we, word_groups g
WHERE we.notes LIKE 'Variante de coger: %'
  AND g.title = 'variantes de coger - pakken nemen grijpen vatten';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id
FROM words_es we, word_groups g
WHERE we.notes LIKE 'Variante de coger: %'
  AND g.title = 'generic';

-- =============================================================================
-- 5. Las que ya existian y son de esta familia, tambien al grupo:
--    661 (opnemen, el telefono) y las dos de la migracion 0001 (loslaten).
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id
FROM words_es we, word_groups g
WHERE g.title = 'variantes de coger - pakken nemen grijpen vatten'
  AND (we.id = 661
       OR we.text = 'soltar'
       OR (we.text = 'Suelta mi mano, por favor.' AND we.notes = 'Ejemplo de "loslaten" (geb.)'));

-- =============================================================================
-- 6. Bloque compartido A: el mapa de coger.
--    Texto IDENTICO al que ya lleva la 75 (migracion 0001), para que no haya dos
--    versiones de la misma teoria. Guard: la marca 🗺️.
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🗺️ Coger, segun que cojas y como:

| que haces | verbo | ejemplo |
|---|---|---|
| cierras la mano sobre algo fisico | **pakken** | Ik **pak** een deken. |
| tomas algo, en sentido amplio y abstracto | **nemen** | Ik **neem** de trein. |
| lo agarras y lo levantas con la mano | **oppakken** | **Pak** de doos **op**. |
| lo recoges del suelo, se habia caido | **oprapen** | Ik **raapte** de pen **op**. |
| lo agarras fuerte y no lo sueltas | **vastpakken** | **Pak** het touw goed **vast**. |
| se lo quitas a alguien | **afpakken** | Ze **pakken** hem zijn telefoon **af**. |
| lo metes en la maleta o en papel | **inpakken** | Ik **pak** mijn koffer **in**. |
| lo sacas de su envoltorio | **uitpakken** | De kinderen **pakken** de cadeaus **uit**. |
| te enfrentas a un asunto, lo abordas | **aanpakken** | We moeten dit anders **aanpakken**. |
| te lo llevas contigo | **meenemen** | Ik **neem** een deken **mee**. |
| lo envasas de fabrica | **verpakken** | Het is in plastic **verpakt**. |
| lo agarras de golpe y con fuerza | **grijpen** | Hij **greep** mijn arm. |

Los tres que vas a usar de verdad: pakken para la mano, nemen para lo abstracto y oprapen para lo que se ha caido al suelo.

📌 Regla de bolsillo:
• Hay una mano que se cierra sobre algo fisico → pakken.
• Es "tomar" en sentido amplio: transporte, decision, descanso, ducha, clase → nemen.
• Esta en el SUELO porque se cayo → oprapen.
• Lo agarras y lo levantas, este donde este → oppakken.
• Lo que "coges" es un problema o una tarea → aanpakken.
• Te lo llevas contigo a otro sitio → meenemen.
• Es el telefono lo que coges → opnemen, y ningun otro. Mapa completo en la tarjeta 661.

🔑 El truco que casi nunca falla: Cambia "coger" por "agarrar con la mano". Si sigue sonando bien, es pakken; si te pide "tomar", es nemen. Ik pak een deken (la agarras del sofa) frente a Ik neem de trein (ningun tren se agarra con la mano).

⚠️ Donde nemen NO se puede sustituir por pakken, aunque en la calle oigas pakken para casi todo: een beslissing nemen (tomar una decision), pauze nemen (hacer una pausa), de tijd nemen (tomarse su tiempo), een douche nemen (ducharse), afscheid nemen (despedirse). Son expresiones hechas y ahi manda nemen.'
WHERE notes LIKE 'Variante de coger: %'
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🗺️ Coger, segun que cojas y como%';

-- =============================================================================
-- 7. Bloque compartido B: el paradigma de pakken.
--    Solo a las 9 tarjetas construidas con pakken. Guard: la marca 📊 El paradigma.
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

📊 El paradigma de pakken (debil, y la base de casi todo el grupo):

| persona | presente | imperfecto |
|---|---|---|
| ik | pak | pakte |
| jij / je | pakt | pakte |
| u | pakt | pakte |
| hij / zij / het | pakt | pakte |
| wij | pakken | pakten |
| jullie | pakken | pakten |
| zij (plural) | pakken | pakten |

• participio — gepakt, con hebben. En los separables el ge- se cuela dentro: opgepakt, ingepakt, uitgepakt, afgepakt, vastgepakt, aangepakt.
• al invertir, jij pierde la -t: Pak jij een deken? — nunca "pakt jij". Y u no la pierde jamas.
• pakken a secas no rige preposicion, es transitivo directo. Solo con parte del cuerpo entra bij: Hij pakte me bij mijn arm.

📐 Un separable, en sus cuatro sitios:

| donde | que pasa | ejemplo |
|---|---|---|
| principal | la particula se va **al final** | Hij **pakt** de krant **op**. |
| perfecto | el ge- se cuela **dentro** | Hij heeft de krant **opgepakt**. |
| subordinada | las piezas **se reunen y se escriben juntas** | … omdat hij de krant **oppakt**. |
| con te | el te va **en medio** | Hij probeert de krant **op te pakken**. |

⚠️ La excepcion es verpakken, que con ver- atono no se separa ni lleva ge-: verpakt, nunca "geverpakt".'
WHERE notes IN (
    'Variante de coger: pakken',
    'Variante de coger: oppakken levantar',
    'Variante de coger: oppakken detener',
    'Variante de coger: vastpakken',
    'Variante de coger: afpakken',
    'Variante de coger: inpakken',
    'Variante de coger: uitpakken abrir',
    'Variante de coger: uitpakken resultar',
    'Variante de coger: aanpakken'
)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%📊 El paradigma de pakken%';

-- =============================================================================
-- 8. Bloque compartido C: el paradigma de nemen (fuerte).
--    A las 3 tarjetas de nemen / meenemen.
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

📊 El paradigma de nemen (fuerte, y ojo que el imperfecto no se parece nada):

| persona | presente | imperfecto |
|---|---|---|
| ik | neem | nam |
| jij / je | neemt | nam |
| u | neemt | nam |
| hij / zij / het | neemt | nam |
| wij | nemen | namen |
| jullie | nemen | namen |
| zij (plural) | nemen | namen |

• participio — genomen, con hebben. En los separables el ge- va dentro: meegenomen, opgenomen, aangenomen.
• el cambio de vocal es ee → a → o: nemen, nam, genomen. Es el mismo patron que komen (kwam, gekomen).
• al invertir, jij pierde la -t: Neem jij de trein? — nunca "neemt jij".
• ojo a la ortografia, que cambia de ee a e: neem en singular, nemen en plural. La silaba abierta ya alarga la vocal sola.
• preposicion — transitivo directo. Con destino, mee naar: Neem het mee naar huis.'
WHERE notes IN (
    'Variante de coger: nemen transporte',
    'Variante de coger: nemen expresion',
    'Variante de coger: meenemen'
)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%📊 El paradigma de nemen%';
