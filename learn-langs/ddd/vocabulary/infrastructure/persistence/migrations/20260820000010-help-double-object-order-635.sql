-- Learn Languages App - Ayuda 635: el orden de los dos objetos (het hem, no hem het)
-- Migration: 20260820000010-help-double-object-order-635.sql
-- Description: Eduardo pregunta por que no vale «Ik heb hem het gegeven». Porque HET es el
--   pronombre mas ligero del neerlandes y no puede ir detras de otro pronombre objeto: con
--   dos pronombres el DIRECTO va primero (Ik heb het hem gegeven). El detalle bonito es que
--   el problema no es el orden sino la palabra: cambia het por el demostrativo dat y la
--   misma frase se arregla (Ik heb hem dat gegeven), porque dat si se puede acentuar.
--   Bloque 🎁 con una tabla de que si vale y que no, otra tabla con el orden de los dos
--   objetos segun sean pronombre o sustantivo, la regla de bolsillo (cuanto mas ligera la
--   palabra, mas a la izquierda), y los dos corolarios: het tampoco encabeza la frase
--   («Het heb ik hem gegeven» ✗ → Dat heb ik hem gegeven) ni va al final en imperativo
--   («Geef me het» ✗ → Geef het me / Geef het aan mij).
--   Aprovecha las TABLAS que habilita el cambio del formatter del mismo dia.
--   El bloque entra ANTES del cierre 📐. Solo UPDATE de rules_help.
--   IDEMPOTENTE por emoji-guarda (NOT LIKE '%🎁%').
--   Escrita fuera de migrations/ y movida ya terminada (leccion del 2026-08-20).

UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '📐 Oración principal (hoofdzin)',
    '🎁 ¿Y por qué no «Ik heb hem het gegeven»?:
Porque het es el pronombre más ligero que tiene el neerlandés y NUNCA puede ir detrás de otro pronombre objeto. Con dos pronombres, el DIRECTO va primero: Ik heb het hem gegeven.

| lo que dices | ¿vale? | matiz |
|---|---|---|
| Ik heb **het hem** gegeven. | ✓ | el orden neutro con dos pronombres |
| Ik heb **het aan hem** gegeven. | ✓ | el de esta tarjeta: con aan, énfasis en ÉL |
| Ik heb **hem dat** gegeven. | ✓ | «eso» se lo he dado a él |
| Ik heb **hem het boek** gegeven. | ✓ | indirecto pronombre + directo sustantivo |
| Ik heb hem **het** gegeven. | ✗ | het detrás de otro pronombre: imposible |

Fíjate en la tercera fila: el problema NO es el orden, es la palabra. Cambia het por el demostrativo dat —que sí se puede acentuar— y la misma frase se arregla sola.

📊 El orden de los dos objetos, según con qué los digas:

| lo que combinas | orden | ejemplo |
|---|---|---|
| pronombre + pronombre | directo → indirecto | Ik geef **het je**. |
| pronombre indirecto + sustantivo directo | indirecto → directo | Ik geef **je het boek**. |
| sustantivo + sustantivo | indirecto → directo | Ik geef **mijn broer het boek**. |
| con **aan** | el destinatario se va a la derecha | Ik geef **het boek aan mijn broer**. |

Regla de bolsillo: cuanto más ligera es la palabra, más a la izquierda va. het es la más ligera de todas, así que se coloca delante de todo y nunca se queda al final.
⚠️ Por lo mismo, het tampoco puede encabezar la frase ni llevar acento: no digas «Het heb ik hem gegeven», sino Dat heb ik hem gegeven.
⚠️ En imperativo, igual: Geef het me · Geef het aan mij, pero nunca «Geef me het».
🏋️ Ejercicio: «te lo explico» → Ik leg ___ ___ uit. (Respuesta: het je. El directo, primero.)

📐 Oración principal (hoofdzin)'
)
WHERE id = 635
  AND rules_help LIKE '%📐 Oración principal (hoofdzin)%'
  AND rules_help NOT LIKE '%🎁%';
