-- Learn Languages App - Conjugacion y otros contextos de toewijzen en la ayuda de la tarjeta 834
-- Migration: 20260826000004-help-toewijzen-conjugation-examples-834.sql
-- Description: La tarjeta 834 ("En esta funcion asigno un valor a la variable x.") es el
--   ejemplo de programacion de toewijzen (775). Se anade a su rules_help la conjugacion de
--   toewijzen (verbo fuerte: wijst-wees-gewezen, separable toe-) y ejemplos en otros contextos
--   (asiento, presupuesto, tarea, vivienda) para que quede claro que no es solo de codigo.
--   100% aditiva e idempotente: solo UPDATE con guard (rules_help IS NULL).

UPDATE words_es
SET rules_help = 'toewijzen = toe + wijzen. wijzen es fuerte: cambia ij → ee en pasado, no anade -te/-de.

📐 Conjugacion de toewijzen:
• presente — ik wijs toe · jij/hij wijst toe · wij/jullie/zij wijzen toe
• pasado (imperfecto) — ik/jij/hij wees toe · wij/jullie/zij wezen toe
• participio — toegewezen (heeft toegewezen)

🗺️ toewijzen fuera del codigo: sirve para asignar/repartir/adjudicar CUALQUIER cosa concreta a alguien, no solo variables:
• [asiento] De steward wijst je een stoel toe. — El auxiliar te asigna un asiento.
• [presupuesto] De gemeente heeft een budget toegewezen aan het project. — El ayuntamiento ha asignado un presupuesto al proyecto.
• [tarea] De manager wees hem die taak toe. — El jefe le asigno esa tarea.
• [vivienda] Ze hebben haar eindelijk een huis toegewezen. — Por fin le han asignado una vivienda.

📌 En todos los casos hay alguien (o algo, un sistema) que REPARTE una cosa concreta a un destinatario concreto — variable, asiento, presupuesto, tarea o vivienda, da igual: la estructura es siempre [repartidor] wijst [cosa] toe aan [destinatario].',
    updated_at = datetime('now')
WHERE id = 834
  AND rules_help IS NULL;
