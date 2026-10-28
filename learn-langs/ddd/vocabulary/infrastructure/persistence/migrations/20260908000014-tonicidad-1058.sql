-- Learn Languages App - Migration
-- Migration: 20260908000014-tonicidad-1058
-- Description: Eduardo, sobre la 1058 (Kom je ook? = ¿vienes tu tambien?): "indica atona o
--   tonica sino no se como hacer el examen, repasa esto en todo lo nuevo de ayer y hoy que
--   has creado".
--
--   Tiene razon: el español «¿vienes TU tambien?» lleva el pronombre marcado, y eso induce
--   a teclear Kom JIJ ook?, que es la forma tonica. La tarjeta espera je, la atona. Sin la
--   marca la tarjeta no es resoluble, que es la regla de oro del mazo.
--   La convencion ya existia y el mazo la usa en 21 tarjetas: «Estara en el atasco (ella,
--   atona)», «han robado (ellos, atona)». Yo no la aplique al crear los grupos 35 a 41.
--
--   AUDITORIA COMPLETA de lo creado ayer y hoy, como pide Eduardo: de las 39 tarjetas mias
--   que llevan pronombre SUJETO con par atono/tonico (je/jij, ze/zij, we/wij), 38 estan
--   bien y solo falla esta. En las demas el español NO lleva pronombre explicito
--   («¿de donde vienes?», «comemos a las seis», «¿hablas neerlandes?»), que es justo lo que
--   corresponde a la forma atona; y la 1017 («ella tiene la misma edad que yo» = Zij is
--   even oud als ik) usa la tonica con su «ella» delante, que es coherente.
--   Revisados tambien los pronombres de OBJETO: ninguna de mis tarjetas usa mij ni jou, asi
--   que no hay desajuste por ese lado.
--
--   ⚠️ AUDIO: cambia words_es.text, y la cache va por id. La 1058 ya tenia mp3 en español,
--   asi que word-1058-es-es-castellano.mp3 se borra a mano fuera de esta migracion para que
--   se regenere. El mp3 NEERLANDES no se toca porque la traduccion no cambia. No esta en
--   el CDN (0 filas en word_es_media).

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. La marca que faltaba
-- =============================================================================
UPDATE words_es SET text = '¿vienes tú también? (átona)'
WHERE id = 1058 AND text = '¿vienes tú también?';

-- =============================================================================
-- 2. Y la explicacion, porque la eleccion atona/tonica tiene regla
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: ¿Como se si va je o jij?

🔑 Por eso lleva la marca (atona). El español «¿vienes TU tambien?» pone el pronombre porque sin el la frase queda coja, pero eso NO significa que haya enfasis. En neerlandes el enfasis si cambia la palabra, y por eso hay que decirlo: aqui toca je, la forma atona.

| forma | cuando | ejemplo |
|---|---|---|
| **je** (átona) | lo normal, sin énfasis | **Kom je** ook? (¿vienes también?) |
| **jij** (tónica) | contrastando o señalando | **Kom jij** ook? (¿vienes TÚ también, y no otro?) |

📊 Los pares completos, que es lo que hay que tener a mano:

| átona | tónica | persona |
|---|---|---|
| je | **jij** | tú, sujeto |
| je | **jou** | te, ti, objeto |
| ze | **zij** | ella, ellos |
| we | **wij** | nosotros |
| me | **mij** | me, mí |
| ’m | **hem** | lo, le |
| ’r | **haar** | la, le |

🔑 El truco para elegir: Pregunta si en español pondrias el pronombre CON ENFASIS de verdad, del tipo «¿vienes TÚ, que los demas ya han dicho que no?». Si es asi, tonica. Si el pronombre esta solo porque la frase lo pide, atona. En la duda, atona: es la de todos los dias.

⚠️ Y una regla que ayuda: la tonica es obligatoria en las comparaciones y detras de preposicion. Zij is even oud als IK, Dat is voor MIJ, Met JOU. Ahi nunca va la atona.

🗣️ En el habla rapida las atonas se reducen aun mas: je suena a «ju» corto, ze a «zu», y hem y haar se comen la consonante y quedan en ’m y ’r — Ik zie ’m morgen. Eso esta en el grupo 19 y en el de pronunciacion.

🏋️ Ejercicio: «¿y tu que harias?» con enfasis de verdad → Wat zou ___ doen? (Respuesta: jij, tonica, porque contrastas con los demas.)'
WHERE id = 1058
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';
