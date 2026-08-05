-- Learn Languages App - Ayuda gramatical: weer / ben vergeten / verbo reflexivo / komen-aankomen
-- Migration: 20260805000001-grammar-help-weer-vergeten-reflexive.sql
-- Description: Bloques de ayuda (APPEND a words_es.rules_help) para varias tarjetas nl_NL:
--   1) 🔄 weer vs nog eens / nog een keer / opnieuw / alweer, en las 3 frases con "weer":
--        302 (Hij zal wel weer te laat zijn), 304 (Het zal wel weer aan mij liggen),
--        682 (Ik hoop je snel weer te zien).
--   2) ⏰ por que "Ik ben vergeten..." (perfecto, hecho pasado) y no "Ik vergeet..."
--        (presente, habito): tarjeta 680.
--   3) 🪞 marca de verbo reflexivo (zich afvragen) en la tarjeta 324 (unica reflexiva
--        fuera del grupo 17, que ya lo marca en su rules_help/notes).
--   4) 🛬 komen vs aankomen vs "we zijn te laat" en la tarjeta 670 (Schiet op, we komen te
--        laat): por que komen y no aankomen (aan), y el matiz de "we zijn te laat".
--        (El contraste te laat vs laat ya lo cubre 20260721000001.)
--   Todas keyeadas por el texto nl_NL (rebuild-robusto), idempotentes por emoji guarda.
--   Solo UPDATE de words_es.rules_help; no toca words_lang/audio, imagenes ni notes.

PRAGMA foreign_keys = ON;

-- 1) weer -------------------------------------------------------------------

-- 302 · Hij zal wel weer te laat zijn (Seguro que llega tarde otra vez)
UPDATE words_es SET rules_help = rules_help || '

🔄 weer vs nog eens / nog een keer / opnieuw / alweer:
Aqui weer = "otra vez" con sentido de RECURRENCIA habitual (vuelve a pasar lo de siempre), reforzado por el "zal wel" de resignacion.
• weer = de nuevo / otra vez → algo VUELVE a ocurrir (vuelta a un estado anterior). Es la forma natural para habitos y repeticiones molestas.
• alweer = weer + fastidio/sorpresa ("ya otra vez, tan pronto"): Hij is alweer te laat encaja perfecto y suena aun mas harto. INTERCAMBIABLE aqui, subiendo el tono de queja.
• nog eens / nog een keer = "una vez mas" (repeticion CONTADA o que se pide): Doe het nog eens = hazlo una vez mas. NO sirve aqui: no cuentas ni pides repeticiones, describes que el patron se repite. ✗ Hij zal wel nog een keer te laat zijn suena a "llegara tarde una vez mas" (contando), no a "otra vez, como siempre".
• opnieuw = de cero / desde el principio (rehacer algo entero). ✗ No aplica a "llegar tarde".
Regla: recurrencia / vuelta a lo de siempre → weer (o alweer si te quejas); "una vez mas" contada o pedida → nog eens / nog een keer; "desde cero" → opnieuw.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Hij zal wel weer te laat zijn.')
  AND COALESCE(rules_help,'') NOT LIKE '%🔄%';

-- 304 · Het zal wel weer aan mij liggen (Seguro que otra vez es culpa mia, ironico)
UPDATE words_es SET rules_help = rules_help || '

🔄 por que weer (y no nog eens / opnieuw):
weer = "otra vez" marcando la RECURRENCIA ("como siempre me toca a mi") — encaja con la ironia de "zal wel".
• weer → vuelve a repetirse el patron. Correcto y natural.
• alweer → sube la queja ("ya otra vez culpa mia"). INTERCAMBIABLE, mas enfatico.
• nog eens / nog een keer = "una vez mas" (repeticion contada/pedida) → ✗ no describe un patron que se repite, sino un conteo.
• opnieuw = desde cero → ✗ no encaja con "ser culpa mia".
Regla: recurrencia habitual → weer / alweer; "una vez mas" contada → nog eens; "de cero" → opnieuw.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Het zal wel weer aan mij liggen.')
  AND COALESCE(rules_help,'') NOT LIKE '%🔄%';

-- 682 · Ik hoop je snel weer te zien (espero volver a verte pronto)
UPDATE words_es SET rules_help = rules_help || '

🔄 weer vs opnieuw / nog eens / nog een keer:
Aqui weer = "volver a" (weer zien = volver a verse, reencontrarse). Es la forma natural de una despedida afectuosa.
• weer + zien = volver a ver(se), reunirse otra vez. Con ese matiz de reencuentro existen tambien elkaar terugzien y het weerzien (el reencuentro).
• opnieuw = de nuevo desde cero, como si nunca os hubierais visto → ✗ opnieuw zien no significa "reencontrarse", suena erroneo aqui.
• nog eens / nog een keer zien = "verte una vez mas" (contando una repeticion). Gramaticalmente posible, pero enfria el tono: parece que cuentas los encuentros en vez del calido "volver a verte". Para la despedida, weer.
Regla: "volver a (reunirse/repetir)" → weer; "una vez mas" contada → nog eens / nog een keer; "desde cero" → opnieuw.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Ik hoop je snel weer te zien.')
  AND COALESCE(rules_help,'') NOT LIKE '%🔄%';

-- 2) vergeten (perfecto vs presente) ----------------------------------------

-- 680 · Ik ben vergeten je terug te bellen (olvide devolverte la llamada)
UPDATE words_es SET rules_help = rules_help || '

⏰ Por que "Ik BEN vergeten..." y no "Ik vergeet..."?
Porque hablas de un olvido YA OCURRIDO (un hecho concreto del pasado = espanol "olvide"). En neerlandes eso va en PERFECTO, y vergeten en el sentido de "olvidar (hacer algo)" toma el auxiliar zijn: Ik ben vergeten je terug te bellen = olvide (ya me paso) devolverte la llamada.
• Ik ben vergeten... = perfecto → el olvido es un hecho consumado (te disculpas por algo que ya no hiciste). Equivale a "olvide / se me olvido".
• Ik vergeet... = presente → "olvido / me olvido" como habito o afirmacion general/en curso, NO un lapsus concreto ya pasado. Ik vergeet altijd je terug te bellen = siempre me olvido de devolverte la llamada (costumbre). Para disculparte por ESTA vez no sirve.
Regla: hecho puntual del pasado (olvide) → ben vergeten (perfecto con zijn); costumbre / verdad general (me olvido) → vergeet (presente).
Matiz del auxiliar: zijn cuando vergeten = olvidar hacer/dejar algo (ben ... vergeten); con hebben (heb ... vergeten) es mas "no recordar" un dato: Ik heb je naam vergeten = he olvidado tu nombre.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Ik ben vergeten je terug te bellen.')
  AND COALESCE(rules_help,'') NOT LIKE '%⏰%';

-- 3) verbo reflexivo --------------------------------------------------------

-- 324 · Ik vraag me af of hij zou komen (Me pregunto si vendria) — zich afvragen
UPDATE words_es SET rules_help = rules_help || '

🪞 Verbo reflexivo: zich afvragen = preguntarse (a uno mismo). El "me" de "Ik vraag me af" NO es objeto de otra persona, sino el pronombre REFLEXIVO obligatorio del verbo: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich.
Contraste: vragen (sin reflexivo) = preguntar A ALGUIEN (Ik vraag het aan hem); zich afvragen = preguntarSE, dudar por dentro. Quitar el reflexivo cambia el significado.
Ademas es SEPARABLE (af): en la oracion principal el prefijo af va al final → Ik vraag me af..., y la subordinada (of hij zou komen) cuelga detras.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Ik vraag me af of hij zou komen.')
  AND COALESCE(rules_help,'') NOT LIKE '%🪞%';

-- 4) komen vs aankomen vs zijn te laat -------------------------------------

-- 670 · Schiet op, we komen te laat! (date prisa, que llegamos tarde)
UPDATE words_es SET rules_help = rules_help || '

🛬 komen vs aankomen vs "we zijn te laat":
• Aqui el verbo es komen (venir/presentarse), NO aankomen. "te laat komen" es la EXPRESION FIJA de llegar tarde (a una cita, el tren, la clase, el trabajo): We komen te laat = vamos a llegar tarde. Por eso NO lleva "aan".
• aankomen = llegar A UN DESTINO, con foco en el punto o la hora de arribo: De trein komt om 8 uur aan (el tren llega a las 8), We zijn om drie uur aangekomen (llegamos a las tres). Se usa cuando marcas/enfatizas el sitio o el momento exacto de llegar. "We komen te laat aan" es posible (llegar tarde AL destino, tipico de un tren/vuelo), pero para "vamos a llegar tarde" el neerlandes dice "we komen te laat" a secas.
• Se podria decir "Schiet op, we zijn te laat"? Si, correcto y muy usado, pero cambia el matiz temporal: we komen te laat = vamos a llegar tarde (aun de camino, proyeccion a futuro con presente); we zijn te laat = ya vamos/estamos tarde (estado actual, la hora ya paso). komen mira la llegada; zijn constata el retraso ahora. Ambas sirven para meter prisa.
Regla: llegar tarde a algo (en general) → te laat komen; enfatizar el destino/hora de arribo → aankomen; constatar que ya es tarde → we zijn te laat.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Schiet op, we komen te laat!')
  AND COALESCE(rules_help,'') NOT LIKE '%🛬%';
