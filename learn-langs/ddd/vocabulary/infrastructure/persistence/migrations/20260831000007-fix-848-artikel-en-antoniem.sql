-- Learn Languages App - Articulo del sustantivo y antonimos en la ayuda de la 848
-- Migration: 20260831000007-fix-848-artikel-en-antoniem.sql
-- Description: Eduardo, mirando la 848 (afwijzen): «si una palabra tiene antonimo agregalo en la
--   ayuda, y todo sustantivo siempre con su articulo de/het, nunca solo». La 848 citaba el
--   sustantivo como «afwijzing» a pelo — sin articulo no se sabe el genero, y el genero es lo que
--   decide articulo, adjetivo (het verkeerde document vs een verkeerd document), relativo
--   (die/dat) y demostrativo, asi que un sustantivo sin articulo es vocabulario a medio aprender.
--   Se corrige a «de afwijzing» y se anade el bloque de antonimos de la familia de wijzen, que la
--   ayuda no tenia: afwijzen se aprende mucho mejor contra aannemen / goedkeuren / toekennen que
--   con una definicion.
--   Las dos normas quedan como convencion para toda ayuda futura, no solo para esta tarjeta.
--   100% aditiva e idempotente: REPLACE con guard + append con marca.

UPDATE words_es
SET rules_help = REPLACE(rules_help, 'El sustantivo es afwijzing', 'El sustantivo es de afwijzing'),
    updated_at = datetime('now')
WHERE id = 848
  AND rules_help LIKE '%El sustantivo es afwijzing%';

UPDATE words_es
SET rules_help = rules_help || '

↔️ Los antonimos de la familia, que es como se fijan de verdad:
• afwijzen ↔ aannemen (aceptar una propuesta o a una persona), goedkeuren (aprobar), toekennen (conceder lo que se pedia). Ze wees het verzoek af. ↔ Ze keurde het verzoek goed.
• het verzoek werd afgewezen ↔ het verzoek werd toegekend. Los sustantivos, con su articulo: de afwijzing (la denegacion) ↔ de goedkeuring (la aprobacion) y de toekenning (la concesion).
• uitwijzen en su sentido legal (expulsar del pais) ↔ toelaten (dejar entrar, admitir). Los sustantivos: de uitwijzing ↔ de toelating.
• aanwijzen (designar) ↔ ontslaan (destituir, despedir). Los sustantivos: de aanwijzing (la indicacion, la designacion) ↔ het ontslag (el despido).

📌 Y de paso, los sustantivos de la familia con su articulo, que sin genero no sirven de nada: de wijzer (la aguja del reloj, el indicador) · de verwijzing (la referencia, la remision) · de wijziging (la modificacion, del otro verbo, wijzigen).',
    updated_at = datetime('now')
WHERE id = 848
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%↔️ Los antonimos de la familia%';
