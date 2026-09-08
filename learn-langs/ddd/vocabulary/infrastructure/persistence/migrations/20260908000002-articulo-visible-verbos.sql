-- Learn Languages App - Migration
-- Migration: 20260908000002-articulo-visible-verbos
-- Description: Eduardo, sobre la ayuda del grupo 40 ya mejorada: "si esta bien, pero que
--   en algunas se vea el articulo o se use een o ene".
--
--   Revisadas las veinte frases del sustantivo, quince ya enseñan el articulo o el een
--   (Ik heb EEN vraag, HET leven is duur, DE drank is inbegrepen, HET was EEN lange rit).
--   Cinco no lo enseñaban porque van con posesivo o sin determinante: de hulp (Bedankt
--   voor JE hulp), de slaap (Ik heb slaap), de reis (Goede reis!), het werk (Ik ga naar
--   MIJN werk) y de komst (We wachten op ZIJN komst). Sus frases de tarjeta no se tocan,
--   porque son las correctas y ademas cambiarlas desincronizaria el audio; lo que se hace
--   es añadir en la ayuda una frase mas con el articulo a la vista.
--
--   Y se añade al bloque compartido una seccion que Eduardo no pidio pero que resuelve el
--   mismo problema de raiz: EL ADJETIVO DELATA EL ARTICULO. Con een, el adjetivo va sin -e
--   si la palabra es het (een goed gesprek, een vriendelijk gezicht) y con -e si es de
--   (een lange rit, een goede vraag). Los ejemplos salen de sus propias tarjetas, donde ya
--   estaba pasando sin que nadie lo señalara.
--
--   La 20260907000014 y la 20260908000001 ya estan aplicadas, asi que van con REPLACE del
--   texto exacto, que ademas hace la migracion idempotente sola.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. Las cinco frases sin articulo: se les añade otra que si lo enseña
--    El REPLACE alcanza las dos tarjetas del par, porque el fragmento es comun
-- =============================================================================
UPDATE words_es SET rules_help = REPLACE(rules_help,
    'Ik heb je hulp nodig. (necesito tu ayuda)',
    'Ik heb je hulp nodig. (necesito tu ayuda). Y con el articulo a la vista: De hulp is onderweg. (la ayuda esta en camino)')
WHERE rules_help LIKE '%Ik heb je hulp nodig. (necesito tu ayuda)%'
  AND rules_help NOT LIKE '%De hulp is onderweg%';

UPDATE words_es SET rules_help = REPLACE(rules_help,
    'Ik val bijna in slaap. (casi me quedo dormido)',
    'Ik val bijna in slaap. (casi me quedo dormido). Y con el articulo a la vista: Een goede slaap is belangrijk. (dormir bien es importante), donde la -e de goede ya te dice que slaap es palabra de')
WHERE rules_help LIKE '%Ik val bijna in slaap. (casi me quedo dormido)%'
  AND rules_help NOT LIKE '%Een goede slaap is belangrijk%';

UPDATE words_es SET rules_help = REPLACE(rules_help,
    'Hoe was je reis? (¿qué tal el viaje?)',
    'Hoe was je reis? (¿qué tal el viaje?). Y con el articulo a la vista: De reis duurde drie uur. (el viaje duro tres horas)')
WHERE rules_help LIKE '%Hoe was je reis? (¿qué tal el viaje?)%'
  AND rules_help NOT LIKE '%De reis duurde drie uur%';

UPDATE words_es SET rules_help = REPLACE(rules_help,
    'Ik ben op mijn werk. (estoy en el trabajo)',
    'Ik ben op mijn werk. (estoy en el trabajo). Y con el articulo a la vista: Het werk is af. (el trabajo esta terminado)')
WHERE rules_help LIKE '%Ik ben op mijn werk. (estoy en el trabajo)%'
  AND rules_help NOT LIKE '%Het werk is af%';

UPDATE words_es SET rules_help = REPLACE(rules_help,
    'De toekomst ziet er goed uit. (el futuro pinta bien)',
    'De toekomst ziet er goed uit. (el futuro pinta bien). Y con el articulo del propio komst a la vista: De komst van de trein is vertraagd. (la llegada del tren se ha retrasado)')
-- Guard especifico a proposito: la tarjeta de "de komst" ya cita "de komst van de trein"
-- como colocacion, y LIKE es insensible a mayusculas, asi que un guard mas corto la
-- excluiria de su propia correccion.
WHERE rules_help LIKE '%De toekomst ziet er goed uit. (el futuro pinta bien)%'
  AND rules_help NOT LIKE '%De komst van de trein is vertraagd%';

-- =============================================================================
-- 2. El adjetivo delata el articulo: seccion nueva al final del bloque comun
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🔍 El adjetivo delata el articulo:

Cuando el sustantivo va con een y un adjetivo delante, la -e del adjetivo te dice el genero sin que tengas que acordarte de nada.

| lo que oyes | que significa | ejemplo de este grupo |
|---|---|---|
| een + adjetivo **sin -e** | la palabra es **het** | een **goed** gesprek, een **vriendelijk** gezicht |
| een + adjetivo **con -e** | la palabra es **de** | een **lange** rit, een **goede** vraag |

⚠️ La pista solo funciona con een. Con de o het delante, el adjetivo lleva -e siempre, sea del genero que sea: het goede gesprek, de lange rit. Y sin articulo tampoco sirve: goede reis.

🔑 El truco: Si oyes een goed…, es het-woord. Si oyes een goede…, es de-woord. Es la manera mas rapida de deducir el articulo cuando no te acuerdas, y funciona al reves tambien: si sabes el articulo, ya sabes si poner la -e.

📐 Y en plural desaparece el problema: todos los plurales son de, y el adjetivo siempre lleva -e. de goede gesprekken, de lange ritten.'
WHERE notes LIKE 'Verbo frecuente: %'
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🔍 El adjetivo delata el articulo%';
