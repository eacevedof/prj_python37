-- Learn Languages App - Ayuda: tegenkomen (Gisteren al frente + zijn pese a objeto) (tarjeta 619)
-- Migration: 20260811000005-help-tegenkomen-fronting-zijn-exception-619.sql
-- Description: Eduardo (619 "Ik ben hem gisteren tegengekomen") pregunta si vale
--   "Gisteren heb ik hem tegengekomen". Media: adelantar Gisteren es correcto pero
--   OBLIGA a inversion (verbo 2o, sujeto detras) -> "Gisteren ben ik hem tegengekomen".
--   El error es "heb": tegenkomen (familia komen, encuentro/movimiento) va SIEMPRE con
--   ZIJN, aunque lleve objeto directo (hem) -> es EXCEPCION al test del complemento.
--   Bloque 🔁. Card ya aplicada -> migracion nueva. Keyeada por id, idempotente por 🔁,
--   solo rules_help.

PRAGMA foreign_keys = ON;

-- 619 · tegenkomen: Gisteren al frente (inversion) + zijn pese a objeto (excepcion)
UPDATE words_es SET rules_help = rules_help || '

🔁 ¿Vale "Gisteren heb ik hem tegengekomen"? Mitad bien, mitad mal.
- ✅ Adelantar Gisteren SI vale (y suena natural, enfatiza el "ayer"), pero OBLIGA a inversion: el verbo va en 2a posicion y el sujeto detras -> Gisteren ben ik hem tegengekomen. Lo que NO vale es "Gisteren ik ben..." (sujeto delante del verbo).
- ❌ "heb" es el error: tegenkomen es de la familia de komen (cruzarse con / encuentro = movimiento) y va SIEMPRE con ZIJN, nunca con hebben -> ben ik hem tegengekomen, no heb.
- Resultado correcto: Gisteren ben ik hem tegengekomen (= tu frase, pero con ben). Igual de valido el orden original: Ik ben hem gisteren tegengekomen.

⚠️ La trampa: tegenkomen LLEVA objeto directo (hem = lo), y la regla general dice "con objeto -> hebben". Pero tegenkomen es una EXCEPCION: aunque tenga objeto, va con ZIJN por ser compuesto de komen (movimiento/encuentro). Es de las poquisimas que rompen el "test del complemento". Por eso "hem" te empuja a decir "heb", y no es asi. (Parientes que hacen lo mismo: iemand tegemoetkomen. En cambio zien/kennen/ontmoeten SI son normales -> hebben: Ik heb hem ontmoet.)'
WHERE id = 619 AND COALESCE(rules_help,'') NOT LIKE '%🔁%';
