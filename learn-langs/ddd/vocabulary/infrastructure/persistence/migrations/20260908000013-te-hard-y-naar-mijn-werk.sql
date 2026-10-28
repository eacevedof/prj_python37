-- Learn Languages App - Migration
-- Migration: 20260908000013-te-hard-y-naar-mijn-werk
-- Description: Dos dudas de Eduardo sobre el grupo 40.
--
--   (1) La 1052 (Hij rijdt te hard): "pq no puede ser hij rijdt heel snel?". Si puede, es
--   correcto, pero dice otra cosa: te es DEMASIADO y lleva juicio (se pasa del limite),
--   mientras heel es MUY y es una constatacion neutra. Y de paso, con vehiculos la
--   colocacion normal no es snel sino HARD: hard rijden es ir rapido y te hard rijden es
--   ir con exceso de velocidad, que es lo que dice el radar.
--   Se aprovecha para separar los TRES te del neerlandes, que se escriben igual y no
--   tienen nada que ver: te + adjetivo (demasiado), te + sustantivo en locucion (te koop,
--   te voet, que ya estan en la migracion 20260908000008) y te + infinitivo (om te gaan).
--
--   (2) La 1055 (Ik ga naar mijn werk): "que pasa si omito mijn? Ik ga naar werk". Que
--   queda mal: werk exige posesivo o articulo. Lo que despista es que otros lugares de la
--   rutina SI van desnudos — naar school, naar huis, naar bed, naar kantoor — y werk no
--   esta en esa lista. La salida elegante es cambiar de molde: Ik ga werken, con el verbo,
--   que no necesita nada.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. La 1052: te hard o heel snel
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: ¿Por que no Hij rijdt heel snel?

🔑 Si puede: Hij rijdt heel snel es correcto. Lo que pasa es que dice otra cosa, y ademas cambia la palabra que se usa de verdad con vehiculos.

| frase | que dice |
|---|---|
| Hij rijdt **te hard**. | Conduce **demasiado** rapido. Lleva JUICIO: se pasa del limite, es peligroso. |
| Hij rijdt **heel snel**. | Conduce **muy** rapido. Constatacion NEUTRA, sin reproche. |
| Hij rijdt **hard**. | Conduce rapido. Lo normal, sin mas. |
| Hij rijdt **veel te hard**. | Conduce muchisimo mas rapido de lo debido. |

⚠️ Y el detalle de vocabulario: con vehiculos, la palabra de la velocidad no es snel sino HARD. hard rijden es ir rapido y te hard rijden es lo que te pone la multa. snel no esta mal, pero hard es lo idiomatico.

🎭 hard tiene ese sentido de intensidad en muchos sitios, y casi nunca significa duro:
• hard rijden — ir rápido (en coche).
• hard werken — trabajar duro.
• hard lopen — CORRER. hardlopen junto es correr como deporte, no andar deprisa.
• hard praten — hablar alto.
• Het regent hard. — Llueve fuerte.
• De muziek staat hard. — La música está alta.

⚠️ hardlopen es de los falsos amigos que mas descolocan: no es andar duro, es correr. Ik ga hardlopen es me voy a correr.

🔢 Y los TRES te del neerlandes, que se escriben igual y no tienen nada que ver:
• te + ADJETIVO = demasiado. te duur, te laat, te hard. Ojo con Ik ben te laat, que es llego tarde y no llego demasiado tarde.
• te + SUSTANTIVO en locucion fija. te koop, te huur, te voet. Grupo cerrado, esta en la tarjeta 1067.
• te + INFINITIVO. om te gaan, iets te drinken, niets te verbergen.

🏋️ Ejercicio: «va demasiado rapido» y «va muy rapido» → Hij rijdt ___ ___. Hij rijdt ___ ___. (Respuestas: te hard · heel snel.)'
WHERE id = 1052
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';

-- =============================================================================
-- 2. La 1055: naar mijn werk y los lugares que van desnudos
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: ¿Que pasa si omito mijn? ¿Ik ga naar werk?

🔑 Queda mal: werk exige posesivo o articulo. Se dice Ik ga naar mijn werk, y tambien vale naar het werk, pero naar werk a secas no se dice.

⚠️ Lo que despista es que OTROS lugares de la rutina si van desnudos, y son justo los que mas se parecen. No hay logica que valga: es una lista que se aprende.

| van DESNUDOS | van con posesivo o articulo |
|---|---|
| naar **school** | naar **mijn** werk |
| naar **huis** | naar **het** station |
| naar **bed** | naar **de** winkel |
| naar **kantoor** | naar **de** dokter |
| op **vakantie** | in **de** stad |
| aan **tafel**, in **bed**, op **school** | op **het** werk |

🔑 El truco, hasta donde llega: los que van desnudos nombran una INSTITUCION o una funcion abstracta, no un sitio concreto. naar school es escolarizarse, naar bed es irse a dormir, naar huis es al hogar. En cambio werk se siente como TU trabajo concreto, y por eso pide mijn.

💡 Y la salida elegante, que ademas es mas corriente: cambia de molde y usa el VERBO, que no necesita nada.
• Ik ga naar mijn werk. — Voy al trabajo. (al lugar)
• Ik ga werken. — Voy a trabajar. (la actividad)
Las dos valen, y la segunda te evita la duda del posesivo.

📋 werk con sus preposiciones, todas con posesivo:
• naar mijn werk gaan — ir al trabajo.
• op mijn werk zijn — estar en el trabajo.
• van mijn werk komen — venir del trabajo.
• werk zoeken — buscar trabajo. (aqui SI va desnudo, porque es la actividad y no el sitio)

🪞 Fijate en la ultima: werk zoeken va sin nada porque ahi werk es incontable y abstracto, como en We zoeken werk de la tarjeta 1041. Es el mismo reparto de contable y materia: el sitio pide determinante, la actividad no.

🏋️ Ejercicio: «estoy en el trabajo» y «voy a trabajar» → Ik ben ___ ___ werk. Ik ga ___. (Respuestas: op mijn · werken.)'
WHERE id = 1055
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';
