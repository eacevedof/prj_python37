-- Learn Languages App - Migration
-- Migration: 20260922000001-marca-inv-orden-topicalizado
-- Description: Eduardo, tras fallar la 927: "en 927 por ejemplo se espera inversion en la
--   traduccion pero a veces no es asi, de alguna forma para que sepa si lo quieres en inversion o
--   normal me lo tienes que indicar con (inv). En 927 traduje: ik heb dat nooit gewild".
--
--   Tenia razon: «Ik heb dat nooit gewild» es CORRECTO. El mazo esperaba «Dat heb ik nooit
--   gewild» (topicalizacion de dat + inversion), pero el enunciado espanol no daba forma de
--   saberlo, asi que la app marcaba mal una respuesta buena.
--
--   Se crea la marca (inv), con la misma convencion que (pasado)/(presente)/(ella)/(formal):
--   al final del texto ES, entre parentesis, en minuscula. Norma completa y criterio de cuando
--   se pone: learn-langs-howto-skill.md §3.9.
--
--   CRITERIO (lo que hace que una frase sea ambigua y necesite la marca): el neerlandes ANTEPONE
--   un complemento (dat/dit, daar-/hier- compuestos) y el orden neutro sujeto-verbo TAMBIEN seria
--   correcto. No se marca donde la inversion es forzosa ni donde el espanol ya abre con el mismo
--   complemento, porque ahi no hay eleccion y la marca solo seria ruido:
--     - preguntas (Zal ik...? / Waar ga je...?): la inversion es obligatoria y el ¿? ya avisa.
--     - el espanol antepone lo mismo (Manana lo hare -> Morgen zal ik het echt doen).
--     - subordinada delante (Toen ik het huis uitging, zag ik Jan): el orden lo fuerza la sintaxis.
--
--   Barrido de las 910 frases del mazo: 106 llevan inversion, pero solo 6 son ambiguas de verdad.
--   Son estas, y son las unicas que se marcan (la 806 «asi no se hace» se descarto: el espanol ya
--   abre con «asi», no hay eleccion):
--     312 ¡Eso ya lo veremos! (desafio)        -> Dat zullen we nog weleens zien!
--     453 Eso no esta en mi mano               -> Daar kan ik niets aan doen.
--     921 Sobre eso discrepamos. (presente)    -> Daarover verschillen we van mening.
--     927 Eso nunca lo he querido.             -> Dat heb ik nooit gewild.
--     937 No hacia falta que lo hicieras.      -> Dat had je niet hoeven doen.
--     976 de eso no se nada                    -> Daar weet ik niets van.
--
--   Cuando la tarjeta YA tenia una marca, (inv) se funde dentro del mismo parentesis con coma
--   ((desafio, inv), (enfatico con daar, inv), (presente, inv)) en vez de abrir un segundo
--   parentesis, que se leeria fatal en la locucion del examen.
--
--   Bloque compartido '🔄 Cuando el enunciado lleva (inv)' (§3.3): explica que la marca pide el
--   orden topicalizado y que sin ella vale el neutro. Se inyecta byte a byte en las 5 que tienen
--   rules_help; la 921 lo tiene a NULL y se queda sin ayuda (§5.4: una ayuda se crea entera, no a
--   trozos) — su ayuda completa queda PENDIENTE, anotada como tal.
--
--   AUDIO (§5.6.5): de las 6, solo la 312 tenia audio es_ES generado y subido al CDN; se borra su
--   fila de word_es_media para que la app lo regenere con el texto nuevo. Las otras 5 no tenian
--   audio espanol, asi que se generara al vuelo la primera vez que suenen.

-- =====================================================================================
-- 1) La marca (inv) en el texto ES
-- =====================================================================================

UPDATE words_es
SET text = '¡Eso ya lo veremos! (desafío, inv)'
WHERE text = '¡Eso ya lo veremos! (desafío)';

UPDATE words_es
SET text = 'Eso no está en mi mano (enfático con daar, inv).'
WHERE text = 'Eso no está en mi mano (enfático con daar).';

UPDATE words_es
SET text = 'Sobre eso discrepamos. (presente, inv)'
WHERE text = 'Sobre eso discrepamos. (presente)';

UPDATE words_es
SET text = 'Eso nunca lo he querido. (inv)'
WHERE text = 'Eso nunca lo he querido.';

UPDATE words_es
SET text = 'No hacía falta que lo hicieras. (inv)'
WHERE text = 'No hacía falta que lo hicieras.';

UPDATE words_es
SET text = 'de eso no sé nada (inv)'
WHERE text = 'de eso no sé nada';

-- =====================================================================================
-- 2) Bloque compartido: que significa (inv) — solo donde YA hay ayuda (§5.4)
-- =====================================================================================

UPDATE words_es
SET rules_help = rules_help || '

🔄 Cuando el enunciado lleva (inv): La frase neerlandesa NO empieza por el sujeto, sino por el complemento (dat, dit, daar, daarover, daarmee…). El verbo conjugado se queda SIEMPRE en segunda posición, así que el sujeto se va detrás: Dat heb ik nooit gewild, no «Dat ik heb nooit gewild».

🔑 Por qué existe la marca: Sin ella las dos respuestas son correctas y no hay forma de adivinar cuál se pide. Ik heb dat nooit gewild es neerlandés impecable; Dat heb ik nooit gewild es la misma frase poniendo el foco en eso. (inv) significa: la quiero con el complemento delante.

📋 El mismo par, con y sin marca:
• Dat heb ik nooit gewild. — Eso nunca lo he querido. (foco en «eso»)
• Ik heb dat nooit gewild. — Nunca he querido eso. (orden neutro)
• Daar weet ik niets van. — De eso no sé nada. (foco en «de eso»)
• Ik weet daar niets van. — No sé nada de eso. (orden neutro)

📐 El detalle que se escapa: Con daar/hier el neerlandés PARTE la preposición — daar … van, daar … aan, daar … mee —, y esa preposición se va al final de la frase: Daar kan ik niets aan doen.'
WHERE text IN (
    '¡Eso ya lo veremos! (desafío, inv)',
    'Eso no está en mi mano (enfático con daar, inv).',
    'Eso nunca lo he querido. (inv)',
    'No hacía falta que lo hicieras. (inv)',
    'de eso no sé nada (inv)'
)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🔄 Cuando el enunciado lleva (inv)%';

-- =====================================================================================
-- 3) Audio es_ES desincronizado: forzar regeneración de la 312 (§5.6.5)
-- =====================================================================================

DELETE FROM word_es_media
WHERE lang_code = 'es_ES'
  AND word_es_id = (SELECT id FROM words_es WHERE text = '¡Eso ya lo veremos! (desafío, inv)');
