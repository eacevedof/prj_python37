-- Learn Languages App - Ayuda: lopen vs wandelen y las formas de "tanto" (tarjeta 685)
-- Migration: 20260809000001-help-lopen-wandelen-and-tanto-685.sql
-- Description: Dos bloques a la 685 ("Ik word moe van al dat lopen"):
--   🚶 lopen (andar/caminar general) vs wandelen (pasear por placer): por que "van al dat
--     lopen" y no "van wandelen" (cambia el significado); matiz regional BE (lopen=correr).
--   🔢 formas de "tanto": al dat/al die/al het (coloquial, acumulacion), zoveel (cantidad),
--     zo = TAN (grado, no tanto), zozeer, evenveel...als (comparacion).
--   🈵 al / alle / alles / helemaal: por que "al" (=ya) tambien vale "todo"; cuando cada uno.
--   Keyeadas por texto nl_NL, idempotentes por emoji-guarda. Solo UPDATE de rules_help.

PRAGMA foreign_keys = ON;

-- 685 · lopen vs wandelen
UPDATE words_es SET rules_help = rules_help || '

🚶 lopen vs wandelen (¿por que "van al dat lopen" y no "van wandelen"?)
Las dos son correctas, pero significan cosas distintas:
• lopen = andar / caminar (general: ir a pie, moverse mucho, estar de pie). al dat lopen = todo ese andar / tanto caminar → el cansancio de moverse mucho (un dia largo, recados...). Encaja con "me canso de tanto ANDAR".
• wandelen = PASEAR / dar un paseo / hacer senderismo (andar por placer, deliberado). Ik word moe van wandelen = me canso de pasear → otra cosa (te cansas de dar paseos recreativos), no "de tanto andar".
Matiz regional: en Belgica lopen suele ser "correr" y se usa stappen/wandelen para caminar; en Paises Bajos (nl_NL) lopen = caminar.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Ik word moe van al dat lopen.')
  AND COALESCE(rules_help,'') NOT LIKE '%🚶%';

-- 685 · formas de "tanto"
UPDATE words_es SET rules_help = rules_help || '

🔢 "tanto" en neerlandes (y por que aqui es "al dat"):
• al dat / al die / al het = literal "todo ese/esa/esos", coloquialmente "tanto" (acumulacion, a menudo con fastidio): al dat lopen (tanto andar), al die mensen (tanta gente), al het werk (tanto trabajo). Concordancia: al dat + het-woord/infinitivo · al die + plural o de-woord · al het + het-woord.
• zoveel (= zo veel) = tanto/tantos de CANTIDAD: zoveel werk, zoveel mensen. Alternativa valida: Ik word moe van zoveel lopen = me canso de andar tanto.
• OJO con zo: zo = TAN (grado, delante de adjetivo/adverbio): zo moe = tan cansado, zo snel = tan rapido. NO es "tanto" de cantidad (y zo tambien = "asi"). zo n = "un/una tan..." (zo n grote hond = un perro tan grande).
• zozeer = tanto (hasta tal punto, formal): niet zozeer = no tanto. evenveel / net zoveel ... als = tanto ... como (comparacion): evenveel als jij.
Para esta frase: van al dat lopen (de tanto andar, coloquial) o van zoveel lopen (de andar tanto); NO "van zo lopen" (zo = tan, no cuadra con el verbo).'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Ik word moe van al dat lopen.')
  AND COALESCE(rules_help,'') NOT LIKE '%🔢%';

-- 685 · al / alle / alles / helemaal
UPDATE words_es SET rules_help = rules_help || '

🈵 al / alle / alles / helemaal (¿"al" no era "ya"? ¿y "todo" no es "alles"?)
"al" tiene DOS vidas: (1) adverbio = YA (Ik ben al klaar = ya estoy listo; het is al laat); (2) cuantificador = TODO/A/OS, y este es el de "al dat lopen".
Cual usar para "todo":
• al = todo, delante de OTRO determinante (articulo/demostrativo/posesivo). No lleva -e: al de mensen (toda la gente), al die mensen, al het werk, al mijn geld, al dat lopen. Formula: al + {de/het/dit/dat/die/mijn/jouw...} + sustantivo.
• alle = todos/as (adjetivo flexionado), va DIRECTO al sustantivo, SIN articulo: alle mensen, alle boeken. (No se dice "alle de mensen": con articulo -> al de mensen.)
• alles = TODO pronombre (= everything), va SOLO, no acompaña sustantivo: Ik heb alles gezien (lo he visto todo), alles is klaar.
• helemaal = del todo / completamente (GRADO, no cantidad): Ik ben het helemaal vergeten (lo olvide por completo). NO sirve para "todo ese/tanto": no vale para al dat lopen.
Error diana: nada de "alle de mensen" ni "alles het werk". Con determinante detras -> al; sustantivo desnudo -> alle; suelto -> alles.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Ik word moe van al dat lopen.')
  AND COALESCE(rules_help,'') NOT LIKE '%🈵%';
