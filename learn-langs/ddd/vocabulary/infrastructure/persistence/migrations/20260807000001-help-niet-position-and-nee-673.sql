-- Learn Languages App - Ayuda: posicion de "niet", el "Nee" (673) y beloven te vs dat (681)
-- Migration: 20260807000001-help-niet-position-and-nee-673.sql
-- Description:
--   673 (Nee, ik hoef morgen niet te werken) — bloque 🚫: (1) por que "ik hoef morgen niet
--   te werken" y no "ik hoef niet morgen te werken" (posicion de niet: tras el tiempo
--   definido = negacion neutra; delante de morgen = negacion de foco/contraste "no MAÑANA
--   sino otro dia"); (2) por que el "Nee" inicial (respuesta a la pregunta si/no, NO es la
--   negacion; niet es la negacion de la frase; la frase sola ya es completa).
--   681 (Beloof me op tijd te zijn) — bloque 🔀: "Beloof me dat je op tijd komt" TAMBIEN es
--   correcto; son dos construcciones de beloven (te + infinitivo vs dat + subordinada).
--   Keyeadas por el texto nl_NL, idempotentes por emoji-guarda. Solo UPDATE de
--   words_es.rules_help; no toca words_lang/audio, imagenes ni notes.
--   (Nueva pool: 20260805000001 ya esta registrada/aplicada, no se fusiona en ella.)

PRAGMA foreign_keys = ON;

UPDATE words_es SET rules_help = rules_help || '

🚫 Posicion de "niet" y para que el "Nee":
1) Por que "ik hoef morgen niet te werken" y NO "ik hoef niet morgen te werken"?
Por DONDE va niet. Regla: niet va DESPUES de las expresiones de tiempo definidas (morgen, vandaag, om 8 uur) y cae al final, justo antes de te + infinitivo. Asi niega TODA la frase (negacion neutra) = "mañana no hace falta que trabaje".
Si pones niet DELANTE de morgen ("ik hoef niet morgen te werken"), niet niega solo esa palabra (negacion de FOCO/contraste) = "no hace falta que trabaje MAÑANA (sino otro dia)" → da a entender que SI trabajas, pero otro dia. Es una frase marcada que pide contraste (…maar wel overmorgen); no es lo que quieres decir aqui.
Orden normal: sujeto + hoef + [tiempo: morgen] + niet + te + werken.

2) Por que el "Nee" al principio? No basta con "Ik hoef morgen niet te werken"?
Si basta: "Ik hoef morgen niet te werken" es una frase completa y correcta ella sola. El "Nee," solo esta porque aqui es la RESPUESTA a una pregunta de si/no (Ga je morgen naar kantoor? = ¿vas mañana a la oficina?): Nee = No. Es un elemento de DIALOGO (contesta la pregunta), NO forma parte de la negacion gramatical.
No confundas: Nee = el "no" que RESPONDE (fuera de la frase); niet = el "no" que NIEGA dentro de la frase. Fuera de una pregunta, di solo "Ik hoef morgen niet te werken".'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Nee, ik hoef morgen niet te werken.')
  AND COALESCE(rules_help,'') NOT LIKE '%🚫%';

-- 681 · Beloof me op tijd te zijn — beloven + te vs beloven + dat
UPDATE words_es SET rules_help = rules_help || '

🔀 Y "Beloof me dat je op tijd komt"? TAMBIEN es correcto.
beloven admite DOS construcciones y aqui la tarjeta usa la primera:
• beloven + te + infinitivo (compacta): Beloof me op tijd te zijn. Solo se puede cuando el que promete y el que hace la accion son el MISMO sujeto (tu prometes → tu llegas a tiempo). Como el sujeto se sobreentiende, se omite y el infinitivo va con te.
• beloven + dat + subordinada (explicita): Beloof me dat je op tijd komt. El sujeto va EXPRESO (je) y el verbo conjugado (komt) al final. Siempre vale, y es OBLIGATORIA cuando el sujeto es distinto: Beloof me dat je moeder komt (que venga tu madre) — ahi NO puedes usar te.
Las dos dicen lo mismo aqui; la de te es mas breve y es la que practica este grupo (verbos con te). Detalle: op tijd zijn (estar a tiempo) y op tijd komen (llegar a tiempo) son ambas correctas, solo cambia el verbo.

¿"Mismo sujeto"? OJO, en "Beloof me op tijd te zijn" NO hay dos sujetos. Es un IMPERATIVO con el sujeto OCULTO jij (tu): "Beloof (jij) me op tijd te zijn". Piezas: Beloof (jij) = quien promete = tu · me = objeto indirecto (a MI, a quien prometes; NO es un sujeto) · op tijd te zijn = quien llega a tiempo = tu. Quien promete (tu) y quien hace la accion (tu) son el MISMO → por eso te. (En espanol igual: "Prometeme llegar a tiempo": tu prometes, tu llegas; el "me / a mi" solo dice a quien se lo prometes.)
Dos sujetos DE VERDAD seria "Beloof me dat je moeder komt": promete tu, pero viene tu MADRE → distinto sujeto → dat obligatorio (no cabe te).
Regla: mira quien PROMETE y quien hace la ACCION prometida (el "me / a mi" no cuenta, es solo el destinatario). Iguales → te (o dat); distintos → solo dat.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Beloof me op tijd te zijn.')
  AND COALESCE(rules_help,'') NOT LIKE '%🔀%';

-- 676 · Je hoeft je geen zorgen te maken — por que el 2o "je" (reflexivo)
UPDATE words_es SET rules_help = rules_help || '

🪞 Por que NO "Je hoeft geen zorgen te maken" (sin el 2o je)?
Porque la expresion es REFLEXIVA: zich zorgen maken = preocuparse (literal: hacerSE preocupaciones). El reflexivo es OBLIGATORIO; sin el, la frase queda incompleta/incorrecta.
En "Je hoeft je geen zorgen te maken" hay DOS je distintos:
• 1er Je = SUJETO (jij) = tu, quien no tiene que preocuparse.
• 2o je = pronombre REFLEXIVO (zich → je para jij) = te / a ti mismo, parte fija del verbo zich ... maken.
Literal: "Tu no tienes que hacerTE ninguna preocupacion" = no tienes que preocuparte. Quita el 2o je y desaparece el "se" de preocuparSE → ya no es la expresion.
Paradigma del reflexivo: ik → me (Ik maak me geen zorgen) · jij → je · u → u/zich · hij/zij → zich · wij → ons (We maken ons geen zorgen) · jullie → je · zij (pl) → zich. Imperativo: Maak je geen zorgen! (no te preocupes).
Nota: geen (no niet) porque niega el sustantivo zorgen (geen zorgen = ninguna preocupacion); y sigue con te → te maken.'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Je hoeft je geen zorgen te maken.')
  AND COALESCE(rules_help,'') NOT LIKE '%🪞%';

-- 677 · Je hoeft alleen maar te bellen — alleen vs maar vs alleen maar
UPDATE words_es SET rules_help = rules_help || '

☝️ alleen / maar / alleen maar (las tres valen; en espanol todas suenan a "solo"):
Las TRES frases son correctas; cambia el ENFASIS, no la gramatica:
• Je hoeft alleen te bellen = solo tienes que llamar (alleen = solo / unicamente). Correcta. (Ambiguedad teorica minima: alleen tambien significa "a solas", pero el contexto lo descarta.)
• Je hoeft maar te bellen = basta con que llames / no tienes mas que llamar (maar = particula restrictiva "solo / no mas que"). Correcta; suele anadir el matiz "y ya esta / con eso basta", resalta lo POCO o FACIL que es.
• Je hoeft alleen maar te bellen = solo tienes que llamar, y NADA MAS (alleen maar = las dos juntas = refuerzo enfatico). Es la mas comun, idiomatica y la mas clara.
¿Hay que juntar alleen + maar? NO es obligatorio: cada una sola ya se entiende como "solo / basta con". Se juntan para ENFATIZAR ("solo eso, nada mas") y quitar la ambiguedad de alleen. En espanol las dos suenan a "solo" (por eso juntarlas parece redundante); en neerlandes alleen maar = "solo... y nada mas".
¿Que entiende un neerlandes con una sola? Lo mismo (solo tienes que llamar), con matiz: maar → "con una llamada basta, es facilisimo"; alleen → mas neutro "unicamente"; alleen maar → el enfasis pleno "solo eso".

Mini-dialogos coloquiales:
• alleen (unicamente, neutro):
  — Moet ik iets meenemen naar het feestje? (¿tengo que llevar algo a la fiesta?)
  — Nee joh, je hoeft alleen jezelf mee te nemen! (que va, ¡solo tienes que traerte a ti mismo!)
• maar (con eso basta / es facilisimo; suele arrastrar un "en..." con el resultado):
  — Ik durf het niet te vragen... (no me atrevo a pedirlo...)
  — Joh, je hoeft het maar te zeggen en ik help je. (hombre, no tienes mas que decirlo y te ayudo.)
• alleen maar (solo eso y NADA mas, enfatico):
  — Is het moeilijk, die soep? (¿es dificil, esa sopa?)
  — Welnee, je hoeft alleen maar water te koken en het zakje erin te doen. (que va, solo tienes que hervir agua y echar el sobre.)'
WHERE id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Je hoeft alleen maar te bellen.')
  AND COALESCE(rules_help,'') NOT LIKE '%☝️%';
