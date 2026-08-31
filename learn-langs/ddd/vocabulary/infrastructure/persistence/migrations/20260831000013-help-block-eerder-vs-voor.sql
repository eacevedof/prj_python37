-- Learn Languages App - Los cinco «antes» del espanol (eerder vs voor), duda de la 827
-- Migration: 20260831000013-help-block-eerder-vs-voor.sql
-- Description: Eduardo en la 827 («De hond bespeurt gevaar eerder dan wij»): «en la ayuda,
--   diferencia eerder vs voor, antonimos». El espanol usa «antes» para CINCO cosas y el
--   neerlandes las reparte, y lo que decide cual toca es lo que viene DETRAS: eerder dan pide el
--   termino con el que comparas (es comparativo), voor pide un sustantivo (es preposicion),
--   voordat pide una oracion con el verbo al final (es conjuncion), eerst es el adverbio de orden
--   y vroeger o eerder el del pasado. «voor wij» no existe y «eerder het eten» tampoco.
--   Bloque ⏱️ IDENTICO byte a byte con esa tabla, la escalera vroeg → eerder → het eerst (misma
--   forma que goed → beter → best), la segunda vida de eerder («mas bien»: Het is eerder groen
--   dan blauw) y los ANTONIMOS por parejas, que es lo que Eduardo pidio y ademas sirve de prueba:
--   eerder ↔ later · vroeg ↔ laat · het eerst ↔ het laatst · voordat ↔ nadat · eerst ↔ daarna, y
--   sobre todo que voor tiene DOS antonimos segun el sentido — na si es tiempo (voor het eten ↔
--   na het eten) y achter si es lugar (voor het huis ↔ achter het huis) —, asi que el antonimo
--   revela cual de los dos voor tienes delante. Cierra con het gevaar ↔ de veiligheid y
--   gevaarlijk ↔ veilig, mas los articulos de la frase.
--   Va a 11 tarjetas: la 827 (que recibe su ayuda en 20260831000012, justo antes), las de voordat
--   (731, 837), la de eerst (734), la de later (532), las de voor temporal (796, 822) y las
--   cuatro del reloj con kwart voor (743, 746, 747, 749).
--   100% aditiva e idempotente: UPDATE con guard por marca.

UPDATE words_es
SET rules_help = rules_help || '

⏱️ Los cinco «antes» del espanol, y cual toca en cada sitio
El espanol dice «antes» para cinco cosas distintas y el neerlandes las separa. Lo que decide cual toca es QUE viene detras:

| en espanol | en NL | que pide detras | ejemplo |
|---|---|---|---|
| antes QUE, comparando | **eerder dan** | el termino con el que comparas | De hond bespeurt gevaar **eerder dan** wij. |
| antes DE + sustantivo | **voor** | un sustantivo | Ik was mijn handen **voor** het eten. |
| antes DE QUE + oracion | **voordat** | una frase, con el verbo AL FINAL | Ik bewerk het bestand **voordat** ik het verstuur. |
| antes, primero, en orden | **eerst** | nada, es adverbio | **Eerst** eten, dan werken. |
| antes, en el pasado | **vroeger** o **eerder** | nada, es adverbio | **Vroeger** rookte hij. · Ik heb hem **eerder** gezien. |

📌 La confusion tipica es entre las dos primeras, y se resuelve mirando lo que va detras. voor es PREPOSICION y necesita un sustantivo (voor het eten, voor tien uur, kwart voor tien). eerder es un COMPARATIVO y necesita algo con que comparar, casi siempre con dan (eerder dan wij, eerder dan verwacht). No son intercambiables: «voor wij» no existe, y «eerder het eten» tampoco.

🪜 eerder es el comparativo de vroeg, o sea un peldano de la escalera del tiempo: vroeg (temprano) → eerder (antes, mas temprano) → het eerst (el primero de todos). La misma escalera que goed → beter → best.

🎭 Y eerder tiene una segunda vida que despista bastante: MAS BIEN. Het is eerder groen dan blauw. — Es mas bien verde que azul. Se reconoce porque ahi no compara momentos sino cualidades.

↔️ Los antonimos van por parejas, y saber cual toca te dice ademas que palabra estas usando:
• eerder ↔ later (mas tarde). Y la escalera entera, vroeg ↔ laat, het eerst ↔ het laatst.
• voor en su sentido de TIEMPO ↔ na (despues de). voor het eten ↔ na het eten.
• voor en su sentido de LUGAR ↔ achter (detras de). voor het huis ↔ achter het huis. Es la misma palabra con dos antonimos distintos, asi que el antonimo revela cual de los dos voor tienes delante.
• voordat ↔ nadat. Y eerst ↔ daarna.

🔤 Las palabras de la frase, con su articulo y su antonimo: het gevaar (el peligro) ↔ de veiligheid (la seguridad), con los adjetivos gevaarlijk ↔ veilig. Y ademas de hond (el perro), het eten (la comida), het huis (la casa).',
    updated_at = datetime('now')
WHERE id IN (532, 731, 734, 743, 746, 747, 749, 796, 822, 827, 837)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%⏱️ Los cinco «antes» del espanol%';
