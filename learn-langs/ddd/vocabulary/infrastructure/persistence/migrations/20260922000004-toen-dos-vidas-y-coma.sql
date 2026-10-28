-- Learn Languages App - Migration
-- Migration: 20260922000004-toen-dos-vidas-y-coma
-- Description: Eduardo, sobre la 521: "explica el uso de toen, y pq no es toen was ik jong,
--   woonde", despues "podria haber sido Ik woonde in Sevilla toen ik jong was?" y por ultimo
--   "si, unifica la coma y mete el bloque de toen".
--
--   Su «Toen was ik jong» ES correcto, pero es OTRA cosa: ahi toen es ADVERBIO (entonces) y abre
--   una principal con inversion. Como conjuncion (cuando) manda el verbo al final de la bijzin
--   — Toen ik jong was — y, al ocupar la subordinada la primera posicion, la principal invierte:
--   woonde ik, no «ik woonde». Y si, «Ik woonde in Sevilla toen ik jong was» vale igual: cambia
--   el foco, no la correccion.
--
--   1) LA COMA. El mazo era inconsistente: 523 «Ik sliep, toen je belde» con coma, pero 1073 y
--      1115 sin ella. Criterio que se fija (y el mas comun en neerlandes moderno):
--        - subordinada DELANTE -> coma SIEMPRE (Toen ik jong was, woonde ik…). No se toca nada,
--          ya estaban todas bien.
--        - subordinada temporal DETRAS -> SIN coma. Se quita en 511, 513 y 523.
--        - EXCEPCION, terwijl ADVERSATIVO (mientras QUE, contraste, no simultaneidad): conserva
--          la coma porque marca el contraste, igual que en español. Es el caso de la 515
--          («Hij is lang, terwijl zijn broer klein is»), que por eso NO se toca.
--
--   2) EL BLOQUE. '🕰️ Las dos vidas de toen' (§3.3), inyectado byte a byte en las 7 tarjetas del
--      fenomeno: 521, 522, 523, 524, 1073, 1079 y 1115. Lleva el contraste conjuncion/adverbio,
--      el esquema de posiciones que explica el «woonde ik», las dos variantes de orden con su
--      foco, la regla de la coma que se fija aqui y el cuadro de los cinco «cuando» del español
--      (toen, als, wanneer, terwijl, zodra…, con tijdens aparte por ser preposicion).
--
--   AUDIO (§5.6.5): comprobado que ninguna de las 9 tarjetas implicadas tiene audio nl_NL ni
--   word_es_media generado, asi que cambiar la coma no desincroniza ningun mp3.

-- =====================================================================================
-- 1) La coma: fuera en la subordinada temporal pospuesta (no en el terwijl adversativo)
-- =====================================================================================

UPDATE words_lang
SET text = 'Ik kook terwijl zij de tafel dekt.'
WHERE text = 'Ik kook, terwijl zij de tafel dekt.';

UPDATE words_lang
SET text = 'Hij belt terwijl hij fietst.'
WHERE text = 'Hij belt, terwijl hij fietst.';

UPDATE words_lang
SET text = 'Ik sliep toen je belde.'
WHERE text = 'Ik sliep, toen je belde.';

-- =====================================================================================
-- 2) Bloque compartido: las dos vidas de toen
-- =====================================================================================

UPDATE words_es
SET rules_help = rules_help || '

🕰️ Las dos vidas de toen: La misma palabra es conjuncion y adverbio, y cada una coloca el verbo en un sitio distinto. De ahi que «Toen was ik jong, woonde ik…» no cuadre: no es que este mal escrito, es que ese toen ya no significa cuando.

| toen es… | significa | el verbo va… | ejemplo |
|---|---|---|---|
| **conjuncion** | cuando | **al final** de la subordinada | Toen ik jong **was**, … |
| **adverbio** | entonces, en aquel momento | **2ª posicion**, principal invertida | **Toen was** ik jong. |

📐 Por que se dice woonde ik y no «ik woonde»: La subordinada entera ocupa la PRIMERA posicion de la frase, asi que el verbo de la principal, que va siempre en segunda, empuja al sujeto detras.

| posicion 1 | posicion 2 | y detras |
|---|---|---|
| Toen ik jong was, | **woonde** | ik in Sevilla. |
| Ik | **woonde** | in Sevilla toen ik jong was. |

🔄 Las dos van bien, cambia el foco:
• Toen ik jong was, woonde ik in Sevilla. — primero sitúas la epoca, luego cuentas. Es lo natural al narrar.
• Ik woonde in Sevilla toen ik jong was. — primero el hecho, y el cuando llega como precision. Es lo natural al responder «¿donde vivias?».

✒️ La coma, criterio del mazo: Subordinada DELANTE, coma siempre (Toen ik jong was, woonde ik…). Subordinada temporal DETRAS, sin coma (Ik sliep toen je belde). Unica excepcion: terwijl adversativo, el de «mientras QUE» con contraste, que si la lleva — Hij is lang, terwijl zijn broer klein is.

🧭 Los cinco «cuando» del español, que en neerlandes son piezas distintas:
| en español | en neerlandes | cuando se usa |
|---|---|---|
| cuando (pasado, una vez) | **toen** | hecho unico o periodo cerrado: Toen ik jong was… |
| cuando (presente/futuro) | **als** | Als het regent, blijf ik thuis. |
| cuando (pasado REPETIDO) | **als** | cada vez que: Als ik in Amsterdam was, ging ik altijd naar het museum. |
| ¿cuando? | **wanneer** | preguntas: Wanneer kom je? · Ik weet niet wanneer hij komt. |
| mientras | **terwijl** | dos cosas a la vez: Hij belde terwijl ik kookte. |
| en cuanto | **zodra** | Zodra ik thuis ben, bel ik je. |

🔑 Como elegir sin pensar: ¿Es pregunta? wanneer. ¿Es pasado y paso UNA vez? toen. ¿Cabe decir «cada vez que» o «siempre que»? als, aunque sea pasado. ¿Las dos cosas ocurren a la vez? terwijl.

⚠️ tijdens no entra en esta lista: es PREPOSICION, va con sustantivo y no admite sujeto ni verbo detras — tijdens de vergadering, pero terwijl we vergaderden. «Durante que comiamos» no existe.

⚠️ Y el automatismo que nunca falla: con toen, imperfectum SIEMPRE. Nunca «Toen ik jong ben geweest».'
WHERE id IN (521, 522, 523, 524, 1073, 1079, 1115)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🕰️ Las dos vidas de toen%';
