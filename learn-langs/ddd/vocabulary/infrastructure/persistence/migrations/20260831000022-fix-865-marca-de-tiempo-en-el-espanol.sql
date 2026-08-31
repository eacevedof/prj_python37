-- Learn Languages App - La marca «(pasado)» cuando el espanol no distingue el tiempo (865)
-- Migration: 20260831000022-fix-865-marca-de-tiempo-en-el-espanol.sql
-- Description: Eduardo: «hay frases que no se distinguen en pasado o presente, ejemplo 865; en
--   estos casos usa el parentesis al final del espanol (pasado)». La 865 dice «Cambiamos de sitio
--   durante el descanso» y en espanol «cambiamos» es la MISMA forma en presente y en indefinido,
--   asi que la tarjeta pedia un pasado (We hebben van plaats gewisseld) sin que hubiera forma de
--   saberlo: cualquiera responderia «We wisselen van plaats». Se anade la marca al final, con la
--   misma convencion de parentesis que ya usan las tarjetas para desambiguar la persona o el tono
--   («… hasta el final. (ella)», «¿Podria preguntarle algo? (formal, con "u")»).
--   Norma que queda para las tarjetas nuevas: si el espanol no deja ver el tiempo, se marca al
--   final entre parentesis — (pasado) o (presente).
--   Barrido hecho sobre las 700 frases del mazo buscando las formas espanolas ambiguas (-amos,
--   -imos, que son las unicas que coinciden en presente e indefinido): la 865 es la unica que
--   pide pasado sin marcarlo. La 841 («Fundamos la asociacion el ano pasado») tambien es ambigua
--   de forma, pero el «el ano pasado» ya la resuelve, y la 366 («Venimos los dos») es el caso
--   espejo — ambigua con neerlandes en PRESENTE — y queda pendiente de decidir si se marca.
--   100% aditiva e idempotente: UPDATE con guard por el texto exacto.

UPDATE words_es
SET text = 'Cambiamos de sitio durante el descanso. (pasado)',
    updated_at = datetime('now')
WHERE id = 865
  AND text = 'Cambiamos de sitio durante el descanso.';
