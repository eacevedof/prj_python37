-- Learn Languages App - Migration
-- Migration: 20260908000016-plurales-grupo-40
-- Description: Eduardo, sobre el grupo 40: "agregemos a todos los sustantivos su forma
--   plural y estos tips: «Del verbo al sustantivo, y de donde sale su de o su het» y «El
--   truco que resuelve el 90%», que son comunes a todos, dejalos al final; lo que es
--   particular de cada palabra dejalo al principio".
--
--   Revisado el orden actual: ya es el que pide. La parte particular (el articulo con su
--   motivo, como se usa, y la pareja verbo-sustantivo) va primero, y los bloques comunes
--   (Del verbo al sustantivo, El adjetivo delata el articulo, Cuando lleva een, hebben o
--   zijn) van despues. No hay nada que reordenar.
--
--   Lo que si faltaba es el PLURAL como dato propio. Estaba en las veinte tarjetas, pero
--   metido dentro del parrafo de «Como se usa», donde se pierde de vista. Se saca a una
--   linea propia y destacada, colocada en la parte particular, justo delante de «Como se
--   usa» y por tanto antes de los bloques comunes.
--   Cada linea trae ademas POR QUE ese plural es asi, que es lo que permite deducir los
--   demas: -en a secas, -ingen para los acabados en -ing, -s para los acabados en -en
--   atono, consonante doblada tras vocal corta, vocal larga que pierde una letra, y la s
--   que se vuelve z. Los cinco que no se pluralizan lo dicen explicitamente.
--
--   Y se amplia el bloque comun con la regla de formacion del plural, que vale para las
--   cuarenta tarjetas y cierra el tema: todo plural lleva DE, sea cual sea el articulo del
--   singular.
--
--   Las migraciones 20260907000014 y siguientes ya estan aplicadas, asi que van con
--   REPLACE del texto exacto, que ademas hace la migracion idempotente sola.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El plural como dato propio, delante de «Como se usa»
-- =============================================================================

-- de vraag
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: de vraag → de vragen, porque la a larga pierde una letra al abrirse la silaba, y coincide con el infinitivo vragen. Y como todo plural neerlandes, lleva DE.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: de vraag'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- de gedachte
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: de gedachte → de gedachten, porque ya acaba en -e, asi que solo añade -n. Y como todo plural neerlandes, lleva DE.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: de gedachte'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- het begin
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: het begin no se pluraliza en el uso normal.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: het begin'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- de hulp
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: de hulp no se pluraliza: es incontable.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: de hulp'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- het leven
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: het leven → de levens, porque acaba en -en atono, y esos hacen el plural con -s. Y como todo plural neerlandes, lleva DE.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: het leven'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- de woning
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: de woning → de woningen, porque todo -ing hace -ingen. Y como todo plural neerlandes, lleva DE.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: de woning'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- het eten
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: het eten no se pluraliza: es el infinitivo sustantivado.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: het eten'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- de drank
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: de drank → de dranken, porque -en a secas. Y como todo plural neerlandes, lleva DE.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: de drank'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- de slaap
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: de slaap no se pluraliza en este sentido.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: de slaap'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- de betaling
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: de betaling → de betalingen, porque todo -ing hace -ingen. Y como todo plural neerlandes, lleva DE.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: de betaling'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- de reis
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: de reis → de reizen, porque la s se vuelve z entre vocales, como en huis y huizen. Y como todo plural neerlandes, lleva DE.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: de reis'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- de rit
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: de rit → de ritten, porque vocal corta, asi que la t se dobla. Y como todo plural neerlandes, lleva DE.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: de rit'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- het werk
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: het werk → de werken, porque -en a secas, y en plural son ademas las obras de un autor. Y como todo plural neerlandes, lleva DE.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: het werk'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- het gesprek
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: het gesprek → de gesprekken, porque vocal corta, asi que la k se dobla. Y como todo plural neerlandes, lleva DE.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: het gesprek'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- de komst
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: de komst no se pluraliza.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: de komst'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- de gang
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: de gang → de gangen, porque -en a secas. Y como todo plural neerlandes, lleva DE.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: de gang'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- het gezicht
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: het gezicht → de gezichten, porque -en a secas. Y como todo plural neerlandes, lleva DE.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: het gezicht'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- de gift
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: de gift → de giften, porque -en a secas. Y como todo plural neerlandes, lleva DE.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: de gift'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- de koop
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: de koop → de kopen, porque la o larga pierde una letra al abrirse la silaba, y coincide con el infinitivo kopen. Y como todo plural neerlandes, lleva DE.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: de koop'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- de verkoop
UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: ', '🔢 Plural: de verkoop no se pluraliza en el uso normal.

📋 Como se usa: ')
WHERE notes = 'Verbo frecuente: de verkoop'
  AND rules_help LIKE '%📋 Como se usa: %'
  AND rules_help NOT LIKE '%🔢 Plural:%';

-- =============================================================================
-- 2. La regla de formacion del plural, al bloque comun del final
-- =============================================================================
UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.',
    '📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

🔢 Como se forma el plural, que son cinco reglas y se acaban:

| regla | cuando | ejemplos |
|---|---|---|
| **-en** a secas | el caso normal | de drank → de drank**en**, de gang → de gang**en** |
| **-ingen** | acabados en -ing | de woning → de woning**en**, de betaling → de betaling**en** |
| **-s** | acabados en -en, -el, -er, -je atonos | het leven → de leven**s**, het meisje → de meisje**s** |
| consonante **doblada** | vocal corta delante | de rit → de ri**tt**en, het gesprek → het gespre**kk**en |
| vocal que **pierde** una letra | vocal larga en silaba abierta | de vraag → de vr**a**gen, de koop → de k**o**pen |

⚠️ Y dos cambios de consonante que acompañan al plural: la s se vuelve z y la f se vuelve v cuando quedan entre vocales. de reis → de reiZen, het huis → de huiZen, de brief → de brieVen.

🔑 La regla de oro del plural: TODO plural lleva de, sin excepcion, aunque el singular sea het. het huis pero de huizen, het gesprek pero de gesprekken. Por eso en plural el problema del genero desaparece.'
)
WHERE notes LIKE 'Verbo frecuente: %'
  AND rules_help LIKE '%📐 Y una cosa que ahorra memoria%'
  AND rules_help NOT LIKE '%🔢 Como se forma el plural%';

-- =============================================================================
-- 3. El plural ya no se repite dentro de «Como se usa»: se quita de ahi
-- =============================================================================

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: El plural es de vragen, igual que el infinitivo. Colocaciones: een vraag stellen (hacer una pregunta, con stellen y no con doen), de vraag is of… (la cuestion es si…), geen vraag te veel (ninguna pregunta esta de mas). Y en economia, vraag en aanbod es oferta y demanda, con la vraag en el lado de la demanda.', '📋 Como se usa: Colocaciones: een vraag stellen (hacer una pregunta, con stellen y no con doen), de vraag is of… (la cuestion es si…), geen vraag te veel (ninguna pregunta esta de mas). Y en economia, vraag en aanbod es oferta y demanda, con la vraag en el lado de la demanda.')
WHERE notes = 'Verbo frecuente: de vraag' AND rules_help LIKE '%📋 Como se usa: El plural es de vragen, igual que el infinitivo. Colocaciones: een vraag stellen (hacer una pregunta, con stellen y no con doen), de vraag is of… (la cuestion es si…), geen vraag te veel (ninguna pregunta esta de mas). Y en economia, vraag en aanbod es oferta y demanda, con la vraag en el lado de la demanda.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Ojo con esta, que rompe la regla: casi todos los sustantivos con ge- son het (het gesprek, het gezicht), pero de gedachte es de. El plural es de gedachten. Colocaciones: in gedachten zijn (estar absorto), van gedachten veranderen (cambiar de opinion), een goede gedachte (una buena idea). Y het idee tambien existe y es mas corriente para idea.', '📋 Como se usa: Ojo con esta, que rompe la regla: casi todos los sustantivos con ge- son het (het gesprek, het gezicht), pero de gedachte es de. Colocaciones: in gedachten zijn (estar absorto), van gedachten veranderen (cambiar de opinion), een goede gedachte (una buena idea). Y het idee tambien existe y es mas corriente para idea.')
WHERE notes = 'Verbo frecuente: de gedachte' AND rules_help LIKE '%📋 Como se usa: Ojo con esta, que rompe la regla: casi todos los sustantivos con ge- son het (het gesprek, het gezicht), pero de gedachte es de. El plural es de gedachten. Colocaciones: in gedachten zijn (estar absorto), van gedachten veranderen (cambiar de opinion), een goede gedachte (una buena idea). Y het idee tambien existe y es mas corriente para idea.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Sin plural en el uso normal. Colocaciones: in het begin (al principio), vanaf het begin (desde el principio), aan het begin van (al comienzo de), het begin van het einde (el principio del fin). Y beginner es el principiante, con de.', '📋 Como se usa: Colocaciones: in het begin (al principio), vanaf het begin (desde el principio), aan het begin van (al comienzo de), het begin van het einde (el principio del fin). Y beginner es el principiante, con de.')
WHERE notes = 'Verbo frecuente: het begin' AND rules_help LIKE '%📋 Como se usa: Sin plural en el uso normal. Colocaciones: in het begin (al principio), vanaf het begin (desde el principio), aan het begin van (al comienzo de), het begin van het einde (el principio del fin). Y beginner es el principiante, con de.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Casi siempre en singular. Colocaciones: om hulp vragen (pedir ayuda), hulp nodig hebben (necesitar ayuda), eerste hulp (primeros auxilios, y de ahi EHBO), de hulpverlener (el socorrista). Y hulp tambien es la persona que ayuda en casa: de huishoudelijke hulp.', '📋 Como se usa: Colocaciones: om hulp vragen (pedir ayuda), hulp nodig hebben (necesitar ayuda), eerste hulp (primeros auxilios, y de ahi EHBO), de hulpverlener (el socorrista). Y hulp tambien es la persona que ayuda en casa: de huishoudelijke hulp.')
WHERE notes = 'Verbo frecuente: de hulp' AND rules_help LIKE '%📋 Como se usa: Casi siempre en singular. Colocaciones: om hulp vragen (pedir ayuda), hulp nodig hebben (necesitar ayuda), eerste hulp (primeros auxilios, y de ahi EHBO), de hulpverlener (el socorrista). Y hulp tambien es la persona que ayuda en casa: de huishoudelijke hulp.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Es el mismo infinitivo usado como sustantivo, y por eso het. Plural de levens. Colocaciones: het dagelijks leven (la vida diaria), in het echte leven (en la vida real), levenslang (de por vida), Zo is het leven (asi es la vida). Y de levensverzekering es el seguro de vida.', '📋 Como se usa: Es el mismo infinitivo usado como sustantivo, y por eso het. Colocaciones: het dagelijks leven (la vida diaria), in het echte leven (en la vida real), levenslang (de por vida), Zo is het leven (asi es la vida). Y de levensverzekering es el seguro de vida.')
WHERE notes = 'Verbo frecuente: het leven' AND rules_help LIKE '%📋 Como se usa: Es el mismo infinitivo usado como sustantivo, y por eso het. Plural de levens. Colocaciones: het dagelijks leven (la vida diaria), in het echte leven (en la vida real), levenslang (de por vida), Zo is het leven (asi es la vida). Y de levensverzekering es el seguro de vida.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Plural de woningen. Es el termino neutro y administrativo para vivienda; het huis es la casa concreta y het appartement el piso. Colocaciones: de woningmarkt (el mercado inmobiliario), de sociale huurwoning (la vivienda social), de woningnood (la crisis de vivienda), que es palabra de telediario en Paises Bajos.', '📋 Como se usa: Es el termino neutro y administrativo para vivienda; het huis es la casa concreta y het appartement el piso. Colocaciones: de woningmarkt (el mercado inmobiliario), de sociale huurwoning (la vivienda social), de woningnood (la crisis de vivienda), que es palabra de telediario en Paises Bajos.')
WHERE notes = 'Verbo frecuente: de woning' AND rules_help LIKE '%📋 Como se usa: Plural de woningen. Es el termino neutro y administrativo para vivienda; het huis es la casa concreta y het appartement el piso. Colocaciones: de woningmarkt (el mercado inmobiliario), de sociale huurwoning (la vivienda social), de woningnood (la crisis de vivienda), que es palabra de telediario en Paises Bajos.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Sin plural. Es la comida como sustancia o como el acto: Het eten is klaar. Para el plato concreto, het gerecht; para la comida del mediodia, de lunch; para la cena, het avondeten. Colocaciones: eten koken (cocinar), uit eten gaan (salir a cenar), het eten opwarmen (calentar la comida).', '📋 Como se usa: Es la comida como sustancia o como el acto: Het eten is klaar. Para el plato concreto, het gerecht; para la comida del mediodia, de lunch; para la cena, het avondeten. Colocaciones: eten koken (cocinar), uit eten gaan (salir a cenar), het eten opwarmen (calentar la comida).')
WHERE notes = 'Verbo frecuente: het eten' AND rules_help LIKE '%📋 Como se usa: Sin plural. Es la comida como sustancia o como el acto: Het eten is klaar. Para el plato concreto, het gerecht; para la comida del mediodia, de lunch; para la cena, het avondeten. Colocaciones: eten koken (cocinar), uit eten gaan (salir a cenar), het eten opwarmen (calentar la comida).%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Plural de dranken. Es la bebida como producto, sobre todo la alcoholica: sterke drank (bebida fuerte), de drankwinkel (la tienda de licores), alcoholvrije drank. Para lo que pides en un bar, het drankje (het por el diminutivo -je): Wil je een drankje? Y het drinken es el acto de beber.', '📋 Como se usa: Es la bebida como producto, sobre todo la alcoholica: sterke drank (bebida fuerte), de drankwinkel (la tienda de licores), alcoholvrije drank. Para lo que pides en un bar, het drankje (het por el diminutivo -je): Wil je een drankje? Y het drinken es el acto de beber.')
WHERE notes = 'Verbo frecuente: de drank' AND rules_help LIKE '%📋 Como se usa: Plural de dranken. Es la bebida como producto, sobre todo la alcoholica: sterke drank (bebida fuerte), de drankwinkel (la tienda de licores), alcoholvrije drank. Para lo que pides en un bar, het drankje (het por el diminutivo -je): Wil je een drankje? Y het drinken es el acto de beber.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Sin plural en este sentido. Fijate en que el sueño se TIENE con hebben: Ik heb slaap, igual que Ik heb honger. Colocaciones: in slaap vallen (quedarse dormido), de slaapkamer (el dormitorio, ya en tu mazo), een slaapje doen (echar una cabezada), slaap lekker (que duermas bien, la despedida de la noche).', '📋 Como se usa: Fijate en que el sueño se TIENE con hebben: Ik heb slaap, igual que Ik heb honger. Colocaciones: in slaap vallen (quedarse dormido), de slaapkamer (el dormitorio, ya en tu mazo), een slaapje doen (echar una cabezada), slaap lekker (que duermas bien, la despedida de la noche).')
WHERE notes = 'Verbo frecuente: de slaap' AND rules_help LIKE '%📋 Como se usa: Sin plural en este sentido. Fijate en que el sueño se TIENE con hebben: Ik heb slaap, igual que Ik heb honger. Colocaciones: in slaap vallen (quedarse dormido), de slaapkamer (el dormitorio, ya en tu mazo), een slaapje doen (echar una cabezada), slaap lekker (que duermas bien, la despedida de la noche).%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Plural de betalingen. Y aqui va vocabulario que necesitas de verdad en Paises Bajos: met pin betalen es pagar con tarjeta de debito, y es lo normal en todas partes; contant es en efectivo, y muchos sitios ya no lo aceptan; de rekening es la cuenta o la factura; de overschrijving es la transferencia; Tikkie es la app con la que todo el mundo se reclama dinero entre amigos.', '📋 Como se usa: Y aqui va vocabulario que necesitas de verdad en Paises Bajos: met pin betalen es pagar con tarjeta de debito, y es lo normal en todas partes; contant es en efectivo, y muchos sitios ya no lo aceptan; de rekening es la cuenta o la factura; de overschrijving es la transferencia; Tikkie es la app con la que todo el mundo se reclama dinero entre amigos.')
WHERE notes = 'Verbo frecuente: de betaling' AND rules_help LIKE '%📋 Como se usa: Plural de betalingen. Y aqui va vocabulario que necesitas de verdad en Paises Bajos: met pin betalen es pagar con tarjeta de debito, y es lo normal en todas partes; contant es en efectivo, y muchos sitios ya no lo aceptan; de rekening es la cuenta o la factura; de overschrijving es la transferencia; Tikkie es la app con la que todo el mundo se reclama dinero entre amigos.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Plural de reizen, otra vez igual que el infinitivo. Colocaciones: op reis gaan (irse de viaje), een reis boeken (reservar un viaje), de zakenreis (el viaje de negocios), het reisbureau (la agencia). Goede reis! es lo que se le dice a quien se va, y tambien vale Fijne reis!', '📋 Como se usa: Colocaciones: op reis gaan (irse de viaje), een reis boeken (reservar un viaje), de zakenreis (el viaje de negocios), het reisbureau (la agencia). Goede reis! es lo que se le dice a quien se va, y tambien vale Fijne reis!')
WHERE notes = 'Verbo frecuente: de reis' AND rules_help LIKE '%📋 Como se usa: Plural de reizen, otra vez igual que el infinitivo. Colocaciones: op reis gaan (irse de viaje), een reis boeken (reservar un viaje), de zakenreis (el viaje de negocios), het reisbureau (la agencia). Goede reis! es lo que se le dice a quien se va, y tambien vale Fijne reis!%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Plural de ritten, con la t doblada porque la vocal es corta. Es el trayecto concreto: een ritje maken (dar una vuelta), de treinrit, de taxirit. No lo confundas con de reis, que es el viaje entero y mas largo. Y het rijbewijs es el carnet de conducir, palabra que necesitaras.', '📋 Como se usa: Es el trayecto concreto: een ritje maken (dar una vuelta), de treinrit, de taxirit. No lo confundas con de reis, que es el viaje entero y mas largo. Y het rijbewijs es el carnet de conducir, palabra que necesitaras.')
WHERE notes = 'Verbo frecuente: de rit' AND rules_help LIKE '%📋 Como se usa: Plural de ritten, con la t doblada porque la vocal es corta. Es el trayecto concreto: een ritje maken (dar una vuelta), de treinrit, de taxirit. No lo confundas con de reis, que es el viaje entero y mas largo. Y het rijbewijs es el carnet de conducir, palabra que necesitaras.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Plural de werken, que ademas es como se llaman las obras de un autor. Fijate en que al trabajo se va con el POSESIVO y sin articulo: naar mijn werk, op mijn werk. Colocaciones: aan het werk! (¡a trabajar!), werk zoeken (buscar trabajo), de werkgever (el empleador) y de werknemer (el empleado), que se distinguen por quien da y quien toma el trabajo.', '📋 Como se usa: Fijate en que al trabajo se va con el POSESIVO y sin articulo: naar mijn werk, op mijn werk. Colocaciones: aan het werk! (¡a trabajar!), werk zoeken (buscar trabajo), de werkgever (el empleador) y de werknemer (el empleado), que se distinguen por quien da y quien toma el trabajo.')
WHERE notes = 'Verbo frecuente: het werk' AND rules_help LIKE '%📋 Como se usa: Plural de werken, que ademas es como se llaman las obras de un autor. Fijate en que al trabajo se va con el POSESIVO y sin articulo: naar mijn werk, op mijn werk. Colocaciones: aan het werk! (¡a trabajar!), werk zoeken (buscar trabajo), de werkgever (el empleador) y de werknemer (el empleado), que se distinguen por quien da y quien toma el trabajo.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Plural de gesprekken, con la k doblada. Colocaciones: een gesprek voeren (mantener una conversacion, con voeren y no con hebben en registro formal), het sollicitatiegesprek (la entrevista de trabajo), in gesprek (comunicando, al telefono). Y de spraak es el habla como facultad, distinto de het gesprek, que es la conversacion concreta.', '📋 Como se usa: Colocaciones: een gesprek voeren (mantener una conversacion, con voeren y no con hebben en registro formal), het sollicitatiegesprek (la entrevista de trabajo), in gesprek (comunicando, al telefono). Y de spraak es el habla como facultad, distinto de het gesprek, que es la conversacion concreta.')
WHERE notes = 'Verbo frecuente: het gesprek' AND rules_help LIKE '%📋 Como se usa: Plural de gesprekken, con la k doblada. Colocaciones: een gesprek voeren (mantener una conversacion, con voeren y no con hebben en registro formal), het sollicitatiegesprek (la entrevista de trabajo), in gesprek (comunicando, al telefono). Y de spraak es el habla como facultad, distinto de het gesprek, que es la conversacion concreta.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Sin plural. Es formal y se usa sobre todo en anuncios y noticias: de komst van de trein, bij aankomst (a la llegada). En el dia a dia se dice mas de aankomst, con aan-. Colocaciones: de wederkomst (la segunda venida), toekomst (el futuro, literalmente lo que viene hacia ti), que es la palabra realmente util de esta familia: de toekomst is onzeker.', '📋 Como se usa: Es formal y se usa sobre todo en anuncios y noticias: de komst van de trein, bij aankomst (a la llegada). En el dia a dia se dice mas de aankomst, con aan-. Colocaciones: de wederkomst (la segunda venida), toekomst (el futuro, literalmente lo que viene hacia ti), que es la palabra realmente util de esta familia: de toekomst is onzeker.')
WHERE notes = 'Verbo frecuente: de komst' AND rules_help LIKE '%📋 Como se usa: Sin plural. Es formal y se usa sobre todo en anuncios y noticias: de komst van de trein, bij aankomst (a la llegada). En el dia a dia se dice mas de aankomst, con aan-. Colocaciones: de wederkomst (la segunda venida), toekomst (el futuro, literalmente lo que viene hacia ti), que es la palabra realmente util de esta familia: de toekomst is onzeker.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Plural de gangen. Tiene dos vidas: el pasillo de una casa y la marcha o el curso de algo. In de gang (en el pasillo) frente a de gang van zaken (el curso de los acontecimientos), aan de gang zijn (estar en marcha) y op gang komen (arrancar). Y en un restaurante, een gang es un plato del menu: een viergangenmenu.', '📋 Como se usa: Tiene dos vidas: el pasillo de una casa y la marcha o el curso de algo. In de gang (en el pasillo) frente a de gang van zaken (el curso de los acontecimientos), aan de gang zijn (estar en marcha) y op gang komen (arrancar). Y en un restaurante, een gang es un plato del menu: een viergangenmenu.')
WHERE notes = 'Verbo frecuente: de gang' AND rules_help LIKE '%📋 Como se usa: Plural de gangen. Tiene dos vidas: el pasillo de una casa y la marcha o el curso de algo. In de gang (en el pasillo) frente a de gang van zaken (el curso de los acontecimientos), aan de gang zijn (estar en marcha) y op gang komen (arrancar). Y en un restaurante, een gang es un plato del menu: een viergangenmenu.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Plural de gezichten. Tiene dos sentidos que conviene separar: la cara y la vista. Het gezicht es la cara (een vriendelijk gezicht) y tambien la vision; het zicht es la visibilidad (slecht zicht, poca visibilidad). Colocaciones: uit het oog, uit het hart (ojos que no ven), op het eerste gezicht (a primera vista), zijn gezicht verliezen (perder la cara).', '📋 Como se usa: Tiene dos sentidos que conviene separar: la cara y la vista. Het gezicht es la cara (een vriendelijk gezicht) y tambien la vision; het zicht es la visibilidad (slecht zicht, poca visibilidad). Colocaciones: uit het oog, uit het hart (ojos que no ven), op het eerste gezicht (a primera vista), zijn gezicht verliezen (perder la cara).')
WHERE notes = 'Verbo frecuente: het gezicht' AND rules_help LIKE '%📋 Como se usa: Plural de gezichten. Tiene dos sentidos que conviene separar: la cara y la vista. Het gezicht es la cara (een vriendelijk gezicht) y tambien la vision; het zicht es la visibilidad (slecht zicht, poca visibilidad). Colocaciones: uit het oog, uit het hart (ojos que no ven), op het eerste gezicht (a primera vista), zijn gezicht verliezen (perder la cara).%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Plural de giften. Es el donativo, la donacion. Ojo con el falso amigo: en ingles gift es regalo, pero en neerlandes el regalo es het cadeau of het geschenk, y de gift es el donativo a una causa. Y hay otra trampa: het gif, sin t, es el veneno. Colocaciones: een gift doen (hacer un donativo), de gave (el don, el talento), que es otra derivada de geven.', '📋 Como se usa: Es el donativo, la donacion. Ojo con el falso amigo: en ingles gift es regalo, pero en neerlandes el regalo es het cadeau of het geschenk, y de gift es el donativo a una causa. Y hay otra trampa: het gif, sin t, es el veneno. Colocaciones: een gift doen (hacer un donativo), de gave (el don, el talento), que es otra derivada de geven.')
WHERE notes = 'Verbo frecuente: de gift' AND rules_help LIKE '%📋 Como se usa: Plural de giften. Es el donativo, la donacion. Ojo con el falso amigo: en ingles gift es regalo, pero en neerlandes el regalo es het cadeau of het geschenk, y de gift es el donativo a una causa. Y hay otra trampa: het gif, sin t, es el veneno. Colocaciones: een gift doen (hacer un donativo), de gave (el don, el talento), que es otra derivada de geven.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Plural de kopen. Colocaciones que veras por la calle: te koop (en venta, en los carteles), te huur (en alquiler, su pareja), de koopwoning (la vivienda en propiedad), de koopjes (las gangas), de koopzondag (el domingo con comercios abiertos). Y op de koop toe es por si fuera poco.', '📋 Como se usa: Colocaciones que veras por la calle: te koop (en venta, en los carteles), te huur (en alquiler, su pareja), de koopwoning (la vivienda en propiedad), de koopjes (las gangas), de koopzondag (el domingo con comercios abiertos). Y op de koop toe es por si fuera poco.')
WHERE notes = 'Verbo frecuente: de koop' AND rules_help LIKE '%📋 Como se usa: Plural de kopen. Colocaciones que veras por la calle: te koop (en venta, en los carteles), te huur (en alquiler, su pareja), de koopwoning (la vivienda en propiedad), de koopjes (las gangas), de koopzondag (el domingo con comercios abiertos). Y op de koop toe es por si fuera poco.%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '📋 Como se usa: Casi siempre en singular. Colocaciones: te koop aanbieden (poner a la venta), de verkoper (el vendedor), de uitverkoop (las rebajas), uitverkocht (agotado, lo que veras en los carteles de los conciertos). Y de omzet es la facturacion, que es la palabra que oiras en contexto de empresa.', '📋 Como se usa: Colocaciones: te koop aanbieden (poner a la venta), de verkoper (el vendedor), de uitverkoop (las rebajas), uitverkocht (agotado, lo que veras en los carteles de los conciertos). Y de omzet es la facturacion, que es la palabra que oiras en contexto de empresa.')
WHERE notes = 'Verbo frecuente: de verkoop' AND rules_help LIKE '%📋 Como se usa: Casi siempre en singular. Colocaciones: te koop aanbieden (poner a la venta), de verkoper (el vendedor), de uitverkoop (las rebajas), uitverkocht (agotado, lo que veras en los carteles de los conciertos). Y de omzet es la facturacion, que es la palabra que oiras en contexto de empresa.%';
