-- 561 / 562 / 643 — cómo distinguir objeto DIRECTO de INDIRECTO (hen vs hun).
-- El bloque es el mismo para las tres: se marca con @@CDCI@@ y se inyecta al final.
-- Idempotente: solo marca si el bloque 🔍 todavía no está en la ayuda.

UPDATE words_es
SET rules_help = REPLACE(rules_help, '📐 Oración principal', '@@CDCI@@📐 Oración principal'),
    updated_at = datetime('now')
WHERE id IN (561, 562, 643)
  AND rules_help LIKE '%📐 Oración principal%'
  AND rules_help NOT LIKE '%🔍 Directo o indirecto%';

UPDATE words_es
SET rules_help = REPLACE(
        rules_help,
        '@@CDCI@@',
        '🔍 Directo o indirecto, la prueba del aan: si delante del pronombre puedes meter aan (o voor) y la frase sigue de pie, es INDIRECTO → hun. Si no cabe, es DIRECTO → hen.

• Ik heb hen niet uitgenodigd. — uitnodigen aan hen ✗ no cabe → DIRECTO → hen.
• Ik heb hun geschreven. — schrijven aan hen ✓ cabe → INDIRECTO → hun.
• Ik heb hun een kaartje gestuurd. — een kaartje sturen aan hen ✓ → INDIRECTO → hun.

Las otras dos pruebas, por si la del aan no decide:

| prueba | sale DIRECTO | sale INDIRECTO |
|---|---|---|
| ¿cabe **aan** delante? | no cabe | sí: aan hen |
| ¿hay dos objetos, cosa y persona? | la COSA (het kaartje) | la PERSONA (hun) |
| ¿puede ser sujeto de una pasiva? | sí: Zij zijn uitgenodigd | no: zij zijn geschreven ✗ |

Con un solo objeto casi siempre es DIRECTO. En cuanto aparecen dos (una cosa y una persona), la persona es el indirecto y la cosa el directo: Ik heb hun (indirecto) een kaartje (directo) gestuurd.

⚠️ No te fíes del pronombre español, que el leísmo lo desordena: dices «les ayudé», pero helpen lleva objeto DIRECTO en neerlandés (Ik heb hen geholpen). Cuando en español te sale lo/la/los/las vas bien; cuando te sale le/les, comprueba con la prueba del aan.

Verbos que engañan porque el español los reparte al revés:

| verbo NL | rige | y en español dices |
|---|---|---|
| **helpen** | DIRECTO — hen / ze | les ayudé |
| **bellen** | DIRECTO — hen / ze | les llamé |
| **uitnodigen** | DIRECTO — hen / ze | los invité |
| **bedanken** | DIRECTO — hen / ze | les di las gracias |
| **vertrouwen** | DIRECTO — hen / ze | confío en ellos |
| **schrijven** | INDIRECTO — hun | les escribí |
| **vertellen** | INDIRECTO — hun | les conté |
| **geven, sturen, aanbieden, beloven** | INDIRECTO — hun | les di, les mandé, les prometí |

✅ ze sirve para los dos: Ik heb ze niet uitgenodigd (directo) e Ik heb ze niets verteld (indirecto) son las dos correctas, y son lo que se oye. hen/hun es la forma cuidada, y solo ahí hay que elegir.

💎 Donde sí o sí se acierta: detrás de preposición SIEMPRE hen, nunca hun ni ze — aan hen, voor hen, met hen, over hen. Es la regla que ningún neerlandés falla.

'
    ),
    updated_at = datetime('now')
WHERE rules_help LIKE '%@@CDCI@@%';
