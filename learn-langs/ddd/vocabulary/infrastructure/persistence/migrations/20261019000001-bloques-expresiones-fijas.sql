-- Learn Languages App - Migration
-- Migration: 20261019000001-bloques-expresiones-fijas
-- Description: Eduardo, sobre la 899 (Ik ben het min of meer met je eens): "fijate en 899 ahi
--   la expresion que se usa es «het eens zijn met» luego, en todas las frases donde estemos
--   usando expresiones fijas debemos ponerlo en la ayuda".
--
--   La 899 explicaba min of meer y despachaba «het eens zijn met» en media linea. Barrido de
--   las 1039 frases (SENTENCE + PHRASE) con ~95 patrones de expresion fija: muchas solo llevaban
--   el generico «📐 Frase hecha: orden fijo, se memoriza tal cual», que no explica nada, y 17
--   no tenian ayuda (grupo de paises y cuatro del floor-regla37).
--
--   1. Un bloque compartido «🧩 Expresión fija — <expresion>» por expresion (§3.3, byte a byte,
--      el rotulo es el guard): literal, significado, piezas fijas, tabla de ejemplos, variantes
--      o contrario y 🔑 truco. 37 bloques.
--   2. Se anexa a las tarjetas con ayuda (AND rules_help IS NOT NULL) y, a las que no tenian,
--      se les crea la ayuda entera con su primera linea + el bloque (§5.4).
--   3. 899: la media linea pasa a remitir al bloque, y tres frases nuevas cuelgan de ella
--      (EXAMPLE): daar … mee eens (inv), het eens zijn over, het eens worden. Grupo 28 + generic.
--   Se dejan fuera las que ya explicaban su expresion (264, 1085, 921, 862, 547, 1088-1090, 676,
--   629, 266, 232, 971, 1076, 972, 598, 1047, 243, 714, 715...).

PRAGMA foreign_keys = ON;

-- 🧩 het eens zijn met iemand
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — het eens zijn met iemand:

• literal — «serlo uno con alguien»: eens es aquí «de una sola opinión», no «una vez».
• significa — estar de acuerdo con alguien.
• piezas fijas — het (no se quita ni se cambia por dat), met + la persona, y eens siempre al FINAL de su bloque.

| # | dónde | qué pasa | ejemplo |
|---|---|---|---|
| 1 | principal | zijn en 2ª posición, eens al final | Ik **ben het** met je **eens**. |
| 2 | negación | niet delante de met | Ik **ben het** niet met je **eens**. |
| 3 | perfecto | geweest detrás de eens, con zijn | Ik **ben het** nooit met hem **eens geweest**. |
| 4 | subordinada | eens + verbo, juntos al final | … omdat ik het met je **eens ben**. |
| 5 | con te | el te entre eens y zijn | Het is moeilijk om het met hem **eens te zijn**. |
| 6 | con una cosa | met + cosa se vuelve ermee / daarmee, partido | Ik **ben het ermee eens**. · **Daar** ben ik het **mee eens**. |

• het oneens zijn met — estar en desacuerdo. We zijn het over bijna alles oneens.
• het eens worden — ponerse de acuerdo. Zijn jullie het al eens geworden?
• over — el tema del acuerdo. We zijn het eens over de prijs.
• helemaal — totalmente. Ik ben het helemaal met je eens.
• sustantivos — de overeenstemming (el acuerdo, la sintonía) y het akkoord (el acuerdo cerrado). Akkoord! = ¡de acuerdo!

🔑 El truco que casi nunca falla: estar de acuerdo es un sándwich de tres piezas, HET detrás del verbo, MET + persona en medio y EENS cerrando. Si falta het o eens no va al final, está mal.

⚠️ Akkoord gaan met es aceptar una propuesta (Ik ga akkoord met het voorstel), no compartir la opinión de alguien. «Ik ben akkoord met je» se oye en Bélgica, en Países Bajos suena raro.', updated_at = datetime('now')
WHERE id IN (899) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — het eens zijn met iemand:%';

-- 🧩 zin hebben in
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — zin hebben in:

• literal — «tener ganas en»: de zin es aquí las ganas (también la frase y el sentido).
• significa — apetecer, tener ganas de.
• piezas fijas — hebben, zin SIN artículo, e IN delante de la cosa. Con un verbo pasa a om te.

| # | molde | ejemplo | español |
|---|---|---|---|
| 1 | zin in + cosa | Ik heb **zin in** koffie. | Me apetece un café. |
| 2 | er … in, la cosa ya se sabe | Ik heb **er** geen zin **in**. | No me apetece nada. |
| 3 | nergens … in | Ik heb **nergens** zin **in**. | No me apetece nada de nada. |
| 4 | zin om te + verbo | Heb je **zin om** mee **te** gaan? | ¿Te apetece venir? |
| 5 | subordinada | … dat ze **er** echt **zin in** had. | … que tenía muchas ganas. |

• En negativo es geen, porque zin es sustantivo — Ik heb geen zin in de les, nunca «niet zin».
• Contrario fuerte — er een hekel aan hebben (odiarlo).

🔑 El truco que casi nunca falla: si lo que apetece es una COSA, in; si es una ACCIÓN, om te. Y si la cosa ya se ha dicho, er delante y el in al final.', updated_at = datetime('now')
WHERE id IN (448, 449, 450, 451, 907, 1396) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — zin hebben in:%';

-- 🧩 er iets of niets aan doen
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — er iets of niets aan doen:

• literal — «hacer algo en ello».
• significa — iets aan iets doen es hacer algo al respecto, ponerle remedio. Con kunnen y niets, er niets aan kunnen doen es no poder evitarlo, no tener la culpa.
• piezas fijas — doen + AAN. La cosa se esconde en er (o daar con énfasis) y el aan se queda al final, delante de los verbos.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | remediar | We moeten **er** iets **aan** doen. | Tenemos que hacer algo al respecto. |
| 2 | pregunta | Kun je **er** iets **aan** doen? | ¿Puedes hacer algo? |
| 3 | no es culpa mía | Ik kan **er** niets **aan** doen. | No lo puedo evitar. |
| 4 | con énfasis | **Daar** kan ik niets **aan** doen. | Eso no está en mi mano. |
| 5 | subordinada | … dat hij **er** niets **aan** kan doen. | … que él no puede evitarlo. |
| 6 | con la cosa dicha | Ik kan niets **aan** het weer doen. | No puedo hacer nada contra el tiempo. |

• No confundir con er niets aan vinden (no verle la gracia) ni con iemand iets aandoen (hacerle daño a alguien).

🔑 El truco que casi nunca falla: si en español cabe «al respecto» o «no es culpa mía», es iets of niets aan doen, con el aan pegado al final como el de zin in.', updated_at = datetime('now')
WHERE id IN (265, 452, 453, 454, 455) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — er iets of niets aan doen:%';

-- 🧩 er is iets aan de hand
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — er is iets aan de hand:

• literal — «hay algo en la mano».
• significa — pasar algo, haber un problema. Wat is er aan de hand? = ¿qué pasa?
• piezas fijas — er + zijn + aan de hand, siempre con de. El er es de relleno, porque lo que pasa (iets, wat, niets) va detrás o es la pregunta.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pregunta | Wat is er **aan de hand**? | ¿Qué pasa? |
| 2 | afirmación | Er is iets **aan de hand**. | Pasa algo. |
| 3 | negación | Er is niets **aan de hand**. | No pasa nada. |
| 4 | inversión | Buiten is er iets **aan de hand**. | Fuera pasa algo. |
| 5 | subordinada | … wat er **aan de hand** is. | … qué pasa. |
| 6 | con persona | Wat is er met hem **aan de hand**? | ¿Qué le pasa? |

• Versión corta — Wat is er? (¿qué te pasa?). Para un suceso cualquiera, sin problema detrás — Wat gebeurt er?

🔑 El truco que casi nunca falla: si el «pasa» del español huele a problema o a algo raro, es aan de hand; si es un suceso sin más, gebeuren.', updated_at = datetime('now')
WHERE id IN (259, 429, 430, 431, 432, 905) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — er is iets aan de hand:%';

-- 🧩 zich zorgen maken over
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — zich zorgen maken over:

• literal — «hacerse preocupaciones»: de zorg (la preocupación, y también el cuidado), en plural.
• significa — preocuparse por algo.
• piezas fijas — reflexivo (me, je, zich…), zorgen en plural y sin artículo, y OVER para el motivo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo negativo | Maak **je** geen **zorgen**. | No te preocupes. |
| 2 | presente | Ik maak **me zorgen over** jou. | Me preocupo por ti. |
| 3 | perfecto | Ze heeft **zich** veel **zorgen** gemaakt. | Se ha preocupado mucho. |
| 4 | con hoeven | Je hoeft **je** geen **zorgen** te maken. | No hace falta que te preocupes. |
| 5 | con cosa sabida | Ik maak me **er** zorgen **over**. | Eso me preocupa. |

• geen y no niet — zorgen es sustantivo y se niega con geen.
• Falso primo — zorgen voor es cuidar de, encargarse (Ik zorg voor de kinderen). Sin zich y con voor ya no es preocuparse.

🔑 El truco que casi nunca falla: preocuparse lleva ZICH y OVER; cuidar lleva VOOR y no lleva zich.', updated_at = datetime('now')
WHERE id IN (798) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — zich zorgen maken over:%';

-- 🧩 op tijd
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — op tijd:

• literal — «sobre tiempo».
• significa — puntual, a tiempo, a su hora.
• piezas fijas — OP y tijd sin artículo. Nunca «in tijd» ni «op de tijd».

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | ser puntual | Duitsers komen altijd **op tijd**. | Los alemanes siempre llegan puntuales. |
| 2 | llegar a tiempo | Ik ben **op tijd**. | Llego a tiempo. |
| 3 | finalidad | … zodat ze **op tijd** opstaat. | … para levantarse a su hora. |
| 4 | contrario | Hij komt altijd **te laat**. | Siempre llega tarde. |
| 5 | con margen | We waren **ruim op tijd**. | Llegamos con tiempo de sobra. |

• op tijd ↔ te laat — el contrario natural es te laat, con te.
• Familia de op + sustantivo pelado — op tijd, op straat, op school, op vakantie. Preposición fija y sin artículo, se aprenden enteras.
• No es de tijd, el tiempo de reloj — Ik heb geen tijd.

🔑 El truco que casi nunca falla: si en español dices «puntual» o «a tiempo», es op tijd, y su contrario es te laat.', updated_at = datetime('now')
WHERE id IN (518, 681, 798) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — op tijd:%';

UPDATE words_es SET rules_help = 'OP TIJD KOMEN = llegar puntual. Ze zegt dat Duitsers altijd op tijd komen va en subordinada con dat, así que el verbo conjugado (komen) se va al final.' || char(10) || char(10) || '🧩 Expresión fija — op tijd:

• literal — «sobre tiempo».
• significa — puntual, a tiempo, a su hora.
• piezas fijas — OP y tijd sin artículo. Nunca «in tijd» ni «op de tijd».

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | ser puntual | Duitsers komen altijd **op tijd**. | Los alemanes siempre llegan puntuales. |
| 2 | llegar a tiempo | Ik ben **op tijd**. | Llego a tiempo. |
| 3 | finalidad | … zodat ze **op tijd** opstaat. | … para levantarse a su hora. |
| 4 | contrario | Hij komt altijd **te laat**. | Siempre llega tarde. |
| 5 | con margen | We waren **ruim op tijd**. | Llegamos con tiempo de sobra. |

• op tijd ↔ te laat — el contrario natural es te laat, con te.
• Familia de op + sustantivo pelado — op tijd, op straat, op school, op vakantie. Preposición fija y sin artículo, se aprenden enteras.
• No es de tijd, el tiempo de reloj — Ik heb geen tijd.

🔑 El truco que casi nunca falla: si en español dices «puntual» o «a tiempo», es op tijd, y su contrario es te laat.', updated_at = datetime('now')
WHERE id = 1241 AND rules_help IS NULL;

-- 🧩 in de file staan
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — in de file staan:

• literal — «estar de pie en la fila»: de file es el atasco (del francés, fila).
• significa — estar en un atasco.
• piezas fijas — IN de file, con artículo, y el verbo es STAAN, no zijn ni zitten. Perfecto con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | presente | Ik sta **in de file**. | Estoy en un atasco. |
| 2 | suposición | Ze zal wel **in de file staan**. | Estará en un atasco. |
| 3 | perfecto | We hebben uren **in de file gestaan**. | Hemos estado horas en un atasco. |
| 4 | subordinada | … omdat ik **in de file stond**. | … porque estaba en un atasco. |

• de file — la e final suena, y el plural es de files.
• staan es aquí estar parado, como el coche — el mismo de Het huis staat te koop.

🔑 El truco que casi nunca falla: en un atasco el coche no anda, está de pie, así que STAAN.', updated_at = datetime('now')
WHERE id IN (305) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — in de file staan:%';

-- 🧩 verliefd worden op
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — verliefd worden op:

• literal — «volverse enamorado sobre».
• significa — enamorarse de alguien o de algo.
• piezas fijas — verliefd es adjetivo, así que lo lleva worden (el paso) o zijn (el estado). Y de quien te enamoras va con OP, nunca con van.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | el paso, worden | Ze werd **verliefd op** hem. | Se enamoró de él. |
| 2 | el estado, zijn | Ik ben **verliefd op** haar. | Estoy enamorado de ella. |
| 3 | perfecto de worden | We zijn **verliefd geworden op** de Italiaanse keuken. | Nos hemos enamorado de la cocina italiana. |
| 4 | perfecto de zijn | Ben je ooit **verliefd geweest**? | ¿Te has enamorado alguna vez? |

• worden ↔ zijn — worden es el momento (enamorarse), zijn el estado (estar enamorado). Los dos hacen el perfecto con zijn: is verliefd geworden, is verliefd geweest.
• sustantivos — de verliefdheid (el enamoramiento) y de liefde (el amor).

🔑 El truco que casi nunca falla: los sentimientos hacia alguien van con OP, como boos op, trots op, dol op. Te enamoras encima de alguien.', updated_at = datetime('now')
WHERE id IN (392, 688) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — verliefd worden op:%';

UPDATE words_es SET rules_help = 'VERLIEFD WORDEN OP = enamorarse de. Perfecto de worden con zijn, y op delante de lo amado: We zijn verliefd geworden op de Italiaanse keuken.' || char(10) || char(10) || '🧩 Expresión fija — verliefd worden op:

• literal — «volverse enamorado sobre».
• significa — enamorarse de alguien o de algo.
• piezas fijas — verliefd es adjetivo, así que lo lleva worden (el paso) o zijn (el estado). Y de quien te enamoras va con OP, nunca con van.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | el paso, worden | Ze werd **verliefd op** hem. | Se enamoró de él. |
| 2 | el estado, zijn | Ik ben **verliefd op** haar. | Estoy enamorado de ella. |
| 3 | perfecto de worden | We zijn **verliefd geworden op** de Italiaanse keuken. | Nos hemos enamorado de la cocina italiana. |
| 4 | perfecto de zijn | Ben je ooit **verliefd geweest**? | ¿Te has enamorado alguna vez? |

• worden ↔ zijn — worden es el momento (enamorarse), zijn el estado (estar enamorado). Los dos hacen el perfecto con zijn: is verliefd geworden, is verliefd geweest.
• sustantivos — de verliefdheid (el enamoramiento) y de liefde (el amor).

🔑 El truco que casi nunca falla: los sentimientos hacia alguien van con OP, como boos op, trots op, dol op. Te enamoras encima de alguien.', updated_at = datetime('now')
WHERE id = 1250 AND rules_help IS NULL;

-- 🧩 hoe gaat het ermee, hoe staat het ermee
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — hoe gaat het ermee, hoe staat het ermee:

• literal — «cómo va ello con eso»: ermee = met + lo que ya se sabe.
• significa — ¿qué tal va?, ¿cómo va la cosa? Hoe staat het ermee? pregunta más por el estado del asunto.
• piezas fijas — het impersonal de sujeto y ermee al final. Con persona es met + persona, sin er.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pregunta | Hoe **gaat het ermee**? | ¿Qué tal va eso? |
| 2 | estado del asunto | Hoe **staat het ermee**? | ¿Cómo está la cosa? |
| 3 | respuesta | Het gaat **er** goed **mee**. | Va bien. |
| 4 | indirecta | Ze vroeg hoe het **ermee** ging. | Preguntó qué tal iba. |
| 5 | con persona | Hoe **gaat het met** je moeder? | ¿Qué tal tu madre? |

• ermee va junto al final de la pregunta, y se parte (er … mee) cuando algo se mete en medio — Het gaat er goed mee.
• Respuestas típicas — Goed, hoor. · Het gaat wel. (tirando) · Niet zo best. (no muy bien)

🔑 El truco que casi nunca falla: si preguntas por una persona, met + persona; si es por un asunto que ya se sabe, ermee.', updated_at = datetime('now')
WHERE id IN (456, 457, 459) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — hoe gaat het ermee, hoe staat het ermee:%';

-- 🧩 ervoor gaan, ertegenaan gaan, erop of eronder
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — ervoor gaan, ertegenaan gaan, erop of eronder:

• ervoor gaan — ir a por ello. Ga ervoor! = ¡a por ello! Con vol, a tope — Ik ga er vol voor.
• ertegenaan gaan — lanzarse, darlo todo (literal, ir contra ello). We gaan ertegenaan!
• erop of eronder — o todo o nada (literal, encima o debajo), antes de algo decisivo.
• piezas fijas — er + preposición, con un er vacío que no apunta a nada concreto. Por eso aquí no vale daar.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Kom op, **ga ervoor**! | ¡Venga, a por ello! |
| 2 | con vol, partido | Ik **ga er** vol **voor**. | Voy a por ello con todo. |
| 3 | subordinada | … dat we **ertegenaan** moeten. | … que tenemos que darlo todo. |
| 4 | exclamación | **Erop of eronder**! | ¡O todo o nada! |
| 5 | nosotros | We **gaan ertegenaan**! | ¡Vamos a por todas! |

🔑 El truco que casi nunca falla: son gritos de ánimo y el er no se traduce. Si algo se mete entre er y la preposición (vol, echt), la preposición se va al final — Ik ga er echt voor.', updated_at = datetime('now')
WHERE id IN (268, 464, 465, 466, 467) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — ervoor gaan, ertegenaan gaan, erop of eronder:%';

-- 🧩 af en toe, zo nu en dan
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — af en toe, zo nu en dan:

• literal — af en toe es «abierto y cerrado», como una puerta que va y viene; zo nu en dan, «así ahora y entonces».
• significa — de vez en cuando. Valen igual; zo nu en dan suena algo más a narración.
• piezas fijas — el orden no se toca, nunca «toe en af» ni «dan en nu».

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | en medio | Ik drink **af en toe** een biertje. | Me tomo una cerveza de vez en cuando. |
| 2 | delante, con inversión | **Af en toe** bel ik mijn oma. | De vez en cuando llamo a mi abuela. |
| 3 | pregunta | Sport je **af en toe**? | ¿Haces deporte de vez en cuando? |
| 4 | variante | **Zo nu en dan** doe ik een dutje. | De vez en cuando echo una cabezada. |

🪜 La escalera de la frecuencia — altijd → meestal → vaak → regelmatig → soms → af en toe → zelden → nooit.
• een dutje doen — echar una cabezada, otra fija. El verbo es doen.

🔑 El truco que casi nunca falla: af en toe va en la casilla de soms. Donde cabe soms, cabe af en toe, un pelo menos frecuente.', updated_at = datetime('now')
WHERE id IN (405, 406, 407, 408, 409) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — af en toe, zo nu en dan:%';

-- 🧩 aan iemand liggen
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — aan iemand liggen:

• literal — «estar tumbado en alguien».
• significa — ser culpa de alguien, deberse a algo.
• piezas fijas — sujeto het (o dat), verbo liggen y la persona o la causa con AAN.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | culpa | Het ligt **aan** mij. | Es culpa mía. |
| 2 | negación | Het ligt niet **aan** jou. | No es culpa tuya. |
| 3 | ironía con zal wel | Het zal wel weer **aan** mij **liggen**. | Ya será otra vez culpa mía. |
| 4 | pregunta | **Waar** ligt het **aan**? | ¿A qué se debe? |
| 5 | con cosa | Dat ligt **aan** de computer. | Es cosa del ordenador. |

• Hermana — het hangt ervan af (depende), de afhangen van.

🔑 El truco que casi nunca falla: si en español cabe «es por…» o «es culpa de…», el neerlandés lo tumba encima, het ligt aan.', updated_at = datetime('now')
WHERE id IN (304) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — aan iemand liggen:%';

-- 🧩 het spijt me
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — het spijt me:

• literal — «ello me pesa»: spijten es lamentar, y quien lo siente va de objeto (me), como en «me pesa».
• significa — lo siento.
• piezas fijas — sujeto het y la persona como objeto, het spijt me, het spijt ons. Nunca «ik spijt».

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | disculpa | **Het spijt me**. | Lo siento. |
| 2 | con motivo | **Het spijt me** dat ik te laat ben. | Siento llegar tarde. |
| 3 | plural | **Het spijt ons** heel erg. | Lo sentimos muchísimo. |
| 4 | pasado | **Het speet** haar. | Ella lo sintió. |
| 5 | arrepentirse | Ik heb er **spijt van**. | Me arrepiento. |

• spijt hebben van — arrepentirse de, con el sustantivo de spijt. Ik heb spijt van wat ik zei.
• Más ligero — Sorry. Más formal — Mijn excuses.
• Conjugación — spijten es fuerte (het spijt, het speet, het heeft gespeten) y casi solo vive en tercera persona.

🔑 El truco que casi nunca falla: piensa en «me pesa». Quien lo siente es el objeto, así que siempre het spijt + me, je, hem, ons.', updated_at = datetime('now')
WHERE id IN (546) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — het spijt me:%';

-- 🧩 iets vinden van, er niets aan vinden
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — iets vinden van, er niets aan vinden:

• iets vinden van — opinar de algo. Wat vind je ervan? = ¿qué te parece?
• er niets aan vinden — no verle la gracia. Ik vind er niets aan = no le veo la gracia.
• piezas fijas — la opinión va con VAN y la gracia con AAN. Las dos con er cuando la cosa ya se sabe.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | opinión, cosa dicha | Wat vond je **van** de film? | ¿Qué te pareció la peli? |
| 2 | opinión, cosa sabida | Wat vind je **ervan**? | ¿Qué te parece? |
| 3 | imperativo | Zeg eens wat je **ervan** vindt. | Di qué te parece. |
| 4 | sin gracia | Ik vind **er** niets **aan**. | No le veo la gracia. |
| 5 | con algo de gracia | Ik vind **er** wel iets **aan**. | Algo tiene. |

• Y el gusto directo va sin preposición — Ik vind het leuk, lekker, mooi.

🔑 El truco que casi nunca falla: VAN para opinar (¿qué te parece?), AAN para la gracia (no le veo nada).', updated_at = datetime('now')
WHERE id IN (263, 444, 445, 447) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — iets vinden van, er niets aan vinden:%';

-- 🧩 bezig zijn met
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — bezig zijn met:

• literal — «estar ocupado con».
• significa — estar haciendo algo, estar liado con algo.
• piezas fijas — zijn + bezig (adjetivo) + MET la tarea. Con la tarea ya sabida, ermee o er … mee.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | tarea dicha | Ik ben **bezig met** mijn huiswerk. | Estoy con los deberes. |
| 2 | tarea sabida | Ik ben **er** druk **mee bezig**. | Estoy muy liado con ello. |
| 3 | pregunta | **Waar** ben je **mee bezig**? | ¿Qué estás haciendo? |
| 4 | sin tarea | … nu je toch **bezig** bent. | … ya que estás en ello. |
| 5 | con te | Ik ben **bezig** het huis **te** verven. | Estoy pintando la casa. |

• druk bezig — muy liado, con druk de intensificador fijo.
• nu je toch bezig bent — ya que estás, otra fija entera.
• Hermana — aan het + infinitivo (Ik ben aan het koken) es más neutra; bezig subraya que estás en faena.

🔑 El truco que casi nunca falla: si en español dices «estoy con…» o «estoy liado con…», es bezig zijn met.', updated_at = datetime('now')
WHERE id IN (458, 804) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — bezig zijn met:%';

-- 🧩 iets nodig hebben
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — iets nodig hebben:

• literal — «tener algo necesario».
• significa — necesitar algo.
• piezas fijas — hebben conjugado, la cosa de objeto, y nodig casi al final, delante de los demás verbos.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik **heb** je hulp **nodig**. | Necesito tu ayuda. |
| 2 | relativa | Alles wat je **nodig hebt**, ligt klaar. | Todo lo que necesitas está preparado. |
| 3 | pregunta | Waar **heb** je mijn auto voor **nodig**? | ¿Para qué necesitas mi coche? |
| 4 | negación | Ik **heb** het niet meer **nodig**. | Ya no lo necesito. |
| 5 | impersonal | Dat is niet **nodig**. | No hace falta. |

• Sin persona — het is nodig (hace falta), niet nodig (no hace falta).
• Falso primo — uitnodigen (invitar) no tiene nada que ver.

🔑 El truco que casi nunca falla: «necesito X» se dice «tengo X necesario», con HEBBEN delante, NODIG detrás y la cosa en medio.', updated_at = datetime('now')
WHERE id IN (341) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — iets nodig hebben:%';

-- 🧩 de tafel dekken
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — de tafel dekken:

• literal — «cubrir la mesa»: dekken es cubrir, como el mantel.
• significa — poner la mesa.
• piezas fijas — el verbo es DEKKEN, nunca zetten ni leggen. El contrario es de tafel afruimen, quitar la mesa.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | presente | Ik **dek** de tafel. | Pongo la mesa. |
| 2 | subordinada | … terwijl zij de tafel **dekt**. | … mientras ella pone la mesa. |
| 3 | imperativo | **Dek** de tafel even. | Pon la mesa. |
| 4 | perfecto | Heb je de tafel al **gedekt**? | ¿Ya has puesto la mesa? |
| 5 | contrario | Wie **ruimt** de tafel **af**? | ¿Quién quita la mesa? |

• Conjugación — dekken es débil, dek / dekte / gedekt, con hebben.
• Familia — het dekbed (el edredón), de deken (la manta), bedekken (cubrir). Todo es tapar.

🔑 El truco que casi nunca falla: la mesa no se pone, se TAPA con el mantel, así que dekken.', updated_at = datetime('now')
WHERE id IN (511) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — de tafel dekken:%';

-- 🧩 van plaats wisselen
UPDATE words_es SET rules_help = 'VAN PLAATS WISSELEN = cambiarse de sitio. Perfecto con hebben: We hebben van plaats gewisseld.' || char(10) || char(10) || '🧩 Expresión fija — van plaats wisselen:

• literal — «cambiar de sitio», como en español, pero con VAN y plaats sin artículo.
• significa — cambiarse de sitio, intercambiar los puestos.
• piezas fijas — van + plaats pelado; con alguien, met.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pasado | We hebben **van plaats gewisseld**. | Cambiamos de sitio. |
| 2 | con alguien | Wil je **van plaats** met me **wisselen**? | ¿Me cambias el sitio? |
| 3 | presente | Ze **wisselen** elke week **van plaats**. | Cambian de sitio cada semana. |

• El mismo molde — van baan wisselen (cambiar de trabajo), van gedachten wisselen (intercambiar ideas).
• Conjugación — wisselen es débil, wissel / wisselde / gewisseld, con hebben.

🔑 El truco que casi nunca falla: cambiar DE algo es van + sustantivo sin artículo, igual que en español.', updated_at = datetime('now')
WHERE id = 865 AND rules_help IS NULL;

-- 🧩 met pensioen gaan
UPDATE words_es SET rules_help = 'MET PENSIOEN GAAN = jubilarse. Con als + presente para el futuro: als we met pensioen gaan = cuando nos jubilemos.' || char(10) || char(10) || '🧩 Expresión fija — met pensioen gaan:

• literal — «irse con pensión».
• significa — jubilarse.
• piezas fijas — met + pensioen sin artículo y el verbo gaan. El estado es met pensioen zijn, estar jubilado.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | futuro con als | … als we **met pensioen gaan**. | … cuando nos jubilemos. |
| 2 | estado | Mijn vader **is met pensioen**. | Mi padre está jubilado. |
| 3 | perfecto, con zijn | Ze **is** vorig jaar **met pensioen gegaan**. | Se jubiló el año pasado. |
| 4 | pregunta | Wanneer **ga** je **met pensioen**? | ¿Cuándo te jubilas? |

• Sustantivos — het pensioen (la pensión, la jubilación) y de gepensioneerde (el jubilado).

🔑 El truco que casi nunca falla: el subjuntivo español (cuando nos jubilemos) es presente en neerlandés, als + presente.', updated_at = datetime('now')
WHERE id = 1300 AND rules_help IS NULL;

-- 🧩 bevriend raken met
UPDATE words_es SET rules_help = 'BEVRIEND RAKEN MET = hacerse amigo de. raken es llegar a un estado sin buscarlo, así que el perfecto va con zijn: is bevriend geraakt.' || char(10) || char(10) || '🧩 Expresión fija — bevriend raken met:

• literal — «llegar a amigado con».
• significa — hacerse amigo de alguien.
• piezas fijas — bevriend (adjetivo) + raken (llegar a un estado) + MET la persona. El estado es bevriend zijn met.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto, con zijn | Mijn zoon **is bevriend geraakt met** een Japanner. | Mi hijo se ha hecho amigo de un japonés. |
| 2 | estado | Ik **ben** al jaren **bevriend met** haar. | Soy amigo suyo desde hace años. |
| 3 | pasado | We **raakten** snel **bevriend**. | Nos hicimos amigos enseguida. |

• raken — llegar a un estado sin buscarlo: verliefd raken, gewond raken (herirse), kwijtraken (perder). Perfecto siempre con zijn.

🔑 El truco que casi nunca falla: «hacerse» + un estado que te pasa es raken, y con amigos, bevriend raken met.', updated_at = datetime('now')
WHERE id = 1296 AND rules_help IS NULL;

-- 🧩 te koop staan
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — te koop staan:

• literal — «estar de pie para la venta».
• significa — estar en venta.
• piezas fijas — te + koop (la compra) y el verbo staan. Igual te huur staan, estar en alquiler.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | presente | Het huis **staat te koop**. | La casa está en venta. |
| 2 | alquiler | Het appartement **staat te huur**. | El piso está en alquiler. |
| 3 | perfecto | Het **heeft** lang **te koop gestaan**. | Ha estado mucho tiempo en venta. |
| 4 | poner en venta | Ze **zetten** hun huis **te koop**. | Ponen su casa en venta. |
| 5 | cartel | **Te koop** | Se vende |

🔑 El truco que casi nunca falla: poner en venta es zetten y estar en venta es staan, la misma pareja de Zet de vaas op tafel y De vaas staat op tafel.', updated_at = datetime('now')
WHERE id IN (1067) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — te koop staan:%';

-- 🧩 bij de Chinees eten
UPDATE words_es SET rules_help = 'BIJ DE CHINEES ETEN = cenar en el chino. Con de + gentilicio de persona se nombra el restaurante: bij de Chinees, bij de Italiaan, bij de Turk.' || char(10) || char(10) || '🧩 Expresión fija — bij de Chinees eten:

• literal — «comer en casa del chino».
• significa — comer en el restaurante chino.
• piezas fijas — BIJ (en casa de) + de + el gentilicio de persona, en singular. Nunca «in de Chinees».

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | cenar fuera | Vanavond eten we **bij de Chinees**. | Esta noche cenamos en el chino. |
| 2 | ir | Zullen we **naar de Italiaan** gaan? | ¿Vamos al italiano? |
| 3 | para llevar | Ik haal eten **bij de Turk**. | Compro comida en el turco. |
| 4 | con restaurante | Op zondag eten we **in een Turks restaurant**. | Los domingos comemos en un restaurante turco. |

• Con bij estás en el sitio y con naar vas al sitio — bij de Chinees eten, naar de Chinees gaan.
• Es el molde de bij de bakker y bij de dokter: el sitio por la persona que lo lleva.

🔑 El truco que casi nunca falla: si en español dices «el chino» o «el italiano» por el restaurante, el neerlandés nombra a la persona, de Chinees, de Italiaan, con bij delante.', updated_at = datetime('now')
WHERE id = 1294 AND rules_help IS NULL;

-- 🧩 het druk hebben
UPDATE words_es SET rules_help = 'HET DRUK HEBBEN = estar liado. Con el het fijo y el comparativo en su sitio: Deze week heb ik het drukker dan ooit.' || char(10) || char(10) || '🧩 Expresión fija — het druk hebben:

• literal — «tenerlo apretado».
• significa — estar liado, tener mucho lío.
• piezas fijas — HEBBEN con un het vacío y el adjetivo detrás. Es el molde de het koud hebben (tener frío) y het warm hebben (tener calor).

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | presente | Ik **heb het druk**. | Estoy liado. |
| 2 | comparativo | Deze week **heb** ik **het drukker** dan ooit. | Esta semana estoy más liado que nunca. |
| 3 | pregunta | **Heb** je **het druk**? | ¿Estás liado? |
| 4 | pasado | We **hadden het** erg **druk**. | Estuvimos muy liados. |
| 5 | frío | Ik **heb het koud**. | Tengo frío. |

• druk sin persona describe un sitio — Het is druk in de winkel (hay mucha gente en la tienda).

🔑 El truco que casi nunca falla: cómo te encuentras tú (liado, frío, calor) es het + adjetivo + hebben; cómo está un sitio es het is + adjetivo.', updated_at = datetime('now')
WHERE id = 1387 AND rules_help IS NULL;

-- 🧩 exclamaciones y muletillas hechas
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — exclamaciones y muletillas hechas:

Se dicen enteras y sin tocar nada; ninguna se traduce palabra por palabra.

| # | expresión | literal | significa | cuándo |
|---|---|---|---|---|
| 1 | **Alles kits?** | ¿todo kits? | ¿todo bien?, ¿qué tal? | saludo coloquial entre amigos; se responde Kits! |
| 2 | **Nou en of!** | ¡pues y si! | ¡ya lo creo!, ¡y tanto! | un sí rotundo |
| 3 | **Maar goed…** | pero bien | en fin, bueno… | para cerrar un tema o resignarse |
| 4 | **Alles of niets!** | todo o nada | todo o nada | igual que en español |
| 5 | **Weet ik veel** | sé yo mucho | ¡qué sé yo!, ni idea | con el verbo delante, fijo |
| 6 | **Rot op!** | ¡púdrete fuera! | ¡lárgate!, ¡déjame en paz! | grosero, de rotten (pudrirse) |

• Weet ik veel lleva el orden de pregunta pero se dice sin interrogación, igual que «¡qué sé yo!».
• Rot op es el imperativo de oprotten, separable — Hij is opgerot = se largó. Más suave, Laat me met rust.

🔑 El truco que casi nunca falla: ninguna se arma pieza a pieza. Se aprende la frase entera con su tono, como un gesto.', updated_at = datetime('now')
WHERE id IN (332, 337, 477, 482) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — exclamaciones y muletillas hechas:%';

UPDATE words_es SET rules_help = 'WEET IK VEEL = ¡qué sé yo! Frase hecha con el verbo delante, como en una pregunta, pero sin interrogación.' || char(10) || char(10) || '🧩 Expresión fija — exclamaciones y muletillas hechas:

Se dicen enteras y sin tocar nada; ninguna se traduce palabra por palabra.

| # | expresión | literal | significa | cuándo |
|---|---|---|---|---|
| 1 | **Alles kits?** | ¿todo kits? | ¿todo bien?, ¿qué tal? | saludo coloquial entre amigos; se responde Kits! |
| 2 | **Nou en of!** | ¡pues y si! | ¡ya lo creo!, ¡y tanto! | un sí rotundo |
| 3 | **Maar goed…** | pero bien | en fin, bueno… | para cerrar un tema o resignarse |
| 4 | **Alles of niets!** | todo o nada | todo o nada | igual que en español |
| 5 | **Weet ik veel** | sé yo mucho | ¡qué sé yo!, ni idea | con el verbo delante, fijo |
| 6 | **Rot op!** | ¡púdrete fuera! | ¡lárgate!, ¡déjame en paz! | grosero, de rotten (pudrirse) |

• Weet ik veel lleva el orden de pregunta pero se dice sin interrogación, igual que «¡qué sé yo!».
• Rot op es el imperativo de oprotten, separable — Hij is opgerot = se largó. Más suave, Laat me met rust.

🔑 El truco que casi nunca falla: ninguna se arma pieza a pieza. Se aprende la frase entera con su tono, como un gesto.', updated_at = datetime('now')
WHERE id = 135 AND rules_help IS NULL;

UPDATE words_es SET rules_help = 'ROT OP = ¡lárgate!, ¡déjame en paz! Imperativo grosero de oprotten, separable.' || char(10) || char(10) || '🧩 Expresión fija — exclamaciones y muletillas hechas:

Se dicen enteras y sin tocar nada; ninguna se traduce palabra por palabra.

| # | expresión | literal | significa | cuándo |
|---|---|---|---|---|
| 1 | **Alles kits?** | ¿todo kits? | ¿todo bien?, ¿qué tal? | saludo coloquial entre amigos; se responde Kits! |
| 2 | **Nou en of!** | ¡pues y si! | ¡ya lo creo!, ¡y tanto! | un sí rotundo |
| 3 | **Maar goed…** | pero bien | en fin, bueno… | para cerrar un tema o resignarse |
| 4 | **Alles of niets!** | todo o nada | todo o nada | igual que en español |
| 5 | **Weet ik veel** | sé yo mucho | ¡qué sé yo!, ni idea | con el verbo delante, fijo |
| 6 | **Rot op!** | ¡púdrete fuera! | ¡lárgate!, ¡déjame en paz! | grosero, de rotten (pudrirse) |

• Weet ik veel lleva el orden de pregunta pero se dice sin interrogación, igual que «¡qué sé yo!».
• Rot op es el imperativo de oprotten, separable — Hij is opgerot = se largó. Más suave, Laat me met rust.

🔑 El truco que casi nunca falla: ninguna se arma pieza a pieza. Se aprende la frase entera con su tono, como un gesto.', updated_at = datetime('now')
WHERE id = 140 AND rules_help IS NULL;

-- 🧩 in alle vroegte
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — in alle vroegte:

• literal — «en toda la tempranez»: de vroegte, de vroeg.
• significa — de madrugada, muy temprano.
• piezas fijas — in + alle + vroegte. vroegte casi no vive fuera de esta frase.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pasado | Hij stond **in alle vroegte** op. | Se levantó de madrugada. |
| 2 | delante | **In alle vroegte** vertrokken we. | Salimos muy temprano. |
| 3 | presente | Ik moet **in alle vroegte** weg. | Tengo que irme muy temprano. |

• Más normal en el día a día — heel vroeg, o ''s ochtends vroeg.
• Su familia — in alle rust (con toda tranquilidad), in alle stilte (en la intimidad). in + alle + sustantivo = con todo.

🔑 El truco que casi nunca falla: es registro algo literario. Si la oyes, entiéndela; para hablar, heel vroeg.', updated_at = datetime('now')
WHERE id IN (360) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — in alle vroegte:%';

-- 🧩 van alles
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — van alles:

• literal — «de todo».
• significa — de todo, toda clase de cosas.
• piezas fijas — van + alles, sin artículo, en la casilla del objeto.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Ik heb **van alles** geprobeerd. | He probado de todo. |
| 2 | hay | Er is **van alles** te doen. | Hay mil cosas que hacer. |
| 3 | pasado | Ze vertelde **van alles** over haar reis. | Contó de todo sobre su viaje. |

• Pariente — allerlei (toda clase de), delante de sustantivo: allerlei dingen.
• No es alles a secas — Ik heb alles geprobeerd = lo he probado TODO, sin dejar nada.

🔑 El truco que casi nunca falla: van alles es variado, mucho y distinto; alles es completo, sin excepción.', updated_at = datetime('now')
WHERE id IN (342) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — van alles:%';

-- 🧩 in de bus
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — in de bus:

• literal — «en el autobús», pero aquí de bus es de brievenbus, el buzón.
• significa — en el buzón. Reclame in de bus krijgen = recibir publicidad en el buzón.
• piezas fijas — in de bus, con de. La pegatina contra la publicidad dice NEE/NEE.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pasado | Ik kreeg allemaal reclame **in de bus**. | Me llegó un montón de publicidad al buzón. |
| 2 | presente | Er zit een brief **in de bus**. | Hay una carta en el buzón. |
| 3 | echar al correo | Ik doe de kaart **op de bus**. | Echo la postal al correo. |

• op de bus doen — echar al buzón de correos de la calle.
• allemaal + plural o incontable es «un montón de», sin valor de «todos» — allemaal troep, allemaal reclame.

🔑 El truco que casi nunca falla: si se habla de correo o de publicidad, de bus es el buzón, no el autobús.', updated_at = datetime('now')
WHERE id IN (352) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — in de bus:%';

-- 🧩 in de bouw werken
UPDATE words_es SET rules_help = 'IN DE BOUW WERKEN = trabajar en la construcción. de bouw es el sector entero, con su de.' || char(10) || char(10) || '🧩 Expresión fija — in de bouw werken:

• literal — «trabajar en la construcción»: de bouw, de bouwen (construir).
• significa — trabajar en el sector de la construcción.
• piezas fijas — IN + sector con artículo: in de bouw, in de zorg (sanidad y cuidados), in de horeca (hostelería), in het onderwijs (enseñanza).

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | presente | Veel Polen werken **in de bouw**. | Muchos polacos trabajan en la construcción. |
| 2 | sanidad | Mijn zus werkt **in de zorg**. | Mi hermana trabaja en sanidad. |
| 3 | hostelería | Hij heeft jaren **in de horeca** gewerkt. | Ha trabajado años en hostelería. |
| 4 | enseñanza | Ze werkt **in het onderwijs**. | Trabaja en la enseñanza. |

• La persona es de bouwvakker (el obrero) y el sitio de bouwplaats (la obra).

🔑 El truco que casi nunca falla: sector es in + de/het + sector; empresa concreta es bij, Ik werk bij Philips.', updated_at = datetime('now')
WHERE id = 1261 AND rules_help IS NULL;

-- 🧩 zich vergissen
UPDATE words_es SET rules_help = 'ZICH VERGISSEN = equivocarse. Reflexivo, con hebben y sin ge-: Ik heb me vergist.' || char(10) || char(10) || '🧩 Expresión fija — zich vergissen:

• literal — reflexivo, «equivocarse».
• significa — equivocarse, confundirse.
• piezas fijas — siempre con me, je, zich…, perfecto con HEBBEN y sin ge- (ver- es inseparable), vergist. Lo que confundes va con IN.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Ik **heb me vergist**. | Me he equivocado. |
| 2 | con in | Je **vergist je in** hem. | Te equivocas con él. |
| 3 | pasado | Ze **vergiste zich in** de datum. | Se equivocó de fecha. |
| 4 | condicional | Als ik **me** niet **vergis**, … | Si no me equivoco, … |

• Hermano — het mis hebben, estar equivocado en lo que piensas: Je hebt het mis.
• Contrario — gelijk hebben (tener razón).
• No es vergeten (olvidar).

🔑 El truco que casi nunca falla: fallar en un momento es zich vergissen; estar equivocado en una idea es het mis hebben.', updated_at = datetime('now')
WHERE id = 1262 AND rules_help IS NULL;

-- 🧩 zich vestigen in
UPDATE words_es SET rules_help = 'ZICH VESTIGEN IN = instalarse en un sitio. Reflexivo y con hebben: hebben zich gevestigd.' || char(10) || char(10) || '🧩 Expresión fija — zich vestigen in:

• literal — «establecerse en».
• significa — instalarse a vivir en un sitio; una empresa, tener allí su sede.
• piezas fijas — reflexivo, IN + el sitio, y perfecto con hebben: heeft zich gevestigd. vestigen no lleva prefijo átono, así que el participio sí lleva ge-.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Veel Oekraïners **hebben zich in** Nederland **gevestigd**. | Muchos ucranianos se han instalado en Países Bajos. |
| 2 | presente | Ze **vestigen zich in** Utrecht. | Se instalan en Utrecht. |
| 3 | empresa | Het bedrijf **is gevestigd in** Amsterdam. | La empresa tiene su sede en Ámsterdam. |

• Más coloquial — gaan wonen in (irse a vivir a).
• Sustantivo — de vestiging (la sucursal, la sede).

🔑 El truco que casi nunca falla: personas que se quedan a vivir, zich vestigen; empresas, gevestigd zijn.', updated_at = datetime('now')
WHERE id = 1269 AND rules_help IS NULL;

-- 🧩 iets serieus nemen
UPDATE words_es SET rules_help = 'IETS SERIEUS NEMEN = tomarse algo en serio. Sin zich y sin preposición: serieus va detrás del objeto.' || char(10) || char(10) || '🧩 Expresión fija — iets serieus nemen:

• literal — «tomar algo serio».
• significa — tomarse algo en serio.
• piezas fijas — nemen + objeto + serieus, sin reflexivo y sin preposición.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | presente | Argentijnen **nemen** voetbal heel **serieus**. | Los argentinos se toman el fútbol muy en serio. |
| 2 | negación | Hij **neemt** me niet **serieus**. | No me toma en serio. |
| 3 | imperativo | **Neem** het niet te **serieus**. | No te lo tomes tan en serio. |
| 4 | perfecto | Ze **heeft** het **serieus genomen**. | Se lo ha tomado en serio. |

• Conjugación — nemen es fuerte, neem / nam (wij namen) / genomen, con hebben.
• Cuando «serio» es grave, ernstig — een ernstig ongeluk.

🔑 El truco que casi nunca falla: el «se toma» español es reflexivo y el neerlandés no, nemen a secas.', updated_at = datetime('now')
WHERE id = 1281 AND rules_help IS NULL;

-- 🧩 lijken op
UPDATE words_es SET rules_help = 'LIJKEN OP = parecerse a. Con op, nunca con aan.' || char(10) || char(10) || '🧩 Expresión fija — lijken op:

• literal — «parecer sobre».
• significa — parecerse a alguien o algo.
• piezas fijas — lijken + OP. Sin op, lijken es parecer, dar la impresión — Het lijkt me een goed idee.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | persona | Je **lijkt op** je vader. | Te pareces a tu padre. |
| 2 | negación | Ze **lijken** helemaal niet **op** elkaar. | No se parecen nada. |
| 3 | pasado | Het **leek op** een droom. | Parecía un sueño. |
| 4 | er + op | Het **lijkt erop** dat het gaat regenen. | Parece que va a llover. |
| 5 | perfecto | Hij **heeft** altijd **op** zijn moeder **geleken**. | Siempre se ha parecido a su madre. |

• Conjugación — lijken es fuerte, lijk / leek (wij leken) / geleken, con hebben.
• Sustantivo — de gelijkenis (el parecido).

🔑 El truco que casi nunca falla: con OP es parecerse a alguien; sin preposición es parecer, dar la impresión.', updated_at = datetime('now')
WHERE id = 137 AND rules_help IS NULL;

-- 🧩 het goed bedoelen
UPDATE words_es SET rules_help = 'HET GOED BEDOELEN = tener buena intención. Con el het fijo: Hij bedoelt het goed.' || char(10) || char(10) || '🧩 Expresión fija — het goed bedoelen:

• literal — «quererlo decir bien»: bedoelen es querer decir, tener intención.
• significa — tener buena intención, hacerlo de buena fe.
• piezas fijas — un het vacío y goed (o slecht) en medio.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | presente | Hij **bedoelt het goed**. | Lo hace con buena intención. |
| 2 | perfecto | Ze **heeft het goed bedoeld**. | Lo hizo con buena intención. |
| 3 | negación | Ik **bedoelde het** niet zo. | No lo decía en ese sentido. |
| 4 | pregunta | Wat **bedoel** je? | ¿Qué quieres decir? |

• bedoelen es inseparable (be-), participio bedoeld sin ge- añadido; presente bedoel / bedoelt, pasado bedoelde.
• Sustantivo — de bedoeling (la intención). Dat is niet de bedoeling = esa no es la idea.

🔑 El truco que casi nunca falla: cuando alguien mete la pata con buena intención, hij bedoelt het goed.', updated_at = datetime('now')
WHERE id = 155 AND rules_help IS NULL;

-- 🧩 uit liefdadigheid
UPDATE words_es SET rules_help = 'UIT LIEFDADIGHEID = por caridad. El motivo interior va con uit, no con voor.' || char(10) || char(10) || '🧩 Expresión fija — uit liefdadigheid:

• literal — «de caridad»: de liefdadigheid, de liefde (amor) + de daad (el acto).
• significa — por caridad, por beneficencia.
• piezas fijas — UIT para el motivo interior y sin artículo, como uit liefde, uit angst, uit nieuwsgierigheid.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | caridad | Hij doet het **uit liefdadigheid**. | Lo hace por caridad. |
| 2 | amor | Ze deed het **uit liefde** (de liefde). | Lo hizo por amor. |
| 3 | curiosidad | Ik vraag het **uit nieuwsgierigheid**. | Lo pregunto por curiosidad. |
| 4 | miedo | Hij zei niets **uit angst**. | No dijo nada por miedo. |

• La causa benéfica es het goede doel — geld geven aan een goed doel.

🔑 El truco que casi nunca falla: por + sentimiento o motivo interior es uit; por + causa externa es door.', updated_at = datetime('now')
WHERE id = 144 AND rules_help IS NULL;

-- 🧩 zich aanpassen aan
UPDATE words_es SET rules_help = 'ZICH AANPASSEN AAN = adaptarse a. Reflexivo, separable y con hebben: Ik heb me aangepast.' || char(10) || char(10) || '🧩 Expresión fija — zich aanpassen aan:

• literal — «ajustarse a».
• significa — adaptarse a algo.
• piezas fijas — reflexivo, separable (aan-passen) y la cosa con un segundo AAN.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Ik **heb me** goed **aangepast aan** het Nederlandse leven. | Me he adaptado bien a la vida neerlandesa. |
| 2 | principal | Ze **past zich** snel **aan**. | Se adapta rápido. |
| 3 | modal | Ik moet **me** nog **aanpassen**. | Todavía me tengo que adaptar. |
| 4 | con te | Het is moeilijk om **je aan te passen**. | Es difícil adaptarse. |

• Dos aan seguidos, la partícula del verbo y la preposición — aangepast aan.
• Sustantivo — de aanpassing (la adaptación, el ajuste).

🔑 El truco que casi nunca falla: adaptarse es aanpassen con zich, y el «a» es aan otra vez.', updated_at = datetime('now')
WHERE id = 1236 AND rules_help IS NULL;

-- 🧩 zich thuis voelen
UPDATE words_es SET rules_help = 'ZICH THUIS VOELEN = sentirse en casa. Reflexivo, y con jij salen dos je: Voel je je al thuis?' || char(10) || char(10) || '🧩 Expresión fija — zich thuis voelen:

• literal — «sentirse en casa».
• significa — sentirse a gusto, integrado, como en casa.
• piezas fijas — zich voelen, reflexivo, y thuis sin preposición (no «in huis»).

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pregunta | **Voel je je** al **thuis** in Australië? | ¿Ya te sientes en casa en Australia? |
| 2 | presente | Ik **voel me** hier **thuis**. | Aquí me siento en casa. |
| 3 | perfecto | We **hebben ons** er meteen **thuis gevoeld**. | Nos sentimos en casa desde el principio. |
| 4 | imperativo | **Voel je** hier **thuis**! | ¡Estás en tu casa! |

• En la pregunta con jij salen dos je seguidos, voel JE JE. El primero es el sujeto y el segundo el reflexivo.
• Hermana — zich op zijn gemak voelen (sentirse cómodo).

🔑 El truco que casi nunca falla: thuis es en casa, sin preposición; naar huis es a casa.', updated_at = datetime('now')
WHERE id = 1301 AND rules_help IS NULL;

-- 🧩 het niet meer uithouden
UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🧩 Expresión fija — het niet meer uithouden:

• literal — «no sostenerlo más fuera».
• significa — no aguantar más.
• piezas fijas — un het vacío de objeto, y uithouden es separable, así que el uit se va al final.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | presente | Ik **hou het** niet meer **uit**. | No aguanto más. |
| 2 | perfecto | Hoe **heb** je **het** zo lang **uitgehouden**? | ¿Cómo lo has aguantado tanto tiempo? |
| 3 | con te | Het is niet **uit te houden**! | ¡Es insoportable! |
| 4 | pasado | Ze **hield het** daar maar een week **uit**. | Allí solo aguantó una semana. |

• Conjugación — houden es fuerte, hou(d) / hield (wij hielden) / gehouden, con hebben. Se dice más ik hou que ik houd.
• Hermano — iets niet kunnen uitstaan, no soportar a alguien. Ik kan hem niet uitstaan.

🔑 El truco que casi nunca falla: «no aguanto más» lleva siempre ese het, aunque en español no haya «lo».', updated_at = datetime('now')
WHERE id IN (588) AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 Expresión fija — het niet meer uithouden:%';

-- 899: la media linea remite al bloque
UPDATE words_es SET rules_help = REPLACE(rules_help, 'Y «het eens zijn met» es la construccion de estar de acuerdo.', 'Y «het eens zijn met» (estar de acuerdo) es otra expresion fija, con su propia ficha abajo en 🧩.'), updated_at = datetime('now')
WHERE id = 899 AND rules_help LIKE '%Y «het eens zijn met» es la construccion de estar de acuerdo.%';

-- 899: tres frases nuevas de het eens zijn / worden
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Estoy totalmente de acuerdo con eso. (inv)', 'SENTENCE', 'Ejemplo de "het eens zijn met" (inv.)', 'DAAR … MEE EENS = estar de acuerdo con eso. met + eso se vuelve daarmee y se parte: daar abre la frase y mee se queda delante de eens.

🧩 Expresión fija — het eens zijn met iemand:

• literal — «serlo uno con alguien»: eens es aquí «de una sola opinión», no «una vez».
• significa — estar de acuerdo con alguien.
• piezas fijas — het (no se quita ni se cambia por dat), met + la persona, y eens siempre al FINAL de su bloque.

| # | dónde | qué pasa | ejemplo |
|---|---|---|---|
| 1 | principal | zijn en 2ª posición, eens al final | Ik **ben het** met je **eens**. |
| 2 | negación | niet delante de met | Ik **ben het** niet met je **eens**. |
| 3 | perfecto | geweest detrás de eens, con zijn | Ik **ben het** nooit met hem **eens geweest**. |
| 4 | subordinada | eens + verbo, juntos al final | … omdat ik het met je **eens ben**. |
| 5 | con te | el te entre eens y zijn | Het is moeilijk om het met hem **eens te zijn**. |
| 6 | con una cosa | met + cosa se vuelve ermee / daarmee, partido | Ik **ben het ermee eens**. · **Daar** ben ik het **mee eens**. |

• het oneens zijn met — estar en desacuerdo. We zijn het over bijna alles oneens.
• het eens worden — ponerse de acuerdo. Zijn jullie het al eens geworden?
• over — el tema del acuerdo. We zijn het eens over de prijs.
• helemaal — totalmente. Ik ben het helemaal met je eens.
• sustantivos — de overeenstemming (el acuerdo, la sintonía) y het akkoord (el acuerdo cerrado). Akkoord! = ¡de acuerdo!

🔑 El truco que casi nunca falla: estar de acuerdo es un sándwich de tres piezas, HET detrás del verbo, MET + persona en medio y EENS cerrando. Si falta het o eens no va al final, está mal.

⚠️ Akkoord gaan met es aceptar una propuesta (Ik ga akkoord met het voorstel), no compartir la opinión de alguien. «Ik ben akkoord met je» se oye en Bélgica, en Países Bajos suena raro.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Estoy totalmente de acuerdo con eso. (inv)' AND notes = 'Ejemplo de "het eens zijn met" (inv.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy totalmente de acuerdo con eso. (inv)' AND notes = 'Ejemplo de "het eens zijn met" (inv.)' LIMIT 1), 'nl_NL', 'Daar ben ik het helemaal mee eens.', 'daar ben ik et héelemaal mee eens');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Estoy totalmente de acuerdo con eso. (inv)' AND notes = 'Ejemplo de "het eens zijn met" (inv.)' LIMIT 1), 1);
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Estoy totalmente de acuerdo con eso. (inv)' AND notes = 'Ejemplo de "het eens zijn met" (inv.)' LIMIT 1), 28);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES (899, (SELECT id FROM words_es WHERE text = 'Estoy totalmente de acuerdo con eso. (inv)' AND notes = 'Ejemplo de "het eens zijn met" (inv.)' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No estamos de acuerdo en casi nada.', 'SENTENCE', 'Ejemplo de "het eens zijn met" (can.)', 'HET EENS ZIJN OVER = estar de acuerdo en algo. El tema va con over, y bijna niets (casi nada) en medio.

🧩 Expresión fija — het eens zijn met iemand:

• literal — «serlo uno con alguien»: eens es aquí «de una sola opinión», no «una vez».
• significa — estar de acuerdo con alguien.
• piezas fijas — het (no se quita ni se cambia por dat), met + la persona, y eens siempre al FINAL de su bloque.

| # | dónde | qué pasa | ejemplo |
|---|---|---|---|
| 1 | principal | zijn en 2ª posición, eens al final | Ik **ben het** met je **eens**. |
| 2 | negación | niet delante de met | Ik **ben het** niet met je **eens**. |
| 3 | perfecto | geweest detrás de eens, con zijn | Ik **ben het** nooit met hem **eens geweest**. |
| 4 | subordinada | eens + verbo, juntos al final | … omdat ik het met je **eens ben**. |
| 5 | con te | el te entre eens y zijn | Het is moeilijk om het met hem **eens te zijn**. |
| 6 | con una cosa | met + cosa se vuelve ermee / daarmee, partido | Ik **ben het ermee eens**. · **Daar** ben ik het **mee eens**. |

• het oneens zijn met — estar en desacuerdo. We zijn het over bijna alles oneens.
• het eens worden — ponerse de acuerdo. Zijn jullie het al eens geworden?
• over — el tema del acuerdo. We zijn het eens over de prijs.
• helemaal — totalmente. Ik ben het helemaal met je eens.
• sustantivos — de overeenstemming (el acuerdo, la sintonía) y het akkoord (el acuerdo cerrado). Akkoord! = ¡de acuerdo!

🔑 El truco que casi nunca falla: estar de acuerdo es un sándwich de tres piezas, HET detrás del verbo, MET + persona en medio y EENS cerrando. Si falta het o eens no va al final, está mal.

⚠️ Akkoord gaan met es aceptar una propuesta (Ik ga akkoord met het voorstel), no compartir la opinión de alguien. «Ik ben akkoord met je» se oye en Bélgica, en Países Bajos suena raro.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No estamos de acuerdo en casi nada.' AND notes = 'Ejemplo de "het eens zijn met" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No estamos de acuerdo en casi nada.' AND notes = 'Ejemplo de "het eens zijn met" (can.)' LIMIT 1), 'nl_NL', 'We zijn het over bijna niets eens.', 'ue sein et óuver béina niits eens');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'No estamos de acuerdo en casi nada.' AND notes = 'Ejemplo de "het eens zijn met" (can.)' LIMIT 1), 1);
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'No estamos de acuerdo en casi nada.' AND notes = 'Ejemplo de "het eens zijn met" (can.)' LIMIT 1), 28);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES (899, (SELECT id FROM words_es WHERE text = 'No estamos de acuerdo en casi nada.' AND notes = 'Ejemplo de "het eens zijn met" (can.)' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Ya os habéis puesto de acuerdo?', 'SENTENCE', 'Ejemplo de "het eens zijn met" (perf.)', 'HET EENS WORDEN = ponerse de acuerdo. Es un cambio de estado, así que el perfecto va con zijn: Zijn jullie het al eens geworden?

🧩 Expresión fija — het eens zijn met iemand:

• literal — «serlo uno con alguien»: eens es aquí «de una sola opinión», no «una vez».
• significa — estar de acuerdo con alguien.
• piezas fijas — het (no se quita ni se cambia por dat), met + la persona, y eens siempre al FINAL de su bloque.

| # | dónde | qué pasa | ejemplo |
|---|---|---|---|
| 1 | principal | zijn en 2ª posición, eens al final | Ik **ben het** met je **eens**. |
| 2 | negación | niet delante de met | Ik **ben het** niet met je **eens**. |
| 3 | perfecto | geweest detrás de eens, con zijn | Ik **ben het** nooit met hem **eens geweest**. |
| 4 | subordinada | eens + verbo, juntos al final | … omdat ik het met je **eens ben**. |
| 5 | con te | el te entre eens y zijn | Het is moeilijk om het met hem **eens te zijn**. |
| 6 | con una cosa | met + cosa se vuelve ermee / daarmee, partido | Ik **ben het ermee eens**. · **Daar** ben ik het **mee eens**. |

• het oneens zijn met — estar en desacuerdo. We zijn het over bijna alles oneens.
• het eens worden — ponerse de acuerdo. Zijn jullie het al eens geworden?
• over — el tema del acuerdo. We zijn het eens over de prijs.
• helemaal — totalmente. Ik ben het helemaal met je eens.
• sustantivos — de overeenstemming (el acuerdo, la sintonía) y het akkoord (el acuerdo cerrado). Akkoord! = ¡de acuerdo!

🔑 El truco que casi nunca falla: estar de acuerdo es un sándwich de tres piezas, HET detrás del verbo, MET + persona en medio y EENS cerrando. Si falta het o eens no va al final, está mal.

⚠️ Akkoord gaan met es aceptar una propuesta (Ik ga akkoord met het voorstel), no compartir la opinión de alguien. «Ik ben akkoord met je» se oye en Bélgica, en Países Bajos suena raro.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Ya os habéis puesto de acuerdo?' AND notes = 'Ejemplo de "het eens zijn met" (perf.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Ya os habéis puesto de acuerdo?' AND notes = 'Ejemplo de "het eens zijn met" (perf.)' LIMIT 1), 'nl_NL', 'Zijn jullie het al eens geworden?', 'sein iúlii et al eens jeuórden');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¿Ya os habéis puesto de acuerdo?' AND notes = 'Ejemplo de "het eens zijn met" (perf.)' LIMIT 1), 1);
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¿Ya os habéis puesto de acuerdo?' AND notes = 'Ejemplo de "het eens zijn met" (perf.)' LIMIT 1), 28);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES (899, (SELECT id FROM words_es WHERE text = '¿Ya os habéis puesto de acuerdo?' AND notes = 'Ejemplo de "het eens zijn met" (perf.)' LIMIT 1), 'EXAMPLE');
