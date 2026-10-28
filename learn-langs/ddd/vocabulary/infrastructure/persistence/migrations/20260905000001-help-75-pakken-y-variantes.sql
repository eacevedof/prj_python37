-- Learn Languages App - Migration
-- Migration: 20260905000001-help-75-pakken-y-variantes
-- Description: Eduardo pregunta "en 75 ayuda de pakken y sus variantes cuando se usa".
--   La 75 es "la frasada" = de deken, y sus cinco frases de notes se construyen con
--   pakken (Ik pak een deken / pak een deken) y con meenemen, pero la tarjeta no tenia
--   NINGUNA ayuda (rules_help a NULL). Se escribe la ayuda entera con el mapa completo de
--   "coger": pakken frente a nemen (la duda de verdad: pakken es la mano que se cierra,
--   nemen es el "tomar" abstracto que no se suelta en las expresiones hechas), y las
--   variantes con particula (oppakken, oprapen, vastpakken, afpakken, inpakken, uitpakken,
--   aanpakken, meenemen, verpakken) mas el rival grijpen. Ficha completa del verbo segun
--   la norma: regimen, tabla de conjugacion de 7 personas, participio + auxiliar, las
--   cuatro posiciones del separable, el inseparable verpakken sin ge-, sustantivos
--   derivados con su articulo, expresiones hechas, regla de bolsillo y ejercicio.
--   Como el antonimo de pakken es loslaten y la norma pide que el antonimo entre como
--   tarjeta examinable con al menos una frase propia, se crean tambien:
--     - WORD     "soltar" = loslaten (grupo 21 verbos separables + generic), con ficha.
--     - SENTENCE "Suelta mi mano, por favor." = Laat mijn hand los, alsjeblieft.
--       colgada de "soltar" con relacion EXAMPLE.
--   Coordinada con la tarjeta 661 (migracion 20260810000007), que ya fija el reparto
--   oprapen (del suelo) / oppakken (agarrar y levantar) / pakken-nemen (general) /
--   opnemen (el telefono, y nunca un objeto). Esta ayuda respeta ese reparto, incluye
--   oprapen en el mapa y remite a la 661 para opnemen, para no dar dos reglas distintas
--   del mismo fenomeno.
--   Pendiente (no entra aqui): pakken no existe como tarjeta WORD propia; si se quiere
--   examinable, merece grupo propio "variantes de coger - pakken nemen grijpen vatten",
--   al estilo del grupo 24 (variantes de poner).

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. Ayuda de la 75 (de deken): pakken y sus variantes
--    rules_help esta a NULL, asi que se escribe entera (nunca con ||, que sobre
--    NULL devuelve NULL). El guard IS NULL la hace idempotente.
-- =============================================================================
UPDATE words_es
SET rules_help = 'de deken = la manta. Es palabra de: de deken, plural de dekens, diminutivo het dekentje. Sus frases se construyen con pakken, el verbo de coger con la mano, y ese es el mapa que va debajo.
🗺️ Coger, segun que cojas y como:

| que haces | verbo | ejemplo |
|---|---|---|
| cierras la mano sobre algo fisico | **pakken** | Ik **pak** een deken. |
| tomas algo, en sentido amplio y abstracto | **nemen** | Ik **neem** de trein. |
| lo agarras y lo levantas con la mano | **oppakken** | **Pak** de doos **op**. |
| lo recoges del suelo, se habia caido | **oprapen** | Ik **raapte** de pen **op**. |
| lo agarras fuerte y no lo sueltas | **vastpakken** | **Pak** het touw goed **vast**. |
| se lo quitas a alguien | **afpakken** | Ze **pakken** hem zijn telefoon **af**. |
| lo metes en la maleta o en papel | **inpakken** | Ik **pak** mijn koffer **in**. |
| lo sacas de su envoltorio | **uitpakken** | De kinderen **pakken** de cadeaus **uit**. |
| te enfrentas a un asunto, lo abordas | **aanpakken** | We moeten dit anders **aanpakken**. |
| te lo llevas contigo | **meenemen** | Ik **neem** een deken **mee**. |
| lo envasas de fabrica | **verpakken** | Het is in plastic **verpakt**. |
| lo agarras de golpe y con fuerza | **grijpen** | Hij **greep** mijn arm. |

Los tres que vas a usar de verdad: pakken para la mano, nemen para lo abstracto y oprapen para lo que se ha caido al suelo.

📌 Regla de bolsillo:
• Hay una mano que se cierra sobre algo fisico → pakken.
• Es "tomar" en sentido amplio: transporte, decision, descanso, ducha, clase → nemen.
• Esta en el SUELO porque se cayo → oprapen.
• Lo agarras y lo levantas, este donde este → oppakken.
• Lo que "coges" es un problema o una tarea → aanpakken.
• Te lo llevas contigo a otro sitio → meenemen.
• Es el telefono lo que coges → opnemen, y ningun otro. Mapa completo en la tarjeta 661.

🔑 El truco que casi nunca falla: Cambia "coger" por "agarrar con la mano". Si sigue sonando bien, es pakken; si te pide "tomar", es nemen. Ik pak een deken (la agarras del sofa) frente a Ik neem de trein (ningun tren se agarra con la mano).

⚠️ Donde nemen NO se puede sustituir por pakken, aunque en la calle oigas pakken para casi todo: een beslissing nemen (tomar una decision), pauze nemen (hacer una pausa), de tijd nemen (tomarse su tiempo), een douche nemen (ducharse), afscheid nemen (despedirse). Son expresiones hechas y ahi manda nemen.

📊 Conjugacion de pakken (debil, NO separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | pak | pakte |
| jij / je | pakt | pakte |
| u | pakt | pakte |
| hij / zij / het | pakt | pakte |
| wij | pakken | pakten |
| jullie | pakken | pakten |
| zij (plural) | pakken | pakten |

• participio — gepakt, y el auxiliar es hebben: Ik heb een deken gepakt.
• preposicion — pakken no rige ninguna: es transitivo directo. La unica colocacion fija es con parte del cuerpo, y ahi entra bij: Hij pakte me bij mijn arm (me cogio del brazo).
• al invertir, jij pierde la -t: Pak jij een deken? — nunca "pakt jij". Y u no la pierde jamas: Pakt u een deken?
• imperativo — Pak een deken! y en formal Pakt u een deken.
• el imperfecto plural (wij pakten) y el participio (gepakt) no se parecen, asi que aqui no hay el solape tipico de los verbos fuertes.

📐 Un separable, en sus cuatro sitios (con oppakken):

| donde | que pasa | ejemplo |
|---|---|---|
| principal | la particula se va **al final** | Hij **pakt** de krant **op**. |
| perfecto | el ge- se cuela **dentro** | Hij heeft de krant **opgepakt**. |
| subordinada | las piezas **se reunen y se escriben juntas** | … omdat hij de krant **oppakt**. |
| con te | el te va **en medio** | Hij probeert de krant **op te pakken**. |

Vale igual para inpakken, uitpakken, afpakken, vastpakken, aanpakken, oprapen y meenemen: ingepakt, uitgepakt, afgepakt, vastgepakt, aangepakt, opgeraapt, meegenomen.

⚠️ verpakken es la excepcion: ver- es prefijo atono inseparable, asi que ni se separa ni lleva ge-. Het is verpakt, nunca "geverpakt" ni "Hij pakt het ver".

📦 Los sustantivos que salen de aqui, con su articulo:
• het pak — el traje, y tambien el paquete grande: een pak melk (un carton de leche).
• het pakje — el paquete pequeño: een pakje sigaretten.
• de verpakking — el envase, el embalaje.
• de aanpak — el enfoque, la manera de abordar algo: een harde aanpak.
• de pakkans — la probabilidad de que te pillen.

🔁 El antonimo, loslaten: Soltar, dejar de sujetar. Tambien es separable — ik laat los, ik heb losgelaten, om los te laten. Pak mijn hand (cogeme la mano) ↔ Laat mijn hand los (sueltame la mano). Esta en el mazo como tarjeta propia.

💬 Tres cosas que se oyen de verdad:
• Pak aan! — ¡Toma! (al darle algo a alguien en la mano).
• Dat pakt goed uit. — Eso sale bien, sale redondo. Aqui uitpakken no es desempaquetar sino resultar.
• de draad weer oppakken — retomar el hilo, volver a lo que dejaste a medias.

⚠️ pakken tiene una segunda vida coloquial: pillar. De politie heeft hem gepakt (la policia lo pillo), Ik ben gepakt (me han pillado). De ahi sale de pakkans. Y oppakken hace lo mismo en registro policial, detener: De politie heeft de dader opgepakt. Con una tarea, oppakken es asumirla: een taak oppakken. Por el contexto se distingue, pero la primera vez descoloca.

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandes | español |
|---|---|---|
| presente · ik | Ik pak een deken voor op de bank. | Cojo una manta para el sofa. |
| imperativo · jij | Vanavond is het koud, dus pak een deken. | Esta noche hace frio, asi que coge una manta. |
| perfecto · ik | Ik heb de deken over de baby gelegd. | He puesto la manta sobre el bebe. |
| pregunta · je | Wil je een extra deken? | ¿Quieres una manta extra? |
| subordinada · ik | Ik neem een deken mee, omdat het in het park fris wordt. | Me llevo una manta porque en el parque refresca. |

⚠️ Fijate en la tercera y en la quinta, que no llevan pakken. En la tercera la manta se coloca extendida sobre el bebe: eso es leggen (poner tumbado), no pakken. Y en la quinta te la llevas al parque: meenemen, mee + nemen, porque el foco no es agarrarla sino trasladarla.

🛏️ La familia de la cama, ya que estamos, con su articulo:
• het dekbed — el edredon.
• het laken — la sabana.
• de sloop — la funda de almohada.
• het kussen — la almohada.
• de matras — el colchon, aunque el Groene Boekje admite tambien het matras.

🏋️ Ejercicio: Elige el verbo.
• ___ jij even een stoel? — coge una silla. (Respuesta: Pak.)
• Ik moet een beslissing ___. — tomar una decision. (Respuesta: nemen.)
• Hij heeft de krant van de grond ___. — la ha recogido del suelo. (Respuesta: opgeraapt. Del suelo es oprapen, no oppakken.)
• We moeten dit probleem anders ___. — abordarlo de otra manera. (Respuesta: aanpakken.)
• Het cadeau is mooi ___. — viene bien envuelto. (Respuesta: ingepakt.)'
WHERE id = 75
  AND rules_help IS NULL;

-- =============================================================================
-- 2. El antonimo como tarjeta examinable: soltar = loslaten
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'soltar', 'WORD', 'antonimo de pakken (75)',
'loslaten = soltar, dejar de sujetar. Separable (los + laten) y fuerte: loslaten – liet los – heeft losgelaten. Es el antonimo de pakken y de vasthouden.
📌 Regla de bolsillo:
• Dejas de sujetar con la mano lo que tenias cogido → loslaten.
• Sueltas un animal o a alguien para que corra libre → loslaten, y con destinatario, loslaten OP: Ze lieten de honden op hem los.
• Sueltas informacion, cuentas algo → tambien loslaten: Hij liet niets los.
• Lo contrario, seguir sujetando → vasthouden; y agarrarlo fuerte, vastpakken.

🔑 El truco que casi nunca falla: Los es "suelto" como adjetivo (de hond is los, el perro anda suelto; losse blaadjes, hojas sueltas). Asi que loslaten es literalmente "dejar suelto": si puedes decir "dejar suelto" en español, es loslaten.

📊 Conjugacion de loslaten (fuerte, separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | laat los | liet los |
| jij / je | laat los | liet los |
| u | laat los | liet los |
| hij / zij / het | laat los | liet los |
| wij | laten los | lieten los |
| jullie | laten los | lieten los |
| zij (plural) | laten los | lieten los |

• participio — losgelaten, con hebben: Ik heb het touw losgelaten. El ge- se cuela dentro, como en todo separable.
• ojo con jij, que aqui NO añade -t: la raiz ya acaba en t (laat), asi que es jij laat los, nunca "jij laatt los".
• preposicion — transitivo directo, sin preposicion fija. Solo con destinatario aparece op: iets of iemand loslaten OP iemand.
• imperativo — Laat los! y en formal Laat u het maar los.

📐 Un separable, en sus cuatro sitios:

| donde | que pasa | ejemplo |
|---|---|---|
| principal | la particula se va **al final** | Ik **laat** je hand **los**. |
| perfecto | el ge- se cuela **dentro** | Ik heb je hand **losgelaten**. |
| subordinada | las piezas **se reunen y se escriben juntas** | … omdat ik je hand **loslaat**. |
| con te | el te va **en medio** | Ik probeer je hand **los te laten**. |

📦 Los sustantivos y el adjetivo de esta familia, con su articulo:
• het loslaten — el hecho de soltar (infinitivo sustantivado, siempre het): het loslaten valt me zwaar.
• los — suelto, como adjetivo: een losse knoop (un boton suelto), de hond is los.
• de losprijs — el rescate (lo que se paga para que suelten a alguien).

💬 Dos cosas que se oyen de verdad:
• Laat maar los! — ¡Suelta ya! o ¡Dejalo estar!, segun el contexto.
• Hij liet niets los. — No solto prenda. Es la acepcion de soltar informacion, muy usada.

🗣️ Cinco usos, alternando tiempo y persona:

| tiempo y persona | neerlandes | español |
|---|---|---|
| presente · ik | Ik laat je hand nooit los. | Nunca te suelto la mano. |
| imperativo · jij | Laat de hond even los in het park. | Suelta al perro un rato en el parque. |
| perfecto · hij | Hij heeft het touw te vroeg losgelaten. | Solto la cuerda demasiado pronto. |
| imperfecto · hij | Hij liet niets los over zijn plannen. | No solto prenda sobre sus planes. |
| subordinada · ik | Ik blijf staan, omdat ik het stuur niet durf los te laten. | Me quedo quieto porque no me atrevo a soltar el manillar. |

🏋️ Ejercicio: "sueltame el brazo" → ___ mijn arm ___. (Respuesta: Laat … los.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'soltar');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'soltar' LIMIT 1),
    'nl_NL',
    'loslaten',
    'los-laaten',
    '• [can.] Ik laat je hand nooit los. — Nunca te suelto la mano.
• [geb.] Laat de hond even los in het park. — Suelta al perro un rato en el parque.
• [perf.] Hij heeft het touw te vroeg losgelaten. — Solto la cuerda demasiado pronto.
• [uitdr.] Hij liet niets los over zijn plannen. — No solto prenda sobre sus planes.
• [bijzin] Ik blijf staan, omdat ik het stuur niet durf los te laten. — Me quedo quieto porque no me atrevo a soltar el manillar.'
);

-- grupo tematico (21 - verbos separables) + generic (1)
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'soltar' LIMIT 1),
        (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'soltar' LIMIT 1),
        (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 3. Al menos una frase examinable del antonimo, colgada de su palabra madre
-- =============================================================================
INSERT INTO words_es (text, word_type, notes)
SELECT 'Suelta mi mano, por favor.', 'SENTENCE', 'Ejemplo de "loslaten" (geb.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
                  WHERE text = 'Suelta mi mano, por favor.'
                    AND notes = 'Ejemplo de "loslaten" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'Suelta mi mano, por favor.'
                               AND notes = 'Ejemplo de "loslaten" (geb.)' LIMIT 1),
    'nl_NL',
    'Laat mijn hand los, alsjeblieft.',
    'laat main hant los, alsjebliift',
    'Imperativo de un separable: la particula los se va al final de la frase.'
);

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Suelta mi mano, por favor.'
                                   AND notes = 'Ejemplo de "loslaten" (geb.)' LIMIT 1),
        (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Suelta mi mano, por favor.'
                                   AND notes = 'Ejemplo de "loslaten" (geb.)' LIMIT 1),
        (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'soltar' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Suelta mi mano, por favor.'
                                   AND notes = 'Ejemplo de "loslaten" (geb.)' LIMIT 1),
        'EXAMPLE');
