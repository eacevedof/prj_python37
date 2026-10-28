-- Learn Languages App - zodra y el presente donde el espanol pide subjuntivo (duda de la 807)
-- Migration: 20260831000018-help-zodra-presens-en-thuiskomen.sql
-- Description: Eduardo en la 807 («Zodra ik thuis ben, bel ik je»): «¿por que no puede ser zodra
--   ik thuis kom, bel ik je?». SI puede, con dos matices: (1) ortografia — thuiskomen es
--   SEPARABLE y en subordinada las piezas se reunen y se escriben juntas, «zodra ik thuiskom», no
--   «thuis kom»; en principal si se separan (Ik kom om zes uur thuis). (2) matiz — thuis zijn es
--   el ESTADO y thuiskomen el EVENTO; el espanol «en cuanto llegue» apunta al evento, pero en
--   neerlandes zodra ya marca el momento del cambio y con zijn se enfoca el resultado, que es lo
--   mas frecuente al hablar. Las dos son naturales.
--   Bloque ⏳ IDENTICO byte a byte con la causa de fondo de la extraneza: el espanol obliga a
--   SUBJUNTIVO en las temporales de futuro («en cuanto LLEGUE») y el neerlandes usa PRESENTE de
--   indicativo, sin marcar el futuro dos veces («Zodra ik thuis zal zijn» no se dice). Incluye la
--   tabla de equivalencias, las tres piezas de orden (la conjuncion manda el verbo al final · la
--   subordinada en casilla 1 obliga a la inversion de la principal · si va detras no hay
--   inversion), la distincion als/toen de la 524 y la lista de conjunciones de tiempo (zodra,
--   als, toen, wanneer, terwijl, zolang, voordat, nadat, tot/totdat).
--   Va a 502, 524, 731, 772, 807, 808 y 837. Las 807 y 808 no tenian rules_help y se crean
--   enteras: la 807 con la respuesta a la duda y el reparto de «casa» (thuis adverbio · naar huis
--   con movimiento · het huis edificio · het thuis hogar, con la 789 al lado), y la 808 con zodra
--   en pasado, los dos sentidos de klaar zijn y la pareja naar buiten / naar binnen.
--   100% aditiva e idempotente: UPDATE con guard por marca y por rules_help IS NULL.

-- ==============================================================================
-- 1. Tarjeta 807: no tenia ayuda, se crea con la respuesta a la duda
-- ==============================================================================
UPDATE words_es
SET rules_help = 'Se puede decir «Zodra ik thuiskom, bel ik je», es correcta, pero con dos cosas que conviene ver.

📌 La primera es de ortografia: thuiskomen es un verbo SEPARABLE, y en una subordinada, donde el verbo se va al final, las dos piezas se reunen y se escriben JUNTAS. Zodra ik thuiskom, no «thuis kom». En una principal si se separan: Ik kom om zes uur thuis.

⚠️ La segunda es de matiz, y es la razon de que la tarjeta use la otra: thuis zijn es el ESTADO (estar en casa) y thuiskomen es el EVENTO (llegar a casa). El espanol «en cuanto llegue a casa» apunta al evento, asi que thuiskom traduce mas literal; pero en neerlandes zodra ya marca por si solo el momento del cambio, y con zijn se enfoca el resultado, que es lo mas frecuente al hablar. Las dos suenan naturales.

🏠 Ojo con la familia, que reparte lo que el espanol llama «casa»: thuis es adverbio y significa en casa (Ik ben thuis) · naar huis es a casa, con movimiento (Ik ga naar huis) · het huis es el edificio · het thuis es el hogar, lo afectivo. La tarjeta 789 lo trata en detalle. Y el sustantivo de llegar es de thuiskomst.

↔️ Antonimos: thuiskomen ↔ weggaan o vertrekken (irse, salir) · thuis ↔ weg (fuera) y buitenshuis (fuera de casa).',
    updated_at = datetime('now')
WHERE id = 807
  AND rules_help IS NULL;

-- ==============================================================================
-- 2. Tarjeta 808: no tenia ayuda, se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'Zodra hij klaar was, ging hij naar buiten. Aqui zodra funciona igual que en presente pero en pasado: la conjuncion manda el verbo al final de su oracion (…klaar was) y, como esa subordinada ocupa la casilla 1 de la frase entera, la principal arranca con el verbo y el sujeto pasa detras (ging hij). Si le das la vuelta, la inversion desaparece: Hij ging naar buiten zodra hij klaar was.

📌 klaar zijn tiene dos sentidos que separa el contexto: estar LISTO o preparado (Ben je klaar? = ¿estas listo?) y haber TERMINADO algo (Ik ben klaar met mijn werk). Aqui es el segundo. Y klaarmaken es preparar, con lo que klaar da mucho juego: het eten klaarmaken, zich klaarmaken.

🚪 naar buiten gaan es salir al exterior, con movimiento, frente a buiten zijn, que es estar fuera. La pareja completa: naar buiten ↔ naar binnen (adentro), y buiten ↔ binnen. Los sustantivos, con su articulo: de buitenkant (el exterior) ↔ de binnenkant (el interior).

↔️ Antonimos: klaar (terminado) ↔ bezig (en ello, ocupado) · naar buiten ↔ naar binnen · weggaan ↔ blijven (quedarse).',
    updated_at = datetime('now')
WHERE id = 808
  AND rules_help IS NULL;

-- ==============================================================================
-- 3. El bloque del presente por subjuntivo, en las 7 tarjetas de conjuncion temporal
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

⏳ El subjuntivo espanol que en neerlandes es presente
En las oraciones de tiempo, el espanol obliga a poner SUBJUNTIVO cuando se habla del futuro: «en cuanto LLEGUE», «cuando VENGAS», «antes de que SALGA». El neerlandes no tiene esa forma y lo resuelve con el PRESENTE de indicativo, sin mas.

| en espanol | en neerlandes |
|---|---|
| En cuanto **llegue** a casa, te llamo | Zodra ik thuis **ben**, bel ik je. |
| Cuando **vengas**, hablamos | Als je **komt**, praten we. |
| Antes de que **salga** el tren | Voordat de trein **vertrekt** |
| Mientras **estes** aqui | Zolang je hier **bent** |

📌 O sea que el futuro no se marca dos veces: basta con la conjuncion (zodra, als, voordat, zolang, tot) y el presente. Meter zullen ahi suena raro, «Zodra ik thuis zal zijn» no se dice.

🔧 Y las tres piezas de orden que acompanan siempre a esto:
• La conjuncion manda el verbo AL FINAL de su propia oracion. Zodra ik thuis ben, … · Zodra hij klaar was, …
• Esa subordinada ocupa la casilla 1 de la frase entera, asi que la principal arranca con el VERBO y el sujeto pasa detras. …, bel ik je. · …, ging hij naar buiten.
• Si la subordinada va detras, no hay inversion ninguna. Ik bel je zodra ik thuis ben.

⚠️ als tiene dos vidas, y esta es la de tiempo o condicion, con presente. Para un pasado puntual («cuando llego») als NO vale: hay que usar toen. Toen het regende, bleef ik thuis. Es justo lo que separa la tarjeta 524.

🗺️ Las conjunciones de tiempo mas usadas: zodra (en cuanto) · als (cuando, si) · toen (cuando, solo pasado puntual) · wanneer (cuando, mas formal, y el interrogativo) · terwijl (mientras) · zolang (mientras dure) · voordat (antes de que) · nadat (despues de que) · tot y totdat (hasta que).',
    updated_at = datetime('now')
WHERE id IN (502, 524, 731, 772, 807, 808, 837)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%⏳ El subjuntivo espanol que en neerlandes es presente%';
