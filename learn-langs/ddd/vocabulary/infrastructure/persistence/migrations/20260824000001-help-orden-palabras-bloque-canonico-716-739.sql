-- 716-739 — el ORDEN DE LAS PALABRAS explicado UNA sola vez, igual en las 24 tarjetas.
-- Mismo patrón que el diálogo: bloque idéntico e inyectado, no una explicación distinta por palabra.
-- Se marca con @@ORDEN@@ justo delante del diálogo y se inyecta después.
-- Idempotente: solo marca si el bloque 🧱 todavía no está en la ayuda.

UPDATE words_es
SET rules_help = REPLACE(rules_help, '🎭 El dialogo completo, en orden', '@@ORDEN@@🎭 El dialogo completo, en orden'),
    updated_at = datetime('now')
WHERE id BETWEEN 716 AND 739
  AND rules_help LIKE '%🎭 El dialogo completo, en orden%'
  AND rules_help NOT LIKE '%🧱 El orden de las palabras%';

UPDATE words_es
SET rules_help = REPLACE(
        rules_help,
        '@@ORDEN@@',
        '🧱 El orden de las palabras, el esqueleto de siempre:
Esto es igual en TODAS las tarjetas, así que va explicado una sola vez y con frases de este mismo diálogo. El neerlandés no coloca por significado sino por casillas: el verbo conjugado ocupa la segunda y todo lo demás se acomoda alrededor.

| casilla | qué va dentro |
|---|---|
| **1 · el arranque** | UNA sola cosa: el sujeto, o el tiempo, o el lugar, o lo que quieras destacar |
| **2 · el verbo conjugado** | siempre, sin excepción, en la frase principal |
| **3 · el sujeto** | solo si en la 1 se metió otra cosa: eso es la inversión |
| **4 · el medio** | por este orden TIEMPO, MODO, LUGAR, con el niet justo delante de lo que niega |
| **5 · el final** | los demás verbos (infinitivos y participios) y la partícula del separable |

🧪 El esqueleto caso por caso, con frases del diálogo:
• frase normal — Ik (1) heb (2) om tien uur (4) een afspraak. El sujeto arranca y ya está.
• inversión — Vorig jaar (1) ben (2) ik (3) verhuisd (5). Si en la 1 se cuela otra cosa, el sujeto salta detrás del verbo.
• modal — U (1) kunt (2) uw paspoort binnen drie maanden (4) ophalen (5). El infinitivo se va al final.
• perfecto — Ik (1) heb (2) het thuis (4) ingevuld en geprint (5). El participio, también al final.
• separable — Ik (1) roep (2) u zo (4) op (5). La partícula se despega y cae al final.
• doble infinitivo — Kan (2) ik (3) het (4) laten opsturen (5). Dos verbos al final y en ese orden.
• pregunta sí/no — Klopt (2) uw adres (3) nog? La casilla 1 se queda vacía y el verbo abre la frase.
• pregunta con interrogativo — Hoe lang (1) duurt (2) het (3)? El Wat, Hoe o Waarom ocupa la 1.
• imperativo — Legt (2) u (3) uw vier vingers op de scanner (4). Verbo delante; en el formal, el u justo detrás.
• subordinada — voordat het paspoort klaar is. Aquí no vale nada de lo anterior: ver el aviso.

⚠️ La subordinada (bijzin) es la única que rompe el esqueleto: detrás de dat, of, omdat, als, toen, terwijl, voordat, hoewel y de cualquier relativo, el verbo conjugado abandona la casilla 2 y se va AL FINAL con los demás. Compara het paspoort is klaar con voordat het paspoort klaar is.

🧭 La comprobación de dos segundos: cuenta lo que hay antes del verbo conjugado. Si hay dos cosas, está mal, salvo que sea subordinada, pregunta sí/no o imperativo.

📌 Y la regla de peso decide lo dudoso: lo corto y ya sabido va delante, lo largo y nuevo va detrás. Por eso los pronombres se pegan al verbo (Ik geef het je zo) y el complemento largo se va al fondo.

'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%@@ORDEN@@%';
