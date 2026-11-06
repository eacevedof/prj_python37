-- Learn Languages App - Migration
-- Migration: 20261105000005-frases-hechas-bloques-con-significado
-- Description: Eduardo (2026-11-05), sobre la 1802: «Uitdrukking o spreekwoord, cómo se usa una frase hecha …
--   me pones la expresion pero no me pones el significado y cuando se usa, een oogje dichtknijpen, de aanhouder
--   wint, voor de zekerheid».
--
--   Se sustituye byte a byte el bloque compartido '📚 Uitdrukking o spreekwoord' (grupos 55 y 56, 200 tarjetas)
--   y, por el mismo fallo, el '🛹 Spreektaal, jongerentaal o straattaal' (grupo 57, 80 tarjetas): la tabla
--   gana las columnas 'ejemplo y significado' y 'cuándo se usa', y los ejemplos sueltos de las viñetas llevan
--   su traducción entre paréntesis. Idempotente: el REPLACE solo encuentra el bloque viejo una vez.

UPDATE words_es SET rules_help = REPLACE(rules_help, '📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.', '📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo y significado | cuándo se usa |
|---|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen, hacer la vista gorda | cuando alguien tolera una falta pequeña, De leraar knijpt een oogje dicht |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint, el que la sigue la consigue | para animar a alguien a seguir intentándolo |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid, por si las moscas | al tomar una precaución, Neem een jas mee, voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork (abarco demasiado), Hij neemt te veel hooi op zijn vork (él abarca demasiado).
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt (… porque hace la vista gorda).
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la sección del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'), updated_at = datetime('now')
 WHERE rules_help LIKE '%📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.', '🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo y significado | cuándo se usa |
|---|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, no es para tanto · balen, qué rabia | con amigos, familia y compañeros, a diario |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, vergüenza ajena · chill, tranqui · vet, guay | entre jóvenes; de adulto suena a hacerse el joven |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, te lo juro · mattie, colega · doekoe, pasta | en el colegio, la calle y el rap; para entenderlo, no para usarlo |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, un momento, joh es hombre y hè es eh, Leuk hè? ¿Guay, eh?

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'), updated_at = datetime('now')
 WHERE rules_help LIKE '%🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.%';

