-- Learn Languages App - Ayuda: orden de palabras, pronombre atono y perfecto vs imperfecto (680)
-- Migration: 20260808000001-help-word-order-atonic-pronoun-680.sql
-- Description: Dos bloques a la tarjeta 680 ("Ik ben vergeten je terug te bellen"):
--   🔤 tres variantes de orden (je dentro del te / je adelantado / sin terug = bellen), el
--     porque el pronombre ATONO puede treparse y un grupo nominal pleno (mijn moeder) no
--     (regla del campo central), el matiz bellen vs terugbellen, y ejemplos con los
--     pronombres atonos mas usados (me, het, je, ons, hem/'m, ze).
--   🗓️ por que "ik ben vergeten" (PERFECTO) y no "ik vergat" (IMPERFECTO): el neerlandes
--     hablado cuenta el pasado del dia a dia en perfecto; el imperfectum se reserva para
--     narrar y para hebben/zijn/modales. Auxiliar de vergeten (olvidar hacer algo) = zijn.
--   Keyeadas por texto nl_NL, idempotentes por emoji-guarda. Solo UPDATE de
--   words_es.rules_help; no toca words_lang/audio, imagenes ni notes.

PRAGMA foreign_keys = ON;

UPDATE words_es SET rules_help = rules_help || '

🔤 Orden de palabras: donde va el objeto (y bellen vs terugbellen):
Tres opciones con esta frase:
• Ik ben vergeten je terug te bellen = olvide devolverte la llamada (NEUTRA; el objeto je va DENTRO del grupo con te).
• Ik ben je vergeten terug te bellen = lo mismo; el pronombre ATONO je TREPA hacia delante (natural al hablar).
• Ik ben vergeten je te bellen = olvide LLAMARTE (sin terug = sin "de vuelta"): bellen = llamar; terugbellen = devolver la llamada (separable: terug + te + bellen).

¿Por que je puede adelantarse y "mijn moeder" no?
1) Los pronombres ATONOS (je, me, het, ze, hem/’m, ons...) son ligeros y remiten a algo ya sabido → trepan al principio, pegados al verbo: Ik ben je vergeten terug te bellen ✓.
2) Un grupo nominal PLENO (mijn moeder, het boek) es pesado / informacion nueva → se queda DENTRO del te: Ik ben vergeten mijn moeder terug te bellen ✓ · Ik ben mijn moeder vergeten terug te bellen ✗.
Es la regla del campo central: pronombres delante, sustantivos plenos detras (como Ik heb het hem gegeven vs Ik heb het boek aan mijn broer gegeven).

Ejemplos con los pronombres atonos mas usados (los dos ordenes valen):
• me (a mi): Hij is me vergeten op te halen = se olvido de recogerme.
• het (lo): Ik ben het vergeten te doen = olvide hacerlo.
• je (te): Ik ben je vergeten te bellen = olvide llamarte.
• ons (a nosotros): Ze zijn ons vergeten uit te nodigen = se olvidaron de invitarnos.
• hem / ’m (a el/lo): Ik ben hem vergeten terug te bellen = olvide devolverle la llamada.
• ze (a ellos/ellas): Ik ben ze vergeten mee te nemen = olvide llevarmelos.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Ik ben vergeten je terug te bellen.')
  AND COALESCE(rules_help,'') NOT LIKE '%🔤%';

-- 680 · perfecto (ik ben vergeten) vs imperfecto (ik vergat)
UPDATE words_es SET rules_help = rules_help || '

🗓️ ¿Por que "ik ben vergeten" (PERFECTO) y no "ik vergat" (IMPERFECTO)?
Las dos formas existen y son correctas, pero el neerlandes HABLADO usa por defecto el PERFECTO (voltooid tegenwoordige tijd) para un hecho pasado concreto; el imperfecto (imperfectum) se reserva para narrar.
• Ik ben vergeten... = perfecto (ben + vergeten). Es lo normal en conversacion: hecho puntual ya cumplido y con efecto AHORA (me olvide → y por eso no te llame). Como disculpa: Sorry, ik ben vergeten je terug te bellen. Español "olvide / se me olvido".
• Ik vergat... = imperfectum (pasado simple). Correcto, pero suena a NARRACION / trasfondo, dentro de una historia o secuencia: Ik was zo druk dat ik vergat je terug te bellen (estaba tan liado que olvide devolverte la llamada). Suelto, como disculpa, no se usa.
Regla del neerlandes hablado: el pasado del dia a dia se cuenta en PERFECTO; el imperfectum se guarda para (a) hebben/zijn/modales — was, had, kon, moest, wilde — que SI van en imperfecto al hablar; (b) narrar o describir escenas; (c) acciones repetidas o de fondo.
Ojo al auxiliar: vergeten (olvidar hacer/dejar algo) va con ZIJN → ik BEN vergeten. Con hebben (ik heb ... vergeten) es "no recordar un dato": Ik heb je naam vergeten = he olvidado tu nombre.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Ik ben vergeten je terug te bellen.')
  AND COALESCE(rules_help,'') NOT LIKE '%🗓️%';
