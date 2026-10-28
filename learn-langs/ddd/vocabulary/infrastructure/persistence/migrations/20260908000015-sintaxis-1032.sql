-- Learn Languages App - Migration
-- Migration: 20260908000015-sintaxis-1032
-- Description: Eduardo, sobre la 1032 (Ik denk er nog over na): "explica mejor esa
--   sintaxis de esa frase no pillo la formula de su construccion".
--
--   Y con razon: esa frase tiene DOS piezas partidas a la vez, que es lo que la hace
--   dificil y lo que ninguna ayuda le explicaba.
--     - nadenken es SEPARABLE, asi que su particula na se va al final.
--     - erover es un ADVERBIO PRONOMINAL, que ademas se parte en er … over cuando hay algo
--       en medio, y aqui lo hay: nog.
--   El resultado es que al final de la frase se acumulan dos piezas sueltas en un orden
--   fijo: primero la preposicion del pronominal y despues la particula del separable.
--   Ik denk | er | nog | over | na.
--
--   Se explica construyendola paso a paso desde la version con complemento completo, y se
--   da la formula general mas el mismo esqueleto en
--   perfecto, con modal y en subordinada, que es donde las dos piezas se recolocan.
--   Eduardo pregunto ademas si no seria «Ik denk over mijn toekomst na», y tiene razon:
--   esa es la forma CANONICA, con la particula al final. La otra es la extrapuesta, con
--   el complemento preposicional detras del grupo verbal, que tambien es correcta y es
--   muy frecuente con complementos largos. Se explican las dos, y sobre todo se dice que
--   la eleccion desaparece en cuanto el complemento pasa a ser adverbio pronominal: er y
--   erover NO se extraponen, y eso es lo que fija el orden a partir del paso 2.
--   De propina, denken aan frente a denken over frente a nadenken over, que no son lo
--   mismo y explican por que aqui es nadenken.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

UPDATE words_es
SET rules_help = rules_help || '

🧩 La sintaxis de esta frase, paso a paso:

Es de las mas dificiles del mazo porque tiene DOS piezas partidas al mismo tiempo. Se entiende construyendola desde el principio.

| paso | frase | que ha cambiado |
|---|---|---|
| 1 | Ik denk over mijn toekomst **na**. | El verbo es nadenken, SEPARABLE: la particula na se va AL FINAL. Es el orden canonico. |
| 1b | Ik denk **na** over mijn toekomst. | La misma frase con el complemento preposicional EXTRAPUESTO, detras de la particula. Tambien correcta. |
| 2 | Ik denk **erover** na. | El complemento se sustituye por el adverbio pronominal **erover**, porque es una cosa. Y aqui ya no hay eleccion. |
| 3 | Ik denk **er** nog **over** na. | Entra nog, y al meterse algo en medio el erover se PARTE en er … over. |

🔀 El paso 1 tiene dos versiones, y las dos valen: Ik denk over mijn toekomst na es la que sigue la regla basica, con la particula al final. Lo que hay entre las dos es un fenomeno llamado EXTRAPOSICION: los complementos con preposicion pueden salirse del medio de la frase y colocarse detras del grupo verbal.

| version | que es | cuando se prefiere |
|---|---|---|
| Ik denk over mijn toekomst **na**. | el orden canonico, con todo en el medio | complementos cortos |
| Ik denk **na** over mijn toekomst. | extrapuesta, el complemento detras de la particula | complementos largos, y muy corriente |

📐 Con complementos largos: La extrapuesta gana claramente, porque la otra se hace pesada. Ik denk na over wat ik volgend jaar ga doen suena natural, mientras que «Ik denk over wat ik volgend jaar ga doen na» deja la particula colgando demasiado lejos del verbo.

⚠️ Pero en cuanto el complemento se convierte en adverbio pronominal, la eleccion DESAPARECE: er, erover, daar y waar NO se pueden extraponer. Se dice Ik denk erover na, y nunca «Ik denk na erover». Por eso a partir del paso 2 el orden ya es fijo, y por eso la frase de esta tarjeta solo tiene una forma posible.

🔑 La regla resumida: Con un complemento preposicional normal puedes elegir donde colocarlo; con er, daar, hier o waar, no.

📐 La formula, entonces:

sujeto + VERBO conjugado + ER + (lo que haya en medio) + PREPOSICION + PARTICULA

Ik denk | er | nog | over | na.

⚠️ Y el orden del final es FIJO: primero la preposicion del pronominal (over) y despues la particula del separable (na). Nunca al reves. Si hubiera ademas un infinitivo, iria detras de las dos.

🔑 El truco para montarla: Empieza por la frase con el complemento completo y ve sustituyendo. Nunca intentes colocar er, over y na de una vez: sal de Ik denk over mijn toekomst na, cambia el complemento por erover, y solo entonces mete el adverbio que lo parte.

📋 La misma frase en los demas tiempos, para ver como se recolocan las dos piezas:
• Presente — Ik denk er nog over na.
• Perfecto — Ik heb er nog over nagedacht. (la particula se pega al participio, con el ge- dentro)
• Con modal — Ik moet er nog over nadenken. (el separable se reune en infinitivo al final)
• Subordinada — … dat ik er nog over nadenk. (se reune con el verbo, que cierra la frase)
• Con te — … om er nog over na te denken. (el te se cuela DENTRO del separable)

🎭 Y por que nadenken y no denken, que es la otra mitad de la frase:
• denken aan — pensar EN algo o alguien, lo que te viene a la cabeza. Ik denk aan jou.
• denken over — tener una opinion sobre algo. Wat denk je daarover?
• nadenken over — reflexionar, darle vueltas a una decision. Ik denk erover na.
El na- viene de despues: es pensar detenidamente, no el pensamiento que pasa. Por eso Ik denk erover na es me lo estoy pensando, con una decision pendiente detras.

🪞 Las dos piezas por separado ya las tienes en el mazo: el adverbio pronominal partido esta en el grupo 36 (Waar denk je aan?) y los separables con su particula al final, en el 21. Esta frase es lo que pasa cuando coinciden las dos.

🏋️ Ejercicio: pon «todavia lo estoy pensando» en perfecto → Ik heb er nog ___ ___. (Respuesta: over nagedacht.)'
WHERE id = 1032
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧩 La sintaxis de esta frase%';
