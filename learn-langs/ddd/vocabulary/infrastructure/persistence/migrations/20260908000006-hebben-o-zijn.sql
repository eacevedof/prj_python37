-- Learn Languages App - Migration
-- Migration: 20260908000006-hebben-o-zijn
-- Description: Eduardo, sobre la 1046 (Ik heb slecht geslapen = he dormido mal): "pq es Ik
--   heb slecht geslapen y no Ik ben slecht geslapen? si he cambiado de estado antes estaba
--   dormido y ahora estoy despierto, aparte no hay articulo directo".
--
--   Hay que desmontar las DOS premisas, y las dos son razonables pero falsas:
--
--   (1) El cambio de estado no lo expresa slapen. slapen es un ESTADO QUE DURA, no una
--   transicion: es lo que haces durante la noche entera. El cambio lo marcan otros verbos,
--   y esos SI van con zijn — in slaap vallen (dormirse, Ik ben in slaap gevallen) y wakker
--   worden (despertarse, Ik ben wakker geworden). El mazo ya tiene las dos caras sin
--   señalarlo: la 618 (Heeft u goed geslapen?) con hebben y la 690 (Ik werd vroeg wakker)
--   con worden.
--
--   (2) Lo del objeto directo es una regla del FRANCES, el italiano y el aleman, no del
--   neerlandes. Aqui hay montones de intransitivos con hebben: Ik heb gewerkt, gelachen,
--   gewacht, gestaan, gefietst. Y el mazo tiene la prueba en dos tarjetas seguidas: la 627
--   (Ik heb twee uur gefietst, sin destino, hebben) y la 626 (Ik ben naar school gefietst,
--   con destino, zijn). Mismo verbo, ningun objeto directo en ninguna de las dos, y
--   auxiliar distinto. Luego no decide la transitividad: decide si hay destino o
--   transicion.
--
--   Se escribe el bloque "⚓ hebben o zijn en el perfecto" con los tres unicos casos de
--   zijn y el par gefietst como demostracion, y se inyecta en las tarjetas de verbo del
--   grupo 40 (que ya declaraban su auxiliar sin explicar por que) y en el grupo 18, que es
--   el del perfecto. La 1046 se lleva ademas la respuesta concreta.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. La 1046: la duda concreta
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: ¿Por que Ik HEB geslapen y no Ik BEN geslapen, si he cambiado de estado y ademas no hay objeto directo?

🔑 La regla real: Las dos razones son sensatas, pero ninguna de las dos es la del neerlandes.

⚠️ Lo del cambio de estado: Slapen NO es un cambio de estado, es un estado que DURA. Dormir es lo que haces durante toda la noche, no el momento en que te duermes.

El cambio si lo marcan otros verbos, y esos van con zijn:

| verbo | que es | auxiliar | ejemplo |
|---|---|---|---|
| **slapen** | el estado, la actividad de la noche | **hebben** | Ik **heb** geslapen. |
| **in slaap vallen** | dormirse, entrar en el estado | **zijn** | Ik **ben** in slaap gevallen. |
| **wakker worden** | despertarse, salir del estado | **zijn** | Ik **ben** wakker geworden. |

🪞 Y las dos caras ya estaban en tu mazo: la 618 (Heeft u goed geslapen?) va con hebben, y la 690 (Ik werd vroeg wakker) usa worden, que es el verbo del cambio de verdad.

⚠️ Y lo del objeto directo: esa es la regla del FRANCES, del italiano y del aleman, no del neerlandes. Aqui hay muchisimos verbos sin objeto directo que van con hebben: Ik heb gewerkt, Ik heb gelachen, Ik heb gewacht, Ik heb gestaan, Ik heb gefietst.

🪞 La prueba esta en dos tarjetas seguidas de tu mazo, con el MISMO verbo y sin objeto directo en ninguna:
• 627 — Ik heb twee uur gefietst. (he montado en bici dos horas) → hebben
• 626 — Ik ben naar school gefietst. (he ido en bici al cole) → zijn
Lo unico que cambia es que la segunda tiene DESTINO. Luego no decide la transitividad: decide si hay un punto de llegada o una transicion.

🏋️ Ejercicio: «he corrido una hora» y «he ido corriendo a casa» → Ik ___ een uur gelopen. Ik ___ naar huis gelopen. (Respuestas: heb · ben.)'
WHERE id = 1046
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';

-- =============================================================================
-- 1b. La 1066: el "me" de "me he comprado" no se traduce
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: ¿Por que no Ik heb me een nieuwe fiets gekocht?

🔑 La razon: Ese me no existe en neerlandes. El me de «me he comprado» es un dativo de interes, o sea que no es objeto ni reflexivo de verdad, solo marca que el asunto te toca a ti. El español lo usa constantemente y el neerlandes no lo tiene, asi que simplemente no se traduce. Ik heb een nieuwe fiets gekocht vale a la vez para he comprado una bici y para me he comprado una bici.

🇩🇪 De donde viene la intuicion: en ALEMAN si existe, Ich habe mir ein Fahrrad gekauft. El neerlandes se parece mucho al aleman pero justo aqui no le sigue.

🎭 Las tres construcciones que se confunden, y solo una lleva pronombre obligatorio:

| tipo | ¿lleva pronombre? | ejemplo |
|---|---|---|
| **reflexivo de verdad**, el verbo lo exige | **si, obligatorio** | Ik vergis **me**. Ik haast **me**. |
| **dativo de interes español** | **no se traduce** | Ik heb een fiets gekocht. |
| **reflexivo enfatico**, a mi mismo | si, con -zelf | Ik heb **mezelf** een cadeau gekocht. |

🔑 El truco que lo resuelve: Quita el pronombre en español. Si la frase sigue significando lo mismo, en neerlandes no se pone. «He comprado una bici» = «me he comprado una bici», luego fuera el me. En cambio «equivoco» no es «me equivoco», asi que ahi si es reflexivo de verdad y el pronombre es obligatorio: Ik vergis me.

📋 Mas casos del dativo que NO se traduce:
• Me he comido una pizza. — Ik heb een pizza gegeten.
• Se ha leido el libro entero. — Hij heeft het hele boek gelezen.
• Me voy a tomar un cafe. — Ik ga koffie drinken.
• Se lo sabe todo. — Hij weet alles.

💬 Y si de verdad quieres marcar que fue PARA TI y no para otro, ahi entra mezelf: Ik heb mezelf een cadeau gekocht (me he comprado un regalo a mi mismo). Las formas son mezelf, jezelf, zichzelf, uzelf, onszelf. Los verbos reflexivos de verdad estan en el grupo 17 del mazo.

🏋️ Ejercicio: «me he comprado un abrigo» → Ik heb ___ jas gekocht. (Respuesta: een. Sin ningun pronombre.)'
WHERE id = 1066
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';

-- =============================================================================
-- 2. Bloque compartido: hebben o zijn
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

⚓ hebben o zijn en el perfecto:

Casi todos los verbos van con hebben. zijn se reserva para TRES casos, y fuera de ellos no aparece.

| caso | ejemplo |
|---|---|
| movimiento **con destino** | Ik **ben** naar huis gegaan. Hij **is** naar school gefietst. |
| **cambio de estado** | Ik **ben** ziek geworden. De vaas **is** gevallen. |
| lista cerrada de irregulares | **zijn** (geweest), blijven, gebeuren, beginnen, stoppen, sterven, lukken, slagen |

🔑 El truco que casi nunca falla: Pregunta si la frase señala un punto de llegada o una transicion terminada. Si solo describe una actividad que ocurrio, hebben. Si algo llego a algun sitio o paso a ser otra cosa, zijn.

⚠️ NO decide si hay objeto directo. Esa es la regla del frances, del italiano y del aleman, y en neerlandes falla: Ik heb gewerkt, gelachen, gewacht, gestaan y gefietst son todos intransitivos y todos con hebben.

🪞 La demostracion, con el mismo verbo y sin objeto directo en ninguna de las dos:
• Ik heb twee uur gefietst. — He montado en bici dos horas. Actividad, sin destino → hebben.
• Ik ben naar school gefietst. — He ido en bici al cole. Con destino → zijn.
Pasa igual con lopen, rijden, zwemmen, vliegen y wandelen: la misma frase cambia de auxiliar en cuanto aparece un naar.

📐 Y ojo a los ESTADOS, que engañan porque parecen cambios: slapen (dormir), staan (estar de pie), liggen (estar tumbado) y zitten (estar sentado) describen situaciones que duran, no transiciones, asi que van con hebben. Ik heb geslapen, We hebben uren in de file gestaan. Los cambios correspondientes son otros verbos y esos si llevan zijn: in slaap vallen, gaan staan, gaan liggen, gaan zitten.'
WHERE (
    notes LIKE 'Verbo frecuente: %'
    OR id IN (SELECT word_es_id FROM word_es_groups WHERE group_id = 18)
)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%⚓ hebben o zijn en el perfecto%';
