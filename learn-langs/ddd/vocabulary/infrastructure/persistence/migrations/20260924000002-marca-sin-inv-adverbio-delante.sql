-- Learn Languages App - Migration
-- Migration: 20260924000002-marca-sin-inv-adverbio-delante
-- Description: Eduardo, sobre la 261: "en 261 hay que indicar si se espera inversion o no. Yo
--   traduje como Nooit ben ik er nooit geweest".
--
--   Dos cosas en esa respuesta. La repeticion de nooit es un error suyo (el adverbio se MUEVE
--   delante, no se copia). Pero Nooit ben ik er geweest es correcto, y la app lo habria dado por
--   malo: la 261 espera Ik ben er nooit geweest y el enunciado no lo decia.
--
--   Es el agujero simetrico de la norma (inv) (§3.9, migracion 20260922000001). Aquella fila 3
--   decia «el español abre con lo mismo → no hace falta marca, trasladando el orden sale sola».
--   Falla justo al reves: el español abre con un adverbio (nunca, ayer, aqui, a veces), el mazo
--   espera orden NEUTRO y la version invertida tambien es buena. Barrido del mazo (ES que abre
--   con adverbio y NL que abre con sujeto): 38 candidatas, 17 ambiguas de verdad. Las otras 21
--   no tienen una inversion natural (ya → al/wel/zo, todavia → nog, solo → alleen maar).
--
--   Cambios en las 17:
--     1. Marca (sin inv) en el texto ES, fundida en el parentesis si ya lo habia: (átona, sin inv).
--     2. Seccion propia «🪧 Con inversión también valdría» con la version invertida y su foco.
--     3. Bloque compartido «➡️ Cuando el enunciado lleva (sin inv)», con el par, el truco y el
--        aviso del adverbio duplicado.
--
--   AUDIO (§5.6.5): se borra el word_es_media es_ES de las que lo tienen para que se regenere.
--   El mp3 local de data/audio (cache por id) se borra aparte.

PRAGMA foreign_keys = ON;

-- 1) La marca en el enunciado

UPDATE words_es SET text = 'nunca he estado allí (átona, sin inv)'
WHERE id = 261 AND text = 'nunca he estado allí (átona)';

UPDATE words_es SET text = 'Nunca te olvidaré. (sin inv)'
WHERE id = 298 AND text = 'Nunca te olvidaré.';

UPDATE words_es SET text = 'A veces trabajo desde casa. (sin inv)'
WHERE id = 380 AND text = 'A veces trabajo desde casa.';

UPDATE words_es SET text = 'Aquí se trabaja duro. (sin inv)'
WHERE id = 461 AND text = 'Aquí se trabaja duro.';

UPDATE words_es SET text = 'ayer me lo encontré por la calle (sin inv)'
WHERE id = 619 AND text = 'ayer me lo encontré por la calle';

UPDATE words_es SET text = 'ayer tuve que hacer horas extra (sin inv)'
WHERE id = 678 AND text = 'ayer tuve que hacer horas extra';

UPDATE words_es SET text = 'Nunca ha percibido en él ningún arrepentimiento. (sin inv)'
WHERE id = 828 AND text = 'Nunca ha percibido en él ningún arrepentimiento.';

UPDATE words_es SET text = 'Ayer recibí una denegación de la universidad. (sin inv)'
WHERE id = 852 AND text = 'Ayer recibí una denegación de la universidad.';

UPDATE words_es SET text = 'Siempre confundo sus nombres. (sin inv)'
WHERE id = 867 AND text = 'Siempre confundo sus nombres.';

UPDATE words_es SET text = 'Hoy hace un poco más de frío que ayer. (sin inv)'
WHERE id = 890 AND text = 'Hoy hace un poco más de frío que ayer.';

UPDATE words_es SET text = 'Ayer apenas dormí. (sin inv)'
WHERE id = 894 AND text = 'Ayer apenas dormí.';

UPDATE words_es SET text = 'Ayer tuve que trabajar. (sin inv)'
WHERE id = 935 AND text = 'Ayer tuve que trabajar.';

UPDATE words_es SET text = 'Ahora sí que me tengo que ir. (sin inv)'
WHERE id = 936 AND text = 'Ahora sí que me tengo que ir.';

UPDATE words_es SET text = 'Aquí no puedes aparcar. (sin inv)'
WHERE id = 940 AND text = 'Aquí no puedes aparcar.';

UPDATE words_es SET text = 'Ayer no me dejaron ir. (sin inv)'
WHERE id = 941 AND text = 'Ayer no me dejaron ir.';

UPDATE words_es SET text = 'al final salió bien (sin inv)'
WHERE id = 955 AND text = 'al final salió bien';

UPDATE words_es SET text = 'aquí venden buen queso (sin inv)'
WHERE id = 1068 AND text = 'aquí venden buen queso';


-- 2) La version invertida de cada tarjeta

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Nooit ben ik er geweest, con el foco en nunca. La tarjeta pide el orden neutro, Ik ben er nooit geweest. Ojo, el nooit sale una sola vez, «Nooit ben ik er nooit geweest» repite la negación y está mal.'
WHERE id = 261 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Nooit zal ik je vergeten, con el foco en nunca, muy de promesa solemne. La tarjeta pide el orden neutro.'
WHERE id = 298 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Soms werk ik thuis, igual de natural. La tarjeta pide el orden neutro.'
WHERE id = 380 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Hier wordt hard gewerkt, con el foco en aquí. Al abrir con hier el er de la pasiva sobra y casi siempre cae. La tarjeta pide el orden neutro.'
WHERE id = 461 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Gisteren ben ik hem tegengekomen, igual de natural. La tarjeta pide el orden neutro.'
WHERE id = 619 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Gisteren moest ik overwerken, igual de natural. La tarjeta pide el orden neutro.'
WHERE id = 678 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Nooit heeft ze enige spijt bij hem bespeurd, con el foco en nunca y tono literario. La tarjeta pide el orden neutro.'
WHERE id = 828 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Gisteren kreeg ik een afwijzing van de universiteit, igual de natural. La tarjeta pide el orden neutro.'
WHERE id = 852 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Steeds verwissel ik hun namen, con el foco en siempre. La tarjeta pide el orden neutro.'
WHERE id = 867 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Vandaag is het iets kouder dan gisteren, igual de natural. La tarjeta pide el orden neutro.'
WHERE id = 890 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Gisteren heb ik nauwelijks geslapen, igual de natural. La tarjeta pide el orden neutro.'
WHERE id = 894 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Gisteren moest ik werken, igual de natural. La tarjeta pide el orden neutro.'
WHERE id = 935 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Nu moet ik echt gaan, con el foco en ahora. La tarjeta pide el orden neutro.'
WHERE id = 936 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Hier mag je niet parkeren, con el foco en aquí, típico de cartel o de aviso. La tarjeta pide el orden neutro.'
WHERE id = 940 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Gisteren mocht ik niet mee, igual de natural. La tarjeta pide el orden neutro.'
WHERE id = 941 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Uiteindelijk pakte het goed uit, igual de natural. La tarjeta pide el orden neutro.'
WHERE id = 955 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';

UPDATE words_es SET rules_help = rules_help || '

🪧 Con inversión también valdría: Hier verkopen ze goede kaas, con el foco en aquí. La tarjeta pide el orden neutro.'
WHERE id = 1068 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪧 Con inversión también valdría%';


-- 3) El bloque compartido

UPDATE words_es SET rules_help = rules_help || '

➡️ Cuando el enunciado lleva (sin inv): El español abre con un adverbio (nunca, ayer, aquí, a veces…) y la tentación es copiarlo delante. En neerlandés eso también es correcto, pero obliga a invertir verbo y sujeto y pone el foco en el adverbio. (sin inv) significa que la quiero en orden neutro, empezando por el sujeto. Es la marca gemela de (inv).

📋 El mismo par, con y sin inversión:
• Ik ben er nooit geweest. — orden neutro, lo que pide (sin inv)
• Nooit ben ik er geweest. — correcto, con énfasis en nunca
• Ik ben hem gisteren tegengekomen. — orden neutro
• Gisteren ben ik hem tegengekomen. — igual de natural, foco en ayer
• Je mag hier niet parkeren. — orden neutro
• Hier mag je niet parkeren. — foco en aquí

🔑 El truco que casi nunca falla: Si pones el adverbio delante, el verbo conjugado salta a la segunda posición y el sujeto se va detrás, Nooit ben ik y nunca «Nooit ik ben». Si no quieres pensarlo, empieza por el sujeto, que es lo que pide (sin inv) y nunca falla.

⚠️ El adverbio se mueve, no se copia. Al ponerlo delante sale de su hueco en medio de la frase, así que Nooit ben ik er geweest y nunca «Nooit ben ik er nooit geweest». Y el er de lugar no puede abrir la frase, «Er ben ik nooit geweest» no existe.'
WHERE id IN (261, 298, 380, 461, 619, 678, 828, 852, 867, 890, 894, 935, 936, 940, 941, 955, 1068)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%➡️ Cuando el enunciado lleva (sin inv)%';


-- 4) Audio es_ES desincronizado: forzar su regeneracion

DELETE FROM word_es_media
WHERE lang_code = 'es_ES'
  AND word_es_id IN (298, 619, 678, 828, 852, 867, 1068);
