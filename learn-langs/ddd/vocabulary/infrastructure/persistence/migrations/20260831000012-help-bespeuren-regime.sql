-- Learn Languages App - El regimen de bespeuren: bij con personas, in con cosas
-- Migration: 20260831000012-help-bespeuren-regime.sql
-- Description: Eduardo: «en bespeuren, si puedes agregar la preposicion bij, percibir EN». La
--   ayuda de la 782 tenia el mapa del notar/percibir/observar y cinco ejemplos, pero no decia el
--   regimen, que es justo lo que hace falta para poder construir la frase. Y bespeuren no rige UNA
--   preposicion fija sino que elige segun DONDE percibes la cosa: bij con personas (bij hem, bij
--   haar), in con cosas, voces o textos (in zijn stem), van cuando lo buscado va en cabeza (Van
--   enthousiasme was weinig te bespeuren) y sin preposicion ninguna cuando el objeto es directo y
--   no se dice el sitio (De hond bespeurt gevaar).
--   Bloque 🧭 IDENTICO byte a byte con esa tabla, la construccion «er is/was geen … te bespeuren»
--   (la que mas se oye, equivalente a una pasiva), el aviso del transitivo pelado, la familia con
--   su registro y su regimen (merken · opmerken · waarnemen · signaleren · speuren NAAR) con los
--   sustantivos y su articulo (het spoor, de speurhond, de waarneming, het vermoeden) y los
--   antonimos (over het hoofd zien, missen, negeren).
--   Va a las 3 tarjetas del verbo: 782 (append) y 827 y 828 (que no tenian ayuda y se crean
--   enteras). La 828 explica ademas por que lleva enige y no geen — ver 20260831000011.
--   100% aditiva e idempotente (guard por marca y por rules_help IS NULL).

-- ==============================================================================
-- 1. Tarjetas que ya tienen ayuda: el bloque se anade al final
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🧭 El regimen de bespeuren, que cambia segun donde percibas la cosa
bespeuren = percibir un indicio de algo. No rige UNA preposicion fija, sino que elige segun EN QUE lo percibes, y ahi esta la gracia:

| donde lo percibes | rige | ejemplo |
|---|---|---|
| en una PERSONA | **bij** | Ze heeft nooit enige spijt **bij hem** bespeurd. |
| en una cosa, una voz, un texto | **in** | Ik bespeurde twijfel **in zijn stem**. |
| lo buscado, puesto en cabeza | **van** … te bespeuren | **Van** enthousiasme was weinig te bespeuren. |
| sin decir donde, con er | er was geen … **te bespeuren** | Er was geen enkele beweging te bespeuren. |

📌 La construccion te bespeuren es la que mas se oye, y conviene aprenderla entera: er is o er was + (geen) + sustantivo + te bespeuren = se percibe, o no se percibe ni rastro. Equivale a una pasiva y sirve para no decir quien percibe.

⚠️ Cuando el objeto va directo y no dices donde lo percibes, no hay preposicion ninguna: De hond bespeurt gevaar. Es transitivo pelado, y el bij o el in solo entran si anades el sitio.

🗺️ La familia, cada uno con su registro y su regimen: merken (notar, el normal del habla, sin preposicion) · opmerken (advertir, fijarse, y tambien comentar, sin preposicion) · waarnemen (observar, tecnico) · signaleren (detectar, formal) · speuren NAAR (rastrear en busca de algo). Los sustantivos, con su articulo: het spoor (el rastro), de speurhond (el perro rastreador), de waarneming (la observacion), het vermoeden (la sospecha).

↔️ Antonimos: over het hoofd zien (pasar por alto), missen (no captar) y negeren (ignorar a proposito).',
    updated_at = datetime('now')
WHERE id IN (782, 828)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧭 El regimen de bespeuren%';

-- ==============================================================================
-- 2. Tarjeta 827: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'De hond bespeurt gevaar eerder dan wij. Aqui bespeuren va SIN preposicion: el objeto (gevaar) es directo y no se dice donde se percibe el peligro. La preposicion solo aparece si anades el sitio, y entonces es bij con personas o in con cosas.

📌 El comparativo de la frase es eerder dan, literalmente «antes que». eerder es el comparativo de vroeg (temprano) y tambien significa «mas bien». Los sustantivos, con su articulo: de hond (el perro), het gevaar (el peligro), de speurhond (el perro rastreador, de la misma familia que bespeuren).

🧭 El regimen de bespeuren, que cambia segun donde percibas la cosa
bespeuren = percibir un indicio de algo. No rige UNA preposicion fija, sino que elige segun EN QUE lo percibes, y ahi esta la gracia:

| donde lo percibes | rige | ejemplo |
|---|---|---|
| en una PERSONA | **bij** | Ze heeft nooit enige spijt **bij hem** bespeurd. |
| en una cosa, una voz, un texto | **in** | Ik bespeurde twijfel **in zijn stem**. |
| lo buscado, puesto en cabeza | **van** … te bespeuren | **Van** enthousiasme was weinig te bespeuren. |
| sin decir donde, con er | er was geen … **te bespeuren** | Er was geen enkele beweging te bespeuren. |

📌 La construccion te bespeuren es la que mas se oye, y conviene aprenderla entera: er is o er was + (geen) + sustantivo + te bespeuren = se percibe, o no se percibe ni rastro. Equivale a una pasiva y sirve para no decir quien percibe.

⚠️ Cuando el objeto va directo y no dices donde lo percibes, no hay preposicion ninguna: De hond bespeurt gevaar. Es transitivo pelado, y el bij o el in solo entran si anades el sitio.

🗺️ La familia, cada uno con su registro y su regimen: merken (notar, el normal del habla, sin preposicion) · opmerken (advertir, fijarse, y tambien comentar, sin preposicion) · waarnemen (observar, tecnico) · signaleren (detectar, formal) · speuren NAAR (rastrear en busca de algo). Los sustantivos, con su articulo: het spoor (el rastro), de speurhond (el perro rastreador), de waarneming (la observacion), het vermoeden (la sospecha).

↔️ Antonimos: over het hoofd zien (pasar por alto), missen (no captar) y negeren (ignorar a proposito).',
    updated_at = datetime('now')
WHERE id = 827
  AND rules_help IS NULL;
