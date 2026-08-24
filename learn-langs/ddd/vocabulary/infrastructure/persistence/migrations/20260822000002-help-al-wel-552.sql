-- 552 «Mag ik hem al wel weggeven?» — explicar «al wel» (= ya sí, NO «ya bien»).
-- Idempotente: solo inserta si el bloque ⏳ todavía no está en la ayuda.

UPDATE words_es
SET rules_help = REPLACE(
        rules_help,
        '📐 Pregunta sí/no:',
        '⏳ al wel = ya sí: al ("ya") + wel ("sí que"). Antes no se podía, ahora ya sí. wel NO es "bien".

Los cuatro cuadrantes de ya / todavía:

| momento | afirmativo | negativo |
|---|---|---|
| aún no ha ocurrido | **nog** = todavía | **nog niet** = todavía no |
| ya ha ocurrido | **al** = ya | **niet meer** = ya no |

El par vivo es nog niet ↔ al wel: uno niega, el otro rectifica el «no» anterior. «al niet» NO existe: para eso ya está niet meer (ya no).

⚠️ wel no significa "bien" — es el "sí (que)" que contradice a un niet/geen. "Bien" es goed. Ik heb geen tijd. — Ik wel. = Yo no tengo tiempo. — Yo sí.

Ejemplos de nog niet frente a al wel:
• Nog niet af, maar het werkt al wel. — Acabado no está, pero ya funciona.
• Bier mag ze nog niet, wijn al wel. — Cerveza todavía no puede, vino ya sí.
• Kun je al wel autorijden? — ¿Ya puedes conducir (ya sí)?
• Ik mag nog niet naar huis. — Todavía no me puedo ir a casa.
• Vroeger kon het nog wel, nu niet meer. — Antes todavía se podía, ahora ya no.

🗣 Mini-diálogo:
• — Mag ik hem al weggeven? — Nee, nog niet, ik heb hem nodig.
• — En nu dan? — Ja, nu mag het al wel.

🧪 Sin wel también vale: Mag ik hem al weggeven? es la pregunta neutra («¿ya puedo?»). Con al wel das por hecho que antes NO se podía y pides que te confirmen el cambio.

📌 Sitio en la frase: al wel va en el medio — tras el sujeto y los pronombres, y antes del infinitivo del final: Mag ik hem al wel weggeven?

🎯 Los otros wel que te vas a cruzar:
• wel eens = alguna vez (Ben je er wel eens geweest?)
• zal wel = seguro que / supongo (Hij zal wel ziek zijn)
• wel tien = nada menos que diez
• welkom, wel te rusten, dank je wel = restos del wel antiguo, ahí sí valía "bien"

📐 Pregunta sí/no:'
    ),
    updated_at = datetime('now')
WHERE id = 552
  AND rules_help LIKE '%📐 Pregunta sí/no:%'
  AND rules_help NOT LIKE '%⏳ al wel%';
