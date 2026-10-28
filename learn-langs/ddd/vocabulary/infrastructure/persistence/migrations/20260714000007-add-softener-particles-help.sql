-- Learn Languages App - Ayuda de partículas suavizadoras (even / maar / maar even)
-- Migration: 20260714000007-add-softener-particles-help.sql
-- Description: Añade un bloque 🪶 al rules_help de las 20 tarjetas cuyo neerlandés usa
--   even o maar como PARTÍCULA SUAVIZADORA (no las que usan maar = "pero" conjunción,
--   maar = "solo" adverbio, ni la muletilla "Maar goed"). Explica: even suaviza el
--   tamaño/esfuerzo; maar suaviza la imposición (permiso/ánimo); maar even = ambas
--   (orden fijo); más la escalera Wacht → even → maar → maar even y la regla mental.
--   Keyeada por el texto nl_NL (estable, rebuild-robusto) vía subconsulta.
--   100% aditiva e IDEMPOTENTE (guarda NOT LIKE '%🪶%'). Solo UPDATE de
--   words_es.rules_help; no toca words_lang/audio, imágenes ni notes.

PRAGMA foreign_keys = ON;

UPDATE words_es
SET rules_help = COALESCE(rules_help || char(10) || char(10), '') || '🪶 Partículas para suavizar (even · maar · maar even):
• even suaviza el TAMAÑO/esfuerzo: hace que la petición parezca pequeña y rápida (un momento, un segundito, un poco). Ej.: Kun je me even helpen? (¿me echas una mano un momento?) · Wacht even (espera un momento) · Ik ga even naar de wc (voy un momento al baño).
• maar suaviza la IMPOSICIÓN: en imperativos da permiso, tranquiliza o anima (venga, adelante, tranquilo, sin problema); convierte la orden en invitación. Ej.: Ga maar zitten (siéntate, venga) · Zeg het maar (tú dirás) · Doe maar (venga, vale) · Kom maar binnen! (pasa, pasa).
• maar even = las dos cosas juntas: permiso/tranquilidad + pequeño/rápido = máxima suavidad (anda, un momentito, sin más). Orden FIJO maar even, nunca even maar. Ej.: Kom maar even hier · Bel haar maar even · Wacht maar even.
Escalera con la misma frase: Wacht (seco, orden) → Wacht even (un momento, pequeño) → Wacht maar (tranquilo, permiso) → Wacht maar even (un momentito, del todo suave).
Regla mental: ¿que parezca rápido/pequeño? → even · ¿dar permiso/animar/tranquilizar? → maar · ¿las dos? → maar even. (Ojo: maar también es "pero" (conjunción) y "solo" en nog maar / een keer maar; aquí hablamos del maar partícula de los imperativos.)'
WHERE id IN (
    SELECT word_es_id FROM words_lang WHERE lang_code = 'nl_NL' AND text IN (
        'je moet echt even wat eten',
        'Zullen we even pauze nemen?',
        'Vraag even of hij soms een pen heeft.',
        'Als je tijd hebt, bel me even.',
        'Laat me even nadenken.',
        'Even kijken.',
        'Mag ik me even voorstellen?',
        'Ik ben even gaan liggen.',
        'Kun je me even helpen?',
        'Ik wil even met jou praten.',
        'Zullen we maar?',
        'Zullen we er maar aan beginnen?',
        'Zal ik maar?',
        'Kom maar binnen!',
        'Zeg het maar.',
        'Gooi ze maar weg.',
        'Ontspant u zich maar.',
        'Geef het maar aan mij.',
        'Bel haar maar even.',
        'Wacht maar even op mij!'
    )
)
AND COALESCE(rules_help, '') NOT LIKE '%🪶%';
