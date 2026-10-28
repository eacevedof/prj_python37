-- Learn Languages App - Anade el contraste werd vs ben (con toen/gisteren) a la ayuda de la 830
-- Migration: 20260829000003-help-werd-vs-ben-toen-830.sql
-- Description: Completa la explicacion de la pasiva de benaderen en la tarjeta 830 con el
--   contraste aspectual werd benaderd (pasado simple) vs ben benaderd (perfecto): no es una
--   cuestion de pasado lejano/cercano, sino de si hay un punto temporal fijado (toen exige
--   pasado simple; gisteren/vorige week admiten los dos) frente al perfecto como forma por
--   defecto en el habla para reportar un hecho ya ocurrido sin fijar el momento.
--   100% aditiva e idempotente: solo UPDATE con guard (marca @@TOEN@@ para no duplicar).

UPDATE words_es
SET rules_help = rules_help || '

🕰️ werd benaderd vs ben benaderd — NO es pasado lejano vs cercano, es otra cosa:
No se trata de la distancia en el tiempo (un "werd" de hace mil años y un "ben" de hace un minuto son ambos posibles). La diferencia real es si el momento pasado esta FIJADO en la frase o no:
• **toen** (cuando, para UN momento pasado concreto) EXIGE pasado simple, nunca perfecto — es una regla gramatical fija, no una eleccion de matiz: Toen ik op kantoor kwam, werd ik meteen benaderd door een recruiter. — Cuando llegue a la oficina, un reclutador me contacto enseguida. ("toen ik ben benaderd" no se dice).
• Con un adverbio como **gisteren** o **vorige week** valen los dos, pero el pasado simple es el que suena a narracion de un hecho puntual: Gisteren werd ik benaderd door een recruiter. — Ayer me contacto un reclutador. (tan valido como "Ik ben gisteren benaderd", pero mas narrativo.)
• Sin marcador de tiempo, o para destacar el resultado presente del hecho, el perfecto es la forma por defecto en el habla — poco importa si fue hace un minuto o hace anos: Ik ben ooit benaderd door een recruiter, maar ik heb nee gezegd. — En su dia me contacto un reclutador, pero dije que no.

📌 Resumen: toen → siempre werd (pasado simple). Con fecha/momento explicito (gisteren, vorige week) → los dos valen, werd suena mas a relato. Sin fecha, hablando del hecho y su resultado → ben (perfecto), que es la forma que un neerlandes usa por defecto al hablar del pasado.'
WHERE id = 830
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🕰️ werd benaderd vs ben benaderd%';
