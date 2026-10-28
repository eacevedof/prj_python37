-- Learn Languages App - El orden de las dos preguntas del articulo (duda de la 852)
-- Migration: 20260831000009-help-block-artikel-twee-vragen.sql
-- Description: Eduardo sobre la 852 («Ik kreeg gisteren een afwijzing van de universiteit»): el
--   escribio «van universiteit», y pregunta como formular la pregunta de la regla del «cual»
--   («¿de cual recibi una denegacion? de la universidad, ¿es asi?»). Su test es correcto pero es
--   la SEGUNDA pregunta: la primera es si el sustantivo lleva determinante o no. El singular
--   contable pelado no existe en neerlandes (ni en espanol), asi que «van universiteit» falla
--   antes de llegar a elegir entre de y het. Bloque 🎯 IDENTICO byte a byte con las dos preguntas
--   en orden, el aviso de que los casos SIN articulo son una LISTA CERRADA y no una regla
--   generalizable (se dice op school pero NO «op universiteit»: aan de universiteit), y el mismo
--   sustantivo con y sin articulo (op school = escolarizado / voor de school = el edificio).
--   Completa el grupo 29 «articulos - de, het o sin articulo» (785-799), que daba la regla de la
--   funcion vs el objeto identificable pero no el orden de las preguntas ni el caracter cerrado
--   de la lista, y engancha la 852, donde salio la duda.
--   100% aditiva e idempotente: UPDATE con guard por marca.

UPDATE words_es
SET rules_help = rules_help || '

🎯 Antes de decidir CUAL articulo, decide SI lleva: las dos preguntas van en orden
El fallo tipico no es elegir mal entre de y het, sino quitar el articulo donde tenia que ir alguno. Por eso las preguntas van en este orden y no al reves:

1. ¿El sustantivo es CONTABLE y esta en SINGULAR? Entonces lleva determinante si o si: de, het, een, mijn, deze, die… El singular contable pelado no existe en neerlandes, igual que tampoco existe en espanol. Por eso «een afwijzing van universiteit» esta mal, exactamente igual que suena mal «una denegacion de universidad»: hace falta van de universiteit (esa, la mia) o van een universiteit (una cualquiera).
2. Solo despues, ¿definido o indefinido? Aqui si vale la pregunta del «cual»: si sabes senalar de cual hablas, definido (de/het); si es una cualquiera o la nombras por primera vez, indefinido (een).

⚠️ Lo que de verdad despista: los casos SIN articulo no son una regla general, son una LISTA CERRADA. Se cae el articulo en el plural generico (Katten zijn onafhankelijk), en el incontable generico (Ik drink koffie), en la profesion tras zijn, worden o als (Mijn zus is arts), en el idioma o la asignatura (Nederlands is moeilijk), en la materia (een tafel van hout), en las locuciones fijas (te voet, op tijd, per post) y en un punado de lugares-funcion detras de preposicion: op school, naar school, op kantoor, in bed, naar huis, aan tafel.

📌 Y ese punado es cerrado, o sea que no se puede generalizar a partir de el. Se dice op school pero NO «op universiteit»: la universidad conserva su articulo, op de universiteit, aan de universiteit. Regla practica: si la palabra no esta en la lista de siempre, lleva articulo.

🧭 El mismo sustantivo, con y sin el, para ver la diferencia:
• Hij zit op school. — Esta escolarizado. Es la FUNCION, y por eso va pelado.
• Hij staat voor de school. — Esta delante del edificio. Es una COSA identificable, y por eso lleva articulo.
• Ik studeer aan de universiteit. — Siempre con articulo, porque universiteit no esta en la lista cerrada.
• Ik kreeg een afwijzing van de universiteit. — Con articulo: es una universidad concreta, la que me contesto.',
    updated_at = datetime('now')
WHERE id IN (785, 786, 787, 788, 789, 790, 791, 792, 793, 794, 795, 796, 797, 798, 799, 852)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🎯 Antes de decidir CUAL articulo%';
