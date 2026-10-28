-- Learn Languages App - Migration
-- Migration: 20260910000001-orden-hier-daar-er-y-foco
-- Description: Eduardo, sobre la 1102 (Ik woon hier al vijf jaar): "no entiendo la frase
--   ik woon hier al vijf jaar: se supone q la formula es sujeto verbo tiempo manera lugar
--   y aqui priorizamos lugar antes q tiempo". Y despues: "explicame un poco mejor esto:
--   tiende al final porque es la informacion nueva y focal, dame algunos ejemplos".
--
--   La premisa no falla, falla el alcance de la regla: TMP ordena complementos de LUGAR
--   con preposicion. hier, daar y er son adverbios deicticos cortos y atonos que se pegan
--   al verbo y pasan por delante del tiempo. Con er no es estilo, es agramatical
--   («Ik woon al vijf jaar er» no existe), igual que con los pronombres personales
--   («Ik zie morgen hem»). El contraste real no es tiempo frente a lugar, es lugar LIGERO
--   frente a lugar PESADO: Ik woon hier al vijf jaar frente a Ik woon al vijf jaar in
--   Amsterdam.
--
--   Y hay un segundo motivo, que es el que pidio ampliar: el middenstuk se ordena de lo
--   CONOCIDO a lo NUEVO, y el final de la frase es donde cae el acento. al vijf jaar es el
--   dato; hier ya se sabe. Se explica con el test de la pregunta (lo que responde va el
--   ultimo) y con el par definido/indefinido del objeto directo, que es donde mas se nota
--   (het boek gisteren gelezen frente a gisteren een boek gelezen). Ademas se advierte de
--   que al vijf jaar no es un "cuando" sino una DURACION (hoelang), que no es lo que TMP
--   ordena.
--
--   Bloque compartido (§3.3 del howto), marca «🧭 Donde va el lugar cuando es hier», a cuatro
--   tarjetas donde aparece el mismo fenomeno:
--     - 1102 Ik woon hier al vijf jaar   (la que pregunto)
--     - 1100 Ik woon hier sinds 2020     (mismo esquema, grupo desde)
--     - 437  Ik kom er vaak              (er delante del adverbio de frecuencia)
--     - 269  en                          (es la tarjeta que lleva la chuleta TMP F1-F5:
--                                         la excepcion tiene que estar donde esta la regla)
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

UPDATE words_es
SET rules_help = rules_help || '

🧭 Donde va el lugar cuando es hier, daar o er

La formula que se aprende es sujeto + verbo + TIEMPO + MANERA + LUGAR, y frases como Ik woon hier al vijf jaar parecen romperla, porque el lugar va delante del tiempo. No la rompen: es que hier no cuenta como un lugar normal.

📐 Lugar LIGERO frente a lugar PESADO: TMP ordena los complementos de lugar con PREPOSICION. Los adverbios hier, daar y er son cortos y atonos, se pegan al verbo conjugado y pasan por delante del tiempo.

| el lugar es… | donde va | ejemplo |
|---|---|---|
| **hier / daar / er** | pegado al verbo, ANTES del tiempo | Ik woon **hier** al vijf jaar. |
| **preposicion + lugar** | detras del tiempo, TMP normal | Ik woon al vijf jaar **in Amsterdam**. |

⚠️ Con er no es cuestion de estilo, es agramatical: Ik woon er al vijf jaar si, «Ik woon al vijf jaar er» no existe. Lo mismo con los pronombres personales: Ik zie hem morgen, nunca «Ik zie morgen hem».

📋 Tres pares, lugar ligero frente a lugar pesado:
• Ik werk hier sinds januari. — Ik werk sinds januari in Utrecht.
• Ik kom er vaak. — Ik kom vaak in dat restaurant.
• Ik ken hem al jaren. — Ik ken die man al jaren.

📐 Y ademas al vijf jaar no es un cuando: TMP ordena el momento (wanneer: morgen, om drie uur, in 2020) y esto es una DURACION (hoelang), que tira al final por lo que viene ahora.

🎯 Lo conocido delante, lo nuevo al final

El medio de la frase neerlandesa se ordena de lo VIEJO a lo NUEVO: lo que el que escucha ya tiene en la cabeza se pega al verbo, y lo que aporta el dato cae al final, que es donde el neerlandes pone el acento de la frase. Por eso al vijf jaar cierra la frase: hier ya se sabe, cinco años es la noticia.

🔑 El test de la pregunta:

Lo que responde a la pregunta va el ULTIMO. Con las mismas palabras, cambia la pregunta y cambia el orden.
• Hoelang woon je hier al? → Ik woon hier al vijf jaar. (el dato es la duracion)
• Waar woon je al vijf jaar? → Ik woon al vijf jaar in Amsterdam. (el dato es el lugar)
• Wanneer heb je hem gezien? → Ik heb hem gisteren gezien. (el dato es el cuando)

📋 El objeto directo, definido frente a indefinido:

Es donde mas se nota, porque el articulo ya te dice si la cosa es conocida o nueva.

| frase | traduccion | por que |
|---|---|---|
| Ik heb **het boek** gisteren gelezen. | Lei el libro ayer. | het boek ya se sabe cual es, es conocido → delante del tiempo |
| Ik heb gisteren **een boek** gelezen. | Ayer lei un libro. | een boek es nuevo → detras del tiempo |
| Ik heb **hem** gisteren gezien. | Lo vi ayer. | pronombre, lo mas conocido que existe → siempre delante |

📌 Regla de bolsillo, mira QUE es el complemento:
• ¿Es un pronombre o un adverbio corto (hem, het, ze, er, hier, daar)? → delante, pegado al verbo.
• ¿Lleva de/het/mijn y ya se sabe de que hablas? → delante.
• ¿Lleva een, un numero, o es justo lo que responde a la pregunta? → al final.
• ¿Es un complemento con preposicion? → TMP normal, detras del tiempo.

⚠️ Y si quieres el foco en otra pieza, la sacas al frente con inversion: Al vijf jaar woon ik hier. Eso ya no es orden neutro, es enfasis: cinco años ya.

🏋️ Ejercicio: «lo conozco desde hace años» → Ik ken ___ ___ jaren. (Respuesta: hem al.)'
WHERE id IN (1102, 1100, 437, 269)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧭 Donde va el lugar cuando es hier%';
