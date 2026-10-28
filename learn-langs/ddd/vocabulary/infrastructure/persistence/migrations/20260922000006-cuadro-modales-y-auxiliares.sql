-- Learn Languages App - Migration
-- Migration: 20260922000006-cuadro-modales-y-auxiliares
-- Description: Eduardo, sobre la 930: "en 930 enumera todos los modales y los auxiliares".
--
--   El mazo los tenia sueltos: cada tarjeta WORD del grupo (922 willen, 923 kunnen, 924 moeten,
--   925 mogen) lleva SU conjugacion, y el bloque del participio fantasma los nombra de pasada,
--   pero no habia NINGUN sitio con la lista completa ni con los auxiliares al lado. Para saber
--   cuantos modales hay y en que se diferencian de hebben/zijn/worden habia que reconstruirlo
--   saltando de tarjeta en tarjeta.
--
--   Se añade el bloque '🧰 Los seis modales y los tres auxiliares' (§3.3) con:
--     - los SEIS modales (kunnen, mogen, moeten, willen, zullen, hoeven) en una tabla con
--       presente, imperfectum y participio, mas lo que cada uno significa de verdad.
--     - los TRES auxiliares (hebben, zijn, worden) con sus formas y para que sirve cada uno,
--       incluida la pasiva worden (accion) frente a zijn (estado).
--     - los no-modales que TAMBIEN hacen doble infinitivo (laten, doen, zien, horen, voelen,
--       gaan, komen, blijven, helpen, leren), que es la lista que el bloque 🎭 citaba a medias.
--     - las rarezas que se preguntan siempre: zullen no tiene participio, hoeven solo vive en
--       negacion y con te, jij kunt/kan y jij zult/zal, wou como coloquial de wilde, y mogen con
--       el sentido de gustar (Ik mag hem wel).
--
--   Va a las 20 tarjetas del grupo de modales (922-941), que son las que ya comparten el bloque
--   🎭 del participio fantasma.
--
--   FORMATO (§4.0, §4.4 y §4.7): negritas solo dentro de tablas, un unico «:» por rotulo y cero
--   arte ASCII — las tres trampas del formateador que se comieron el bloque de la 659.
--
--   AUDIO (§5.6.5): solo toca rules_help, no hay audio que regenerar.

UPDATE words_es
SET rules_help = rules_help || '

🧰 Los seis modales y los tres auxiliares: Los modales son seis y no mas; todo lo demas que parece modal es un verbo normal que arrastra un infinitivo. Estos seis llevan el infinitivo DESNUDO, sin te (salvo hoeven, que si lo lleva).

| modal | que dice de verdad | presente (ik · jij · hij) | imperfectum | participio, si va solo |
|---|---|---|---|---|
| **kunnen** | poder, ser capaz, saber hacer | kan · kunt/kan · kan | **kon** · konden | gekund |
| **mogen** | tener permiso, estar permitido | mag · mag · mag | **mocht** · mochten | gemogen |
| **moeten** | tener que, deber | moet · moet · moet | **moest** · moesten | gemoeten |
| **willen** | querer | wil · wilt/wil · wil | **wilde** o wou · wilden | gewild |
| **zullen** | futuro y probabilidad | zal · zult/zal · zal | **zou** · zouden | no tiene |
| **hoeven** | hacer falta, en negacion | hoef · hoeft · hoeft | **hoefde** · hoefden | gehoeven, rarisimo |

📌 Lo que se pregunta siempre de esta tabla, por orden de importancia.
• zullen no tiene participio — su pasado es zou/zouden, y de ahi sale el condicional: Ik zou graag willen.
• hoeven solo vive en NEGACION y lleva te — Je hoeft niet te komen. En afirmativa se usa moeten.
• jij kunt y jij zult son lo correcto en escrito; jij kan y jij zal son la variante hablada, ya aceptada.
• al invertir, jij pierde la -t — Kun je me helpen? Zul je er zijn?
• wou es el imperfecto coloquial de willen; wilde es el neutro, y el que conviene escribir.
• mogen tambien significa gustar cuando va sin infinitivo — Ik mag hem wel. (me cae bien)

| auxiliar | para que sirve | presente (ik · jij · hij) | imperfectum | participio |
|---|---|---|---|---|
| **hebben** | perfecto de casi todo, y tener | heb · hebt · heeft | **had** · hadden | gehad |
| **zijn** | perfecto de cambio de lugar o estado, y ser/estar | ben · bent · is | **was** · waren | geweest |
| **worden** | pasiva de accion, y volverse o llegar a ser | word · wordt · wordt | **werd** · werden | geworden |

⚖️ La pasiva usa los dos, y no dicen lo mismo. Worden describe la ACCION mientras ocurre y zijn el ESTADO en que quedo.
• De deur wordt gesloten. — Estan cerrando la puerta, ocurre ahora.
• De deur is gesloten. — La puerta esta cerrada, es el resultado.

🔗 No solo los modales hacen doble infinitivo. Estos verbos normales tambien mandan su compañero al final en infinitivo, y por eso en perfecto no salen en participio.
• laten, doen — Ik heb mijn haar laten knippen. (me he cortado el pelo, me lo han cortado)
• zien, horen, voelen — Ik heb hem zien lopen. (le he visto caminar)
• gaan, komen, blijven — Ze is gaan zwemmen. (se ha ido a nadar)
• helpen, leren — Hij heeft me leren rijden. (me ha enseñado a conducir)
• hoeven, que ademas pierde su te en este caso — Dat had je niet hoeven doen.

🔑 Como saber si un verbo es modal de verdad: Prueba a ponerle un infinitivo detras SIN te. Si la frase se sostiene (ik wil slapen, ik moet gaan, ik kan zwemmen), es modal. Si pide te (ik probeer TE slapen, ik hoop TE komen), no lo es: es un verbo corriente con infinitivo.'
WHERE id BETWEEN 922 AND 941
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧰 Los seis modales y los tres auxiliares%';
