-- Learn Languages App - Por que "sta je bij" (no "sta bij jou") y que hace "er" en la ayuda de la 819
-- Migration: 20260829000008-help-bijstaan-je-en-er-819.sql
-- Description: La tarjeta 819 usa "Ik sta je bij, wat er ook gebeurt." Se explican dos dudas
--   en su rules_help: (1) por que no "ik sta bij jou/je" — mismo problema que la 820, bijstaan
--   pide objeto directo pegado al verbo y bij al final, "staan bij" cambia de verbo — y (2)
--   que hace el "er" de "wat er ook gebeurt": no es el pronombre "lo"/het, es el er
--   expletivo/presentativo que exige esta construccion concesiva con gebeuren (intransitivo,
--   sin objeto directo posible).
--   100% aditiva e idempotente: solo UPDATE con guard (rules_help IS NULL).

UPDATE words_es
SET rules_help = '1) "Ik sta je bij", no "ik sta bij jou" ni "ik sta bij je":
Mismo problema que con «Ze stond haar moeder bij» — bijstaan (apoyar) es separable, con el objeto DIRECTO pegado al verbo conjugado y la particula bij al final: sujeto + sta + je (objeto directo) + resto + bij.
Si dices "ik sta bij jou", "bij" deja de ser particula separable y pasa a leerse como preposicion normal delante de jou: staan bij jou = estar de pie junto a ti (presencia fisica, sin apoyo). Ganas una frase gramatical pero con OTRO significado — justo lo que ya viste en la tarjeta 820.
Ademas, "jou" es la forma FUERTE de "je" (tu/te), la que se usa detras de preposicion cuando quieres dar enfasis: dit is voor jou (esto es para ti). "je" es la forma debil, la que se pega al verbo como objeto directo — por eso bijstaan usa "je", no "jou": no hay preposicion delante, es el objeto directo del verbo.

📐 Formula: sujeto + sta (2) + je (objeto directo) + resto + bij (particula, al final).

2) "wat er ook gebeurt" — el «er» NO es el «lo» ni sustituye a «het»:
gebeuren (suceder/pasar) es un verbo INTRANSITIVO: no lleva objeto directo, asi que no hay ningun «lo» que traducir con het. El «lo que» del espanol ya esta cubierto por «wat» (wat = lo que / que). El «er» que va detras es un «er» EXPLETIVO (de relleno), obligatorio en esta construccion concesiva fija: wat er ook + verbo = "lo que sea que pase" / pase lo que pase. Se usa igual con otros interrogativos: wie er ook komt (venga quien venga), hoe het er ook uitziet (tenga el aspecto que tenga). No sustituye nada, es una pieza gramatical fija de la formula "wat/wie + er + ook + verbo".

🧭 Ejemplo completo: Ik sta je bij, wat er ook gebeurt. — Estoy a tu lado, pase lo que pase.

🏋️ Ejercicio: «venga quien venga, te ayudare» → Wie ___ ook komt, ik help je. (Respuesta: er — wie er ook komt, misma formula que wat er ook gebeurt.)',
    updated_at = datetime('now')
WHERE id = 819
  AND rules_help IS NULL;
