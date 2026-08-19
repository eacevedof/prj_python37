-- Learn Languages App - Ayudas: perfecto/imperfecto (690) + hoeven reflexivo (675)
--                        + zien vs kijken (641) + komen vs aankomen (621)
--                        + singular de medida tras numero (627)
--                        + haast je vs schiet op y particulas del imperativo (601)
--                        + niet lekker vs niet goed y el mapa de lekker (598)
-- Migration: 20260818000001-help-blocks-690-680-675-641-621.sql
-- Description: Eduardo (690 "Ik werd vroeg wakker" = me desperte temprano) pregunta si no
--   podria ser "Ik ben vroeg wakker geworden". Si: las dos son correctas. Bloque 🗓️ con el
--   reparto: worden pertenece al grupo (zijn/hebben/worden/modales) que MANTIENE el
--   imperfecto en el neerlandes hablado, asi que "werd" es lo normal; el perfecto es
--   correcto pero pide un complemento de tiempo o una consecuencia detras. Auxiliar ZIJN
--   (cambio de estado) y "wakker" suelto delante del participio. Aviso: no confundir con
--   opstaan (salir de la cama). El bloque se inserta ANTES del cierre 📐/🧭/🏋️ para que la
--   tarjeta conserve su estructura, y el ejercicio final absorbe el caso nuevo.
--   De paso, la 680 (vergeten, mismo eje perfecto/imperfecto) listaba los verbos que se
--   quedan en imperfecto sin incluir worden: se anade worden/werd para que las dos ayudas
--   cuenten lo mismo.
--   Se anade tambien el bloque 🛏️ con la FAMILIA completa (wakker worden/zijn/maken/schrikken/
--   liggen, opstaan, uitslapen, zich verslapen, in slaap vallen, de wekker zetten), su
--   auxiliar y la secuencia de la noche: la duda del tiempo verbal era el sintoma, el hueco
--   era el reparto del verbo (criterio de Eduardo 2026-08-18: no quedarse en la pregunta).
--   Ademas (675 "Je hoeft niet te komen als je moe bent"): Eduardo pregunta por que la 676
--   dice "Je hoeft je geen zorgen te maken" y esta no lleva ese segundo je, si es
--   reflexivo en una y no en otra. Bloque 🪞: el reflexivo NO lo pone hoeven, lo pide el
--   verbo principal (komen no es reflexivo; zich zorgen maken si). Truco: quitar hoeven y
--   mirar la frase base. Y niet niega el verbo mientras geen niega un sustantivo (zorgen).
--   La 676 ya tenia su bloque 🪞 desde el lado reflexivo; este es el lado contrario.
--   Ultima migracion ya aplicada -> migracion nueva, con los tres UPDATE fusionados en el
--   mismo .sql (sigue pendiente). Keyeadas por id, idempotentes (guarda por texto), solo
--   UPDATE de rules_help.
--   Y (641 "Ik zie ze bijna elke dag"): Eduardo pregunta si valdria "Ik kijk ze bijna elke
--   dag" y que se entenderia con kijk. Bloque 👀: con personas NO vale, y el fallo no es el
--   pronombre sino el verbo — zien es TRANSITIVO (Ik zie ze) mientras kijken es
--   INTRANSITIVO y pide naar (Ik kijk naar hen); el transitivo de la familia es bekijken
--   (be- transitiviza, como antwoorden op -> beantwoorden). Aunque se arregle con naar,
--   cambia el significado (mirar a proposito, de unos vecinos suena a vigilarlos). Matiz de
--   uso real: con MEDIOS (series/pelis) el coloquial si dice "Ik kijk ze", por eso la frase
--   se entenderia, pero como "las veo en la tele", no como personas.
--   Y (621 "Jij bent te laat gekomen"): Eduardo pregunta que se entenderia con "Jij bent te
--   laat aangekomen" y cuando toca cada verbo para "llegar". Bloque 🚆: las dos son
--   correctas y ambas con ZIJN, pero cambia el foco — te laat KOMEN = presentarse tarde a
--   una cita (colocacion fija del reproche), te laat AANKOMEN = llegar tarde al destino de
--   un trayecto (suena a parte de viaje). Mapa del "llegar": komen (cita) · aankomen
--   (destino, separable, con in/op/bij y nunca naar; sustantivo aankomst) · thuiskomen
--   (a casa) · bereiken (alcanzar, transitivo con hebben). Mas los otros sentidos de
--   aankomen: engordar, het komt erop aan, aankomen met (venir con excusas).

PRAGMA foreign_keys = ON;

-- 690 · el bloque nuevo entra justo antes del cierre "📐 Pasado:"
UPDATE words_es SET rules_help = REPLACE(
    rules_help,
    '📐 Pasado:',
    '🗓️ ¿Y «Ik ben vroeg wakker geworden»? — también es correcto.
Las dos formas valen; cambia el registro, no la gramática.
• Auxiliar: wakker worden es CAMBIO DE ESTADO → perfecto con ZIJN. Ik BEN vroeg wakker geworden ✓ · Ik heb ... geworden ✗.
• Orden: wakker va suelto, delante del participio, al final de la frase → Ik ben vroeg wakker geworden.
• Ik werd vroeg wakker = imperfectum. Es lo normal aquí, por dos motivos: (a) worden entra en el grupo que MANTIENE el imperfecto al hablar (zijn, hebben, worden y los modales: was, had, werd, kon, moest, wilde), donde otros verbos saltarían al perfecto; (b) sirve para narrar: Ik werd vroeg wakker, ik stond op en ik zette koffie.
• Ik ben vroeg wakker geworden = perfecto. Correcto, pero pide algo alrededor: un complemento de tiempo concreto o una consecuencia detrás. Ik ben vanochtend vroeg wakker geworden, dus ik ben moe (me he despertado pronto esta mañana, así que estoy cansado).
• En español: werd ≈ me desperté · ben ... geworden ≈ me he despertado.
⚠️ No lo mezcles con opstaan (levantarse, salir de la cama), que también va con zijn: Ik ben vroeg opgestaan = me levanté pronto · Ik werd vroeg wakker = abrí los ojos pronto (puedes seguir en la cama).

📐 Pasado:'
)
WHERE id = 690 AND COALESCE(rules_help,'') NOT LIKE '%wakker geworden»?%';

-- 690 · el ejercicio final pasa a pedir tambien el perfecto
UPDATE words_es SET rules_help = REPLACE(
    rules_help,
    '🏋️ Ejercicio: «Estoy despierto» → Ik ___ wakker. · «Me desperte» → Ik ___ wakker. (Respuestas: ben / werd.)',
    '🏋️ Ejercicio: «Estoy despierto» → Ik ___ wakker. · «Me desperte» → Ik ___ wakker. · «Me he despertado pronto esta manana» → Ik ___ vanochtend vroeg wakker ___. (Respuestas: ben / werd / ben ... geworden.)'
)
WHERE id = 690 AND COALESCE(rules_help,'') LIKE '%🏋️ Ejercicio: «Estoy despierto» → Ik ___ wakker. · «Me desperte» → Ik ___ wakker. (Respuestas: ben / werd.)%';

-- 680 · worden entra en la lista de verbos que se quedan en imperfecto al hablar
UPDATE words_es SET rules_help = REPLACE(
    rules_help,
    'hebben/zijn/modales — was, had, kon, moest, wilde',
    'hebben/zijn/worden/modales — was, had, werd, kon, moest, wilde'
)
WHERE id = 680 AND COALESCE(rules_help,'') LIKE '%hebben/zijn/modales — was, had, kon, moest, wilde%';

-- 675 · por que hoeven no arrastra reflexivo (contraste con la 676)
UPDATE words_es SET rules_help = rules_help || '

🪞 ¿Por qué la 676 lleva un «je» de más (Je hoeft JE geen zorgen te maken) y esta no?
Porque el reflexivo NO lo pone hoeven: lo pide el VERBO principal. hoeven solo añade «no hace falta» + te; no toca los pronombres.
• komen (venir) no es reflexivo → Je hoeft niet te komen. Un solo je, el SUJETO.
• zich zorgen maken (preocuparse) sí lo es, el pronombre es parte fija del verbo → Je hoeft je geen zorgen te maken. Dos je: 1º sujeto (jij) y 2º reflexivo (zich → je para jij).
Truco: quita hoeven y mira la frase base. Je komt (sin reflexivo) · Je maakt je zorgen (con reflexivo). Lo que había en la base, sigue estando.
⚠️ Y ojo a la negación, que también cambia: niet niega el verbo (niet te komen); geen niega un SUSTANTIVO (geen zorgen). Por eso aquí va niet y en la 676 geen.
Reflexivos frecuentes que se comportan igual: zich haasten (darse prisa), zich vergissen (equivocarse), zich voelen (sentirse), zich herinneren (acordarse), zich aankleden (vestirse), zich vervelen (aburrirse). Con hoeven: Je hoeft je niet te haasten (no hace falta que te des prisa).'
WHERE id = 675 AND COALESCE(rules_help,'') NOT LIKE '%🪞%';

-- 641 · zien (transitivo) vs kijken naar (intransitivo) vs bekijken
UPDATE words_es SET rules_help = rules_help || '

👀 ¿Y «Ik kijk ze bijna elke dag»? Con personas no vale
El problema no es el pronombre, es el verbo. En neerlandés el «ver/mirar» español se reparte, y además cambia la construcción:
• zien = VER (percibir, encontrarse con alguien). Es TRANSITIVO: lleva objeto directo pegado, sin preposición → Ik zie ze. Es el de esta tarjeta.
• kijken = MIRAR (dirigir la vista a propósito). Es INTRANSITIVO: pide la preposición naar → Ik kijk naar ze / naar hen. «Ik kijk ze» sin naar es agramatical.
• bekijken = mirar/examinar algo entero. Este SÍ es transitivo (el be- lo transitiviza) → Ik bekijk de foto''s, Ik bekijk ze bijna elke dag (las miro casi a diario).
Truco: be- convierte en transitivo. kijken naar iets = bekijken iets. Igual que antwoorden op iets = beantwoorden iets.
⚠️ Y aunque lo arregles con naar, cambia el significado: Ik kijk bijna elke dag naar hen = los miro/observo casi a diario (los estoy mirando a propósito), que de unos vecinos suena raro, casi a vigilarlos. «Los veo a diario» (me los encuentro) es zien.
Nota de uso real: con MEDIOS (tele, series, pelis) el neerlandés coloquial sí usa kijken con objeto directo — Ik kijk een film, Ik kijk ze bijna elke dag (las series). Por eso tu frase se entendería... pero se entendería como «las veo (en la tele)», no como personas. Lo estándar sigue siendo naar iets kijken.
🧭 Resumen: ¿me los encuentro/los percibo? → zien (Ik zie ze) · ¿los miro a propósito? → naar ... kijken · ¿examino algo? → bekijken.'
WHERE id = 641 AND COALESCE(rules_help,'') NOT LIKE '%👀%';

-- 621 · komen (cita) vs aankomen (destino) y el resto del mapa de «llegar»
UPDATE words_es SET rules_help = rules_help || '

🚆 ¿Y «Jij bent te laat aangekomen»? Es correcta, pero cuenta otra cosa
Las dos son gramaticales y las dos van con ZIJN; lo que cambia es el foco.
• te laat komen = presentarse tarde a una cita, clase, reunión. El foco está en la PERSONA que aparece donde te espera alguien. Es la colocación fija del reproche → Jij bent te laat gekomen.
• te laat aankomen = llegar tarde al DESTINO, al final de un trayecto. El foco está en el punto de llegada, no en la cita → De trein is te laat aangekomen · We zijn pas om middernacht in Amsterdam aangekomen.
Aplicado a ti: «Jij bent te laat aangekomen» se entiende, pero suena a parte de viaje (como si narraras que tu tren o tu coche llegó tarde), no a «has llegado tarde» de reproche.
🧭 ¿Cuándo cada uno para «llegar»?
• komen = venir/presentarse. Cita, evento, hora acordada: te laat komen, op tijd komen (llegar a tiempo), Kom je vanavond? Es el «llegar» de las personas ante un compromiso.
• aankomen = arribar al destino (separable: Ik kom om acht uur aan). Va con in/op/bij, NUNCA con naar: in Rotterdam aankomen, op het station aankomen, bij het hotel aankomen. El sustantivo es aankomst (llegadas del aeropuerto: aankomst / vertrek).
• thuiskomen = llegar a casa (verbo propio) → Hij komt laat thuis.
• bereiken = llegar a en el sentido de ALCANZAR: transitivo y con hebben → We hebben de top bereikt, een akkoord bereiken (llegar a un acuerdo).
⚠️ aankomen tiene otros dos sentidos muy usados: ENGORDAR (Ik ben drie kilo aangekomen = he engordado tres kilos) y, en Het komt erop aan, «lo que importa es». Y aankomen met = salir con, presentarse con (Kom niet aankomen met smoesjes = no me vengas con excusas).
Regla de bolsillo: ¿tarde a una cita? → te laat komen · ¿tarde al destino/en un trayecto? → te laat aankomen.'
WHERE id = 621 AND COALESCE(rules_help,'') NOT LIKE '%🚆%';

-- 690 · la familia «despertarse/levantarse» al completo (auxiliar + construcción)
UPDATE words_es SET rules_help = rules_help || '

🛏️ La familia entera de «despertarse / levantarse» (que se confunde toda)
El español reparte esto en pocos verbos y el neerlandés en muchos, cada uno con su auxiliar y su construcción:
• wakker worden = despertarse, abrir los ojos (cambio de estado, intransitivo) → ZIJN: Ik ben wakker geworden. Es el de esta tarjeta.
• wakker zijn = estar despierto (estado, no cambio): Ik ben al wakker.
• wakker maken = despertar A ALGUIEN (transitivo, lleva objeto) → HEBBEN: Kun je me om zeven uur wakker maken?
• wakker schrikken = despertarse de golpe, de un sobresalto → ZIJN: Ik ben wakker geschrokken van het lawaai.
• wakker liggen (van iets) = desvelarse, no pegar ojo por algo → HEBBEN: Ik heb er de hele nacht wakker van gelegen.
• opstaan = levantarse, salir de la cama → ZIJN: Ik ben vroeg opgestaan.
• uitslapen = dormir hasta tarde a gusto → HEBBEN: Zaterdag slaap ik lekker uit.
• zich verslapen = quedarse dormido, no oír el despertador → HEBBEN + reflexivo: Ik heb me verslapen.
• in slaap vallen = quedarse dormido (empezar a dormir) → ZIJN: Ik viel voor de tv in slaap.
• de wekker zetten = poner el despertador · de wekker gaat (af) = suena el despertador.
🧭 La secuencia natural de la noche, en orden: naar bed gaan → in slaap vallen → slapen → de wekker gaat → wakker worden → opstaan.
⚠️ Trampa del hispanohablante: «despertarse» NO es reflexivo en neerlandés. Nada de «zich wakker worden»; el reflexivo solo aparece en zich verslapen. Y ojo al par wakker worden (te despiertas tú, zijn) frente a wakker maken (despiertas a otro, hebben) — es el mismo par que ver/mostrar o caerse/tirar.'
WHERE id = 690 AND COALESCE(rules_help,'') NOT LIKE '%🛏️%';

-- 627 · «twee uur» (medida en singular tras número) frente a «uren» sin número
UPDATE words_es SET rules_help = rules_help || '

🔢 ¿Por qué «twee uur» y no «twee uren», si en la 629 sí es «uren»?
Porque en neerlandés los sustantivos de MEDIDA se quedan en SINGULAR detrás de un número. No es que uur no tenga plural (lo tiene, uren): es que contar cantidades no lo activa.
• Se quedan en singular tras número: uur (twee uur), jaar (drie jaar, hij is tien jaar oud), keer/maal (twee keer), kilo/gram/pond/ons (vijf kilo), euro/cent (tien euro), meter/kilometer (drie kilometer), liter (twee liter), procent (tien procent), man contando personas (tien man).
• PERO estas unidades de tiempo sí pluralizan con normalidad: minuten (twee minuten), seconden, dagen (drie dagen), weken, maanden, eeuwen. La excepción son justo uur y jaar, que son las que más usas.
🧭 ¿Y entonces «uren in de file gestaan» de la 629?
Ahí NO hay número. La regla del singular solo se dispara detrás de una cifra; sin ella, uren es el plural normal y significa horas y horas, un montón de horas (indefinido).
• Con número, cantidad exacta: Ik heb twee uur gefietst = he montado dos horas.
• Sin número, cantidad indefinida: We hebben uren in de file gestaan = hemos estado horas en el atasco. Ik heb uren gewacht = esperé horas y horas.
• Mismo juego con jaar: drie jaar geleden (hace tres años) frente a Ik heb hem jaren niet gezien (no lo veo desde hace años).
• Variante enfática: urenlang / jarenlang = durante horas / durante años (Ze stonden urenlang in de rij).
⚠️ Matiz fino: si pones un adjetivo que las individualiza, el plural reaparece aunque haya número → Ik heb twee lange uren gewacht (dos larguísimas horas). Es marcado, para recrearse; lo neutro es twee uur.
Colocaciones de uur que conviene fijar: Het is twee uur = son las dos · om twee uur = a las dos · over een uur = dentro de una hora · een uur of twee = unas dos horas · een half uur = media hora.
Regla de bolsillo: ¿hay cifra delante? → unidad en SINGULAR (twee uur) · ¿no hay cifra? → plural normal (uren = horas y horas).'
WHERE id = 627 AND COALESCE(rules_help,'') NOT LIKE '%🔢%';

-- 601 · zich haasten vs opschieten y las partículas del imperativo (even/eens/nou/maar/toch)
UPDATE words_es SET rules_help = rules_help || '

🏃 ¿Y «Schiet op!» o «Schiet even op!»?
Schiet op! es correcto y de hecho está aquí arriba como alternativa coloquial. Si la tarjeta enseña Haast je een beetje! es por el TEMA (verbos reflexivos: zich haasten), no porque lo otro esté mal. Lo que cambia es el registro y la construcción:
• zich haasten = darse prisa. REFLEXIVO: Haast je! · Ik haast me · Haast je niet (no corras). Neutro, vale con cualquiera.
• opschieten = espabilar, moverse. SEPARABLE y NO reflexivo: Schiet op! Nunca «schiet je op». Es coloquial y bastante más brusco: suena a ¡venga, muévete! Entre amigos o en casa, perfecto; a un desconocido o a un jefe, no.
🧭 ¿Y el «even»? Aquí está el detalle que preguntas
En el imperativo el neerlandés mete partículas que cambian el tono, y no son intercambiables:
• even = un momentito, brevedad. Hace la orden pequeña: Kom even hier · Wacht even. Con opschieten se oye (Schiet even op = date prisa un segundo), pero NO es la habitual: choca un poco pedir brevedad y prisa a la vez.
• eens = a ver, anda. Es LA de este verbo: Schiet eens op! Suena a apremio con un punto de reproche.
• nou = venga ya, impaciencia pura: Schiet nou op! (y se combinan: Schiet nou eens op!).
• een beetje = un poco, suaviza. Schiet een beetje op! es el gemelo coloquial EXACTO de la frase de la tarjeta: misma dosis de «un poco», solo cambia el verbo (Haast je een beetje! → Schiet een beetje op!). Es de las más naturales.
• maar = tranquilo, adelante (permiso): Ga maar zitten · Zeg het maar.
• toch = insistencia o reproche: Kom toch! · Doe toch normaal!
⚠️ opschieten tiene otros dos usos muy frecuentes que no son prisa: avanzar (Het schiet niet op = esto no avanza · Schiet het al op?) y llevarse bien con alguien (Ik kan goed met hem opschieten = me llevo bien con él). El contexto los separa solos, pero conviene reconocerlos.
Bonus del sustantivo: haast = prisa (Ik heb haast = tengo prisa · haastig = apresurado). Y OJO, haast también significa CASI como adverbio: Ik ben haast klaar = casi he terminado. Mismo aspecto, significados distintos.
📐 Dónde va la partícula: opschieten es SEPARABLE, así que op se marcha al final y todo lo demás se cuela en medio → Schiet [eens / nou / even / een beetje] op. Y se pueden apilar en este orden: Schiet nou eens een beetje op! En subordinada el verbo se vuelve a juntar (Ik hoop dat je opschiet) y con te se parte por dentro (om op te schieten), igual que terugbellen → terug te bellen.
Regla de bolsillo: neutro o educado → Haast je (een beetje) · confianza y prisa de verdad → Schiet eens/nou op · «even» no es la partícula de este verbo.'
WHERE id = 601 AND COALESCE(rules_help,'') NOT LIKE '%🏃%';

-- 598 · «niet lekker» (malestar físico) frente a «niet goed», y la trampa del reflexivo
UPDATE words_es SET rules_help = rules_help || '

🤒 ¿Y «Ik voel me niet goed»? Vale, pero no es la que usa un nativo para estar pachucho
Se entiende perfectamente y es correcta. La diferencia es de colocación y de matiz:
• Ik voel me niet lekker = la fórmula FIJA del malestar físico: estoy malo, pachucho, no me encuentro bien. Es la que oirás y la que se dice al llamar al trabajo.
• Ik voel me niet goed = también se dice, pero tira a algo más serio o más difuso: no estar bien del todo, sentirse flojo, a punto de marearse. Fuera del cuerpo suena a estar mal anímicamente o a que algo no cuadra.
• Dit voelt niet goed (sin reflexivo, con sujeto impersonal) ya NO habla de salud: esto no me da buena espina.
🧭 La clave es lekker, que no es «rico» sino «a gusto»
Es una de las palabras más neerlandesas que hay: significa agradable, cómodo, que sienta bien, y se pega a casi todo. lekker eten (comer rico) · lekker weer (buen tiempo) · lekker slapen (dormir a gusto) · lekker warm (calentito) · lekker zitten (estar cómodo) · lekker bezig (irónico: menudo trabajo estás haciendo). Por eso niet lekker = no estar a gusto en tu propio cuerpo.
⚠️ Trampa gorda con el reflexivo: quítale el me y cambia de significado. Ik voel me niet lekker = no me encuentro bien, pero Ben je niet lekker?! = ¿estás mal de la cabeza?, ¿tú estás loco? Con zijn y sin reflexivo es un insulto suave, no una enfermedad. Y voelen sin reflexivo es TOCAR o notar al tacto: Voel eens! (¡toca!) · Het voelt zacht (se nota suave).
Cómo decir que estás malo, de menos a más: Ik voel me niet lekker (pachucho) · Ik ben ziek (estoy enfermo) · Ik voel me beroerd / rot (fatal). Síntomas sueltos: misselijk (con náuseas), duizelig (mareado), koorts hebben (tener fiebre), verkouden zijn (estar resfriado), grieperig (con algo de gripe). Lo que te contestarán: Beterschap! (¡que te mejores!).
Regla de bolsillo: cuerpo pachucho → niet lekker · algo no cuadra o presentimiento → niet goed · sin reflexivo → tocar (voelen) o insulto (niet lekker zijn).'
WHERE id = 598 AND COALESCE(rules_help,'') NOT LIKE '%🤒%';
