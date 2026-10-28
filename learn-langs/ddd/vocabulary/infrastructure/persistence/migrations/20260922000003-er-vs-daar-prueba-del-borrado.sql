-- Learn Languages App - Migration
-- Migration: 20260922000003-er-vs-daar-prueba-del-borrado
-- Description: Eduardo, sobre la 261: "en 261 mejora la ayuda, er vs daar no entiendo eso q no
--   señalar, es decir si me dicen has estado en marruecos? (contesto) no, nunca he estado (ese es
--   un alli oculto)?" y despues: "si, es asi, pq en español pones allí y la traduces con er?".
--
--   Las dos preguntas apuntan al mismo agujero. La ayuda decia «sin señalar → er; señalando o
--   contrastando → daar», y ESO NO ES APLICABLE: cuando dices «alli» te parece que siempre estas
--   señalando, asi que el criterio no decide nada. Ademas el enunciado de la tarjeta («nunca he
--   estado alli») lleva un «alli» explicito y se traduce con er, que es justo lo que parecia
--   contradecir la regla.
--
--   Lo que decide de verdad no es señalar, es ACENTUAR: el español tiene UNA palabra («alli»)
--   para lo que el neerlandes parte en dos, er (atono, nunca acentuable) y daar (tonico). En
--   «nunca he estado alli» el «alli» va al final y sin peso -> atono -> er. Con daar el español
--   natural seria anteponerlo: «Alli no he estado nunca».
--
--   Se mete la PRUEBA DEL BORRADO, que es la version operativa y la que Eduardo intuyo solo con
--   su ejemplo de Marruecos: si puedes borrar el «alli» y la frase española sigue en pie, era
--   atono -> er (y en neerlandes es OBLIGATORIO aunque el español lo haya tirado). Si al borrarlo
--   se cae la frase o pierde el contraste, era tonico -> daar o hier.
--
--   Cambios, los dos en la 261 (el bloque ER LOCATIVO solo existe en esta tarjeta):
--     1. El texto ES pasa a «nunca he estado allí (átona)», con la marca que el mazo ya usa para
--        atono/tonico en los pronombres (142, 439, 1058…). Asi el enunciado dice que se pide er.
--     2. El bloque inicial se reescribe entero: criterio de acentuacion, prueba del borrado, el
--        dialogo de Marruecos y el par minimo con la misma frase en las dos versiones.
--
--   AUDIO (§5.6.5): la 261 no tiene audio es_ES generado (word_es_media vacio), asi que cambiar
--   el texto no desincroniza nada.

-- =====================================================================================
-- 1) La marca (átona) en el enunciado
-- =====================================================================================

UPDATE words_es
SET text = 'nunca he estado allí (átona)'
WHERE text = 'nunca he estado allí';

-- =====================================================================================
-- 2) El bloque er/daar, reescrito con un criterio que se pueda aplicar
-- =====================================================================================

UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    'ER LOCATIVO = «allí» átono, sin énfasis. Es la versión débil de daar:
• Ik ben er nooit geweest. — Nunca he estado (allí).
• Ik kom er vaak. — Voy mucho (por allí). · Het is er mooi. — Allí es bonito.
ER nunca puede llevar énfasis ni ir en primera posición; DAAR sí:
DAAR ben ik nooit geweest! — ¡ALLÍ no he estado nunca!
Regla: sin señalar → er; señalando/contrastando → daar (o hier).',
    '🎯 er o daar, y el criterio no es señalar sino ACENTUAR: El español tiene UNA palabra, alli, para lo que el neerlandes parte en dos: er es atono y no se puede pronunciar con enfasis; daar es tonico y sirve para destacar o contrastar. Por eso «señalar» no vale como criterio: al decir alli siempre parece que señalas.

✂️ La prueba del borrado, que decide en un segundo: Quita el alli de la frase española. Si la frase sigue en pie, ese alli era atono → er. Si al quitarlo la frase se cae o pierde el contraste, era tonico → daar.

• Nunca he estado (alli). — se puede borrar → Ik ben er nooit geweest.
• Alli no he estado nunca, aqui si. — no se puede borrar → Daar ben ik nooit geweest.

💬 El alli oculto, que es donde falla un hispanohablante:
— Ben je ooit in Marokko geweest? (¿has estado alguna vez en Marruecos?)
— Nee, ik ben er nooit geweest. (no, nunca he estado)
El español TIRA el lugar y dice solo «nunca he estado». El neerlandes no puede: er es obligatorio aunque en español no quede ni rastro. Esa casilla vacia del castellano es la razon de que er se resista — el frances la tiene (J''y suis), el catalan tambien (Ja hi soc), el español no.

📋 La misma frase, en sus dos versiones:
| lo que dices | en neerlandes | por que |
|---|---|---|
| Nunca he estado alli. | Ik ben **er** nooit geweest. | alli de relleno, borrable → atono |
| ¡ALLI no he estado nunca! | **Daar** ben ik nooit geweest! | alli con enfasis, y por eso abre la frase |
| Voy mucho por alli. | Ik kom **er** vaak. | nadie acentua ese por alli |
| Alli es bonito. | Het is **er** mooi. | el sitio ya se sabe, no se destaca |

⚠️ Los dos limites de er, que salen de que no admite acento: no puede abrir frase con este valor y no se puede pronunciar con fuerza. Si quieres destacar el sitio, daar o hier a la fuerza.'
)
WHERE rules_help LIKE '%ER LOCATIVO = «allí» átono%';
