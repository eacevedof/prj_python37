-- Learn Languages App - Bloque compartido: el «por» espanol (door vs voor), duda de la 864
-- Migration: 20260831000006-help-block-por-door-vs-voor.sql
-- Description: Eduardo, sobre la 864 («Kun je hier euro's wisselen voor dollars?»): «tengo
--   problemas con traducir "por" al neerlandes, a veces es "door" y otras "voor"». El «por»
--   espanol se reparte en SEIS preposiciones segun lo que este haciendo en la frase, y el par
--   que se atasca (door/voor) se resuelve con un test de sustitucion: si cabe «a causa de» o
--   «por parte de» es door (agente de pasiva y causa), si cabe «a cambio de» o «para» es voor
--   (intercambio y destinatario). El mazo ya tiene las dos caras del par y ahora quedan
--   enlazadas: la 864 es el intercambio (voor) y la 830 el agente de pasiva (door).
--   Bloque 🔁 IDENTICO byte a byte con la tabla de las seis (door · voor · per · uit · vanwege ·
--   langs), el test de sustitucion, las CUATRO vidas de voor (a cambio de / antes de en tiempo /
--   delante de en espacio / particula de separable, donde ya no es preposicion — de ahi la 706,
--   «Ik stel voor om te wachten»), las locuciones fijas que no se deducen (dank voor, daarom,
--   voor het geval dat, voorlopig, eindelijk, natuurlijk, per post) y la construccion
--   «door … te + infinitivo» para el «por + infinitivo» causal.
--   Va a 10 tarjetas. Tres (822, 825, 864) tenian rules_help a NULL y se crean enteras, con el
--   regimen que cada una ensena: voor como plazo (822), verbergen VOOR iemand = ocultar algo A
--   alguien (825) y wisselen voor con el reparto de «cambiar» (864).
--   100% aditiva e idempotente (guard por marca y por rules_help IS NULL).

-- ==============================================================================
-- 1. Tarjetas que YA tienen ayuda: el bloque se anade al final
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🔁 El «por» espanol se reparte en seis preposiciones
«por» es de las palabras que peor viajan: en neerlandes no hay ninguna que valga para todo, y la eleccion depende de QUE esta haciendo el «por» en la frase.

| si el «por» significa… | en NL | ejemplo |
|---|---|---|
| quien hace la accion (agente de pasiva) | **door** | Ik ben benaderd **door** een recruiter. |
| la causa, por culpa de | **door** | **Door** de regen bleven we thuis. |
| a cambio de | **voor** | euro''s wisselen **voor** dollars |
| a favor de, destinatario | **voor** | Wat kan ik **voor** u doen? |
| por unidad o por medio de | **per** | twee keer **per** week · **per** post |
| por un sentimiento o motivo interno | **uit** | **uit** liefde · **uit** angst |
| a causa de, en registro formal | **vanwege** | **vanwege** het weer |
| recorrido, pasar por | **langs** o **door** | **langs** de winkel · **door** het park |

🔤 Los sustantivos de los ejemplos, con su articulo: de regen · de winkel · het park · het weer · het huis · de liefde · de angst · de post. En «uit liefde» y «per post» el sustantivo va pelado porque son colocaciones fijas, pero la palabra tiene su genero igual.

🧪 El test que resuelve casi todos los casos, door o voor, que es donde se atasca:
• Si puedes sustituir el «por» por «a causa de» o por «por parte de», es door.
• Si puedes sustituirlo por «a cambio de» o por «para», es voor.
Euros por dolares es euros A CAMBIO DE dolares, luego voor. Contactado por un cazatalentos es POR PARTE DE un cazatalentos, luego door.

⚠️ voor tiene cuatro vidas y solo una de ellas traduce «por»:
• a cambio de, o para alguien. Dit is voor jou.
• ANTES DE, en el tiempo. voor het eten · kwart voor tien.
• DELANTE DE, en el espacio. Hij stond voor het huis.
• particula de un verbo separable, donde ya no es preposicion y no significa nada por su cuenta. voorstellen es proponer: Ik stel voor om te wachten.

📌 Las fijas, que no se deducen y hay que saberlas: gracias por = dank voor · por eso = daarom · por si acaso = voor het geval dat · por ahora = voorlopig · por fin = eindelijk · por supuesto = natuurlijk · por correo = per post · por telefono = telefonisch o per telefoon.

🏗️ Y una construccion que rinde mucho: el «por + infinitivo» causal del espanol se dice door … te + infinitivo. Door hard te werken heeft hij het gehaald. — Por trabajar duro lo consiguio.',
    updated_at = datetime('now')
WHERE id IN (564, 634, 639, 706, 738, 796, 830)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🔁 El «por» espanol%';

-- ==============================================================================
-- 2. Tarjeta 822: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'voor de zomer = para el verano, o sea antes de que llegue: aqui «voor» marca el PLAZO, la fecha limite, no un «por». Es la vida temporal de voor, la misma de «voor het eten» (antes de comer). Y afvallen es adelgazar (literalmente caerse encima, de peso), separable y con auxiliar zijn en el perfecto: Ze is vijf kilo afgevallen. Su contrario es aankomen, que ademas de llegar significa engordar. Y de zomer ↔ de winter.

🔁 El «por» espanol se reparte en seis preposiciones
«por» es de las palabras que peor viajan: en neerlandes no hay ninguna que valga para todo, y la eleccion depende de QUE esta haciendo el «por» en la frase.

| si el «por» significa… | en NL | ejemplo |
|---|---|---|
| quien hace la accion (agente de pasiva) | **door** | Ik ben benaderd **door** een recruiter. |
| la causa, por culpa de | **door** | **Door** de regen bleven we thuis. |
| a cambio de | **voor** | euro''s wisselen **voor** dollars |
| a favor de, destinatario | **voor** | Wat kan ik **voor** u doen? |
| por unidad o por medio de | **per** | twee keer **per** week · **per** post |
| por un sentimiento o motivo interno | **uit** | **uit** liefde · **uit** angst |
| a causa de, en registro formal | **vanwege** | **vanwege** het weer |
| recorrido, pasar por | **langs** o **door** | **langs** de winkel · **door** het park |

🔤 Los sustantivos de los ejemplos, con su articulo: de regen · de winkel · het park · het weer · het huis · de liefde · de angst · de post. En «uit liefde» y «per post» el sustantivo va pelado porque son colocaciones fijas, pero la palabra tiene su genero igual.

🧪 El test que resuelve casi todos los casos, door o voor, que es donde se atasca:
• Si puedes sustituir el «por» por «a causa de» o por «por parte de», es door.
• Si puedes sustituirlo por «a cambio de» o por «para», es voor.
Euros por dolares es euros A CAMBIO DE dolares, luego voor. Contactado por un cazatalentos es POR PARTE DE un cazatalentos, luego door.

⚠️ voor tiene cuatro vidas y solo una de ellas traduce «por»:
• a cambio de, o para alguien. Dit is voor jou.
• ANTES DE, en el tiempo. voor het eten · kwart voor tien.
• DELANTE DE, en el espacio. Hij stond voor het huis.
• particula de un verbo separable, donde ya no es preposicion y no significa nada por su cuenta. voorstellen es proponer: Ik stel voor om te wachten.

📌 Las fijas, que no se deducen y hay que saberlas: gracias por = dank voor · por eso = daarom · por si acaso = voor het geval dat · por ahora = voorlopig · por fin = eindelijk · por supuesto = natuurlijk · por correo = per post · por telefono = telefonisch o per telefoon.

🏗️ Y una construccion que rinde mucho: el «por + infinitivo» causal del espanol se dice door … te + infinitivo. Door hard te werken heeft hij het gehaald. — Por trabajar duro lo consiguio.',
    updated_at = datetime('now')
WHERE id = 822
  AND rules_help IS NULL;

-- ==============================================================================
-- 3. Tarjeta 825: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'verbergen VOOR iemand = ocultar algo A alguien. Es puro regimen: el espanol pone «a» (esconderselo A todos) y el neerlandes exige voor, nunca aan. Traducido pieza a pieza suena a «ante todos», que es justo lo que hay que memorizar. Y verbergen es fuerte: verbergen - verborg - verborgen, con participio sin ge- por el prefijo ver-. Sus antonimos: tonen o laten zien (mostrar) y onthullen (revelar, destapar). El sustantivo es het gevoel (el sentimiento), plural de gevoelens.

🔁 El «por» espanol se reparte en seis preposiciones
«por» es de las palabras que peor viajan: en neerlandes no hay ninguna que valga para todo, y la eleccion depende de QUE esta haciendo el «por» en la frase.

| si el «por» significa… | en NL | ejemplo |
|---|---|---|
| quien hace la accion (agente de pasiva) | **door** | Ik ben benaderd **door** een recruiter. |
| la causa, por culpa de | **door** | **Door** de regen bleven we thuis. |
| a cambio de | **voor** | euro''s wisselen **voor** dollars |
| a favor de, destinatario | **voor** | Wat kan ik **voor** u doen? |
| por unidad o por medio de | **per** | twee keer **per** week · **per** post |
| por un sentimiento o motivo interno | **uit** | **uit** liefde · **uit** angst |
| a causa de, en registro formal | **vanwege** | **vanwege** het weer |
| recorrido, pasar por | **langs** o **door** | **langs** de winkel · **door** het park |

🔤 Los sustantivos de los ejemplos, con su articulo: de regen · de winkel · het park · het weer · het huis · de liefde · de angst · de post. En «uit liefde» y «per post» el sustantivo va pelado porque son colocaciones fijas, pero la palabra tiene su genero igual.

🧪 El test que resuelve casi todos los casos, door o voor, que es donde se atasca:
• Si puedes sustituir el «por» por «a causa de» o por «por parte de», es door.
• Si puedes sustituirlo por «a cambio de» o por «para», es voor.
Euros por dolares es euros A CAMBIO DE dolares, luego voor. Contactado por un cazatalentos es POR PARTE DE un cazatalentos, luego door.

⚠️ voor tiene cuatro vidas y solo una de ellas traduce «por»:
• a cambio de, o para alguien. Dit is voor jou.
• ANTES DE, en el tiempo. voor het eten · kwart voor tien.
• DELANTE DE, en el espacio. Hij stond voor het huis.
• particula de un verbo separable, donde ya no es preposicion y no significa nada por su cuenta. voorstellen es proponer: Ik stel voor om te wachten.

📌 Las fijas, que no se deducen y hay que saberlas: gracias por = dank voor · por eso = daarom · por si acaso = voor het geval dat · por ahora = voorlopig · por fin = eindelijk · por supuesto = natuurlijk · por correo = per post · por telefono = telefonisch o per telefoon.

🏗️ Y una construccion que rinde mucho: el «por + infinitivo» causal del espanol se dice door … te + infinitivo. Door hard te werken heeft hij het gehaald. — Por trabajar duro lo consiguio.',
    updated_at = datetime('now')
WHERE id = 825
  AND rules_help IS NULL;

-- ==============================================================================
-- 4. Tarjeta 864: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'wisselen VOOR = cambiar A CAMBIO DE, y por eso aqui es voor y no door: lo que hay es un intercambio, no un agente ni una causa. Este es exactamente el par que confunde, porque la tarjeta 830 usa el otro («Ik ben benaderd DOOR een recruiter», donde el «por» es quien hace la accion). Ademas, el «cambiar» espanol se reparte: wisselen es cambiar dinero o intercambiar, ruilen es canjear una cosa por otra (ruilen voor tambien), veranderen es cambiar de estado o de forma, y omwisselen es hacer el cambio efectivo en ventanilla. Detalle ortografico: el plural de euro se escribe con apostrofo, euro''s, como foto''s y taxi''s, porque sin el la o se leeria corta. Los articulos: de euro, de dollar, het geld (el dinero).

🔁 El «por» espanol se reparte en seis preposiciones
«por» es de las palabras que peor viajan: en neerlandes no hay ninguna que valga para todo, y la eleccion depende de QUE esta haciendo el «por» en la frase.

| si el «por» significa… | en NL | ejemplo |
|---|---|---|
| quien hace la accion (agente de pasiva) | **door** | Ik ben benaderd **door** een recruiter. |
| la causa, por culpa de | **door** | **Door** de regen bleven we thuis. |
| a cambio de | **voor** | euro''s wisselen **voor** dollars |
| a favor de, destinatario | **voor** | Wat kan ik **voor** u doen? |
| por unidad o por medio de | **per** | twee keer **per** week · **per** post |
| por un sentimiento o motivo interno | **uit** | **uit** liefde · **uit** angst |
| a causa de, en registro formal | **vanwege** | **vanwege** het weer |
| recorrido, pasar por | **langs** o **door** | **langs** de winkel · **door** het park |

🔤 Los sustantivos de los ejemplos, con su articulo: de regen · de winkel · het park · het weer · het huis · de liefde · de angst · de post. En «uit liefde» y «per post» el sustantivo va pelado porque son colocaciones fijas, pero la palabra tiene su genero igual.

🧪 El test que resuelve casi todos los casos, door o voor, que es donde se atasca:
• Si puedes sustituir el «por» por «a causa de» o por «por parte de», es door.
• Si puedes sustituirlo por «a cambio de» o por «para», es voor.
Euros por dolares es euros A CAMBIO DE dolares, luego voor. Contactado por un cazatalentos es POR PARTE DE un cazatalentos, luego door.

⚠️ voor tiene cuatro vidas y solo una de ellas traduce «por»:
• a cambio de, o para alguien. Dit is voor jou.
• ANTES DE, en el tiempo. voor het eten · kwart voor tien.
• DELANTE DE, en el espacio. Hij stond voor het huis.
• particula de un verbo separable, donde ya no es preposicion y no significa nada por su cuenta. voorstellen es proponer: Ik stel voor om te wachten.

📌 Las fijas, que no se deducen y hay que saberlas: gracias por = dank voor · por eso = daarom · por si acaso = voor het geval dat · por ahora = voorlopig · por fin = eindelijk · por supuesto = natuurlijk · por correo = per post · por telefono = telefonisch o per telefoon.

🏗️ Y una construccion que rinde mucho: el «por + infinitivo» causal del espanol se dice door … te + infinitivo. Door hard te werken heeft hij het gehaald. — Por trabajar duro lo consiguio.',
    updated_at = datetime('now')
WHERE id = 864
  AND rules_help IS NULL;
