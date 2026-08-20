-- Learn Languages App - Ayudas 637 (régimen de spreken) y 632 (imperativo pelado)
-- Migration: 20260820000011-help-spreken-637-and-imperative-politeness-632.sql
-- Description:
--   (a) 637 · por que no se dice «Ik heb tegen haar (nog) gesproken». Por dos motivos que se
--       suman: spreken con una PERSONA es TRANSITIVO (iemand spreken, sin preposicion) y su
--       preposicion es met, nunca tegen — tegen es de zeggen y de praten; y ademas el ORDEN
--       estaba cambiado (el pronombre objeto va pegado al verbo, el sintagma con preposicion
--       se va a la derecha, detras de los adverbios de tiempo). Tabla de regimen de los
--       verbos de hablar, el matiz de «iemand spreken» = dar con alguien y hablar con el, y
--       la regla de que un idioma se SPREEKT, nunca se praat.
--   (b) 632 · que se entiende por «Geef het aan mij» sin el maar. NO es grosero: es una orden
--       PELADA, y en neerlandes el imperativo desnudo es mucho mas normal que en espanol. Lo
--       que puede sonar exigente es la mezcla de orden pelada + «aan MIJ» tonico (que ya de
--       por si contrasta: a MI y no a otro). Tabla con la escalera entera, de «Geef het me»
--       a «Zou je het aan mij willen geven?», mas donde si chirria (pedir en un bar a un
--       desconocido: se dice Doe mij maar een koffie o Mag ik een koffie?), donde no pasa
--       nada (familia, prisa) y lo que si es brusco de verdad (Geef hier! / Geef op!).
--   (c) Arreglo de formato en el bloque 🙋 de la 20260820000005: la linea de «erzelf» acababa
--       en «:» con 207 caracteres, asi que el conversor la pintaba como un ENCABEZADO enorme.
--       Se parte en rotulo corto + parrafo. Afecta a las 15 tarjetas del grupo de reflexivos.
--   Leccion de redaccion aprendida aqui: fuera de las tablas NO se pueden usar negritas con
--   **, porque el conversor escapa `*` (saldria \*\*asi\*\*); y una linea de aviso que acaba
--   en «:» deja de ser cita y se vuelve encabezado. Ver [[learn-langs-code]].
--   Solo UPDATE de rules_help. IDEMPOTENTE por emoji-guarda.
--   Escrita fuera de migrations/ y movida ya terminada.

-- ==============================================================================
-- 637 · el régimen de spreken (y por qué no «tegen haar»)
-- ==============================================================================
UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '📐 Oración principal (hoofdzin)',
    '🗣️ ¿Y por qué no «Ik heb tegen haar gesproken»?:
Porque spreken, cuando lo que sigue es una PERSONA, es TRANSITIVO: iemand spreken = hablar con alguien, sin preposición ninguna. Ik heb haar gesproken. La preposición que sí admite spreken es met; tegen no es suya, es de zeggen y de praten.

| verbo | régimen | ejemplo |
|---|---|---|
| **spreken** | objeto directo (persona) | Ik heb **haar** gesproken. |
| **spreken met** | met | Ik heb **met haar** gesproken. |
| **spreken over** | over (el tema) | We spraken **over** het werk. |
| **spreken tot** | tot (formal, dirigirse a un público) | De koning sprak **tot** het volk. |
| **praten met** | met (charlar con) | Ik wil even **met jou** praten. |
| **praten tegen** | tegen (hablarle A, casi de un solo lado) | Hij praat **tegen** de hond. |
| **zeggen tegen** | tegen — aquí sí vive el tegen | Ik heb **tegen haar** gezegd dat ik kom. |
| **vertellen** | aan, o directo | Ik heb het **aan haar** verteld · Ik heb het **haar** verteld. |

⚠️ Y tu frase llevaba además el ORDEN cambiado: el pronombre objeto va pegado al verbo, mientras que el sintagma con preposición se marcha a la derecha, detrás de los adverbios de tiempo.
• Ik heb haar net nog gesproken. ✓ — pronombre, pegado al verbo.
• Ik heb net nog met haar gesproken. ✓ — preposición, a la derecha.
• «Ik heb tegen haar nog gesproken» ✗ — preposición equivocada y encima adelantada.
🎯 Matiz de iemand spreken: no es solo «hablar», es «dar con alguien y hablar con él». Es lo que se dice en el trabajo y por teléfono: Ik heb hem vanochtend nog gesproken (he hablado con él esta mañana) · Kan ik meneer Jansen spreken? (¿puedo hablar con el señor Jansen?) · Spreek ik met Anna? (¿hablo con Anna?).
📚 Ojo con los idiomas: un idioma se SPREEKT, nunca se praat — Ik spreek Nederlands. praten es charlar; spreken es hablar, y es el de los idiomas y los discursos (een toespraak houden).

📐 Oración principal (hoofdzin)'
)
WHERE id = 637
  AND rules_help LIKE '%📐 Oración principal (hoofdzin)%'
  AND rules_help NOT LIKE '%🗣️%';

-- ==============================================================================
-- 632 · «Geef het aan mij» sin maar: ¿grosero? No, seco
-- ==============================================================================
UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '📐 Imperativo:',
    '🎚️ ¿Y «Geef het aan mij» a secas? Ni grosero ni cortés: seco:
Sin partícula no es un insulto, es una ORDEN pelada. El imperativo desnudo en neerlandés es mucho más normal que en español y entre familia o amigos no molesta; lo que lo vuelve brusco es soltárselo a un desconocido o usarlo donde se espera una pregunta.
Y fíjate en el detalle que ya trae esta tarjeta: aan MIJ es tónico, así que encima suena a contraste — «dámelo A MÍ, y no a otro». Esa mezcla, orden pelada más contraste, es la que puede sonar exigente.

| lo que dices | cómo suena |
|---|---|
| Geef het me. | lo neutro de verdad, sin contraste |
| Geef het aan mij. | orden seca + «a MÍ, no a otro» |
| Geef het maar aan mij. | venga, dámelo — amable, te quitas un marrón (el de esta tarjeta) |
| Geef het even aan mij. | pásamelo un momento, cosa pequeña |
| Geef het maar even aan mij. | lo más suave que da el imperativo |
| Kun je het aan mij geven? | ya es petición, no orden |
| Zou je het aan mij willen geven? | claramente cortés |
| Mag ik het even? | cortés y cortísimo, se usa muchísimo |

🏪 Dónde sí chirría: pedir a un desconocido o en un bar con imperativo pelado. Nadie dice «Geef mij een koffie»; se dice Doe mij maar een koffie o Mag ik een koffie? Y de usted, Kunt u… / Zou u…
😐 Dónde no pasa nada: con familia, amigos o con prisa — Geef het aan mij, snel! suena a urgencia, no a mala educación.
🚫 Lo que sí es brusco de verdad: Geef hier! o Geef op! (¡trae aquí!, ¡suelta eso!). Ahí no hay cortesía que valga: es reproche o autoridad.
🏋️ Ejercicio: «pásamelo un momento, venga» → Geef het ___ ___ aan mij. (Respuesta: maar even, en ese orden fijo.)

📐 Imperativo:'
)
WHERE id = 632
  AND rules_help LIKE '%📐 Imperativo:%'
  AND rules_help NOT LIKE '%🎚️%';

-- ==============================================================================
-- Formato: la línea de «erzelf» era un encabezado de 207 caracteres (15 tarjetas)
-- ==============================================================================
UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '⚠️ «erzelf» NO existe. er es el pronombre de COSA que sustituye a het/dat delante de preposición (ermee, eraan, erover) y no admite -zelf. Si lo que buscas es «solo, por sí mismo», tienes otras dos palabras:',
    '⚠️ «erzelf» no existe:
er es el pronombre de COSA que sustituye a het/dat delante de preposición (ermee, eraan, erover) y no admite -zelf. Si lo que buscas es «solo, por sí mismo», tienes otras dos palabras:'
)
WHERE instr(COALESCE(rules_help, ''), '⚠️ «erzelf» NO existe. er es el pronombre de COSA') > 0;
