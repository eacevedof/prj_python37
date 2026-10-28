-- Learn Languages App - «Altijd verwissel ik hun namen» y los adverbios de frecuencia (duda 867)
-- Migration: 20260831000021-help-frecuencia-y-door-elkaar-halen.sql
-- Description: Eduardo en la 867 (Ik verwissel steeds hun namen): «¿no puede ser Altijd verwissel
--   ik hun namen?». SI puede, y es correcta: altijd ocupa la casilla 1, el verbo se queda en la 2a
--   y el sujeto pasa detras. Lo que cambia no es la gramatica sino el foco — adelantarlo subraya
--   la frecuencia y suena a queja, como el «es que SIEMPRE» del espanol. Se responde en la 867,
--   que estaba SIN rules_help y se crea entera, con lo que la respuesta literal no cubria:
--   (1) altijd (siempre, sin excepcion) no es steeds (una y otra vez, recurrente), y steeds tiene
--   ademas otras dos vidas — nog steeds (todavia) y steeds + comparativo (steeds meer);
--   (2) la palabra que usaria de verdad un neerlandes para confundir NOMBRES o PERSONAS es
--   «door elkaar halen», separable, que no estaba en el mazo: verwisselen apunta al intercambio
--   material (llaves, neumaticos, etiquetas) y door elkaar halen a la confusion mental; con su
--   antonimo «uit elkaar houden» (distinguir), el formal verwarren met y la familia de la war;
--   (3) hun namen es correcto (posesivo), pero hay que separar el trio hun / hen / ze y avisar del
--   error famoso de «hun» como sujeto.
--   Y un bloque 🕒 IDENTICO byte a byte en 298, 380, 381, 437 y 867 con lo que la duda pone sobre
--   la mesa para todo el mazo: donde va el adverbio de frecuencia (campo medio por defecto, antes
--   del bloque verbal final, delante o detras del objeto segun el acento, en la casilla 1 con
--   inversion y enfasis, y delante de los verbos en subordinada) y la escalera completa de
--   altijd a nooit. Las 380 y 437 solo tenian la linea de la formula.
--   100% aditiva e idempotente: UPDATE con guard por marca y por rules_help IS NULL.

-- ==============================================================================
-- 1. Tarjeta 867: no tenia ayuda, se crea con la respuesta a la duda
-- ==============================================================================
UPDATE words_es
SET rules_help = 'Si, «Altijd verwissel ik hun namen» es correcta. altijd ocupa la casilla 1, el verbo conjugado se queda en la 2a (verwissel) y el sujeto pasa detras (ik): es la inversion de siempre, y la frase es impecable.

📌 Lo que cambia es el FOCO, no la gramatica. En el campo medio (Ik verwissel altijd hun namen) la frase es neutra: informa. Adelantando el adverbio (Altijd verwissel ik hun namen) lo subrayas, y en neerlandes eso suena a queja o resignacion, igual que el espanol «es que SIEMPRE me lio con sus nombres». Las dos son correctas; solo tienes que saber cual estas diciendo.

⚠️ Pero ojo con la palabra, porque la tarjeta usa steeds y no altijd, y no significan lo mismo: altijd es SIEMPRE, sin excepcion, y steeds es UNA Y OTRA VEZ, una repeticion que molesta. Con altijd afirmas una constante; con steeds te quejas de que vuelve a pasar. En esta frase las dos encajan.

🔁 Y steeds tiene otras dos vidas que conviene no mezclar:
• nog steeds = todavia, sigue siendo asi. Woont u nog steeds in Madrid? — ¿Sigue viviendo en Madrid?
• steeds + comparativo = cada vez mas / cada vez menos. Het wordt steeds moeilijker. — Cada vez es mas dificil. Hij valt steeds meer af. — Cada vez adelgaza mas.
• steeds weer = una y otra vez, con enfasis. Hij maakt steeds weer dezelfde fout.

🧠 La palabra que usaria un neerlandes aqui: door elkaar halen. Es LA expresion para confundir dos cosas o dos personas en la cabeza, y es justo lo que pasa con unos nombres:
• Ik haal hun namen altijd door elkaar. — Siempre confundo sus nombres. (la version mas natural de esta tarjeta)
• Sorry, ik haal jullie steeds door elkaar. — Perdona, os confundo todo el rato.
• Ik heb de data door elkaar gehaald. — He confundido las fechas.
• Ze lijken zo op elkaar dat ik ze niet uit elkaar kan houden. — Se parecen tanto que no los distingo.

📐 door elkaar halen es separable y de tres piezas: el verbo es halen y door elkaar se va al final (Ik haal ze door elkaar), en el perfecto queda door elkaar gehaald (Ik heb ze door elkaar gehaald) y en subordinada todo se junta al fondo (… dat ik ze door elkaar haal). Su antonimo es uit elkaar houden = distinguir, no confundir: Ik kan die twee niet uit elkaar houden.

🗺️ Entonces, ¿cuando verwisselen? Cuando el cambio es MATERIAL: has cogido unas llaves por otras, has puesto mal las etiquetas, el mecanico ha cambiado los neumaticos. Si lo que se te mezcla esta en la CABEZA (nombres, caras, fechas, palabras), door elkaar halen. Y en registro formal existe verwarren MET: Verwar hem niet met zijn broer. De ahi de verwarring (la confusion), verwarrend (confuso) y la expresion in de war zijn (estar hecho un lio): Ik ben helemaal in de war.

👥 hun namen esta bien: hun es el POSESIVO de ellos (hun namen, hun huis, hun kinderen). Lo que hay que separar es el trio:
• zij / ze = sujeto. Zij verwisselen alles.
• hen / ze = objeto. Ik zie ze elke dag. En la norma escrita, hen para el objeto directo y detras de preposicion (Ik reken op hen) y hun para el indirecto (Ik heb hun een brief geschreven); al hablar, todo el mundo dice ze.
• hun = posesivo. Hun namen lijken op elkaar.
⚠️ «Hun hebben dat gedaan» es el error mas criticado del neerlandes: hun NUNCA es sujeto. Se oye, pero no se escribe jamas.

🏋️ Ejercicio: (a) «Siempre confundo sus nombres» (lo mas natural) → Ik ___ hun namen altijd ___ ___. (b) «¿Sigue viviendo aqui?» → Woont u ___ ___ hier? (c) «Cada vez es mas dificil» → Het wordt ___ moeilijker. (d) «No los distingo» → Ik kan ze niet ___ ___ ___. (Respuestas: haal … door elkaar · nog steeds · steeds · uit elkaar houden.)',
    updated_at = datetime('now')
WHERE id = 867
  AND rules_help IS NULL;

-- ==============================================================================
-- 2. El bloque de los adverbios de frecuencia, en las 5 tarjetas que los usan
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🕒 Donde va el adverbio de frecuencia (y que pasa si lo pones delante)
Su sitio por defecto es el CAMPO MEDIO: detras del verbo conjugado y de los pronombres atonos, y siempre DELANTE del resto de verbos, que se van al final.

| la frase | donde cae el adverbio |
|---|---|
| Ik werk **soms** thuis. | detras del verbo conjugado |
| Ik kom er **vaak**. | detras del pronombre er |
| Ik zal je **nooit** vergeten. | antes del infinitivo, que cierra la frase |
| Ik heb hem **vaak** gezien. | antes del participio, que cierra la frase |
| … dat ik hun namen **steeds** verwissel. | en subordinada, antes del bloque verbal final |

📌 Con un objeto definido puedes ponerlo antes o despues, y lo que cambia es el acento: Ik verwissel steeds hun namen (neutro, la informacion es lo que confundo) frente a Ik verwissel hun namen steeds (el acento cae en la frecuencia).

🔝 Y puede ir en la CASILLA 1, que obliga a la inversion — verbo en 2a y sujeto detras: Soms regent het hier de hele dag · Altijd verwissel ik hun namen · Nooit vergeet ik dat. Es correcto y lo que ganas es enfasis; a menudo, ademas, tono de queja o de sentencia.

📊 La escalera completa, de 100 a 0:

| adverbio | cuanto | ejemplo |
|---|---|---|
| **altijd** | siempre, sin excepcion | Hij is altijd te laat. |
| **steeds** | una y otra vez (repeticion que molesta) | Ik verwissel steeds hun namen. |
| **telkens** | cada vez que pasa | Telkens als ik hem zie, vergeet ik zijn naam. |
| **meestal** | normalmente, la mayoria de las veces | Meestal werk ik thuis. |
| **vaak** | a menudo | Ik kom er vaak. |
| **regelmatig** | con regularidad | Ze gaat regelmatig naar de sportschool. |
| **soms** | a veces | Ik werk soms thuis. |
| **zelden** | rara vez | Hij komt zelden op tijd. |
| **nooit** | nunca | Ik zal je nooit vergeten. |

⚠️ nooit ocupa el mismo hueco que niet, porque es la negacion de la frase: Ik ga niet → Ik ga nooit. Y por eso no se le suma otra: con nooit ya hay negacion, asi que el objeto va con enig/enige y nunca con geen.',
    updated_at = datetime('now')
WHERE id IN (298, 380, 381, 437, 867)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🕒 Donde va el adverbio de frecuencia%';
