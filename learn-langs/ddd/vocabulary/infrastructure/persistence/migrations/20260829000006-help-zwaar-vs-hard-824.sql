-- Learn Languages App - Por que zware y no harde en la ayuda de la tarjeta 824
-- Migration: 20260829000006-help-zwaar-vs-hard-824.sql
-- Description: La tarjeta 824 traduce "penas duras" como "zware straffen", no "harde
--   straffen". Se explica en su rules_help la diferencia zwaar (pesado -> severo/grave, por
--   extension de peso) vs hard (duro al tacto, o duro de caracter/tono/esfuerzo).
--   100% aditiva e idempotente: solo UPDATE con guard (rules_help IS NULL).

UPDATE words_es
SET rules_help = '"Zware straffen", no "harde straffen" — porque "duro" aqui significa SEVERO/GRAVE (el peso de la condena), y ese sentido es zwaar, no hard.

📐 Dos "duro" en espanol, dos palabras en neerlandes:
• **zwaar** = pesado (literal, peso) y por extension SEVERO, GRAVE, DIFICIL DE LLEVAR — una carga, una pena, una epoca. Zware straf = pena dura/severa. Zwaar werk = trabajo duro/pesado. Zware tijden = tiempos dificiles.
• **hard** = duro al tacto (textura, firmeza), o duro de caracter/tono, o intenso en esfuerzo/volumen. Harde stoel = silla dura. Harde stem = voz dura/aspera. Hard werken = trabajar duro (con esfuerzo). Harde muziek = musica alta/fuerte.

📌 Regla de bolsillo: si el "duro" espanol se puede cambiar por "pesado/grave/severo" sin que cambie mucho el sentido → zwaar. Si es sobre textura fisica, dureza de caracter, o volumen/esfuerzo → hard.

🗣 Mas ejemplos:
• zwaar — Deze koffer is zwaar. — Esta maleta pesa mucho / es pesada. Het was een zwaar jaar. — Fue un año duro.
• hard — Deze stoel is hard. — Esta silla es dura. Hij heeft een hard hart. — Tiene un corazón duro (insensible).

⚠️ La trampa: ambos se traducen "duro" en espanol, pero no son intercambiables — zware straf (severidad/peso de la condena) suena natural; harde straf suena raro, porque "hard" ahi describiria el TONO o la manera de castigar (severidad de trato), no el peso/gravedad de la pena en si.',
    updated_at = datetime('now')
WHERE id = 824
  AND rules_help IS NULL;
