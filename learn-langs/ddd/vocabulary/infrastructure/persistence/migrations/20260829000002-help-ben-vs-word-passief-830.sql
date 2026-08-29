-- Learn Languages App - Por que "ben benaderd" y no "word benaderd" en la ayuda de la tarjeta 830
-- Migration: 20260829000002-help-ben-vs-word-passief-830.sql
-- Description: La tarjeta 830 ("Me ha contactado un cazatalentos.") usa "Ik ben benaderd
--   door een recruiter" — pasiva de PERFECTO (zijn + participio), no worden + participio
--   (pasiva de presente). Se explica en su rules_help el reparto worden/zijn en la pasiva:
--   worden para los tiempos simples, zijn para los tiempos perfectos (el propio worden usa
--   zijn como auxiliar de su perfecto: no existe "is geworden benaderd").
--   100% aditiva e idempotente: solo UPDATE con guard (rules_help IS NULL).

UPDATE words_es
SET rules_help = '"Ik ben benaderd door een recruiter" es pasiva de PERFECTO, no de presente — por eso zijn (ben) y no worden (word).

📐 El reparto worden / zijn en la pasiva:
• **worden** + participio = pasiva de tiempo SIMPLE (presente/pasado): la accion ocurre o se repite. Ik word benaderd door recruiters. — Soy contactado por reclutadores (en general, presente).
• **zijn** + participio = pasiva de tiempo PERFECTO (presente perfecto/pluscuamperfecto): la accion ya se completo, hay un resultado. Ik ben benaderd door een recruiter. — Me ha contactado un cazatalentos (ya paso, perfecto).

⚠️ La razon de fondo: el propio worden usa ZIJN como auxiliar de su PROPIO perfecto (worden → is geworden, como gaan → is gegaan). Asi que el perfecto de una pasiva NUNCA lleva worden ni "is geworden" delante del participio — el "geworden" se absorbe y solo queda zijn + participio. Decir "Ik ben geworden benaderd" o "Ik word benaderd" (para el sentido de "me ha contactado") es el error tipico del hispanohablante.

🗣 Contraste completo con benaderen:
• presente pasiva — Ik word vaak benaderd door recruiters. — A menudo me contactan reclutadores.
• pasado pasiva — Ik werd gisteren benaderd door een recruiter. — Ayer me contactó un reclutador.
• perfecto pasiva — Ik ben benaderd door een recruiter. — Me ha contactado un reclutador. (esta frase)

📌 Regla de bolsillo: si en español la frase esta en pretérito perfecto o pluscuamperfecto ("me HA/HABIA contactado") → zijn (ben/is/was) + participio. Si esta en presente o pasado simple ("me contacta/contactó") → worden (word/wordt/werd) + participio.',
    updated_at = datetime('now')
WHERE id = 830
  AND rules_help IS NULL;
