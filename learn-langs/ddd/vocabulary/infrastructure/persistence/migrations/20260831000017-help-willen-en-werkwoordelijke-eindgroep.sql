-- Learn Languages App - willen, el corchete verbal y las tres colocaciones (dudas de la 822)
-- Migration: 20260831000017-help-willen-en-werkwoordelijke-eindgroep.sql
-- Description: Eduardo en la 822 («Ze wil afvallen voor de zomer»), tres preguntas: la
--   conjugacion de willen; si valdria «Ze wil voor de zomer afvallen»; por que unas veces el
--   verbo va al final y otras no; y si una alternativa seria «eerder de zomer wil ze afvallen».
--   Respuestas: (1) bloque 📊 con la conjugacion completa, las dos formas correctas jij wil y jij
--   wilt, el imperfecto coloquial wou frente al escrito wilde, y sobre todo el DOBLE INFINITIVO
--   en el perfecto (Ze heeft willen afvallen, nunca «heeft gewild afvallen»), que es por lo que el
--   participio gewild casi no se ve — mas gewild como adjetivo («solicitado») y los vecinos
--   (weigeren, zin hebben in, wensen, hopen). Va a las 10 tarjetas de willen.
--   (2) bloque 🔓 sobre el corchete verbal: verbo conjugado en la casilla 2, los demas al final, y
--   la lista de lo que PUEDE salirse detras del cierre (grupos preposicionales, comparaciones con
--   dan/als, subordinadas) frente a lo que NO (objeto directo, niet, adverbios sueltos). De ahi
--   que las dos versiones de Eduardo sean correctas y solo cambie el foco, y que «Ze wil afvallen
--   vijf kilo» sea imposible. Va a 313, 413, 652, 822 y 830 (esta ultima ensena lo mismo con
--   «benaderd door een recruiter», donde el grupo preposicional sale detras del participio).
--   (3) bloque 🧪 solo en la 822 con las tres colocaciones validas y por que la cuarta no lo es:
--   no es problema de orden sino de palabra — eerder es comparativo y no rige sustantivo, «antes
--   del verano» es voor de zomer; arreglando eso, «Voor de zomer wil ze afvallen» es correcta.
--   Enlaza con el bloque de los cinco «antes» (20260831000013).
--   100% aditiva e idempotente: UPDATE con guard por marca.


-- ==============================================================================
-- 1. Conjugacion de willen, en las 10 tarjetas del verbo
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

📊 Conjugacion de willen, que es modal e irregular

| persona | presente | imperfecto |
|---|---|---|
| ik | wil | wilde, o wou al hablar |
| jij / je | wil o wilt | wilde, o wou |
| u | wilt | wilde |
| hij / zij / het | wil | wilde, o wou |
| wij | willen | wilden |
| jullie | willen | wilden |
| zij (plural) | willen | wilden |

• participio = gewild, con auxiliar hebben, aunque casi nunca lo vas a usar (mira el aviso de abajo).
• jij wil y jij wilt son las DOS correctas. wilt suena algo mas cuidado, y con u es la unica posible: u wilt.
• wou es el imperfecto coloquial y se oye constantemente. Ik wou je wat vragen. En escrito se pone wilde. El plural wouden se oye pero esta mal visto: mejor wilden.

⚠️ El participio casi no aparece, y esto descoloca mucho: cuando willen lleva OTRO infinitivo detras, el perfecto se hace con DOBLE INFINITIVO y no con participio.
• Ze heeft willen afvallen. — Ha querido adelgazar. Nunca «heeft gewild afvallen».
• Dat heb ik nooit gewild. — Eso nunca lo he querido. Aqui willen va solo, y entonces si lleva participio.
Funciona igual con los demas modales: heeft kunnen komen, heeft moeten werken, heeft mogen blijven.

🎭 Y gewild tiene otra vida como adjetivo, solicitado o muy buscado. Een gewild product. — Un producto muy demandado.

↔️ Antonimos y vecinos: willen ↔ weigeren (negarse). Y no confundas querer con sus vecinos: graag willen o zin hebben in es apetecer, wensen es desear en registro formal, y hopen es esperar, que es otra cosa. Los sustantivos, con su articulo: de wil (la voluntad), de wens (el deseo).',
    updated_at = datetime('now')
WHERE id IN (313, 317, 368, 413, 441, 470, 475, 478, 652, 822)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%📊 Conjugacion de willen%';

-- ==============================================================================
-- 2. El corchete verbal y lo que puede salirse
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🔓 Que puede salirse detras del verbo final, y por que hay varias frases correctas
En una principal, el verbo conjugado va en la casilla 2 y TODOS los demas verbos se van al final. Entre los dos queda el campo medio, y el conjunto forma un corchete: Ze WIL … AFVALLEN. La pregunta util es que puede colarse DETRAS del cierre, y la respuesta es que solo unas pocas cosas.

| puede salirse detras del verbo final | no puede salirse |
|---|---|
| grupos preposicionales: **voor de zomer**, **door een recruiter**, **naar Amsterdam** | el objeto directo: vijf kilo, het boek |
| comparaciones con dan o als: **eerder dan wij** | la negacion niet |
| oraciones subordinadas enteras: **dat het regent** | los adverbios sueltos de tiempo y de modo |

📌 De ahi que haya mas de una frase correcta para lo mismo, y que solo cambie el foco:
• Ze wil voor de zomer afvallen. — Todo dentro del corchete. Es la neutra.
• Ze wil afvallen voor de zomer. — El grupo preposicional se sale y queda destacado, como informacion nueva.
• Voor de zomer wil ze afvallen. — En la casilla 1, que obliga a la inversion (wil ze). Tematiza el plazo, lo pone de titulo.

⚠️ Lo que NO se puede es sacar un objeto directo. «Ze wil afvallen vijf kilo» es imposible: tiene que ser Ze wil vijf kilo afvallen. Si dudas, mete todo dentro del corchete, que nunca falla; sacar cosas es opcional y solo vale para grupos preposicionales, comparaciones y subordinadas.

🔒 En subordinada no hay casilla 2 y todos los verbos se juntan al final: …dat ze voor de zomer wil afvallen. El grupo preposicional tambien puede salirse ahi: …dat ze wil afvallen voor de zomer.',
    updated_at = datetime('now')
WHERE id IN (313, 413, 652, 822, 830)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🔓 Que puede salirse detras del verbo final%';

-- ==============================================================================
-- 3. Las tres colocaciones de la 822 y la que no vale
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧪 Las tres colocaciones de esta frase, y una que no vale
Las tres primeras son correctas y solo cambian el foco:
• Ze wil voor de zomer afvallen. — La neutra, con todo dentro del corchete.
• Ze wil afvallen voor de zomer. — Destaca el plazo, que sale detras del infinitivo. Es la de esta tarjeta.
• Voor de zomer wil ze afvallen. — Tematiza el plazo poniendolo en la casilla 1, con inversion.

❌ Lo que NO vale es «eerder de zomer wil ze afvallen», por una razon que no tiene que ver con el orden sino con la palabra: eerder es un COMPARATIVO y no puede regir un sustantivo. «Antes del verano» es voor de zomer, con preposicion. eerder pide algo con que comparar, casi siempre con dan: Ze wil eerder afvallen dan haar zus. — Quiere adelgazar antes que su hermana.

📌 O sea que el orden que proponias era bueno: arreglando la primera palabra queda Voor de zomer wil ze afvallen, que es perfectamente correcta y ademas enfatica.',
    updated_at = datetime('now')
WHERE id IN (822)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧪 Las tres colocaciones de esta frase%';
