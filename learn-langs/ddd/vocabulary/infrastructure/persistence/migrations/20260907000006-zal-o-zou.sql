-- Learn Languages App - Migration
-- Migration: 20260907000006-zal-o-zou
-- Description: Eduardo, sobre la tarjeta 322 (Zou ze het al weten? = ¿Lo sabra ya?): "no
--   entiendo esto, lo sabra es futuro pero se aplica zou, crea una documentacion muy
--   clara de cuando se usa zal y cuando zou".
--
--   El nudo: «¿lo sabra ya?» NO es futuro en español. El español usa la FORMA de futuro
--   para dos cosas distintas — el futuro de verdad (mañana lo hare) y la conjetura sobre
--   el PRESENTE (seran las tres, estara durmiendo, ¿lo sabra ya?). La prueba es que
--   «¿lo sabra ya?» se puede cambiar por «¿sera que ya lo sabe?» sin cambiar el sentido.
--   El neerlandes no usa el futuro para conjeturar: reparte la conjetura en dos segun se
--   afirme o se dude — zal wel para la afirmada (Hij zal wel thuis zijn, estara en casa)
--   y zou para la dudada (Zou ze het al weten?, ¿lo sabra ya?). Eso ya estaba en el mazo
--   sin explicar: las 302, 305, 306 y 307 son conjeturas afirmadas con zal wel, y la 321
--   y la 322 son dudadas con zou.
--
--   Regla madre: zou es el IMPERFECTO de zal, y como el will/would del ingles ese
--   imperfecto sirve para poner distancia (duda, cortesia, irrealidad). zal = lo doy por
--   hecho; zou = lo pongo a distancia.
--
--   El mazo tenia 83 tarjetas con zal, zou, zullen, zouden o zult, y NINGUNA explicaba la
--   diferencia: la mayoria llevaba solo el bloque generico de la pregunta si/no. Se les
--   inyecta el bloque "⚖️ zal o zou" con el paradigma, los cuatro usos de zal, los cinco
--   de zou, la tabla que separa los dos futuros del español y el papel de wel.
--   Cuatro de esas 83 (303, 307, 310, 326) tenian rules_help a NULL, asi que primero se
--   les escribe una primera linea propia (NULL || texto seria NULL y las dejaria vacias).
--   La 322, que es la que trajo la duda, se lleva ademas su explicacion concreta.
--
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. Las cuatro sin ayuda: primera linea propia antes de poder concatenar
-- =============================================================================
UPDATE words_es SET rules_help =
'Zal het lukken? Het zal wel moeten! = ¿Saldra bien? ¡Tendra que salir! Las dos mitades usan zullen para cosas distintas: la pregunta es conjetura dudada y la respuesta es la formula zal wel moeten, que es el no queda otra del neerlandes.'
WHERE id = 303 AND rules_help IS NULL;

UPDATE words_es SET rules_help =
'Waar is hij? Hij zal wel thuis zijn. = ¿Donde esta? Estara en casa. Fijate en que estara no habla del futuro: es una suposicion sobre AHORA, y por eso el neerlandes usa zal wel y no un futuro.'
WHERE id = 307 AND rules_help IS NULL;

UPDATE words_es SET rules_help =
'Komt het goed? We zullen zien. = ¿Saldra bien? Ya veremos. We zullen zien es formula hecha, el ya veremos de toda la vida, y aqui zullen si mira al futuro de verdad.'
WHERE id = 310 AND rules_help IS NULL;

UPDATE words_es SET rules_help =
'Moet dat echt? Je zult wel moeten! = ¿En serio hay que hacerlo? ¡No queda otra! Je zult wel moeten es la formula de la resignacion: literalmente tendras que, con el wel de la suposicion inevitable.'
WHERE id = 326 AND rules_help IS NULL;

-- =============================================================================
-- 2. La 322: la duda concreta que trajo esta migracion
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: Si «lo sabra» es futuro, ¿por que aparece zou y no zal?

🔑 Porque «¿lo sabra ya?» NO es futuro. El español usa la forma de futuro para dos cosas muy distintas, y esta es la segunda: no preguntas por el futuro, especulas sobre AHORA MISMO. La prueba es que puedes cambiarlo por «¿sera que ya lo sabe?» y significa exactamente lo mismo. Igual pasa con seran las tres, estara durmiendo o tendra unos cuarenta años: todos hablan del presente.

⚠️ El neerlandes no usa nunca el futuro para conjeturar. Reparte la conjetura en dos, segun la afirmes o la dudes: zal wel si la das por buena, zou si la pones en duda. Por eso aqui es Zou ze het al weten?

| en español | que es de verdad | en neerlandes |
|---|---|---|
| Estara en casa. | conjetura **afirmada** sobre el ahora | Hij **zal wel** thuis zijn. |
| ¿Lo sabra ya? | conjetura **dudada** sobre el ahora | **Zou** ze het al weten? |
| Manana lo hare. | futuro de verdad, con promesa | Ik **zal** het morgen doen. |
| Manana voy a Amsterdam. | futuro neutro | Ik **ga** morgen naar Amsterdam. |

🪞 Y esto ya estaba repartido por tu mazo sin que nadie lo dijera: la 302 (Hij zal wel weer te laat zijn), la 305 (Ze zal wel in de file staan), la 306 (Het zal wel duur zijn) y la 307 (Hij zal wel thuis zijn) son conjeturas AFIRMADAS, todas con zal wel. La 321 (Zou het gaan regenen?) y esta son conjeturas DUDADAS, las dos con zou. Misma idea, dos grados de seguridad.

🏋️ Ejercicio: «estara enfermo» (lo supones) → Hij ___ ___ ziek zijn. Y «¿estara enfermo?» (lo dudas) → ___ hij ziek zijn? (Respuestas: zal wel · Zou.)'
WHERE id = 322
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';

-- =============================================================================
-- 3. Bloque compartido a las 83 tarjetas con zal / zou / zullen / zouden / zult
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

⚖️ zal o zou, de una vez:

zou es el IMPERFECTO de zal. Y como el will y el would del ingles, ese imperfecto no sirve para hablar del pasado sino para poner DISTANCIA: duda, cortesia o irrealidad.

| persona | presente | imperfecto |
|---|---|---|
| ik | zal | zou |
| jij / je | zult (o zal) | zou |
| u | zult | zou |
| hij / zij / het | zal | zou |
| wij | zullen | zouden |
| jullie | zullen | zouden |
| zij (plural) | zullen | zouden |

• al invertir, jij pierde la -t: Zul jij komen? — no «zult jij» en el habla corriente.
• jij zal se oye y se admite; jij zult es la forma tradicional y la de los textos.

🎯 Los cuatro usos de ZAL, lo que se da por hecho:
• Promesa o compromiso — Ik zal het doen. (lo hare, te lo prometo)
• Propuesta u ofrecimiento, en pregunta — Zullen we…? Zal ik…?
• Suposicion SEGURA, y casi siempre con wel — Hij zal wel thuis zijn. (estara en casa)
• Futuro formal o enfatico — De vergadering zal om drie uur beginnen.

🎯 Los cinco usos de ZOU, lo que se pone a distancia:
• Condicional — Als ik jou was, zou ik het doen. (lo haria)
• Cortesia — Zou je me kunnen helpen? Ik zou graag een koffie willen.
• Suposicion DUDOSA, sobre todo preguntando — Zou ze het al weten? (¿lo sabra ya?)
• Consejo, con moeten — Je zou meer moeten slapen. (deberias dormir mas)
• Rumor sin confirmar — Hij zou ziek zijn. (dicen que esta enfermo)

🪄 Y la tabla que resuelve el lio de verdad, porque el español usa la forma de futuro para DOS cosas y el neerlandes las separa:

| en español | que es de verdad | en neerlandes |
|---|---|---|
| Manana **lo hare**. | futuro con promesa | Ik **zal** het morgen doen. |
| Manana **voy** a Amsterdam. | futuro neutro | Ik **ga** morgen… (presente) |
| **Estara** en casa. | conjetura afirmada sobre el AHORA | Hij **zal wel** thuis zijn. |
| **¿Lo sabra** ya? | conjetura dudada sobre el AHORA | **Zou** ze het al weten? |
| **Compraria** una casa. | condicional | Ik **zou** een huis kopen. |
| **¿Podrias** ayudarme? | cortesia | **Zou** je me kunnen helpen? |
| **Deberias** dormir mas. | consejo | Je **zou** meer moeten slapen. |

🔑 El truco que casi nunca falla: Si el futuro español no habla del futuro sino que especula sobre el ahora, en neerlandes NO va futuro. Lo afirmas con zal wel, lo dudas con zou. Para saber si es conjetura, cambialo por «sera que…»: si encaja, es conjetura.

⚠️ El papel de wel, que es el que se pasa por alto: wel es la marca de la suposicion confiada. Sin el, Hij zal thuis zijn suena a promesa rara; con el, Hij zal wel thuis zijn es estara en casa. Y Dat zal wel a secas es un supongo que si, a veces con retintin de no me lo creo del todo.

🕐 Y el recordatorio de siempre: el futuro neutro en neerlandes se dice con PRESENTE mas marcador de tiempo. Ik ga morgen naar Amsterdam vale para mañana voy y para mañana ire. zullen se reserva para la promesa, la propuesta y la suposicion.'
WHERE id IN (
    SELECT word_es_id FROM words_lang
    WHERE lang_code = 'nl_NL'
      AND (text LIKE '%zal %' OR text LIKE '%zou %' OR text LIKE '%zullen%'
           OR text LIKE '%zouden%' OR text LIKE '%zult%')
)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%⚖️ zal o zou%';
