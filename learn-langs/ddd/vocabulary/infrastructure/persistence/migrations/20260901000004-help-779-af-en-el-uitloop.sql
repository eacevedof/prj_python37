-- Learn Languages App - la 779: ¿puede el «af» quedarse al final del todo? (vielen na… af)
-- Migration: 20260901000004-help-779-af-en-el-uitloop.sql
-- Description: Eduardo sobre el ejemplo de la 779 (Twee kandidaten vielen af na de eerste ronde):
--   «¿podria ser Twee kandidaten vielen na de eerste ronde af?». Si — y ademas su variante es el
--   orden de manual: la particula del separable cierra la frase (la formula 📐 que la propia
--   tarjeta ya trae). El ejemplo de la tabla usa la extraposicion (uitloop): el grupo
--   preposicional «na de eerste ronde» se sale DETRAS del af y queda destacado como informacion
--   nueva. Es el mismo fenomeno ya explicado en la 822 (Ze wil afvallen voor de zomer) y en la
--   840 (is opgericht in 1990). Se añade a la 779 un bloque 🧲 con las dos variantes, el enlace
--   con la fila 2 de su tabla y el truco: solo un grupo CON preposicion (u oracion subordinada)
--   puede saltarse el cierre; un adverbio pelado jamas (vielen af gisteren ✗).
--   Idempotente: guard por la marca 🧲 y por rules_help IS NOT NULL (gotcha del NULL).

PRAGMA foreign_keys = ON;

UPDATE words_es
SET rules_help = rules_help || '

🧲 ¿Puede el af quedarse al final del todo? — vielen af na… frente a vielen na… af:

Si: Twee kandidaten vielen na de eerste ronde af es correcta, y ademas es el orden de manual — la particula af cierra la frase, como dice la formula 📐 de arriba. En el ejemplo de la tabla, Twee kandidaten vielen af na de eerste ronde, el grupo preposicional na de eerste ronde se ha salido DETRAS del af (extraposicion, uitloop) y queda destacado como informacion nueva: el cuando.
• Twee kandidaten vielen na de eerste ronde af. — orden neutro: la noticia es que quedaron eliminados.
• Twee kandidaten vielen af na de eerste ronde. — foco en el momento: fue TRAS la primera ronda.
• Ze wil afvallen voor de zomer. — el mismo fenomeno con el infinitivo (la fila 2 de la tabla): foco en el plazo.

🔑 El truco que casi nunca falla: solo puede saltarse el cierre un grupo CON preposicion (na…, voor…, in…) o una oracion entera (voordat…, omdat…); un adverbio pelado jamas: «Ze vielen af gisteren» ✗ → Ze vielen gisteren af.'
WHERE id = 779 AND text = 'adelgazar'
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧲%';
