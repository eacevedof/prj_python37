-- Learn Languages App - Migration
-- Migration: 20260908000004-materia-o-unidad-y-el-se
-- Description: Eduardo, sobre la tarjeta 1068 (Ze verkopen hier goede kaas = aqui venden
--   buen queso): "pq no puede ser hier wordt een goede kaas verkocht?".
--
--   La pasiva SI es correcta: Hier wordt goede kaas verkocht es perfecta y muy natural, y
--   el mazo ya la cubre en el grupo 23 (Dit huis wordt verkocht, Hier wordt Nederlands
--   gesproken). Lo que falla es el EEN. kaas ahi es sustantivo de MATERIA, queso como
--   sustancia, y en sentido generico va sin articulo: goede kaas. Con een pasa a ser
--   unidad contable, een goede kaas, que es un queso concreto o un tipo concreto. Mismo
--   contraste que en español entre venden buen queso y venden un queso buenisimo.
--
--   Lo bonito es que el mazo ya tenia el par que lo demuestra sin señalarlo: la 290 (Zal
--   ik koffie zetten?) y la 420 (Er is koffie in de keuken) usan koffie como sustancia y
--   sin articulo, mientras la 317 (Ik zou graag een koffie willen) lleva een porque ahi
--   es una taza, una unidad.
--
--   Dos bloques compartidos:
--     A) "🧀 Materia o unidad" — cuando el sustantivo va sin articulo y cuando lleva een,
--        con las medidas (een stuk kaas, een glas melk) y el diminutivo de los bares
--        (een biertje). Va a las tarjetas que usan sustantivos de materia de comida,
--        bebida o dinero.
--     B) "🔁 Las cinco maneras del se español" — porque el grupo 23 solo cubre worden y
--        faltaban las otras cuatro: ze impersonal (que es justo lo que usa la 1068), je
--        generico, er wordt para la pasiva sin sujeto y men, que solo aparecia suelto en
--        la 824. Va a la 1068, al grupo 23 y a las de er wordt.
--
--   La 1068 se lleva ademas la respuesta concreta, con las dos versiones enfrentadas y la
--   diferencia de registro: la activa con ze es la coloquial y la pasiva es la de los
--   carteles.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. La 1068: la duda concreta
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: ¿Por que no Hier wordt een goede kaas verkocht?

🔑 La pasiva esta bien, el problema es el een. Hier wordt goede kaas verkocht es correcta y muy natural, tan buena como la version de la tarjeta. Lo que no encaja es el een, porque kaas aqui es sustantivo de MATERIA: queso como sustancia, no como pieza.

| version | que dice |
|---|---|
| Ze verkopen hier **goede kaas**. | Aqui venden buen queso. Activa coloquial, con ze impersonal. |
| Hier wordt **goede kaas** verkocht. | Aqui se vende buen queso. Pasiva, la de los carteles. Igual de correcta. |
| Hier wordt **een goede kaas** verkocht. | Aqui se vende un queso bueno. Cambia el sentido: ya es UNA pieza o UN tipo concreto. |

⚠️ En sentido generico, los sustantivos de materia van SIN articulo: goede kaas, vers brood, koud water, lekkere koffie. En cuanto pones een, dejan de ser sustancia y pasan a ser una unidad.

🪞 Y esto ya estaba en tu mazo sin que nadie lo dijera: la 290 (Zal ik koffie zetten?) y la 420 (Er is koffie in de keuken) llevan koffie sin articulo porque es sustancia, mientras la 317 (Ik zou graag een koffie willen) lleva een porque ahi es una taza. Misma palabra, dos comportamientos.

🎭 Sobre las dos versiones de la frase, la activa y la pasiva: las dos valen y solo cambia el registro. Ze verkopen hier… es lo que le dices a un amigo; Hier wordt… verkocht es lo que pone en el cartel o lo que dirias describiendo el barrio. El neerlandes tira de pasiva mucho mas que el español.

🏋️ Ejercicio: «aqui se vende pan fresco» → Hier wordt ___ ___ verkocht. (Respuesta: vers brood, sin een.)'
WHERE id = 1068
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';

-- =============================================================================
-- 1a. La 1033: idee o gedachte, het o dat, goede o goeie
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: ¿Por que no Het is een goeie idee? ¿Cuando gedachte? ¿Y cuando goeie en vez de goede?

🔑 Son tres preguntas y la segunda esconde el fallo de verdad: idee es palabra HET, no de. Y con een, un het-woord lleva el adjetivo SIN -e. Asi que no es «een goeie idee» ni «een goede idee», sino een goed idee.

| forma | ¿correcta? | por que |
|---|---|---|
| een **goed** idee | ✔ | idee es het → con een, adjetivo sin -e |
| een goede idee | ✘ | la -e delata un de-woord, y idee no lo es |
| een **goede** gedachte | ✔ | gedachte es de → con een, adjetivo con -e |
| het **goede** idee | ✔ | con het delante, la -e vuelve siempre |

🪞 Es justo lo que dice el bloque del adjetivo delator, aqui en accion: si dudas del articulo, mira la -e. een goed idee te esta diciendo que idee es het.

🎭 Y ahora idee o gedachte, que no son lo mismo:
• het idee — la idea como ocurrencia, propuesta o plan. Es la de reaccionar a lo que alguien propone: Goed idee! Dat is een goed idee.
• de gedachte — el pensamiento, lo que te pasa por la cabeza. Mas interior y reflexivo: in gedachten zijn (estar absorto), van gedachten veranderen (cambiar de opinion).
Para contestar a una propuesta, lo normal es Goed idee! La frase de esta tarjeta es correcta, pero suena algo mas pensativa.

🎚️ Het is o Dat is: las dos valen, y es el mismo par atono/tonico de er y daar. dat SEÑALA lo que se acaba de decir y es lo natural para reaccionar: Dat is een goed idee. het es atono y funciona cuando el asunto ya esta en el aire. Por eso la tarjeta usa Dat.

🗣️ Y goede o goeie: goede es la forma ESCRITA y estandar; goeie es su contraccion HABLADA, correctisima al hablar y fuera de lugar en un texto. Pasa con toda la familia: goede/goeie, oude/ouwe, rode/rooie, koude/kouwe. Lo veras clarisimo en el saludo: Goedemorgen se escribe asi, pero por la calle oiras Goeiemorgen.

🏋️ Ejercicio: «es una buena idea» en la version mas corriente → Dat is een ___ idee. (Respuesta: goed, sin -e, porque idee es het.)'
WHERE id = 1033
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';

-- =============================================================================
-- 1b. La 1041: la cara opuesta de la misma regla
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: ¿Que regla me salto? ¿Por que siempre een? ¿No podria ser We zoeken woning?

🔑 No, y la regla es la misma que la de kaas pero vista del reves. de woning es un sustantivo CONTABLE: una vivienda, dos viviendas, tres viviendas. Y en neerlandes un contable en SINGULAR nunca va desnudo: exige een, de o un posesivo. Por eso We zoeken woning esta mal.

⚠️ Aqui esta la trampa, porque en español no se nota: buscamos vivienda y buscamos trabajo suenan igual, los dos sin articulo. En neerlandes se separan, y la frontera es si la cosa se cuenta.

| frase | por que |
|---|---|
| We zoeken **een** woning. | woning se cuenta → contable singular → necesita determinante |
| We zoeken woning**en**. | en plural ya no hace falta |
| We zoeken werk. | werk no se cuenta → materia → va desnudo |
| Hier wordt goede kaas verkocht. | kaas no se cuenta → materia → va desnudo |

🪞 Fijate en que en este mismo grupo tienes las dos: la 1041 con een woning y la del sustantivo het werk sin nada. No es capricho, es que una se cuenta y la otra no.

🚧 Y las tres excepciones en que un contable SI va desnudo: las profesiones con zijn o worden (Ik ben leraar, sin een), las locuciones fijas (naar school, op kantoor, in bed, aan tafel) y los pares (man en vrouw). Fuera de eso, determinante siempre.

🏋️ Ejercicio: «busco piso» (contable) y «busco trabajo» (materia) → Ik zoek ___ appartement. Ik zoek ___ werk. (Respuestas: een · nada.)'
WHERE id = 1041
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';

-- =============================================================================
-- 1c. La 1043: het eten o de maaltijd
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: ¿Por que no De maaltijd is klaar?

🔑 Si puede, es correcto. Lo que cambia no es la gramatica sino el REGISTRO. het eten es la comida de todos los dias, lo que se va a comer, y Het eten is klaar! es lo que se grita desde la cocina. de maaltijd es la comida como acto o como racion, y suena formal: es la palabra de las residencias, los hospitales, el catering y la nutricion. En una casa nadie dice De maaltijd is klaar.

🍽️ Todas las maneras de decir comida, que en español son casi la misma palabra:

| neerlandes | que es | ejemplo |
|---|---|---|
| **het eten** | la comida diaria, lo cotidiano | **Het eten** is klaar! |
| **de maaltijd** | la comida como acto o racion, formal | een gezonde **maaltijd** |
| **het gerecht** | el plato, la preparacion concreta | het **gerecht** van de dag |
| **het voedsel** | el alimento, la sustancia | **voedsel** en water |
| **de hap** | el bocado | een **hapje** eten (picar algo) |

🕐 Y las comidas del dia, con su articulo, que tampoco estaban en tu mazo:
• het ontbijt — el desayuno. ontbijten es desayunar.
• de lunch of het middageten — el almuerzo.
• het avondeten of het diner — la cena. diner es el mas formal.
• het tussendoortje — el tentempie, con het por el diminutivo.

💬 Y una nota cultural: en Paises Bajos se cena PRONTO, sobre las seis, y het avondeten es la comida caliente del dia. El almuerzo suele ser un bocadillo frio, de boterham, comido en veinte minutos. Si te invitan om zes uur, es a cenar.

🏋️ Ejercicio: «el plato del dia» → het ___ van de dag. (Respuesta: gerecht.)'
WHERE id = 1043
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';

-- =============================================================================
-- 2. Bloque A: cuando lleva een y cuando no
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧀 Cuando lleva een y cuando no:

Es la misma regla vista por sus dos caras, y decide casi todos los casos: lo CONTABLE en singular exige determinante, y lo INCONTABLE puede ir desnudo.

| tipo | en singular | ejemplo |
|---|---|---|
| **contable** | SIEMPRE con een, de o posesivo | We zoeken **een** woning. |
| **contable en plural** | puede ir desnudo | We zoeken **woningen**. |
| **materia o abstracto** | puede ir desnudo | We zoeken **werk**. Hier wordt **goede kaas** verkocht. |

⚠️ Y ahi esta la trampa para un hispanohablante: en español buscamos vivienda y buscamos trabajo se dicen igual, los dos sin articulo. En neerlandes no, porque woning se cuenta (una vivienda, dos viviendas) y werk no. Por eso «We zoeken woning» esta mal y We zoeken werk esta bien.

📦 Y la materia, con een, deja de ser sustancia y pasa a ser una unidad:

| sin articulo, es sustancia | con een, es una unidad |
|---|---|
| Hier wordt **goede kaas** verkocht. | Ik heb **een kaas** gekocht. (una pieza) |
| Ik eet **brood**. | Ik heb **een brood** gekocht. (una hogaza) |
| Wil je **koffie**? | Ik zou graag **een koffie** willen. (una taza) |
| Ik drink **water**. | Mag ik **een water**? (un vaso, en un bar) |

🚧 Las excepciones en que un contable SI va desnudo, y son pocas pero muy usadas:
• Profesiones y roles con zijn o worden — Ik ben leraar. Hij wordt dokter. Sin een. Pero en cuanto metes un adjetivo vuelve: Hij is EEN goede leraar.
• Locuciones fijas de lugar y rutina — naar school, op kantoor, in bed, aan tafel, naar huis, met de trein.
• Pares y enumeraciones — man en vrouw, dag en nacht.

🪞 En tu propio mazo esta el par que lo demuestra: la 290 (Zal ik koffie zetten?) y la 420 (Er is koffie in de keuken) van sin articulo, y la 317 (Ik zou graag een koffie willen) lleva een. Misma palabra, dos comportamientos segun sea sustancia o taza.

📏 Y cuando quieres contar la sustancia, se mide con un envase o una porcion delante:
• een stuk kaas — un trozo de queso.
• een glas melk — un vaso de leche.
• een kopje koffie — una taza de café.
• een fles water — una botella de agua.
• een snee brood — una rebanada de pan.
Fijate en que la medida NO lleva van: es een glas melk y no «een glas van melk».

🍺 En los bares se pide con DIMINUTIVO, y eso convierte la sustancia en unidad automaticamente: een biertje (una caña), een wijntje (un vino), een colaatje. Y como todo diminutivo acaba en -je, siempre es het: het biertje.

🔑 El truco: Pregunta si puedes contarlo tal cual. ¿Un queso, dos quesos? Entonces es unidad y lleva een. ¿Queso a secas, como sustancia? Sin articulo. Y si necesitas contarlo pero no se deja, mete una medida delante.'
-- Parentesis a proposito: AND liga mas que OR, y sin ellos los dos guards de abajo
-- solo se aplicarian a la rama del notes, dejando la del id sin proteger.
WHERE (id IN (
    SELECT wl.word_es_id FROM words_lang wl
    WHERE wl.lang_code = 'nl_NL'
      AND (lower(' ' || wl.text || ' ') LIKE '% kaas %'
           OR lower(' ' || wl.text || ' ') LIKE '% kaas.%'
           OR lower(' ' || wl.text || ' ') LIKE '% brood %'
           OR lower(' ' || wl.text || ' ') LIKE '% brood.%'
           OR lower(' ' || wl.text || ' ') LIKE '% melk %'
           OR lower(' ' || wl.text || ' ') LIKE '% melk.%'
           OR lower(' ' || wl.text || ' ') LIKE '% water %'
           OR lower(' ' || wl.text || ' ') LIKE '% water.%'
           OR lower(' ' || wl.text || ' ') LIKE '% koffie %'
           OR lower(' ' || wl.text || ' ') LIKE '% koffie.%'
           OR lower(' ' || wl.text || ' ') LIKE '% koffie?%'
           OR lower(' ' || wl.text || ' ') LIKE '% thee %'
           OR lower(' ' || wl.text || ' ') LIKE '% thee.%'
           OR lower(' ' || wl.text || ' ') LIKE '% drank %'
           OR lower(' ' || wl.text || ' ') LIKE '% drank.%'
           OR lower(' ' || wl.text || ' ') LIKE '% geld %'
           OR lower(' ' || wl.text || ' ') LIKE '% geld.%')
)
  -- y todo el grupo 40, que es donde viven las cuatro dudas de Eduardo y donde
  -- conviven contables (een woning) e incontables (werk, kaas, eten)
  OR notes LIKE 'Verbo frecuente: %')
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧀 Cuando lleva een%';

-- =============================================================================
-- 3. Bloque B: las cinco maneras del "se" español
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🔁 Las cinco maneras de decir el se español:

El español resuelve con un se lo que el neerlandes reparte en cinco construcciones. Todas dicen aqui se vende queso, pero no suenan igual.

| construccion | como suena | ejemplo |
|---|---|---|
| **ze** + activa | coloquial, con un ellos difuso | **Ze** verkopen hier goede kaas. |
| **worden** + participio | neutra, la de los carteles | Hier **wordt** goede kaas **verkocht**. |
| **er wordt** + participio | pasiva sin sujeto, muy holandesa | **Er wordt** hier hard **gewerkt**. |
| **je** generico | cercana, hablando de posibilidades | Hier kun **je** goede kaas kopen. |
| **men** | formal y escrita, casi de informe | **Men** zegt dat hij rijk is. |

⚠️ La que mas cuesta a un hispanohablante es la tercera: er wordt + participio no tiene sujeto ninguno y traduce el se impersonal puro. Er wordt gebeld es llaman a la puerta, sin que nadie sea el sujeto. Es de las cosas mas caracteristicas del neerlandes.

🔑 El truco para elegir: ¿Hablas con un amigo? ze. ¿Escribes un cartel o describes algo? worden. ¿No hay ni objeto ni sujeto, solo la accion? er wordt. ¿Le explicas a alguien lo que puede hacer? je. ¿Redactas algo formal? men, y con cuidado, que suena antiguo.

📐 Y el orden en la pasiva: worden se conjuga en su sitio de siempre (2a posicion) y el participio se va AL FINAL. Hier WORDT goede kaas VERKOCHT. En perfecto entra un is y worden se vuelve geworden, que en pasiva se acorta a is verkocht.'
WHERE (
    id = 1068
    OR id IN (SELECT word_es_id FROM word_es_groups WHERE group_id = 23)
    OR id IN (
        SELECT wl.word_es_id FROM words_lang wl
        WHERE wl.lang_code = 'nl_NL' AND lower(wl.text) LIKE '%er wordt%'
    )
)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🔁 Las cinco maneras%';
