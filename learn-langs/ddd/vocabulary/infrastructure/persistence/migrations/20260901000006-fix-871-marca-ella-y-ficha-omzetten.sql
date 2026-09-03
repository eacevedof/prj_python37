-- Learn Languages App - la 871: marca (ella) + conjugacion de omzetten y sus casuisticas
-- Migration: 20260901000006-fix-871-marca-ella-y-ficha-omzetten.sql
-- Description: Eduardo, dos peticiones sobre la 871 (Ze heeft het idee omgezet in een concreet
--   plan): (1) marca (ella) porque «Ha convertido» vale para el/ella/usted y sin la marca la
--   tarjeta no es resoluble (norma 3.2); (2) «agrega la conjugacion de omzetten y sus
--   casuisticas». La 871 estaba SIN ayuda y se crea entera: regla de la frase (ge- DENTRO del
--   separable + preposicion fija in), el bloque 📐 de conjugacion COPIADO BYTE A BYTE de la
--   WORD 869 (norma 3.3) y un bloque 🚦 nuevo con las cuatro posiciones del separable
--   (norma 2.7: principal/perfecto/subordinada/te) mas la extraposicion del complemento
--   preposicional (omgezet in een concreet plan = in een concreet plan omgezet). Ese bloque
--   🚦 se inyecta tambien en la 869, que tenia ficha pero incumplia la 2.7 (sin las
--   cuatro posiciones). Sin audio que regenerar (word_es_media vacio para la 871).
--   Idempotente: texto viejo exacto en el WHERE del rename, rules_help IS NULL para la creacion
--   y guard 🚦 + IS NOT NULL para el append a la 869.

PRAGMA foreign_keys = ON;

-- 1. La marca (ella)
UPDATE words_es
SET text = 'Ha convertido la idea en un plan concreto. (ella)'
WHERE id = 871 AND text = 'Ha convertido la idea en un plan concreto.';

-- 2. La ayuda de la 871, entera (estaba a NULL: se crea, no se concatena)
UPDATE words_es
SET rules_help = 'Perfecto de un separable: el ge- se cuela DENTRO — om-ge-zet, heeft omgezet. Y el «en» de convertir EN es su preposicion fija: omzetten in. La marca (ella) esta porque «Ha convertido» vale para el/ella/usted y la respuesta pide Ze.

📐 Conjugacion de omzetten (debil y separable: om + zetten):

| persona | presente | imperfecto |
|---|---|---|
| ik | zet om | zette om |
| jij / je | zet om | zette om |
| u | zet om | zette om |
| hij / zij / het | zet om | zette om |
| wij | zetten om | zetten om |
| jullie | zetten om | zetten om |
| zij (plural) | zetten om | zetten om |

• participio — omgezet, con hebben y el ge- DENTRO (om-ge-zet): Ik heb de graden omgezet naar Fahrenheit.
• ojo — la raiz ya acaba en -t (zet), asi que jij/hij NO anaden otra: hij zet om, nunca «zett om».
• y otro ojo — el presente plural (wij zetten om) y el imperfecto plural (wij zetten om) son IGUALES: lo decide el contexto o un marcador de tiempo (vroeger zetten we…).
• preposicion — omzetten IN o NAAR (convertir en/a): euro''s omzetten in dollars, een bestand omzetten naar pdf.

🚦 Las cuatro posiciones del separable, con omzetten:

| donde | que pasa | ejemplo |
|---|---|---|
| principal | la particula se va al final | Ik zet het bestand om. |
| perfecto | el ge- se cuela DENTRO | Ze heeft het idee omgezet. |
| subordinada | las piezas se reunen y se escriben juntas | … omdat ze het idee omzet. |
| con te | el te va en medio | Ze probeert het idee om te zetten. |

• y el complemento con preposicion fija puede extraponerse detras del participio: Ze heeft het idee omgezet in een concreet plan = Ze heeft het idee in een concreet plan omgezet. Las dos valen; la primera deja el resultado como foco.'
WHERE id = 871 AND rules_help IS NULL;

-- 3. Las cuatro posiciones tambien en la WORD 869 (le faltaban)
UPDATE words_es
SET rules_help = rules_help || '

🚦 Las cuatro posiciones del separable, con omzetten:

| donde | que pasa | ejemplo |
|---|---|---|
| principal | la particula se va al final | Ik zet het bestand om. |
| perfecto | el ge- se cuela DENTRO | Ze heeft het idee omgezet. |
| subordinada | las piezas se reunen y se escriben juntas | … omdat ze het idee omzet. |
| con te | el te va en medio | Ze probeert het idee om te zetten. |

• y el complemento con preposicion fija puede extraponerse detras del participio: Ze heeft het idee omgezet in een concreet plan = Ze heeft het idee in een concreet plan omgezet. Las dos valen; la primera deja el resultado como foco.'
WHERE id = 869 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🚦%';
