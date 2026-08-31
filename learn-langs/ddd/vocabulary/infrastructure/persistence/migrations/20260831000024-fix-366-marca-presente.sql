-- Learn Languages App - La marca «(presente)» en la 366, caso espejo de la 865
-- Migration: 20260831000024-fix-366-marca-presente.sql
-- Description: Eduardo: «si, ponle (presente) a la 366». Es el caso espejo del que se arreglo en
--   la 865 con la migracion 20260831000022: «Venimos los dos» tiene la misma forma en presente y
--   en indefinido, y aqui nada en la frase resuelve el tiempo — el neerlandes pide PRESENTE
--   (We komen allebei) pero cualquiera podria responder un perfecto (We zijn allebei gekomen).
--   Se marca al final entre parentesis, misma convencion que la 865 y que las tarjetas que
--   desambiguan la persona o el tono («… hasta el final. (ella)»).
--   Con esto, la norma queda cerrada por los dos lados: (pasado) y (presente).
--   Del barrido de formas ambiguas (-amos / -imos) quedan dos casos de frontera que NO se marcan
--   porque el contexto ya inclina la balanza: la 401 («Salimos a cenar alguna que otra vez»,
--   habito) y la 519 («Salimos pronto, asi evitamos el atasco», plan).
--   100% aditiva e idempotente: UPDATE con guard por el texto exacto.

UPDATE words_es
SET text = 'Venimos los dos. (presente)',
    updated_at = datetime('now')
WHERE id = 366
  AND text = 'Venimos los dos.';
