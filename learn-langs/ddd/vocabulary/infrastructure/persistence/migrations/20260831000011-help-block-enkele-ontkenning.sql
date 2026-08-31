-- Learn Languages App - Una sola negacion por frase: por que «enige spijt» y no «geen spijt»
-- Migration: 20260831000011-help-block-enkele-ontkenning.sql
-- Description: Eduardo en la 828 («Ze heeft nooit enige spijt bij hem bespeurd»): «¿por que enige
--   spijt y no geen spijt?». Porque la frase YA tiene una negacion, nooit, y el neerlandes admite
--   UNA sola por oracion. El espanol hace concordancia negativa («NUNCA ha percibido NINGUN
--   arrepentimiento» lleva dos y es correcto), el neerlandes no: con nooit, nergens, niemand,
--   niets o zonder, el sustantivo suelta el geen y coge enig o enige.
--   Bloque 🚫 IDENTICO byte a byte con la tabla de los tres casos (nooit + enige · geen como unica
--   negacion · geen enkele enfatico), la prohibicion explicita del doble negativo, la regla de
--   decision en dos segundos, la flexion de enig segun la regla del adjetivo (enige spijt con
--   de-woord pero enig idee con het-woord indefinido, de donde sale «Heb je enig idee?») y las
--   TRES vidas de enig: alguno/ningun en contexto negativo, EL UNICO con articulo definido (que
--   es lo que ya ensenan las tarjetas 415-419) y «encantador» en el habla. Cierra separandolo de
--   enkel (een enkele keer positivo frente a geen enkele negativo).
--   Va a 11 tarjetas: la 828 (que no tenia ayuda y se crea entera) mas las de nooit (156, 261,
--   298, 543, 812) y las de «het enige» (415-419), que son la segunda vida de la palabra.
--   100% aditiva e idempotente (guard por marca y por rules_help IS NULL).

-- ==============================================================================
-- 1. Tarjetas que ya tienen ayuda: el bloque se anade al final
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🚫 Una sola negacion por frase, y de ahi sale enige
El espanol ACUMULA negaciones y le parecen correctas: «NUNCA ha percibido NINGUN arrepentimiento» lleva dos y esta perfecta. El neerlandes no lo admite: en una misma oracion va UNA sola, y lo demas se queda en su forma neutra.

| en espanol | en neerlandes | por que |
|---|---|---|
| Nunca ha percibido NINGUN arrepentimiento | Ze heeft nooit **enige** spijt bespeurd. | ya esta nooit, asi que el objeto va con enige y no con geen |
| No ha percibido arrepentimiento | Ze heeft **geen** spijt bespeurd. | aqui geen ES la negacion de la frase |
| No se percibia NI UN SOLO movimiento | Er was **geen enkele** beweging te bespeuren. | geen enkele es el enfatico, y sigue siendo la unica negacion |

⚠️ Lo prohibido es juntar dos. «Ze heeft nooit geen spijt bespeurd» esta mal. Con nooit, nergens, niemand, niets o zonder ya hay negacion en la frase, asi que el sustantivo suelta el geen y coge enig o enige.

📌 Como decidirlo en dos segundos: ¿hay ya una palabra negativa en la oracion? Si la hay, enig o enige. Si no la hay y quieres negar el sustantivo, geen, o geen enkel y geen enkele si quieres enfatizar.

🔤 enig lleva -e o no segun la misma regla del adjetivo: enige spijt (de spijt es de-woord) pero enig idee (het idee es het-woord e indefinido, la unica casilla sin -e). De ahi la pregunta cotidiana Heb je enig idee? = ¿tienes idea?

🎭 Y ojo, porque enig tiene TRES vidas que no se parecen en nada:
• en contexto negativo o de pregunta = alguno, ningun. Zonder enige twijfel. — Sin ninguna duda.
• con articulo definido = el unico. Het enige wat ik wil, is rust. — Lo unico que quiero es tranquilidad.
• en el habla, de adjetivo suelto = encantador, monisimo. Wat een enig huisje! — ¡Que casita mas mona!

🔗 Y no lo confundas con enkel, que es otra palabra: een enkele keer = alguna que otra vez, en positivo, frente a geen enkele = ni uno solo, en negativo enfatico. Los sustantivos que salen aqui, con su articulo: de spijt (el arrepentimiento), de twijfel (la duda), het idee (la idea), de beweging (el movimiento).',
    updated_at = datetime('now')
WHERE id IN (156, 261, 298, 415, 416, 417, 418, 419, 543, 812)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🚫 Una sola negacion por frase%';

-- ==============================================================================
-- 2. Tarjeta 828: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'Esta frase junta las dos cosas que se preguntan de ella. Primero, por que enige spijt y no geen spijt: porque la oracion YA tiene una negacion, nooit, y el neerlandes solo admite UNA por frase. Con nooit dentro, el objeto no puede llevar geen y coge enige. «Ze heeft nooit geen spijt bespeurd» seria doble negacion y esta mal, aunque en espanol «nunca ha percibido ningun arrepentimiento» sea perfecto con las dos.

📌 Y segundo, el bij: bespeuren elige preposicion segun donde percibas la cosa, y para una PERSONA es bij hem, bij haar, bij mijn collega. Si fuera en la voz o en un texto seria in.

🔤 Los sustantivos, con su articulo: de spijt (el arrepentimiento, el pesar). El verbo de la misma raiz es spijt hebben VAN (arrepentirse de algo): Ik heb er spijt van. Y la formula de disculpa que sale de ahi es Het spijt me (lo siento), literalmente «me pesa».

🚫 Una sola negacion por frase, y de ahi sale enige
El espanol ACUMULA negaciones y le parecen correctas: «NUNCA ha percibido NINGUN arrepentimiento» lleva dos y esta perfecta. El neerlandes no lo admite: en una misma oracion va UNA sola, y lo demas se queda en su forma neutra.

| en espanol | en neerlandes | por que |
|---|---|---|
| Nunca ha percibido NINGUN arrepentimiento | Ze heeft nooit **enige** spijt bespeurd. | ya esta nooit, asi que el objeto va con enige y no con geen |
| No ha percibido arrepentimiento | Ze heeft **geen** spijt bespeurd. | aqui geen ES la negacion de la frase |
| No se percibia NI UN SOLO movimiento | Er was **geen enkele** beweging te bespeuren. | geen enkele es el enfatico, y sigue siendo la unica negacion |

⚠️ Lo prohibido es juntar dos. «Ze heeft nooit geen spijt bespeurd» esta mal. Con nooit, nergens, niemand, niets o zonder ya hay negacion en la frase, asi que el sustantivo suelta el geen y coge enig o enige.

📌 Como decidirlo en dos segundos: ¿hay ya una palabra negativa en la oracion? Si la hay, enig o enige. Si no la hay y quieres negar el sustantivo, geen, o geen enkel y geen enkele si quieres enfatizar.

🔤 enig lleva -e o no segun la misma regla del adjetivo: enige spijt (de spijt es de-woord) pero enig idee (het idee es het-woord e indefinido, la unica casilla sin -e). De ahi la pregunta cotidiana Heb je enig idee? = ¿tienes idea?

🎭 Y ojo, porque enig tiene TRES vidas que no se parecen en nada:
• en contexto negativo o de pregunta = alguno, ningun. Zonder enige twijfel. — Sin ninguna duda.
• con articulo definido = el unico. Het enige wat ik wil, is rust. — Lo unico que quiero es tranquilidad.
• en el habla, de adjetivo suelto = encantador, monisimo. Wat een enig huisje! — ¡Que casita mas mona!

🔗 Y no lo confundas con enkel, que es otra palabra: een enkele keer = alguna que otra vez, en positivo, frente a geen enkele = ni uno solo, en negativo enfatico. Los sustantivos que salen aqui, con su articulo: de spijt (el arrepentimiento), de twijfel (la duda), het idee (la idea), de beweging (el movimiento).',
    updated_at = datetime('now')
WHERE id = 828
  AND rules_help IS NULL;
