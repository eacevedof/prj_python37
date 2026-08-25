-- Learn Languages App - Ayuda: «un poco» = wat o een beetje (704 y 601)
-- Migration: 20260825000002-help-wat-vs-een-beetje-704-601.sql
-- Description: Eduardo pregunta en la 704 (Doe wat melk in de thee) cuando «un poco» es wat y
--   cuando een beetje. Lo que decide PRIMERO es lo que viene detras: con plural contable solo
--   vale wat (wat mensen; «een beetje mensen» no existe) y con verbo solo een beetje (Haast je
--   een beetje, que es justo la 601). Con incontable y con adjetivo valen los dos, y ahi lo que
--   cambia es el matiz: wat es ATONO y neutro («algo de», no dice que sea poco), een beetje MARCA
--   la pequenez y admite acento (maar EEN BEETJE). De propina, la trampa que no se ve venir:
--   «poco» espanol se parte en dos como en ingles little/a little — weinig (escaso, queja) frente
--   a wat/een beetje (neutro). Incluye los otros tres wat (interrogativo, exclamativo, relativo,
--   ya en las tarjetas 258/218/338) y el wat pronombre «algo» de las 147/204/283.
--   Bloque IDENTICO en las dos unicas tarjetas donde vive el fenomeno: 704 (wat + incontable) y
--   601 (een beetje + verbo).
--   100% aditiva e IDEMPOTENTE: guarda NOT LIKE en cada UPDATE.

PRAGMA foreign_keys = ON;

UPDATE words_es
SET rules_help = rules_help || '

🥄 «un poco»: wat o een beetje (y cuando no es ninguno de los dos)
Lo que decide PRIMERO es lo que viene DETRAS:
| detras va... | wat | een beetje |
|---|---|---|
| incontable (melk, zout, tijd, geld) | ✅ wat melk | ✅ een beetje melk |
| plural contable (mensen, boeken) | ✅ wat mensen = unas cuantas personas | ❌ no existe |
| adjetivo o adverbio (moe, laat, duur) | ✅ wat moe (mas escrito) | ✅ een beetje moe (lo hablado) |
| verbo (haasten, opschieten) | ⚠️ raro | ✅ Haast je een beetje! |

🎚️ Y lo que ANADE cada uno cuando los dos valen:
• wat es ATONO y neutro: «algo de». No dice que sea poco, dice que no se precisa la cantidad. Por eso es el de la receta: Doe wat melk in de thee = echale leche, sin mas.
• een beetje MARCA la pequenez y admite acento: maar EEN BEETJE = solo un poco. Literalmente es el diminutivo de beet (bocado): «un bocadito».
🧪 Prueba de dos segundos: si cabe «algo de» sin cambiar el sentido → wat. Si quieres decir «solo un poco» o «un pelin» → een beetje.

⚠️ wat con este valor NO se puede acentuar: en cuanto lo acentuas deja de ser cuantificador. Es homonimo de otros tres wat que ya estan en el temario: interrogativo (Wat is er? — 258), exclamativo (Wat mooi!) y relativo (alles wat je zegt — 218, 338).
⚠️ Y hay un cuarto wat, el PRONOMBRE «algo», que va SIN sustantivo detras: Zullen we wat eten? = ¿comemos algo? (147, 204, 283).

🚫 Cuando no va ninguno de los dos: weinig. Es la trampa del «poco» espanol, que el neerlandes parte en dos igual que el ingles (little / a little):
• weinig melk = POCA leche, y suena a insuficiente. Ik heb weinig tijd = voy justo de tiempo.
• wat melk / een beetje melk = ALGO de leche, neutro o hasta de sobra. Ik heb wat tijd = tengo un rato.
Si lo que transmites es escasez o queja, es weinig — nunca een beetje.

🗺️ La familia entera del «poco»: een klein beetje = un poquito · een tikkeltje = un pelin · iets = algo, sobre todo con comparativo (iets warmer = un poco mas caliente) · enigszins / ietwat = formal escrito · nogal = bastante · beetje bij beetje = poco a poco · zo''n beetje = mas o menos, aproximadamente.
💬 Dos hechas que vas a oir: Doe eens een beetje normaal! = ¡compórtate! · een beetje veel = un pelin demasiado.',
    updated_at = datetime('now')
WHERE id IN (704, 601)
  AND rules_help NOT LIKE '%🥄 «un poco»: wat o een beetje%';
