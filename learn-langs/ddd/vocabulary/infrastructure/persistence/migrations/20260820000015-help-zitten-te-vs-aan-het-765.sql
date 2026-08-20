-- Learn Languages App - Ayuda 765: «zit te lezen» vs «is aan het lezen»
-- Migration: 20260820000015-help-zitten-te-vs-aan-het-765.sql
-- Description: Eduardo pregunta si vale «Hij zit aan het lezen». NO: son DOS construcciones
--   distintas del «estar + gerundio» y cada una trae su propio verbo — postura (zitten,
--   staan, liggen, lopen) + TE + infinitivo, o ZIJN + AAN HET + infinitivo. Mezclarlas junta
--   el verbo de postura con la construccion que rige zijn y no es estandar.
--   El porque, que es lo bonito: en «aan het lezen» el infinitivo esta SUSTANTIVADO (het
--   lezen = la lectura) y ese bloque lo rige zijn; zitten no puede regirlo, lo que zitten
--   rige es un te + infinitivo. Bloque 🔄 con la tabla de las cuatro maneras de decirlo, la
--   colocacion del objeto en cada una, el perfecto de las dos (Hij heeft ZITTEN LEZEN, con
--   doble infinitivo, frente a Hij is aan het lezen GEWEEST) y cuando elegir cada una.
--   Ademas se quita el parentesis del texto espanol —«esta leyendo (sentado)» → «esta
--   leyendo sentado»—, que se locuta (norma del 2026-08-20). Al aplicarla hay que borrar
--   data/audio/word-765-es-es-castellano.mp3, que la cache va por id; hecho a mano.
--   Solo UPDATE. IDEMPOTENTE por emoji-guarda (NOT LIKE '%🔄%') y por el texto viejo.
--   Escrita fuera de migrations/ y movida ya terminada.

-- El bloque de ayuda
UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '📐 Estructura: sujeto + zit',
    '🔄 ¿Y «Hij zit aan het lezen»? No, eso mezcla dos construcciones:
El neerlandés tiene varias maneras de decir «está leyendo», y cada una viene con su propio verbo. No se combinan entre sí.

| construcción | qué verbo la rige | ejemplo |
|---|---|---|
| postura + **te** + infinitivo | zitten, staan, liggen, lopen | Hij **zit te** lezen. |
| **aan het** + infinitivo | **zijn** | Hij **is aan het** lezen. |
| **bezig zijn met** | zijn | Hij **is bezig met** lezen. |
| presente a secas | ninguno | Hij **leest**. |

🔍 Por qué chocan: en «aan het lezen» el infinitivo está SUSTANTIVADO — het lezen es «la lectura», con su artículo — y ese bloque lo rige zijn. zitten no puede regir un sustantivo así; lo que zitten rige es un te + infinitivo. Por eso «Hij zit aan het lezen» suena a frase a medio hacer (se le oye a alguna gente, pero no es estándar).
📦 Dónde va el objeto en cada una, que también cambia:
• Hij zit een boek te lezen. — el objeto se mete ANTES del te.
• Hij is een boek aan het lezen. — el objeto se mete ANTES del aan het.
⏳ Y en perfecto se separan del todo: Hij heeft zitten lezen — DOBLE INFINITIVO, nada de «gezeten te lezen» — frente a Hij is aan het lezen geweest.
🎯 Cuál usar: si la postura aporta algo o quieres el matiz (Hij loopt te zeuren = ahí está, quejándose), postura + te. Si solo quieres decir que está metido en ello, aan het. Y si nada de eso importa, el presente pelado ya vale: Hij leest.

📐 Estructura: sujeto + zit'
)
WHERE id = 765
  AND rules_help LIKE '%📐 Estructura: sujeto + zit%'
  AND rules_help NOT LIKE '%🔄%';

-- El paréntesis del texto español, que se locuta
UPDATE words_es
SET text = 'está leyendo sentado',
    updated_at = datetime('now')
WHERE id = 765
  AND text = 'está leyendo (sentado)';
