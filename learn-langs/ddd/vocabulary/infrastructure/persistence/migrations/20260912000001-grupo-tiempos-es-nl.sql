-- Learn Languages App - Migration
-- Migration: 20260912000001-grupo-tiempos-es-nl
-- Description: Eduardo, sobre la 1101: "no lo veo desde el verano. El negado del presente ver se
--   transforma en presente perfecto, sigo cometiendo errores en ese sentido, yo lo traduje (en el
--   examen) Ik zie hem niet sinds zomer. Creemos un grupo para practicar esto. Mezcla de todo un
--   poco, presente en español = presente en neerlandes, presente es -> participio pasado nl o
--   pasado en nl, es decir todas las variantes confusas donde los hispano hablantes cometemos mas
--   errores y es importante que en la ayuda incluyas el pq".
--
--   El fenomeno no estaba agrupado: la 1101 lo explicaba dentro del grupo 43 (desde), el grupo 18
--   trata hebben/zijn (que auxiliar, no que tiempo) y el bloque del participio fantasma trata los
--   modales. Faltaba el mapa completo ES -> NL de eleccion de TIEMPO.
--
--   Se crea el grupo 'tiempos es-nl - presente, perfectum o imperfectum' con 12 tarjetas PHRASE
--   nuevas, y se le suman 10 que ya existian y son de esta familia (1101, 1102, 261, 521, 438,
--   659, 927, 930, 932, 935): 22 en total.
--
--   Las 12 nuevas cubren las variantes donde falla un hispanohablante:
--     - presente es -> perfectum nl: hace mucho que no te veo, acabo de comer, no me acuerdo de
--       su nombre (resultado), hace dos semanas que no me llama.
--     - indefinido es -> perfectum nl al hablar: ayer comi con mi hermana, estuve alli hace dos
--       años (con geleden pospositivo).
--     - imperfecto es -> imperfectum nl: de pequeños siempre ibamos a la playa (costumbre con
--       vroeger), estaba en la ducha cuando llamaste (toen, que SIEMPRE pide imperfectum).
--     - pluscuamperfecto es -> voltooid verleden tijd: no te habia visto.
--     - presente es = presente nl: cuanto tiempo llevas esperando (al), desde que vivo aqui como
--       mejor (sinds afirmativo), mañana voy al medico (futuro con fecha).
--
--   Bloque compartido '🧭 El cuadro de tiempos es → nl' (§3.3): tabla de 10 equivalencias, regla
--   de bolsillo de 5 viñetas, el truco de reescribir con «he/ha + participio», el aviso de que
--   los auxiliares y modales prefieren el imperfectum, y la escalera del eje temporal. Se inyecta
--   byte a byte en las 22 tarjetas.
--
--   No se toca ningun words_lang.text de las existentes, asi que el audio ya generado sigue valido.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'tiempos es-nl - presente, perfectum o imperfectum',
       'El error que mas caro sale al hispanohablante no es conjugar mal, sino elegir el tiempo que pide el español en vez del que pide el neerlandes. Este grupo junta las variantes confusas con su por que: presente español que en neerlandes va en PERFECTO porque lo que cuentas es que algo no ha vuelto a pasar (Ik heb hem sinds de zomer niet gezien, y no «Ik zie hem niet sinds de zomer») o porque cuentas el resultado de algo ya ocurrido (Ik ben zijn naam vergeten, Ik heb net gegeten); indefinido español que en el habla va en perfecto (Gisteren heb ik gegeten) y el hace que es geleden y va detras del tiempo; imperfecto español que va en IMPERFECTUM, que es el tiempo de la costumbre (Vroeger gingen we altijd naar het strand) y del decorado, y que es obligatorio detras de toen; pluscuamperfecto que se calca con had o was + participio; y los casos en que el presente español SI es presente neerlandes, siempre con al midiendo la duracion (Ik woon hier al vijf jaar, Hoe lang wacht je al?), con sinds afirmativo y con el futuro que lleva fecha (Morgen ga ik naar de dokter). El truco que vertebra el grupo: reescribe la frase española con «he/ha + participio»; si suena bien, en neerlandes va perfectum aunque tu la digas en presente',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'tiempos es-nl - presente, perfectum o imperfectum');

-- =============================================================================
-- 2. Las 12 tarjetas nuevas
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hace mucho que no te veo', 'PHRASE', 'Tiempos: lang niet gezien',
'Ik heb je lang niet gezien = hace mucho que no te veo. El español lo dice en PRESENTE y el neerlandes en PERFECTO, porque lo que cuentas no es lo que haces ahora, sino que el verte no ha ocurrido en todo ese tramo.

📐 El orden de la frase: El heb va en segunda posicion, je detras, lang (el tramo de tiempo) delante de la negacion y el participio al final. El molde es hebben + complementos + niet + participio.

🔑 El truco: Si puedes decirlo con «he/ha + participio» sin que cambie el significado, va perfectum. «Hace mucho que no te veo» = «hace mucho que no te he visto» → gezien.

📋 Las que se dicen igual, todas en perfecto:
• Ik heb je lang niet gezien. — Hace mucho que no te veo.
• We hebben elkaar al jaren niet gesproken. — Hace años que no hablamos.
• Ik heb daar al maanden niets meer van gehoord. — Hace meses que no sé nada de eso.

📐 Stamtijden de zien (fuerte):

| infinitief | imperfectum | voltooid deelwoord |
|---|---|---|
| zien | zag / zagen | gezien (hebben) |

• preposicion — zien es transitivo directo (Ik zie je). Mirar HACIA algo no es zien sino kijken naar.
• el participio gezien tiene una segunda vida de preposicion: gezien de omstandigheden (dadas las circunstancias).
• sustantivo derivado — het gezicht (la cara, y tambien la vista), het uitzicht (las vistas).

⚠️ Con lang, jaren o maanden delante de la negacion el neerlandes cierra en perfecto. Ik zie je lang niet no dice lo que quieres decir.

🏋️ Ejercicio: «hace semanas que no le escribo» → Ik ___ hem al weken niet ___. (Respuesta: heb … geschreven.)

🧭 El cuadro de tiempos es → nl:

El fallo no es conjugar mal: es elegir el tiempo que pide el español en vez del que pide el neerlandes. Este es el mapa.

| lo que dices en español | lo que va en neerlandes | ejemplo |
|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | **Morgen ga ik** naar de dokter. |

📌 Regla de bolsillo:
• ¿Sigue pasando ahora mismo? → presente, y casi siempre con al.
• ¿Lo que dices es que NO ha vuelto a pasar? → perfectum, con niet o niet meer.
• ¿Es un hecho suelto del pasado, contado en conversacion? → perfectum.
• ¿Es el decorado, la costumbre o un verbo modal? → imperfectum.
• ¿Hay un toen delante? → imperfectum, sin excepcion.

🔑 El truco que casi nunca falla: Reescribe la frase española con «he/ha + participio». Si suena bien, en neerlandes va perfectum aunque tu la digas en presente — «no lo veo desde el verano» = «no lo he visto desde el verano» → Ik heb hem niet gezien. Si no cabe ese «he» y lo que describes es el decorado del pasado, va imperfectum.

⚠️ Los auxiliares y los modales van por libre: zijn, hebben, kunnen, moeten, willen y zullen prefieren el imperfectum incluso hablando — was, had, kon, moest, wilde, zou. Donde el español dice he podido, el neerlandes dice ik kon.

🪜 El eje que lo ordena todo: Sigue pasando hoy → presente · ya paso pero su resultado cuenta ahora, o no ha vuelto a pasar → perfectum · esta cerrado y lo estas narrando o describiendo → imperfectum · ya estaba hecho antes de otra cosa pasada → had o was + participio.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Tiempos: lang niet gezien');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'acabo de comer', 'PHRASE', 'Tiempos: net gegeten',
'Ik heb net gegeten = acabo de comer. El neerlandes no tiene «acabar de»: lo dice con el PERFECTO mas net, mientras el español lo dice en presente.

🔑 La equivalencia directa: Acabar de + infinitivo = net + perfecto. No busques un verbo que signifique acabar de, porque no existe.

📋 Las tres maneras de decirlo, de mas a menos corriente:
• Ik heb net gegeten. — Acabo de comer.
• Ik heb zojuist gegeten. — Acabo de comer. (mas formal, de texto escrito)
• Ik heb pas gegeten. — He comido hace nada.

⚠️ net y pas no son lo mismo aunque a veces se toquen: net es justo ahora mismo, pas es hace poco o mas tarde de lo esperado. Y pas tiene otra vida entera: Hij komt pas om acht uur (no llega hasta las ocho).

📐 El auxiliar lo decide el verbo, no el net: Ik heb net gegeten pero We zijn net aangekomen, porque aankomen es movimiento con cambio de lugar.

📐 Stamtijden de eten (fuerte):

| infinitief | imperfectum | voltooid deelwoord |
|---|---|---|
| eten | at / aten | gegeten (hebben) |

• preposicion — transitivo directo (Ik eet een appel); comer EN un sitio es eten bij o eten in.
• sustantivo derivado — het eten (la comida), het porque es infinitivo sustantivado.
• expresion hecha — Eet smakelijk! (que aproveche).

🏋️ Ejercicio: «acabo de hablar con ella» → Ik ___ haar ___ gesproken. (Respuesta: heb … net.)

🧭 El cuadro de tiempos es → nl:

El fallo no es conjugar mal: es elegir el tiempo que pide el español en vez del que pide el neerlandes. Este es el mapa.

| lo que dices en español | lo que va en neerlandes | ejemplo |
|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | **Morgen ga ik** naar de dokter. |

📌 Regla de bolsillo:
• ¿Sigue pasando ahora mismo? → presente, y casi siempre con al.
• ¿Lo que dices es que NO ha vuelto a pasar? → perfectum, con niet o niet meer.
• ¿Es un hecho suelto del pasado, contado en conversacion? → perfectum.
• ¿Es el decorado, la costumbre o un verbo modal? → imperfectum.
• ¿Hay un toen delante? → imperfectum, sin excepcion.

🔑 El truco que casi nunca falla: Reescribe la frase española con «he/ha + participio». Si suena bien, en neerlandes va perfectum aunque tu la digas en presente — «no lo veo desde el verano» = «no lo he visto desde el verano» → Ik heb hem niet gezien. Si no cabe ese «he» y lo que describes es el decorado del pasado, va imperfectum.

⚠️ Los auxiliares y los modales van por libre: zijn, hebben, kunnen, moeten, willen y zullen prefieren el imperfectum incluso hablando — was, had, kon, moest, wilde, zou. Donde el español dice he podido, el neerlandes dice ik kon.

🪜 El eje que lo ordena todo: Sigue pasando hoy → presente · ya paso pero su resultado cuenta ahora, o no ha vuelto a pasar → perfectum · esta cerrado y lo estas narrando o describiendo → imperfectum · ya estaba hecho antes de otra cosa pasada → had o was + participio.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Tiempos: net gegeten');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no me acuerdo de su nombre (de él)', 'PHRASE', 'Tiempos: naam vergeten',
'Ik ben zijn naam vergeten = no me acuerdo de su nombre. El español habla del ahora y lo dice en presente; el neerlandes cuenta el HECHO que produjo ese ahora, y por eso va en perfecto.

🔑 El truco del resultado: Cuando el español describe un estado de ahora que viene de algo ya ocurrido, el neerlandes cuenta lo ocurrido. No me acuerdo = se me ha olvidado → ik ben het vergeten.

⚠️ vergeten admite los dos auxiliares y el matiz cambia:
• Ik ben zijn naam vergeten. — No me acuerdo de su nombre. (con objeto, zijn: el estado de no tenerlo ya)
• Ik ben vergeten je terug te bellen. — Olvidé devolverte la llamada. (con te + infinitivo, tambien zijn en el uso corriente)
• Ik heb mijn paraplu vergeten. — Me he dejado el paraguas. (hebben cuando es dejarse una cosa en un sitio)

📋 Otros estados de ahora que el neerlandes cuenta en perfecto:
• Ik ben mijn sleutels kwijt. — No encuentro mis llaves.
• Dat heb ik niet begrepen. — Eso no lo entiendo. (de lo que se acaba de decir)
• Hij is in slaap gevallen. — Está dormido.

📐 Stamtijden de vergeten (fuerte, inseparable):

| infinitief | imperfectum | voltooid deelwoord |
|---|---|---|
| vergeten | vergat / vergaten | vergeten (zijn o hebben) |

• el participio es igual que el infinitivo y va SIN ge-, porque ver- es prefijo atono inseparable.
• antonimo — zich herinneren (acordarse), reflexivo: Ik herinner me zijn naam niet meer.
• sustantivo derivado — de vergetelheid (el olvido), de con -heid.

🏋️ Ejercicio: «no me acuerdo de tu cumpleaños» → Ik ___ je verjaardag ___. (Respuesta: ben … vergeten.)

🧭 El cuadro de tiempos es → nl:

El fallo no es conjugar mal: es elegir el tiempo que pide el español en vez del que pide el neerlandes. Este es el mapa.

| lo que dices en español | lo que va en neerlandes | ejemplo |
|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | **Morgen ga ik** naar de dokter. |

📌 Regla de bolsillo:
• ¿Sigue pasando ahora mismo? → presente, y casi siempre con al.
• ¿Lo que dices es que NO ha vuelto a pasar? → perfectum, con niet o niet meer.
• ¿Es un hecho suelto del pasado, contado en conversacion? → perfectum.
• ¿Es el decorado, la costumbre o un verbo modal? → imperfectum.
• ¿Hay un toen delante? → imperfectum, sin excepcion.

🔑 El truco que casi nunca falla: Reescribe la frase española con «he/ha + participio». Si suena bien, en neerlandes va perfectum aunque tu la digas en presente — «no lo veo desde el verano» = «no lo he visto desde el verano» → Ik heb hem niet gezien. Si no cabe ese «he» y lo que describes es el decorado del pasado, va imperfectum.

⚠️ Los auxiliares y los modales van por libre: zijn, hebben, kunnen, moeten, willen y zullen prefieren el imperfectum incluso hablando — was, had, kon, moest, wilde, zou. Donde el español dice he podido, el neerlandes dice ik kon.

🪜 El eje que lo ordena todo: Sigue pasando hoy → presente · ya paso pero su resultado cuenta ahora, o no ha vuelto a pasar → perfectum · esta cerrado y lo estas narrando o describiendo → imperfectum · ya estaba hecho antes de otra cosa pasada → had o was + participio.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Tiempos: naam vergeten');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hace dos semanas que no me llama (ella, átona)', 'PHRASE', 'Tiempos: twee weken niet gebeld',
'Ze heeft me al twee weken niet gebeld = hace dos semanas que no me llama. Otra vez presente en español y PERFECTO en neerlandes, y aqui ademas entra al, que es quien mide el tramo.

📐 El orden, que es donde se falla: Sujeto + heeft + el objeto (me) + el tiempo (al twee weken) + niet + participio al final. La negacion va justo delante del participio.

🔑 Por que al y no sinds: El al mide la DURACION (dos semanas de tiempo) y el sinds marca el PUNTO de partida (desde el verano). al twee weken frente a sinds de zomer.

📋 El mismo molde con otros tramos:
• Ze heeft me al twee weken niet gebeld. — Hace dos semanas que no me llama.
• Hij heeft al maanden niet gewerkt. — Hace meses que no trabaja.
• Ik heb al dagen niet goed geslapen. — Hace días que no duermo bien.

📐 Stamtijden de bellen (debil):

| infinitief | imperfectum | voltooid deelwoord |
|---|---|---|
| bellen | belde / belden | gebeld (hebben) |

• preposicion — con persona va directo (Ik bel je), y bellen NAAR con un numero o un sitio (Ik bel naar het ziekenhuis).
• la imagen que lo fija — de bel es el timbre, asi que bellen es cosa de aparatos que suenan; llamar a alguien con la voz es roepen.
• sustantivo derivado — het telefoontje (la llamada), het por el diminutivo -tje.
• expresion hecha — Dat belt niet lekker (asi no hay quien hable) y bel me maar (tu llamame).

⚠️ Y si la que llama es ella y va atona, Ze y no Zij: zij solo cuando contrastas — ZIJ heeft me niet gebeld, maar hij wel.

🏋️ Ejercicio: «hace tres días que no come» → Hij ___ al drie dagen niet ___. (Respuesta: heeft … gegeten.)

🧭 El cuadro de tiempos es → nl:

El fallo no es conjugar mal: es elegir el tiempo que pide el español en vez del que pide el neerlandes. Este es el mapa.

| lo que dices en español | lo que va en neerlandes | ejemplo |
|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | **Morgen ga ik** naar de dokter. |

📌 Regla de bolsillo:
• ¿Sigue pasando ahora mismo? → presente, y casi siempre con al.
• ¿Lo que dices es que NO ha vuelto a pasar? → perfectum, con niet o niet meer.
• ¿Es un hecho suelto del pasado, contado en conversacion? → perfectum.
• ¿Es el decorado, la costumbre o un verbo modal? → imperfectum.
• ¿Hay un toen delante? → imperfectum, sin excepcion.

🔑 El truco que casi nunca falla: Reescribe la frase española con «he/ha + participio». Si suena bien, en neerlandes va perfectum aunque tu la digas en presente — «no lo veo desde el verano» = «no lo he visto desde el verano» → Ik heb hem niet gezien. Si no cabe ese «he» y lo que describes es el decorado del pasado, va imperfectum.

⚠️ Los auxiliares y los modales van por libre: zijn, hebben, kunnen, moeten, willen y zullen prefieren el imperfectum incluso hablando — was, had, kon, moest, wilde, zou. Donde el español dice he podido, el neerlandes dice ik kon.

🪜 El eje que lo ordena todo: Sigue pasando hoy → presente · ya paso pero su resultado cuenta ahora, o no ha vuelto a pasar → perfectum · esta cerrado y lo estas narrando o describiendo → imperfectum · ya estaba hecho antes de otra cosa pasada → had o was + participio.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Tiempos: twee weken niet gebeld');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ayer comí con mi hermana', 'PHRASE', 'Tiempos: gisteren gegeten',
'Gisteren heb ik met mijn zus gegeten = ayer comí con mi hermana. El indefinido español suelto se cuenta en PERFECTO en el neerlandes hablado, no en imperfecto.

🔑 La regla que sorprende: Hablando, el neerlandes cuenta los hechos sueltos del pasado en perfecto aunque lleven ayer, la semana pasada o en 2019. Gisteren at ik no esta mal, pero suena a narracion escrita.

📐 Y la inversion: Si la frase abre con Gisteren, el verbo conjugado se queda en SEGUNDA posicion y el sujeto pasa detras — heb ik, nunca «Gisteren ik heb».

📋 El mismo hecho contado de las dos maneras:
• Gisteren heb ik met mijn zus gegeten. — Ayer comí con mi hermana. (conversacion, lo normal)
• Gisteren at ik met mijn zus. — Ayer comía con mi hermana. (relato, narracion)
• Vorige week hebben we een huis gekocht. — La semana pasada compramos una casa.
• In 2019 ben ik naar Nederland verhuisd. — En 2019 me mudé a Holanda.

⚠️ Los que NO siguen esto son los verbos que ya viven en imperfecto: zijn, hebben y los modales. Gisteren was ik ziek, ik moest werken, ik kon niet komen — y no sus perfectos.

🪜 El reparto de los dos pasados: Perfectum para contar un hecho suelto · imperfectum para narrar, describir el decorado y hablar de costumbres.

🏋️ Ejercicio: «anoche vi una peli» → Gisteravond ___ ik een film ___. (Respuesta: heb … gezien.)

🧭 El cuadro de tiempos es → nl:

El fallo no es conjugar mal: es elegir el tiempo que pide el español en vez del que pide el neerlandes. Este es el mapa.

| lo que dices en español | lo que va en neerlandes | ejemplo |
|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | **Morgen ga ik** naar de dokter. |

📌 Regla de bolsillo:
• ¿Sigue pasando ahora mismo? → presente, y casi siempre con al.
• ¿Lo que dices es que NO ha vuelto a pasar? → perfectum, con niet o niet meer.
• ¿Es un hecho suelto del pasado, contado en conversacion? → perfectum.
• ¿Es el decorado, la costumbre o un verbo modal? → imperfectum.
• ¿Hay un toen delante? → imperfectum, sin excepcion.

🔑 El truco que casi nunca falla: Reescribe la frase española con «he/ha + participio». Si suena bien, en neerlandes va perfectum aunque tu la digas en presente — «no lo veo desde el verano» = «no lo he visto desde el verano» → Ik heb hem niet gezien. Si no cabe ese «he» y lo que describes es el decorado del pasado, va imperfectum.

⚠️ Los auxiliares y los modales van por libre: zijn, hebben, kunnen, moeten, willen y zullen prefieren el imperfectum incluso hablando — was, had, kon, moest, wilde, zou. Donde el español dice he podido, el neerlandes dice ik kon.

🪜 El eje que lo ordena todo: Sigue pasando hoy → presente · ya paso pero su resultado cuenta ahora, o no ha vuelto a pasar → perfectum · esta cerrado y lo estas narrando o describiendo → imperfectum · ya estaba hecho antes de otra cosa pasada → had o was + participio.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Tiempos: gisteren gegeten');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estuve allí hace dos años', 'PHRASE', 'Tiempos: twee jaar geleden',
'Ik ben daar twee jaar geleden geweest = estuve allí hace dos años. Dos trampas en una: el hace del español es geleden y va DETRAS del tiempo, y el verbo va en perfecto con zijn.

🔑 El truco de geleden: Va SIEMPRE detras del tiempo — twee jaar geleden, drie dagen geleden, een uur geleden. Nunca delante, y nunca con van.

⚠️ Los dos hace del español no son el mismo:
• hace + tiempo, un punto del pasado → geleden: Ik ben daar twee jaar geleden geweest.
• hace + tiempo + que, una duracion que sigue → al: Ik woon hier al twee jaar.

📋 geleden en sus usos corrientes:
• Ik ben daar twee jaar geleden geweest. — Estuve allí hace dos años.
• Dat was lang geleden. — Eso fue hace mucho.
• Hij is een uur geleden vertrokken. — Se fue hace una hora.

📐 Stamtijden de zijn (fuerte, irregular):

| infinitief | imperfectum | voltooid deelwoord |
|---|---|---|
| zijn | was / waren | geweest (zijn) |

• zijn es su propio auxiliar: ik ben geweest, nunca «ik heb geweest».
• su imperfecto compite con su perfecto: Ik was daar (estaba o estuve alli, describiendo) frente a Ik ben daar geweest (he estado alli, contandolo).
• expresion hecha — Ben je er weleens geweest? (¿has estado alguna vez?), que es justo la pregunta de esta frase.

🏋️ Ejercicio: «llegué hace diez minutos» → Ik ben tien minuten ___ aangekomen. (Respuesta: geleden.)

🧭 El cuadro de tiempos es → nl:

El fallo no es conjugar mal: es elegir el tiempo que pide el español en vez del que pide el neerlandes. Este es el mapa.

| lo que dices en español | lo que va en neerlandes | ejemplo |
|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | **Morgen ga ik** naar de dokter. |

📌 Regla de bolsillo:
• ¿Sigue pasando ahora mismo? → presente, y casi siempre con al.
• ¿Lo que dices es que NO ha vuelto a pasar? → perfectum, con niet o niet meer.
• ¿Es un hecho suelto del pasado, contado en conversacion? → perfectum.
• ¿Es el decorado, la costumbre o un verbo modal? → imperfectum.
• ¿Hay un toen delante? → imperfectum, sin excepcion.

🔑 El truco que casi nunca falla: Reescribe la frase española con «he/ha + participio». Si suena bien, en neerlandes va perfectum aunque tu la digas en presente — «no lo veo desde el verano» = «no lo he visto desde el verano» → Ik heb hem niet gezien. Si no cabe ese «he» y lo que describes es el decorado del pasado, va imperfectum.

⚠️ Los auxiliares y los modales van por libre: zijn, hebben, kunnen, moeten, willen y zullen prefieren el imperfectum incluso hablando — was, had, kon, moest, wilde, zou. Donde el español dice he podido, el neerlandes dice ik kon.

🪜 El eje que lo ordena todo: Sigue pasando hoy → presente · ya paso pero su resultado cuenta ahora, o no ha vuelto a pasar → perfectum · esta cerrado y lo estas narrando o describiendo → imperfectum · ya estaba hecho antes de otra cosa pasada → had o was + participio.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Tiempos: twee jaar geleden');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'de pequeños siempre íbamos a la playa', 'PHRASE', 'Tiempos: vroeger strand',
'Vroeger gingen we altijd naar het strand = de pequeños siempre íbamos a la playa. La COSTUMBRE del pasado va en imperfectum, nunca en perfecto: es el caso contrario al de «ayer comí».

🔑 El truco: Si la frase lleva siempre, nunca, todos los años, cada verano o de pequeño, es costumbre → imperfectum. Si es un hecho que paso una vez → perfectum.

📐 La palabra que abre estas frases: Es vroeger, que significa antes, en otros tiempos, y al ocupar el primer lugar obliga a la inversion — gingen we, no «we gingen».

📋 Las costumbres, todas en imperfecto:
• Vroeger gingen we altijd naar het strand. — Antes siempre íbamos a la playa.
• Als kind speelde ik elke dag buiten. — De niño jugaba fuera todos los días.
• Mijn opa rookte nooit. — Mi abuelo no fumaba nunca.

📐 Stamtijden de gaan (fuerte):

| infinitief | imperfectum | voltooid deelwoord |
|---|---|---|
| gaan | ging / gingen | gegaan (zijn) |

• preposicion — gaan NAAR el destino (naar het strand, naar school, naar huis sin articulo).
• el plural del imperfecto añade -en: ging → gingen, y es la forma que sale con we, jullie y ze.
• auxiliar zijn, porque gaan es movimiento con destino: Hij is naar huis gegaan.

⚠️ El neerlandes no tiene un soler: la costumbre la marcan vroeger, altijd, meestal y vaak. «Ik gebruikte te gaan» no existe.

🏋️ Ejercicio: «antes fumaba mucho» → Vroeger ___ ik veel. (Respuesta: rookte.)

🧭 El cuadro de tiempos es → nl:

El fallo no es conjugar mal: es elegir el tiempo que pide el español en vez del que pide el neerlandes. Este es el mapa.

| lo que dices en español | lo que va en neerlandes | ejemplo |
|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | **Morgen ga ik** naar de dokter. |

📌 Regla de bolsillo:
• ¿Sigue pasando ahora mismo? → presente, y casi siempre con al.
• ¿Lo que dices es que NO ha vuelto a pasar? → perfectum, con niet o niet meer.
• ¿Es un hecho suelto del pasado, contado en conversacion? → perfectum.
• ¿Es el decorado, la costumbre o un verbo modal? → imperfectum.
• ¿Hay un toen delante? → imperfectum, sin excepcion.

🔑 El truco que casi nunca falla: Reescribe la frase española con «he/ha + participio». Si suena bien, en neerlandes va perfectum aunque tu la digas en presente — «no lo veo desde el verano» = «no lo he visto desde el verano» → Ik heb hem niet gezien. Si no cabe ese «he» y lo que describes es el decorado del pasado, va imperfectum.

⚠️ Los auxiliares y los modales van por libre: zijn, hebben, kunnen, moeten, willen y zullen prefieren el imperfectum incluso hablando — was, had, kon, moest, wilde, zou. Donde el español dice he podido, el neerlandes dice ik kon.

🪜 El eje que lo ordena todo: Sigue pasando hoy → presente · ya paso pero su resultado cuenta ahora, o no ha vuelto a pasar → perfectum · esta cerrado y lo estas narrando o describiendo → imperfectum · ya estaba hecho antes de otra cosa pasada → had o was + participio.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Tiempos: vroeger strand');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no te había visto', 'PHRASE', 'Tiempos: had niet gezien',
'Ik had je niet gezien = no te había visto. El pluscuamperfecto español tiene calco exacto: la voltooid verleden tijd, que es el perfecto con el auxiliar en IMPERFECTO.

📐 La formula: Es had o was + participio. El auxiliar es el mismo que usaria el perfecto, pero en pasado — heb gezien → had gezien; ben gegaan → was gegaan.

📋 Los dos auxiliares en accion:
• Ik had je niet gezien. — No te había visto.
• Ze was al vertrokken toen ik aankwam. — Ya se había ido cuando llegué.
• We hadden het huis al verkocht. — Ya habíamos vendido la casa.

🔑 Cuando toca: Para lo que ya estaba hecho ANTES de otra cosa del pasado. Si solo hay un momento pasado no hace falta, con el imperfecto basta.

📐 Los cuatro tiempos con el mismo verbo, para verlo de un vistazo:

| tiempo | forma | español |
|---|---|---|
| presente | ik **zie** je | te veo |
| imperfectum | ik **zag** je | te veía, te vi |
| perfectum | ik **heb** je **gezien** | te he visto |
| voltooid verleden | ik **had** je **gezien** | te había visto |

⚠️ Y las que se usan a diario sin pensar que son este tiempo: Dat had ik niet verwacht (no me lo esperaba), Dat had je niet hoeven doen (no hacia falta que lo hicieras), Ik had het kunnen weten (me lo podia haber imaginado).

🏋️ Ejercicio: «ya se había ido» → Hij ___ al ___. (Respuesta: was … vertrokken.)

🧭 El cuadro de tiempos es → nl:

El fallo no es conjugar mal: es elegir el tiempo que pide el español en vez del que pide el neerlandes. Este es el mapa.

| lo que dices en español | lo que va en neerlandes | ejemplo |
|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | **Morgen ga ik** naar de dokter. |

📌 Regla de bolsillo:
• ¿Sigue pasando ahora mismo? → presente, y casi siempre con al.
• ¿Lo que dices es que NO ha vuelto a pasar? → perfectum, con niet o niet meer.
• ¿Es un hecho suelto del pasado, contado en conversacion? → perfectum.
• ¿Es el decorado, la costumbre o un verbo modal? → imperfectum.
• ¿Hay un toen delante? → imperfectum, sin excepcion.

🔑 El truco que casi nunca falla: Reescribe la frase española con «he/ha + participio». Si suena bien, en neerlandes va perfectum aunque tu la digas en presente — «no lo veo desde el verano» = «no lo he visto desde el verano» → Ik heb hem niet gezien. Si no cabe ese «he» y lo que describes es el decorado del pasado, va imperfectum.

⚠️ Los auxiliares y los modales van por libre: zijn, hebben, kunnen, moeten, willen y zullen prefieren el imperfectum incluso hablando — was, had, kon, moest, wilde, zou. Donde el español dice he podido, el neerlandes dice ik kon.

🪜 El eje que lo ordena todo: Sigue pasando hoy → presente · ya paso pero su resultado cuenta ahora, o no ha vuelto a pasar → perfectum · esta cerrado y lo estas narrando o describiendo → imperfectum · ya estaba hecho antes de otra cosa pasada → had o was + participio.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Tiempos: had niet gezien');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿cuánto tiempo llevas esperando?', 'PHRASE', 'Tiempos: hoe lang wacht je al',
'Hoe lang wacht je al? = ¿cuánto tiempo llevas esperando? Aqui el presente español SI es presente en neerlandes, porque la accion sigue pasando ahora mismo, y al es quien dice que viene de antes.

🔑 El contraste que hay que fijar, que es el corazon de este grupo: Si sigue pasando → presente con al (Hoe lang wacht je al?). Si lo que dices es que NO pasa → perfecto (Ik heb hem lang niet gezien). Mismo español, dos tiempos distintos, y lo que decide es la negacion.

⚠️ El llevar + gerundio del español no tiene verbo propio en neerlandes: se pone el verbo en presente y se añade al con la duracion.

📋 El molde, en pregunta y en respuesta:
• Hoe lang wacht je al? — ¿Cuánto tiempo llevas esperando?
• Ik wacht al een half uur. — Llevo esperando media hora.
• Hoe lang woon je hier al? — ¿Cuánto tiempo llevas viviendo aquí?
• Ik leer al twee jaar Nederlands. — Llevo dos años aprendiendo neerlandés.

📐 Donde va al: Pegado a la expresion de tiempo, detras del verbo y de los pronombres (Ik wacht al een half uur). En la pregunta se queda al final: Hoe lang wacht je al?

📐 Stamtijden de wachten (debil):

| infinitief | imperfectum | voltooid deelwoord |
|---|---|---|
| wachten | wachtte / wachtten | gewacht (hebben) |

• preposicion — wachten OP (esperar a): Ik wacht op de bus, Ik wacht op je.
• la raiz acaba en -t, asi que el imperfecto dobla la t (wachtte) y el participio no añade ninguna (gewacht, nunca «gewachtd»).
• sustantivo derivado — de wachtkamer (la sala de espera), de wachttijd (el tiempo de espera).

🏋️ Ejercicio: «llevo una hora aquí» → Ik ben hier ___ een uur. (Respuesta: al.)

🧭 El cuadro de tiempos es → nl:

El fallo no es conjugar mal: es elegir el tiempo que pide el español en vez del que pide el neerlandes. Este es el mapa.

| lo que dices en español | lo que va en neerlandes | ejemplo |
|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | **Morgen ga ik** naar de dokter. |

📌 Regla de bolsillo:
• ¿Sigue pasando ahora mismo? → presente, y casi siempre con al.
• ¿Lo que dices es que NO ha vuelto a pasar? → perfectum, con niet o niet meer.
• ¿Es un hecho suelto del pasado, contado en conversacion? → perfectum.
• ¿Es el decorado, la costumbre o un verbo modal? → imperfectum.
• ¿Hay un toen delante? → imperfectum, sin excepcion.

🔑 El truco que casi nunca falla: Reescribe la frase española con «he/ha + participio». Si suena bien, en neerlandes va perfectum aunque tu la digas en presente — «no lo veo desde el verano» = «no lo he visto desde el verano» → Ik heb hem niet gezien. Si no cabe ese «he» y lo que describes es el decorado del pasado, va imperfectum.

⚠️ Los auxiliares y los modales van por libre: zijn, hebben, kunnen, moeten, willen y zullen prefieren el imperfectum incluso hablando — was, had, kon, moest, wilde, zou. Donde el español dice he podido, el neerlandes dice ik kon.

🪜 El eje que lo ordena todo: Sigue pasando hoy → presente · ya paso pero su resultado cuenta ahora, o no ha vuelto a pasar → perfectum · esta cerrado y lo estas narrando o describiendo → imperfectum · ya estaba hecho antes de otra cosa pasada → had o was + participio.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Tiempos: hoe lang wacht je al');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'desde que vivo aquí como mejor', 'PHRASE', 'Tiempos: sinds ik hier woon',
'Sinds ik hier woon, eet ik beter = desde que vivo aquí como mejor. Cuando sinds no lleva negacion y la cosa SIGUE pasando, los dos verbos van en presente, igual que en español.

📐 Las dos vidas de sinds: Con sustantivo es preposicion (sinds de zomer, sinds 2020) y con frase entera es conjuncion, y entonces manda el orden de subordinada, con el verbo al final — Sinds ik hier woon.

📐 Y al abrir con la subordinada, la principal invierte: El verbo se pone delante del sujeto — eet ik beter y no «ik eet beter», porque el primer lugar ya esta ocupado.

📋 Los tres casos del mismo sinds:
• Sinds ik hier woon, eet ik beter. — Desde que vivo aquí como mejor. (sigue: presente)
• Sinds de zomer heb ik hem niet gezien. — Desde el verano no lo veo. (negado: perfecto)
• Sindsdien is alles veranderd. — Desde entonces todo ha cambiado. (cambio ya ocurrido: perfecto)

🔑 La regla en una linea: Con sinds afirmativo y la cosa en marcha → presente; con negacion o con un cambio ya consumado → perfecto.

⚠️ Y no lo cambies por vanaf, que mira al futuro: Vanaf morgen eet ik beter (a partir de mañana) frente a Sinds ik hier woon (desde que vivo aqui).

🏋️ Ejercicio: «desde que trabaja aquí está más contento» → ___ hij hier werkt, is hij blijer. (Respuesta: Sinds.)

🧭 El cuadro de tiempos es → nl:

El fallo no es conjugar mal: es elegir el tiempo que pide el español en vez del que pide el neerlandes. Este es el mapa.

| lo que dices en español | lo que va en neerlandes | ejemplo |
|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | **Morgen ga ik** naar de dokter. |

📌 Regla de bolsillo:
• ¿Sigue pasando ahora mismo? → presente, y casi siempre con al.
• ¿Lo que dices es que NO ha vuelto a pasar? → perfectum, con niet o niet meer.
• ¿Es un hecho suelto del pasado, contado en conversacion? → perfectum.
• ¿Es el decorado, la costumbre o un verbo modal? → imperfectum.
• ¿Hay un toen delante? → imperfectum, sin excepcion.

🔑 El truco que casi nunca falla: Reescribe la frase española con «he/ha + participio». Si suena bien, en neerlandes va perfectum aunque tu la digas en presente — «no lo veo desde el verano» = «no lo he visto desde el verano» → Ik heb hem niet gezien. Si no cabe ese «he» y lo que describes es el decorado del pasado, va imperfectum.

⚠️ Los auxiliares y los modales van por libre: zijn, hebben, kunnen, moeten, willen y zullen prefieren el imperfectum incluso hablando — was, had, kon, moest, wilde, zou. Donde el español dice he podido, el neerlandes dice ik kon.

🪜 El eje que lo ordena todo: Sigue pasando hoy → presente · ya paso pero su resultado cuenta ahora, o no ha vuelto a pasar → perfectum · esta cerrado y lo estas narrando o describiendo → imperfectum · ya estaba hecho antes de otra cosa pasada → had o was + participio.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Tiempos: sinds ik hier woon');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'mañana voy al médico', 'PHRASE', 'Tiempos: morgen naar de dokter',
'Morgen ga ik naar de dokter = mañana voy al médico. Para el futuro con fecha el neerlandes usa el PRESENTE, igual que el español, y meter zullen ahi suena raro.

🔑 El truco: Si en la frase hay una marca de tiempo futuro (morgen, straks, volgende week, om acht uur), el presente basta y sobra. zullen queda para la promesa, la propuesta y la prediccion.

📋 Los tres futuros y cuando se usa cada uno:
• Morgen ga ik naar de dokter. — Mañana voy al médico. (plan con fecha: presente)
• Ik zal het doen. — Lo haré. (promesa: zullen)
• Ik ga het morgen doen. — Lo voy a hacer mañana. (intencion: gaan + infinitivo)

📐 La inversion otra vez: Morgen abre la frase, asi que ga ik. Tambien vale Ik ga morgen naar de dokter — lo que cambia es el foco, que se lo lleva lo que va primero.

⚠️ Ojo al gaan doble: Ik ga naar de dokter ya es ir, asi que no existe «ik ga gaan». El gaan + infinitivo es para otros verbos: ik ga koken, ik ga slapen.

📐 Stamtijden de gaan (fuerte):

| infinitief | imperfectum | voltooid deelwoord |
|---|---|---|
| gaan | ging / gingen | gegaan (zijn) |

• preposicion — gaan NAAR el destino (naar de dokter, naar huis sin articulo, naar school).
• expresion hecha — Hoe gaat het? (¿qué tal?) y Dat gaat niet (eso no puede ser).

🏋️ Ejercicio: «la semana que viene empiezo a trabajar» → Volgende week ___ ik. (Respuesta: begin.)

🧭 El cuadro de tiempos es → nl:

El fallo no es conjugar mal: es elegir el tiempo que pide el español en vez del que pide el neerlandes. Este es el mapa.

| lo que dices en español | lo que va en neerlandes | ejemplo |
|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | **Morgen ga ik** naar de dokter. |

📌 Regla de bolsillo:
• ¿Sigue pasando ahora mismo? → presente, y casi siempre con al.
• ¿Lo que dices es que NO ha vuelto a pasar? → perfectum, con niet o niet meer.
• ¿Es un hecho suelto del pasado, contado en conversacion? → perfectum.
• ¿Es el decorado, la costumbre o un verbo modal? → imperfectum.
• ¿Hay un toen delante? → imperfectum, sin excepcion.

🔑 El truco que casi nunca falla: Reescribe la frase española con «he/ha + participio». Si suena bien, en neerlandes va perfectum aunque tu la digas en presente — «no lo veo desde el verano» = «no lo he visto desde el verano» → Ik heb hem niet gezien. Si no cabe ese «he» y lo que describes es el decorado del pasado, va imperfectum.

⚠️ Los auxiliares y los modales van por libre: zijn, hebben, kunnen, moeten, willen y zullen prefieren el imperfectum incluso hablando — was, had, kon, moest, wilde, zou. Donde el español dice he podido, el neerlandes dice ik kon.

🪜 El eje que lo ordena todo: Sigue pasando hoy → presente · ya paso pero su resultado cuenta ahora, o no ha vuelto a pasar → perfectum · esta cerrado y lo estas narrando o describiendo → imperfectum · ya estaba hecho antes de otra cosa pasada → had o was + participio.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Tiempos: morgen naar de dokter');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estaba en la ducha cuando llamaste', 'PHRASE', 'Tiempos: douche toen belde',
'Ik stond onder de douche toen je belde = estaba en la ducha cuando llamaste. Las dos mitades van en imperfectum: el decorado que ya estaba pasando y el toen que lo corta.

🔑 La regla de toen, que no falla nunca: Detras de toen va SIEMPRE imperfectum. Si ves un perfecto ahi, el error esta ahi.

📐 El orden con toen: Es subordinante, asi que su verbo se va AL FINAL — toen je belde, nunca «toen belde je». Y tiene otra vida de adverbio al principio de frase: Toen ging de telefoon (entonces sonó el teléfono).

⚠️ Los tres cuando del español se reparten asi:
• pasado, una sola vez → toen: Toen je belde.
• presente o futuro, o algo repetido → als: Als je belt, neem ik op.
• pregunta → wanneer: Wanneer bel je?

📋 El decorado y el corte, los dos en imperfecto:
• Ik stond onder de douche toen je belde. — Estaba en la ducha cuando llamaste.
• We aten net toen hij binnenkwam. — Estábamos comiendo justo cuando entró.
• Het regende toen we vertrokken. — Llovía cuando salimos.

📐 Y fijate en stond: Donde el español dice estar, el neerlandes coloca el cuerpo con un verbo de postura — staan de pie, zitten sentado, liggen tumbado. Bajo la ducha se esta de pie, asi que onder de douche staan.

🏋️ Ejercicio: «dormía cuando llegaste» → Ik ___ toen je ___. (Respuesta: sliep … aankwam.)

🧭 El cuadro de tiempos es → nl:

El fallo no es conjugar mal: es elegir el tiempo que pide el español en vez del que pide el neerlandes. Este es el mapa.

| lo que dices en español | lo que va en neerlandes | ejemplo |
|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | **Morgen ga ik** naar de dokter. |

📌 Regla de bolsillo:
• ¿Sigue pasando ahora mismo? → presente, y casi siempre con al.
• ¿Lo que dices es que NO ha vuelto a pasar? → perfectum, con niet o niet meer.
• ¿Es un hecho suelto del pasado, contado en conversacion? → perfectum.
• ¿Es el decorado, la costumbre o un verbo modal? → imperfectum.
• ¿Hay un toen delante? → imperfectum, sin excepcion.

🔑 El truco que casi nunca falla: Reescribe la frase española con «he/ha + participio». Si suena bien, en neerlandes va perfectum aunque tu la digas en presente — «no lo veo desde el verano» = «no lo he visto desde el verano» → Ik heb hem niet gezien. Si no cabe ese «he» y lo que describes es el decorado del pasado, va imperfectum.

⚠️ Los auxiliares y los modales van por libre: zijn, hebben, kunnen, moeten, willen y zullen prefieren el imperfectum incluso hablando — was, had, kon, moest, wilde, zou. Donde el español dice he podido, el neerlandes dice ik kon.

🪜 El eje que lo ordena todo: Sigue pasando hoy → presente · ya paso pero su resultado cuenta ahora, o no ha vuelto a pasar → perfectum · esta cerrado y lo estas narrando o describiendo → imperfectum · ya estaba hecho antes de otra cosa pasada → had o was + participio.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Tiempos: douche toen belde');

-- =============================================================================
-- 3. Traducciones
-- =============================================================================
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
SELECT we.id, 'nl_NL', v.nl, v.pron
FROM (
    SELECT 'Tiempos: lang niet gezien' AS k, 'Ik heb je lang niet gezien.' AS nl, 'ik hep ye lang nit jesin' AS pron
    UNION ALL SELECT 'Tiempos: net gegeten', 'Ik heb net gegeten.', 'ik hep net jejeeten'
    UNION ALL SELECT 'Tiempos: naam vergeten', 'Ik ben zijn naam vergeten.', 'ik ben zain naam ferjeeten'
    UNION ALL SELECT 'Tiempos: twee weken niet gebeld', 'Ze heeft me al twee weken niet gebeld.', 'ze heeft me al tuee veeken nit jebelt'
    UNION ALL SELECT 'Tiempos: gisteren gegeten', 'Gisteren heb ik met mijn zus gegeten.', 'jísteren hep ik met main zus jejeeten'
    UNION ALL SELECT 'Tiempos: twee jaar geleden', 'Ik ben daar twee jaar geleden geweest.', 'ik ben daar tuee yaar jeleeden jeveest'
    UNION ALL SELECT 'Tiempos: vroeger strand', 'Vroeger gingen we altijd naar het strand.', 'frúujer jíngen ve áltait naar het strant'
    UNION ALL SELECT 'Tiempos: had niet gezien', 'Ik had je niet gezien.', 'ik hat ye nit jesin'
    UNION ALL SELECT 'Tiempos: hoe lang wacht je al', 'Hoe lang wacht je al?', 'hu lang vajt ye al'
    UNION ALL SELECT 'Tiempos: sinds ik hier woon', 'Sinds ik hier woon, eet ik beter.', 'sints ik hiir voon, eet ik beeter'
    UNION ALL SELECT 'Tiempos: morgen naar de dokter', 'Morgen ga ik naar de dokter.', 'mórjen ja ik naar de dokter'
    UNION ALL SELECT 'Tiempos: douche toen belde', 'Ik stond onder de douche toen je belde.', 'ik stont ónder de dusj tun ye belde'
) v
JOIN words_es we ON we.notes = v.k;

-- =============================================================================
-- 4. Al grupo nuevo y a generic
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Tiempos: %' AND g.title = 'tiempos es-nl - presente, perfectum o imperfectum';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Tiempos: %' AND g.title = 'generic';

-- =============================================================================
-- 5. Las 10 que ya existian y son de esta familia
--    1101: no lo veo desde el verano — el caso que abrio el grupo
--    1102: llevo cinco años viviendo aquí — presente con al
--    261: nunca he estado allí — nog nooit + perfecto
--    521: cuando era joven vivía en Sevilla — toen + imperfectum
--    438: antes vivía allí — vroeger + imperfectum
--    659: acabamos de llegar — net + perfecto con zijn
--    927: eso nunca lo he querido — modal solo, participio
--    930: no he podido dormir — modal + infinitivo, doble infinitivo
--    932: no podía encontrarlo — el imperfecto del modal, que es lo normal
--    935: ayer tuve que trabajar — moest, no «heb moeten»
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE g.title = 'tiempos es-nl - presente, perfectum o imperfectum' AND we.id IN (1101, 1102, 261, 521, 438, 659, 927, 930, 932, 935);

-- =============================================================================
-- 6. El bloque compartido en las 10 que ya existian (§3.3)
--    Guard doble: idempotente por la marca y protegido del NULL || texto (§5.4)
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧭 El cuadro de tiempos es → nl:

El fallo no es conjugar mal: es elegir el tiempo que pide el español en vez del que pide el neerlandes. Este es el mapa.

| lo que dices en español | lo que va en neerlandes | ejemplo |
|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | **Morgen ga ik** naar de dokter. |

📌 Regla de bolsillo:
• ¿Sigue pasando ahora mismo? → presente, y casi siempre con al.
• ¿Lo que dices es que NO ha vuelto a pasar? → perfectum, con niet o niet meer.
• ¿Es un hecho suelto del pasado, contado en conversacion? → perfectum.
• ¿Es el decorado, la costumbre o un verbo modal? → imperfectum.
• ¿Hay un toen delante? → imperfectum, sin excepcion.

🔑 El truco que casi nunca falla: Reescribe la frase española con «he/ha + participio». Si suena bien, en neerlandes va perfectum aunque tu la digas en presente — «no lo veo desde el verano» = «no lo he visto desde el verano» → Ik heb hem niet gezien. Si no cabe ese «he» y lo que describes es el decorado del pasado, va imperfectum.

⚠️ Los auxiliares y los modales van por libre: zijn, hebben, kunnen, moeten, willen y zullen prefieren el imperfectum incluso hablando — was, had, kon, moest, wilde, zou. Donde el español dice he podido, el neerlandes dice ik kon.

🪜 El eje que lo ordena todo: Sigue pasando hoy → presente · ya paso pero su resultado cuenta ahora, o no ha vuelto a pasar → perfectum · esta cerrado y lo estas narrando o describiendo → imperfectum · ya estaba hecho antes de otra cosa pasada → had o was + participio.',
    updated_at = datetime('now')
WHERE id IN (1101, 1102, 261, 521, 438, 659, 927, 930, 932, 935)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%El cuadro de tiempos es%';
