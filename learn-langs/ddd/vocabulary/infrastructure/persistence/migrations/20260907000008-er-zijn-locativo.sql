-- Learn Languages App - Migration
-- Migration: 20260907000008-er-zijn-locativo
-- Description: Eduardo, sobre la tarjeta 300 (Ze belooft dat ze er zal zijn = Promete que
--   estara alli): "pq es necesario er? que pasa si lo cambio por daar?".
--
--   La respuesta: er zijn no significa estar en aquel sitio, significa estar PRESENTE o
--   haber llegado, y funciona casi como formula hecha. Por eso el mazo la tiene repetida
--   en once tarjetas sin explicarla nunca: Ik ben er (ya estoy aqui), De taxi is er (el
--   taxi ya llego), Ben je er al? (¿ya has llegado?), Ik ben er bijna (ya casi llego),
--   Ik zal er zijn (alli estare), Zul jij er zijn? (¿estaras alli?).
--   Cambiarlo por daar no da error, da otra frase: er es atono y remite a un lugar ya
--   sabido sin señalarlo, mientras daar es tonico y señala, asi que Ze zal daar zijn suena
--   a estara ALLI y no en otro sitio. Sin contraste real detras, chirria.
--   Y hay tres diferencias que son duras, no de matiz: (1) er no admite acento y por eso
--   no puede abrir frase — Daar zal ze zijn si, «Er zal ze zijn» no; (2) er zijn es
--   semi-idiomatico (Ik ben er voor je es estoy aqui para ti) y con daar se pierde;
--   (3) si el lugar va explicito no hay er (Ze zal in Amsterdam zijn): er SUSTITUYE al
--   lugar, no lo acompaña.
--
--   Es el mismo par er atono / daar tonico que quedo documentado en el bloque de
--   adverbios pronominales (migracion 20260907000001), aqui aplicado al locativo. No se
--   duplica el grupo 12 (er), que cubre las cuatro vidas de er en general; este bloque va
--   solo a las once tarjetas del er LOCATIVO, que es donde vive la duda.
--   La 434 tenia rules_help a NULL y recibe primera linea propia.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. La 434, sin ayuda: primera linea propia antes de poder concatenar
-- =============================================================================
UPDATE words_es SET rules_help =
'Ben je er al? Ik ben er net. = ¿Ya has llegado? Acabo de llegar. Las dos mitades usan er zijn con el valor de haber llegado, no de estar en un sitio concreto. Y net es el acabo de: Ik ben er net, acabo de llegar ahora mismo.'
WHERE id = 434 AND rules_help IS NULL;

-- =============================================================================
-- 2. La 300: la duda concreta
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: ¿Por que er y no daar?

🔑 Porque er zijn no es estar en aquel sitio: es estar PRESENTE, haber llegado. Funciona casi como formula hecha, y de ahi que Ik zal er zijn sea alli estare en el sentido de cuenta conmigo. er es el locativo atono: remite a un lugar que ya se sabe cual es, sin señalarlo.

⚠️ Con daar la frase sigue siendo correcta, pero dice otra cosa. daar es tonico y SEÑALA, asi que Ze belooft dat ze daar zal zijn suena a estara ALLI, y no en otro sitio. Solo funciona si de verdad hay un contraste detras; sin el, chirria.

| forma | que es | cuando |
|---|---|---|
| **er** | atono, no se puede acentuar | el lugar ya se sabe. **Es lo normal** |
| **daar** | tonico, señala lejos | cuando destacas o contrastas ese sitio |
| **hier** | tonico, señala cerca | aqui, donde estoy |

🚧 Y tres diferencias que son duras, no de matiz:
• er no admite acento, asi que no puede abrir frase. Daar zal ze zijn se dice; «Er zal ze zijn» no existe.
• er zijn es semi-idiomatico: Ik ben er voor je es estoy aqui para ti, con el sentido de apoyo. Con daar se pierde: Ik ben daar es literalmente estoy en aquel sitio.
• Si el lugar va EXPLICITO, no hay er: Ze zal in Amsterdam zijn. er sustituye al lugar, no lo acompaña.

📐 Donde se coloca en la subordinada: justo detras del sujeto y delante de los verbos finales. dat ze ER zal zijn. En principal iria Ze zal er zijn.

🏋️ Ejercicio: «a las ocho estare alli» → Om acht uur zal ik ___ zijn. Y «alli estara, no aqui» → ___ zal ze zijn, niet hier. (Respuestas: er · Daar.)'
WHERE id = 300
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';

-- =============================================================================
-- 3. Bloque compartido: er zijn, la formula de estar presente
--    A las once tarjetas del er locativo
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

📍 er zijn, que no es estar alli sino estar presente:

er zijn es de las formulas que mas se usan y de las que peor se traducen. No dice en que sitio estas: dice que ESTAS, que has llegado, que se cuenta contigo.

| frase | lo que dice de verdad |
|---|---|
| Ik **ben er**. | Ya estoy aqui, ya he llegado. |
| De taxi **is er**. | El taxi ya esta abajo. |
| **Ben** je **er** al? | ¿Ya has llegado? |
| Ik **ben er** bijna. | Ya casi llego. |
| Ik **zal er zijn**. | Alli estare, cuenta conmigo. |
| Ik **ben er** voor je. | Estoy aqui para ti. |

🎚️ er, daar o hier, que es la eleccion de fondo:
• er — atono, no se puede acentuar. Remite a un lugar ya sabido sin señalarlo. Es lo normal.
• daar — tonico, señala lejos. Se usa para destacar o contrastar: Daar zal ze zijn, niet hier.
• hier — tonico, señala cerca. Hier ben ik.

⚠️ er no admite acento, y de ahi salen sus dos limites: no puede abrir frase con este valor («Er zal ze zijn» no existe) y no se puede pronunciar con enfasis. Si quieres destacar el sitio, necesitas daar o hier a la fuerza.

⚠️ Y si el lugar va EXPLICITO en la frase, er desaparece: Ze zal in Amsterdam zijn, no «Ze zal er in Amsterdam zijn». er sustituye al lugar, nunca lo acompaña.

📐 Donde se coloca: pegado detras del sujeto en frase normal (Ik ben er) y detras del sujeto tambien en subordinada, delante de los verbos finales (dat ze er zal zijn).

🔑 El truco para decidir: Pregunta si estas señalando un sitio o solo diciendo que alguien esta. Si señalas, daar. Si solo dices que esta o que ha llegado, er.

🧭 Que es er exactamente, porque NO es un alli abstracto:

er locativo señala lugares completamente reales: Ik ben er es en esta casa, De taxi is er es ahi abajo, Ik ben er nooit geweest es en ese pais. Nada figurado. Lo que le pasa no es que sea abstracto, es que no se puede ACENTUAR. er es el pronombre atono de los lugares, lo mismo que lo y la son los pronombres atonos de los objetos: ves la casa, la ves; vas a Amsterdam, er ga je naartoe.

📎 La prueba de que es un lugar de verdad es que admite preposiciones de lugar reales:
• Ik ga er naartoe. — Voy alli.
• Ik kom er vandaan. — Vengo de alli.
• Ik ben er doorheen gereden. — He pasado por ahi.

🇫🇷 Y el motivo de que a un hispanohablante se le resista: el castellano NO tiene esta pieza, pero el frances si (J''y vais, J''y suis), y el catalan (Ja hi soc) y el italiano (Ci vado). En español el lugar simplemente se OMITE — «¿Has estado en Amsterdam?» «Si, he estado» — mientras que el neerlandes obliga a retomarlo: Ja, ik ben er geweest. Por eso el er parece que sobra: en español no hay nada en esa casilla.

⚠️ Ojo, que er tiene otras vidas donde SI ha perdido el valor de lugar, y son esas las que suenan abstractas:
• locativo — Ik ben er. Un lugar real y concreto, solo que sin señalar.
• existencial — Er is koffie. (hay cafe) Aqui er no es ningun sitio: es un sujeto postizo.
• preposicional — Ik weet er niets van. Sustituye a una cosa, no a un lugar.
• cantidad — Ik heb er drie. Es partitivo: ni lugar ni cosa.
Las cuatro con sus ejemplos estan en el grupo er del mazo.

🎚️ La escala de los sitios, y fijate en cual es el unico que no se puede acentuar:

| forma | que es | ¿acentuable? |
|---|---|---|
| **hier** | aqui, señalando cerca | si |
| **daar** | alli, señalando lejos | si |
| **er** | el sitio ya sabido, sin señalar | **no** |
| **ergens** | en algun sitio | si |
| **nergens** | en ningun sitio | si |
| **overal** | en todas partes | si |'
WHERE id IN (208, 260, 261, 297, 300, 374, 395, 433, 434, 435, 534)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%📍 er zijn, que no es estar alli%';
