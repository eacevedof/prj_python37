-- Learn Languages App - Migration
-- Migration: 20260908000012-grupo-desde
-- Description: Eduardo: "haz un grupo de uit, vanaf, vanuit y van no se cuando aplicar
--   cada uno en «desde»".
--
--   El hueco era real: vanaf y sinds estaban a CERO en el mazo, vanuit solo aparecia en la
--   1054 (Ik werk vanuit huis) y nada comparaba las preposiciones. Se añade ademas sinds,
--   que Eduardo no menciona pero es imprescindible para cerrar el mapa: tambien se traduce
--   por desde y es el que se opone a vanaf en el eje temporal.
--
--   Los dos trucos que resuelven las dudas de verdad y que vertebran el grupo:
--     - uit frente a vanuit: uit implica SALIR y vanuit no. Ik stap uit de trein (me bajo)
--       frente a Ik bel vanuit de trein (sigo dentro).
--     - vanaf frente a sinds: vanaf mira al FUTURO y sinds al PASADO. Vanaf maandag ben ik
--       er frente a Ik woon hier sinds 2020.
--
--   12 tarjetas PHRASE: uit con pais y con interior (la nevera), van con procedencia
--   inmediata y el par van … tot con su tot en met, vanaf en tiempo, en recorrido y en
--   escala de precios, vanuit fisico y figurado (vanuit mijn oogpunt), sinds en presente
--   y sinds con negacion en perfecto, y al + duracion, que es la alternativa mas holandesa
--   a sinds y que ademas resuelve el llevar + gerundio español, que no tiene verbo propio.
--   Se suman al grupo la 965 (Ik kom uit Spanje), la 966 (Ik kom van mijn werk) y la 1054
--   (Ik werk vanuit huis), que ya existian y son de esta familia.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'desde - uit, van, vanaf, vanuit, sinds',
       'El español dice desde para cinco cosas distintas y el neerlandes las separa, y lo que decide es si hay un interior, si te mueves y hacia donde va el tiempo: uit es desde dentro saliendo (Ik kom uit Spanje), van es el punto de partida generico y de donde vienes ahora (Ik kom van de dokter), vanaf es a partir de mirando al futuro o el inicio de un recorrido o una escala (Vanaf morgen, vanaf 10 euro), vanuit es desde dentro pero sin salir, la perspectiva desde la que haces algo (Ik werk vanuit huis), y sinds es desde cuando mirando al pasado con la cosa durando hasta hoy (Ik woon hier sinds 2020). Con los dos trucos que resuelven las dudas: uit implica salir y vanuit no, y vanaf mira al futuro mientras sinds mira al pasado. Incluye el par van … tot con su tot en met para incluir el ultimo dia, y al + duracion como alternativa a sinds, que ademas resuelve el llevar + gerundio español',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'desde - uit, van, vanaf, vanuit, sinds');

-- =============================================================================
-- 2. Las 12 tarjetas
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿de qué país eres?', 'PHRASE', 'Desde: uit pais',
'Uit welk land kom je? = ¿de que pais eres? uit es el desde de DENTRO: marca que sales del interior de algo, y con paises, ciudades y edificios es el que manda.

📐 El molde de la pregunta: uit + welk land + verbo + sujeto. Y fijate en welk, que concuerda con land porque es palabra het: welk land, pero welke stad, que es de.

📋 uit con lugares, que es su uso principal:
• Ik kom uit Spanje. — Soy de España.
• Ze komt uit Amsterdam. — Es de Ámsterdam.
• Hij komt uit het huis. — Sale de la casa.
• Haal de melk uit de koelkast. — Saca la leche de la nevera.

🔑 El truco de uit: Piensa si hay un INTERIOR del que se sale. Un pais, una ciudad, una casa, una nevera, un bolsillo: todos tienen dentro. Por eso es uit y no van.

⚠️ No lo confundas con vanuit, que es su hermano y se parece muchisimo: uit implica SALIR, vanuit no. Ik kom uit het huis es salgo de la casa; Ik werk vanuit huis es trabajo desde casa, sin moverme de ella.

🏋️ Ejercicio: «soy de Belgica» → Ik kom ___ Belgie. (Respuesta: uit.)

📍 Las cinco maneras de decir desde:

El español dice desde para cinco cosas distintas y el neerlandes las separa. Lo que decide es si hay un interior, si te mueves, y hacia donde va el tiempo.

| preposicion | que marca | ejemplo |
|---|---|---|
| **uit** | desde DENTRO, saliendo. Origen y procedencia de un interior | Ik kom **uit** Spanje. |
| **van** | punto de partida generico, de donde vienes ahora | Ik kom **van** de dokter. |
| **vanaf** | a partir de. Mira al FUTURO, o marca el inicio de un recorrido o una escala | **Vanaf** morgen. |
| **vanuit** | desde dentro pero SIN salir. La perspectiva desde la que haces algo | Ik werk **vanuit** huis. |
| **sinds** | desde cuando. Mira al PASADO, y la cosa dura hasta hoy | Ik woon hier **sinds** 2020. |

📌 Regla de bolsillo:
• ¿Es tu origen, tu pais, o sales del interior de algo? → uit.
• ¿De donde vienes ahora mismo? → van.
• ¿A partir de cuando, mirando adelante? → vanaf.
• ¿Desde donde haces algo sin moverte de ahi? → vanuit.
• ¿Desde cuando, y sigue pasando? → sinds.

🔑 Los dos trucos que resuelven las dudas de verdad:
• uit frente a vanuit — uit implica SALIR y vanuit no. Ik stap uit de trein (me bajo) frente a Ik bel vanuit de trein (sigo dentro).
• vanaf frente a sinds — vanaf mira al FUTURO y sinds al PASADO. Vanaf maandag ben ik er (a partir del lunes) frente a Ik woon hier sinds 2020 (y sigo viviendo).

📐 Y si el desde lleva un HASTA, la pareja es van … tot: van maandag tot vrijdag. Para incluir el ultimo dia, tot en met, que se abrevia t/m y es lo que veras en horarios y plazos.

🪞 Todo esto contesta a la misma pregunta, Waar kom je vandaan?, que esta en el grupo de adverbios pronominales: la respuesta lleva uit si hablas de tu origen y van si hablas de donde vienes ahora.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Desde: uit pais');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'saca la leche de la nevera', 'PHRASE', 'Desde: uit koelkast',
'Haal de melk uit de koelkast = saca la leche de la nevera. Aqui se ve uit en estado puro: hay un interior (la nevera) y algo sale de el.

📐 El verbo: Halen es ir a por algo y traerlo. Con uit se saca de dentro; con van, de una superficie. Haal het boek van de plank (coge el libro de la estanteria).

🎭 uit o van segun donde este la cosa:
• Dentro de algo — uit. uit de kast, uit de la, uit je zak, uit de koelkast.
• Encima de algo — van. van de tafel, van de plank, van de grond.

📋 Los verbos que salen con uit todo el rato: halen (traer), pakken (coger), nemen (tomar), stappen (bajarse de un vehiculo: uit de trein stappen), drinken (uit een glas drinken).

⚠️ Y ojo a uitgaan y a la particula uit de los separables, que es otra cosa: Doe het licht uit (apaga la luz) no lleva ningun desde. La uit preposicion siempre tiene un complemento detras; la uit particula va suelta al final.

🏋️ Ejercicio: «coge el libro de la estanteria» (esta encima) → Pak het boek ___ de plank. (Respuesta: van, porque esta encima y no dentro.)

📍 Las cinco maneras de decir desde:

El español dice desde para cinco cosas distintas y el neerlandes las separa. Lo que decide es si hay un interior, si te mueves, y hacia donde va el tiempo.

| preposicion | que marca | ejemplo |
|---|---|---|
| **uit** | desde DENTRO, saliendo. Origen y procedencia de un interior | Ik kom **uit** Spanje. |
| **van** | punto de partida generico, de donde vienes ahora | Ik kom **van** de dokter. |
| **vanaf** | a partir de. Mira al FUTURO, o marca el inicio de un recorrido o una escala | **Vanaf** morgen. |
| **vanuit** | desde dentro pero SIN salir. La perspectiva desde la que haces algo | Ik werk **vanuit** huis. |
| **sinds** | desde cuando. Mira al PASADO, y la cosa dura hasta hoy | Ik woon hier **sinds** 2020. |

📌 Regla de bolsillo:
• ¿Es tu origen, tu pais, o sales del interior de algo? → uit.
• ¿De donde vienes ahora mismo? → van.
• ¿A partir de cuando, mirando adelante? → vanaf.
• ¿Desde donde haces algo sin moverte de ahi? → vanuit.
• ¿Desde cuando, y sigue pasando? → sinds.

🔑 Los dos trucos que resuelven las dudas de verdad:
• uit frente a vanuit — uit implica SALIR y vanuit no. Ik stap uit de trein (me bajo) frente a Ik bel vanuit de trein (sigo dentro).
• vanaf frente a sinds — vanaf mira al FUTURO y sinds al PASADO. Vanaf maandag ben ik er (a partir del lunes) frente a Ik woon hier sinds 2020 (y sigo viviendo).

📐 Y si el desde lleva un HASTA, la pareja es van … tot: van maandag tot vrijdag. Para incluir el ultimo dia, tot en met, que se abrevia t/m y es lo que veras en horarios y plazos.

🪞 Todo esto contesta a la misma pregunta, Waar kom je vandaan?, que esta en el grupo de adverbios pronominales: la respuesta lleva uit si hablas de tu origen y van si hablas de donde vienes ahora.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Desde: uit koelkast');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'vengo del médico', 'PHRASE', 'Desde: van dokter',
'Ik kom van de dokter = vengo del medico. van es el desde generico: el punto del que vienes AHORA, sin la idea de interior que tiene uit.

🎭 uit o van, que es la pareja que mas se confunde en las respuestas:
• Ik kom uit Spanje. — Soy de España. Tu ORIGEN, de donde eres.
• Ik kom van de dokter. — Vengo del medico. De donde vienes AHORA.
Las dos contestan a Waar kom je vandaan?, y solo el contexto dice cual toca.

📋 Los sitios de los que se viene con van, casi siempre sin articulo o con posesivo:
• van mijn werk — del trabajo.
• van school — del colegio.
• van de markt — del mercado.
• van de kapper — de la peluqueria.
• van een feestje — de una fiesta.

📦 Y van tiene otra vida, la de la posesion, que no es este desde pero conviene tenerla presente: de sleutel van de auto (la llave del coche), een vriend van mij (un amigo mio). Es el mismo van, y por eso la 973 pregunta Waar is deze sleutel van?

🏋️ Ejercicio: «vengo de la peluqueria» → Ik kom ___ de kapper. (Respuesta: van.)

📍 Las cinco maneras de decir desde:

El español dice desde para cinco cosas distintas y el neerlandes las separa. Lo que decide es si hay un interior, si te mueves, y hacia donde va el tiempo.

| preposicion | que marca | ejemplo |
|---|---|---|
| **uit** | desde DENTRO, saliendo. Origen y procedencia de un interior | Ik kom **uit** Spanje. |
| **van** | punto de partida generico, de donde vienes ahora | Ik kom **van** de dokter. |
| **vanaf** | a partir de. Mira al FUTURO, o marca el inicio de un recorrido o una escala | **Vanaf** morgen. |
| **vanuit** | desde dentro pero SIN salir. La perspectiva desde la que haces algo | Ik werk **vanuit** huis. |
| **sinds** | desde cuando. Mira al PASADO, y la cosa dura hasta hoy | Ik woon hier **sinds** 2020. |

📌 Regla de bolsillo:
• ¿Es tu origen, tu pais, o sales del interior de algo? → uit.
• ¿De donde vienes ahora mismo? → van.
• ¿A partir de cuando, mirando adelante? → vanaf.
• ¿Desde donde haces algo sin moverte de ahi? → vanuit.
• ¿Desde cuando, y sigue pasando? → sinds.

🔑 Los dos trucos que resuelven las dudas de verdad:
• uit frente a vanuit — uit implica SALIR y vanuit no. Ik stap uit de trein (me bajo) frente a Ik bel vanuit de trein (sigo dentro).
• vanaf frente a sinds — vanaf mira al FUTURO y sinds al PASADO. Vanaf maandag ben ik er (a partir del lunes) frente a Ik woon hier sinds 2020 (y sigo viviendo).

📐 Y si el desde lleva un HASTA, la pareja es van … tot: van maandag tot vrijdag. Para incluir el ultimo dia, tot en met, que se abrevia t/m y es lo que veras en horarios y plazos.

🪞 Todo esto contesta a la misma pregunta, Waar kom je vandaan?, que esta en el grupo de adverbios pronominales: la respuesta lleva uit si hablas de tu origen y van si hablas de donde vienes ahora.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Desde: van dokter');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'de lunes a viernes', 'PHRASE', 'Desde: van tot',
'van maandag tot vrijdag = de lunes a viernes. Cuando el desde tiene un HASTA, la pareja es van … tot: marca un tramo cerrado, con principio y final.

📐 La pareja completa: van + inicio + tot + final. Y para incluir el final se dice tot en met, que se abrevia t/m y lo veras en formularios: van maandag tot en met vrijdag (de lunes a viernes, viernes incluido).

⚠️ Esa distincion importa de verdad: tot vrijdag deja el viernes FUERA y tot en met vrijdag lo incluye. En horarios de tiendas y en plazos oficiales se usa siempre t/m para que no haya dudas.

📋 El par van … tot en sus usos:
• van maandag tot vrijdag — de lunes a viernes.
• van negen tot vijf — de nueve a cinco.
• van Amsterdam tot Utrecht — de Ámsterdam a Utrecht.
• van kop tot teen — de la cabeza a los pies.

🔑 El truco: Si hay un final explicito, van … tot. Si no lo hay y solo dices a partir de cuando, vanaf. Van maandag tot vrijdag frente a Vanaf maandag.

🏋️ Ejercicio: «de nueve a cinco, las cinco incluidas» → van negen ___ ___ ___ vijf. (Respuesta: tot en met.)

📍 Las cinco maneras de decir desde:

El español dice desde para cinco cosas distintas y el neerlandes las separa. Lo que decide es si hay un interior, si te mueves, y hacia donde va el tiempo.

| preposicion | que marca | ejemplo |
|---|---|---|
| **uit** | desde DENTRO, saliendo. Origen y procedencia de un interior | Ik kom **uit** Spanje. |
| **van** | punto de partida generico, de donde vienes ahora | Ik kom **van** de dokter. |
| **vanaf** | a partir de. Mira al FUTURO, o marca el inicio de un recorrido o una escala | **Vanaf** morgen. |
| **vanuit** | desde dentro pero SIN salir. La perspectiva desde la que haces algo | Ik werk **vanuit** huis. |
| **sinds** | desde cuando. Mira al PASADO, y la cosa dura hasta hoy | Ik woon hier **sinds** 2020. |

📌 Regla de bolsillo:
• ¿Es tu origen, tu pais, o sales del interior de algo? → uit.
• ¿De donde vienes ahora mismo? → van.
• ¿A partir de cuando, mirando adelante? → vanaf.
• ¿Desde donde haces algo sin moverte de ahi? → vanuit.
• ¿Desde cuando, y sigue pasando? → sinds.

🔑 Los dos trucos que resuelven las dudas de verdad:
• uit frente a vanuit — uit implica SALIR y vanuit no. Ik stap uit de trein (me bajo) frente a Ik bel vanuit de trein (sigo dentro).
• vanaf frente a sinds — vanaf mira al FUTURO y sinds al PASADO. Vanaf maandag ben ik er (a partir del lunes) frente a Ik woon hier sinds 2020 (y sigo viviendo).

📐 Y si el desde lleva un HASTA, la pareja es van … tot: van maandag tot vrijdag. Para incluir el ultimo dia, tot en met, que se abrevia t/m y es lo que veras en horarios y plazos.

🪞 Todo esto contesta a la misma pregunta, Waar kom je vandaan?, que esta en el grupo de adverbios pronominales: la respuesta lleva uit si hablas de tu origen y van si hablas de donde vienes ahora.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Desde: van tot');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'a partir de mañana trabajo en casa', 'PHRASE', 'Desde: vanaf morgen',
'Vanaf morgen werk ik thuis = a partir de mañana trabajo en casa. vanaf es el desde que mira HACIA ADELANTE: marca cuando empieza algo que a partir de ahi sigue.

📐 vanaf en primera posicion obliga a invertir, como cualquier complemento que abra la frase: Vanaf morgen WERK IK thuis, y no «vanaf morgen ik werk».

🕐 vanaf o sinds, que es LA duda del desde temporal:
• vanaf — mira al FUTURO. Vanaf maandag ben ik er. (a partir del lunes)
• sinds — mira al PASADO, desde entonces hasta ahora. Ik woon hier sinds 2020.

🔑 El truco que casi nunca falla: Pregunta hacia donde va el tiempo. Si el punto esta en el futuro y lo que viene despues aun no ha pasado, vanaf. Si el punto esta en el pasado y la cosa dura hasta hoy, sinds.

📋 vanaf tambien vale para escalas y recorridos, no solo para el tiempo:
• vanaf 10 euro — desde 10 euros. (en anuncios y precios)
• vanaf hier — desde aquí.
• vanaf het station — desde la estación.
• vanaf nu — de ahora en adelante.

🏋️ Ejercicio: «a partir del lunes» → ___ maandag. Y «desde 2020» → ___ 2020. (Respuestas: Vanaf · sinds.)

📍 Las cinco maneras de decir desde:

El español dice desde para cinco cosas distintas y el neerlandes las separa. Lo que decide es si hay un interior, si te mueves, y hacia donde va el tiempo.

| preposicion | que marca | ejemplo |
|---|---|---|
| **uit** | desde DENTRO, saliendo. Origen y procedencia de un interior | Ik kom **uit** Spanje. |
| **van** | punto de partida generico, de donde vienes ahora | Ik kom **van** de dokter. |
| **vanaf** | a partir de. Mira al FUTURO, o marca el inicio de un recorrido o una escala | **Vanaf** morgen. |
| **vanuit** | desde dentro pero SIN salir. La perspectiva desde la que haces algo | Ik werk **vanuit** huis. |
| **sinds** | desde cuando. Mira al PASADO, y la cosa dura hasta hoy | Ik woon hier **sinds** 2020. |

📌 Regla de bolsillo:
• ¿Es tu origen, tu pais, o sales del interior de algo? → uit.
• ¿De donde vienes ahora mismo? → van.
• ¿A partir de cuando, mirando adelante? → vanaf.
• ¿Desde donde haces algo sin moverte de ahi? → vanuit.
• ¿Desde cuando, y sigue pasando? → sinds.

🔑 Los dos trucos que resuelven las dudas de verdad:
• uit frente a vanuit — uit implica SALIR y vanuit no. Ik stap uit de trein (me bajo) frente a Ik bel vanuit de trein (sigo dentro).
• vanaf frente a sinds — vanaf mira al FUTURO y sinds al PASADO. Vanaf maandag ben ik er (a partir del lunes) frente a Ik woon hier sinds 2020 (y sigo viviendo).

📐 Y si el desde lleva un HASTA, la pareja es van … tot: van maandag tot vrijdag. Para incluir el ultimo dia, tot en met, que se abrevia t/m y es lo que veras en horarios y plazos.

🪞 Todo esto contesta a la misma pregunta, Waar kom je vandaan?, que esta en el grupo de adverbios pronominales: la respuesta lleva uit si hablas de tu origen y van si hablas de donde vienes ahora.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Desde: vanaf morgen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'desde aquí son cinco minutos andando', 'PHRASE', 'Desde: vanaf hier',
'Vanaf hier is het vijf minuten lopen = desde aqui son cinco minutos andando. Aqui vanaf no es tiempo sino RECORRIDO: marca el punto desde el que se cuenta una distancia.

📐 Fijate en la formula de las distancias: is het + cantidad + lopen o fietsen o rijden, con el verbo en infinitivo al final. Het is tien minuten lopen (son diez minutos andando), Het is een uur rijden (es una hora en coche).

📋 vanaf con recorridos y escalas:
• Vanaf het station is het tien minuten. — Desde la estación son diez minutos.
• Vanaf de derde verdieping. — A partir del tercer piso.
• Kinderen vanaf zes jaar. — Niños a partir de seis años.
• Vanaf 10 euro. — Desde 10 euros.

🎭 Y la diferencia con van, que aqui se nota: Ik kom van het station es vengo de la estacion (de donde vengo), mientras que Vanaf het station is het tien minuten es desde la estacion son diez minutos (el punto donde empieza a contar). van dice de donde vienes; vanaf, donde empieza la cuenta.

🏋️ Ejercicio: «niños a partir de 12 años» → Kinderen ___ twaalf jaar. (Respuesta: vanaf.)

📍 Las cinco maneras de decir desde:

El español dice desde para cinco cosas distintas y el neerlandes las separa. Lo que decide es si hay un interior, si te mueves, y hacia donde va el tiempo.

| preposicion | que marca | ejemplo |
|---|---|---|
| **uit** | desde DENTRO, saliendo. Origen y procedencia de un interior | Ik kom **uit** Spanje. |
| **van** | punto de partida generico, de donde vienes ahora | Ik kom **van** de dokter. |
| **vanaf** | a partir de. Mira al FUTURO, o marca el inicio de un recorrido o una escala | **Vanaf** morgen. |
| **vanuit** | desde dentro pero SIN salir. La perspectiva desde la que haces algo | Ik werk **vanuit** huis. |
| **sinds** | desde cuando. Mira al PASADO, y la cosa dura hasta hoy | Ik woon hier **sinds** 2020. |

📌 Regla de bolsillo:
• ¿Es tu origen, tu pais, o sales del interior de algo? → uit.
• ¿De donde vienes ahora mismo? → van.
• ¿A partir de cuando, mirando adelante? → vanaf.
• ¿Desde donde haces algo sin moverte de ahi? → vanuit.
• ¿Desde cuando, y sigue pasando? → sinds.

🔑 Los dos trucos que resuelven las dudas de verdad:
• uit frente a vanuit — uit implica SALIR y vanuit no. Ik stap uit de trein (me bajo) frente a Ik bel vanuit de trein (sigo dentro).
• vanaf frente a sinds — vanaf mira al FUTURO y sinds al PASADO. Vanaf maandag ben ik er (a partir del lunes) frente a Ik woon hier sinds 2020 (y sigo viviendo).

📐 Y si el desde lleva un HASTA, la pareja es van … tot: van maandag tot vrijdag. Para incluir el ultimo dia, tot en met, que se abrevia t/m y es lo que veras en horarios y plazos.

🪞 Todo esto contesta a la misma pregunta, Waar kom je vandaan?, que esta en el grupo de adverbios pronominales: la respuesta lleva uit si hablas de tu origen y van si hablas de donde vienes ahora.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Desde: vanaf hier');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'te llamo desde el tren', 'PHRASE', 'Desde: vanuit trein',
'Ik bel je vanuit de trein = te llamo desde el tren. vanuit es van + uit: el punto DESDE DENTRO del cual haces algo, sin salir de ahi.

🔑 La diferencia con uit, que es la que hay que fijar: uit implica SALIR, vanuit no. Ik stap uit de trein es me bajo del tren (salgo); Ik bel vanuit de trein es llamo desde el tren (sigo dentro).

📋 vanuit en sus dos usos:
• Fisico, haciendo algo sin moverte de donde estas — Ik werk vanuit huis. Ik bel vanuit de trein. Ik kijk vanuit het raam.
• Figurado, la perspectiva desde la que se mira — vanuit mijn oogpunt (desde mi punto de vista), vanuit die gedachte (partiendo de esa idea), vanuit historisch perspectief.

⚠️ Y ojo a huis, que con vanuit va SIN articulo: Ik werk vanuit huis, no «vanuit het huis». Es de las locuciones fijas de lugar que pierden el articulo, como naar huis y thuis.

🎭 Los cuatro de un vistazo con el mismo sustantivo: uit het huis (saliendo de la casa) · van het huis (la llave del huis, o viniendo de alli) · vanaf het huis (contando la distancia desde alli) · vanuit huis (haciendo algo desde dentro).

🏋️ Ejercicio: «trabajo desde casa» → Ik werk ___ huis. (Respuesta: vanuit, y sin articulo.)

📍 Las cinco maneras de decir desde:

El español dice desde para cinco cosas distintas y el neerlandes las separa. Lo que decide es si hay un interior, si te mueves, y hacia donde va el tiempo.

| preposicion | que marca | ejemplo |
|---|---|---|
| **uit** | desde DENTRO, saliendo. Origen y procedencia de un interior | Ik kom **uit** Spanje. |
| **van** | punto de partida generico, de donde vienes ahora | Ik kom **van** de dokter. |
| **vanaf** | a partir de. Mira al FUTURO, o marca el inicio de un recorrido o una escala | **Vanaf** morgen. |
| **vanuit** | desde dentro pero SIN salir. La perspectiva desde la que haces algo | Ik werk **vanuit** huis. |
| **sinds** | desde cuando. Mira al PASADO, y la cosa dura hasta hoy | Ik woon hier **sinds** 2020. |

📌 Regla de bolsillo:
• ¿Es tu origen, tu pais, o sales del interior de algo? → uit.
• ¿De donde vienes ahora mismo? → van.
• ¿A partir de cuando, mirando adelante? → vanaf.
• ¿Desde donde haces algo sin moverte de ahi? → vanuit.
• ¿Desde cuando, y sigue pasando? → sinds.

🔑 Los dos trucos que resuelven las dudas de verdad:
• uit frente a vanuit — uit implica SALIR y vanuit no. Ik stap uit de trein (me bajo) frente a Ik bel vanuit de trein (sigo dentro).
• vanaf frente a sinds — vanaf mira al FUTURO y sinds al PASADO. Vanaf maandag ben ik er (a partir del lunes) frente a Ik woon hier sinds 2020 (y sigo viviendo).

📐 Y si el desde lleva un HASTA, la pareja es van … tot: van maandag tot vrijdag. Para incluir el ultimo dia, tot en met, que se abrevia t/m y es lo que veras en horarios y plazos.

🪞 Todo esto contesta a la misma pregunta, Waar kom je vandaan?, que esta en el grupo de adverbios pronominales: la respuesta lleva uit si hablas de tu origen y van si hablas de donde vienes ahora.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Desde: vanuit trein');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'desde mi punto de vista', 'PHRASE', 'Desde: vanuit oogpunt',
'Vanuit mijn oogpunt gezien = desde mi punto de vista. Es el uso FIGURADO de vanuit: la perspectiva desde la que se mira algo.

📐 La formula completa suele llevar gezien al final, que es visto: vanuit … gezien. Se puede omitir y sigue siendo correcto: Vanuit mijn oogpunt is dat geen probleem.

📋 Las de este corte, que salen en reuniones y en textos:
• vanuit mijn oogpunt — desde mi punto de vista.
• vanuit dat perspectief — desde esa perspectiva.
• vanuit die gedachte — partiendo de esa idea.
• vanuit praktisch oogpunt — desde un punto de vista práctico.

📦 het oogpunt es el punto de vista, y viene de het oog (el ojo) mas het punt. Sus sinonimos: het perspectief, het standpunt (la postura, mas de opinion), het gezichtspunt.

🎭 Y las otras maneras de dar tu opinion, que ya estan en el mazo: volgens mij (para mi, lo corriente), naar mijn mening (en mi opinion, formal), ik vind (yo creo). vanuit mijn oogpunt es el registro de trabajo.

🏋️ Ejercicio: «desde un punto de vista practico» → ___ praktisch oogpunt. (Respuesta: vanuit.)

📍 Las cinco maneras de decir desde:

El español dice desde para cinco cosas distintas y el neerlandes las separa. Lo que decide es si hay un interior, si te mueves, y hacia donde va el tiempo.

| preposicion | que marca | ejemplo |
|---|---|---|
| **uit** | desde DENTRO, saliendo. Origen y procedencia de un interior | Ik kom **uit** Spanje. |
| **van** | punto de partida generico, de donde vienes ahora | Ik kom **van** de dokter. |
| **vanaf** | a partir de. Mira al FUTURO, o marca el inicio de un recorrido o una escala | **Vanaf** morgen. |
| **vanuit** | desde dentro pero SIN salir. La perspectiva desde la que haces algo | Ik werk **vanuit** huis. |
| **sinds** | desde cuando. Mira al PASADO, y la cosa dura hasta hoy | Ik woon hier **sinds** 2020. |

📌 Regla de bolsillo:
• ¿Es tu origen, tu pais, o sales del interior de algo? → uit.
• ¿De donde vienes ahora mismo? → van.
• ¿A partir de cuando, mirando adelante? → vanaf.
• ¿Desde donde haces algo sin moverte de ahi? → vanuit.
• ¿Desde cuando, y sigue pasando? → sinds.

🔑 Los dos trucos que resuelven las dudas de verdad:
• uit frente a vanuit — uit implica SALIR y vanuit no. Ik stap uit de trein (me bajo) frente a Ik bel vanuit de trein (sigo dentro).
• vanaf frente a sinds — vanaf mira al FUTURO y sinds al PASADO. Vanaf maandag ben ik er (a partir del lunes) frente a Ik woon hier sinds 2020 (y sigo viviendo).

📐 Y si el desde lleva un HASTA, la pareja es van … tot: van maandag tot vrijdag. Para incluir el ultimo dia, tot en met, que se abrevia t/m y es lo que veras en horarios y plazos.

🪞 Todo esto contesta a la misma pregunta, Waar kom je vandaan?, que esta en el grupo de adverbios pronominales: la respuesta lleva uit si hablas de tu origen y van si hablas de donde vienes ahora.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Desde: vanuit oogpunt');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'vivo aquí desde 2020', 'PHRASE', 'Desde: sinds 2020',
'Ik woon hier sinds 2020 = vivo aqui desde 2020. sinds es el desde que mira al PASADO: un punto de entonces, y la cosa sigue hasta hoy.

📐 Y ojo al TIEMPO VERBAL, que es donde el español y el neerlandes se separan: en neerlandes va en PRESENTE, Ik WOON hier sinds 2020, porque sigues viviendo. En español tambien decimos vivo, asi que aqui coincidimos; pero cuidado con el ingles, que pide perfecto (I have lived).

🕐 sinds o vanaf, que es la duda de siempre:
• sinds — el punto esta en el PASADO y la cosa dura hasta ahora. Ik woon hier sinds 2020.
• vanaf — el punto esta en el FUTURO y lo que viene aun no ha pasado. Vanaf 2027 woon ik daar.

📋 sinds en sus formas:
• sinds 2020 — desde 2020.
• sinds vorig jaar — desde el año pasado.
• sinds kort — desde hace poco.
• sindsdien — desde entonces. (una palabra)
• Sinds wanneer? — ¿Desde cuándo?

⚠️ Y la alternativa mas holandesa para lo mismo: al + duracion. Ik woon hier al vijf jaar es llevo cinco años viviendo aqui. Dice lo mismo que sinds 2020 pero contando el tiempo transcurrido en vez del punto de partida.

🏋️ Ejercicio: «lo conozco desde el año pasado» → Ik ken hem ___ vorig jaar. (Respuesta: sinds.)

📍 Las cinco maneras de decir desde:

El español dice desde para cinco cosas distintas y el neerlandes las separa. Lo que decide es si hay un interior, si te mueves, y hacia donde va el tiempo.

| preposicion | que marca | ejemplo |
|---|---|---|
| **uit** | desde DENTRO, saliendo. Origen y procedencia de un interior | Ik kom **uit** Spanje. |
| **van** | punto de partida generico, de donde vienes ahora | Ik kom **van** de dokter. |
| **vanaf** | a partir de. Mira al FUTURO, o marca el inicio de un recorrido o una escala | **Vanaf** morgen. |
| **vanuit** | desde dentro pero SIN salir. La perspectiva desde la que haces algo | Ik werk **vanuit** huis. |
| **sinds** | desde cuando. Mira al PASADO, y la cosa dura hasta hoy | Ik woon hier **sinds** 2020. |

📌 Regla de bolsillo:
• ¿Es tu origen, tu pais, o sales del interior de algo? → uit.
• ¿De donde vienes ahora mismo? → van.
• ¿A partir de cuando, mirando adelante? → vanaf.
• ¿Desde donde haces algo sin moverte de ahi? → vanuit.
• ¿Desde cuando, y sigue pasando? → sinds.

🔑 Los dos trucos que resuelven las dudas de verdad:
• uit frente a vanuit — uit implica SALIR y vanuit no. Ik stap uit de trein (me bajo) frente a Ik bel vanuit de trein (sigo dentro).
• vanaf frente a sinds — vanaf mira al FUTURO y sinds al PASADO. Vanaf maandag ben ik er (a partir del lunes) frente a Ik woon hier sinds 2020 (y sigo viviendo).

📐 Y si el desde lleva un HASTA, la pareja es van … tot: van maandag tot vrijdag. Para incluir el ultimo dia, tot en met, que se abrevia t/m y es lo que veras en horarios y plazos.

🪞 Todo esto contesta a la misma pregunta, Waar kom je vandaan?, que esta en el grupo de adverbios pronominales: la respuesta lleva uit si hablas de tu origen y van si hablas de donde vienes ahora.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Desde: sinds 2020');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no lo veo desde el verano (a él)', 'PHRASE', 'Desde: sinds niet gezien',
'Ik heb hem sinds de zomer niet gezien = no lo veo desde el verano. Con una negacion, sinds marca desde cuando NO pasa algo, y aqui el verbo si va en perfecto.

📐 Fijate en el contraste de tiempos con la tarjeta hermana: Ik woon hier sinds 2020 va en PRESENTE porque la accion continua, pero Ik heb hem sinds de zomer niet gezien va en PERFECTO porque lo que se cuenta es que la accion NO ha ocurrido en ese tramo.

🔑 La regla: Si la accion sigue pasando, presente. Si lo que dices es que no ha vuelto a pasar, perfecto con niet.

📋 Las que se dicen asi:
• Ik heb hem sinds de zomer niet gezien. — No lo veo desde el verano.
• Ze heeft sindsdien niets meer gezegd. — Desde entonces no ha dicho nada más.
• Ik ben hier sinds vorig jaar niet meer geweest. — No vengo aquí desde el año pasado.

⚠️ Y fijate en niet meer, que aparece mucho en estas frases: es el ya no del cuadrado al / nog / nog niet / niet meer. Sinds de zomer niet meer es desde el verano ya no.

🏋️ Ejercicio: «desde entonces no he vuelto» → ___ ben ik niet meer geweest. (Respuesta: Sindsdien.)

📍 Las cinco maneras de decir desde:

El español dice desde para cinco cosas distintas y el neerlandes las separa. Lo que decide es si hay un interior, si te mueves, y hacia donde va el tiempo.

| preposicion | que marca | ejemplo |
|---|---|---|
| **uit** | desde DENTRO, saliendo. Origen y procedencia de un interior | Ik kom **uit** Spanje. |
| **van** | punto de partida generico, de donde vienes ahora | Ik kom **van** de dokter. |
| **vanaf** | a partir de. Mira al FUTURO, o marca el inicio de un recorrido o una escala | **Vanaf** morgen. |
| **vanuit** | desde dentro pero SIN salir. La perspectiva desde la que haces algo | Ik werk **vanuit** huis. |
| **sinds** | desde cuando. Mira al PASADO, y la cosa dura hasta hoy | Ik woon hier **sinds** 2020. |

📌 Regla de bolsillo:
• ¿Es tu origen, tu pais, o sales del interior de algo? → uit.
• ¿De donde vienes ahora mismo? → van.
• ¿A partir de cuando, mirando adelante? → vanaf.
• ¿Desde donde haces algo sin moverte de ahi? → vanuit.
• ¿Desde cuando, y sigue pasando? → sinds.

🔑 Los dos trucos que resuelven las dudas de verdad:
• uit frente a vanuit — uit implica SALIR y vanuit no. Ik stap uit de trein (me bajo) frente a Ik bel vanuit de trein (sigo dentro).
• vanaf frente a sinds — vanaf mira al FUTURO y sinds al PASADO. Vanaf maandag ben ik er (a partir del lunes) frente a Ik woon hier sinds 2020 (y sigo viviendo).

📐 Y si el desde lleva un HASTA, la pareja es van … tot: van maandag tot vrijdag. Para incluir el ultimo dia, tot en met, que se abrevia t/m y es lo que veras en horarios y plazos.

🪞 Todo esto contesta a la misma pregunta, Waar kom je vandaan?, que esta en el grupo de adverbios pronominales: la respuesta lleva uit si hablas de tu origen y van si hablas de donde vienes ahora.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Desde: sinds niet gezien');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'llevo cinco años viviendo aquí', 'PHRASE', 'Desde: al vijf jaar',
'Ik woon hier al vijf jaar = llevo cinco años viviendo aqui. Es la alternativa a sinds, y en neerlandes suena aun mas natural: en vez del punto de partida se cuenta el TIEMPO TRANSCURRIDO.

📐 El molde: sujeto + verbo en PRESENTE + al + la duracion. Ik woon hier al vijf jaar. Y otra vez presente, porque la cosa sigue.

🎭 Las dos maneras de decir lo mismo:
• Ik woon hier sinds 2020. — Vivo aquí desde 2020. Da el punto.
• Ik woon hier al vijf jaar. — Llevo cinco años viviendo aquí. Da la duración.
La segunda es la que oiras mas.

⚠️ Y ojo al llevar + gerundio del español, que NO se traduce con ningun verbo: no hay un llevar. Se dice con al + duracion y el verbo en presente. «Ik draag vijf jaar hier wonend» no existe ni se acerca.

📋 Con otras duraciones:
• Ik wacht al een uur. — Llevo una hora esperando.
• We kennen elkaar al jaren. — Nos conocemos desde hace años.
• Hij is al drie weken ziek. — Lleva tres semanas enfermo.

🏋️ Ejercicio: «llevo dos horas esperando» → Ik wacht ___ twee uur. (Respuesta: al.)

📍 Las cinco maneras de decir desde:

El español dice desde para cinco cosas distintas y el neerlandes las separa. Lo que decide es si hay un interior, si te mueves, y hacia donde va el tiempo.

| preposicion | que marca | ejemplo |
|---|---|---|
| **uit** | desde DENTRO, saliendo. Origen y procedencia de un interior | Ik kom **uit** Spanje. |
| **van** | punto de partida generico, de donde vienes ahora | Ik kom **van** de dokter. |
| **vanaf** | a partir de. Mira al FUTURO, o marca el inicio de un recorrido o una escala | **Vanaf** morgen. |
| **vanuit** | desde dentro pero SIN salir. La perspectiva desde la que haces algo | Ik werk **vanuit** huis. |
| **sinds** | desde cuando. Mira al PASADO, y la cosa dura hasta hoy | Ik woon hier **sinds** 2020. |

📌 Regla de bolsillo:
• ¿Es tu origen, tu pais, o sales del interior de algo? → uit.
• ¿De donde vienes ahora mismo? → van.
• ¿A partir de cuando, mirando adelante? → vanaf.
• ¿Desde donde haces algo sin moverte de ahi? → vanuit.
• ¿Desde cuando, y sigue pasando? → sinds.

🔑 Los dos trucos que resuelven las dudas de verdad:
• uit frente a vanuit — uit implica SALIR y vanuit no. Ik stap uit de trein (me bajo) frente a Ik bel vanuit de trein (sigo dentro).
• vanaf frente a sinds — vanaf mira al FUTURO y sinds al PASADO. Vanaf maandag ben ik er (a partir del lunes) frente a Ik woon hier sinds 2020 (y sigo viviendo).

📐 Y si el desde lleva un HASTA, la pareja es van … tot: van maandag tot vrijdag. Para incluir el ultimo dia, tot en met, que se abrevia t/m y es lo que veras en horarios y plazos.

🪞 Todo esto contesta a la misma pregunta, Waar kom je vandaan?, que esta en el grupo de adverbios pronominales: la respuesta lleva uit si hablas de tu origen y van si hablas de donde vienes ahora.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Desde: al vijf jaar');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'desde 10 euros', 'PHRASE', 'Desde: vanaf tien euro',
'vanaf 10 euro = desde 10 euros. Es el vanaf de las ESCALAS: marca el minimo de un rango, y es lo que veras en anuncios, menus y tiendas.

📐 Fijate en que euro va en SINGULAR despues de un numero: 10 euro y no «10 euros». Pasa con las unidades de medida y moneda: drie kilo, vijf meter, tien euro, twee uur.

⚠️ Esa es una regla que ahorra errores: en neerlandes las unidades no se pluralizan detras de un numero. Se dice vier jaar (cuatro años), twintig kilometer, honderd gram. Solo se pluralizan cuando no hay numero delante: de euro''s, de jaren.

📋 vanaf en precios y rangos, tal como aparece:
• vanaf 10 euro — desde 10 euros.
• vanaf 6 jaar — a partir de 6 años.
• vanaf maat 38 — a partir de la talla 38.
• Alles vanaf hier is afgeprijsd. — Todo a partir de aquí está rebajado.

💰 Y el vocabulario del precio: de prijs (el precio), de korting (el descuento), de aanbieding (la oferta), afgeprijsd (rebajado), gratis (gratis) y het is in de aanbieding (está de oferta).

🏋️ Ejercicio: «a partir de 18 años» → ___ 18 jaar. (Respuesta: vanaf.)

📍 Las cinco maneras de decir desde:

El español dice desde para cinco cosas distintas y el neerlandes las separa. Lo que decide es si hay un interior, si te mueves, y hacia donde va el tiempo.

| preposicion | que marca | ejemplo |
|---|---|---|
| **uit** | desde DENTRO, saliendo. Origen y procedencia de un interior | Ik kom **uit** Spanje. |
| **van** | punto de partida generico, de donde vienes ahora | Ik kom **van** de dokter. |
| **vanaf** | a partir de. Mira al FUTURO, o marca el inicio de un recorrido o una escala | **Vanaf** morgen. |
| **vanuit** | desde dentro pero SIN salir. La perspectiva desde la que haces algo | Ik werk **vanuit** huis. |
| **sinds** | desde cuando. Mira al PASADO, y la cosa dura hasta hoy | Ik woon hier **sinds** 2020. |

📌 Regla de bolsillo:
• ¿Es tu origen, tu pais, o sales del interior de algo? → uit.
• ¿De donde vienes ahora mismo? → van.
• ¿A partir de cuando, mirando adelante? → vanaf.
• ¿Desde donde haces algo sin moverte de ahi? → vanuit.
• ¿Desde cuando, y sigue pasando? → sinds.

🔑 Los dos trucos que resuelven las dudas de verdad:
• uit frente a vanuit — uit implica SALIR y vanuit no. Ik stap uit de trein (me bajo) frente a Ik bel vanuit de trein (sigo dentro).
• vanaf frente a sinds — vanaf mira al FUTURO y sinds al PASADO. Vanaf maandag ben ik er (a partir del lunes) frente a Ik woon hier sinds 2020 (y sigo viviendo).

📐 Y si el desde lleva un HASTA, la pareja es van … tot: van maandag tot vrijdag. Para incluir el ultimo dia, tot en met, que se abrevia t/m y es lo que veras en horarios y plazos.

🪞 Todo esto contesta a la misma pregunta, Waar kom je vandaan?, que esta en el grupo de adverbios pronominales: la respuesta lleva uit si hablas de tu origen y van si hablas de donde vienes ahora.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Desde: vanaf tien euro');

-- =============================================================================
-- 3. Traducciones
-- =============================================================================
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
SELECT we.id, 'nl_NL', v.nl, v.pron
FROM (
    SELECT 'Desde: uit pais' AS k, 'Uit welk land kom je?' AS nl, 'eut velk lant kom ye' AS pron
    UNION ALL SELECT 'Desde: uit koelkast', 'Haal de melk uit de koelkast.', 'hal de melk eut de kulkast'
    UNION ALL SELECT 'Desde: van dokter', 'Ik kom van de dokter.', 'ik kom fan de dokter'
    UNION ALL SELECT 'Desde: van tot', 'van maandag tot vrijdag', 'fan mandaj tot freidaj'
    UNION ALL SELECT 'Desde: vanaf morgen', 'Vanaf morgen werk ik thuis.', 'fanaf mórjen verk ik tais'
    UNION ALL SELECT 'Desde: vanaf hier', 'Vanaf hier is het vijf minuten lopen.', 'fanaf hiir is het feif minuten loopen'
    UNION ALL SELECT 'Desde: vanuit trein', 'Ik bel je vanuit de trein.', 'ik bel ye faneut de train'
    UNION ALL SELECT 'Desde: vanuit oogpunt', 'Vanuit mijn oogpunt gezien.', 'faneut main ójpunt jesin'
    UNION ALL SELECT 'Desde: sinds 2020', 'Ik woon hier sinds 2020.', 'ik voon hiir sints tuedeuzent tuintej'
    UNION ALL SELECT 'Desde: sinds niet gezien', 'Ik heb hem sinds de zomer niet gezien.', 'ik hep hem sints de zoomer nit jesin'
    UNION ALL SELECT 'Desde: al vijf jaar', 'Ik woon hier al vijf jaar.', 'ik voon hiir al feif yar'
    UNION ALL SELECT 'Desde: vanaf tien euro', 'vanaf 10 euro', 'fanaf tin euro'
) v
JOIN words_es we ON we.notes = v.k;

-- =============================================================================
-- 4. Al grupo nuevo y a generic
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Desde: %' AND g.title = 'desde - uit, van, vanaf, vanuit, sinds';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Desde: %' AND g.title = 'generic';

-- =============================================================================
-- 5. Las tres que ya existian y son de esta familia
--    965 (Ik kom uit Spanje), 966 (Ik kom van mijn werk), 1054 (Ik werk vanuit huis)
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE g.title = 'desde - uit, van, vanaf, vanuit, sinds' AND we.id IN (965, 966, 1054);
