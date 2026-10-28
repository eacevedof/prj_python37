-- Learn Languages App - Migration
-- Migration: 20260907000001-grupo-adverbios-pronominales
-- Description: Eduardo pregunta por la tarjeta 134: "hay una regla: Waar kom je vandaan.
--   De donde vienes, Pq no puede ser Waarvan kom je?", y anade el contexto de donde sale
--   la 134: es el dialogo de una pelicula, unos vecinos nuevos que son refugiados, y una
--   chica pregunta «ze zijn vluchtelingen» — «waarvandaan?». Pide montar un grupo con
--   todas las estructuras del patron, ejemplos en todos sus modos variando pronombres,
--   tiempos y posesivos, y preguntas mas largas para ver donde cae la preposicion. Y
--   pregunta ademas por que se dice waar kom JE (sin -t) si es jij komt.
--
--   IMPORTANTE — la 134 NO estaba mal: «waarvandaan?» suelto es correcto. Un adverbio
--   pronominal solo se puede partir si hay frase donde poner la segunda mitad; en una
--   pregunta eliptica de eco no la hay, asi que la forma junta es la unica posible
--   (igual que Waarover?, Waarmee?, Waarvoor?). Lo que si estaba mal son sus frases de
--   ejemplo, que ponen Waarvandaan al frente de oraciones completas (libresco), y sobre
--   todo «Waarvandaan ken jij hem? — ¿De que lo conoces?», que es un ERROR: ahi es van y
--   no vandaan (Waar ken je hem van?). Se corrigen las notes de la 134 y se le escribe la
--   ayuda; su text y su traduccion NO se tocan, asi que sus mp3 siguen validos.
--
--   Se crea el grupo "adverbios pronominales - waar ... vandaan, waar ... over" con 18
--   tarjetas nuevas, mas la 134 (waarvandaan eliptico) y la 238 (waar ga je heen), que ya
--   existian y son de esta familia. Reparto: 6 de origen con vandaan (presente, plural,
--   imperfecto, subordinada, y las dos respuestas uit/van), 7 del patron partido waar +
--   preposicion (incluida la pregunta larga y las de posesivo), 2 del contraste con
--   PERSONA (van wie / over wie, donde NO hay adverbio pronominal), 1 de daar tonico y
--   2 de la -t de la inversion.
--
--   Tres bloques compartidos, inyectados identicos (norma: un solo bloque, nunca
--   reescrito), cada uno con su emoji-marca de guard:
--     A) "🧩 El adverbio pronominal" — que es, cuando es obligatorio (cosa, nunca
--        persona), las cuatro bases er/daar/hier/waar y la tabla junto/partido.
--     B) "📏 Donde cae la preposicion" — el reparto de la frase larga, en principal y en
--        subordinada, que es lo que Eduardo pidio ver con ejemplos largos.
--     C) "✂️ La -t que jij pierde al invertir" — la respuesta a su segunda pregunta.
--        Hasta ahora esta regla aparecia como vineta suelta en 110 tarjetas del mazo,
--        pero no habia ninguna que la enseñara.
--   No se duplica el grupo 12 (er), que cubre er + preposicion como anafora; aqui el foco
--   es waar (interrogativo y relativo) y la separacion.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'adverbios pronominales - waar ... vandaan, waar ... over',
       'En neerlandes una preposicion no puede llevar delante het, dat o wat cuando se refiere a una COSA: se sustituye por er, daar, hier o waar y la preposicion se pega detras (ervan, daarover, hiermee, waarvoor). Y en lengua hablada esa pieza se PARTE: la base va al principio y la preposicion viaja al final de la frase, delante de los verbos (Waar praat je over?). El grupo recorre las cuatro bases, el origen con vandaan frente a la respuesta con uit o van, el contraste con personas (van wie, over wie, donde no hay adverbio pronominal), donde cae exactamente la preposicion en preguntas largas, y la -t que jij pierde cuando el sujeto queda detras del verbo',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups
                  WHERE title = 'adverbios pronominales - waar ... vandaan, waar ... over');

-- =============================================================================
-- 2. Arreglo de la 134: sus 5 frases. El text y la traduccion NO se tocan
--    (waarvandaan? eliptico es correcto y sus mp3 siguen valiendo).
-- =============================================================================
UPDATE words_lang
SET notes = '• [can.] Waar kom je vandaan? — ¿De donde vienes?
• [vraag] «Ze zijn vluchtelingen.» «Waarvandaan?» — «Son refugiados.» «¿De donde?» (eliptico: sin frase detras, la forma va junta)
• [inv.] Waar komen die nieuwe buren eigenlijk vandaan? — ¿De donde son en realidad esos vecinos nuevos?
• [perf.] Waar is die geur vandaan gekomen? — ¿De donde ha salido ese olor?
• [bijzin] Vertel eens waar je vandaan komt. — Cuentame de donde vienes.'
WHERE word_es_id = 134
  AND lang_code = 'nl_NL'
  AND notes LIKE '%Waarvandaan ken jij hem%';

UPDATE words_es
SET rules_help = 'waarvandaan? = ¿de donde?, preguntado a secas. Suelto y sin frase detras es CORRECTO y es lo que se oye: «Ze zijn vluchtelingen.» «Waarvandaan?». En cuanto hay frase completa, la pieza se parte y vandaan se va al final: Waar kom je vandaan?

🎬 De donde sale esta tarjeta: de un dialogo de pelicula. Unos vecinos nuevos, alguien suelta «ze zijn vluchtelingen» y la otra pregunta «waarvandaan?». Ahi no hay verbo ni sujeto donde repartir la pieza, asi que la unica opcion es la forma junta. Es el mismo caso de Waarover?, Waarmee?, Waarvoor? y Waarom? como preguntas de eco.

⚠️ Lo que NO se dice es Waarvandaan kom je?, con la forma junta al frente de una frase completa: suena a libro del siglo pasado. Con frase, siempre partido: Waar kom je vandaan?

📌 Regla de bolsillo:
• ¿La pregunta va sola, sin verbo? → junta. Waarvandaan? Waarover? Waarmee?
• ¿Hay frase completa detras? → partida, y la preposicion al final. Waar kom je vandaan?
• ¿Es formal, escrito, juridico? → junta tambien vale al frente, pero no la uses al hablar.

🏋️ Ejercicio: «¿de donde vienen?» con frase completa → Waar ___ ze ___? (Respuesta: komen … vandaan.)'
WHERE id = 134
  AND (rules_help IS NULL OR rules_help NOT LIKE '%🎬 De donde sale esta tarjeta%');

-- =============================================================================
-- 3. Las 18 tarjetas nuevas
--    notes = 'Adverbio pronominal: <caso>' identifica cada una y sirve de guard.
-- =============================================================================

-- --- 3.01 origen, presente, jij invertido ------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿de dónde vienes?', 'PHRASE', 'Adverbio pronominal: vandaan presente',
'Waar kom je vandaan? = ¿de donde vienes? y tambien ¿de donde eres? Es LA pregunta de presentarse, y en ella se juntan las dos cosas que hay que entender: vandaan se va al final, y kom pierde la -t porque je queda detras del verbo.

⚠️ Por que no «Waarvan kom je?». Por dos motivos distintos, y conviene no mezclarlos. Primero, waarvan existe pero significa otra cosa: van marca pertenencia, materia o tema, nunca la procedencia con movimiento. Waarvan leeft hij? es ¿de que vive?. Para el origen el neerlandes tiene palabra propia, vandaan. Y segundo, aunque fuera van, no iria pegado delante: al hablar la pieza se parte y la preposicion se va al final, asi que seria Waar kom je van?, nunca Waarvan kom je?

🧠 De donde viene la palabra: vandaan es van + daan, una forma vieja de "de alli". Por eso no vive suelta y siempre necesita su base delante: waar, daar, hier, er, ergens, nergens of overal … vandaan. No existe «Ik kom vandaan» a secas.

🗺️ Las tres casillas de "donde", que se confunden entre si:

| que preguntas | pregunta | respuesta tipica |
|---|---|---|
| posicion | **Waar** ben je? | Ik ben thuis. |
| origen | **Waar** kom je **vandaan**? | Ik kom uit Spanje. |
| destino | **Waar** ga je **heen**? | Ik ga naar huis. |

🔑 El truco que casi nunca falla: En neerlandes la direccion no se marca delante con la preposicion, sino DETRAS con una particula. waar a secas es solo "donde"; lo que decide si es origen o destino va al final: vandaan (de) frente a heen o naartoe (a).

🏋️ Ejercicio: «¿de donde eres?» → Waar ___ je ___? (Respuesta: kom … vandaan. Y ojo: kom sin -t.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: vandaan presente');

-- --- 3.02 origen, plural, pregunta larga (el caso de la pelicula) ------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿de dónde son en realidad esos vecinos nuevos?', 'PHRASE', 'Adverbio pronominal: vandaan largo',
'Waar komen die nieuwe buren eigenlijk vandaan? = ¿de donde son en realidad esos vecinos nuevos? Es la version larga y completa de la pregunta eliptica «waarvandaan?» de la tarjeta 134.

📐 El reparto de la frase, pieza a pieza: waar (1a posicion) · komen (verbo finito) · die nieuwe buren (sujeto) · eigenlijk (el relleno) · vandaan (la particula, al final del todo). Por mucho que se alargue el medio, vandaan no se mueve de ahi.

💬 eigenlijk es la palabra que convierte la pregunta en curiosidad y no en interrogatorio: "en realidad", "a todo esto". Muy holandes y muy util: Wat doe je eigenlijk? (¿y tu a que te dedicas?).

📦 El vocabulario de la escena, con su articulo: de buurman (el vecino), de buurvrouw (la vecina), de buren (los vecinos, siempre plural), de buurt (el barrio), de vluchteling (el refugiado), het asielzoekerscentrum (el centro de acogida, azc para los amigos).

🏋️ Ejercicio: «¿de donde viene tu madre?» → Waar ___ jouw moeder ___? (Respuesta: komt … vandaan. Aqui SI hay -t, porque el sujeto no es jij.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: vandaan largo');

-- --- 3.03 origen, imperfecto --------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿de dónde venía ese ruido?', 'PHRASE', 'Adverbio pronominal: vandaan imperfecto',
'Waar kwam dat geluid vandaan? = ¿de donde venia ese ruido? Mismo patron en imperfecto: komen es fuerte y hace kwam en singular, kwamen en plural.

📊 komen en las dos formas que vas a necesitar aqui:

| persona | presente | imperfecto |
|---|---|---|
| ik | kom | kwam |
| jij / je | komt | kwam |
| u | komt | kwam |
| hij / zij / het | komt | kwam |
| wij | komen | kwamen |
| jullie | komen | kwamen |
| zij (plural) | komen | kwamen |

• participio — gekomen, y el auxiliar es ZIJN, no hebben: Ik ben uit Spanje gekomen. Es verbo de movimiento.
• en perfecto la particula se coloca antes del participio: Waar is dat geluid vandaan gekomen?

🧭 Cuando usarlo: preguntar por el origen de algo que ya no esta pasando. Ej.: → Waar kwam die lucht vandaan? (¿de donde venia ese olor?).

📦 Con articulo: het geluid (el ruido, el sonido), de lucht (el aire y tambien el olor), de geur (el olor, mas neutro), de stank (la peste).

🏋️ Ejercicio: «¿de donde venian esos gritos?» → Waar ___ die kreten ___? (Respuesta: kwamen … vandaan.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: vandaan imperfecto');

-- --- 3.04 origen, subordinada --------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no sé de dónde es él', 'PHRASE', 'Adverbio pronominal: vandaan bijzin',
'Ik weet niet waar hij vandaan komt. = no se de donde es. En subordinada el patron sigue igual, pero el verbo se va al final del todo y la particula queda JUSTO DELANTE de el.

📐 El reparto en subordinada: waar (abre la subordinada) · hij (sujeto) · vandaan (la particula) · komt (el verbo, al final). Compara con la principal, donde el verbo va en 2a posicion y la particula al final: Waar komt hij vandaan?

⚠️ Y ojo a la -t, que aqui SI aparece aunque en la principal tambien estaba: hij nunca la pierde. La que se cae al invertir es solo la de jij.

📋 Las subordinadas que usaras con esto:
• Ik weet niet waar hij vandaan komt. — No se de donde es.
• Vertel eens waar je vandaan komt. — Cuentame de donde eres.
• Hij vroeg waar ik vandaan kwam. — Preguntó de donde era yo.
• Het maakt niet uit waar je vandaan komt. — Da igual de donde seas.

🧭 Cuando usarlo: hablar del origen de alguien sin preguntarselo a la cara. Ej.: → Ze wilde weten waar we vandaan kwamen.

🏋️ Ejercicio: «no se de donde vienen» → Ik weet niet waar ze ___ ___. (Respuesta: vandaan komen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: vandaan bijzin');

-- --- 3.05 la respuesta con uit ---------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'soy de España', 'PHRASE', 'Adverbio pronominal: respuesta uit',
'Ik kom uit Spanje. = soy de España. Es la respuesta a Waar kom je vandaan?, y aqui la preposicion es UIT, no van ni vandaan: con paises y ciudades manda uit.

🗺️ uit o van en la respuesta, que es donde de verdad se falla:

| que dices | preposicion | ejemplo |
|---|---|---|
| de donde ERES, tu origen | **uit** | Ik kom **uit** Spanje. Ik kom **uit** Madrid. |
| de donde VIENES ahora mismo | **van** | Ik kom **van** mijn werk. Ik kom **van** school. |
| de donde sales, un edificio | **uit** | Ik kom **uit** het ziekenhuis. |

🔑 El truco: uit es "desde dentro de", asi que sirve para paises, ciudades y edificios, que son cosas en las que se esta metido. van es "desde", y sirve para el sitio del que vuelves: van de markt, van de bakker, van de kapper, van een feestje.

⚠️ La pregunta no cambia: para las dos cosas se pregunta Waar kom je vandaan? El que decide si hablas de tu origen o de esta mañana es el contexto, y la respuesta con uit o van.

📦 Paises con articulo, que sorprenden: Spanje, Nederland y België van sin articulo, pero de Verenigde Staten, de Filipijnen y het Verenigd Koninkrijk lo llevan. Ik kom uit de Verenigde Staten.

🏋️ Ejercicio: «vengo del medico» → Ik kom ___ de dokter. (Respuesta: van. No es tu origen, es de donde vuelves.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: respuesta uit');

-- --- 3.06 la respuesta con van ----------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'vengo del trabajo', 'PHRASE', 'Adverbio pronominal: respuesta van',
'Ik kom van mijn werk. = vengo del trabajo. Aqui SI es van: no hablas de tu origen sino del sitio del que vuelves ahora mismo.

📋 Los sitios de los que se "viene" con van, casi siempre sin articulo o con el posesivo:
• van mijn werk — del trabajo.
• van school — del colegio, de clase.
• van de markt — del mercado.
• van de kapper — de la peluqueria.
• van een feestje — de una fiesta.
• van vakantie — de vacaciones.

📐 Estructura: sujeto + kom + van + lugar. Y con posesivo, van mijn werk, van je moeder, van ons huis.

⚠️ No confundas con het werk como sustantivo: se dice naar mijn werk gaan (ir al trabajo) y van mijn werk komen (venir del trabajo), las dos con el posesivo y sin articulo. «van het werk» suena raro.

🔁 El par completo del movimiento: naar (hacia) para ir, van o uit (desde) para venir, bij o op (en) para estar. Ik ga naar mijn werk · Ik ben op mijn werk · Ik kom van mijn werk.

🏋️ Ejercicio: «venimos de la playa» → We komen ___ het strand. (Respuesta: van.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: respuesta van');

-- --- 3.07 waar ... over, la corta -------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿de qué hablas?', 'PHRASE', 'Adverbio pronominal: waar over corto',
'Waar heb je het over? = ¿de que hablas? Es la forma hecha para "hablar de algo": het ergens over hebben, con ese het fijo que no se traduce y que hay que poner si o si.

⚠️ El het no es opcional ni se puede quitar: Waar heb je het over? nunca «Waar heb je over?». Es parte de la expresion, igual que en Ik heb het over jou (estoy hablando de ti).

🎭 Las tres maneras de decir "hablar de", que no son intercambiables del todo:
• het ergens over hebben — hablar de un tema, en conversacion. Waar heb je het over?
• ergens over praten — hablar sobre algo, mas neutro. Waar praat je over?
• ergens over spreken — mas formal, y el de los discursos y las citas.

💬 Y la frase que oiras cuando no te siguen: Waar heb je het over? dicho con cara rara es "¿pero tu de que me hablas?". Para pedir aclaracion de verdad: Wat bedoel je?

🏋️ Ejercicio: «¿de que hablabais?» → Waar ___ jullie het ___? (Respuesta: hadden … over.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: waar over corto');

-- --- 3.08 waar ... over, la larga (perfecto) ----------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿de qué hablaste ayer tanto rato con tu madre?', 'PHRASE', 'Adverbio pronominal: waar over largo',
'Waar heb je gisteren zo lang met je moeder over gepraat? = ¿de que hablaste ayer tanto rato con tu madre? Es el ejemplo que enseña de verdad donde cae la preposicion: da igual lo que crezca el medio de la frase, over se queda al final y solo el participio va detras.

📐 El reparto, pieza a pieza:

| posicion | pieza | aqui |
|---|---|---|
| 1a | la palabra-W | **waar** |
| 2a | verbo finito | **heb** |
| 3a | sujeto | **je** |
| medio | tiempo | gisteren |
| medio | manera | zo lang |
| medio | compañia | met je moeder |
| final | **la preposicion** | **over** |
| tras el final | verbos no finitos | gepraat |

🔑 El truco: la preposicion se coloca lo mas al final posible, pero SIEMPRE por delante de los verbos que cierran la frase. Si hay participio o infinitivo, ella va justo antes.

📋 Mas ejemplos con el medio cada vez mas largo, para que se vea:
• Waar praat je over? — ¿de que hablas?
• Waar praat je met je collega over? — ¿de que hablas con tu compañero?
• Waar heb je gisteren met je collega over gepraat? — ¿de que hablaste ayer con tu compañero?
• Waar heb je gisteren op kantoor zo lang met je collega over zitten praten? — ¿de que estuviste ayer en la oficina hablando tanto rato con tu compañero?

⚠️ En la lengua escrita y formal se admite la forma junta al frente, waarover: Waarover heb je gepraat? Se entiende y es correcta, pero al hablar suena rigida. Al hablar, siempre partida.

🏋️ Ejercicio: «¿de que discutisteis tanto tiempo?» → Waar hebben jullie zo lang ___ ___? (Respuesta: over gediscussieerd.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: waar over largo');

-- --- 3.09 waar ... van (el que estaba mal en la 134) ---------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿de qué lo conoces?', 'PHRASE', 'Adverbio pronominal: waar van',
'Waar ken je hem van? = ¿de que lo conoces? Este es el caso donde la preposicion SI es van, y es justo el que se confunde con vandaan: aqui no hay procedencia fisica, hay origen de un conocimiento.

⚠️ Este ejemplo estaba MAL en la tarjeta 134, que traia «Waarvandaan ken jij hem?» traducido como ¿de que lo conoces?. Es un error: vandaan es de donde vienes fisicamente, van es de que lo conoces. Corregido en esta tanda.

🎭 van y vandaan, uno al lado del otro:

| que preguntas | forma | ejemplo |
|---|---|---|
| origen fisico, de que sitio vienes | **vandaan** | Waar kom je **vandaan**? |
| origen de un conocimiento o una relacion | **van** | Waar ken je hem **van**? |
| de que vive, de que material es | **van** | Waar leeft hij **van**? Waar is dit **van** gemaakt? |
| de que es esta pieza, a que pertenece | **van** | Waar is deze sleutel **van**? |

💬 Las respuestas tipicas a Waar ken je hem van?: Van mijn werk (del trabajo) · Van school (del colegio) · Van vroeger (de hace tiempo) · Van het voetbal (del futbol) · Geen idee, ik ken hem helemaal niet (ni idea, no lo conozco de nada).

🏋️ Ejercicio: «¿de que la conoces?» → Waar ken je ___ ___? (Respuesta: haar … van.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: waar van');

-- --- 3.10 waar ... mee -----------------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿con qué has abierto esto?', 'PHRASE', 'Adverbio pronominal: waar mee',
'Waar heb je dit mee opengemaakt? = ¿con que has abierto esto? Ojo a la preposicion, porque cambia de forma: met se convierte en MEE en cuanto entra en un adverbio pronominal.

⚠️ Las dos preposiciones que cambian de forma al pegarse, y son las que mas fallos dan:
• met → mee. ermee, daarmee, hiermee, waarmee. Nunca «ermet».
• tot → toe. ertoe, daartoe, waartoe.
Todas las demas se pegan tal cual: eraan, ervan, erover, ervoor, erin, erop, erbij.

📋 mee en la vida diaria, que sale constantemente:
• Waar ben je mee bezig? — ¿en que andas?
• Hoe gaat het ermee? — ¿como te va?
• Ik ben er blij mee. — Estoy contento con ello.
• Doe je mee? — ¿te apuntas?
• Neem het mee. — Llevatelo.

📐 El reparto: waar · heb · je · dit · mee · opengemaakt. La preposicion antes del participio, como siempre.

🏋️ Ejercicio: «¿con que lo has cortado?» → Waar heb je het ___ ___? (Respuesta: mee gesneden.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: waar mee');

-- --- 3.11 waar ... mee bezig ------------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿en qué estás liado?', 'PHRASE', 'Adverbio pronominal: waar mee bezig',
'Waar ben je mee bezig? = ¿en que estas liado?, ¿que andas haciendo? Es una de las preguntas mas frecuentes del dia a dia, y va con la formula fija ergens mee bezig zijn.

⚠️ bezig zijn met es "estar ocupado con". Con sustantivo se dice entero: Ik ben bezig met mijn huiswerk. Pero en cuanto el complemento es un pronombre de cosa, hay que pasar al adverbio pronominal: Ik ben ermee bezig, y en pregunta Waar ben je mee bezig?

📐 Fijate en el sitio de bezig: la preposicion mee va antes, y bezig cierra. waar · ben · je · mee · bezig. Y en la version larga, waar · ben · je · de hele middag · mee · bezig · geweest.

💬 Segun el tono, la misma pregunta cambia de sentido: dicha normal es interes, "¿que estas haciendo?"; dicha con las cejas levantadas es reproche, "¿pero que estas liando?". La version claramente enfadada es Waar ben jij nou mee bezig?, con jij tonico y nou.

📋 La familia de bezig: bezig zijn met (estar ocupado con) · druk bezig zijn (estar muy liado) · de bezigheid (la ocupacion) · bezet (ocupado, de sitio o de linea telefonica, que no es lo mismo que bezig).

🏋️ Ejercicio: «llevo toda la tarde con ello» → Ik ben er de hele middag ___ ___ ___. (Respuesta: mee bezig geweest.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: waar mee bezig');

-- --- 3.12 waar ... voor, con posesivo -----------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿para qué necesitas mi coche?', 'PHRASE', 'Adverbio pronominal: waar voor posesivo',
'Waar heb je mijn auto voor nodig? = ¿para que necesitas mi coche? Aqui el complemento lleva POSESIVO (mijn auto) y aun asi la preposicion se va al final: el posesivo se queda en el medio de la frase, con su sustantivo.

📐 El reparto con posesivo: waar · heb · je · mijn auto · voor · nodig. El grupo mijn auto viaja entero por el medio; voor no se le pega nunca.

📋 Los posesivos, ya que salen aqui:

| persona | posesivo | ejemplo |
|---|---|---|
| ik | **mijn** | Waar heb je **mijn** auto voor nodig? |
| jij / je | **jouw** / **je** | Waar heb je **je** fiets voor nodig? |
| u | **uw** | Waar heeft u **uw** paspoort voor nodig? |
| hij | **zijn** | Waar heeft hij **zijn** laptop voor nodig? |
| zij (ella) | **haar** | Waar heeft ze **haar** tas voor nodig? |
| wij | **ons** / **onze** | Waar hebben we **onze** sleutels voor nodig? |
| jullie | **jullie** | Waar hebben jullie **jullie** spullen voor nodig? |
| zij (ellos) | **hun** | Waar hebben ze **hun** auto voor nodig? |

• ons u onze: ons con palabra het (ons huis) y onze con palabra de y con todos los plurales (onze auto, onze sleutels).
• jouw es el tonico y je el atono: Is dat jouw fiets? (enfatico) frente a je fiets (normal).

⚠️ nodig hebben (necesitar) es formula fija y se parte igual que un separable: el nodig se va al final del todo, detras de la preposicion. Ik heb het nodig · Waar heb je het voor nodig?

🏋️ Ejercicio: «¿para que necesita ella su pasaporte?» → Waar heeft ze ___ paspoort ___ ___? (Respuesta: haar … voor nodig.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: waar voor posesivo');

-- --- 3.13 waar ... van, pertenencia de COSA -------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿de qué es esta llave?', 'PHRASE', 'Adverbio pronominal: waar van cosa',
'Waar is deze sleutel van? = ¿de que es esta llave?, o sea a que puerta pertenece. Como lo que preguntas es una COSA, toca adverbio pronominal partido: waar … van.

⚠️ Compara con la tarjeta hermana Van wie is deze sleutel? (¿de quien es esta llave?). Misma llave, misma preposicion, y sin embargo dos construcciones distintas: la de COSA se parte con waar, la de PERSONA va entera con wie. Es la frontera que define todo este grupo.

📋 Preguntas de pertenencia y de material, todas con waar … van:
• Waar is deze sleutel van? — ¿de que es esta llave?
• Waar is dit van gemaakt? — ¿de que esta hecho esto?
• Waar is die knop van? — ¿de que es ese boton?
• Waar leeft hij van? — ¿de que vive?

📦 Con articulo: de sleutel (la llave), het slot (la cerradura, y tambien el candado), de deur (la puerta), de sleutelbos (el manojo de llaves), het sleutelgat (la cerradura, el ojo).

💬 Y la respuesta se da con van + la cosa: Van de voordeur (de la puerta de la calle), Van de schuur (del cobertizo), Van de fietsenstalling (del aparcamiento de bicis).

🏋️ Ejercicio: «¿de que esta hecho?» → Waar is het ___ ___? (Respuesta: van gemaakt.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: waar van cosa');

-- --- 3.14 PERSONA: van wie ---------------------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿de quién es esta llave?', 'PHRASE', 'Adverbio pronominal: persona van wie',
'Van wie is deze sleutel? = ¿de quien es esta llave? Con PERSONAS no hay adverbio pronominal: la preposicion se queda delante y se junta con wie. Nunca «waarvan is deze sleutel».

🚧 La frontera de todo este grupo, en una linea: si el complemento es una COSA, se sustituye por er/daar/hier/waar y la preposicion se pega detras. Si es una PERSONA, la preposicion se queda delante con wie, hem, haar, mij…

| complemento | como se dice | ejemplo |
|---|---|---|
| cosa, preguntando | **waar** … **van** | **Waar** is deze sleutel **van**? |
| persona, preguntando | **van wie** | **Van wie** is deze sleutel? |
| cosa, afirmando | **er** … **van** | Ik weet **er** niets **van**. |
| persona, afirmando | **van hem** | Ik weet niets **van hem**. |

📋 Las preguntas de persona, todas enteras y delante: van wie (de quien), met wie (con quien), over wie (de quien, hablando), aan wie (a quien), voor wie (para quien), bij wie (en casa de quien).

⚠️ Y la trampa de van wie: tambien es como se dice "cuyo" en lengua hablada. De man van wie de auto gestolen is (el hombre al que le robaron el coche). En escrito formal seria wiens.

🏋️ Ejercicio: «¿con quien vas?» → ___ ___ ga je mee? (Respuesta: Met wie.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: persona van wie');

-- --- 3.15 PERSONA: over wie ---------------------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿de quién estás hablando?', 'PHRASE', 'Adverbio pronominal: persona over wie',
'Over wie heb je het? = ¿de quien estas hablando? La pareja exacta de Waar heb je het over?: misma expresion, y solo cambia si lo que sigue es persona o cosa.

🚧 Las dos, una al lado de la otra, que es como se aprende:
• Waar heb je het over? — ¿de QUE hablas? (cosa, partido)
• Over wie heb je het? — ¿de QUIEN hablas? (persona, entero y delante)

⚠️ No se dice «Waar heb je het over wie», ni «Over wat heb je het». Con cosa, waar … over. Con persona, over wie. Y si es una persona concreta ya mencionada: Ik heb het over hem, nunca «Ik heb er het over».

📋 Mas pares del mismo corte, para fijar la frontera:
• Waar denk je aan? (¿en que piensas?) — Aan wie denk je? (¿en quien piensas?)
• Waar ben je bang voor? (¿de que tienes miedo?) — Voor wie ben je bang? (¿de quien?)
• Waar wacht je op? (¿que esperas?) — Op wie wacht je? (¿a quien esperas?)
• Waar praat je over? (¿de que hablas?) — Met wie praat je? (¿con quien hablas?)

🏋️ Ejercicio: «¿en quien piensas?» → ___ ___ denk je? (Respuesta: Aan wie.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: persona over wie');

-- --- 3.16 daar tonico ------------------------------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'de eso no sé nada', 'PHRASE', 'Adverbio pronominal: daar tonico',
'Daar weet ik niets van. = de eso no se nada. Misma pieza partida, pero con DAAR en vez de waar: daar es el demostrativo tonico, el que sirve para responder y para enfatizar.

🎚️ Las cuatro bases, que se eligen por lo que quieres hacer:

| base | que es | ejemplo |
|---|---|---|
| **er** | atono, neutro, no se puede acentuar | Ik weet **er** niets **van**. |
| **daar** | tonico, señala y enfatiza: "de ESO" | **Daar** weet ik niets **van**. |
| **hier** | tonico y cercano: "de ESTO" | **Hier** weet ik niets **van**. |
| **waar** | interrogativo y relativo | **Waar** weet jij iets **van**? |

🔑 El truco: si la pieza va en PRIMERA posicion, no puede ser er (er nunca abre frase con enfasis). Ahi solo valen daar y hier. Ik weet er niets van y Daar weet ik niets van dicen lo mismo, pero la segunda pone el foco en "de eso" y suena a que te desmarcas.

⚠️ er es atono y por eso se cuela en medio sin que se note; daar es tonico y por eso se planta al principio. Es el mismo par que het frente a dat: Ik weet het / Dat weet ik.

💬 Frases hechas con esta forma: Daar kan ik niets aan doen (yo no puedo hacer nada) · Daar heb je gelijk in (en eso tienes razon) · Daar gaat het niet om (no va de eso) · Daar ben ik het mee eens (en eso estoy de acuerdo).

🏋️ Ejercicio: «en eso estoy de acuerdo» → ___ ben ik het ___ eens. (Respuesta: Daar … mee.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: daar tonico');

-- --- 3.17 la -t: inversion sin pregunta -----------------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'mañana llegas tarde', 'PHRASE', 'Adverbio pronominal: t inversion',
'Morgen kom je te laat. = mañana llegas tarde. Fijate en que NO es una pregunta y aun asi kom va sin -t: lo que quita la -t no es la pregunta, es que je haya quedado DETRAS del verbo.

⚠️ Este es el ejemplo que desmonta la regla mal aprendida. Casi todo el mundo memoriza "en las preguntas se quita la -t" y luego escribe «Morgen komt je te laat», que esta mal. Aqui Morgen ocupa la primera posicion, empuja el verbo a la segunda y el sujeto se va detras: inversion, y adios -t.

📋 Mas casos de inversion sin pregunta, que son los que se escapan:
• Morgen kom je te laat. — Mañana llegas tarde.
• Vanavond eet je bij ons. — Esta noche cenas en casa.
• Daar woon je toch? — Ahi vives, ¿no?
• Nu begrijp je het. — Ahora lo entiendes.
• Volgens mij vergeet je iets. — Creo que te olvidas de algo.

🔑 El truco: mira DONDE esta el sujeto, no si hay interrogacion. Delante del verbo, -t. Detras del verbo, sin -t.

🏋️ Ejercicio: «esta noche trabajas hasta tarde» → Vanavond ___ je lang door. (Respuesta: werk, sin -t.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: t inversion');

-- --- 3.18 la -t: u no la pierde -----------------------------------------------------------------------------
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿viene usted de Bélgica?', 'PHRASE', 'Adverbio pronominal: t usted',
'Komt u uit België? = ¿viene usted de Bélgica? La regla de la -t solo afecta a jij y je. u no la pierde NUNCA, ni invertida ni en pregunta.

🚧 Las tres personas, en pregunta, para verlo de una vez:

| sujeto | afirmando | preguntando | ¿pierde la -t? |
|---|---|---|---|
| jij / je | Je **komt** uit Spanje. | **Kom** je uit Spanje? | **si** |
| u | U **komt** uit België. | **Komt** u uit België? | **no** |
| hij / zij | Hij **komt** uit België. | **Komt** hij uit België? | **no** |

🧠 Por que solo jij: la -t que se cae venia de la fusion antigua del verbo con el pronombre pospuesto (comes du acabo dando com-stu), y al deshacerse la fusion el verbo se quedo desnudo. u y hij nunca entraron en esa fusion, asi que conservan su -t.

⚠️ Y si la raiz YA acaba en -t no hay nada que quitar: jij zit / Zit jij? · jij laat los / Laat jij los? · jij vat het samen / Vat jij het samen?

📦 Paises con articulo o sin el: uit België, uit Spanje, uit Duitsland, uit Nederland van sin articulo; pero uit de Verenigde Staten y uit het Verenigd Koninkrijk lo llevan.

🏋️ Ejercicio: «¿usted vive aqui?» → ___ u hier? (Respuesta: Woont, con -t.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Adverbio pronominal: t usted');

-- =============================================================================
-- 4. Traducciones
-- =============================================================================
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
SELECT we.id, 'nl_NL', v.nl, v.pron
FROM (
    SELECT 'Adverbio pronominal: vandaan presente' AS k, 'Waar kom je vandaan?' AS nl, 'uaar kom ye fandaan' AS pron
    UNION ALL SELECT 'Adverbio pronominal: vandaan largo', 'Waar komen die nieuwe buren eigenlijk vandaan?', 'uaar koomen di niuue buuren eijenlek fandaan'
    UNION ALL SELECT 'Adverbio pronominal: vandaan imperfecto', 'Waar kwam dat geluid vandaan?', 'uaar kuam dat jelaut fandaan'
    UNION ALL SELECT 'Adverbio pronominal: vandaan bijzin', 'Ik weet niet waar hij vandaan komt.', 'ik veet nit uaar hai fandaan komt'
    UNION ALL SELECT 'Adverbio pronominal: respuesta uit', 'Ik kom uit Spanje.', 'ik kom aut spanye'
    UNION ALL SELECT 'Adverbio pronominal: respuesta van', 'Ik kom van mijn werk.', 'ik kom fan main verk'
    UNION ALL SELECT 'Adverbio pronominal: waar over corto', 'Waar heb je het over?', 'uaar hep ye het oover'
    UNION ALL SELECT 'Adverbio pronominal: waar over largo', 'Waar heb je gisteren zo lang met je moeder over gepraat?', 'uaar hep ye jísteren zo lang met ye muder oover jepraat'
    UNION ALL SELECT 'Adverbio pronominal: waar van', 'Waar ken je hem van?', 'uaar ken ye hem fan'
    UNION ALL SELECT 'Adverbio pronominal: waar mee', 'Waar heb je dit mee opengemaakt?', 'uaar hep ye dit mee oopenjemaakt'
    UNION ALL SELECT 'Adverbio pronominal: waar mee bezig', 'Waar ben je mee bezig?', 'uaar ben ye mee beezej'
    UNION ALL SELECT 'Adverbio pronominal: waar voor posesivo', 'Waar heb je mijn auto voor nodig?', 'uaar hep ye main auto foor noodej'
    UNION ALL SELECT 'Adverbio pronominal: waar van cosa', 'Waar is deze sleutel van?', 'uaar is deeze sleutel fan'
    UNION ALL SELECT 'Adverbio pronominal: persona van wie', 'Van wie is deze sleutel?', 'fan ui is deeze sleutel'
    UNION ALL SELECT 'Adverbio pronominal: persona over wie', 'Over wie heb je het?', 'oover ui hep ye het'
    UNION ALL SELECT 'Adverbio pronominal: daar tonico', 'Daar weet ik niets van.', 'daar veet ik nits fan'
    UNION ALL SELECT 'Adverbio pronominal: t inversion', 'Morgen kom je te laat.', 'mórjen kom ye te laat'
    UNION ALL SELECT 'Adverbio pronominal: t usted', 'Komt u uit België?', 'komt u aut belji'
) v
JOIN words_es we ON we.notes = v.k;

-- =============================================================================
-- 5. Al grupo nuevo y a generic; y las dos que ya existian (134, 238)
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Adverbio pronominal: %'
  AND g.title = 'adverbios pronominales - waar ... vandaan, waar ... over';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Adverbio pronominal: %'
  AND g.title = 'generic';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE g.title = 'adverbios pronominales - waar ... vandaan, waar ... over'
  AND we.id IN (134, 238);

-- =============================================================================
-- 6. Bloque compartido A: que es un adverbio pronominal
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧩 El adverbio pronominal, la pieza que explica todo esto:

En neerlandes una preposicion NO puede llevar delante het, dat o wat cuando se refiere a una cosa. No se dice «met het», «van dat», «over wat». Hay que sustituir el pronombre por una de estas cuatro bases y pegarle la preposicion DETRAS:

| base | cuando | con met | con van | con over |
|---|---|---|---|---|
| **er** | atono, neutro | er**mee** | er**van** | er**over** |
| **daar** | tonico, "de eso" | daar**mee** | daar**van** | daar**over** |
| **hier** | tonico, "de esto" | hier**mee** | hier**van** | hier**over** |
| **waar** | pregunta y relativo | waar**mee** | waar**van** | waar**over** |

⚠️ Dos preposiciones cambian de forma al pegarse: met se vuelve mee (ermee, waarmee) y tot se vuelve toe (ertoe, waartoe). Las demas se pegan tal cual.

✂️ Y la pieza se PARTE: la base se queda al principio y la preposicion se va al final de la frase. Al hablar, esta es la forma normal; la junta suena a escrito.

| | junta (escrito, formal) | partida (hablado, normal) |
|---|---|---|
| pregunta | **Waarover** praat je? | **Waar** praat je **over**? |
| respuesta | Ik weet **daarvan** niets. | **Daar** weet ik niets **van**. |
| relativo | het boek **waarover** ik sprak | het boek **waar** ik **over** sprak |

🚧 Con PERSONAS no se hace nada de esto: la preposicion se queda delante y se junta con wie, hem, haar. Van wie is dit? y nunca «waarvan is dit» si preguntas por una persona.'
WHERE notes LIKE 'Adverbio pronominal: %'
  AND notes NOT IN ('Adverbio pronominal: t inversion', 'Adverbio pronominal: t usted')
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 El adverbio pronominal%';

-- =============================================================================
-- 7. Bloque compartido B: donde cae la preposicion en la frase larga
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

📏 Donde cae la preposicion cuando la frase se alarga:

El sitio de la preposicion no cambia por mucho que crezca la frase: se va lo mas al final posible, pero SIEMPRE por delante de los verbos que cierran (participio, infinitivo).

| frase | reparto |
|---|---|
| Waar praat je **over**? | waar · praat · je · **over** |
| Waar praat je met je collega **over**? | waar · praat · je · met je collega · **over** |
| Waar heb je gisteren met je collega **over** gepraat? | waar · heb · je · gisteren met je collega · **over** · gepraat |
| Waar ben je de hele middag **mee** bezig geweest? | waar · ben · je · de hele middag · **mee** · bezig geweest |
| Waar komen die buren eigenlijk **vandaan**? | waar · komen · die buren · eigenlijk · **vandaan** |

📐 En subordinada el verbo se va al final del todo, y la preposicion queda justo delante de el:
• Ik weet niet waar hij vandaan komt. — No se de donde es.
• Ik weet niet waar je het de hele tijd over hebt. — No se de que hablas todo el rato.
• Dat is de man waar ik je over vertelde. — Ese es el hombre del que te hable.

🔑 El truco: coloca primero toda la frase sin la preposicion, y sueltala al final, justo antes del ultimo verbo. Si no hay verbo final, va la ultima del todo.'
WHERE notes IN (
    'Adverbio pronominal: vandaan presente',
    'Adverbio pronominal: vandaan largo',
    'Adverbio pronominal: vandaan bijzin',
    'Adverbio pronominal: waar over corto',
    'Adverbio pronominal: waar over largo',
    'Adverbio pronominal: waar van',
    'Adverbio pronominal: waar mee',
    'Adverbio pronominal: waar mee bezig',
    'Adverbio pronominal: waar voor posesivo',
    'Adverbio pronominal: waar van cosa',
    'Adverbio pronominal: daar tonico'
)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%📏 Donde cae la preposicion%';

-- =============================================================================
-- 8. Bloque compartido C: la -t que jij pierde al invertir
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

✂️ La -t que jij pierde al invertir:

La regla NO es "en las preguntas se quita la -t". Es de POSICION: el verbo lleva -t en segunda persona solo si jij o je va DELANTE. Si el sujeto queda detras del verbo, la -t desaparece.

| frase | donde esta je | forma |
|---|---|---|
| **Jij komt** uit Spanje. | delante | con **-t** |
| **Kom jij** uit Spanje? | detras | sin -t |
| Waar **kom je** vandaan? | detras | sin -t |
| Morgen **kom je** te laat. | detras | sin -t |
| … omdat **je komt**. | delante | con **-t** |

⚠️ Fijate en la cuarta, que NO es pregunta y aun asi pierde la -t: Morgen ocupa la primera posicion y empuja el sujeto detras del verbo. Ese es el caso donde falla todo el que aprendio la regla como "en preguntas".

🚧 Solo le pasa a jij y je. Ni u ni hij la pierden nunca: Komt u mee? · Komt hij mee?

🔑 El truco: jij y la -t no caben los dos detras del verbo. Mira donde esta el sujeto, no si hay interrogacion.

⚠️ Y si la raiz ya acaba en -t, no hay nada que quitar ni que poner: jij zit / Zit jij? · jij laat los / Laat jij los?'
WHERE notes LIKE 'Adverbio pronominal: %'
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%✂️ La -t que jij pierde%';
