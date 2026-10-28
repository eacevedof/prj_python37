-- Learn Languages App - Migration
-- Migration: 20260907000010-lukken-vs-goedkomen
-- Description: Eduardo pide "ayuda de lukken vs goedkomen". El mazo tiene los dos verbos
--   repartidos en cinco tarjetas (301 Het zal wel goedkomen, 303 Zal het lukken?, 310
--   Komt het goed?, 318 Zonder jou zou het niet lukken, 333 Ik hoop dat alles goed komt) y
--   ninguna los compara.
--
--   La diferencia: los dos se traducen por salir bien, pero miran cosas distintas. lukken
--   es que una ACCION CONCRETA tenga exito, con un intento detras; goedkomen es que una
--   SITUACION acabe arreglandose con el tiempo, y es la formula de consolar. Por eso
--   Lukt het? se le dice a quien pelea con una maleta y Het komt wel goed a quien esta
--   preocupado por el futuro.
--
--   El gotcha gramatical de lukken merece la migracion el solo: la persona NUNCA es el
--   sujeto. La cosa es la que lukt y la persona va en DATIVO — Het lukt me, y nunca
--   «Ik luk het», que es la tentacion directa de un hispanohablante que piensa en yo lo
--   consigo. Ademas su auxiliar es zijn (Het is gelukt, no «het heeft gelukt»).
--
--   El bloque incluye el mapa completo del campo, con los rivales que tampoco estaban en
--   el mazo: slagen (aprobar), het redden (apañarselas, llegar), voor elkaar krijgen
--   (conseguir con esfuerzo), werken (funcionar, de aparatos), goed aflopen (acabar bien)
--   y uitpakken (resultar), que ya vive en el grupo 35 de variantes de coger.
--
--   Pendiente, no entra aqui: Het lukt me niet y Ik red het niet son frases de uso diario
--   y no existen como tarjetas. Se deja apuntado.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

UPDATE words_es
SET rules_help = rules_help || '

🎯 lukken o goedkomen, que no son lo mismo:

Los dos se traducen por salir bien, pero miran a cosas distintas: lukken es que una accion CONCRETA tenga exito, y goedkomen es que una SITUACION acabe arreglandose.

| verbo | que dice | ejemplo |
|---|---|---|
| **lukken** | una accion concreta sale, se consigue | Het **lukt** me niet. (no me sale) |
| **goedkomen** | una situacion se arregla con el tiempo | Het **komt** wel **goed**. (ya veras) |
| **slagen** | aprobar, tener exito formal | Ik ben **geslaagd** voor mijn examen. |
| **het redden** | apañarselas, llegar a tiempo | Ik **red** het niet. (no llego) |
| **voor elkaar krijgen** | conseguir a base de esfuerzo | Ik heb het **voor elkaar**. |
| **werken** | funcionar, de aparatos | Het **werkt** niet. |
| **goed aflopen** | acabar bien, una historia | Het is goed **afgelopen**. |
| **uitpakken** | resultar de una manera | Dat **pakt** goed **uit**. |

📌 Regla de bolsillo:
• ¿Intentas algo y quieres saber si te sale? → lukken.
• ¿Alguien esta preocupado y quieres tranquilizarlo? → goedkomen.
• ¿Es un examen, una oposicion o una candidatura? → slagen.
• ¿Es cuestion de llegar a tiempo o de poder con ello? → het redden.
• ¿Es un aparato que no va? → werken.

⚠️ El gotcha gordo de lukken. La persona NUNCA es el sujeto: la cosa es la que lukt, y tu vas en DATIVO. Se dice Het lukt me, y nunca «Ik luk het», que es la tentacion directa del yo lo consigo español.

📊 lukken, por la persona a la que le sale:

| a quien | presente | imperfecto |
|---|---|---|
| ik | het lukt **me** | het lukte **me** |
| jij / je | het lukt **je** | het lukte **je** |
| u | het lukt **u** | het lukte **u** |
| hij / zij / het | het lukt **hem / haar** | het lukte **hem / haar** |
| wij | het lukt **ons** | het lukte **ons** |
| jullie | het lukt **jullie** | het lukte **jullie** |
| zij (plural) | het lukt **ze** | het lukte **ze** |

• participio — gelukt, y el auxiliar es ZIJN: Het is gelukt. Nunca «het heeft gelukt».
• con infinitivo detras se usa om te: Het lukt me niet om de deur open te krijgen.
• tambien admite sujeto concreto, no solo het: De taart is gelukt (el pastel ha salido bien), Het plan is gelukt.

📐 goedkomen es SEPARABLE (goed + komen), asi que se parte como todos: Het komt goed en principal, Het is goedgekomen en perfecto (con zijn, porque komen es de movimiento), dat het goedkomt en subordinada y om goed te komen con te.

💬 Las frases hechas de cada uno, que son las que vas a oir:
• Het komt wel goed. — Ya veras como se arregla. Es LA frase de consolar en neerlandes.
• Komt goed! — ¡Hecho!, ¡tranquilo! Respuesta rapida y muy holandesa a un encargo.
• Lukt het? — ¿Te sale?, ¿puedes? Lo que te preguntan si te ven peleando con algo.
• Het is gelukt! — ¡Lo he conseguido!
• Dat gaat niet lukken. — Eso no va a poder ser.
• Ik red het niet. — No llego, no me da tiempo.

🔑 El truco para elegir entre los dos: Pregunta si hay un INTENTO detras. Si alguien esta intentando algo ahora, lukken. Si solo hay preocupacion y tiempo por delante, goedkomen. Por eso Lukt het? se le dice a quien pelea con una maleta, y Het komt wel goed a quien esta preocupado por como acabara algo.

🏋️ Ejercicio: «no me sale» → Het ___ me niet. Y «ya se arreglara» → Het ___ wel ___. (Respuestas: lukt · komt … goed.)'
WHERE id IN (301, 303, 310, 318, 333)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🎯 lukken o goedkomen%';
