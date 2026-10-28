-- Learn Languages App - Conjugacion completa de verbergen en tabla (pedida en la 781)
-- Migration: 20260831000010-help-conjugatie-verbergen.sql
-- Description: Eduardo, en la 781: «dame la conjugacion en una tabla, o lista, presente, pasado
--   y participio». La 781 tenia el mapa de los nueve verbos de esconder y el reparto entre
--   verstoppen / verbergen / verzwijgen, pero la conjugacion solo en linea («verbergen - verborg
--   - heeft verborgen»), sin desglosar por persona. Se anade el bloque 📊 IDENTICO byte a byte en
--   las TRES tarjetas del verbo (781 la palabra, 825 «Hij verbergt zijn gevoelens voor iedereen»
--   y 826 «Het kind verborg zich achter de bank»): tabla de presente e imperfecto por persona,
--   participio con su auxiliar, te + infinitivo, imperativo y condicional; los dos avisos que
--   evitan la mitad de los fallos (jij pierde la -t en la inversion, «Verberg je iets?»; y el
--   imperfecto plural «wij verborgen» es la MISMA palabra que el participio «verborgen», se
--   distinguen por el auxiliar y por el sitio); la serie reflexiva completa de zich verbergen,
--   donde el pronombre cambia con la persona y no siempre es zich (ik verberg ME, jij verbergt
--   JE); y el origen, ver- + bergen (bergen - borg - geborgen = poner a salvo), que da de berging
--   (el trastero), de bergplaats y el adjetivo geborgen, zich geborgen voelen.
--   100% aditiva e idempotente: UPDATE con guard por marca.

UPDATE words_es
SET rules_help = rules_help || '

📊 Conjugacion completa de verbergen
Es verbo fuerte, o sea que el pasado no se hace con -te ni -de sino cambiando la vocal: verbergen - verborg - verborgen.

| persona | presente | imperfecto |
|---|---|---|
| ik | verberg | verborg |
| jij / je | verbergt | verborg |
| u | verbergt | verborg |
| hij / zij / het | verbergt | verborg |
| wij | verbergen | verborgen |
| jullie | verbergen | verborgen |
| zij (plural) | verbergen | verborgen |

• participio = verborgen, y el auxiliar es hebben. Hij heeft het verborgen.
• infinitivo con te = te verbergen. Ik heb niets te verbergen.
• imperativo = Verberg dat! y en formal Verbergt u dat maar.
• condicional = zou verbergen. Ik zou dat nooit verbergen.

⚠️ Dos avisos que evitan la mitad de los errores con este verbo:
• En la inversion, jij pierde la -t: Verberg je iets voor mij? — no «verbergt je».
• El imperfecto plural (wij verborgen) y el participio (verborgen) son la MISMA palabra. Se distinguen por el sitio y por el auxiliar: We verborgen de cadeaus (imperfecto, sin auxiliar) frente a We hebben de cadeaus verborgen (perfecto, con hebben y al final).

🪞 Y en reflexivo, zich verbergen (esconderse), el pronombre cambia con la persona y no siempre es zich: ik verberg me · jij verbergt je · hij, zij, het en u verbergt zich · wij verbergen ons · jullie verbergen je · zij verbergen zich.

🌱 De donde sale: verbergen es ver- + bergen, y bergen (bergen - borg - geborgen) es poner a salvo, guardar. De ahi de berging (el trastero), de bergplaats (el almacen) y el adjetivo geborgen, que es sentirse a salvo y arropado: zich geborgen voelen.',
    updated_at = datetime('now')
WHERE id IN (781, 825, 826)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%📊 Conjugacion completa de verbergen%';
