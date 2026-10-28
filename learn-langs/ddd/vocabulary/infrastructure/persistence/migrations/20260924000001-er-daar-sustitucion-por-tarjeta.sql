-- Learn Languages App - Migration
-- Migration: 20260924000001-er-daar-sustitucion-por-tarjeta
-- Description: Eduardo: "en todos los textos donde aparece er o daar indica si se puede o no
--   sustituir por el opuesto (daar -> er, er -> daar) y o q regla aplica, ejemplo 438".
--   La 438 (Antes vivia alli -> Vroeger woonde ik er) acepta daar igual de bien y la ayuda no lo
--   decia; en cambio en la mayoria de tarjetas con er (hay, cantidad, pasiva, er zijn = llegar)
--   daar cambia el sentido. Faltaba el mapa.
--
--   Se barren las tarjetas cuyo words_lang (nl_NL) lleva er o daar sueltos o sus compuestos con
--   preposicion (ervan, eraan, daarover, daarom...): 90 tarjetas. A cada una:
--     1. Un veredicto propio, seccion «↕️ er ↔ daar en esta frase», que dice si/no y la regla.
--     2. El bloque compartido «🚦 Las nueve vidas de er frente a daar» (§3.3, byte a byte): tabla
--        de 9 reglas con 3 ejemplos cada una, truco y regla de bolsillo.
--   Las tres sin ayuda (149, 464, 921) se crean enteras en un UPDATE aparte (§5.4), con su regla
--   como primera linea.
--
--   Idempotente: cada UPDATE lleva su guard NOT LIKE sobre la marca. No se toca ningun texto ES ni
--   NL, asi que no hay audio que regenerar.
--
--   Pendiente (a decidir por Eduardo): 438 y 1109 aceptan er y daar y el enunciado no dice cual
--   pide; se podrian marcar (átona)/(tónica) como la 261.

PRAGMA foreign_keys = ON;

-- 1) Las tres tarjetas sin ayuda

UPDATE words_es
SET rules_help = 'ZICH ERGENS OVERHEEN ZETTEN = superar algo, pasar pagina. Zet je er overheen = supéralo, literalmente «ponte por encima de eso»; er … overheen es ese «eso» partido alrededor del resto.

↕️ er ↔ daar en esta frase: Sí, regla 6. er … overheen = por encima de eso. Zet je daar overheen vale y apunta a algo concreto que se acaba de decir.

🚦 Las nueve vidas de er frente a daar:

er es atono y daar es tonico, como lo y eso en español. Donde er hace de allí o de eso, daar lo sustituye y añade enfasis. Donde er es pura gramatica (hay, cantidad, pasiva, frase hecha), daar no entra porque vuelve a significar allí.

| # | er hace de | ejemplo con er | ¿vale daar? | con daar queda |
|---|---|---|---|---|
| 1 | lugar atono, allí | Vroeger woonde ik **er**. · Ik kom **er** vaak. · Ik zal **er** zijn. | **sí** | Vroeger woonde ik daar. · Daar kom ik vaak. · Ik zal daar zijn. |
| 2 | er zijn = estar presente, haber llegado | Ik ben **er**. · De taxi is **er**. · Is iedereen **er**? | **no** | Ik ben daar = estoy allí, en otro sitio |
| 3 | hay: er is, er zijn, er ligt, wat is er | **Er** is koffie. · Wat is **er**? · **Er** kwamen weinig mensen. | **no** | Daar is koffie = allí hay café |
| 4 | cantidad, de esos | Ik heb **er** drie. · Ik wil **er** nog een. · Hoeveel heb je **er**? | **no** | Ik heb daar drie = tengo tres allí |
| 5 | pasiva sin sujeto | **Er** wordt gebeld. · **Er** wordt gezegd dat… · **Er** is ingebroken. | **no** | Daar wordt gebeld = allí llaman |
| 6 | er + preposicion = eso | Ik heb **er** geen zin **in**. · Wat vind je **ervan**? · Ik denk **er** nog **over** na. | **sí** | Daar heb ik geen zin in. · Wat vind je daarvan? · Daar denk ik nog over na. |
| 7 | frase hecha | Hoe gaat het **ermee**? · Ik kom **eraan**. · Ga **ervoor**! | **no** | cambia el sentido o no se dice |
| 8 | al reves, daar abre la frase | **Daar** weet ik niets van. · **Daar** kan ik niets aan doen. · **Daarover** verschillen we. | **sí, recolocando** | Ik weet er niets van. · Ik kan er niets aan doen. · We verschillen erover. |
| 9 | al reves, daar- conector | **daarom** · **daarna** · **daardoor** | **no** | «erom» no significa por eso |

🔑 El truco que casi nunca falla: Traduce er por allí o por eso. Si uno de los dos cabe sin cambiar el sentido, daar vale (reglas 1 y 6). Si no cabe ninguno, er es gramatica y no se toca (reglas 2 a 5). La excepcion son las frases hechas (regla 7), que se aprenden de memoria.

📌 Regla de bolsillo:
• ¿er se traduce por allí y habla de un sitio? → daar vale, con mas peso y pudiendo abrir la frase.
• ¿er zijn significa llegar o estar presente? → er fijo, daar lo convierte en un sitio.
• ¿er va con hay, con un numero o con una pasiva? → er fijo, daar diria allí.
• ¿er va con una preposicion y significa eso? → daar + preposicion, casi siempre en cabeza.

⚠️ er nunca abre la frase con estos valores. Si quieres empezar por el sitio o por el eso, es daar a la fuerza, y si partes de daar en cabeza y lo cambias por er tienes que mover er detras del verbo.'
WHERE id = 149 AND text = 'supéralo' AND rules_help IS NULL;

UPDATE words_es
SET rules_help = 'ERGENS VOOR GAAN = ir a por algo con todo. Kom op, ga ervoor! es el grito de animo hecho, con er + voor pegados al final.

↕️ er ↔ daar en esta frase: No, regla 7. Grito hecho. Daar ga ik voor si existe, pero el imperativo con daar no se dice.

🚦 Las nueve vidas de er frente a daar:

er es atono y daar es tonico, como lo y eso en español. Donde er hace de allí o de eso, daar lo sustituye y añade enfasis. Donde er es pura gramatica (hay, cantidad, pasiva, frase hecha), daar no entra porque vuelve a significar allí.

| # | er hace de | ejemplo con er | ¿vale daar? | con daar queda |
|---|---|---|---|---|
| 1 | lugar atono, allí | Vroeger woonde ik **er**. · Ik kom **er** vaak. · Ik zal **er** zijn. | **sí** | Vroeger woonde ik daar. · Daar kom ik vaak. · Ik zal daar zijn. |
| 2 | er zijn = estar presente, haber llegado | Ik ben **er**. · De taxi is **er**. · Is iedereen **er**? | **no** | Ik ben daar = estoy allí, en otro sitio |
| 3 | hay: er is, er zijn, er ligt, wat is er | **Er** is koffie. · Wat is **er**? · **Er** kwamen weinig mensen. | **no** | Daar is koffie = allí hay café |
| 4 | cantidad, de esos | Ik heb **er** drie. · Ik wil **er** nog een. · Hoeveel heb je **er**? | **no** | Ik heb daar drie = tengo tres allí |
| 5 | pasiva sin sujeto | **Er** wordt gebeld. · **Er** wordt gezegd dat… · **Er** is ingebroken. | **no** | Daar wordt gebeld = allí llaman |
| 6 | er + preposicion = eso | Ik heb **er** geen zin **in**. · Wat vind je **ervan**? · Ik denk **er** nog **over** na. | **sí** | Daar heb ik geen zin in. · Wat vind je daarvan? · Daar denk ik nog over na. |
| 7 | frase hecha | Hoe gaat het **ermee**? · Ik kom **eraan**. · Ga **ervoor**! | **no** | cambia el sentido o no se dice |
| 8 | al reves, daar abre la frase | **Daar** weet ik niets van. · **Daar** kan ik niets aan doen. · **Daarover** verschillen we. | **sí, recolocando** | Ik weet er niets van. · Ik kan er niets aan doen. · We verschillen erover. |
| 9 | al reves, daar- conector | **daarom** · **daarna** · **daardoor** | **no** | «erom» no significa por eso |

🔑 El truco que casi nunca falla: Traduce er por allí o por eso. Si uno de los dos cabe sin cambiar el sentido, daar vale (reglas 1 y 6). Si no cabe ninguno, er es gramatica y no se toca (reglas 2 a 5). La excepcion son las frases hechas (regla 7), que se aprenden de memoria.

📌 Regla de bolsillo:
• ¿er se traduce por allí y habla de un sitio? → daar vale, con mas peso y pudiendo abrir la frase.
• ¿er zijn significa llegar o estar presente? → er fijo, daar lo convierte en un sitio.
• ¿er va con hay, con un numero o con una pasiva? → er fijo, daar diria allí.
• ¿er va con una preposicion y significa eso? → daar + preposicion, casi siempre en cabeza.

⚠️ er nunca abre la frase con estos valores. Si quieres empezar por el sitio o por el eso, es daar a la fuerza, y si partes de daar en cabeza y lo cambias por er tienes que mover er detras del verbo.'
WHERE id = 464 AND text = '¡Venga, a por ello! (ergens voor gaan)' AND rules_help IS NULL;

UPDATE words_es
SET rules_help = 'VAN MENING VERSCHILLEN = discrepar. Daarover = sobre eso, y como abre la frase el verbo va segundo y el sujeto detras, Daarover verschillen we van mening.

↕️ er ↔ daar en esta frase: Sí, regla 8. Con er hay que recolocar, We verschillen erover van mening, porque er nunca abre la frase.

🚦 Las nueve vidas de er frente a daar:

er es atono y daar es tonico, como lo y eso en español. Donde er hace de allí o de eso, daar lo sustituye y añade enfasis. Donde er es pura gramatica (hay, cantidad, pasiva, frase hecha), daar no entra porque vuelve a significar allí.

| # | er hace de | ejemplo con er | ¿vale daar? | con daar queda |
|---|---|---|---|---|
| 1 | lugar atono, allí | Vroeger woonde ik **er**. · Ik kom **er** vaak. · Ik zal **er** zijn. | **sí** | Vroeger woonde ik daar. · Daar kom ik vaak. · Ik zal daar zijn. |
| 2 | er zijn = estar presente, haber llegado | Ik ben **er**. · De taxi is **er**. · Is iedereen **er**? | **no** | Ik ben daar = estoy allí, en otro sitio |
| 3 | hay: er is, er zijn, er ligt, wat is er | **Er** is koffie. · Wat is **er**? · **Er** kwamen weinig mensen. | **no** | Daar is koffie = allí hay café |
| 4 | cantidad, de esos | Ik heb **er** drie. · Ik wil **er** nog een. · Hoeveel heb je **er**? | **no** | Ik heb daar drie = tengo tres allí |
| 5 | pasiva sin sujeto | **Er** wordt gebeld. · **Er** wordt gezegd dat… · **Er** is ingebroken. | **no** | Daar wordt gebeld = allí llaman |
| 6 | er + preposicion = eso | Ik heb **er** geen zin **in**. · Wat vind je **ervan**? · Ik denk **er** nog **over** na. | **sí** | Daar heb ik geen zin in. · Wat vind je daarvan? · Daar denk ik nog over na. |
| 7 | frase hecha | Hoe gaat het **ermee**? · Ik kom **eraan**. · Ga **ervoor**! | **no** | cambia el sentido o no se dice |
| 8 | al reves, daar abre la frase | **Daar** weet ik niets van. · **Daar** kan ik niets aan doen. · **Daarover** verschillen we. | **sí, recolocando** | Ik weet er niets van. · Ik kan er niets aan doen. · We verschillen erover. |
| 9 | al reves, daar- conector | **daarom** · **daarna** · **daardoor** | **no** | «erom» no significa por eso |

🔑 El truco que casi nunca falla: Traduce er por allí o por eso. Si uno de los dos cabe sin cambiar el sentido, daar vale (reglas 1 y 6). Si no cabe ninguno, er es gramatica y no se toca (reglas 2 a 5). La excepcion son las frases hechas (regla 7), que se aprenden de memoria.

📌 Regla de bolsillo:
• ¿er se traduce por allí y habla de un sitio? → daar vale, con mas peso y pudiendo abrir la frase.
• ¿er zijn significa llegar o estar presente? → er fijo, daar lo convierte en un sitio.
• ¿er va con hay, con un numero o con una pasiva? → er fijo, daar diria allí.
• ¿er va con una preposicion y significa eso? → daar + preposicion, casi siempre en cabeza.

⚠️ er nunca abre la frase con estos valores. Si quieres empezar por el sitio o por el eso, es daar a la fuerza, y si partes de daar en cabeza y lo cambias por er tienes que mover er detras del verbo.'
WHERE id = 921 AND text = 'Sobre eso discrepamos. (presente, inv)' AND rules_help IS NULL;


-- 2) El veredicto de cada tarjeta

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 5. Es la pasiva sin sujeto y er solo tapa el hueco del sujeto. Daar is ingebroken diria «allí han entrado a robar», otra frase.'
WHERE id = 141 AND text = 'han entrado a robar' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 1. Ik zal daar zijn vale. Con er el peso esta en acudir, en estar presente; con daar, en el sitio. Y con daar puedes abrir, Daar zal ik zijn.'
WHERE id = 208 AND text = 'estaré allí' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. Es el hay. Daar is / daar zijn significa «allí hay, allí están».'
WHERE id = 257 AND text = 'hay' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. Es el er de hay dentro de la pregunta. Wat is daar? = ¿qué hay allí?'
WHERE id = 258 AND text = '¿qué pasa?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, reglas 3 y 7. Frase hecha con el er de hay. Wat is daar aan de hand? pregunta qué pasa allí, en ese sitio.'
WHERE id = 259 AND text = '¿qué está pasando?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 2. er zijn = haber llegado. Ik ben daar = estoy allí, en otro sitio, justo lo contrario de ya estoy aquí.'
WHERE id = 260 AND text = 'ya estoy aquí' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 1, pero el enunciado pide la átona. Ik ben daar nooit geweest es correcto, y con enfasis Daar ben ik nooit geweest.'
WHERE id = 261 AND text = 'nunca he estado allí (átona)' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 4. Es el er de cantidad. Ik heb daar drie = tengo tres allí.'
WHERE id = 262 AND text = 'tengo tres (de esos)' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Wat vind je daarvan? vale, preguntando por algo concreto que se acaba de enseñar.'
WHERE id = 263 AND text = '¿qué te parece?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Daar heb ik zin in = de ESO tengo ganas, mas enfatico y abriendo la frase.'
WHERE id = 264 AND text = '¡qué ganas!' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Daar kan ik niets aan doen es la version enfatica (es la tarjeta 453).'
WHERE id = 265 AND text = 'no puedo hacer nada' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 7. Saludo hecho. Hoe gaat het daarmee? ya no pregunta por la persona sino por una cosa concreta.'
WHERE id = 266 AND text = '¿cómo te va?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 5. Pasiva sin sujeto. Daar wordt aangebeld = allí llaman al timbre.'
WHERE id = 267 AND text = 'llaman a la puerta' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Zullen we daar maar aan beginnen? vale, señalando la tarea concreta.'
WHERE id = 288 AND text = '¿Nos ponemos ya con ello?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Daar zal ik aan denken vale, con daar abriendo y la preposicion al final.'
WHERE id = 294 AND text = 'Me acordaré, lo tendré en cuenta.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 1. Om acht uur zal ik daar zijn vale. Con er importa que estaras; con daar, el sitio.'
WHERE id = 297 AND text = 'A las ocho estaré allí.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 1. Zul je daar echt zijn? vale, poniendo el peso en el sitio.'
WHERE id = 299 AND text = '¿De verdad estarás allí?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 1. … dat ze daar zal zijn vale. En la subordinada daar tambien va en medio, sin abrir.'
WHERE id = 300 AND text = 'Promete que estará allí. (ella)' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. Es el er que presenta un sujeto indefinido (iets). Daar zal iets moeten veranderen = allí tendra que cambiar algo.'
WHERE id = 327 AND text = 'Algo tendrá que cambiar.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. er ligt es un hay. Con daar seria «allí hay trastos».'
WHERE id = 351 AND text = 'Hay un montón de trastos por la calle.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6 al reves. Wat moet ik er allemaal mee? es correcto y mas neutro; daar subraya todo ESO que te han dejado.'
WHERE id = 355 AND text = '¿Y qué hago yo con todo eso?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 2. er zijn = estar presente. Is iedereen daar? pregunta si estan todos allí, en otro sitio.'
WHERE id = 364 AND text = '¿Están todos?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 1. Ik ben daar weleens geweest vale, señalando el sitio del que se habla.'
WHERE id = 374 AND text = 'He estado alguna vez.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 1. Ik ben daar een paar keer geweest vale, y con enfasis Daar ben ik een paar keer geweest.'
WHERE id = 395 AND text = 'He estado allí algunas veces.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. Es el hay, y el sitio ya lo dice in de keuken.'
WHERE id = 420 AND text = 'Hay café en la cocina.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. Es el hay. Daar zijn veel fietsen = allí hay muchas bicis, y sobraria in Amsterdam.'
WHERE id = 421 AND text = 'Hay muchas bicis en Ámsterdam.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. Is daar nog melk? = ¿queda leche allí?'
WHERE id = 422 AND text = '¿Queda leche?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. Es el hay, colocado detras del verbo porque abre vanavond.'
WHERE id = 423 AND text = 'Esta noche hay fiesta en casa de los vecinos.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. omdat daar storm is = porque allí hay tormenta.'
WHERE id = 424 AND text = 'Me quedo en casa porque hay tormenta.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. Es la formula wat is er, y daar no entra.'
WHERE id = 425 AND text = '¿Qué te pasa a ti?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. Is daar iets? = ¿hay algo allí?'
WHERE id = 426 AND text = '¿Pasa algo?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. Es el hay negado, er is niets.'
WHERE id = 427 AND text = 'No pasa nada, tranquilo.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. En subordinada el er de hay se mantiene, wat er is.'
WHERE id = 428 AND text = 'Cuéntame qué pasa.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, reglas 3 y 7. El lugar ya es hier; er es el del hay y daar chocaria con hier.'
WHERE id = 429 AND text = '¿Qué pasa aquí?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, reglas 3 y 7. Es el hay de la frase hecha aan de hand.'
WHERE id = 430 AND text = 'No pasa nada, todo en orden.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, reglas 3 y 7. El sitio lo da buiten; er es el del hay.'
WHERE id = 431 AND text = 'Fuera está pasando algo.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, reglas 3 y 7. Es el hay de aan de hand, en subordinada.'
WHERE id = 432 AND text = 'No sé qué está pasando.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 2. er zijn = haber llegado. De taxi is daar = el taxi esta allí, en otro sitio.'
WHERE id = 433 AND text = 'El taxi ya está aquí.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No en ninguno de los dos, regla 2. er zijn = llegar. Con daar serian ¿estas allí? y acabo de estar allí.'
WHERE id = 434 AND text = '¿Ya has llegado? Acabo de llegar.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 2. Ik ben er bijna = casi llego. Ik ben daar bijna no se dice con ese sentido.'
WHERE id = 435 AND text = '¡Ya casi llego!' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 1. Ben je daar weleens geweest? vale, señalando el sitio del que se hablaba.'
WHERE id = 436 AND text = '¿Has estado allí alguna vez?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 1. Ik kom daar vaak vale, y Daar kom ik vaak abre con el sitio.'
WHERE id = 437 AND text = 'Voy mucho por allí.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 1. Vroeger woonde ik daar es igual de correcto y muy frecuente; daar da algo mas de peso al sitio y deja abrir con el, Daar woonde ik vroeger. La tarjeta pide er porque el allí español va al final y sin enfasis.'
WHERE id = 438 AND text = 'Antes vivía allí.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 1, pero el enunciado pide la átona. … dat het daar mooi is es correcto.'
WHERE id = 439 AND text = 'Dice que allí es bonito. (ella, átona)' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 4. Es el er de cantidad. Hoeveel heb je daar? = ¿cuantos tienes allí?'
WHERE id = 440 AND text = '¿Cuántos tienes?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 4. Es el er de cantidad, er nog een = otro de esos.'
WHERE id = 441 AND text = 'Quiero otro más.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 4. Es el er de cantidad, er geen meer = ninguno mas de esos.'
WHERE id = 442 AND text = 'Ya no nos quedan.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 4. Es el er de cantidad, en subordinada.'
WHERE id = 443 AND text = 'Preguntó cuántos me quedaban. (él)' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Daar vind ik niets aan vale, y es la forma de despreciar algo concreto.'
WHERE id = 445 AND text = 'No le veo la gracia (frase hecha).' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Daar weet ik niets van es la version enfatica (tarjeta 976).'
WHERE id = 446 AND text = 'No sé nada de eso.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Zeg eens wat je daarvan vindt vale, preguntando por algo concreto.'
WHERE id = 447 AND text = 'Di qué te parece.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Heb je daar zin in? vale, señalando el plan concreto.'
WHERE id = 448 AND text = '¿Tienes ganas?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Daar heb ik geen zin in es muy frecuente, y mas cortante.'
WHERE id = 449 AND text = 'No me apetece nada.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6, pero el enunciado pide la átona. … dat ze daar echt zin in had es correcto.'
WHERE id = 451 AND text = 'Dijo que tenía muchísimas ganas. (ella, átona)' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Kun je daar iets aan doen? vale.'
WHERE id = 452 AND text = '¿Puedes hacer algo al respecto?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 8. Con er hay que recolocar, Ik kan er niets aan doen, porque er nunca abre la frase.'
WHERE id = 453 AND text = 'Eso no está en mi mano (enfático con daar, inv).' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Daar moeten we iets aan doen, con daar abriendo.'
WHERE id = 454 AND text = 'Tenemos que hacer algo al respecto.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. … dat hij daar niets aan kan doen vale; en subordinada daar va en medio.'
WHERE id = 455 AND text = 'Dice que no es culpa suya. (él)' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6, con matiz. Hoe staat het daarmee? pregunta por un asunto concreto recien mencionado; ermee es la formula general.'
WHERE id = 456 AND text = '¿Cómo va eso? (el estado de un asunto)' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 7. Es formula hecha de como va la cosa; con daar pasa a hablar de un asunto concreto.'
WHERE id = 457 AND text = 'Va bien la cosa.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Daar ben ik druk mee bezig vale.'
WHERE id = 458 AND text = 'Estoy muy liado con ello.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 7. Aqui es el como iba todo, general; daarmee lo reduciria a una cosa concreta.'
WHERE id = 459 AND text = 'Preguntó cómo iba todo. (ella, átona)' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 5. Pasiva sin sujeto.'
WHERE id = 460 AND text = 'Están llamando a la puerta (golpes).' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 5. Pasiva sin sujeto, y el sitio ya es hier.'
WHERE id = 461 AND text = 'Aquí se trabaja duro.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 5. Pasiva sin sujeto, invertida detras del verbo, wordt er.'
WHERE id = 462 AND text = 'Por la noche llama mucha gente.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 5. Pasiva sin sujeto, en subordinada.'
WHERE id = 463 AND text = 'Oigo que llaman a la puerta.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Daar ga ik vol voor vale, señalando el objetivo.'
WHERE id = 465 AND text = 'Voy a por todas.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 7. Frase hecha, se dice tal cual.'
WHERE id = 466 AND text = '¡O todo o nada!' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 9. daarna es conector (despues); erna solo va con un tiempo delante, kort erna.'
WHERE id = 469 AND text = 'Vamos al mercado y luego a casa.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. Es el hay. Maar daar is meer verkeer = pero allí hay mas trafico, otra frase.'
WHERE id = 474 AND text = 'El camino por delante es más corto, pero hay más tráfico.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. Es el hay, en subordinada.'
WHERE id = 498 AND text = 'El camino por delante es más corto, aunque hay más tráfico.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 1. Zul jij daar zijn? vale, poniendo el peso en el sitio.'
WHERE id = 534 AND text = '¿estarás allí?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6, pero raro. er anuncia la subordinada; con daar lo natural es partir la frase, Daar zorg ik voor.'
WHERE id = 565 AND text = 'me encargo de que todo esté listo' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Bemoei je daar niet mee! vale, y suena mas cortante.'
WHERE id = 610 AND text = '¡no te metas!' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. Wat is daar gebeurd? = ¿que ha pasado allí?'
WHERE id = 624 AND text = '¿qué ha pasado?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 5. Pasiva sin sujeto.'
WHERE id = 695 AND text = 'se dice que es rico' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. Es el er de hay dentro de wat … ook.'
WHERE id = 819 AND text = 'Estoy a tu lado, pase lo que pase.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 3. er presenta el sujeto indefinido, weinig mensen.'
WHERE id = 887 AND text = 'Vino poca gente a la charla.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 7. eraan komen = estar llegando. Ik kom daaraan = toco eso.'
WHERE id = 895 AND text = 'Espera un momento, ya voy.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, reglas 3 y 7. Es el hay de la frase hecha aan de hand.'
WHERE id = 905 AND text = '¿Qué pasa?' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 7. er uitzien = tener aspecto, fijo. Hoe het daar ook uitziet = como este aquello allí.'
WHERE id = 942 AND text = 'Pinte como pinte, seguimos adelante.' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 8. Con er hay que recolocar, Ik weet er niets van (tarjeta 446).'
WHERE id = 976 AND text = 'de eso no sé nada (inv)' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 9. daarom es conector (por eso); «erom» no existe con ese valor.'
WHERE id = 1003 AND text = 'estaba cansado, por eso me fui a la cama' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No en ninguno, reglas 3 y 9. Er was file es el hay, y daardoor es conector (por eso) que erdoor no sustituye.'
WHERE id = 1004 AND text = 'había atasco, por eso llegué tarde' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: No, regla 9. daarom es conector (por eso); «erom» no existe con ese valor.'
WHERE id = 1009 AND text = 'está enfermo, por eso no viene (él)' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 6. Daar denk ik nog over na vale, y es muy frecuente.'
WHERE id = 1032 AND text = 'me lo estoy pensando' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';

UPDATE words_es SET rules_help = rules_help || '

↕️ er ↔ daar en esta frase: Sí, regla 1 al reves. Ik ben er twee jaar geleden geweest es correcto y mas neutro; daar señala el sitio.'
WHERE id = 1109 AND text = 'estuve allí hace dos años' AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↕️ er ↔ daar en esta frase%';


-- 3) El bloque compartido, detras del veredicto

UPDATE words_es SET rules_help = rules_help || '

🚦 Las nueve vidas de er frente a daar:

er es atono y daar es tonico, como lo y eso en español. Donde er hace de allí o de eso, daar lo sustituye y añade enfasis. Donde er es pura gramatica (hay, cantidad, pasiva, frase hecha), daar no entra porque vuelve a significar allí.

| # | er hace de | ejemplo con er | ¿vale daar? | con daar queda |
|---|---|---|---|---|
| 1 | lugar atono, allí | Vroeger woonde ik **er**. · Ik kom **er** vaak. · Ik zal **er** zijn. | **sí** | Vroeger woonde ik daar. · Daar kom ik vaak. · Ik zal daar zijn. |
| 2 | er zijn = estar presente, haber llegado | Ik ben **er**. · De taxi is **er**. · Is iedereen **er**? | **no** | Ik ben daar = estoy allí, en otro sitio |
| 3 | hay: er is, er zijn, er ligt, wat is er | **Er** is koffie. · Wat is **er**? · **Er** kwamen weinig mensen. | **no** | Daar is koffie = allí hay café |
| 4 | cantidad, de esos | Ik heb **er** drie. · Ik wil **er** nog een. · Hoeveel heb je **er**? | **no** | Ik heb daar drie = tengo tres allí |
| 5 | pasiva sin sujeto | **Er** wordt gebeld. · **Er** wordt gezegd dat… · **Er** is ingebroken. | **no** | Daar wordt gebeld = allí llaman |
| 6 | er + preposicion = eso | Ik heb **er** geen zin **in**. · Wat vind je **ervan**? · Ik denk **er** nog **over** na. | **sí** | Daar heb ik geen zin in. · Wat vind je daarvan? · Daar denk ik nog over na. |
| 7 | frase hecha | Hoe gaat het **ermee**? · Ik kom **eraan**. · Ga **ervoor**! | **no** | cambia el sentido o no se dice |
| 8 | al reves, daar abre la frase | **Daar** weet ik niets van. · **Daar** kan ik niets aan doen. · **Daarover** verschillen we. | **sí, recolocando** | Ik weet er niets van. · Ik kan er niets aan doen. · We verschillen erover. |
| 9 | al reves, daar- conector | **daarom** · **daarna** · **daardoor** | **no** | «erom» no significa por eso |

🔑 El truco que casi nunca falla: Traduce er por allí o por eso. Si uno de los dos cabe sin cambiar el sentido, daar vale (reglas 1 y 6). Si no cabe ninguno, er es gramatica y no se toca (reglas 2 a 5). La excepcion son las frases hechas (regla 7), que se aprenden de memoria.

📌 Regla de bolsillo:
• ¿er se traduce por allí y habla de un sitio? → daar vale, con mas peso y pudiendo abrir la frase.
• ¿er zijn significa llegar o estar presente? → er fijo, daar lo convierte en un sitio.
• ¿er va con hay, con un numero o con una pasiva? → er fijo, daar diria allí.
• ¿er va con una preposicion y significa eso? → daar + preposicion, casi siempre en cabeza.

⚠️ er nunca abre la frase con estos valores. Si quieres empezar por el sitio o por el eso, es daar a la fuerza, y si partes de daar en cabeza y lo cambias por er tienes que mover er detras del verbo.'
WHERE id IN (141, 208, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 288, 294, 297, 299, 300, 327, 351, 355, 364, 374, 395, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 445, 446, 447, 448, 449, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 465, 466, 469, 474, 498, 534, 565, 610, 624, 695, 819, 887, 895, 905, 942, 976, 1003, 1004, 1009, 1032, 1109)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🚦 Las nueve vidas de er frente a daar%';
