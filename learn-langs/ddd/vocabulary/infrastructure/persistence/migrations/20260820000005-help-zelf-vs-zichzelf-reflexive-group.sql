-- Learn Languages App - Ayuda: los tres «zelf» (zelf · mezelf/zichzelf · vanzelf)
-- Migration: 20260820000005-help-zelf-vs-zichzelf-reflexive-group.sql
-- Description: Eduardo no sabe cuando toca mezelf/jezelf/zichzelf y cuando la forma corta, y
--   da por buena una forma que NO existe: «erzelf». Bloque 🙋 con las TRES cosas distintas que
--   en espanol suenan igual —el reflexivo atono que pide el verbo (me/je/zich/ons), el
--   reflexivo tonico que es objeto de verdad (mezelf/jezelf/zichzelf/onszelf) y el adverbio
--   de enfasis del sujeto (zelf, invariable)— con la formula de tres preguntas para elegir
--   (¿lo exige el verbo? ¿admitiria otra persona como objeto? ¿va tras preposicion?), la
--   tabla de formas, el aviso de que «erzelf» no existe y las dos palabras que si cubren ese
--   hueco (zichzelf para cosas y sobre todo VANZELF = por si solo), el falso amigo zelf/zelfs
--   (incluso), el reciproco elkaar (el otro «se» del espanol) y las frases hechas con -zelf.
--   Se anade a las 15 tarjetas del grupo «verbos reflexivos» porque la sesion las baraja: asi
--   la regla aparece con cualquier reflexivo que salga. Solo UPDATE de rules_help.
--   IDEMPOTENTE por emoji-guarda (NOT LIKE '%🙋%').
--   Escrita fuera de migrations/ y movida ya terminada (leccion del 2026-08-20).

UPDATE words_es SET rules_help = COALESCE(rules_help, '') || '

🙋 Los tres «zelf» que se mezclan (y la fórmula para elegir)
En español todo suena a «me / se / mismo»; en neerlandés son TRES cosas distintas:
1) me · je · zich · ons = reflexivo ÁTONO. Es el que PIDE EL VERBO y no significa nada por sí solo: zich schamen, zich vergissen, zich haasten. Ik schaam me. No se puede quitar ni sustituir.
2) mezelf · jezelf · zichzelf · onszelf = reflexivo TÓNICO, «a mí mismo». Es un objeto de verdad: la acción recae sobre quien la hace, y eso INFORMA, porque podría recaer sobre otro. Ik zie mezelf in de spiegel (me veo a mí mismo) · Hij haat zichzelf.
3) zelf a secas = adverbio de ÉNFASIS del sujeto: «yo mismo, en persona, sin ayuda». No es objeto y NO cambia con la persona: Ik doe het zelf · Heb je dat zelf gemaakt? · De directeur zelf belde.
🧮 La fórmula, en tres preguntas:
• ¿El verbo EXIGE el reflexivo, solo existe así? → forma CORTA. Ik vergis me · Ik haast me · Ik schaam me · Ik verslaap me. Nunca mezelf.
• ¿El verbo admitiría OTRA persona como objeto (wassen, zien, kennen, haten, helpen, snijden, voorstellen)? → corta si es rutina (Ik was me = me lavo), y -ZELF en cuanto hay contraste o énfasis: Ik was mezelf, niet de auto · Hij helpt alleen zichzelf.
• ¿Va detrás de PREPOSICIÓN? → casi siempre -zelf: Ik denk aan mezelf · Ze praat tegen zichzelf · Hij is trots op zichzelf · voor zichzelf beginnen (establecerse por su cuenta).
Tabla de formas: ik→me / mezelf · jij-je→je / jezelf · u→zich / uzelf · hij-zij-het→zich / zichzelf · wij→ons / onszelf · jullie→je / jezelf · zij (pl)→zich / zichzelf.
⚠️ «erzelf» NO existe. er es el pronombre de COSA que sustituye a het/dat delante de preposición (ermee, eraan, erover) y no admite -zelf. Si lo que buscas es «solo, por sí mismo», tienes otras dos palabras:
• zichzelf, cuando la cosa es el sujeto y la acción recae sobre ella: De machine schakelt zichzelf uit · Het systeem herstart zichzelf.
• vanzelf = por sí solo, automáticamente — que suele ser lo que de verdad quieres decir: De deur gaat vanzelf dicht · Het gaat vanzelf over (se pasa solo) · Dat spreekt vanzelf (eso cae de su peso) · vanzelfsprekend (evidente).
⚠️ zelf (mismo) NO es zelfs (con -s), que significa INCLUSO: Zelfs Jan kwam (incluso vino Jan) frente a Jan kwam zelf (vino Jan en persona).
🤝 Y el otro «se» del español: elkaar (el uno al otro). El español usa «se» para las dos cosas y el neerlandés no: Ze wassen zich (cada uno se lava) · Ze wassen elkaar (se lavan el uno al otro) · Ze kennen elkaar al jaren (se conocen desde hace años).
📌 Frases hechas con -zelf que vas a oír: Wees jezelf (sé tú mismo) · uit zichzelf (por iniciativa propia) · op zichzelf wonen (vivir por su cuenta) · op zichzelf (en sí mismo) · buiten zichzelf van woede (fuera de sí de rabia) · Ken jezelf.
🏋️ Ejercicio: (a) «me equivoco» → Ik vergis ___. (b) «me veo en el espejo» → Ik zie ___ in de spiegel. (c) «lo hago yo mismo» → Ik doe het ___. (d) «la puerta se cierra sola» → De deur gaat ___ dicht. (Respuestas: me · mezelf · zelf · vanzelf.)'
WHERE id IN (
    SELECT word_es_id FROM word_es_groups
    WHERE group_id = (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden')
)
AND COALESCE(rules_help, '') NOT LIKE '%🙋%';
