-- Learn Languages App - Grupo "conjuncties": coordinantes vs subordinantes
-- Migration: 20260707000002-create-conjuncties-group.sql
-- Description: Crea el grupo "conjuncties" con las 5 coordinantes (en, maar,
--   of, want, dus: verbo en posicion 2) y las subordinantes mas usadas
--   (omdat, hoewel, als, dat, terwijl, zodat, toen: verbo al final).
--   Las rules_help incluyen la chuleta de formulas del orden de palabras:
--   TMP, V2, inversion, pregunta y parentesis verbal.
--   Idempotente. No toca ids existentes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'conjuncties',
    'Conjunciones: las 5 coordinantes (en, maar, of, want, dus -> verbo en posicion 2) frente a las subordinantes (omdat, hoewel, als, dat, terwijl, zodat, toen -> verbo al final), con las formulas del orden de palabras',
    'migracion'
);

-- ==============================================================================
-- 2. PALABRAS EN ESPAÑOL (solo si no existen)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes)
SELECT 'y', 'WORD', 'en: coordinante'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'y');

INSERT INTO words_es (text, word_type, notes)
SELECT 'pero', 'WORD', 'maar: coordinante'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pero');

INSERT INTO words_es (text, word_type, notes)
SELECT 'o', 'WORD', 'of: coordinante (y "si" indirecto: subordinante)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'o');

INSERT INTO words_es (text, word_type, notes)
SELECT 'pues, porque', 'PHRASE', 'want: coordinante, verbo en su sitio'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pues, porque');

INSERT INTO words_es (text, word_type, notes)
SELECT 'así que', 'PHRASE', 'dus: coordinante'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'así que');

INSERT INTO words_es (text, word_type, notes)
SELECT 'porque', 'WORD', 'omdat: subordinante, verbo al final'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'porque');

INSERT INTO words_es (text, word_type, notes)
SELECT 'aunque', 'WORD', 'hoewel: subordinante'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'aunque');

INSERT INTO words_es (text, word_type, notes)
SELECT 'si (condicional)', 'PHRASE', 'als: subordinante'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'si (condicional)');

INSERT INTO words_es (text, word_type, notes)
SELECT 'que (conjunción)', 'PHRASE', 'dat: subordinante'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'que (conjunción)');

INSERT INTO words_es (text, word_type, notes)
SELECT 'mientras', 'WORD', 'terwijl: subordinante'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'mientras');

INSERT INTO words_es (text, word_type, notes)
SELECT 'de modo que', 'PHRASE', 'zodat: subordinante'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'de modo que');

INSERT INTO words_es (text, word_type, notes)
SELECT 'cuando (pasado puntual)', 'PHRASE', 'toen: subordinante'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'cuando (pasado puntual)');

-- ==============================================================================
-- 3. TRADUCCIONES + 5 EJEMPLOS
-- ==============================================================================

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'y'),
    'nl_NL',
    'en',
    '• [can.] Ik drink koffie en zij drinkt thee. — Yo bebo café y ella bebe té.
• [can.] We gaan naar de markt en daarna naar huis. — Vamos al mercado y luego a casa.
• [vraag] Wil je kaas en brood? — ¿Quieres queso y pan?
• [vraag] En toen? — ¿Y entonces qué pasó?
• [bijzin] Hij zegt dat hij komt en dat hij eten meeneemt. — Dice que viene y que trae comida.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'pero'),
    'nl_NL',
    'maar',
    '• [can.] Het is koud, maar de zon schijnt. — Hace frío, pero brilla el sol.
• [can.] De weg voorlangs is korter, maar er is meer verkeer. — El camino por delante es más corto, pero hay más tráfico.
• [can.] Ik wil wel, maar ik kan niet. — Querer quiero, pero no puedo.
• [geb.] Kom maar binnen! — ¡Pasa, pasa! (ojo: aquí maar es partícula suavizadora, no "pero")
• [uitdr.] Maar goed... — En fin... (muletilla para cambiar de tema)'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'o'),
    'nl_NL',
    'of',
    '• [vraag] Wil je thee of koffie? — ¿Quieres té o café?
• [can.] We gaan morgen of overmorgen. — Vamos mañana o pasado mañana.
• [vraag] Kom je, of blijf je thuis? — ¿Vienes o te quedas en casa?
• [bijzin] Ik weet niet of hij komt. — No sé si viene (¡of = "si" indirecto es SUBORDINANTE: verbo al final!).
• [uitdr.] Nou en of! — ¡Ya lo creo!'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'pues, porque'),
    'nl_NL',
    'want',
    '• [can.] Ik blijf thuis, want het regent de hele dag. — Me quedo en casa, pues llueve todo el día (verbo en posición 2).
• [can.] Neem een jas mee, want het is koud buiten. — Llévate abrigo, que hace frío fuera.
• [can.] Ik ga slapen, want ik moet morgen vroeg op. — Me voy a dormir, que mañana madrugo.
• [can.] Hij is blij, want hij heeft de baan gekregen. — Está contento, pues ha conseguido el trabajo.
• [can.] Ze is moe, want ze heeft slecht geslapen. — Está cansada, pues ha dormido mal.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'así que'),
    'nl_NL',
    'dus',
    '• [can.] Het regent, dus we blijven thuis. — Llueve, así que nos quedamos en casa.
• [can.] Ik had honger, dus ik heb een broodje gekocht. — Tenía hambre, así que me compré un bocadillo.
• [vraag] Dus jij bent de nieuwe buurman? — ¿Así que tú eres el nuevo vecino?
• [can.] Dus dat was het idee. — Así que esa era la idea.
• [uitdr.] Dus ja... — Así que bueno... (muletilla)'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'porque'),
    'nl_NL',
    'omdat',
    '• [bijzin] Ik blijf thuis, omdat het de hele dag regent. — Me quedo en casa porque llueve todo el día (¡verbo al final!).
• [bijzin] Hij is moe, omdat hij vandaag hard heeft gewerkt. — Está cansado porque hoy ha trabajado duro (los dos verbos juntos al final).
• [bijzin] Ze leert Nederlands, omdat ze in Nederland woont. — Aprende neerlandés porque vive en Países Bajos.
• [inv.] Omdat het regent, blijven we thuis. — Como llueve, nos quedamos en casa (subordinada delante → inversión en la principal).
• [vraag] Waarom? Omdat het zo is! — ¿Por qué? ¡Porque sí!'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'aunque'),
    'nl_NL',
    'hoewel',
    '• [bijzin] De weg voorlangs is korter, hoewel er meer verkeer is. — El camino por delante es más corto, aunque hay más tráfico.
• [bijzin] Hoewel het regende, gingen we fietsen. — Aunque llovía, fuimos en bici (subordinada delante → inversión).
• [bijzin] Hij kwam, hoewel hij ziek was. — Vino, aunque estaba enfermo.
• [bijzin] Ik vind het lekker, hoewel het erg zoet is. — Me gusta, aunque es muy dulce.
• [uitdr.] Hoewel... — Aunque... (muletilla al dudar y repensarlo)'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'si (condicional)'),
    'nl_NL',
    'als',
    '• [bijzin] Als het regent, blijven we thuis. — Si llueve, nos quedamos en casa.
• [bijzin] Als je tijd hebt, bel me even. — Si tienes tiempo, llámame.
• [bijzin] Ik help je, als je het vraagt. — Te ayudo si lo pides.
• [bijzin] Als ik jou was, zou ik het doen. — Yo que tú, lo haría.
• [bijzin] Als kind woonde ik in Sevilla. — De niño vivía en Sevilla (als también = "de/como").'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'que (conjunción)'),
    'nl_NL',
    'dat',
    '• [bijzin] Ik denk dat het morgen regent. — Creo que mañana llueve.
• [bijzin] Ze zegt dat ze moe is. — Dice que está cansada.
• [bijzin] Het is jammer dat je niet kunt komen. — Es una pena que no puedas venir.
• [bijzin] Ik wist niet dat je in Haarlem woonde. — No sabía que vivías en Haarlem.
• [vraag] Weet je zeker dat het klopt? — ¿Estás seguro de que es correcto?'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'mientras'),
    'nl_NL',
    'terwijl',
    '• [bijzin] Ik kook, terwijl zij de tafel dekt. — Yo cocino mientras ella pone la mesa.
• [bijzin] Terwijl ik wachtte, las ik een boek. — Mientras esperaba, leía un libro.
• [bijzin] Hij belt, terwijl hij fietst. — Habla por teléfono mientras va en bici (estampa holandesa).
• [bijzin] Terwijl jij sliep, heb ik boodschappen gedaan. — Mientras dormías, hice la compra.
• [bijzin] Hij is lang, terwijl zijn broer klein is. — Él es alto, mientras que su hermano es bajito (contraste).'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'de modo que'),
    'nl_NL',
    'zodat',
    '• [bijzin] Spreek langzaam, zodat ik je kan verstaan. — Habla despacio, de modo que pueda entenderte.
• [bijzin] Ik schrijf het op, zodat ik het niet vergeet. — Lo apunto para que no se me olvide.
• [bijzin] Ze zet de wekker, zodat ze op tijd opstaat. — Pone el despertador para levantarse a tiempo.
• [bijzin] We vertrekken vroeg, zodat we de file vermijden. — Salimos pronto, así evitamos el atasco.
• [bijzin] Doe de deur dicht, zodat de kat niet ontsnapt. — Cierra la puerta, que no se escape el gato.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'cuando (pasado puntual)'),
    'nl_NL',
    'toen',
    '• [bijzin] Toen ik jong was, woonde ik in Sevilla. — Cuando era joven, vivía en Sevilla.
• [bijzin] Toen de trein aankwam, regende het. — Cuando llegó el tren, llovía.
• [bijzin] Ik sliep, toen je belde. — Dormía cuando llamaste.
• [bijzin] Als het regent, blijf ik thuis; toen het regende, bleef ik thuis. — als = presente/futuro; toen = pasado.
• [vraag] En toen? — ¿Y luego qué pasó? (toen adverbio = entonces)'
);

-- ==============================================================================
-- 4. ASOCIAR AL GRUPO "conjuncties" (y a "generic")
-- ==============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, (SELECT id FROM word_groups WHERE title = 'conjuncties')
FROM words_es we
WHERE we.text IN (
    'y', 'pero', 'o', 'pues, porque', 'así que', 'porque', 'aunque',
    'si (condicional)', 'que (conjunción)', 'mientras', 'de modo que',
    'cuando (pasado puntual)'
);

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, (SELECT id FROM word_groups WHERE title = 'generic')
FROM words_es we
WHERE we.text IN (
    'y', 'pero', 'o', 'pues, porque', 'así que', 'porque', 'aunque',
    'si (condicional)', 'que (conjunción)', 'mientras', 'de modo que',
    'cuando (pasado puntual)'
);

-- ==============================================================================
-- 5. REGLAS DE USO (boton de ayuda del Aprendizaje)
-- ==============================================================================

UPDATE words_es SET rules_help = 'CHULETA DEL ORDEN DE PALABRAS (las fórmulas):
F1 PRINCIPAL (TMP): Sujeto + V2 + Tiempo + Manera + Lugar
   Ik ga morgen met de fiets naar de markt.
F2 INVERSIÓN: X (tiempo/lugar) + V + Sujeto + resto
   Morgen ga ik met de fiets naar de markt.
F3 PREGUNTA sí/no: V1 + Sujeto + resto → Ga je morgen naar de markt?
F4 PARÉNTESIS VERBAL: aux en V2... participio/infinitivo AL FINAL
   Ik ben gisteren met de trein naar Utrecht gegaan.
F5 SUBORDINADA: conjunción + S + T + M + P + VERBO(S) AL FINAL
   ...omdat ik morgen met de fiets naar de markt ga.
EN es coordinante: une dos principales, cada una con su F1 normal.
Las 5 coordinantes (verbo en su sitio): EN, MAAR, OF, WANT, DUS.' WHERE text = 'y';

UPDATE words_es SET rules_help = 'MAAR = pero. COORDINANTE: verbo en posición 2 (fórmula F1), nada se mueve:
• ...maar er IS meer verkeer. (compara: hoewel er meer verkeer IS → al final)
Matiz vs hoewel: maar contrasta (pero), hoewel concede (aunque); maar es lo hablado.
¡Doble vida! maar átono = partícula suavizadora, no significa "pero":
• Kom maar binnen. — Pasa, pasa. · Doe maar. — Venga, hazlo. · Zullen we maar?
Refuerzo típico: maar + wel: ...maar er is WEL meer verkeer (pero eso sí...).' WHERE text = 'pero';

UPDATE words_es SET rules_help = 'OF tiene dos vidas MUY distintas:
1) COORDINANTE = «o» (verbo en su sitio): Wil je thee of koffie?
2) SUBORDINANTE = «si» de pregunta indirecta (¡verbo al final!):
   Ik weet niet of hij KOMT. — No sé si viene.
   Ze vroeg of ik tijd HAD. — Preguntó si tenía tiempo.
Truco: si tu «o» español es «si» (duda indirecta), el verbo se va al final.
Nou en of! = ¡ya lo creo! (frase hecha).' WHERE text = 'o';

UPDATE words_es SET rules_help = 'WANT = porque/pues. COORDINANTE: la frase sigue la fórmula F1,
verbo en posición 2: Ik blijf thuis, want het REGENT de hele dag.
Su gemelo subordinante es OMDAT (verbo al final): mismo significado,
distinta sintaxis. WANT no puede empezar la oración compuesta
(«Want het regent, ...» ✗); OMDAT sí (Omdat het regent, blijven we thuis).
En el habla, want es comodísimo: no te obliga a recolocar nada.' WHERE text = 'pues, porque';

UPDATE words_es SET rules_help = 'DUS = así que/por tanto. COORDINANTE: verbo en su sitio:
• Het regent, dus we blijven thuis. (también se oye «dus blijven we thuis», con inversión, ambas valen)
Muy usado como muletilla al hilar ideas: Dus ja... · Dus eh...
Y para confirmar conclusiones: Dus jij bent de nieuwe buurman?
Su primo subordinante es ZODAT (de modo que, verbo al final).' WHERE text = 'así que';

UPDATE words_es SET rules_help = 'OMDAT = porque. SUBORDINANTE: fórmula F5, verbo(s) AL FINAL:
• ...omdat het de hele dag REGENT. (compara want: ...want het REGENT de hele dag)
Con dos verbos, todos juntos al final: ...omdat hij hard HEEFT GEWERKT.
Subordinada delante → inversión en la principal (F2):
Omdat het regent, BLIJVEN WE thuis.
want/omdat: mismo significado; want no responde a «waarom?», omdat sí:
Waarom? Omdat het zo is! — ¡Porque sí!' WHERE text = 'porque';

UPDATE words_es SET rules_help = 'HOEWEL = aunque. SUBORDINANTE: verbo al final (F5):
• ...hoewel er meer verkeer IS.
Alternativa coordinante: maar (pero) — verbo en su sitio, más coloquial.
Hoewel delante → inversión en la principal: Hoewel het regende, GINGEN WE fietsen.
Sinónimos: ook al (+ frecuente en el habla: Ook al is het duur, ik koop het)
y al (con inversión propia: Al is er meer verkeer...).
Solo, como muletilla: Hoewel... — Aunque, pensándolo bien...' WHERE text = 'aunque';

UPDATE words_es SET rules_help = 'ALS = si (condicional). SUBORDINANTE: verbo al final:
• Als het REGENT, blijven we thuis. (subordinada delante → inversión después)
Tres vidas de als:
1) si condicional: Als je tijd hebt... · Als ik jou was, zou ik...
2) cuando (presente/futuro/habitual): Als ik thuiskom, eet ik. — Cuando llego a casa...
3) como/de (rol): Als kind woonde ik daar. — De niño vivía allí.
Para «cuando» en pasado puntual NO uses als: usa TOEN.' WHERE text = 'si (condicional)';

UPDATE words_es SET rules_help = 'DAT = que (conjunción). SUBORDINANTE: verbo al final:
• Ik denk dat het morgen REGENT. — Creo que mañana llueve.
Es la subordinante más frecuente del idioma: tras denken, zeggen, weten,
hopen, vinden... En el habla a veces se omite en español pero NUNCA en neerlandés.
No confundir con dat demostrativo (eso/ese): Dat is mooi. — Eso es bonito.
Tras alles/iets/niets el relativo es WAT, no dat: alles WAT je zegt.' WHERE text = 'que (conjunción)';

UPDATE words_es SET rules_help = 'TERWIJL = mientras. SUBORDINANTE: verbo al final:
• Ik kook, terwijl zij de tafel DEKT.
Dos usos:
1) simultaneidad: Terwijl ik wachtte, las ik een boek.
2) contraste (mientras que): Hij is lang, terwijl zijn broer klein is.
Con sustantivo se usa tijdens (durante): tijdens het eten — durante la comida.' WHERE text = 'mientras';

UPDATE words_es SET rules_help = 'ZODAT = de modo que / para que (resultado). SUBORDINANTE: verbo al final:
• Spreek langzaam, zodat ik je kan VERSTAAN.
zodat (resultado/consecuencia) vs om te + infinitivo (finalidad, mismo sujeto):
• Ik schrijf het op om het niet te vergeten. — para no olvidarlo (yo mismo)
• Ik schrijf het op, zodat jij het weet. — para que TÚ lo sepas (otro sujeto → zodat)
Su primo coordinante es dus (así que, verbo en su sitio).' WHERE text = 'de modo que';

UPDATE words_es SET rules_help = 'TOEN = cuando (UNA vez, en pasado). SUBORDINANTE: verbo al final:
• Toen ik jong WAS, woonde ik in Sevilla.
El reparto de «cuando»:
• pasado puntual/único → TOEN: Toen de trein aankwam...
• presente, futuro o hábito (incluso en pasado repetido) → ALS: Als ik thuiskom...
• pregunta ¿cuándo? → WANNEER: Wanneer kom je?
Ojo: toen adverbio = entonces/luego: En toen? — ¿Y luego qué?' WHERE text = 'cuando (pasado puntual)';
