-- Learn Languages App - Migration
-- Migration: 20261020000001-mapa-un-poco-completo
-- Description: Eduardo: "en 897 no describes enigszins en el mapa de «un poco»".
--
--   La 897 (La situacion ha mejorado algo → De situatie is enigszins verbeterd) explica
--   enigszins en su regla, pero el bloque compartido «🥄 El mapa del «un poco»» no lo lleva. El
--   fallo es mas ancho que la 897: el bloque es identico en las 15 tarjetas del grupo «un poco -
--   weinig, een beetje, wat y compania» (886-900) y solo traia 5 de las 11 formas que el grupo
--   ensena. Faltaban tambien een tikkeltje (893), nauwelijks / amper (894), een tijdje /
--   een poosje (896), een paar (898) y min of meer (899).
--
--   Se sustituye el bloque entero (§3.3: un solo bloque, byte a byte en las 15) por el mapa de
--   las 11 formas, ordenadas de menos a mas cantidad y con el TIEMPO al final. Cambia tambien el
--   rotulo: «cinco cosas distintas» → «once formas». minder / steeds minder no entran en la
--   tabla: ya tienen su sitio en la 📊 escalera y en las ⚠️ trampas del mismo bloque.
--
--   Idempotente: el REPLACE se filtra por el bloque viejo exacto, que desaparece al aplicarse.
--   No toca words_es.text ni words_lang.text: el audio no se desincroniza.

PRAGMA foreign_keys = ON;

UPDATE words_es SET rules_help = REPLACE(rules_help, '🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |', '🥄 El mapa del «un poco» — once formas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **nauwelijks / amper** | apenas = CASI NADA, el escalon por debajo de weinig (amper, mas coloquial) | verbos y adjetivos | nauwelijks geslapen |
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een tikkeltje** | un pelin = el «un poco» MAS pequeno, algo carinoso | adjetivos (a menudo con te) e incontables | een tikkeltje te zout |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **een paar** | unos cuantos, un par = el «un poco» de lo CONTABLE | plurales contables | een paar vragen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **enigszins** | algo, en cierta medida = el «un poco» FORMAL, de informe o prensa | verbos, participios y adjetivos | enigszins verbeterd |
| **min of meer** | mas o menos = RELATIVIZA lo que dices, no mide cantidad | verbos, adjetivos y frases enteras | min of meer eens |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |
| **een tijdje / een poosje** | un rato LARGO, una temporada: el escalon siguiente a even | verbos | een tijdje gewoond |'), updated_at = datetime('now')
WHERE rules_help LIKE '%🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:%'
  AND instr(rules_help, '| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |') > 0;
