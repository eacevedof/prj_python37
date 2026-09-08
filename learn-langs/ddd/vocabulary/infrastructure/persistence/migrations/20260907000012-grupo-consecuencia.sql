-- Learn Languages App - Migration
-- Migration: 20260907000012-grupo-consecuencia
-- Description: Eduardo: "crea un grupo con dus vs dan no se como diferenciar cuando usar
--   para explicar una consecuencia".
--
--   Estado del mazo antes: dus estaba bien cubierto (273, 488-491), y tambien want
--   (272, 483-486), omdat (274, 399, 424, 493, 494) y zodat (279, 516-520) dentro del
--   grupo 13 de conjunciones. Pero dan NO existia como consecuencia: solo aparecia en
--   comparativos (827, 890) y en locuciones (409, 414). Y daarom, daardoor, vandaar,
--   doordat y aangezien estaban a CERO.
--
--   La diferencia que pide Eduardo: dus DEDUCE y dan ORDENA en el tiempo. dus es la
--   conclusion logica (Ik denk, dus ik ben, con el «luego» logico de pienso luego existo);
--   dan es la secuencia temporal o el correlato de als (Als het regent, dan blijf ik
--   thuis). Y hay una diferencia gramatical dura que es la que mas se falla: dus es de las
--   cinco coordinantes y NO cambia el orden, mientras dan, daarom, daardoor y vandaar son
--   adverbios y en primera posicion obligan a invertir. dus admite ademas las dos
--   versiones (dus ik blijf thuis y dus blijf ik thuis), lo que despista mas.
--
--   15 tarjetas PHRASE: dus sin inversion y con inversion, dan como correlato de als,
--   dan temporal, dan abriendo frase, dan al final en preguntas, daarom, daardoor,
--   vandaar, aangezien, doordat, la locucion wat dan ook, el orden de palabras con
--   daarom, la replica Nou, dan niet, y el cogito como percha para dus.
--   Un bloque compartido con el mapa de los diez conectores por eje (causa o consecuencia)
--   y por voluntad, la regla de bolsillo y el aviso de daarom frente a daardoor.
--
--   El dan COMPARATIVO (groter dan) no se duplica aqui: se remite al grupo de
--   comparativos, que Eduardo pidio a continuacion.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'consecuencia - dus, dan, daarom, daardoor',
       'El español dice porque, asi que y por eso para casi todo, y el neerlandes lo reparte por dos ejes: si señalas la causa o la consecuencia, y si hay voluntad detras o no. dus deduce (conclusion logica) y dan ordena en el tiempo o responde a un als; daarom es por eso con una decision detras y daardoor es por eso sin voluntad, un efecto que simplemente ocurre. Del lado de la causa, want no cambia el orden, omdat y doordat mandan el verbo al final y aangezien es el formal. Incluye la diferencia de orden de palabras, que es la que mas se falla: dus es coordinante y no toca nada, mientras dan, daarom, daardoor y vandaar son adverbios y obligan a invertir',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'consecuencia - dus, dan, daarom, daardoor');

-- =============================================================================
-- 2. Las 15 tarjetas
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'está cerrado, así que volvemos mañana', 'PHRASE', 'Consecuencia: dus sin inversion',
'Het is gesloten, dus we komen morgen terug = esta cerrado, asi que volvemos mañana. dus es la conjuncion de la CONSECUENCIA LOGICA: delante va la causa, detras la conclusion que sacas de ella.

📐 dus es una de las cinco coordinantes (en, maar, of, want, dus), asi que NO cambia el orden: detras viene sujeto + verbo, como en una frase normal. dus WE KOMEN morgen terug.

⚠️ Y aqui esta el lio con dan: dan tambien se traduce por entonces, pero es un ADVERBIO, no una conjuncion, y por eso obliga a invertir. Compara: dus we komen terug frente a dan komen we terug. Las dos son correctas, pero el orden es distinto porque la pieza es distinta.

🔑 El truco: Cambia el conector por «por lo tanto». Si la frase sigue teniendo sentido, es dus. Si lo que pega es «luego» o «despues», es dan.

🏋️ Ejercicio: «no hay pan, asi que voy a la panaderia» → Er is geen brood, ___ ik ga naar de bakker. (Respuesta: dus.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: dus sin inversion');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'llueve, así que me quedo en casa', 'PHRASE', 'Consecuencia: dus con inversion',
'Het regent, dus blijf ik thuis = llueve, asi que me quedo en casa. Fijate en el orden: aqui dus va seguido del VERBO y luego el sujeto. Las dos versiones existen y las dos son correctas.

🎭 Las dos caras de dus, que confunden porque parecen contradecirse:
• dus como CONJUNCION coordinante — Het regent, dus ik blijf thuis. Sin inversion, sujeto delante.
• dus como ADVERBIO en primera posicion — Het regent, dus blijf ik thuis. Con inversion, verbo delante.

⚠️ Ninguna de las dos esta mal. La segunda suena algo mas cuidada y es la que veras escrita; la primera es la corriente al hablar. Lo que NO existe es mezclarlas: «dus blijf ik thuis» con sujeto repetido, o «dus ik blijf ik».

📐 La regla de fondo: si dus cuenta como primera posicion de la frase, el verbo va segundo y el sujeto tercero. Si dus solo une dos frases, la segunda arranca normal.

🏋️ Ejercicio: pasa a la version con inversion «Ik ben moe, dus ik ga naar bed» → Ik ben moe, dus ___ ___ naar bed. (Respuesta: ga ik.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: dus con inversion');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'si llueve, entonces me quedo en casa', 'PHRASE', 'Consecuencia: dan tras als',
'Als het regent, dan blijf ik thuis = si llueve, entonces me quedo en casa. Este es el dan mas util: el que responde a un als. Van en pareja, como el si… entonces del español.

📐 dan es ADVERBIO y ocupa la primera posicion de la principal, asi que detras va el VERBO y luego el sujeto: dan BLIJF IK. Nunca «dan ik blijf».

⚠️ El dan es opcional pero muy natural. Als het regent, blijf ik thuis tambien es correcto: al ir la subordinada delante, la principal ya invierte igual. Lo que no puedes es poner el sujeto delante: «Als het regent, ik blijf thuis» esta mal.

📋 Los correlatos que funcionan igual, todos con inversion detras:
• Als… dan… — Als je komt, dan bel ik je. (si vienes, entonces te llamo)
• Wanneer… dan… — Wanneer het klaar is, dan zeg ik het. (cuando este listo, te aviso)
• Mocht… dan… — Mocht het regenen, dan gaan we niet. (si llegara a llover, no vamos)
• Hoe meer… hoe beter — Hoe eerder, hoe beter. (cuanto antes, mejor)

🔑 El truco: Si el conector responde a un si o a un cuando, es dan. Si saca una conclusion logica, es dus.

🏋️ Ejercicio: «si tienes tiempo, entonces quedamos» → Als je tijd hebt, ___ ___ we af. (Respuesta: dan spreken.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: dan tras als');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'primero comemos y luego nos vamos', 'PHRASE', 'Consecuencia: dan temporal',
'Eerst eten we, dan gaan we weg = primero comemos y luego nos vamos. Aqui dan no saca ninguna conclusion: solo ordena en el TIEMPO. Es el luego, el despues.

🕐 La secuencia temporal completa, que es como se cuenta cualquier plan:
• eerst — primero. Eerst eten we.
• dan — luego, entonces. Dan gaan we weg.
• daarna — despues de eso. Daarna drinken we koffie.
• vervolgens — a continuacion, mas formal.
• ten slotte / uiteindelijk — por ultimo, al final.

⚠️ dan y daarna se parecen pero no son iguales: dan es el siguiente paso sin mas, y daarna señala explicitamente que va DESPUES de lo anterior. En una receta o unas instrucciones veras los dos alternandose.

📐 Y otra vez el orden: dan en primera posicion obliga a invertir. dan GAAN WE weg, nunca «dan we gaan».

🔑 El truco: Si puedes cambiar el conector por «luego» o «despues», es dan y no dus.

🏋️ Ejercicio: «primero trabajo y luego descanso» → Eerst werk ik, ___ ___ ik uit. (Respuesta: dan rust.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: dan temporal');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'entonces te veo mañana', 'PHRASE', 'Consecuencia: dan al inicio',
'Dan zie ik je morgen = entonces te veo mañana. dan abriendo frase es lo que dices para cerrar un acuerdo: se da por hecho lo hablado y se saca la consecuencia practica.

📐 dan en primera posicion, verbo en segunda, sujeto en tercera: Dan ZIE IK je morgen. Es la inversion de siempre.

💬 Las que oiras a diario para cerrar un plan:
• Dan zie ik je morgen. — Entonces te veo mañana.
• Dan doen we dat. — Pues hacemos eso.
• Dan is het geregeld. — Entonces queda arreglado.
• Tot dan! — ¡Hasta entonces!
• Dan niet. — Pues nada. (cuando algo se cae)

🎭 Y ojo a la diferencia con dus abriendo frase, que no es lo mismo: Dus jij komt niet? es asi que no vienes, con cara de estar sacando una conclusion, incluso con reproche. Dan zie ik je morgen no reprocha nada: solo ordena lo que viene.

🏋️ Ejercicio: «entonces quedamos el viernes» → ___ ___ we vrijdag af. (Respuesta: Dan spreken.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: dan al inicio');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿y entonces qué hacemos?', 'PHRASE', 'Consecuencia: dan en pregunta',
'En wat doen we dan? = ¿y entonces qué hacemos? Aqui dan va al FINAL, y es donde suele caer cuando la frase es una pregunta con palabra-W.

📐 En una pregunta con wat, wie, hoe o waar, dan se va al final del medio de la frase: Wat doen we dan? Hoe weet je dat dan? Waarom zeg je dat dan?

💬 Ese dan final añade un matiz de y entonces, de estar pidiendo que te resuelvan lo que queda colgando:
• Wat doen we dan? — ¿Y entonces qué hacemos?
• En hoe moet dat dan? — ¿Y cómo se hace eso entonces?
• Waarom niet dan? — ¿Y por qué no?
• Wie dan? — ¿Quién entonces?

⚠️ Sin el dan, la pregunta es neutra: Wat doen we? es simplemente ¿qué hacemos? Con dan, la pregunta se engancha a algo que se acaba de decir.

🏋️ Ejercicio: «¿y quién paga entonces?» → Wie betaalt er ___? (Respuesta: dan.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: dan en pregunta');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estaba cansado, por eso me fui a la cama', 'PHRASE', 'Consecuencia: daarom',
'Ik was moe, daarom ging ik naar bed = estaba cansado, por eso me fui a la cama. daarom es por eso, por esa razon, y se usa cuando hay una DECISION detras: alguien hizo algo a proposito por ese motivo.

📐 daarom es adverbio, asi que en primera posicion obliga a invertir: daarom GING IK naar bed. Nunca «daarom ik ging».

🎭 daarom o daardoor, que es la pareja que mas se confunde:
• daarom — por eso, con intencion. Alguien decide. Ik was moe, daarom ging ik naar bed.
• daardoor — por eso, sin intencion. Es el efecto material. Er was file, daardoor kwam ik te laat.

🔑 El truco que casi nunca falla: Pregunta si alguien DECIDIO. Si hay una persona que actua a proposito, daarom. Si es una consecuencia que simplemente ocurrio, daardoor. Nadie decide llegar tarde por un atasco.

📋 Y los tres que completan la familia:
• vandaar — de ahi que. Vandaar dat hij niet kwam.
• dus — asi que, la conclusion logica.
• zodat — de modo que, mirando al resultado buscado.

🏋️ Ejercicio: «tenia hambre, por eso me hice un bocadillo» → Ik had honger, ___ ___ ik een broodje. (Respuesta: daarom maakte.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: daarom');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'había atasco, por eso llegué tarde', 'PHRASE', 'Consecuencia: daardoor',
'Er was file, daardoor kwam ik te laat = habia atasco, por eso llegue tarde. daardoor es por eso en el sentido de por culpa de eso: el efecto ocurre solo, sin que nadie lo decida.

🔑 La diferencia con daarom en una linea: Nadie DECIDE llegar tarde por un atasco, le pasa. Por eso aqui es daardoor y no daarom. Si hubiera decidido algo — Er was file, daarom nam ik de trein — vuelve daarom, porque coger el tren si fue una decision.

📐 daardoor es adverbio y en primera posicion invierte: daardoor KWAM IK te laat.

📋 Los casos tipicos de daardoor, que son todos efectos sin voluntad:
• Er was file, daardoor kwam ik te laat. — Había atasco, por eso llegué tarde.
• Het regende hard, daardoor was de weg glad. — Llovía fuerte, por eso la carretera estaba resbaladiza.
• Hij werd ziek, daardoor ging het feest niet door. — Se puso enfermo, por eso se anuló la fiesta.

⚠️ Y su hermano subordinante es doordat, que dice lo mismo pero manda el verbo al final: Doordat het regende, was de weg glad. La pareja es exacta: daarom/omdat para la razon con voluntad, daardoor/doordat para la causa material.

🏋️ Ejercicio: «nevó, por eso se cerró el colegio» → Het sneeuwde, ___ ___ de school dicht. (Respuesta: daardoor ging.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: daardoor');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'de ahí que no viniera', 'PHRASE', 'Consecuencia: vandaar',
'Vandaar dat hij niet kwam = de ahi que no viniera. vandaar es de ahi, por eso, y se usa cuando acabas de ENTENDER algo: encaja una pieza que faltaba.

📐 Dos maneras de usarlo:
• Con dat + subordinada, y el verbo al final: Vandaar dat hij niet kwam.
• Suelto, como reaccion: Ah, vandaar! — ¡Ah, por eso!

💬 Ah, vandaar! es de las respuestas mas utiles del neerlandes: es el ya decia yo, el ahora lo entiendo. Alguien te explica por que pasó algo y contestas Ah, vandaar.

🎭 vandaar frente a daarom, que se parecen pero miran al reves:
• daarom — sabes la causa y cuentas el efecto. Ik was moe, daarom ging ik naar bed.
• vandaar — sabias el efecto y acabas de descubrir la causa. Hij was ziek. Ah, vandaar dat hij niet kwam.

🧠 De donde sale: vandaar es van + daar, literalmente de ahi. La misma construccion que vandaan (van + daan, de donde), que esta en el grupo de adverbios pronominales.

🏋️ Ejercicio: te enteras de que estaba enfermo y por eso no fue → Ah, ___! (Respuesta: vandaar.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: vandaar');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'como ya es tarde, lo dejamos', 'PHRASE', 'Consecuencia: aangezien',
'Aangezien het al laat is, stoppen we = como ya es tarde, lo dejamos. aangezien es dado que, puesto que: presenta una causa que las dos partes YA conocen, y por eso suele ir delante.

📐 Es subordinante, asi que manda el verbo al final de su parte: aangezien het al laat IS. Y como la subordinada va delante, la principal invierte: STOPPEN WE.

🎭 Las cuatro maneras de dar una causa, ordenadas por registro:
• want — pues, que. Coordinante, no cambia el orden. Ik blijf thuis, want het regent.
• omdat — porque. Subordinante, verbo al final. Ik blijf thuis omdat het regent.
• doordat — porque, causa material sin voluntad. Doordat het regende, was de weg glad.
• aangezien — dado que, puesto que. Formal, y para causas ya sabidas.

🔑 El truco para want u omdat: want responde a un porqué que el otro no sabia; omdat puede ir delante o detras y es el normal. Y una pista de orden: detras de want la frase sigue normal, detras de omdat el verbo se va al final. Ik blijf thuis, want HET REGENT frente a Ik blijf thuis omdat het REGENT.

⚠️ aangezien no se usa al hablar de andar por casa: suena a informe o a carta. En la conversacion normal, omdat.

🏋️ Ejercicio: «dado que no hay tiempo, lo dejamos» → ___ er geen tijd is, stoppen we. (Respuesta: Aangezien.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: aangezien');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la carretera estaba resbaladiza porque había llovido', 'PHRASE', 'Consecuencia: doordat',
'Doordat het geregend had, was de weg glad = la carretera estaba resbaladiza porque habia llovido. doordat es el porque de las causas MATERIALES, las que no dependen de la voluntad de nadie.

🎭 omdat o doordat, que en español son el mismo porque:
• omdat — razon, motivo. Hay alguien que decide o siente. Ik blijf thuis omdat ik moe ben.
• doordat — causa mecanica. Nadie decide nada, simplemente pasa. Doordat het regende, was de weg glad.

🔑 El truco: Pregunta si detras hay una persona con un motivo. Si la hay, omdat. Si es la fisica actuando sola, doordat. Por eso se dice Doordat de trein vertraging had, kwam ik te laat, pero Omdat ik moe was, ging ik naar bed.

📐 Las dos son subordinantes y mandan el verbo al final: doordat het geregend HAD. Y como la subordinada abre la frase, la principal invierte: WAS de weg glad.

⚠️ En el habla real mucha gente usa omdat para todo y no pasa nada grave, pero doordat en su sitio suena preciso y es muy frecuente en noticias y en informes.

🪞 Su pareja de adverbios son daarom (con voluntad) y daardoor (sin ella), que estan en este mismo grupo.

🏋️ Ejercicio: «se estropeó por el calor» → ___ de hitte ging het kapot. (Respuesta: Door. Con sustantivo se usa door, y doordat solo delante de una frase entera.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: doordat');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'lo que sea', 'PHRASE', 'Consecuencia: wat dan ook',
'Wat dan ook = lo que sea, cualquier cosa. Aqui dan ya no significa entonces: forma parte de una locucion fija que sirve para decir da igual cual.

📋 La familia entera, que se construye toda igual con dan ook:
• wat dan ook — lo que sea. Ik eet wat dan ook.
• wie dan ook — quien sea. Vraag het aan wie dan ook.
• waar dan ook — donde sea. Ik ga waar dan ook heen.
• wanneer dan ook — cuando sea.
• hoe dan ook — como sea, y tambien en cualquier caso. Hoe dan ook, we gaan.
• welke dan ook — cualquiera que sea.

💬 hoe dan ook es la mas util de todas y tiene dos sentidos: como sea, de cualquier manera (We doen het hoe dan ook) y en cualquier caso, pase lo que pase (Hoe dan ook, bedankt).

⚠️ No confundas este dan con el de entonces ni con el comparativo de groter dan. Son tres piezas distintas que se escriben igual; el bloque de abajo las separa.

🏋️ Ejercicio: «pase lo que pase, vamos» → ___ ___ ___, we gaan. (Respuesta: Hoe dan ook.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: wat dan ook');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'está enfermo, por eso no viene', 'PHRASE', 'Consecuencia: daarom inversion',
'Hij is ziek, daarom komt hij niet = esta enfermo, por eso no viene. Fijate bien en el orden, porque es el error numero uno con daarom: detras va el VERBO y luego el sujeto.

⚠️ daarom KOMT HIJ niet, y nunca «daarom hij komt niet». daarom es un adverbio que ocupa la primera posicion de su frase, asi que empuja el verbo a la segunda y el sujeto a la tercera. Lo mismo pasa con dan, daardoor, vandaar, toen y todos los adverbios que abren frase.

📊 El orden segun el conector, que es lo que hay que tener claro:

| conector | tipo | que hace con el orden |
|---|---|---|
| **want** | coordinante | nada. want het **regent** |
| **dus** | coordinante | nada. dus ik **blijf** thuis |
| **dus** | tambien adverbio | invierte. dus **blijf ik** thuis |
| **dan** | adverbio | invierte. dan **blijf ik** thuis |
| **daarom** | adverbio | invierte. daarom **komt hij** niet |
| **daardoor** | adverbio | invierte. daardoor **kwam ik** te laat |
| **omdat** | subordinante | verbo al final. omdat hij ziek **is** |
| **doordat** | subordinante | verbo al final. doordat het **regende** |

🔑 El truco: Solo want y dus dejan la frase en paz. Todos los demas o invierten (los adverbios) o mandan el verbo al final (los subordinantes).

🏋️ Ejercicio: «no tenia dinero, por eso no lo compre» → Ik had geen geld, ___ ___ ik het niet. (Respuesta: daarom kocht.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: daarom inversion');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pues entonces nada', 'PHRASE', 'Consecuencia: dan niet',
'Nou, dan niet = pues entonces nada. Es de las respuestas mas holandesas que hay: se dice cuando alguien rechaza algo y tu lo dejas estar, con un punto de resignacion o de pique.

💬 Como suena de verdad: si ofreces ayuda y te dicen que no, contestas Nou, dan niet con un encogimiento de hombros. Segun el tono es tranquilo (pues vale) o algo picado (pues nada, tu mismo).

📋 Las respuestas cortas con dan, que valen para media conversacion:
• Dan niet. — Pues nada, pues no.
• Dan wel. — Pues sí entonces.
• Dan doen we dat. — Pues hacemos eso.
• Dan is het goed. — Entonces vale.
• Tot dan! — ¡Hasta entonces!
• Nou en? — ¿Y qué? (esta sin dan, pero va en el mismo saco de replicas)

🪶 nou es una particula de las que no se traducen, como wel: aqui suaviza y da tono de resignacion. Sin ella, Dan niet suena mas seco.

⚠️ Fijate en que dan niet y dan wel funcionan como pareja, igual que wel y niet en general: uno niega y el otro afirma lo que estaba en el aire.

🏋️ Ejercicio: te dicen que no quieren venir y lo dejas estar → Nou, ___ ___. (Respuesta: dan niet.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: dan niet');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pienso, luego existo', 'PHRASE', 'Consecuencia: dus filosofico',
'Ik denk, dus ik ben = pienso, luego existo. Es el cogito de Descartes en neerlandes, y sirve de percha perfecta para que se te quede que dus es la deduccion pura: de A se sigue B.

🧠 Por que ayuda a recordarlo: en español la traduccion clasica usa luego (pienso, LUEGO existo), que es justo el luego logico y no el luego temporal. Ese luego logico es dus. El luego de tiempo, en cambio, es dan: Eerst denk ik, dan slaap ik.

📐 Y fijate en el orden, que es el de la coordinante: dus IK BEN, con sujeto delante del verbo. Sin inversion.

📋 Otras formulas donde dus es pura logica:
• Dus dat is geregeld. — Así que eso está arreglado.
• Dus jij komt niet? — ¿Así que no vienes? (con cara de sacar conclusiones)
• Ik heb het gezien, dus ik weet het. — Lo he visto, así que lo sé.
• Dus? — ¿Y? ¿Entonces qué? (seco, pidiendo la conclusión)

🔑 El truco definitivo entre los dos: dus DEDUCE, dan ORDENA en el tiempo. Si puedes poner «por lo tanto», dus. Si puedes poner «después», dan.

🏋️ Ejercicio: «está lloviendo, así que llevo paraguas» → Het regent, ___ ik neem een paraplu mee. (Respuesta: dus.)

🧭 Causa y consecuencia, el mapa entero:

El español tira de porque, así que y por eso para casi todo. El neerlandes reparte por dos ejes: si señalas la CAUSA o la CONSECUENCIA, y si hay una VOLUNTAD detras o no.

| direccion | conector | matiz | ejemplo |
|---|---|---|---|
| consecuencia | **dus** | conclusion logica | Het regent, **dus** ik blijf thuis. |
| consecuencia | **dan** | secuencia o correlato de als | Als het regent, **dan** blijf ik thuis. |
| consecuencia | **daarom** | por eso, con decision detras | Ik was moe, **daarom** ging ik naar bed. |
| consecuencia | **daardoor** | por eso, efecto sin voluntad | Er was file, **daardoor** kwam ik te laat. |
| consecuencia | **vandaar** | de ahi que, al entenderlo | **Vandaar** dat hij niet kwam. |
| consecuencia | **zodat** | de modo que, resultado buscado | Ik schrijf het op, **zodat** ik het niet vergeet. |
| causa | **want** | pues, que | Ik blijf thuis, **want** het regent. |
| causa | **omdat** | porque, con motivo | Ik blijf thuis **omdat** het regent. |
| causa | **doordat** | porque, causa material | **Doordat** het regende, was de weg glad. |
| causa | **aangezien** | dado que, formal | **Aangezien** het laat is, stoppen we. |

📌 Regla de bolsillo para dus o dan:
• ¿Puedes decir «por lo tanto»? → dus.
• ¿Puedes decir «luego» o «despues»? → dan.
• ¿Responde a un si o a un cuando? → dan, que es el correlato de als.
• ¿Es una deduccion, sacas una conclusion? → dus.
• ¿Es «mas … que»? → ese dan es el comparativo y no pinta nada aqui. Esta en el grupo de comparativos.

🔑 El truco que casi nunca falla: dus DEDUCE, dan ORDENA en el tiempo. Ik denk, dus ik ben es pienso LUEGO existo, con el luego logico. Eerst eten we, dan gaan we es primero comemos y LUEGO nos vamos, con el luego del reloj.

⚠️ Y el que mas se falla, daarom o daardoor: pregunta si alguien DECIDIO. Nadie decide llegar tarde por un atasco, asi que ahi es daardoor. Pero si por el atasco decidiste coger el tren, eso si fue decision tuya: daarom nam ik de trein. Su pareja subordinante es omdat (con voluntad) y doordat (sin ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Consecuencia: dus filosofico');

-- =============================================================================
-- 3. Traducciones
-- =============================================================================
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
SELECT we.id, 'nl_NL', v.nl, v.pron
FROM (
    SELECT 'Consecuencia: dus sin inversion' AS k, 'Het is gesloten, dus we komen morgen terug.' AS nl, 'het is jeslooten, dus ve koomen mórjen teruj' AS pron
    UNION ALL SELECT 'Consecuencia: dus con inversion', 'Het regent, dus blijf ik thuis.', 'het reejent, dus blaif ik tais'
    UNION ALL SELECT 'Consecuencia: dan tras als', 'Als het regent, dan blijf ik thuis.', 'als het reejent, dan blaif ik tais'
    UNION ALL SELECT 'Consecuencia: dan temporal', 'Eerst eten we, dan gaan we weg.', 'eerst eeten ve, dan jaan ve vej'
    UNION ALL SELECT 'Consecuencia: dan al inicio', 'Dan zie ik je morgen.', 'dan zi ik ye mórjen'
    UNION ALL SELECT 'Consecuencia: dan en pregunta', 'En wat doen we dan?', 'en vat dun ve dan'
    UNION ALL SELECT 'Consecuencia: daarom', 'Ik was moe, daarom ging ik naar bed.', 'ik vas mu, daarom jing ik naar bet'
    UNION ALL SELECT 'Consecuencia: daardoor', 'Er was file, daardoor kwam ik te laat.', 'er vas file, daardoor kuam ik te laat'
    UNION ALL SELECT 'Consecuencia: vandaar', 'Vandaar dat hij niet kwam.', 'fandaar dat hai nit kuam'
    UNION ALL SELECT 'Consecuencia: aangezien', 'Aangezien het al laat is, stoppen we.', 'aanjezin het al laat is, stopen ve'
    UNION ALL SELECT 'Consecuencia: doordat', 'Doordat het geregend had, was de weg glad.', 'doordat het jereejent hat, vas de vej jlat'
    UNION ALL SELECT 'Consecuencia: wat dan ook', 'Wat dan ook.', 'vat dan ook'
    UNION ALL SELECT 'Consecuencia: daarom inversion', 'Hij is ziek, daarom komt hij niet.', 'hai is zik, daarom komt hai nit'
    UNION ALL SELECT 'Consecuencia: dan niet', 'Nou, dan niet.', 'nau, dan nit'
    UNION ALL SELECT 'Consecuencia: dus filosofico', 'Ik denk, dus ik ben.', 'ik denk, dus ik ben'
) v
JOIN words_es we ON we.notes = v.k;

-- =============================================================================
-- 4. Al grupo nuevo y a generic
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Consecuencia: %' AND g.title = 'consecuencia - dus, dan, daarom, daardoor';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Consecuencia: %' AND g.title = 'generic';
