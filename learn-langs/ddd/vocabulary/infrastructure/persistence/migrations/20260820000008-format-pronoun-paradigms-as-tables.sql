-- Learn Languages App - Los paradigmas de pronombres, en TABLA
-- Migration: 20260820000008-format-pronoun-paradigms-as-tables.sql
-- Description: los paradigmas iban apretados en una sola linea («ik→me/mij · jij→je/jou ·
--   hij→(’m)/hem …») y se leian fatal. Ahora que la ayuda se pinta en markdown, pasan a
--   TABLA y —esto es lo que pedia Eduardo— con UN EJEMPLO POR FORMA, para ver cada
--   pronombre en una frase de verdad y no solo en el listado.
--   (a) atono/tonico: 13 tarjetas del grupo 19, tabla persona / atona + ejemplo / tonica +
--       ejemplo, con las reducidas ’m y ’r marcadas como habla rapida.
--   (b) reflexivos: 15 tarjetas del grupo 17, tabla persona / reflexivo / ejemplo, cada uno
--       con la frase de una tarjeta real del grupo.
--   (c) 643: el bloque de hun, que era una linea con cuatro ideas encajadas, se reorganiza en
--       tabla por FUNCION (indirecto hun · coloquial ze · directo hen · tras preposicion hen ·
--       sujeto zij/ze) + los dos avisos (hun no es sujeto; hun posesivo si existe) + el truco.
--   (d) 562: su lista de pronombres de objeto pasa tambien a tabla espanol / neerlandes /
--       ejemplo.
--   Requiere el cambio en RulesHelpMarkdownFormatter del mismo dia: antes, una sola linea que
--   empezara por «|» hacia que TODA la ayuda se devolviera sin convertir. Ahora las filas de
--   tabla se copian literales y el resto se sigue formateando.
--   Solo UPDATE de rules_help. IDEMPOTENTE: el REPLACE busca el texto viejo, que tras la
--   primera pasada ya no existe.

-- atono/tonico (13 tarjetas del grupo 19)
UPDATE words_es
SET rules_help = REPLACE(rules_help, 'Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.', 'Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa.
• tónica (plena) — para ÉNFASIS o contraste, y SIEMPRE tras preposición (aan, voor, met, op…).

| persona | átona | ejemplo con la átona | tónica | ejemplo con la tónica |
|---|---|---|---|---|
| ik | **me** | Kun je **me** even helpen? | **mij** | Geef het maar aan **mij**. |
| jij | **je** | Ik bel **je** straks. | **jou** | Dit is voor **jou**. |
| hij | **’m** | Ik zie **’m** morgen wel. | **hem** | Ik vertrouw **hem** niet. |
| zij (ella) | **’r** | Ik heb **’r** net gebeld. | **haar** | Ik heb **haar** net gesproken. |
| u | *no tiene* | — | **u** | Wat kan ik voor **u** doen? |
| wij | *no tiene* | — | **ons** | Hij heeft **ons** uitgenodigd. |
| jullie | *no tiene* | — | **jullie** | Ik heb **jullie** gemist. |
| zij (pl) | **ze** | Ik zie **ze** bijna elke dag. | **hen** / **hun** | Ik denk vaak aan **hen**. · Ik heb **hun** een kaartje gestuurd. |

Las formas ’m y ’r son de habla rápida: se escriben poco, se oyen todo el rato.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.')
WHERE instr(COALESCE(rules_help, ''), 'Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.') > 0;

-- reflexivos (15 tarjetas del grupo 17)
UPDATE words_es
SET rules_help = REPLACE(rules_help, 'Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).', 'Pronombres reflexivos, uno por persona:

| persona | reflexivo | ejemplo |
|---|---|---|
| ik | **me** | Ik voel **me** niet lekker. |
| jij / je | **je** | Haast **je** een beetje! |
| u | **zich** (también **u**) | Ontspant **u zich** maar. |
| hij / zij / het | **zich** | Hij vergist **zich**. |
| wij | **ons** | We verheugen **ons** op de vakantie. |
| jullie | **je** | Jullie vergissen **je**. |
| zij / ze (pl) | **zich** | De kinderen vervelen **zich**. |

El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).')
WHERE instr(COALESCE(rules_help, ''), 'Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).') > 0;

-- 643 - el bloque de hun
UPDATE words_es
SET rules_help = REPLACE(rules_help, 'hun = objeto INDIRECTO de personas (les, a ellos), sin preposición — iets sturen aan iemand. Coloquial: ze. El directo (los) es hen. Ojo: hun como SUJETO (hun hebben…) está mal.', 'hun = objeto INDIRECTO de personas: «les, a ellos», sin preposición delante.

| función | forma | ejemplo |
|---|---|---|
| indirecto (les) | **hun** | Ik heb **hun** een kaartje gestuurd. |
| indirecto, coloquial | **ze** | Ik heb **ze** een kaartje gestuurd. |
| directo (los, las) | **hen** | Ik zie **hen** morgen. |
| tras preposición | **hen** | Ik denk vaak aan **hen**. |
| sujeto (ellos) | **zij / ze** | **Zij** hebben gebeld. |

⚠️ hun NUNCA es sujeto: «hun hebben gebeld» está mal, por mucho que se oiga; es zij/ze hebben gebeld.
⚠️ Ojo, hun también es el POSESIVO «su, de ellos» (hun huis = su casa), y ese sí es correcto. Son dos palabras distintas que se escriben igual.
🧠 Truco: si en español puedes meter «a ellos» delante (a ellos les mandé una postal), es hun; si es «los/las» directo o va detrás de preposición, hen. Y al hablar, casi todo el mundo dice ze.')
WHERE instr(COALESCE(rules_help, ''), 'hun = objeto INDIRECTO de personas (les, a ellos), sin preposición — iets sturen aan iemand. Coloquial: ze. El directo (los) es hen. Ojo: hun como SUJETO (hun hebben…) está mal.') > 0;

-- 562 - pronombres de objeto
UPDATE words_es
SET rules_help = REPLACE(rules_help, 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze', 'Pronombres de objeto (lo, la, le, los, las, les...):

| español | neerlandés | ejemplo |
|---|---|---|
| me | **me** / **mij** | Kun je **me** helpen? |
| te | **je** / **jou** | Ik bel **je** straks. |
| le, lo (usted) | **u** | Ik heb **u** gebeld. |
| lo, le (él) y cosas de-woord | **hem** | Ik vertrouw **hem** niet. |
| la, le (ella) | **haar** | Ik heb **haar** gesproken. |
| lo (cosas het-woord) | **het** | Ik heb **het** gezien. |
| nos | **ons** | Hij heeft **ons** uitgenodigd. |
| os | **jullie** | Ik heb **jullie** gemist. |
| los, las (plural) | **ze** | Ik zie **ze** elke dag. |
| los (directo, cuidado) | **hen** | Ik zie **hen** morgen. |
| les (indirecto) | **hun** | Ik heb **hun** geschreven. |

Para COSAS manda el artículo: de-woord → **hem** · het-woord → **het** · plural → **ze**')
WHERE instr(COALESCE(rules_help, ''), 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze') > 0;

-- 636 · vertrouwen: reflexivo en español, NO en neerlandés (y transitivo directo)
UPDATE words_es
SET rules_help = REPLACE(rules_help, '📐 Oración principal (hoofdzin)', '🤝 «Fiarse de» lleva «se» en español, pero vertrouwen no lo lleva en neerlandés:
El español mete aquí dos cosas que en neerlandés sobran: el «me» y la preposición «de». Y encima vertrouwen es TRANSITIVO DIRECTO. Ik vertrouw hem niet = no me fío de él. Ni reflexivo, ni van/in.
• vertrouwen + objeto DIRECTO = fiarse de alguien. Ik vertrouw hem · Ze vertrouwt haar collega niet.
• vertrouwen OP = contar con, apoyarse en. Ik vertrouw op jou · Je kunt op hem vertrouwen.
• vertrouwen hebben IN = tener confianza en (con el sustantivo). Ik heb veel vertrouwen in dit team.
• toevertrouwen = confiar algo a alguien (separable). Ik vertrouw je mijn sleutel toe.
Familia: het vertrouwen (la confianza) · wantrouwen (desconfiar y desconfianza) · betrouwbaar (fiable) · onbetrouwbaar (poco de fiar) · vertrouwelijk (confidencial) · vertrouwd (familiar, de toda la vida).
🔁 Más verbos con «se» en español que en neerlandés no lo llevan (no les pongas me/je/zich):
• levantarse = opstaan · despertarse = wakker worden · dormirse = in slaap vallen · acostarse = naar bed gaan
• caerse = vallen · irse = weggaan, vertrekken · quedarse = blijven · sentarse = gaan zitten
• mudarse = verhuizen · casarse = trouwen · divorciarse = scheiden · ducharse = douchen
• reírse de = lachen om · quejarse de = klagen over · atreverse a = durven · asustarse = schrikken
• acostumbrarse a = wennen aan · enamorarse de = verliefd worden op · resfriarse = verkouden worden
⚠️ Y al revés, para que no te pases de listo: hay verbos neerlandeses con zich que en español no llevan «se» — zich herinneren (recordar), zich verheugen op (hacer ilusión), zich bevinden (estar situado), zich bemoeien met (meterse en). Ahí el reflexivo es obligatorio.
🏋️ Ejercicio: «no me fío de ella» → Ik vertrouw ___ niet. (Respuesta: haar. Sin reflexivo y sin preposición.)

📐 Oración principal (hoofdzin)')
WHERE id = 636
  AND instr(COALESCE(rules_help, ''), '📐 Oración principal (hoofdzin)') > 0
  AND COALESCE(rules_help, '') NOT LIKE '%🤝%';
