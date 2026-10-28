-- Learn Languages App - Migration
-- Migration: 20260908000010-grupo-gustar-y-preferir
-- Description: Eduardo, sobre la 1050 (Ik reis graag alleen): "vs ik hou van alleen te
--   reisen, por cierto haz un grupo con gustar y preferir".
--
--   Primero, la correccion: «ik hou van alleen te reizen» tiene un error. houden van NO
--   lleva te delante del infinitivo, porque lo que sigue a van es un infinitivo
--   SUSTANTIVADO, o sea el verbo usado como nombre. Se dice Ik hou van alleen reizen.
--   Quitando el te, la frase es correcta, y la diferencia con la de la tarjeta es de
--   intensidad: Ik reis graag alleen es me gusta viajar solo y es lo normal; Ik hou van
--   alleen reizen es me encanta viajar solo.
--
--   Y el grupo hacia falta. El mazo tenia graag en cinco tarjetas, zin in en cinco y leuk
--   vinden en una, pero CERO hekel, CERO dol op, CERO bevallen, CERO lekker vinden y
--   liever solo en la tarjeta que creo el grupo de comparativos. Nada comparaba las
--   construcciones ni decia cual usar.
--
--   10 tarjetas PHRASE: graag con verbo (la normal, y la que menos se le ocurre a un
--   hispanohablante porque es un ADVERBIO y no un verbo), houden van sin te y con el aviso
--   de que Ik hou van je es te quiero en sentido amoroso, vinden + adjetivo con los cuatro
--   adjetivos de valorar, bevallen (el unico que se construye como el gustar español, con
--   la cosa de sujeto y la persona en dativo), zin hebben in frente a om te, liever, het
--   liefst con su het obligatorio, een hekel hebben aan, dol zijn op y de voorkeur geven
--   aan para el registro formal.
--
--   El bloque compartido trae la tabla de las diez construcciones, el truco de accion
--   frente a cosa, los tres errores tipicos y la escala completa del agrado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'gustar y preferir - graag, houden van, leuk vinden, liever',
       'El español lo resuelve todo con gustar y su estructura al reves, y el neerlandes no tiene ese verbo: reparte segun que te gusta y cuanto. Para una ACCION, el verbo va conjugado y se le pega graag, liever o het liefst detras (Ik kook graag, Ik blijf liever thuis); para una COSA, vinden mas adjetivo (Ik vind deze stad leuk, Ik vind kaas lekker) o houden van, que es mas intenso. Incluye zin hebben in para lo que apetece ahora, bevallen (el unico que se construye como el gustar español, con la cosa de sujeto), dol zijn op como escalon mas alto, een hekel hebben aan como antonimo y de voorkeur geven aan para el registro formal. Con los tres errores tipicos: houden van no lleva te, Ik hou van je es te quiero en sentido amoroso, y zin hebben cambia de preposicion segun venga sustantivo o verbo',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'gustar y preferir - graag, houden van, leuk vinden, liever');

-- =============================================================================
-- 2. Las 10 tarjetas
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me gusta cocinar', 'PHRASE', 'Gustar: graag verbo',
'Ik kook graag = me gusta cocinar. Esta es LA manera normal de decir que te gusta hacer algo, y la que menos se le ocurre a un hispanohablante: no hay ningun verbo gustar, hay un adverbio.

📐 El molde: sujeto + VERBO conjugado + graag. Literalmente cocino con gusto. graag se coloca en el medio de la frase, como cualquier adverbio, y el verbo es el de la accion.

⚠️ El error tipico es buscar un verbo que signifique gustar y montar la frase a la española. En neerlandes se dice al reves: el que disfruta es el SUJETO, no un complemento. Ik kook graag, y no una construccion tipo «me gusta cocinar» con el cocinar de sujeto.

📋 Las que diras a diario:
• Ik lees graag. — Me gusta leer.
• Ik reis graag alleen. — Me gusta viajar solo.
• Werk je graag hier? — ¿Te gusta trabajar aquí?
• Ik zou graag willen… — Querría… (la formula de pedir con educación)
• Graag! — ¡Sí, gracias! (aceptando algo que te ofrecen)
• Graag gedaan. — De nada.

🏋️ Ejercicio: «me gusta nadar» → Ik ___ ___. (Respuesta: zwem graag.)

❤️ Gustar y preferir, que en neerlandes no son un verbo:

El español lo resuelve todo con gustar y su estructura al reves (a mi me gusta X). El neerlandes no tiene ese verbo: reparte segun QUE te gusta y CUANTO.

| lo que quieres decir | construccion | ejemplo |
|---|---|---|
| me gusta HACER algo | verbo + **graag** | Ik kook **graag**. |
| me encanta hacer algo | **houden van** + infinitivo | Ik hou **van** koken. |
| me gusta una COSA | **vinden** + adjetivo | Ik **vind** deze stad **leuk**. |
| me gusta la comida | vinden + **lekker** | Ik vind kaas **lekker**. |
| me apetece ahora | **zin hebben in / om te** | Ik heb **zin in** koffie. |
| ¿que tal te resulta? | **bevallen** | Hoe **bevalt** je baan? |
| me vuelve loco | **dol zijn op** | Ik ben **dol op** chocola. |
| prefiero | verbo + **liever** | Ik blijf **liever** thuis. |
| lo que mas me gusta | verbo + **het liefst** | Ik lees **het liefst**. |
| no lo soporto | **een hekel hebben aan** | Ik heb **een hekel aan** wachten. |

🔑 El truco que ordena el grupo: Pregunta si lo que te gusta es una ACCION o una COSA. Si es una accion, el verbo va conjugado y le pegas graag, liever o het liefst detras. Si es una cosa, tiras de vinden + adjetivo, o de houden van.

⚠️ Tres errores que evitan mucho ridiculo:
• houden van NO lleva te delante del infinitivo. Ik hou van reizen, y nunca «van te reizen».
• Ik hou van je es TE QUIERO, amoroso. Para me caes bien, Ik vind je aardig.
• zin hebben cambia de preposicion: IN con sustantivo (zin in koffie) y OM TE con verbo (zin om te wandelen).

📐 Y la escala completa, de menos a mas, que es lo que de verdad hay que memorizar: een hekel hebben aan → niet leuk vinden → leuk vinden → graag doen → houden van → dol op zijn.

🪞 bevallen merece mencion aparte porque es el UNICO que se construye como el gustar español: la cosa es el sujeto y tu vas en dativo. Het bevalt me hier. Se usa para si una situacion te resulta agradable, no para gustos generales.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gustar: graag verbo');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me encanta viajar', 'PHRASE', 'Gustar: houden van sin te',
'Ik hou van reizen = me encanta viajar. houden van es mas fuerte que graag: es amar, y con actividades se traduce por encantar.

⚠️ Y aqui va el error que hay que evitar: houden van NO lleva te delante del infinitivo. Se dice Ik hou van reizen, nunca «Ik hou van te reizen». Lo que sigue a van es un infinitivo SUSTANTIVADO, o sea el verbo usado como nombre, y por eso va desnudo. Igual que Ik hou van muziek, con un sustantivo normal.

🎭 graag o houden van, que no dicen lo mismo:
• Ik reis graag. — Me gusta viajar. Neutro, es lo normal.
• Ik hou van reizen. — Me encanta viajar. Mas intenso.
Las dos son correctas para la misma idea; solo cambia la fuerza.

🚨 Y el aviso serio: Ik hou van je es TE QUIERO, en sentido amoroso. No es me caes bien ni me gustas un poco. Para eso hay otras: Ik vind je aardig (me caes bien) o Ik vind je leuk (me gustas, suave). Cuidado con soltarle un Ik hou van je a un compañero de trabajo.

📐 La conjugacion tiene una irregularidad de las que se oyen: houden pierde la d en ik hou, aunque tambien existe ik houd, mas escrito. Y en plural vuelve: wij houden van.

🏋️ Ejercicio: «me encanta bailar» → Ik hou ___ ___. (Respuesta: van dansen, sin te.)

❤️ Gustar y preferir, que en neerlandes no son un verbo:

El español lo resuelve todo con gustar y su estructura al reves (a mi me gusta X). El neerlandes no tiene ese verbo: reparte segun QUE te gusta y CUANTO.

| lo que quieres decir | construccion | ejemplo |
|---|---|---|
| me gusta HACER algo | verbo + **graag** | Ik kook **graag**. |
| me encanta hacer algo | **houden van** + infinitivo | Ik hou **van** koken. |
| me gusta una COSA | **vinden** + adjetivo | Ik **vind** deze stad **leuk**. |
| me gusta la comida | vinden + **lekker** | Ik vind kaas **lekker**. |
| me apetece ahora | **zin hebben in / om te** | Ik heb **zin in** koffie. |
| ¿que tal te resulta? | **bevallen** | Hoe **bevalt** je baan? |
| me vuelve loco | **dol zijn op** | Ik ben **dol op** chocola. |
| prefiero | verbo + **liever** | Ik blijf **liever** thuis. |
| lo que mas me gusta | verbo + **het liefst** | Ik lees **het liefst**. |
| no lo soporto | **een hekel hebben aan** | Ik heb **een hekel aan** wachten. |

🔑 El truco que ordena el grupo: Pregunta si lo que te gusta es una ACCION o una COSA. Si es una accion, el verbo va conjugado y le pegas graag, liever o het liefst detras. Si es una cosa, tiras de vinden + adjetivo, o de houden van.

⚠️ Tres errores que evitan mucho ridiculo:
• houden van NO lleva te delante del infinitivo. Ik hou van reizen, y nunca «van te reizen».
• Ik hou van je es TE QUIERO, amoroso. Para me caes bien, Ik vind je aardig.
• zin hebben cambia de preposicion: IN con sustantivo (zin in koffie) y OM TE con verbo (zin om te wandelen).

📐 Y la escala completa, de menos a mas, que es lo que de verdad hay que memorizar: een hekel hebben aan → niet leuk vinden → leuk vinden → graag doen → houden van → dol op zijn.

🪞 bevallen merece mencion aparte porque es el UNICO que se construye como el gustar español: la cosa es el sujeto y tu vas en dativo. Het bevalt me hier. Se usa para si una situacion te resulta agradable, no para gustos generales.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gustar: houden van sin te');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me gusta esta ciudad', 'PHRASE', 'Gustar: leuk vinden',
'Ik vind deze stad leuk = me gusta esta ciudad. vinden + adjetivo es la formula de la opinion, y es la que usas cuando lo que te gusta es una COSA y no una actividad.

📐 El molde: sujeto + vind + la cosa + ADJETIVO al final. El adjetivo cierra la frase, separado de vinden. Ik vind deze stad LEUK. No se dice «Ik vind leuk deze stad».

🎨 Y el adjetivo se elige segun lo que valoras, que es donde el español se queda corto con un solo gustar:
• leuk — agradable, divertido, majo. Para planes, ciudades, personas.
• mooi — bonito. Para lo visual: een mooie film, een mooi huis.
• lekker — rico. Para comida y bebida: Ik vind kaas lekker.
• goed — bueno, de calidad. Ik vind dit boek goed.
• interessant — interesante.

🚨 Ojo con personas: Ik vind hem leuk suele entenderse como me gusta en sentido romantico. Para decir que alguien te cae bien sin equivocos, Ik vind hem aardig.

🏋️ Ejercicio: «me gusta el queso» → Ik vind kaas ___. (Respuesta: lekker, que es el adjetivo de la comida.)

❤️ Gustar y preferir, que en neerlandes no son un verbo:

El español lo resuelve todo con gustar y su estructura al reves (a mi me gusta X). El neerlandes no tiene ese verbo: reparte segun QUE te gusta y CUANTO.

| lo que quieres decir | construccion | ejemplo |
|---|---|---|
| me gusta HACER algo | verbo + **graag** | Ik kook **graag**. |
| me encanta hacer algo | **houden van** + infinitivo | Ik hou **van** koken. |
| me gusta una COSA | **vinden** + adjetivo | Ik **vind** deze stad **leuk**. |
| me gusta la comida | vinden + **lekker** | Ik vind kaas **lekker**. |
| me apetece ahora | **zin hebben in / om te** | Ik heb **zin in** koffie. |
| ¿que tal te resulta? | **bevallen** | Hoe **bevalt** je baan? |
| me vuelve loco | **dol zijn op** | Ik ben **dol op** chocola. |
| prefiero | verbo + **liever** | Ik blijf **liever** thuis. |
| lo que mas me gusta | verbo + **het liefst** | Ik lees **het liefst**. |
| no lo soporto | **een hekel hebben aan** | Ik heb **een hekel aan** wachten. |

🔑 El truco que ordena el grupo: Pregunta si lo que te gusta es una ACCION o una COSA. Si es una accion, el verbo va conjugado y le pegas graag, liever o het liefst detras. Si es una cosa, tiras de vinden + adjetivo, o de houden van.

⚠️ Tres errores que evitan mucho ridiculo:
• houden van NO lleva te delante del infinitivo. Ik hou van reizen, y nunca «van te reizen».
• Ik hou van je es TE QUIERO, amoroso. Para me caes bien, Ik vind je aardig.
• zin hebben cambia de preposicion: IN con sustantivo (zin in koffie) y OM TE con verbo (zin om te wandelen).

📐 Y la escala completa, de menos a mas, que es lo que de verdad hay que memorizar: een hekel hebben aan → niet leuk vinden → leuk vinden → graag doen → houden van → dol op zijn.

🪞 bevallen merece mencion aparte porque es el UNICO que se construye como el gustar español: la cosa es el sujeto y tu vas en dativo. Het bevalt me hier. Se usa para si una situacion te resulta agradable, no para gustos generales.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gustar: leuk vinden');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿qué tal tu trabajo nuevo?', 'PHRASE', 'Gustar: bevallen',
'Hoe bevalt je nieuwe baan? = ¿que tal tu trabajo nuevo?, ¿te gusta? bevallen es el unico verbo neerlandes que funciona como el gustar español: la COSA es el sujeto y la persona va en dativo.

📐 El molde, que te sonara: cosa + bevalt + persona. Het bevalt me hier (me gusta esto aqui, estoy a gusto). Es exactamente la estructura de a mi me gusta esto, con la cosa mandando.

📋 Como se usa de verdad, que es sobre todo preguntando por una situacion nueva:
• Hoe bevalt je nieuwe baan? — ¿Qué tal tu trabajo nuevo?
• Hoe bevalt het je in Nederland? — ¿Qué tal te va en Países Bajos?
• Het bevalt me hier prima. — Aquí estoy la mar de a gusto.
• Het bevalt me niet. — No me convence.

⚠️ No sirve para todo: bevallen se usa para si una SITUACION te resulta agradable (un trabajo, una casa, una ciudad, una experiencia), no para gustos generales. Para me gusta el queso no vale: eso es Ik vind kaas lekker.

🤰 Y una curiosidad que evita malentendidos: bevallen tambien significa dar a luz. Ze is bevallen van een dochter (ha dado a luz a una niña). El contexto los separa sin problema, pero conviene saberlo.

🏋️ Ejercicio: «¿que tal tu casa nueva?» → Hoe ___ je nieuwe huis? (Respuesta: bevalt.)

❤️ Gustar y preferir, que en neerlandes no son un verbo:

El español lo resuelve todo con gustar y su estructura al reves (a mi me gusta X). El neerlandes no tiene ese verbo: reparte segun QUE te gusta y CUANTO.

| lo que quieres decir | construccion | ejemplo |
|---|---|---|
| me gusta HACER algo | verbo + **graag** | Ik kook **graag**. |
| me encanta hacer algo | **houden van** + infinitivo | Ik hou **van** koken. |
| me gusta una COSA | **vinden** + adjetivo | Ik **vind** deze stad **leuk**. |
| me gusta la comida | vinden + **lekker** | Ik vind kaas **lekker**. |
| me apetece ahora | **zin hebben in / om te** | Ik heb **zin in** koffie. |
| ¿que tal te resulta? | **bevallen** | Hoe **bevalt** je baan? |
| me vuelve loco | **dol zijn op** | Ik ben **dol op** chocola. |
| prefiero | verbo + **liever** | Ik blijf **liever** thuis. |
| lo que mas me gusta | verbo + **het liefst** | Ik lees **het liefst**. |
| no lo soporto | **een hekel hebben aan** | Ik heb **een hekel aan** wachten. |

🔑 El truco que ordena el grupo: Pregunta si lo que te gusta es una ACCION o una COSA. Si es una accion, el verbo va conjugado y le pegas graag, liever o het liefst detras. Si es una cosa, tiras de vinden + adjetivo, o de houden van.

⚠️ Tres errores que evitan mucho ridiculo:
• houden van NO lleva te delante del infinitivo. Ik hou van reizen, y nunca «van te reizen».
• Ik hou van je es TE QUIERO, amoroso. Para me caes bien, Ik vind je aardig.
• zin hebben cambia de preposicion: IN con sustantivo (zin in koffie) y OM TE con verbo (zin om te wandelen).

📐 Y la escala completa, de menos a mas, que es lo que de verdad hay que memorizar: een hekel hebben aan → niet leuk vinden → leuk vinden → graag doen → houden van → dol op zijn.

🪞 bevallen merece mencion aparte porque es el UNICO que se construye como el gustar español: la cosa es el sujeto y tu vas en dativo. Het bevalt me hier. Se usa para si una situacion te resulta agradable, no para gustos generales.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gustar: bevallen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me apetece un helado', 'PHRASE', 'Gustar: zin hebben in',
'Ik heb zin in een ijsje = me apetece un helado. zin hebben in es apetecer, y cubre el hueco entre gustar (algo general) y querer (algo concreto ahora).

📐 Dos moldes, segun lo que apetezca:
• Con SUSTANTIVO va con IN — Ik heb zin in koffie. Ik heb zin in een ijsje.
• Con VERBO va con OM TE — Ik heb zin om te wandelen. (me apetece pasear)

⚠️ Esa es la trampa: no se dice «Ik heb zin in wandelen» sino Ik heb zin OM TE wandelen. Con cosa, in; con accion, om te.

📋 Las que se oyen a diario:
• Heb je zin in koffie? — ¿Te apetece un café?
• Ik heb er geen zin in. — No me apetece nada. (con er, porque la cosa ya se sabe)
• Ik heb zin om naar het strand te gaan. — Me apetece ir a la playa.
• Zin in een biertje? — ¿Una cerveza? (así, sin verbo, es lo más natural)

🎚️ Y la escala del apetecer, de menos a mas: geen zin (no me apetece) → wel zin (sí me apetece) → veel zin (muchas ganas) → ontzettend veel zin (unas ganas locas).

🏋️ Ejercicio: «me apetece salir a cenar» → Ik heb zin ___ ___ uit eten ___ gaan. (Respuesta: om … te.)

❤️ Gustar y preferir, que en neerlandes no son un verbo:

El español lo resuelve todo con gustar y su estructura al reves (a mi me gusta X). El neerlandes no tiene ese verbo: reparte segun QUE te gusta y CUANTO.

| lo que quieres decir | construccion | ejemplo |
|---|---|---|
| me gusta HACER algo | verbo + **graag** | Ik kook **graag**. |
| me encanta hacer algo | **houden van** + infinitivo | Ik hou **van** koken. |
| me gusta una COSA | **vinden** + adjetivo | Ik **vind** deze stad **leuk**. |
| me gusta la comida | vinden + **lekker** | Ik vind kaas **lekker**. |
| me apetece ahora | **zin hebben in / om te** | Ik heb **zin in** koffie. |
| ¿que tal te resulta? | **bevallen** | Hoe **bevalt** je baan? |
| me vuelve loco | **dol zijn op** | Ik ben **dol op** chocola. |
| prefiero | verbo + **liever** | Ik blijf **liever** thuis. |
| lo que mas me gusta | verbo + **het liefst** | Ik lees **het liefst**. |
| no lo soporto | **een hekel hebben aan** | Ik heb **een hekel aan** wachten. |

🔑 El truco que ordena el grupo: Pregunta si lo que te gusta es una ACCION o una COSA. Si es una accion, el verbo va conjugado y le pegas graag, liever o het liefst detras. Si es una cosa, tiras de vinden + adjetivo, o de houden van.

⚠️ Tres errores que evitan mucho ridiculo:
• houden van NO lleva te delante del infinitivo. Ik hou van reizen, y nunca «van te reizen».
• Ik hou van je es TE QUIERO, amoroso. Para me caes bien, Ik vind je aardig.
• zin hebben cambia de preposicion: IN con sustantivo (zin in koffie) y OM TE con verbo (zin om te wandelen).

📐 Y la escala completa, de menos a mas, que es lo que de verdad hay que memorizar: een hekel hebben aan → niet leuk vinden → leuk vinden → graag doen → houden van → dol op zijn.

🪞 bevallen merece mencion aparte porque es el UNICO que se construye como el gustar español: la cosa es el sujeto y tu vas en dativo. Het bevalt me hier. Se usa para si una situacion te resulta agradable, no para gustos generales.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gustar: zin hebben in');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'prefiero quedarme en casa', 'PHRASE', 'Gustar: liever preferir',
'Ik blijf liever thuis = prefiero quedarme en casa. liever es el comparativo de graag, y es la manera normal de decir preferir: no hay un verbo preferir de uso diario.

📐 El molde es el mismo que el de graag, cambiando la palabra: sujeto + VERBO + liever. El verbo sigue siendo el de la accion, no ninguno de preferir. Ik blijf liever thuis, literalmente me quedo mas a gusto en casa.

📊 La escala completa, que es la de un comparativo cualquiera:
• graag — con gusto. Ik blijf graag thuis. (me gusta quedarme en casa)
• liever — preferentemente. Ik blijf liever thuis. (prefiero quedarme)
• het liefst — lo que mas. Ik blijf het liefst thuis. (lo que mas me gusta es quedarme)

📋 Y con la comparacion explicita entra dan, como en todo comparativo: Ik blijf liever thuis DAN uit te gaan (prefiero quedarme en casa a salir). Aqui el segundo verbo si lleva te.

💬 Liever niet es de las respuestas mas utiles del neerlandes: literalmente preferiblemente no, y es la manera educada de rechazar algo. Suena mucho mejor que un nee seco.

🏋️ Ejercicio: «prefiero ir en tren» → Ik ga ___ met de trein. (Respuesta: liever.)

❤️ Gustar y preferir, que en neerlandes no son un verbo:

El español lo resuelve todo con gustar y su estructura al reves (a mi me gusta X). El neerlandes no tiene ese verbo: reparte segun QUE te gusta y CUANTO.

| lo que quieres decir | construccion | ejemplo |
|---|---|---|
| me gusta HACER algo | verbo + **graag** | Ik kook **graag**. |
| me encanta hacer algo | **houden van** + infinitivo | Ik hou **van** koken. |
| me gusta una COSA | **vinden** + adjetivo | Ik **vind** deze stad **leuk**. |
| me gusta la comida | vinden + **lekker** | Ik vind kaas **lekker**. |
| me apetece ahora | **zin hebben in / om te** | Ik heb **zin in** koffie. |
| ¿que tal te resulta? | **bevallen** | Hoe **bevalt** je baan? |
| me vuelve loco | **dol zijn op** | Ik ben **dol op** chocola. |
| prefiero | verbo + **liever** | Ik blijf **liever** thuis. |
| lo que mas me gusta | verbo + **het liefst** | Ik lees **het liefst**. |
| no lo soporto | **een hekel hebben aan** | Ik heb **een hekel aan** wachten. |

🔑 El truco que ordena el grupo: Pregunta si lo que te gusta es una ACCION o una COSA. Si es una accion, el verbo va conjugado y le pegas graag, liever o het liefst detras. Si es una cosa, tiras de vinden + adjetivo, o de houden van.

⚠️ Tres errores que evitan mucho ridiculo:
• houden van NO lleva te delante del infinitivo. Ik hou van reizen, y nunca «van te reizen».
• Ik hou van je es TE QUIERO, amoroso. Para me caes bien, Ik vind je aardig.
• zin hebben cambia de preposicion: IN con sustantivo (zin in koffie) y OM TE con verbo (zin om te wandelen).

📐 Y la escala completa, de menos a mas, que es lo que de verdad hay que memorizar: een hekel hebben aan → niet leuk vinden → leuk vinden → graag doen → houden van → dol op zijn.

🪞 bevallen merece mencion aparte porque es el UNICO que se construye como el gustar español: la cosa es el sujeto y tu vas en dativo. Het bevalt me hier. Se usa para si una situacion te resulta agradable, no para gustos generales.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gustar: liever preferir');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'lo que más me gusta es leer', 'PHRASE', 'Gustar: het liefst',
'Ik lees het liefst = lo que mas me gusta es leer. het liefst es el superlativo de graag, y cierra la escala graag, liever, het liefst.

📐 Fijate en el HET, que es obligatorio y no es un articulo: es la marca del superlativo adverbial, la misma de het grootst y het lekkerst que ya viste en el grupo de comparativos. Ik lees het liefst, y no «Ik lees liefst».

📋 Con el resto de la frase:
• Ik drink het liefst thee. — Lo que más me gusta beber es té.
• Het liefst zou ik nu naar huis gaan. — Lo que más me apetecería es irme a casa ahora.
• Wat doe je het liefst? — ¿Qué es lo que más te gusta hacer?

🪞 Y el paralelo con el otro superlativo adverbial, que es la misma construccion: Wat vind je het lekkerst? (¿qué es lo que más te gusta de comer?), In juli is het het warmst (en julio es cuando más calor hace).

🏋️ Ejercicio: «lo que mas me gusta es cocinar» → Ik kook ___ ___. (Respuesta: het liefst.)

❤️ Gustar y preferir, que en neerlandes no son un verbo:

El español lo resuelve todo con gustar y su estructura al reves (a mi me gusta X). El neerlandes no tiene ese verbo: reparte segun QUE te gusta y CUANTO.

| lo que quieres decir | construccion | ejemplo |
|---|---|---|
| me gusta HACER algo | verbo + **graag** | Ik kook **graag**. |
| me encanta hacer algo | **houden van** + infinitivo | Ik hou **van** koken. |
| me gusta una COSA | **vinden** + adjetivo | Ik **vind** deze stad **leuk**. |
| me gusta la comida | vinden + **lekker** | Ik vind kaas **lekker**. |
| me apetece ahora | **zin hebben in / om te** | Ik heb **zin in** koffie. |
| ¿que tal te resulta? | **bevallen** | Hoe **bevalt** je baan? |
| me vuelve loco | **dol zijn op** | Ik ben **dol op** chocola. |
| prefiero | verbo + **liever** | Ik blijf **liever** thuis. |
| lo que mas me gusta | verbo + **het liefst** | Ik lees **het liefst**. |
| no lo soporto | **een hekel hebben aan** | Ik heb **een hekel aan** wachten. |

🔑 El truco que ordena el grupo: Pregunta si lo que te gusta es una ACCION o una COSA. Si es una accion, el verbo va conjugado y le pegas graag, liever o het liefst detras. Si es una cosa, tiras de vinden + adjetivo, o de houden van.

⚠️ Tres errores que evitan mucho ridiculo:
• houden van NO lleva te delante del infinitivo. Ik hou van reizen, y nunca «van te reizen».
• Ik hou van je es TE QUIERO, amoroso. Para me caes bien, Ik vind je aardig.
• zin hebben cambia de preposicion: IN con sustantivo (zin in koffie) y OM TE con verbo (zin om te wandelen).

📐 Y la escala completa, de menos a mas, que es lo que de verdad hay que memorizar: een hekel hebben aan → niet leuk vinden → leuk vinden → graag doen → houden van → dol op zijn.

🪞 bevallen merece mencion aparte porque es el UNICO que se construye como el gustar español: la cosa es el sujeto y tu vas en dativo. Het bevalt me hier. Se usa para si una situacion te resulta agradable, no para gustos generales.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gustar: het liefst');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'odio esperar', 'PHRASE', 'Gustar: hekel hebben aan',
'Ik heb een hekel aan wachten = odio esperar, no soporto esperar. Es el antonimo de houden van, y se construye con la formula fija een hekel hebben AAN.

📐 El molde: sujeto + heb + EEN HEKEL AAN + la cosa o el infinitivo sustantivado. Fijate en que el een es obligatorio (een hekel, no «hekel») y en que la preposicion es aan.

🎚️ La escala del desagrado, de menos a mas:
• Ik vind het niet leuk. — No me gusta.
• Ik hou er niet van. — No me gusta nada. (con er, porque van necesita su adverbio pronominal)
• Ik heb een hekel aan… — No soporto…
• Ik haat… — Odio… Es fuerte y algo dramatico, menos usado que en español.

⚠️ Fijate en Ik hou er niet van: como van rige un complemento y ese complemento es una cosa, hay que meter el er del adverbio pronominal. Es lo que viste en el grupo 36: no se dice «Ik hou niet van het».

📋 Las que se oyen:
• Ik heb een hekel aan opstaan. — Odio madrugar.
• Ze heeft een hekel aan hem. — No lo soporta.
• Ik heb er een hekel aan. — No lo soporto. (con er)

🏋️ Ejercicio: «odio el frio» → Ik heb ___ ___ ___ kou. (Respuesta: een hekel aan.)

❤️ Gustar y preferir, que en neerlandes no son un verbo:

El español lo resuelve todo con gustar y su estructura al reves (a mi me gusta X). El neerlandes no tiene ese verbo: reparte segun QUE te gusta y CUANTO.

| lo que quieres decir | construccion | ejemplo |
|---|---|---|
| me gusta HACER algo | verbo + **graag** | Ik kook **graag**. |
| me encanta hacer algo | **houden van** + infinitivo | Ik hou **van** koken. |
| me gusta una COSA | **vinden** + adjetivo | Ik **vind** deze stad **leuk**. |
| me gusta la comida | vinden + **lekker** | Ik vind kaas **lekker**. |
| me apetece ahora | **zin hebben in / om te** | Ik heb **zin in** koffie. |
| ¿que tal te resulta? | **bevallen** | Hoe **bevalt** je baan? |
| me vuelve loco | **dol zijn op** | Ik ben **dol op** chocola. |
| prefiero | verbo + **liever** | Ik blijf **liever** thuis. |
| lo que mas me gusta | verbo + **het liefst** | Ik lees **het liefst**. |
| no lo soporto | **een hekel hebben aan** | Ik heb **een hekel aan** wachten. |

🔑 El truco que ordena el grupo: Pregunta si lo que te gusta es una ACCION o una COSA. Si es una accion, el verbo va conjugado y le pegas graag, liever o het liefst detras. Si es una cosa, tiras de vinden + adjetivo, o de houden van.

⚠️ Tres errores que evitan mucho ridiculo:
• houden van NO lleva te delante del infinitivo. Ik hou van reizen, y nunca «van te reizen».
• Ik hou van je es TE QUIERO, amoroso. Para me caes bien, Ik vind je aardig.
• zin hebben cambia de preposicion: IN con sustantivo (zin in koffie) y OM TE con verbo (zin om te wandelen).

📐 Y la escala completa, de menos a mas, que es lo que de verdad hay que memorizar: een hekel hebben aan → niet leuk vinden → leuk vinden → graag doen → houden van → dol op zijn.

🪞 bevallen merece mencion aparte porque es el UNICO que se construye como el gustar español: la cosa es el sujeto y tu vas en dativo. Het bevalt me hier. Se usa para si una situacion te resulta agradable, no para gustos generales.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gustar: hekel hebben aan');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'le encantan los perros (ella)', 'PHRASE', 'Gustar: dol zijn op',
'Ze is dol op honden = le encantan los perros. dol zijn op es el escalon mas alto del gustar, por encima de houden van, y se construye con OP.

📐 El molde: sujeto + zijn + dol + OP + la cosa. Y ojo a la preposicion, que aqui es op y no van: es dol OP honden, nunca «dol van».

🎚️ La escala completa del agrado, ordenada, que es lo que resuelve el grupo entero:
• Ik vind het leuk. — Me gusta.
• Ik doe het graag. — Me gusta hacerlo.
• Ik hou ervan. — Me encanta.
• Ik ben er dol op. — Me vuelve loco.
• Ik ben er gek op. — Igual de fuerte, mas coloquial.

📋 dol tiene otro sentido que conviene no mezclar: significa loco, chiflado. Een dolle koe es una vaca loca. En dol op se ha lexicalizado y ya solo significa entusiasmado con.

⚠️ Y otra vez el adverbio pronominal: con una cosa ya mencionada se dice Ik ben er dol op, con el er delante y el op al final. Nunca «Ik ben dol op het».

🏋️ Ejercicio: «me encanta el chocolate» → Ik ben ___ ___ chocola. (Respuesta: dol op.)

❤️ Gustar y preferir, que en neerlandes no son un verbo:

El español lo resuelve todo con gustar y su estructura al reves (a mi me gusta X). El neerlandes no tiene ese verbo: reparte segun QUE te gusta y CUANTO.

| lo que quieres decir | construccion | ejemplo |
|---|---|---|
| me gusta HACER algo | verbo + **graag** | Ik kook **graag**. |
| me encanta hacer algo | **houden van** + infinitivo | Ik hou **van** koken. |
| me gusta una COSA | **vinden** + adjetivo | Ik **vind** deze stad **leuk**. |
| me gusta la comida | vinden + **lekker** | Ik vind kaas **lekker**. |
| me apetece ahora | **zin hebben in / om te** | Ik heb **zin in** koffie. |
| ¿que tal te resulta? | **bevallen** | Hoe **bevalt** je baan? |
| me vuelve loco | **dol zijn op** | Ik ben **dol op** chocola. |
| prefiero | verbo + **liever** | Ik blijf **liever** thuis. |
| lo que mas me gusta | verbo + **het liefst** | Ik lees **het liefst**. |
| no lo soporto | **een hekel hebben aan** | Ik heb **een hekel aan** wachten. |

🔑 El truco que ordena el grupo: Pregunta si lo que te gusta es una ACCION o una COSA. Si es una accion, el verbo va conjugado y le pegas graag, liever o het liefst detras. Si es una cosa, tiras de vinden + adjetivo, o de houden van.

⚠️ Tres errores que evitan mucho ridiculo:
• houden van NO lleva te delante del infinitivo. Ik hou van reizen, y nunca «van te reizen».
• Ik hou van je es TE QUIERO, amoroso. Para me caes bien, Ik vind je aardig.
• zin hebben cambia de preposicion: IN con sustantivo (zin in koffie) y OM TE con verbo (zin om te wandelen).

📐 Y la escala completa, de menos a mas, que es lo que de verdad hay que memorizar: een hekel hebben aan → niet leuk vinden → leuk vinden → graag doen → houden van → dol op zijn.

🪞 bevallen merece mencion aparte porque es el UNICO que se construye como el gustar español: la cosa es el sujeto y tu vas en dativo. Het bevalt me hier. Se usa para si una situacion te resulta agradable, no para gustos generales.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gustar: dol zijn op');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'prefiero la opción B', 'PHRASE', 'Gustar: voorkeur geven',
'Ik geef de voorkeur aan optie B = prefiero la opcion B. de voorkeur geven aan es la version FORMAL de liever, la de los informes, las reuniones y los correos de trabajo.

📐 El molde: sujeto + geef + DE VOORKEUR AAN + la cosa. Es formula fija: lleva su de y su aan, y no se toca.

🎭 Las tres maneras de preferir, por registro:
• Ik blijf liever thuis. — Prefiero quedarme en casa. La normal, para hablar.
• Ik heb liever thee. — Prefiero té. Igual de corriente, con hebben.
• Ik geef de voorkeur aan optie B. — Prefiero la opción B. Formal y escrita.

⚠️ No mezcles los moldes: liever va con el verbo de la accion, y de voorkeur geven aan va con un sustantivo detras. No se dice «Ik geef de voorkeur aan thuisblijven» en el habla normal; ahi se dice Ik blijf liever thuis.

📦 El sustantivo es de voorkeur (la preferencia), y sale en frases utiles: mijn voorkeur gaat uit naar… (mi preferencia va hacia…), bij voorkeur (preferiblemente, y es lo que veras en formularios y anuncios).

🏋️ Ejercicio: «preferiblemente por la mañana» en un formulario → ___ ___ in de ochtend. (Respuesta: Bij voorkeur.)

❤️ Gustar y preferir, que en neerlandes no son un verbo:

El español lo resuelve todo con gustar y su estructura al reves (a mi me gusta X). El neerlandes no tiene ese verbo: reparte segun QUE te gusta y CUANTO.

| lo que quieres decir | construccion | ejemplo |
|---|---|---|
| me gusta HACER algo | verbo + **graag** | Ik kook **graag**. |
| me encanta hacer algo | **houden van** + infinitivo | Ik hou **van** koken. |
| me gusta una COSA | **vinden** + adjetivo | Ik **vind** deze stad **leuk**. |
| me gusta la comida | vinden + **lekker** | Ik vind kaas **lekker**. |
| me apetece ahora | **zin hebben in / om te** | Ik heb **zin in** koffie. |
| ¿que tal te resulta? | **bevallen** | Hoe **bevalt** je baan? |
| me vuelve loco | **dol zijn op** | Ik ben **dol op** chocola. |
| prefiero | verbo + **liever** | Ik blijf **liever** thuis. |
| lo que mas me gusta | verbo + **het liefst** | Ik lees **het liefst**. |
| no lo soporto | **een hekel hebben aan** | Ik heb **een hekel aan** wachten. |

🔑 El truco que ordena el grupo: Pregunta si lo que te gusta es una ACCION o una COSA. Si es una accion, el verbo va conjugado y le pegas graag, liever o het liefst detras. Si es una cosa, tiras de vinden + adjetivo, o de houden van.

⚠️ Tres errores que evitan mucho ridiculo:
• houden van NO lleva te delante del infinitivo. Ik hou van reizen, y nunca «van te reizen».
• Ik hou van je es TE QUIERO, amoroso. Para me caes bien, Ik vind je aardig.
• zin hebben cambia de preposicion: IN con sustantivo (zin in koffie) y OM TE con verbo (zin om te wandelen).

📐 Y la escala completa, de menos a mas, que es lo que de verdad hay que memorizar: een hekel hebben aan → niet leuk vinden → leuk vinden → graag doen → houden van → dol op zijn.

🪞 bevallen merece mencion aparte porque es el UNICO que se construye como el gustar español: la cosa es el sujeto y tu vas en dativo. Het bevalt me hier. Se usa para si una situacion te resulta agradable, no para gustos generales.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Gustar: voorkeur geven');

-- =============================================================================
-- 3. Traducciones
-- =============================================================================
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
SELECT we.id, 'nl_NL', v.nl, v.pron
FROM (
    SELECT 'Gustar: graag verbo' AS k, 'Ik kook graag.' AS nl, 'ik kook jraaj' AS pron
    UNION ALL SELECT 'Gustar: houden van sin te', 'Ik hou van reizen.', 'ik hau fan raizen'
    UNION ALL SELECT 'Gustar: leuk vinden', 'Ik vind deze stad leuk.', 'ik fint deeze stat leuk'
    UNION ALL SELECT 'Gustar: bevallen', 'Hoe bevalt je nieuwe baan?', 'hu befalt ye niuue baan'
    UNION ALL SELECT 'Gustar: zin hebben in', 'Ik heb zin in een ijsje.', 'ik hep zin in en aisye'
    UNION ALL SELECT 'Gustar: liever preferir', 'Ik blijf liever thuis.', 'ik blaif liifer tais'
    UNION ALL SELECT 'Gustar: het liefst', 'Ik lees het liefst.', 'ik lees het liifst'
    UNION ALL SELECT 'Gustar: hekel hebben aan', 'Ik heb een hekel aan wachten.', 'ik hep en heekel aan vajten'
    UNION ALL SELECT 'Gustar: dol zijn op', 'Ze is dol op honden.', 'ze is dol op honden'
    UNION ALL SELECT 'Gustar: voorkeur geven', 'Ik geef de voorkeur aan optie B.', 'ik jeef de fóorkeur aan opsi bee'
) v
JOIN words_es we ON we.notes = v.k;

-- =============================================================================
-- 4. Al grupo nuevo y a generic
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Gustar: %' AND g.title = 'gustar y preferir - graag, houden van, leuk vinden, liever';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Gustar: %' AND g.title = 'generic';

-- =============================================================================
-- 5. Las que ya existian y son de esta familia
--    1050 (Ik reis graag alleen), 1024 (liever), 448-451 y 264 (zin in), 531 (leuk vinden)
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE g.title = 'gustar y preferir - graag, houden van, leuk vinden, liever' AND we.id IN (264, 448, 449, 450, 451, 531, 1024, 1050);

-- =============================================================================
-- 6. La 1050: la duda concreta, con el te que sobra
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: Ik reis graag alleen frente a «ik hou van alleen te reizen».

⚠️ Lo primero, el error: houden van NO lleva te delante del infinitivo. Se dice Ik hou van alleen reizen, sin te. Lo que sigue a van es un infinitivo SUSTANTIVADO, o sea el verbo usado como nombre, y por eso va desnudo — igual que en Ik hou van muziek, donde detras hay un sustantivo normal.

🔑 Quitado el te, las dos frases son correctas y la diferencia es de INTENSIDAD:

| frase | que dice |
|---|---|
| Ik reis **graag** alleen. | Me gusta viajar solo. Neutro, y es lo normal. |
| Ik hou **van** alleen reizen. | Me encanta viajar solo. Mas fuerte. |
| Ik ben **dol op** alleen reizen. | Me vuelve loco viajar solo. El escalon mas alto. |

📐 Y fijate en la diferencia de molde, que es lo que hay que fijar: con graag el verbo de la accion va CONJUGADO (Ik REIS graag), mientras que con houden van el verbo pasa a INFINITIVO y se convierte casi en un sustantivo (Ik hou van REIZEN).

🚨 Y el aviso de siempre con houden van: Ik hou van je es te quiero, en sentido amoroso. Para decir que alguien te cae bien, Ik vind je aardig.

🏋️ Ejercicio: «me encanta cocinar» → Ik hou ___ ___. (Respuesta: van koken, sin te.)'
WHERE id = 1050
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';
