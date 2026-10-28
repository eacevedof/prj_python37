-- 550 «Dat gaat jou niets aan» — por qué no vale «dat maakt je niet uit»:
-- aangaan = incumbir (competencia) · uitmaken = dar igual (indiferencia).
-- Idempotente: solo inserta si el bloque 🙅 todavía no está en la ayuda.

UPDATE words_es
SET rules_help = REPLACE(
        rules_help,
        '📐 Oración principal:',
        '🙅 aangaan no es uitmaken: «Dat maakt jou niet uit» es neerlandés correcto, pero dice otra cosa — «eso a ti te da igual». El pronombre no es el problema (je/jou valen en las dos): lo que cambia es el verbo.

Dos ideas distintas que en español caben en el mismo «no te importa»:
• aangaan = INCUMBIR — no es asunto tuyo, no tienes por qué meterte (competencia).
• uitmaken = DAR IGUAL — no te supone ninguna diferencia (indiferencia).

Por eso «Dat maakt jou niet uit» no corta a nadie: le estás diciendo al otro lo que siente, no le estás parando los pies.

Los verbos de importar, que en español son uno solo:

| neerlandés | qué dice de verdad | ejemplo |
|---|---|---|
| **aangaan** | incumbir, ser asunto de alguien | Dat gaat jou niets **aan**. — Eso a ti no te importa. |
| **uitmaken** | dar igual, no suponer diferencia | Het maakt me niet **uit**. — Me da igual. |
| **schelen** | importarle a uno (coloquial) | Het kan me niets **schelen**. — Me trae sin cuidado. |
| **ertoe doen** | venir al caso, contar | Dat doet er niet **toe**. — Eso no viene al caso. |
| **geven om** | tenerle aprecio a algo | Ik **geef** niet **om** geld. — El dinero no me importa. |
| **interesseren** | interesar | Het interesseert me niet. — No me interesa. |
| **boeien** | importar un pimiento (muy coloquial) | Het boeit me niet. — Me la trae floja. |

⚠️ El detalle del niets: aangaan pide niets (Dat gaat je niets aan) y uitmaken pide niet (Dat maakt niet uit). Intercambiarlos suena a extranjero.

La misma escena, un verbo cada vez:
• Dat gaat jou niets aan. — Eso a ti no te importa (no te metas).
• Dat maakt jou toch niets uit? — A ti te da igual, ¿no?
• Kan het je echt niets schelen? — ¿De verdad te da lo mismo?
• Waarom bemoei je je ermee? — ¿Por qué te metes?

💎 Si lo que quieres es cortarle: Dat gaat je niets aan (no es asunto tuyo) o Dat maak ik zelf wel uit (eso lo decido yo). Eso es lo que NO dice «dat maakt je niet uit».

🎭 Los otros uitmaken:
• het uitmaken (met iemand) = cortar, dejar la relación — Ze heeft het uitgemaakt.
• deel uitmaken van = formar parte de — Hij maakt deel uit van het team.
• iets uitmaken = decidirlo uno — Dat maak ik zelf wel uit.

🔌 El otro aangaan: encenderse (Het licht gaat vanzelf aan) y contraer, entrar en algo (een verbintenis aangaan = comprometerse).

📐 Oración principal:'
    ),
    updated_at = datetime('now')
WHERE id = 550
  AND rules_help LIKE '%📐 Oración principal:%'
  AND rules_help NOT LIKE '%🙅 aangaan%';
