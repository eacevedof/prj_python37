-- Learn Languages App - Ayuda: perfectum vs imperfectum (tarjetas 657 y 662)
-- Migration: 20260810000001-help-perfect-vs-imperfect-past-657-662.sql
-- Description: Eduardo se lia con que en 657 "te llame ayer" el NL usa PERFECTUM
--   (Ik heb je gisteren opgebeld) pero en 662 "me lo lleve a casa" usa IMPERFECTUM
--   (Ik nam hem mee), cuando en espanol las dos son pasado simple. El bloque 🕰️
--   deja claro que NO lo decide el espanol sino el REGISTRO del neerlandes:
--   perfectum = hecho suelto que cuentas/respondes (pasado por defecto hablado);
--   imperfectum = narracion encadenada + los verbos grandes zijn/hebben/modales;
--   y que ambas suelen valer (657 tambien "belde", 662 tambien "heb meegenomen").
--   Mismo bloque en las dos tarjetas (par de contraste). Keyeada por texto nl_NL,
--   idempotente por emoji-guarda 🕰️. Solo UPDATE de rules_help.

PRAGMA foreign_keys = ON;

-- 657 · perfectum (heb opgebeld) vs 662 · imperfectum (nam mee)
UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Por que 657 "heb opgebeld" (participio) pero 662 "nam mee" (pasado simple), si en espanol las dos son pasado simple?
El lio NO esta en el espanol (llame / lleve, las dos son pasado simple), esta en que el neerlandes tiene DOS pasados y elige por REGISTRO, no por la forma espanola:
• PERFECTUM (heb/ben + participio: heb opgebeld, ben gegaan) = el pasado POR DEFECTO del neerlandes hablado. Un hecho SUELTO, algo que cuentas o respondes ("¿que hiciste ayer?"). Por eso 657: Ik heb je gisteren opgebeld. El espanol "te llame / te he llamado" casi siempre -> perfectum.
• IMPERFECTUM (belde, nam, ging, was, had) = modo NARRACION: encadenas hechos o describes una escena/trasfondo ("y entonces...", como contar una historia). La 662 va asi: "Hij had te veel op, dus ik nam hem mee naar huis" (habia bebido de mas, asi que me lo lleve a casa) -> es un relato con secuencia, por eso nam mee.
• SIEMPRE imperfectum aunque hables (nunca en perfectum en el dia a dia): los verbos "grandes" zijn (was/waren), hebben (had/hadden) y los modales (kon, moest, wilde, mocht, zou). -> Ik was moe, ik had geen tijd, ik moest werken.

💡 Lo que te desbloquea: las dos formas suelen ser CORRECTAS; es estilo, no error.
• 657 tambien admite "Ik belde je gisteren" (imperfectum) -> suena algo mas narrativo.
• 662 tambien admite "Ik heb hem meegenomen naar huis" (perfectum) -> suena a hecho suelto.
La app te pide una respuesta concreta, pero si dudas, decide asi:

📌 Regla de bolsillo (pasado simple espanol -> ¿que pasado NL?):
① ¿Hecho suelto que cuentas o respondes? -> PERFECTUM (heb/ben + participio): Ik heb gegeten, Ik ben gegaan, Ik heb je opgebeld.
② ¿Estas narrando una secuencia o describiendo una escena? -> IMPERFECTUM (belde, nam, ging): ...dus ik nam hem mee.
③ ¿Es zijn, hebben o un modal? -> IMPERFECTUM siempre: was, waren, had, hadden, kon, moest, wilde, mocht, zou.
Truco: si en espanol podrias decirlo tambien con "he ..." (he llamado, he ido) casi seguro es perfectum; si es puro relato ("aquel dia ..., entonces ...") tira a imperfectum.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Ik heb je gisteren opgebeld.')
  AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';

UPDATE words_es SET rules_help = rules_help || '

🕰️ ¿Por que 662 "nam mee" (pasado simple) pero 657 "heb opgebeld" (participio), si en espanol las dos son pasado simple?
El lio NO esta en el espanol (lleve / llame, las dos son pasado simple), esta en que el neerlandes tiene DOS pasados y elige por REGISTRO, no por la forma espanola:
• IMPERFECTUM (nam, belde, ging, was, had) = modo NARRACION: encadenas hechos o describes una escena/trasfondo ("y entonces...", como contar una historia). Esta 662 va asi: "Hij had te veel op, dus ik nam hem mee naar huis" (habia bebido de mas, asi que me lo lleve a casa) -> relato con secuencia, por eso nam mee.
• PERFECTUM (heb/ben + participio: heb meegenomen, heb opgebeld) = el pasado POR DEFECTO del neerlandes hablado. Un hecho SUELTO, algo que cuentas o respondes ("¿que hiciste ayer?"). Por eso la 657 usa "Ik heb je gisteren opgebeld". El espanol "me lleve / me he llevado" tambien -> perfectum si es hecho aislado.
• SIEMPRE imperfectum aunque hables (nunca en perfectum en el dia a dia): los verbos "grandes" zijn (was/waren), hebben (had/hadden) y los modales (kon, moest, wilde, mocht, zou). -> Ik was moe, ik had geen tijd, ik moest werken. (Fijate: la 662 ya lleva "had" -> Hij HAD te veel op.)

💡 Lo que te desbloquea: las dos formas suelen ser CORRECTAS; es estilo, no error.
• 662 tambien admite "Ik heb hem meegenomen naar huis" (perfectum) -> suena a hecho suelto.
• 657 tambien admite "Ik belde je gisteren" (imperfectum) -> suena algo mas narrativo.
La app te pide una respuesta concreta, pero si dudas, decide asi:

📌 Regla de bolsillo (pasado simple espanol -> ¿que pasado NL?):
① ¿Hecho suelto que cuentas o respondes? -> PERFECTUM (heb/ben + participio): Ik heb gegeten, Ik ben gegaan, Ik heb hem meegenomen.
② ¿Estas narrando una secuencia o describiendo una escena? -> IMPERFECTUM (nam, belde, ging): ...dus ik nam hem mee.
③ ¿Es zijn, hebben o un modal? -> IMPERFECTUM siempre: was, waren, had, hadden, kon, moest, wilde, mocht, zou.
Truco: si en espanol podrias decirlo tambien con "he ..." (he ido, me he llevado) casi seguro es perfectum; si es puro relato ("aquel dia ..., entonces ...") tira a imperfectum.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Ik nam hem mee naar huis.')
  AND COALESCE(rules_help,'') NOT LIKE '%🕰️%';
