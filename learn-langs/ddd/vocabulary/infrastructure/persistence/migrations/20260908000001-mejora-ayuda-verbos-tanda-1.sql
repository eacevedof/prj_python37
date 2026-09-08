-- Learn Languages App - Migration
-- Migration: 20260908000001-mejora-ayuda-verbos-tanda-1
-- Description: Eduardo, sobre el grupo 40: "hay que mejorar la ayuda, esta bien q me
--   digas el sustantivo pero pon un ejemplo en una frase muy usada".
--
--   Tiene razon: la linea de la pareja nombraba el sustantivo (vragen → de vraag) pero no
--   lo enseñaba funcionando, y una palabra suelta es justo lo que el grupo queria evitar.
--   Ahora esa linea trae DOS frases en cada tarjeta:
--     - la de la tarjeta hermana, para ver la pareja completa desde los dos lados;
--     - y una frase extra muy usada con el sustantivo, que antes solo aparecia como
--       colocacion suelta dentro de una lista (een vraag stellen) y ahora va entera y
--       traducida (Mag ik een vraag stellen?).
--   Se cruza en las dos direcciones: la tarjeta del verbo enseña el sustantivo en frase y
--   la del sustantivo enseña el verbo en frase.
--
--   La 20260907000014 YA ESTA APLICADA, asi que no se puede corregir editandola: van 40
--   REPLACE del texto viejo exacto por el nuevo, acotados ademas por notes para que cada
--   uno toque solo su tarjeta. Al aplicarse desaparece el texto viejo, de modo que la
--   segunda pasada no encuentra nada y la migracion es idempotente sola.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

-- Verbo frecuente: vragen
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: vragen → de vraag. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: vragen → de vraag. El sustantivo, en frase: Ik heb een vraag. (tengo una pregunta). Y otra muy usada: Mag ik een vraag stellen? (¿puedo hacer una pregunta?) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: vragen' AND rules_help LIKE '%🔗 La pareja: vragen → de vraag. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: de vraag
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: de vraag ← vragen. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: de vraag ← vragen. El verbo, en frase: Mag ik je iets vragen? (¿te puedo preguntar una cosa?). Y otra frase muy usada con el sustantivo: Mag ik een vraag stellen? (¿puedo hacer una pregunta?) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: de vraag' AND rules_help LIKE '%🔗 La pareja: de vraag ← vragen. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: denken
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: denken → de gedachte. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: denken → de gedachte. El sustantivo, en frase: Dat is een goede gedachte. (es una buena idea). Y otra muy usada: Ik was in gedachten. (estaba absorto en mis cosas) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: denken' AND rules_help LIKE '%🔗 La pareja: denken → de gedachte. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: de gedachte
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: de gedachte ← denken. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: de gedachte ← denken. El verbo, en frase: Ik denk er nog over na. (me lo estoy pensando). Y otra frase muy usada con el sustantivo: Ik was in gedachten. (estaba absorto en mis cosas) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: de gedachte' AND rules_help LIKE '%🔗 La pareja: de gedachte ← denken. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: beginnen
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: beginnen → het begin. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: beginnen → het begin. El sustantivo, en frase: In het begin was het moeilijk. (al principio era difícil). Y otra muy usada: Laten we bij het begin beginnen. (empecemos por el principio) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: beginnen' AND rules_help LIKE '%🔗 La pareja: beginnen → het begin. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: het begin
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: het begin ← beginnen. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: het begin ← beginnen. El verbo, en frase: We beginnen om negen uur. (empezamos a las nueve). Y otra frase muy usada con el sustantivo: Laten we bij het begin beginnen. (empecemos por el principio) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: het begin' AND rules_help LIKE '%🔗 La pareja: het begin ← beginnen. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: helpen
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: helpen → de hulp. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: helpen → de hulp. El sustantivo, en frase: Bedankt voor je hulp. (gracias por tu ayuda). Y otra muy usada: Ik heb je hulp nodig. (necesito tu ayuda) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: helpen' AND rules_help LIKE '%🔗 La pareja: helpen → de hulp. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: de hulp
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: de hulp ← helpen. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: de hulp ← helpen. El verbo, en frase: Kun je me even helpen? (¿me ayudas un momento?). Y otra frase muy usada con el sustantivo: Ik heb je hulp nodig. (necesito tu ayuda) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: de hulp' AND rules_help LIKE '%🔗 La pareja: de hulp ← helpen. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: leven
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: leven → het leven. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: leven → het leven. El sustantivo, en frase: Het leven is duur. (la vida es cara). Y otra muy usada: Zo is het leven. (así es la vida) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: leven' AND rules_help LIKE '%🔗 La pareja: leven → het leven. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: het leven
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: het leven ← leven. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: het leven ← leven. El verbo, en frase: Hij leeft nog. (todavía vive). Y otra frase muy usada con el sustantivo: Zo is het leven. (así es la vida) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: het leven' AND rules_help LIKE '%🔗 La pareja: het leven ← leven. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: wonen
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: wonen → de woning. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: wonen → de woning. El sustantivo, en frase: We zoeken een woning. (buscamos vivienda). Y otra muy usada: De woningmarkt is oververhit. (el mercado de la vivienda está disparado) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: wonen' AND rules_help LIKE '%🔗 La pareja: wonen → de woning. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: de woning
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: de woning ← wonen. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: de woning ← wonen. El verbo, en frase: Ik woon in Amsterdam. (vivo en Ámsterdam). Y otra frase muy usada con el sustantivo: De woningmarkt is oververhit. (el mercado de la vivienda está disparado) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: de woning' AND rules_help LIKE '%🔗 La pareja: de woning ← wonen. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: eten
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: eten → het eten. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: eten → het eten. El sustantivo, en frase: Het eten is klaar. (la comida está lista). Y otra muy usada: Het eten wordt koud. (la comida se está enfriando) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: eten' AND rules_help LIKE '%🔗 La pareja: eten → het eten. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: het eten
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: het eten ← eten. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: het eten ← eten. El verbo, en frase: We eten om zes uur. (comemos a las seis). Y otra frase muy usada con el sustantivo: Het eten wordt koud. (la comida se está enfriando) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: het eten' AND rules_help LIKE '%🔗 La pareja: het eten ← eten. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: drinken
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: drinken → de drank. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: drinken → de drank. El sustantivo, en frase: De drank is inbegrepen. (la bebida está incluida). Y otra muy usada: De drankjes zijn voor mij. (las bebidas las pago yo) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: drinken' AND rules_help LIKE '%🔗 La pareja: drinken → de drank. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: de drank
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: de drank ← drinken. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: de drank ← drinken. El verbo, en frase: Wil je iets drinken? (¿quieres beber algo?). Y otra frase muy usada con el sustantivo: De drankjes zijn voor mij. (las bebidas las pago yo) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: de drank' AND rules_help LIKE '%🔗 La pareja: de drank ← drinken. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: slapen
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: slapen → de slaap. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: slapen → de slaap. El sustantivo, en frase: Ik heb slaap. (tengo sueño). Y otra muy usada: Ik val bijna in slaap. (casi me quedo dormido) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: slapen' AND rules_help LIKE '%🔗 La pareja: slapen → de slaap. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: de slaap
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: de slaap ← slapen. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: de slaap ← slapen. El verbo, en frase: Ik heb slecht geslapen. (he dormido mal). Y otra frase muy usada con el sustantivo: Ik val bijna in slaap. (casi me quedo dormido) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: de slaap' AND rules_help LIKE '%🔗 La pareja: de slaap ← slapen. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: betalen
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: betalen → de betaling. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: betalen → de betaling. El sustantivo, en frase: De betaling is gelukt. (el pago se ha realizado). Y otra muy usada: De betaling is nog niet binnen. (el pago todavía no ha llegado) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: betalen' AND rules_help LIKE '%🔗 La pareja: betalen → de betaling. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: de betaling
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: de betaling ← betalen. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: de betaling ← betalen. El verbo, en frase: Kan ik met pin betalen? (¿puedo pagar con tarjeta?). Y otra frase muy usada con el sustantivo: De betaling is nog niet binnen. (el pago todavía no ha llegado) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: de betaling' AND rules_help LIKE '%🔗 La pareja: de betaling ← betalen. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: reizen
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: reizen → de reis. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: reizen → de reis. El sustantivo, en frase: Goede reis! (¡buen viaje!). Y otra muy usada: Hoe was je reis? (¿qué tal el viaje?) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: reizen' AND rules_help LIKE '%🔗 La pareja: reizen → de reis. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: de reis
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: de reis ← reizen. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: de reis ← reizen. El verbo, en frase: Ik reis graag alleen. (me gusta viajar solo). Y otra frase muy usada con el sustantivo: Hoe was je reis? (¿qué tal el viaje?) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: de reis' AND rules_help LIKE '%🔗 La pareja: de reis ← reizen. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: rijden
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: rijden → de rit. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: rijden → de rit. El sustantivo, en frase: Het was een lange rit. (fue un trayecto largo). Y otra muy usada: Zullen we een ritje maken? (¿damos una vuelta?) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: rijden' AND rules_help LIKE '%🔗 La pareja: rijden → de rit. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: de rit
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: de rit ← rijden. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: de rit ← rijden. El verbo, en frase: Hij rijdt te hard. (conduce demasiado rápido). Y otra frase muy usada con el sustantivo: Zullen we een ritje maken? (¿damos una vuelta?) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: de rit' AND rules_help LIKE '%🔗 La pareja: de rit ← rijden. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: werken
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: werken → het werk. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: werken → het werk. El sustantivo, en frase: Ik ga naar mijn werk. (voy al trabajo). Y otra muy usada: Ik ben op mijn werk. (estoy en el trabajo) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: werken' AND rules_help LIKE '%🔗 La pareja: werken → het werk. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: het werk
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: het werk ← werken. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: het werk ← werken. El verbo, en frase: Ik werk vanuit huis. (trabajo desde casa). Y otra frase muy usada con el sustantivo: Ik ben op mijn werk. (estoy en el trabajo) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: het werk' AND rules_help LIKE '%🔗 La pareja: het werk ← werken. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: spreken
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: spreken → het gesprek. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: spreken → het gesprek. El sustantivo, en frase: We hadden een goed gesprek. (tuvimos una buena conversación). Y otra muy usada: Ik ben in gesprek. (estoy hablando, está comunicando) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: spreken' AND rules_help LIKE '%🔗 La pareja: spreken → het gesprek. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: het gesprek
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: het gesprek ← spreken. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: het gesprek ← spreken. El verbo, en frase: Spreek je Nederlands? (¿hablas neerlandés?). Y otra frase muy usada con el sustantivo: Ik ben in gesprek. (estoy hablando, está comunicando) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: het gesprek' AND rules_help LIKE '%🔗 La pareja: het gesprek ← spreken. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: komen
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: komen → de komst. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: komen → de komst. El sustantivo, en frase: We wachten op zijn komst. (esperamos su llegada). Y otra muy usada: De toekomst ziet er goed uit. (el futuro pinta bien) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: komen' AND rules_help LIKE '%🔗 La pareja: komen → de komst. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: de komst
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: de komst ← komen. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: de komst ← komen. El verbo, en frase: Kom je ook? (¿vienes tú también?). Y otra frase muy usada con el sustantivo: De toekomst ziet er goed uit. (el futuro pinta bien) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: de komst' AND rules_help LIKE '%🔗 La pareja: de komst ← komen. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: gaan
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: gaan → de gang. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: gaan → de gang. El sustantivo, en frase: De jas hangt in de gang. (el abrigo está en el pasillo). Y otra muy usada: Alles is in volle gang. (todo está en plena marcha) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: gaan' AND rules_help LIKE '%🔗 La pareja: gaan → de gang. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: de gang
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: de gang ← gaan. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: de gang ← gaan. El verbo, en frase: Hoe gaat het? (¿cómo va?). Y otra frase muy usada con el sustantivo: Alles is in volle gang. (todo está en plena marcha) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: de gang' AND rules_help LIKE '%🔗 La pareja: de gang ← gaan. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: zien
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: zien → het gezicht. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: zien → het gezicht. El sustantivo, en frase: Hij heeft een vriendelijk gezicht. (tiene una cara amable). Y otra muy usada: Ik ken dat gezicht. (esa cara me suena) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: zien' AND rules_help LIKE '%🔗 La pareja: zien → het gezicht. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: het gezicht
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: het gezicht ← zien. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: het gezicht ← zien. El verbo, en frase: Ik zie je morgen. (te veo mañana). Y otra frase muy usada con el sustantivo: Ik ken dat gezicht. (esa cara me suena) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: het gezicht' AND rules_help LIKE '%🔗 La pareja: het gezicht ← zien. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: geven
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: geven → de gift. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: geven → de gift. El sustantivo, en frase: Het was een gift van de buren. (fue un donativo de los vecinos). Y otra muy usada: Bedankt voor uw gift. (gracias por su donativo) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: geven' AND rules_help LIKE '%🔗 La pareja: geven → de gift. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: de gift
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: de gift ← geven. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: de gift ← geven. El verbo, en frase: Kun je me het zout geven? (¿me pasas la sal?). Y otra frase muy usada con el sustantivo: Bedankt voor uw gift. (gracias por su donativo) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: de gift' AND rules_help LIKE '%🔗 La pareja: de gift ← geven. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: kopen
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: kopen → de koop. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: kopen → de koop. El sustantivo, en frase: Het huis staat te koop. (la casa está en venta). Y otra muy usada: Ik heb een koopje gescoord. (he pillado una ganga) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: kopen' AND rules_help LIKE '%🔗 La pareja: kopen → de koop. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: de koop
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: de koop ← kopen. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: de koop ← kopen. El verbo, en frase: Ik heb een nieuwe fiets gekocht. (me he comprado una bici nueva). Y otra frase muy usada con el sustantivo: Ik heb een koopje gescoord. (he pillado una ganga) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: de koop' AND rules_help LIKE '%🔗 La pareja: de koop ← kopen. La tarjeta del verbo esta en este mismo grupo.%';

-- Verbo frecuente: verkopen
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: verkopen → de verkoop. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.', '🔗 La pareja: verkopen → de verkoop. El sustantivo, en frase: De verkoop gaat goed. (las ventas van bien). Y otra muy usada: De verkoop start morgen. (la venta empieza mañana) Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.')
WHERE notes = 'Verbo frecuente: verkopen' AND rules_help LIKE '%🔗 La pareja: verkopen → de verkoop. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.%';

-- Verbo frecuente: de verkoop
UPDATE words_es SET rules_help = REPLACE(rules_help, '🔗 La pareja: de verkoop ← verkopen. La tarjeta del verbo esta en este mismo grupo.', '🔗 La pareja: de verkoop ← verkopen. El verbo, en frase: Ze verkopen hier goede kaas. (aquí venden buen queso). Y otra frase muy usada con el sustantivo: De verkoop start morgen. (la venta empieza mañana) La tarjeta del verbo esta en este mismo grupo.')
WHERE notes = 'Verbo frecuente: de verkoop' AND rules_help LIKE '%🔗 La pareja: de verkoop ← verkopen. La tarjeta del verbo esta en este mismo grupo.%';
