-- Learn Languages App - Bloque compartido: el «se» espanol son TRES cosas y solo una es zich
-- Migration: 20260831000001-help-block-zich-vs-worden-passive.sql
-- Description: La duda nace de «Dit element in het programma wordt minder goed bekeken»
--   («esa seccion se ve poco»): el instinto del hispanohablante busca un reflexivo (zich)
--   donde el neerlandes exige una PASIVA con worden. Las tarjetas de worden (694-699, 686-692,
--   267, 460-463) ya explicaban los DOS trabajos de worden (cambio de estado y pasiva), pero
--   no daban el procedimiento para DECIDIR entre zich y worden, ni la receta mecanica de la
--   pasiva, ni los tres atajos que el neerlandes hablado prefiere a la pasiva (je / men / er).
--   Este bloque anade justo eso, IDENTICO byte a byte, a las 20 tarjetas del fenomeno:
--     - reflexivas de verdad (zich / je): 601, 602, 606, 826
--     - pasiva impersonal con er: 267, 460, 461, 462, 463
--     - cambio de estado con worden: 686, 688, 690, 692
--     - pasiva con «se»: 694, 695, 696, 697, 698, 699
--     - pasiva de perfecto (zijn + participio): 830
--   La 826 («Het kind verborg zich achter de bank») tenia rules_help a NULL — un || sobre NULL
--   da NULL —, asi que se le crea la ayuda entera: explicacion propia de zich verbergen (con
--   la conjugacion del reflexivo, que no siempre es «zich») + el MISMO bloque.
--   100% aditiva e idempotente: UPDATE con guard por marca (🧪 ¿zich o worden?).

-- ==============================================================================
-- 1. Las 19 tarjetas que YA tienen ayuda: se les anade el bloque al final
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧪 ¿zich o worden? El «se» espanol son TRES cosas distintas
El espanol escribe igual tres fenomenos que el neerlandes separa. Antes de traducir un «se», pasa la frase por dos tests:
• Test del «a si mismo» — ¿puedo anadirlo sin que suene absurdo? Si SI, es reflexivo de verdad → zich. El nino se escondio (a si mismo) → Het kind verborg zich. · Esa seccion se ve poco (a si misma) ❌ absurdo → NO es zich.
• Test del «alguien lo…» — ¿puedo reescribirlo con un agente indefinido? Si SI, es pasiva → worden + participio. Esa seccion se ve poco = la gente la ve poco → Dat element wordt weinig bekeken.

| el «se» espanol | que es | en neerlandes |
|---|---|---|
| se lava, se esconde, se aburre | reflexivo: el sujeto se lo hace a si mismo | **zich** — Het kind verborg **zich** achter de bank. |
| se vende, se dice, aqui se fuma | pasiva/impersonal: el sujeto la padece | **worden** + participio — Dit huis **wordt verkocht**. |
| se enfada, se cansa, se hace medico | cambio de estado | **worden** + adjetivo — Hij **wordt** snel boos. |

📌 Regla de bolsillo: si el sujeto NO puede ser el autor de la accion, cambia el chip a worden. Solo cuando el sujeto se lo hace a si mismo es zich. Fijate en que DOS de las tres familias caen en worden y solo UNA en zich: por eso el instinto espanol (buscar el reflexivo) falla la mayoria de las veces.

⚙️ La receta mecanica de la pasiva, para automatizarla:
[lo que en espanol era el objeto] + worden (2a casilla) + … + PARTICIPIO al final.
• presente: wordt (singular) / worden (plural) — Hier wordt Nederlands gesproken. (aqui se habla neerlandes)
• pasado: werd / werden — Het programma werd vorig jaar veel bekeken. (el programa se vio mucho el ano pasado)
• perfecto: CAE el worden y queda zijn + participio — Het is bekeken. Nunca «is geworden bekeken», porque el propio worden hace su perfecto con zijn.
• el agente, cuando aparece, va con DOOR — Het wordt weinig bekeken door jongeren.
• en subordinada, todo al final — …dat het weinig bekeken wordt.
• sujeto plural → worden: Er worden appartementen verkocht. (se venden pisos)

🗣️ La trampa contraria: el neerlandes hablado a menudo NO usa la pasiva donde el espanol pone «se». Tres atajos que conviene tener a mano:
• je = el impersonal mas natural al hablar. Dat zie je niet vaak. — Eso no se ve mucho.
• men = el impersonal formal, de lengua escrita. Men zegt dat hij rijk is. — Se dice que es rico.
• er + pasiva sin sujeto = el impersonal sin protagonista. Er wordt veel gepraat. — Se habla mucho.',
    updated_at = datetime('now')
WHERE id IN (601, 602, 606, 267, 460, 461, 462, 463, 686, 688, 690, 692, 694, 695, 696, 697, 698, 699, 830)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧪 ¿zich o worden?%';

-- ==============================================================================
-- 2. La 826 no tenia ayuda (NULL): se le crea con explicacion propia + el mismo bloque
-- ==============================================================================
UPDATE words_es
SET rules_help = 'zich verbergen = esconderse. Es un reflexivo DE VERDAD (el nino se esconde a si mismo), y por eso aqui si va zich: Het kind verborg zich achter de bank.

📌 zich es la forma de 3a persona (hij, ze, het, ze plural) y la de usted (u). Con las demas personas el reflexivo cambia: Ik verberg me · Jij verbergt je · Wij verbergen ons. El diccionario lo cita siempre como «zich verbergen», pero en la frase hay que conjugarlo tambien a el.

⚠️ verbergen es fuerte e irregular: verbergen - verborg - verborgen. Y no lo confundas con verstoppen, que es el de esconder algo o jugar al escondite (verstoppertje spelen).

🧪 ¿zich o worden? El «se» espanol son TRES cosas distintas
El espanol escribe igual tres fenomenos que el neerlandes separa. Antes de traducir un «se», pasa la frase por dos tests:
• Test del «a si mismo» — ¿puedo anadirlo sin que suene absurdo? Si SI, es reflexivo de verdad → zich. El nino se escondio (a si mismo) → Het kind verborg zich. · Esa seccion se ve poco (a si misma) ❌ absurdo → NO es zich.
• Test del «alguien lo…» — ¿puedo reescribirlo con un agente indefinido? Si SI, es pasiva → worden + participio. Esa seccion se ve poco = la gente la ve poco → Dat element wordt weinig bekeken.

| el «se» espanol | que es | en neerlandes |
|---|---|---|
| se lava, se esconde, se aburre | reflexivo: el sujeto se lo hace a si mismo | **zich** — Het kind verborg **zich** achter de bank. |
| se vende, se dice, aqui se fuma | pasiva/impersonal: el sujeto la padece | **worden** + participio — Dit huis **wordt verkocht**. |
| se enfada, se cansa, se hace medico | cambio de estado | **worden** + adjetivo — Hij **wordt** snel boos. |

📌 Regla de bolsillo: si el sujeto NO puede ser el autor de la accion, cambia el chip a worden. Solo cuando el sujeto se lo hace a si mismo es zich. Fijate en que DOS de las tres familias caen en worden y solo UNA en zich: por eso el instinto espanol (buscar el reflexivo) falla la mayoria de las veces.

⚙️ La receta mecanica de la pasiva, para automatizarla:
[lo que en espanol era el objeto] + worden (2a casilla) + … + PARTICIPIO al final.
• presente: wordt (singular) / worden (plural) — Hier wordt Nederlands gesproken. (aqui se habla neerlandes)
• pasado: werd / werden — Het programma werd vorig jaar veel bekeken. (el programa se vio mucho el ano pasado)
• perfecto: CAE el worden y queda zijn + participio — Het is bekeken. Nunca «is geworden bekeken», porque el propio worden hace su perfecto con zijn.
• el agente, cuando aparece, va con DOOR — Het wordt weinig bekeken door jongeren.
• en subordinada, todo al final — …dat het weinig bekeken wordt.
• sujeto plural → worden: Er worden appartementen verkocht. (se venden pisos)

🗣️ La trampa contraria: el neerlandes hablado a menudo NO usa la pasiva donde el espanol pone «se». Tres atajos que conviene tener a mano:
• je = el impersonal mas natural al hablar. Dat zie je niet vaak. — Eso no se ve mucho.
• men = el impersonal formal, de lengua escrita. Men zegt dat hij rijk is. — Se dice que es rico.
• er + pasiva sin sujeto = el impersonal sin protagonista. Er wordt veel gepraat. — Se habla mucho.',
    updated_at = datetime('now')
WHERE id = 826
  AND rules_help IS NULL;
