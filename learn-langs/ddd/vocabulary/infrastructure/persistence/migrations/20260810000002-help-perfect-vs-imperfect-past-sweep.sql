-- Learn Languages App - Barrido ayuda perfectum vs imperfectum (grupo pasado 613-687)
-- Migration: 20260810000002-help-perfect-vs-imperfect-past-sweep.sql
-- Description: Cuelga el bloque 🕰️ (perfectum vs imperfectum: el NL tiene dos pasados y lo
--   decide el registro, no el espanol) a las 28 tarjetas de pasado del grupo, con una linea
--   "👉 Aqui:" a medida por tarjeta (por que ESA usa su tiempo/auxiliar). Complementa la
--   20260810000001 que ya lo puso en 657 y 662. Keyeada por id, idempotente por emoji-guarda
--   🕰️, solo UPDATE de rules_help.

PRAGMA foreign_keys = ON;


-- 613
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: espanol e NL coinciden (perfecto compuesto). kopen con HEBBEN (transitivo, een boek = objeto). Hecho suelto.'
WHERE id = 613 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 614
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, werken con HEBBEN (actividad sin destino). Espanol perfecto = NL perfectum.'
WHERE id = 614 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 615
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, eten con HEBBEN. Hecho suelto que cuentas.'
WHERE id = 615 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 616
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, zien con HEBBEN. Pregunta por un hecho -> perfecto por defecto.'
WHERE id = 616 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 617
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, verkopen con HEBBEN (transitivo, hun huis = objeto; el cambio del OBJETO no dispara zijn).'
WHERE id = 617 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 618
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, slapen con HEBBEN.'
WHERE id = 618 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 619
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: OJO: en espanol es pasado SIMPLE (encontre) pero el NL usa PERFECTUM igual (hecho suelto = pasado por defecto). tegenkomen con ZIJN (encuentro/movimiento). Tambien valdria narrar en imperfecto (kwam ik tegen), pero suelto -> perfecto.'
WHERE id = 619 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 620
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, gaan con ZIJN (movimiento del sujeto).'
WHERE id = 620 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 621
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, komen con ZIJN (movimiento/llegada).'
WHERE id = 621 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 622
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, vallen con ZIJN (el jarron = sujeto que cambia, intransitivo).'
WHERE id = 622 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 623
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum de zijn = ben/is/zijn geweest ("haber estado en un sitio"). OJO: como verbo normal zijn suele ir en imperfecto (was), pero "estuvimos/hemos estado EN un lugar" se dice zijn geweest.'
WHERE id = 623 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 624
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, gebeuren con ZIJN. "¿que ha pasado?" hecho suelto.'
WHERE id = 624 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 625
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, worden (cambio de estado) con ZIJN -> is geworden.'
WHERE id = 625 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 626
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum con ZIJN porque hay DESTINO (naar school): fietsen con destino = movimiento -> zijn. Contrasta con la 627.'
WHERE id = 626 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 627
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum con HEBBEN porque es ACTIVIDAD sin destino (twee uur fietsen): mismo verbo que la 626 pero sin destino -> hebben.'
WHERE id = 627 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 628
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, liggen con HEBBEN (postura, sin cambio de lugar del sujeto).'
WHERE id = 628 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 629
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, staan con HEBBEN (postura, sin destino).'
WHERE id = 629 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 630
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum con ZIJN: gaan liggen (ir a tumbarse, movimiento/cambio de posicion del sujeto).'
WHERE id = 630 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 658
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum con ZIJN: opstaan = levantarse (cambio de posicion del sujeto). Orden: Vanochtend ben ik... (inversion por el adverbio inicial).'
WHERE id = 658 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 659
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: OJO: espanol "acabamos de llegar" -> en NL = net + PERFECTUM (net aangekomen). aankomen con ZIJN. "acabar de" no existe como tal: se dice net + perfecto.'
WHERE id = 659 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 661
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: OJO: espanol pasado SIMPLE (cogiste) y aqui el NL tambien va en IMPERFECTUM (nam op): pregunta sobre un momento concreto ya cerrado. Tambien valdria heb je opgenomen (perfecto); las dos correctas.'
WHERE id = 661 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 664
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, uitnodigen con HEBBEN (transitivo, ons = objeto).'
WHERE id = 664 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 665
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, terugbellen con HEBBEN. "¿ya ha devuelto la llamada?" hecho suelto.'
WHERE id = 665 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 666
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum, uitgeven con HEBBEN (transitivo, geld = objeto).'
WHERE id = 666 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 667
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum con ZIJN: weggaan = irse (movimiento del sujeto).'
WHERE id = 667 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 668
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum con HEBBEN: opruimen es transitivo (je kamer = objeto) -> hebben, aunque el cuarto quede cambiado (el cambio del OBJETO no dispara zijn).'
WHERE id = 668 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 678
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: CLAVE: espanol pasado simple (tuve que) y el NL va en IMPERFECTUM porque es un MODAL (moeten -> moest): los modales van casi siempre en imperfecto en el habla (moest, kon, wilde, mocht), NO "heb gemoeten".'
WHERE id = 678 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

-- 687
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Perfectum (heb/ben + participio) o imperfectum (belde/nam/was)? El NL tiene DOS pasados y NO lo decide el espanol:
- PERFECTUM = el pasado POR DEFECTO del habla: un hecho SUELTO que cuentas o respondes ("¿que hiciste?"). Ik heb gegeten, Ik ben gegaan.
- IMPERFECTUM = modo NARRACION (encadenas hechos / describes una escena, "y entonces...") y SIEMPRE los verbos grandes zijn (was), hebben (had) y modales (kon, moest, wilde, mocht, zou).
- Las dos suelen valer; es registro, no error.
Regla de bolsillo: ① hecho suelto que cuentas/respondes -> PERFECTUM · ② relato/descripcion -> IMPERFECTUM · ③ zijn/hebben/modal -> IMPERFECTUM siempre.

👉 Aqui: perfectum con ZIJN: ziek worden = ponerse enfermo (cambio de estado del sujeto) -> ben geworden.'
WHERE id = 687 AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';
