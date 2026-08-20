-- Learn Languages App - Ayuda 600: ¿«Herinner je je me nog?» en vez de mij?
-- Migration: 20260820000002-help-me-vs-mij-and-herinneren-600.sql
-- Description: Eduardo pregunta si en la 600 (Herinner je je mij nog?) cabe «me» en lugar
--   de «mij». No: (a) se apilarian TRES atonos seguidos (je sujeto + je reflexivo + me
--   objeto) y (b) el objeto es el foco de la pregunta, y el foco pide forma tonica — la
--   misma regla que ya cuenta la 631 (atona por defecto, tonica para enfasis y tras
--   preposicion). Se anaden dos bloques a `rules_help`: 🧠 con el reparto atono/tonico
--   aplicado a esta frase (mas lo que SI se oye al hablar: «Herinner je me nog?» soltando
--   el reflexivo, y sobre todo «Ken je me nog?», que es lo natural) y 🗺️ con el mapa
--   completo de «recordar»: zich herinneren / onthouden / herinneren aan / kennen / weten /
--   vergeten, con la trampa de onthouden (mira al futuro) vs zich herinneren (mira al pasado).
--   Los bloques entran ANTES del cierre 📐/🧭 para no romper la estructura de la tarjeta.
--   Solo UPDATE de rules_help. IDEMPOTENTE por emoji-guarda (NOT LIKE '%🧠%').
--   No es un lote nuevo: va en fichero propio porque la migracion pendiente del mismo dia
--   (20260820000001) crea un GRUPO, y mezclar una ayuda ahi ensuciaria el fichero.

UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '📐 Pregunta sí/no',
    '🧠 ¿Vale «Herinner je je me nog?» en vez de mij? NO, por dos motivos que se refuerzan:
• Fila de TRES átonos: je (sujeto) + je (reflexivo) + me (objeto). El neerlandés no apila tres pronombres débiles seguidos; el último se estira a su forma tónica → mij.
• El objeto es el FOCO de la pregunta: «¿te acuerdas de MÍ?». Y el foco pide tónica, igual que dice la tarjeta de Kun je me even helpen: átona por defecto, tónica para énfasis y siempre tras preposición.
Regla práctica de posición: el átono vive PEGADO al verbo y al sujeto (Ik bel je straks); en la posición fuerte —al final, en contraste o tras preposición— solo cabe el tónico: mij, jou, hem, haar, hen.
Lo que SÍ se oye al hablar: mucha gente suelta el reflexivo y dice «Herinner je me nog?» — ahí el me ya va pegado al sujeto y deja de estar en posición fuerte. Correcto de norma sigue siendo: Herinner je je mij nog?
Y lo más natural de todo: «Ken je me nog?», que es lo que dice un neerlandés al reencontrarse con alguien (herinneren suena más de libro). También vale: Weet je nog wie ik ben?
El reflexivo, en cambio, es SIEMPRE átono: Ik herinner me jou nog goed (me = reflexivo átono, jou = objeto tónico). Nunca «Ik herinner mij jou».

🗺️ El mapa de «recordar / acordarse» (en español es casi un solo verbo; en neerlandés son seis):
• zich herinneren = acordarse de, traer a la memoria (reflexivo, mira al PASADO). Ik herinner me zijn naam niet.
• onthouden = memorizar, retener para después (mira al FUTURO). Kun je dit nummer onthouden?
• herinneren aan = recordar A alguien algo, o hacer pensar en (NO reflexivo, con aan). Herinner me eraan dat ik moet bellen (recuérdamelo) · Dat liedje herinnert mij aan vroeger.
• kennen = conocer y reconocer a una persona. Ken je me nog? = ¿te acuerdas de mí?
• weten = saber un dato. Weet je nog waar we waren?
• vergeten = olvidar, el contrario de onthouden. Ik ben het vergeten.
⚠️ Error típico: decir onthouden donde toca herinneren. onthouden = meterlo en la cabeza (futuro) · zich herinneren = sacarlo de la cabeza (pasado).

📐 Pregunta sí/no'
)
WHERE id = 600
  AND rules_help LIKE '%📐 Pregunta sí/no%'
  AND rules_help NOT LIKE '%🧠%';
