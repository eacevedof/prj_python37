-- Learn Languages App - Migration
-- Migration: 20260908000007-grupo-gerundio
-- Description: Eduardo, sobre la 1032 (Ik denk er nog over na = me lo estoy pensando):
--   "regla gerundio, para ese gerundio se usa nog? en que casos uso nog para gerundio?
--   crees q estaria bien crear un grupo gerundio?".
--
--   Primero, la correccion: el nog NO es la marca del gerundio. En Ik denk er nog over na,
--   nog significa TODAVIA — es el mismo nog del cuadrado al/nog/nog niet/niet meer de la
--   migracion 20260908000003. El gerundio ya esta en denk: quita el nog y Ik denk erover na
--   sigue siendo lo estoy pensando. nog solo añade que la decision sigue pendiente.
--
--   Y si, el grupo hacia falta. El neerlandes NO tiene gerundio como forma verbal, y el
--   estoy + -ando español se reparte en cuatro construcciones que el mazo apenas tocaba:
--   aan het aparecia en UNA tarjeta (953), zitten te en UNA (765) y bezig en tres, sin
--   nada que las comparase ni que explicase cuando usar cada una.
--
--   11 tarjetas PHRASE: el presente simple como respuesta por defecto, aan het en tres
--   usos (basico, con complementos y en pasado con toen), las posturas zitten/staan/
--   liggen/lopen te en dos, bezig zijn met, el -end como ADJETIVO (que es el error clasico
--   del hispanohablante: slapend es durmiente, no durmiendo), el -end adverbial de modo
--   (unico caso en que si traduce un gerundio), la subordinada con toen para el gerundio
--   que dice cuando, y nog steeds con blijven para el sigue + gerundio.
--   Se añade al grupo la 765 (Hij zit te lezen), la 953 (aan het inpakken) y la 1032, que
--   es la que trajo la duda.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'gerundio - aan het, zitten te, bezig zijn',
       'El neerlandes no tiene gerundio como forma verbal, asi que el estoy + -ando español se reparte en cuatro construcciones: el presente simple (Het regent ya es esta lloviendo y es la respuesta por defecto), aan het + infinitivo para subrayar que la accion pasa ahora mismo, zitten/staan/liggen/lopen + te para el continuo diciendo ademas la postura (lo mas holandes del grupo: Ik zit tv te kijken) y bezig zijn met cuando detras va un sustantivo. Incluye el error clasico del hispanohablante, que es usar la forma en -end como gerundio cuando en realidad es un ADJETIVO (slapend es durmiente y no durmiendo), su unico uso valido como adverbio de modo, y que hacer con el gerundio que dice cuando (subordinada con toen o terwijl) y con el que dice que algo continua (nog steeds o blijven + infinitivo)',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'gerundio - aan het, zitten te, bezig zijn');

-- =============================================================================
-- 2. Las 11 tarjetas
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'está lloviendo', 'PHRASE', 'Gerundio: presente simple',
'Het regent = llueve, y tambien esta lloviendo. El presente neerlandes cubre las dos cosas, asi que la respuesta por defecto al gerundio español es NO PONER NADA.

🔑 La regla de partida: Antes de buscar una construccion rara, prueba con el presente a secas. Wat doe je? es ¿que haces? y ¿que estas haciendo?. Ik werk es trabajo y estoy trabajando. El neerlandes solo marca el continuo cuando quiere subrayar que la accion esta en curso justo ahora.

⚠️ El error tipico del hispanohablante es traducir siempre estoy + -ando con una perifrasis. Suena forzado: si dices Ik ben aan het regenen no solo es raro, es que ni siquiera funciona con verbos meteorologicos.

📋 Casos en que el presente simple basta y sobra:
• Het regent. — Está lloviendo.
• Wat doe je? — ¿Qué estás haciendo?
• Ik werk. — Estoy trabajando.
• Hij slaapt. — Está durmiendo.
• We eten. — Estamos comiendo.

🏋️ Ejercicio: «¿que estas leyendo?» en la version normal → Wat ___ je? (Respuesta: lees.)

🔄 El gerundio que el neerlandes no tiene:

No existe una forma verbal de gerundio. El estoy + -ando español se reparte en cuatro construcciones, y la primera es no poner nada.

| como se dice | cuando | ejemplo |
|---|---|---|
| **presente simple** | por defecto, cubre lo durativo | Het **regent**. (está lloviendo) |
| **aan het** + infinitivo | subrayar que pasa ahora mismo | Ik ben **aan het** koken. |
| **zitten/staan/liggen/lopen** + te | continuo, diciendo la postura | Ik **zit** tv **te** kijken. |
| **bezig zijn met** | cuando detras va un sustantivo | Ik ben **bezig met** mijn huiswerk. |

🔑 El truco que resuelve el 90%: Empieza por el presente simple. Solo pasa a aan het si quieres subrayar que estas metido en la accion justo ahora, tipicamente para explicar que no puedes atender otra cosa.

⚠️ Y el error que hay que evitar a toda costa: la forma en -end NO es un gerundio, es un ADJETIVO. slapend es durmiente, no durmiendo. de slapende kinderen es correcto, pero «Ik ben slapend» no existe: es Ik slaap of Ik lig te slapen. El unico caso en que -end traduce un gerundio es el adverbial de modo, Hij kwam zingend binnen (entró cantando), que ademas es formal y poco frecuente.

🪑 Lo mas holandes del grupo son las posturas. El neerlandes te dice si estas sentado, de pie o tumbado mientras haces algo, y elige la de verdad: Ik zit te lezen, Hij staat te wachten, Ze ligt te slapen. Con lopen, ademas, se añade fastidio: Hij loopt te zeuren es lleva un rato dando la lata.

🕐 Y para el gerundio que dice CUANDO (saliendo de casa vi a Jan), no hay perifrasis: se convierte en subordinada con toen, als o terwijl. Para el que dice que algo CONTINUA (sigue lloviendo), presente mas nog steeds, o blijven + infinitivo: Het blijft regenen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gerundio: presente simple');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estoy cocinando', 'PHRASE', 'Gerundio: aan het koken',
'Ik ben aan het koken = estoy cocinando. Esta es la formula del continuo explicito, la mas parecida al estar + gerundio del español: zijn + AAN HET + infinitivo.

📐 El molde exacto: sujeto + zijn conjugado + aan het + INFINITIVO al final. Ik ben aan het koken. Fijate en que el verbo va en infinitivo, no en ninguna forma en -end.

⚠️ Se usa cuando quieres subrayar que estas metido en la accion AHORA MISMO, tipicamente para justificar que no puedes hacer otra cosa: Ik kan niet, ik ben aan het koken. Si no hay ese matiz, el presente simple basta.

📋 En los otros tiempos funciona igual, cambiando solo el zijn:
• Ik ben aan het koken. — Estoy cocinando.
• Ik was aan het koken. — Estaba cocinando.
• Ik ben aan het koken geweest. — He estado cocinando.
• Ik zal aan het koken zijn. — Estaré cocinando.

🚧 Con objeto, el objeto se cuela ENTRE el sujeto y el aan het: Ik ben mijn koffer aan het inpakken (estoy haciendo la maleta). No se dice «Ik ben aan het mijn koffer inpakken».

🏋️ Ejercicio: «estamos comiendo» con la forma continua → We ___ ___ ___ eten. (Respuesta: zijn aan het.)

🔄 El gerundio que el neerlandes no tiene:

No existe una forma verbal de gerundio. El estoy + -ando español se reparte en cuatro construcciones, y la primera es no poner nada.

| como se dice | cuando | ejemplo |
|---|---|---|
| **presente simple** | por defecto, cubre lo durativo | Het **regent**. (está lloviendo) |
| **aan het** + infinitivo | subrayar que pasa ahora mismo | Ik ben **aan het** koken. |
| **zitten/staan/liggen/lopen** + te | continuo, diciendo la postura | Ik **zit** tv **te** kijken. |
| **bezig zijn met** | cuando detras va un sustantivo | Ik ben **bezig met** mijn huiswerk. |

🔑 El truco que resuelve el 90%: Empieza por el presente simple. Solo pasa a aan het si quieres subrayar que estas metido en la accion justo ahora, tipicamente para explicar que no puedes atender otra cosa.

⚠️ Y el error que hay que evitar a toda costa: la forma en -end NO es un gerundio, es un ADJETIVO. slapend es durmiente, no durmiendo. de slapende kinderen es correcto, pero «Ik ben slapend» no existe: es Ik slaap of Ik lig te slapen. El unico caso en que -end traduce un gerundio es el adverbial de modo, Hij kwam zingend binnen (entró cantando), que ademas es formal y poco frecuente.

🪑 Lo mas holandes del grupo son las posturas. El neerlandes te dice si estas sentado, de pie o tumbado mientras haces algo, y elige la de verdad: Ik zit te lezen, Hij staat te wachten, Ze ligt te slapen. Con lopen, ademas, se añade fastidio: Hij loopt te zeuren es lleva un rato dando la lata.

🕐 Y para el gerundio que dice CUANDO (saliendo de casa vi a Jan), no hay perifrasis: se convierte en subordinada con toen, als o terwijl. Para el que dice que algo CONTINUA (sigue lloviendo), presente mas nog steeds, o blijven + infinitivo: Het blijft regenen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gerundio: aan het koken');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'los niños están jugando fuera', 'PHRASE', 'Gerundio: aan het spelen',
'De kinderen zijn buiten aan het spelen = los niños están jugando fuera. Fijate en donde cae buiten: el lugar va ANTES del aan het, no despues.

📐 El orden completo: sujeto + zijn + complementos (tiempo, lugar) + aan het + infinitivo. Todo lo que no sea el verbo se coloca antes del aan het, que forma bloque con el infinitivo y cierra la frase.

📋 Con el medio cada vez mas largo, para que se vea:
• De kinderen zijn aan het spelen. — Los niños están jugando.
• De kinderen zijn buiten aan het spelen. — … fuera.
• De kinderen zijn de hele middag buiten aan het spelen. — … toda la tarde fuera.
En las tres, aan het spelen se queda pegado al final.

⚠️ Y ojo con el plural de zijn: De kinderen ZIJN aan het spelen, no «is». El verbo concuerda con el sujeto normal, aunque la construccion parezca fija.

🏋️ Ejercicio: «estan trabajando en el jardin» → Ze zijn in de tuin ___ ___ werken. (Respuesta: aan het.)

🔄 El gerundio que el neerlandes no tiene:

No existe una forma verbal de gerundio. El estoy + -ando español se reparte en cuatro construcciones, y la primera es no poner nada.

| como se dice | cuando | ejemplo |
|---|---|---|
| **presente simple** | por defecto, cubre lo durativo | Het **regent**. (está lloviendo) |
| **aan het** + infinitivo | subrayar que pasa ahora mismo | Ik ben **aan het** koken. |
| **zitten/staan/liggen/lopen** + te | continuo, diciendo la postura | Ik **zit** tv **te** kijken. |
| **bezig zijn met** | cuando detras va un sustantivo | Ik ben **bezig met** mijn huiswerk. |

🔑 El truco que resuelve el 90%: Empieza por el presente simple. Solo pasa a aan het si quieres subrayar que estas metido en la accion justo ahora, tipicamente para explicar que no puedes atender otra cosa.

⚠️ Y el error que hay que evitar a toda costa: la forma en -end NO es un gerundio, es un ADJETIVO. slapend es durmiente, no durmiendo. de slapende kinderen es correcto, pero «Ik ben slapend» no existe: es Ik slaap of Ik lig te slapen. El unico caso en que -end traduce un gerundio es el adverbial de modo, Hij kwam zingend binnen (entró cantando), que ademas es formal y poco frecuente.

🪑 Lo mas holandes del grupo son las posturas. El neerlandes te dice si estas sentado, de pie o tumbado mientras haces algo, y elige la de verdad: Ik zit te lezen, Hij staat te wachten, Ze ligt te slapen. Con lopen, ademas, se añade fastidio: Hij loopt te zeuren es lleva un rato dando la lata.

🕐 Y para el gerundio que dice CUANDO (saliendo de casa vi a Jan), no hay perifrasis: se convierte en subordinada con toen, als o terwijl. Para el que dice que algo CONTINUA (sigue lloviendo), presente mas nog steeds, o blijven + infinitivo: Het blijft regenen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gerundio: aan het spelen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estaba trabajando cuando llamaste', 'PHRASE', 'Gerundio: aan het werken toen',
'Ik was aan het werken toen je belde = estaba trabajando cuando llamaste. Es el uso mas natural del continuo: marcar la accion de fondo que ya estaba en marcha cuando ocurrio otra.

📐 Aqui el continuo va con WAS, el imperfecto de zijn, porque hablas del pasado. Y la subordinada con toen manda su verbo al final: toen je BELDE.

🕐 toen es el cuando del pasado concreto, y es obligatorio aqui: no vale als ni wanneer. Como ya viste en el grupo de adverbios pronominales, toen se reserva para un momento pasado y puntual.

📋 El mismo contraste, que es donde el continuo gana de verdad:
• Ik werkte toen je belde. — Trabajaba cuando llamaste. Correcto, pero plano.
• Ik was aan het werken toen je belde. — Estaba trabajando. Subraya que la accion ya estaba en curso.
• Ik zat te werken toen je belde. — Igual, y ademas dice que estaba sentado.

🏋️ Ejercicio: «estaba durmiendo cuando llegaste» → Ik ___ aan het slapen ___ je aankwam. (Respuestas: was … toen.)

🔄 El gerundio que el neerlandes no tiene:

No existe una forma verbal de gerundio. El estoy + -ando español se reparte en cuatro construcciones, y la primera es no poner nada.

| como se dice | cuando | ejemplo |
|---|---|---|
| **presente simple** | por defecto, cubre lo durativo | Het **regent**. (está lloviendo) |
| **aan het** + infinitivo | subrayar que pasa ahora mismo | Ik ben **aan het** koken. |
| **zitten/staan/liggen/lopen** + te | continuo, diciendo la postura | Ik **zit** tv **te** kijken. |
| **bezig zijn met** | cuando detras va un sustantivo | Ik ben **bezig met** mijn huiswerk. |

🔑 El truco que resuelve el 90%: Empieza por el presente simple. Solo pasa a aan het si quieres subrayar que estas metido en la accion justo ahora, tipicamente para explicar que no puedes atender otra cosa.

⚠️ Y el error que hay que evitar a toda costa: la forma en -end NO es un gerundio, es un ADJETIVO. slapend es durmiente, no durmiendo. de slapende kinderen es correcto, pero «Ik ben slapend» no existe: es Ik slaap of Ik lig te slapen. El unico caso en que -end traduce un gerundio es el adverbial de modo, Hij kwam zingend binnen (entró cantando), que ademas es formal y poco frecuente.

🪑 Lo mas holandes del grupo son las posturas. El neerlandes te dice si estas sentado, de pie o tumbado mientras haces algo, y elige la de verdad: Ik zit te lezen, Hij staat te wachten, Ze ligt te slapen. Con lopen, ademas, se añade fastidio: Hij loopt te zeuren es lleva un rato dando la lata.

🕐 Y para el gerundio que dice CUANDO (saliendo de casa vi a Jan), no hay perifrasis: se convierte en subordinada con toen, als o terwijl. Para el que dice que algo CONTINUA (sigue lloviendo), presente mas nog steeds, o blijven + infinitivo: Het blijft regenen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gerundio: aan het werken toen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estoy viendo la tele', 'PHRASE', 'Gerundio: zitten te kijken',
'Ik zit tv te kijken = estoy viendo la tele. Y aqui viene lo mas holandes de todo: el neerlandes dice en que POSTURA estas mientras haces algo. Literalmente, estoy sentado a ver la tele.

📐 El molde: zitten, staan, liggen o lopen conjugado + complementos + TE + infinitivo al final. Ik zit tv te kijken. El te es obligatorio y va pegado al infinitivo.

🪑 Las cuatro posturas, que se eligen por la de verdad:
• zitten te — sentado. Ik zit te lezen. (estoy leyendo, sentado)
• staan te — de pie. Hij staat te wachten. (está esperando, de pie)
• liggen te — tumbado. Ze ligt te slapen. (está durmiendo)
• lopen te — andando, o de fondo con matiz de insistencia. Hij loopt te mopperen. (va quejándose)

⚠️ No es un adorno: si dices Ik zit te koken suena raro, porque no se cocina sentado. Elige la postura real, o usa aan het, que es neutro.

💬 Y en perfecto, estas construcciones pierden el te y usan doble infinitivo: Ik heb zitten kijken (he estado viendo). Es el mismo IPP de los modales que ya tienes en el mazo.

🏋️ Ejercicio: «esta esperando de pie» → Hij ___ ___ wachten. (Respuesta: staat te.)

🔄 El gerundio que el neerlandes no tiene:

No existe una forma verbal de gerundio. El estoy + -ando español se reparte en cuatro construcciones, y la primera es no poner nada.

| como se dice | cuando | ejemplo |
|---|---|---|
| **presente simple** | por defecto, cubre lo durativo | Het **regent**. (está lloviendo) |
| **aan het** + infinitivo | subrayar que pasa ahora mismo | Ik ben **aan het** koken. |
| **zitten/staan/liggen/lopen** + te | continuo, diciendo la postura | Ik **zit** tv **te** kijken. |
| **bezig zijn met** | cuando detras va un sustantivo | Ik ben **bezig met** mijn huiswerk. |

🔑 El truco que resuelve el 90%: Empieza por el presente simple. Solo pasa a aan het si quieres subrayar que estas metido en la accion justo ahora, tipicamente para explicar que no puedes atender otra cosa.

⚠️ Y el error que hay que evitar a toda costa: la forma en -end NO es un gerundio, es un ADJETIVO. slapend es durmiente, no durmiendo. de slapende kinderen es correcto, pero «Ik ben slapend» no existe: es Ik slaap of Ik lig te slapen. El unico caso en que -end traduce un gerundio es el adverbial de modo, Hij kwam zingend binnen (entró cantando), que ademas es formal y poco frecuente.

🪑 Lo mas holandes del grupo son las posturas. El neerlandes te dice si estas sentado, de pie o tumbado mientras haces algo, y elige la de verdad: Ik zit te lezen, Hij staat te wachten, Ze ligt te slapen. Con lopen, ademas, se añade fastidio: Hij loopt te zeuren es lleva un rato dando la lata.

🕐 Y para el gerundio que dice CUANDO (saliendo de casa vi a Jan), no hay perifrasis: se convierte en subordinada con toen, als o terwijl. Para el que dice que algo CONTINUA (sigue lloviendo), presente mas nog steeds, o blijven + infinitivo: Het blijft regenen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gerundio: zitten te kijken');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'está esperando en la puerta (él)', 'PHRASE', 'Gerundio: staan te wachten',
'Hij staat bij de deur te wachten = está esperando en la puerta. staan te es la postura de pie, y con wachten es de las combinaciones que mas se oyen: esperar se hace de pie.

📐 El orden: staat (2a posicion) + el lugar (bij de deur) + te wachten al final. Todo el relleno va en medio y el bloque te + infinitivo cierra.

📋 Las combinaciones que suenan naturales con cada postura:
• staan te wachten, te praten, te kijken — esperar, charlar, mirar. De pie.
• zitten te lezen, te werken, te eten — leer, trabajar, comer. Sentado.
• liggen te slapen, te rusten — dormir, descansar. Tumbado.
• lopen te zeuren, te mopperen — dar la lata, refunfuñar. Aquí lopen no es andar de verdad: añade el matiz de que la cosa dura y cansa.

⚠️ Fijate en que lopen te ha perdido su sentido literal en esas expresiones. Hij loopt te zeuren no dice que vaya andando: dice que lleva un rato dando la lata. Es el uso mas idiomatico de los cuatro.

🏋️ Ejercicio: «esta tumbada leyendo» → Ze ___ ___ lezen. (Respuesta: ligt te.)

🔄 El gerundio que el neerlandes no tiene:

No existe una forma verbal de gerundio. El estoy + -ando español se reparte en cuatro construcciones, y la primera es no poner nada.

| como se dice | cuando | ejemplo |
|---|---|---|
| **presente simple** | por defecto, cubre lo durativo | Het **regent**. (está lloviendo) |
| **aan het** + infinitivo | subrayar que pasa ahora mismo | Ik ben **aan het** koken. |
| **zitten/staan/liggen/lopen** + te | continuo, diciendo la postura | Ik **zit** tv **te** kijken. |
| **bezig zijn met** | cuando detras va un sustantivo | Ik ben **bezig met** mijn huiswerk. |

🔑 El truco que resuelve el 90%: Empieza por el presente simple. Solo pasa a aan het si quieres subrayar que estas metido en la accion justo ahora, tipicamente para explicar que no puedes atender otra cosa.

⚠️ Y el error que hay que evitar a toda costa: la forma en -end NO es un gerundio, es un ADJETIVO. slapend es durmiente, no durmiendo. de slapende kinderen es correcto, pero «Ik ben slapend» no existe: es Ik slaap of Ik lig te slapen. El unico caso en que -end traduce un gerundio es el adverbial de modo, Hij kwam zingend binnen (entró cantando), que ademas es formal y poco frecuente.

🪑 Lo mas holandes del grupo son las posturas. El neerlandes te dice si estas sentado, de pie o tumbado mientras haces algo, y elige la de verdad: Ik zit te lezen, Hij staat te wachten, Ze ligt te slapen. Con lopen, ademas, se añade fastidio: Hij loopt te zeuren es lleva un rato dando la lata.

🕐 Y para el gerundio que dice CUANDO (saliendo de casa vi a Jan), no hay perifrasis: se convierte en subordinada con toen, als o terwijl. Para el que dice que algo CONTINUA (sigue lloviendo), presente mas nog steeds, o blijven + infinitivo: Het blijft regenen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gerundio: staan te wachten');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estoy con los deberes', 'PHRASE', 'Gerundio: bezig zijn met',
'Ik ben bezig met mijn huiswerk = estoy con los deberes. bezig zijn met es la cuarta manera de decir el continuo, y la que se usa cuando lo que sigue es un SUSTANTIVO y no un verbo.

🎭 Las dos construcciones hermanas, que se eligen por lo que viene detras:
• Con SUSTANTIVO — bezig zijn MET. Ik ben bezig met mijn huiswerk.
• Con VERBO — aan het + infinitivo. Ik ben mijn huiswerk aan het maken.
Las dos dicen lo mismo; cambia si nombras la cosa o la accion.

📋 bezig en el dia a dia:
• Waar ben je mee bezig? — ¿En qué andas? (ya en tu mazo)
• Ik ben druk bezig. — Estoy muy liado.
• Hij is bezig met een nieuw project. — Está con un proyecto nuevo.
• Nu je toch bezig bent… — Ya que estás…

⚠️ Y ojo a bezig frente a bezet, que se parecen: bezig es estar ocupado HACIENDO algo, y bezet es estar ocupado un sitio o una linea. De stoel is bezet (la silla está ocupada), Ik ben bezig (estoy liado).

🏋️ Ejercicio: «esta con la mudanza» → Hij is ___ ___ de verhuizing. (Respuesta: bezig met.)

🔄 El gerundio que el neerlandes no tiene:

No existe una forma verbal de gerundio. El estoy + -ando español se reparte en cuatro construcciones, y la primera es no poner nada.

| como se dice | cuando | ejemplo |
|---|---|---|
| **presente simple** | por defecto, cubre lo durativo | Het **regent**. (está lloviendo) |
| **aan het** + infinitivo | subrayar que pasa ahora mismo | Ik ben **aan het** koken. |
| **zitten/staan/liggen/lopen** + te | continuo, diciendo la postura | Ik **zit** tv **te** kijken. |
| **bezig zijn met** | cuando detras va un sustantivo | Ik ben **bezig met** mijn huiswerk. |

🔑 El truco que resuelve el 90%: Empieza por el presente simple. Solo pasa a aan het si quieres subrayar que estas metido en la accion justo ahora, tipicamente para explicar que no puedes atender otra cosa.

⚠️ Y el error que hay que evitar a toda costa: la forma en -end NO es un gerundio, es un ADJETIVO. slapend es durmiente, no durmiendo. de slapende kinderen es correcto, pero «Ik ben slapend» no existe: es Ik slaap of Ik lig te slapen. El unico caso en que -end traduce un gerundio es el adverbial de modo, Hij kwam zingend binnen (entró cantando), que ademas es formal y poco frecuente.

🪑 Lo mas holandes del grupo son las posturas. El neerlandes te dice si estas sentado, de pie o tumbado mientras haces algo, y elige la de verdad: Ik zit te lezen, Hij staat te wachten, Ze ligt te slapen. Con lopen, ademas, se añade fastidio: Hij loopt te zeuren es lleva un rato dando la lata.

🕐 Y para el gerundio que dice CUANDO (saliendo de casa vi a Jan), no hay perifrasis: se convierte en subordinada con toen, als o terwijl. Para el que dice que algo CONTINUA (sigue lloviendo), presente mas nog steeds, o blijven + infinitivo: Het blijft regenen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gerundio: bezig zijn met');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'los niños que duermen', 'PHRASE', 'Gerundio: end es adjetivo',
'de slapende kinderen = los niños que duermen, los niños dormidos. Y aqui esta EL error clasico del hispanohablante: la forma en -end existe, pero NO es un gerundio. Es un ADJETIVO.

⚠️ slapend no significa durmiendo sino durmiente. Por eso de slapende kinderen son los niños que duermen, pero NO se puede decir «Ik ben slapend» para estoy durmiendo. Eso es Ik slaap of Ik lig te slapen.

📐 Como se forma y como se usa: infinitivo + -D, y se declina como cualquier adjetivo, con su -e delante del sustantivo. slapen → slapend → de slapende kinderen.

📋 Los que veras por todas partes, todos como adjetivo:
• een lopende band — una cinta transportadora.
• stromend water — agua corriente.
• de volgende week — la semana que viene.
• een bestaande klant — un cliente existente.
• de betreffende persoon — la persona en cuestión.

🔑 El truco que evita el error: Si en español puedes cambiar el -ando por «que + verbo», es adjetivo y va con -end. Los niños DURMIENDO = los niños QUE DUERMEN → de slapende kinderen. Si no puedes, es continuo y necesitas aan het o una postura.

🏋️ Ejercicio: «agua corriente» → ___ water. (Respuesta: stromend.)

🔄 El gerundio que el neerlandes no tiene:

No existe una forma verbal de gerundio. El estoy + -ando español se reparte en cuatro construcciones, y la primera es no poner nada.

| como se dice | cuando | ejemplo |
|---|---|---|
| **presente simple** | por defecto, cubre lo durativo | Het **regent**. (está lloviendo) |
| **aan het** + infinitivo | subrayar que pasa ahora mismo | Ik ben **aan het** koken. |
| **zitten/staan/liggen/lopen** + te | continuo, diciendo la postura | Ik **zit** tv **te** kijken. |
| **bezig zijn met** | cuando detras va un sustantivo | Ik ben **bezig met** mijn huiswerk. |

🔑 El truco que resuelve el 90%: Empieza por el presente simple. Solo pasa a aan het si quieres subrayar que estas metido en la accion justo ahora, tipicamente para explicar que no puedes atender otra cosa.

⚠️ Y el error que hay que evitar a toda costa: la forma en -end NO es un gerundio, es un ADJETIVO. slapend es durmiente, no durmiendo. de slapende kinderen es correcto, pero «Ik ben slapend» no existe: es Ik slaap of Ik lig te slapen. El unico caso en que -end traduce un gerundio es el adverbial de modo, Hij kwam zingend binnen (entró cantando), que ademas es formal y poco frecuente.

🪑 Lo mas holandes del grupo son las posturas. El neerlandes te dice si estas sentado, de pie o tumbado mientras haces algo, y elige la de verdad: Ik zit te lezen, Hij staat te wachten, Ze ligt te slapen. Con lopen, ademas, se añade fastidio: Hij loopt te zeuren es lleva un rato dando la lata.

🕐 Y para el gerundio que dice CUANDO (saliendo de casa vi a Jan), no hay perifrasis: se convierte en subordinada con toen, als o terwijl. Para el que dice que algo CONTINUA (sigue lloviendo), presente mas nog steeds, o blijven + infinitivo: Het blijft regenen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gerundio: end es adjetivo');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'entró cantando (él)', 'PHRASE', 'Gerundio: zingend binnen',
'Hij kwam zingend binnen = entró cantando. Este es el UNICO caso en que la forma en -end si traduce un gerundio español: cuando dice de que MANERA se hace la accion principal.

📐 Aqui zingend funciona como adverbio de modo: no dice que el sujeto sea cantante, dice como entro. Va en el medio de la frase, antes de la particula binnen del separable binnenkomen.

📋 Los que se usan de verdad, y son pocos:
• Hij kwam zingend binnen. — Entró cantando.
• Ze ging huilend weg. — Se fue llorando.
• Lopend ben je er sneller. — Andando llegas antes.
• Al pratend losten we het op. — Hablando lo resolvimos.

⚠️ Es una construccion algo formal y limitada: no se puede fabricar con cualquier verbo. En el habla corriente se prefiere partirlo en dos frases o usar een subordinada: Hij zong toen hij binnenkwam.

🎭 No lo confundas con el -end ADJETIVO de la tarjeta de slapende kinderen. Aqui modifica al verbo (como entro) y alli modifica al sustantivo (que niños son). Misma forma, dos oficios.

🏋️ Ejercicio: «se fue llorando» → Ze ging ___ weg. (Respuesta: huilend.)

🔄 El gerundio que el neerlandes no tiene:

No existe una forma verbal de gerundio. El estoy + -ando español se reparte en cuatro construcciones, y la primera es no poner nada.

| como se dice | cuando | ejemplo |
|---|---|---|
| **presente simple** | por defecto, cubre lo durativo | Het **regent**. (está lloviendo) |
| **aan het** + infinitivo | subrayar que pasa ahora mismo | Ik ben **aan het** koken. |
| **zitten/staan/liggen/lopen** + te | continuo, diciendo la postura | Ik **zit** tv **te** kijken. |
| **bezig zijn met** | cuando detras va un sustantivo | Ik ben **bezig met** mijn huiswerk. |

🔑 El truco que resuelve el 90%: Empieza por el presente simple. Solo pasa a aan het si quieres subrayar que estas metido en la accion justo ahora, tipicamente para explicar que no puedes atender otra cosa.

⚠️ Y el error que hay que evitar a toda costa: la forma en -end NO es un gerundio, es un ADJETIVO. slapend es durmiente, no durmiendo. de slapende kinderen es correcto, pero «Ik ben slapend» no existe: es Ik slaap of Ik lig te slapen. El unico caso en que -end traduce un gerundio es el adverbial de modo, Hij kwam zingend binnen (entró cantando), que ademas es formal y poco frecuente.

🪑 Lo mas holandes del grupo son las posturas. El neerlandes te dice si estas sentado, de pie o tumbado mientras haces algo, y elige la de verdad: Ik zit te lezen, Hij staat te wachten, Ze ligt te slapen. Con lopen, ademas, se añade fastidio: Hij loopt te zeuren es lleva un rato dando la lata.

🕐 Y para el gerundio que dice CUANDO (saliendo de casa vi a Jan), no hay perifrasis: se convierte en subordinada con toen, als o terwijl. Para el que dice que algo CONTINUA (sigue lloviendo), presente mas nog steeds, o blijven + infinitivo: Het blijft regenen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gerundio: zingend binnen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'saliendo de casa vi a Jan', 'PHRASE', 'Gerundio: subordinada con toen',
'Toen ik het huis uitging, zag ik Jan = saliendo de casa vi a Jan. Cuando el gerundio español marca CUANDO pasa algo, el neerlandes lo convierte en una subordinada de tiempo con toen, als o terwijl.

📐 El reparto: la subordinada manda su verbo al final (toen ik het huis UITGING) y la principal invierte porque va detras (ZAG IK Jan).

🎭 La conjuncion se elige por el tipo de tiempo, como ya viste en el grupo de adverbios pronominales:
• toen — un momento concreto del pasado. Toen ik binnenkwam, zag ik hem.
• als — futuro o repetido. Als ik thuiskom, bel ik je.
• terwijl — dos acciones a la vez. Terwijl jij kookt, dek ik de tafel.

⚠️ El gerundio español es comodisimo porque no dice cuando: «saliendo de casa» vale para pasado, presente y futuro. El neerlandes te obliga a decidirlo, y por eso hay que elegir conjuncion.

🔑 El truco: Si el gerundio español contesta a «¿cuándo?», no busques perifrasis: convierte la frase en una subordinada con toen, als o terwijl.

🏋️ Ejercicio: «mientras tu cocinas, pongo la mesa» → ___ jij kookt, dek ik de tafel. (Respuesta: Terwijl.)

🔄 El gerundio que el neerlandes no tiene:

No existe una forma verbal de gerundio. El estoy + -ando español se reparte en cuatro construcciones, y la primera es no poner nada.

| como se dice | cuando | ejemplo |
|---|---|---|
| **presente simple** | por defecto, cubre lo durativo | Het **regent**. (está lloviendo) |
| **aan het** + infinitivo | subrayar que pasa ahora mismo | Ik ben **aan het** koken. |
| **zitten/staan/liggen/lopen** + te | continuo, diciendo la postura | Ik **zit** tv **te** kijken. |
| **bezig zijn met** | cuando detras va un sustantivo | Ik ben **bezig met** mijn huiswerk. |

🔑 El truco que resuelve el 90%: Empieza por el presente simple. Solo pasa a aan het si quieres subrayar que estas metido en la accion justo ahora, tipicamente para explicar que no puedes atender otra cosa.

⚠️ Y el error que hay que evitar a toda costa: la forma en -end NO es un gerundio, es un ADJETIVO. slapend es durmiente, no durmiendo. de slapende kinderen es correcto, pero «Ik ben slapend» no existe: es Ik slaap of Ik lig te slapen. El unico caso en que -end traduce un gerundio es el adverbial de modo, Hij kwam zingend binnen (entró cantando), que ademas es formal y poco frecuente.

🪑 Lo mas holandes del grupo son las posturas. El neerlandes te dice si estas sentado, de pie o tumbado mientras haces algo, y elige la de verdad: Ik zit te lezen, Hij staat te wachten, Ze ligt te slapen. Con lopen, ademas, se añade fastidio: Hij loopt te zeuren es lleva un rato dando la lata.

🕐 Y para el gerundio que dice CUANDO (saliendo de casa vi a Jan), no hay perifrasis: se convierte en subordinada con toen, als o terwijl. Para el que dice que algo CONTINUA (sigue lloviendo), presente mas nog steeds, o blijven + infinitivo: Het blijft regenen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gerundio: subordinada con toen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'sigue lloviendo', 'PHRASE', 'Gerundio: nog steeds continuo',
'Het regent nog steeds = sigue lloviendo. Para el sigue + gerundio del español no hay perifrasis: se dice con el presente normal mas nog o nog steeds.

⚠️ Aqui esta el aviso que da sentido a todo el grupo: nog NO es la marca del gerundio. nog significa todavia. En Ik denk er nog over na, el gerundio ya esta en denk, y nog solo añade que la decision sigue pendiente. Quita el nog y sigue siendo lo estoy pensando.

🎚️ Las maneras de decir que algo continua:
• Het regent nog. — Todavía llueve.
• Het regent nog steeds. — Sigue lloviendo. Con enfasis, y a menudo con hartazgo.
• Het blijft regenen. — Sigue lloviendo, no para. Con blijven, que es el verbo de seguir.
• Het is nog steeds aan het regenen. — Todavía está lloviendo. Continuo explicito.

📋 blijven + infinitivo es la forma mas limpia del seguir + gerundio: Hij blijft praten (sigue hablando), Ze blijft het proberen (sigue intentandolo). Sin te y sin nada en medio.

🏋️ Ejercicio: «sigue hablando» con blijven → Hij ___ praten. (Respuesta: blijft.)

🔄 El gerundio que el neerlandes no tiene:

No existe una forma verbal de gerundio. El estoy + -ando español se reparte en cuatro construcciones, y la primera es no poner nada.

| como se dice | cuando | ejemplo |
|---|---|---|
| **presente simple** | por defecto, cubre lo durativo | Het **regent**. (está lloviendo) |
| **aan het** + infinitivo | subrayar que pasa ahora mismo | Ik ben **aan het** koken. |
| **zitten/staan/liggen/lopen** + te | continuo, diciendo la postura | Ik **zit** tv **te** kijken. |
| **bezig zijn met** | cuando detras va un sustantivo | Ik ben **bezig met** mijn huiswerk. |

🔑 El truco que resuelve el 90%: Empieza por el presente simple. Solo pasa a aan het si quieres subrayar que estas metido en la accion justo ahora, tipicamente para explicar que no puedes atender otra cosa.

⚠️ Y el error que hay que evitar a toda costa: la forma en -end NO es un gerundio, es un ADJETIVO. slapend es durmiente, no durmiendo. de slapende kinderen es correcto, pero «Ik ben slapend» no existe: es Ik slaap of Ik lig te slapen. El unico caso en que -end traduce un gerundio es el adverbial de modo, Hij kwam zingend binnen (entró cantando), que ademas es formal y poco frecuente.

🪑 Lo mas holandes del grupo son las posturas. El neerlandes te dice si estas sentado, de pie o tumbado mientras haces algo, y elige la de verdad: Ik zit te lezen, Hij staat te wachten, Ze ligt te slapen. Con lopen, ademas, se añade fastidio: Hij loopt te zeuren es lleva un rato dando la lata.

🕐 Y para el gerundio que dice CUANDO (saliendo de casa vi a Jan), no hay perifrasis: se convierte en subordinada con toen, als o terwijl. Para el que dice que algo CONTINUA (sigue lloviendo), presente mas nog steeds, o blijven + infinitivo: Het blijft regenen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gerundio: nog steeds continuo');

-- =============================================================================
-- 3. Traducciones
-- =============================================================================
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
SELECT we.id, 'nl_NL', v.nl, v.pron
FROM (
    SELECT 'Gerundio: presente simple' AS k, 'Het regent.' AS nl, 'het reejent' AS pron
    UNION ALL SELECT 'Gerundio: aan het koken', 'Ik ben aan het koken.', 'ik ben aan het kooken'
    UNION ALL SELECT 'Gerundio: aan het spelen', 'De kinderen zijn buiten aan het spelen.', 'de kínderen zain baiten aan het speelen'
    UNION ALL SELECT 'Gerundio: aan het werken toen', 'Ik was aan het werken toen je belde.', 'ik vas aan het verken tun ye belde'
    UNION ALL SELECT 'Gerundio: zitten te kijken', 'Ik zit tv te kijken.', 'ik zit tee-fee te kaiken'
    UNION ALL SELECT 'Gerundio: staan te wachten', 'Hij staat bij de deur te wachten.', 'hai staat bai de deur te vajten'
    UNION ALL SELECT 'Gerundio: bezig zijn met', 'Ik ben bezig met mijn huiswerk.', 'ik ben beezej met main haisverk'
    UNION ALL SELECT 'Gerundio: end es adjetivo', 'de slapende kinderen', 'de slaapende kínderen'
    UNION ALL SELECT 'Gerundio: zingend binnen', 'Hij kwam zingend binnen.', 'hai kuam zingent binen'
    UNION ALL SELECT 'Gerundio: subordinada con toen', 'Toen ik het huis uitging, zag ik Jan.', 'tun ik het hais áutjing, zaj ik yan'
    UNION ALL SELECT 'Gerundio: nog steeds continuo', 'Het regent nog steeds.', 'het reejent noj steets'
) v
JOIN words_es we ON we.notes = v.k;

-- =============================================================================
-- 4. Al grupo nuevo y a generic
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Gerundio: %' AND g.title = 'gerundio - aan het, zitten te, bezig zijn';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Gerundio: %' AND g.title = 'generic';

-- =============================================================================
-- 5. Las tres que ya existian y son de esta familia
--    765 (Hij zit te lezen), 953 (aan het inpakken) y 1032 (la de la duda)
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE g.title = 'gerundio - aan het, zitten te, bezig zijn' AND we.id IN (765, 953, 1032);

-- =============================================================================
-- 6. La 1032: el nog no es el gerundio
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: ¿Para el gerundio se usa nog? ¿En que casos?

🔑 La respuesta corta: El nog NO es la marca del gerundio. Aqui nog significa TODAVIA, y es el mismo nog del cuadrado al / nog / nog niet / niet meer. El gerundio ya esta en denk: si quitas el nog, Ik denk erover na sigue siendo lo estoy pensando. Lo unico que añade nog es que la decision sigue pendiente.

| frase | que dice |
|---|---|
| Ik denk erover na. | Lo estoy pensando. |
| Ik denk er **nog** over na. | **Todavia** lo estoy pensando. |
| Ik denk er **niet meer** over na. | **Ya no** le doy vueltas. |

⚠️ Asi que nog no se usa NUNCA para marcar el gerundio: se usa para decir que algo continua. Son dos cosas distintas que en esta frase coinciden y por eso confunden.

🔄 El gerundio de verdad se hace de otras cuatro maneras, y las tienes en este grupo: el presente simple (lo normal), aan het + infinitivo, las posturas con zitten/staan/liggen/lopen + te, y bezig zijn met.

📐 Y de propina, el verbo de esta tarjeta: nadenken over es reflexionar sobre algo, y es SEPARABLE. Por eso el na se va al final: Ik denk erover na. En subordinada se reune: … dat ik erover nadenk.

🏋️ Ejercicio: «ya no me lo pienso mas» → Ik denk er ___ ___ over na. (Respuesta: niet meer.)'
WHERE id = 1032
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';
