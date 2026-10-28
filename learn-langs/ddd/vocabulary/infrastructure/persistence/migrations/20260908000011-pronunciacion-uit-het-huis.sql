-- Learn Languages App - Migration
-- Migration: 20260908000011-pronunciacion-uit-het-huis
-- Description: Eduardo: "en pronunciacion: Ik kom uit het huis".
--
--   Se añade la frase al grupo 33 (pronunciacion - palabras que se pegan al hablar),
--   porque encadena tres fenomenos de los que trata ese grupo y no habia ninguna tarjeta
--   que los juntara: la k de ik que se funde con la de kom, la t de uit que enlaza con la
--   vocal de het mientras la h de het se desvanece, y la h de huis que SI se pronuncia
--   porque ahi la palabra es tonica. Suena ik-KOM-eu-tet-HEUS.
--
--   ⚠️ HALLAZGO DE CODIGO que salio al preparar esta tarjeta y que no es de contenido:
--   DutchToSpanishPhoneticService tenia cuatro errores sistematicos, y como el slider y el
--   examen generan la pronunciacion NEERLANDESA al vuelo con ese servicio (ignorando la
--   columna words_lang.pronunciation, ver learn-langs-code §144), esos errores se veian en
--   TODAS las tarjetas. Los cuatro, ya corregidos fuera de esta migracion:
--     1. Borraba la h SIEMPRE (regla «h -> ""», con el comentario «h española muda»). La h
--        neerlandesa si se pronuncia, aspirada: hoort era «ort» y ahora es «hort».
--     2. ui -> au, confundiendola con ou. muis era «maus» y ahora es «meus».
--     3. No ensordecia la oclusiva final. goed era «jud» y ahora es «jut».
--     4. ng -> nj, cuando es /ŋ/. honger era «onjer» y ahora es «honger».
--   Verificado contra las 21 tarjetas del grupo 33, que estan escritas a mano y son la
--   referencia: antes coincidian 3 de 21 y ahora coinciden 12 de 21. La que queda lejos es
--   la 942, que hace una contraccion de FRASE (Hut-er-ok) y eso un servicio que va palabra
--   a palabra no puede reproducirlo.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. La tarjeta
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'salgo de casa', 'PHRASE', 'Pronunciacion: uit het huis',
'Ik kom uit het huis = salgo de casa. Por separado las cuatro palabras son faciles; juntas se traban, y por eso esta aqui: en esta frase se encadenan tres fenomenos distintos.

🔊 Como suena de verdad: ik-KOM-eu-tet-HEUS. Escrito a la española, Ik kom eut et heus.

🔗 Los tres enlaces, uno por uno:
• Ik kom — la k que cierra ik y la que abre kom se funden en UNA sola. No se dice ik-kom con dos golpes, sino i-KOM.
• uit het — la t de uit se pega a la vocal siguiente y la h de het se DESVANECE, porque het es atono. Queda eu-tet, como si fuera una palabra.
• het huis — aqui la h SI se pronuncia, aspirada, porque huis es tonico. HEUS.

⚠️ Y esa es la regla que ordena todo: la h neerlandesa se pronuncia siempre, MENOS en las palabras atonas de dentro de la frase. het, hem y un hij detras del verbo la pierden; huis, hond, hoor y honger la mantienen. No es como la h española, que es muda en todas partes.

📐 El diptongo ui, que aparece dos veces aqui (uit, huis), no suena au. Es un sonido entre la e y la o redondeada, y la aproximacion que usa el mazo es eu: eut, heus. No lo confundas con ou, que ese si es au: koud suena kaud.

📋 Mas cadenas del mismo tipo, para practicar el mismo gesto:
• Ik ga het huis uit. — Salgo de casa. (con el separable uitgaan partido)
• Ik kom uit Spanje. — Soy de España.
• Doe het licht uit. — Apaga la luz. (do-e-t-licht-eut)
• Ik heb het niet. — No lo tengo. (Ik hep et nit)

🏠 Y el matiz de vocabulario: Ik kom uit het huis es salir del edificio concreto. Para soy de aqui, de un pais o una ciudad, es Ik kom uit Spanje, sin articulo. Y para irse de casa en el sentido de salir a la calle, lo normal es Ik ga naar buiten of Ik ga de deur uit.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Pronunciacion: uit het huis');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE notes = 'Pronunciacion: uit het huis' LIMIT 1),
        'nl_NL', 'Ik kom uit het huis.', 'Ik kom eut et heus.');

-- =============================================================================
-- 2. Al grupo 33 y a generic
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, 33 FROM words_es we WHERE we.notes = 'Pronunciacion: uit het huis';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes = 'Pronunciacion: uit het huis' AND g.title = 'generic';
