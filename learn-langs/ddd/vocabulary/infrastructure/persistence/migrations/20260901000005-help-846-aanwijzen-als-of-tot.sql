-- Learn Languages App - la 846: ¿puede aanwijzen ir sin als? (Hij is teamleider aangewezen ✗)
-- Migration: 20260901000005-help-846-aanwijzen-als-of-tot.sql
-- Description: Eduardo sobre la 846 (Hij is aangewezen als teamleider): «¿aanwijzen siempre va
--   con als? ¿no podria ser Hij is teamleider aangewezen?». No: el espanol borra el enlace («lo
--   nombraron jefe»), el neerlandes no. El cargo necesita su palabra-puente y cual es depende del
--   verbo: aanwijzen/aanstellen ALS, benoemen/verkiezen TOT, y solo los copulativos
--   (zijn/worden/blijven) llevan el cargo pelado (Hij is teamleider geworden). Se añade a la 846
--   un bloque 🎖️ con la tabla de puentes, el matiz de registro entre los tres verbos de nombrar
--   y la nota de orden: als teamleider aangewezen (neutro) y aangewezen als teamleider
--   (extrapuesto, foco en el cargo) valen las dos — el grupo de als se comporta como los
--   preposicionales. Idempotente: guard por la marca 🎖️ acotado a la tarjeta + IS NOT NULL.

PRAGMA foreign_keys = ON;

UPDATE words_es
SET rules_help = rules_help || '

🎖️ ¿Y sin als? — «Hij is teamleider aangewezen» ✗:

No. El espanol borra el enlace (lo nombraron jefe), el neerlandes no: el cargo necesita su palabra-puente, y cual es depende del verbo de nombrar.

| verbo | puente | ejemplo |
|---|---|---|
| aanwijzen / aanstellen | als | Hij is aangewezen **als** teamleider. |
| benoemen / verkiezen | tot | Hij is benoemd **tot** teamleider. · Ze werd verkozen **tot** voorzitter. |
| zijn / worden / blijven | pelado | Hij is teamleider. · Hij werd teamleider. |

• el unico camino sin puente es el copulativo: Hij is teamleider geworden. — Se ha hecho jefe de equipo.
• matiz de registro — benoemen tot es el nombramiento formal (cargos oficiales), aanwijzen als es designar (eleccion practica: alguien tenia que serlo), aanstellen als es contratar para el puesto.
• el orden — Hij is als teamleider aangewezen (neutro) y Hij is aangewezen als teamleider (foco en el cargo) valen las dos: el grupo de als se extrapone igual que los preposicionales.'
WHERE id = 846 AND text = 'Ha sido nombrado jefe de equipo.'
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🎖️%';
