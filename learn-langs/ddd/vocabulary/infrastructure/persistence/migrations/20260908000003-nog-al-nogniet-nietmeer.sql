-- Learn Languages App - Migration
-- Migration: 20260908000003-nog-al-nogniet-nietmeer
-- Description: Eduardo, sobre la tarjeta 1038 (Hij leeft nog = todavia vive): "q se
--   entenderia con hij leeft nog steeds?".
--
--   Se entenderia, y es correcto, pero dice otra cosa: nog es todavia a secas, neutro, y
--   nog steeds es todavia Y SIGUE, con enfasis. Hij leeft nog es lo que dices tras un
--   accidente, sigue vivo; Hij leeft nog steeds suena a asombro, sigue vivo despues de
--   todo o con lo mayor que es. nog steeds subraya que la situacion dura mas de lo
--   esperado, y casi siempre lleva sorpresa, impaciencia o insistencia detras.
--
--   La duda destapa un hueco mayor: el mazo usa nog steeds dos veces (656, 725), al cinco
--   (322, 363, 552, 616, 665), niet meer una (588) y nog niet ninguna, pero NADA explica
--   que las cuatro forman un cuadrado cerrado. Y es de lo mas util del neerlandes, porque
--   las negaciones no son las que un hispanohablante espera: la negacion de al no es
--   «niet al» sino NOG NIET, y la de nog no es «niet nog» sino NIET MEER.
--     al (ya)      ↔  nog niet (todavia no)
--     nog (todavia) ↔  niet meer (ya no)
--
--   Se escribe el bloque compartido "⏳ al, nog, nog niet y niet meer" y se inyecta en las
--   tarjetas que usan alguno de los cuatro. La 1038 se lleva ademas la respuesta concreta
--   sobre nog frente a nog steeds y nog altijd.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. La 1038: la duda concreta
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: ¿Que se entenderia con Hij leeft nog steeds?

🔑 La diferencia: Se entenderia, y es correcto, pero dice otra cosa. nog es todavia a secas, constata que la situacion sigue, sin mas. nog steeds es todavia Y SIGUE, con enfasis: subraya que dura mas de lo esperado, y casi siempre lleva sorpresa, impaciencia o insistencia detras.

| frase | lo que transmite |
|---|---|
| Hij leeft **nog**. | Todavia vive. Neutro, es lo que dices tras un accidente: sigue vivo. |
| Hij leeft **nog steeds**. | Sigue vivo todavia. Con asombro: con lo mayor que es, o despues de todo lo que ha pasado. |
| Hij leeft **nog altijd**. | Lo mismo que nog steeds, algo mas literario. |
| Hij leeft **niet meer**. | Ya no vive. Es la negacion de nog, y no «niet nog». |

⚠️ Fijate en la ultima fila, que es lo importante: la negacion de nog NO se hace poniendo niet delante. Se cambia la palabra entera por niet meer. Y lo mismo pasa con al, cuya negacion es nog niet.

💬 nog steeds es de las que oiras a diario cuando alguien esta harto de esperar: Ben je er nog steeds niet? (¿pero todavia no has llegado?), Het regent nog steeds (sigue lloviendo, y ya cansa), Ik wacht nog steeds op antwoord (sigo esperando respuesta).

🏋️ Ejercicio: «¿todavia trabajas alli?» con enfasis de que ya va siendo mucho tiempo → Werk je daar ___ ___? (Respuesta: nog steeds.)'
WHERE id = 1038
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';

-- =============================================================================
-- 2. Bloque compartido: el cuadrado de al, nog, nog niet y niet meer
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

⏳ al, nog, nog niet y niet meer, que forman un cuadrado cerrado:

Son cuatro piezas que se responden entre si, y la trampa esta en las negaciones: NO se hacen poniendo niet delante, sino cambiando la palabra entera.

| | afirmando | negando |
|---|---|---|
| lo que ya ha pasado | **al** (ya) | **nog niet** (todavia no) |
| lo que sigue pasando | **nog** (todavia) | **niet meer** (ya no) |

📋 Las cuatro en accion, con su pregunta y su respuesta:
• Ben je er al? — ¿Ya has llegado? → Nee, nog niet. (no, todavia no)
• Woon je hier nog? — ¿Todavia vives aqui? → Nee, niet meer. (no, ya no)
• Heb je al gegeten? — ¿Ya has comido? → Nee, ik heb nog niet gegeten.
• Werkt hij hier nog? — ¿Todavia trabaja aqui? → Nee, hij werkt hier niet meer.

⚠️ La negacion de al NO es «niet al» sino nog niet. Y la de nog NO es «niet nog» sino niet meer. Es lo que mas se falla, porque en español si decimos todavia no y ya no con las mismas piezas.

🔤 Y con SUSTANTIVO, niet se cambia por geen, igual que siempre:
• Ik heb nog geen tijd gehad. — Todavia no he tenido tiempo.
• Ik heb geen tijd meer. — Ya no tengo tiempo.
Fijate en donde cae el meer: va al final, separado de geen.

🎚️ Y las versiones enfaticas de nog:
• nog — todavia. Neutro. Hij leeft nog.
• nog steeds — todavia y sigue. Con sorpresa o impaciencia. Het regent nog steeds.
• nog altijd — lo mismo, algo mas literario.
• nog maar — solo, apenas. Ik ben er nog maar net. (acabo de llegar)
• nog een — otro mas. Nog een biertje? (¿otra cerveza?)

🔑 El truco: Piensa en el cuadrado, no en las palabras sueltas. Si quieres negar un al, salta a nog niet; si quieres negar un nog, salta a niet meer. Nunca metas un niet delante de ninguno de los dos.'
WHERE id IN (
    SELECT wl.word_es_id FROM words_lang wl
    WHERE wl.lang_code = 'nl_NL'
      AND (lower(' ' || wl.text || ' ') LIKE '% nog %'
           OR lower(' ' || wl.text || ' ') LIKE '% nog.%'
           OR lower(' ' || wl.text || ' ') LIKE '% al %'
           OR lower(' ' || wl.text || ' ') LIKE '% niet meer %'
           OR lower(' ' || wl.text || ' ') LIKE '% niet meer.%')
)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%⏳ al, nog, nog niet y niet meer%';
