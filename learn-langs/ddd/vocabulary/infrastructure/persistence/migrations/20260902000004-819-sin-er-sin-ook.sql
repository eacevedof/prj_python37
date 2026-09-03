-- Learn Languages App - la 819: ¿que pasa si quito el er? ¿y si quito el ook?
-- Migration: 20260902000004-819-sin-er-sin-ook.sql
-- Description: Eduardo sobre la 819 (Ik sta je bij, wat er ook gebeurt): «no entiendo todavia el
--   uso del er, ¿que pasa si dejo fuera el er? ¿y si dejo fuera ook? ¿como se entenderia?». La
--   ayuda ya decia que el er es expletivo pero no contestaba a las dos supresiones: se añade el
--   bloque ✂️ — sin er la frase suena rota (el er existencial de Er gebeurt iets, obligatorio con
--   sujeto indefinido; la pregunta Wat gebeurt er? lo delata) y sin ook deja de ser concesiva
--   (wat er gebeurt = «lo que pasa», relativa normal; el ook es el «-quiera») — y el bloque 🌀
--   con la tabla de la formula (wat er ook gebeurt / wie er ook komt / waar je ook bent / hoe
--   het er ook uitziet), IDENTICO byte a byte al de la tarjeta nueva de eruitzien
--   (20260902000005), aclarando que el er de hoe het er ook uitziet es OTRO er (el de
--   eruitzien). Idempotente: guard ✂️ + IS NOT NULL.

PRAGMA foreign_keys = ON;

UPDATE words_es
SET rules_help = rules_help || '

✂️ ¿Y si quito piezas? — las dos dudas de esta tarjeta:

• sin er — «wat ook gebeurt» le suena rota al nativo. El er esta porque el sujeto es INDEFINIDO: la frase madre es Er gebeurt iets (pasa algo), el mismo er existencial de Er is een probleem. La pregunta lo delata: Wat gebeurt er? (¿que pasa?). Quitarlo no cambia el significado — te entenderian — pero falta la muleta que el neerlandes exige con sujeto indefinido: aprendela dentro de la formula, como una pieza fija.
• sin ook — Ik sta je bij, wat er gebeurt ya NO significa «pase lo que pase»: wat er gebeurt a secas es «lo que pasa» (Ik zie wat er gebeurt — veo lo que pasa), y pegada a la principal el oyente entiende «te apoyo, lo que pasa…» y se queda esperando el final de la frase. El ook es el que pone el «-quiera».

🌀 La formula concesiva: interrogativo + (er) + ook … + verbo al final:

| formula | literal | espanol |
|---|---|---|
| wat er ook gebeurt | lo que sea que pase | pase lo que pase |
| wie er ook komt | quien sea que venga | venga quien venga |
| waar je ook bent | donde sea que estes | estes donde estes |
| hoe het er ook uitziet | el aspecto que sea que tenga | pinte como pinte |

• el ook es el «-quiera» espanol: sin el, la frase se queda en una relativa normal (wat er gebeurt = lo que pasa) y pierde el «pase lo que pase».
• el er solo aparece si la gramatica lo pide: en wat/wie er ook … porque el sujeto es indefinido (viene de Er gebeurt iets); en hoe het er ook uitziet porque es parte del verbo eruitzien; en waar je ook bent no hay er, porque je es definido.
• el verbo va al final: son subordinadas.'
WHERE id = 819 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%✂️%';
