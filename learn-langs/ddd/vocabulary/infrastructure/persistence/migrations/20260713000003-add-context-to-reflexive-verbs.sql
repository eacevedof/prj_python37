-- Learn Languages App - Contexto de uso + ejemplo en los verbos reflexivos
-- Migration: 20260713000003-add-context-to-reflexive-verbs.sql
-- Description: Añade un bloque "🧭 Cuándo usarlo" (contexto real de uso + un ejemplo/mini
--   situación) al rules_help de las 15 tarjetas del grupo
--   "verbos reflexivos - wederkerige werkwoorden".
--   100% aditiva e IDEMPOTENTE: solo UPDATE de words_es.rules_help (APPEND) con guarda
--   NOT LIKE '%🧭%'. NO toca words_lang (audio_path), imágenes, notes, text ni ninguna
--   otra columna -> respeta audios/imágenes ya adjuntos.

PRAGMA foreign_keys = ON;

-- zich voelen
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: para describir cómo estás, física o anímicamente. "niet lekker" = malo/pachucho. Ej.: llamas al trabajo para no ir → Ik voel me niet lekker, ik blijf thuis (no me encuentro bien, me quedo en casa). Ánimo: Ik voel me gelukkig / rot.'
WHERE notes = 'Verbo reflexivo: zich voelen' AND rules_help NOT LIKE '%🧭%';

-- zich vergissen
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: para admitir una confusión o error (de nombre, hora, número, parada). Ej.: te bajas en la parada equivocada → Sorry, ik heb me vergist (perdona, me he equivocado). Vergis ik me, of…? = ¿me equivoco, o…?'
WHERE notes = 'Verbo reflexivo: zich vergissen' AND rules_help NOT LIKE '%🧭%';

-- zich herinneren
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: reconectar con alguien que hace tiempo no ves, o comprobar si recuerda algo. Ej.: te cruzas con un excompañero → Herinner je je mij nog? Van de universiteit! (¿te acuerdas de mí? ¡De la uni!).'
WHERE notes = 'Verbo reflexivo: zich herinneren' AND rules_help NOT LIKE '%🧭%';

-- zich haasten
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: meter prisa a alguien (o a ti) porque vais tarde. Ej.: el tren sale en 5 minutos y tu amigo va lento → Haast je een beetje, anders missen we de trein! (date prisa o perdemos el tren). Coloquial: Schiet op!'
WHERE notes = 'Verbo reflexivo: zich haasten' AND rules_help NOT LIKE '%🧭%';

-- zich vervelen
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: decir que alguien (o tú) está aburrido, sin nada que hacer. Ej.: día de lluvia y los niños no saben qué hacer → De kinderen vervelen zich, laten we iets doen (se aburren, hagamos algo). Tú: Ik verveel me.'
WHERE notes = 'Verbo reflexivo: zich vervelen' AND rules_help NOT LIKE '%🧭%';

-- zich schamen
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: expresar vergüenza fuerte por algo que has hecho o que ha pasado. Ej.: te caes en público o metes la pata en una reunión → Ik schaam me dood! (¡qué vergüenza, me muero!). A un niño que se porta fatal: Schaam je!'
WHERE notes = 'Verbo reflexivo: zich schamen' AND rules_help NOT LIKE '%🧭%';

-- zich aankleden
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: decirle a alguien que se vista (rutina de mañana, prisas para salir). Ej.: por la mañana con los niños → Kleed je aan, we gaan zo naar school (vístete, nos vamos ya al cole). Para acostarse: zich uitkleden (desvestirse).'
WHERE notes = 'Verbo reflexivo: zich aankleden' AND rules_help NOT LIKE '%🧭%';

-- zich concentreren
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: quejarte de que no logras concentrarte por ruido o distracciones. Ej.: intentas estudiar y hay jaleo → Zet de tv uit, ik kan me niet concentreren (apaga la tele, no me puedo concentrar).'
WHERE notes = 'Verbo reflexivo: zich concentreren' AND rules_help NOT LIKE '%🧭%';

-- zich ontspannen
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: pedir o animar a relajarse. Con u es formal y tranquilizador (médico, fisio o masajista al cliente: Ontspant u zich maar). Ej. informal: estás nervioso por un examen y un compañero te dice → Ontspan je! Je kunt dit (¡relájate! tú puedes). Equivalentes: Rustig maar / Doe maar rustig aan.'
WHERE notes = 'Verbo reflexivo: zich ontspannen' AND rules_help NOT LIKE '%🧭%';

-- zich gedragen
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: pedir buen comportamiento, sobre todo a niños (o en broma a un adulto). Ej.: antes de entrar en casa ajena → Gedraag je bij oma! (pórtate bien en casa de la abuela). A secas, Gedraag je! = ¡compórtate!'
WHERE notes = 'Verbo reflexivo: zich gedragen' AND rules_help NOT LIKE '%🧭%';

-- zich afvragen
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: expresar una duda o pregunta interna, reflexionar en voz alta. Ej.: oyes un rumor y no te lo crees del todo → Ik vraag me af of het waar is (me pregunto si será verdad). Ik vraag me af waarom… = me pregunto por qué…'
WHERE notes = 'Verbo reflexivo: zich afvragen' AND rules_help NOT LIKE '%🧭%';

-- zich voorstellen
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: dos sentidos que el contexto aclara. (a) Presentarse a alguien nuevo (reunión, primer día): Mag ik me even voorstellen? Ik ben… (¿me presento? Soy…). (b) Imaginarse algo: Stel je voor! = ¡imagínate!'
WHERE notes = 'Verbo reflexivo: zich voorstellen' AND rules_help NOT LIKE '%🧭%';

-- zich bemoeien
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: decirle a alguien, con enfado, que no se meta en un asunto que no le incumbe (coloquial y fuerte). Ej.: alguien opina de tu vida sin que se lo pidan → Bemoei je er niet mee! (¡no te metas!) o Bemoei je met je eigen zaken! (métete en tus asuntos).'
WHERE notes = 'Verbo reflexivo: zich bemoeien' AND rules_help NOT LIKE '%🧭%';

-- zich verheugen
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: expresar ilusión por algo que va a pasar (algo más emotivo/formal que "tener ganas"). Ej.: al hablar de planes o cerrando un email → We verheugen ons op de vakantie (nos hace mucha ilusión las vacaciones). Coloquial equivalente: Ik kijk ernaar uit.'
WHERE notes = 'Verbo reflexivo: zich verheugen' AND rules_help NOT LIKE '%🧭%';

-- zich verslapen
UPDATE words_es
SET rules_help = rules_help || '

🧭 Cuándo usarlo: la excusa clásica por llegar tarde — te has quedado dormido / no sonó el despertador. Ej.: entras corriendo a la oficina → Sorry dat ik te laat ben, ik heb me verslapen (perdón por el retraso, me quedé dormido).'
WHERE notes = 'Verbo reflexivo: zich verslapen' AND rules_help NOT LIKE '%🧭%';
