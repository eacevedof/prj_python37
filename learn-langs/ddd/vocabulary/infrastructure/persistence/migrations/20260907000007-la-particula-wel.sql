-- Learn Languages App - Migration
-- Migration: 20260907000007-la-particula-wel
-- Description: Eduardo, sobre la tarjeta 308 (Ik denk dat hij wel moe zal zijn = Creo que
--   estara cansado): "pq en 308 tiene q ir wel? que pasa si lo omito? que se entenderia?".
--
--   La respuesta: omitirlo NO da error, da OTRA frase. Sin wel, zal vuelve a leerse como
--   futuro real — Ik denk dat hij moe zal zijn es creo que estara cansado LUEGO, cuando
--   llegue, una prediccion. Con wel es conjetura sobre el presente: me imagino que estara
--   cansado ahora. O sea que wel es exactamente la pieza que desvia zal de futuro a
--   suposicion, que es la maquinaria que quedo documentada en la migracion 0006 para la
--   322. Y hay una tercera opcion, la mas natural si se habla del presente y que no lleva
--   zal ninguno: Ik denk dat hij moe IS.
--
--   Como la duda destapa que el mazo no explicaba wel en ninguna parte (18 tarjetas lo
--   usan como palabra suelta y ninguna decia que es), se escribe el bloque compartido
--   "🎛️ wel, la particula" y se inyecta en las 18. Su idea central: wel es en origen el
--   CONTRARIO de niet, la afirmacion frente a la negacion, y eso ya estaba en el mazo sin
--   explicar en la 382 (Soms wel, soms niet) y la 475 (Ik wil wel, maar ik kan niet). De
--   esa raiz salen sus seis vidas: contradecir una negacion, la conjetura con zullen,
--   atenuar (Dat is wel lekker BAJA la intensidad), weleens, la concesion y wel degelijk.
--   Se avisa ademas del falso amigo: wel no es "bien" (eso es goed), aunque lo parezca por
--   el well ingles y el wohl aleman.
--
--   Las tres de las 18 que tenian rules_help a NULL (303, 307 y 326) reciben su primera
--   linea en la migracion 0006, que se aplica antes que esta por orden de nombre.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. La 308: la duda concreta
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: ¿Por que tiene que ir wel? ¿Que pasa si lo omito?

🔑 No pasa nada malo: pasa que dices OTRA cosa. Ik denk dat hij moe zal zijn, sin wel, es gramatical, pero ahi zal vuelve a leerse como futuro de verdad: creo que estara cansado LUEGO, cuando llegue. Con wel es una conjetura sobre ahora: me imagino que estara cansado. wel es justamente la pieza que desvia zal de futuro a suposicion.

| frase | que dice de verdad |
|---|---|
| Ik denk dat hij moe **is**. | creo que esta cansado. Opinion directa, y lo mas natural si hablas del presente |
| Ik denk dat hij **wel** moe **zal** zijn. | me imagino que estara cansado. Deduccion sobre ahora |
| Ik denk dat hij moe **zal** zijn. | creo que estara cansado luego. Prediccion de futuro |
| Hij is **vast** moe. | seguro que esta cansado. Mas seguro que con wel |

⚠️ Y fijate en la primera fila, que es la que mas se olvida: si solo quieres decir que crees algo del presente, en neerlandes NO hace falta zullen. Ik denk dat hij moe is. Meter zal wel añade el matiz de lo deduzco, me lo imagino, y sin ese matiz sobra.

📐 Donde va el wel: en el medio de la frase, justo delante de lo que matiza. En subordinada, dat hij wel moe zal zijn, con los verbos al final. En principal seria Hij zal wel moe zijn.

🏋️ Ejercicio: «creo que esta enfermo» sin deduccion → Ik denk dat hij ziek ___. Y «me imagino que estara enfermo» → Ik denk dat hij ___ ziek ___ zijn. (Respuestas: is · wel … zal.)'
WHERE id = 308
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';

-- =============================================================================
-- 2. Bloque compartido: la particula wel, en las 18 tarjetas que la usan
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🎛️ wel, la particula que no se traduce:

En origen wel es el CONTRARIO de niet: la afirmacion frente a la negacion. Todo lo demas sale de ahi.

| negado | afirmado con wel |
|---|---|
| Ik heb **geen** tijd. | Ik heb **wel** tijd. (si que tengo tiempo) |
| Dat is **niet** waar. | Dat is **wel** waar! (¡si que es verdad!) |
| Soms **niet**. | Soms **wel**. (a veces si) |
| Ik kan **niet**. | Ik wil **wel**. (querer quiero) |

🎭 Sus seis vidas, todas hijas de esa primera:
• Contradecir una negacion — Jij komt niet. Ik kom wel! Es el uso base y el mas facil de reconocer.
• La conjetura con zullen — Het zal wel regenen. Aqui wel es lo que convierte el futuro en suposicion.
• Atenuar — Dat is wel lekker. Ojo, que aqui BAJA la intensidad: es bastante bueno, no buenisimo. Para eso, heel lekker.
• weleens — alguna vez. Ben je er weleens geweest?
• Conceder — Het is wel duur, maar het is goed. Si, es caro, pero…
• wel degelijk — si, ciertamente, en contra de lo que se creia. Hij heeft het wel degelijk gezegd.

⚠️ El falso amigo que muerde: wel NO significa bien. Bien es goed. Lo parece por el well ingles y el wohl aleman, pero wel es una particula y casi nunca se traduce palabra por palabra: se traduce el efecto que hace en la frase.

📐 Donde se coloca: en el medio de la frase, justo delante de lo que matiza. Hij zal wel moe zijn. Ik heb wel tijd. Nunca al principio, salvo en respuestas cortas: Wel! como replica a Niet!, que es lo que se gritan los niños.

🔑 El truco para reconocerlo: Pregunta que estaria negando. Si la frase contesta a un niet o un geen, aunque no se haya dicho en voz alta, ahi hay un wel. Ik heb wel tijd responde a un ¿no tienes tiempo? que flota en el aire.'
WHERE id IN (
    SELECT wl.word_es_id FROM words_lang wl
    WHERE wl.lang_code = 'nl_NL'
      AND replace(replace(replace(replace(replace(
              ' ' || lower(wl.text) || ' ',
              '.', ' '), '!', ' '), '?', ' '), ',', ' '), ';', ' ') LIKE '% wel %'
)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🎛️ wel, la particula%';
