-- 548 «Dat maakt mij niet uit» — las cuatro combinaciones me/mij × dat/het:
-- todas correctas, pero me/mij es el ÉNFASIS y dat/het es a QUÉ te refieres.
-- Idempotente: solo inserta si el bloque 🎚️ todavía no está en la ayuda.

UPDATE words_es
SET rules_help = REPLACE(
        rules_help,
        '📐 Oración principal:',
        '🎚️ me o mij, dat o het: las cuatro combinaciones son neerlandés correcto, pero no dicen lo mismo. me/mij marca el ÉNFASIS; dat/het marca a QUÉ te refieres.

| frase | qué dice de verdad |
|---|---|
| Het maakt me niet uit. | Me da igual. (lo más neutro y lo que más se oye) |
| Het maakt mij niet uit. | A mí me da igual. |
| Dat maakt me niet uit. | Eso me da igual. (señalando lo que acaban de decir) |
| Dat maakt mij niet uit. | Eso a mí me da igual. ← la de la tarjeta |

🔊 Cada idioma marca el énfasis a su manera: el español lo marca AÑADIENDO palabras («me da igual» → «a mí me da igual»). El neerlandés no añade nada: CAMBIA de forma, me → mij. Por eso ese «a mí» del español no se traduce con una palabra aparte, se traduce eligiendo mij.

La escalera del énfasis, de menos a más:
• Het maakt me niet uit. — Me da igual.
• Het maakt mij niet uit. — A mí me da igual.
• Mij maakt het niet uit. — A MÍ me da igual (el pronombre en 1ª posición pesa todavía más).
• Voor mij maakt het niet uit. — Por mí, ninguna diferencia.

🎯 dat o het, la diferencia real:
• het = neutro, no apunta a nada concreto — o anuncia lo que viene después.
• dat = apunta a ESO que se acaba de decir; es un dedo señalando.

Te preguntan «¿cine o teatro?» y respondes Het maakt me niet uit (la elección en general). Te sueltan «va a llover» y respondes Dat maakt me niet uit (eso concreto).

⚠️ Cuando lo que da igual viene DESPUÉS, solo vale het: Het maakt me niet uit of we gaan of niet · Het maakt niet uit wanneer je komt. Ahí het es un sujeto provisional que anuncia la subordinada, y dat no puede hacer ese papel.

💎 La respuesta hecha a una disculpa: Het maakt niet uit, sin pronombre. — Sorry, ik ben te laat! — Het maakt niet uit! (¡no pasa nada!). En habla rápida se queda en Maakt niet uit.

🎭 No lo confundas con het kan me niet schelen: los dos se traducen «me da igual», pero maakt me niet uit es AMABLE (por mí bien, elige tú) y kan me niet schelen es DESPEGADO, casi borde (me trae sin cuidado). Si te preguntan dónde cenar, la buena es Het maakt me niet uit.

🔌 Y el otro uitmaken, que muerde: het uitmaken met iemand = cortar la relación (Ze heeft het uitgemaakt = lo ha dejado).

📐 Oración principal:'
    ),
    updated_at = datetime('now')
WHERE id = 548
  AND rules_help LIKE '%📐 Oración principal:%'
  AND rules_help NOT LIKE '%🎚️ me o mij%';
