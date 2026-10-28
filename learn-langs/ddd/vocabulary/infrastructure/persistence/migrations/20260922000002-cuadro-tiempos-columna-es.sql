-- Learn Languages App - Migration
-- Migration: 20260922000002-cuadro-tiempos-columna-es
-- Description: Eduardo, sobre la 521: "en 521 hay una tabla con lo q dices en español va en
--   neerlandes ejemplo, pon una columna mas con la trad en español antes de ejemplo".
--
--   La tabla del bloque compartido '🧭 El cuadro de tiempos es → nl' daba el ejemplo SOLO en
--   neerlandes, asi que para leer la fila habia que traducir mentalmente justo la frase que
--   ilustra la regla — que es lo que se esta aprendiendo.
--
--   Pasa de 3 a 4 columnas, con la traduccion ANTES del ejemplo, como pidio:
--     | lo que dices en español | lo que va en neerlandes | el ejemplo en español | el ejemplo en neerlandes |
--
--   La 4a columna se renombra de «ejemplo» a «el ejemplo en neerlandes»: con la traduccion al
--   lado, un «ejemplo» a secas ya no dice cual de las dos es, y la 1a columna («lo que dices en
--   español») habla del CASO gramatical, no de la frase.
--
--   Las 10 traducciones son las de las propias tarjetas del grupo de tiempos, no versiones
--   nuevas: «llevo cinco años viviendo aqui» (1104), «no lo veo desde el verano» (1101),
--   «acabo de comer» (1102), «no me acuerdo de su nombre» (1105), «ayer comi» (1108), «cuando
--   era joven» (521), «antes siempre ibamos» (1110), «no lo encontraba» (927/930), «no te habia
--   visto» (1112), «mañana voy al medico» (1114). Asi la tabla y el mazo dicen lo mismo.
--
--   Bloque compartido (§3.3): se sustituye byte a byte con REPLACE en las 22 tarjetas que lo
--   llevan (261, 438, 521, 659, 927, 930, 932, 935, 1101-1115). Idempotente por §5.3: el guard
--   busca la cabecera VIEJA, que desaparece en la primera pasada.
--
--   No toca ningun words_es.text ni words_lang.text -> no hay audio que regenerar (§5.6.5).

UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '| lo que dices en español | lo que va en neerlandes | ejemplo |
|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | **Morgen ga ik** naar de dokter. |',
    '| lo que dices en español | lo que va en neerlandes | el ejemplo en español | el ejemplo en neerlandes |
|---|---|---|---|
| presente que empezo antes y sigue | **presente** + al | Llevo cinco años viviendo aqui. | Ik woon hier **al** vijf jaar. |
| presente NEGADO con desde o hace | **perfectum** | No lo veo desde el verano. | Ik **heb** hem sinds de zomer niet **gezien**. |
| acabo de + infinitivo | **perfectum** + net | Acabo de comer. | Ik **heb** net **gegeten**. |
| no me acuerdo, no lo encuentro: el resultado | **perfectum** | No me acuerdo de su nombre. | Ik **ben** zijn naam **vergeten**. |
| indefinido suelto: comi, fui, estuve | **perfectum** al hablar | Ayer comi. | Gisteren **heb** ik **gegeten**. |
| imperfecto: era, iba, estaba | **imperfectum** | Cuando era joven… | **Toen** ik jong **was**… |
| costumbre del pasado: antes siempre… | **imperfectum** + vroeger | Antes siempre ibamos… | **Vroeger gingen** we altijd… |
| poder, querer, tener que en pasado | **imperfectum** | No lo encontraba. | Ik **kon** het niet vinden. |
| pluscuamperfecto: habia visto | **had** + participio | No te habia visto. | Ik **had** je niet **gezien**. |
| futuro: ire, voy a ir | **presente** | Mañana voy al medico. | **Morgen ga ik** naar de dokter. |'
)
WHERE rules_help LIKE '%| lo que dices en español | lo que va en neerlandes | ejemplo |%';
