-- Learn Languages App - Migration
-- Migration: 20260922000005-verbos-de-llegar
-- Description: Eduardo, sobre la 659: "en 659 «cuando usarlo» aankomen vs komen q a veces es
--   llegar y si hay otro verbo «llegar» bereken (creo) tambien contrastalo ahi cuando se usa cada
--   uno con un ejemplo (oracion común)", y luego el caso real: "por ejemplo acabar de llegar en
--   avion, en coche, en bici, a pie, ... entrando en casa puedo decir jongens, ik ben net
--   aangekomen a mis hijos".
--
--   El verbo que buscaba es bereiken (no «bereken», que es berekenen = calcular).
--
--   Respuesta al caso de casa, que es el nucleo del bloque: el MEDIO no cambia el verbo (met het
--   vliegtuig / de auto / de fiets / te voet, todos con aankomen), pero el DESTINO si. aankomen
--   es llegar al final de un TRAYECTO — la estacion, el hotel, una ciudad —, asi que entrando en
--   casa «jongens, ik ben net aangekomen» suena a recien aterrizado de un viaje. Lo que dice un
--   neerlandes al cruzar la puerta es «Ik ben thuis!», «Ik ben er weer» o «Ik ben net
--   thuisgekomen».
--
--   El bloque contrasta los cuatro verbos que el español tapa bajo «llegar» (aankomen, komen,
--   bereiken, halen) + thuiskomen para casa, cada uno con una frase cotidiana, y avisa de las dos
--   trampas: bereiken es TRANSITIVO (objeto directo sin preposicion, auxiliar hebben) frente a
--   aankomen intransitivo de movimiento (auxiliar zijn), y aankomen significa ademas ENGORDAR
--   (Ik ben drie kilo aangekomen), que lo desambigua el complemento.
--
--   El bloque '🛬 Los cuatro «llegar»' (§3.3) va a las 3 tarjetas del mazo que usan aankomen:
--   659 (acabamos de llegar), 532 (ellos llegaran mas tarde) y 986 (cuando llegues, llamame).
--
--   AUDIO (§5.6.5): no se toca ningun words_es.text ni words_lang.text, solo rules_help -> no hay
--   audio que regenerar.

UPDATE words_es
SET rules_help = rules_help || '

🛬 Los cuatro «llegar»: El español usa llegar para todo; el neerlandes reparte el trabajo en cuatro verbos, y lo que decide no es el medio de transporte sino QUE es el sitio al que llegas.

| en neerlandes | que es exactamente | frase de todos los dias |
|---|---|---|
| **aankomen** | llegar al final de un TRAYECTO (estacion, hotel, ciudad, un paquete) | De trein komt om acht uur **aan**. |
| **komen** | venir o presentarse, el llegar generico | Hij **komt** altijd te laat. |
| **thuiskomen** | llegar A CASA, que tiene verbo propio | Ik **kom** om zes uur **thuis**. |
| **bereiken** | alcanzar algo que costo, o localizar a alguien | Ik kon hem niet **bereiken**. |
| **halen** | llegar a tiempo, alcanzar algo que se escapa | Ik **haal** de trein niet. |

🏠 Llegar a casa no es aankomen: aankomen vale para destinos de viaje, no para tu propia casa. Entrando por la puerta, «jongens, ik ben net aangekomen» suena a que acabas de aterrizar con la maleta. Lo que se dice de verdad al cruzarla es esto.
• Ik ben thuis! — ¡ya estoy en casa! Es el clasico al abrir la puerta.
• Ik ben er weer. — ya estoy de vuelta.
• Ik ben net thuisgekomen. — acabo de llegar a casa, contandolo.
• Ik ben net aangekomen uit Madrid. — con aangekomen la frase SI encaja, porque vuelves de fuera.

✈️ El medio de transporte NO cambia el verbo, solo el complemento: Ik ben net aangekomen met het vliegtuig · met de auto · met de fiets · te voet. Todos con aankomen y todos con zijn.

⚖️ aankomen frente a bereiken, que es la pareja que mas se cruza:
| | aankomen | bereiken |
|---|---|---|
| tipo | intransitivo, movimiento | **transitivo**: lleva objeto directo |
| preposicion | si: **in** Amsterdam, **bij** het hotel | **ninguna**: bereiken + objeto a secas |
| auxiliar | **zijn** — We zijn aangekomen | **hebben** — We hebben het bereikt |
| que aporta | el momento de arribo | que se ALCANZO, casi siempre con esfuerzo |
• We zijn in Amsterdam aangekomen. — Hemos llegado a Amsterdam.
• We hebben de top bereikt. — Hemos llegado a la cumbre (alcanzado).
• Ik kan haar niet bereiken. — No consigo localizarla (por telefono).

🎯 Por que is aangekomen y no heb, si al llegar ya no hay movimiento: Porque lo que pide zijn NO es el movimiento, es el CAMBIO. El sujeto pasa de no estar aqui a estar aqui, y ese cambio de lugar consumado es lo que dispara zijn. La prueba es que el mismo verbo cambia de auxiliar segun haya destino o no.
• Ik heb gelopen. — he andado, actividad sin meta, asi que hebben.
• Ik ben naar huis gelopen. — he ido andando a casa, hay cambio de lugar, asi que zijn.
• Ik heb gezwommen / Ik ben naar de overkant gezwommen. — el mismo par con nadar.
Y fijate en que el auxiliar es literalmente ser o estar: el perfecto con zijn describe el RESULTADO, no el trayecto — Hij is aangekomen es ha llegado y aqui esta, igual que Het ijs is gesmolten (el hielo esta derretido) o Hij is gevallen (se ha caido y ahi sigue).

🔑 Como elegir sin pensar: ¿Vengo de un trayecto y hablo del momento de llegar? aankomen. ¿Es mi casa? thuiskomen. ¿Es «alcanzar» algo que costo, o dar con alguien? bereiken. ¿Es llegar A TIEMPO? halen. ¿Ninguna de esas? komen.

⚠️ aankomen tiene doble vida y la segunda no es de viajes: con un peso significa ENGORDAR — Ik ben drie kilo aangekomen (he engordado tres kilos). Lo desambigua el complemento: con lugar es llegar, con kilos es engordar.

📌 Y no lo confundas con berekenen (calcular), que se parece a bereiken pero no tiene nada que ver: Ik heb de kosten berekend. — He calculado los costes.'
WHERE id IN (659, 532, 986)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🛬 Los cuatro «llegar»%';
