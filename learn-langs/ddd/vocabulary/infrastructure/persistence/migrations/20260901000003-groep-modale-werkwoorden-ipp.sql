-- Learn Languages App - grupo nuevo de verbos modales y el doble infinitivo (IPP)
-- Migration: 20260901000003-groep-modale-werkwoorden-ipp.sql
-- Description: Eduardo (2026-09-01): «willen es un verbo muy peculiar, crea un grupo con willen,
--   con frases muy usadas en distintos tiempos y especificamente sobre esto: Ze heeft willen
--   afvallen. Nunca "heeft gewild afvallen". Dat heb ik nooit gewild. Aqui willen va solo, y
--   entonces si lleva participio. que descoloca bastante, aprovecha y mete los otros modales
--   kunnen, moeten, mogen y si hay alguno mas incluyelo».
--   Se crea el grupo «verbos modales - modale werkwoorden» con 4 tarjetas WORD (willen, kunnen,
--   moeten, mogen; ficha completa del verbo segun la normativa: tabla de 7 personas, participio y
--   auxiliar, preposicion, antonimo o su ausencia justificada, sustantivo derivado, expresion
--   hecha) y 16 SENTENCE muy usadas alternando presente, imperfecto, perfecto IPP y perfecto con
--   el modal solo. El fenomeno estrella va en un bloque 🎭 IDENTICO byte a byte en las 20
--   tarjetas: modal + infinitivo en perfecto = doble infinitivo (heeft willen afvallen), modal
--   solo = participio normal (heb gewild); zullen sin participio (zou/zouden); hoeven pierde el
--   te (Dat had je niet hoeven doen); y la familia IPP completa (laten, zien, horen, gaan, komen,
--   blijven, helpen). zullen y hoeven no se crean como WORD: ya viven en los grupos 8/14 (zullen)
--   y 22 (moeten of hoeven te); aqui solo se citan. 100% aditiva e idempotente (NOT EXISTS /
--   OR IGNORE).

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. El grupo
-- ==============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'verbos modales - modale werkwoorden', 'Los modales willen/kunnen/moeten/mogen en distintos tiempos y su fenomeno estrella: el doble infinitivo del perfecto (infinitivus pro participio) - Ze heeft willen afvallen, nunca «heeft gewild afvallen»; y el participio normal cuando el modal va solo (Dat heb ik nooit gewild). Con kunnen vs mogen (capacidad vs permiso), moeten vs hoeven, zullen sin participio y los otros verbos del doble infinitivo (laten, zien, horen, gaan, komen, blijven, helpen).', 'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'verbos modales - modale werkwoorden');

-- ==============================================================================
-- WORD: willen (querer)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'querer', 'WORD', 'modal: willen', 'willen = querer (voluntad, deseo). Es modal: lleva infinitivo desnudo, sin te — Ik wil afvallen, nunca «wil te afvallen».

📐 Conjugacion de willen (irregular, modal):

| persona | presente | imperfecto |
|---|---|---|
| ik | wil | wilde |
| jij / je | wil / wilt | wilde |
| u | wilt | wilde |
| hij / zij / het | wil | wilde |
| wij | willen | wilden |
| jullie | willen | wilden |
| zij (plural) | willen | wilden |

• participio — gewild, con hebben; solo aparece cuando willen va solo (ver el bloque del doble infinitivo).
• jij admite las dos formas, wil y wilt (unico verbo asi); al invertir, siempre sin -t: Wil je koffie?
• en el habla, el imperfecto wilde suena muchas veces wou (plural wouden): informal pero omnipresente.
• preposicion — no rige ninguna: modal con infinitivo desnudo u objeto directo (Ik wil koffie).
• antonimo — no tiene antonimo lexico claro: se niega (niet willen) o se salta a weigeren (negarse a), que es verbo pleno y si lleva te: Hij weigert te betalen.
• sustantivo derivado — de wil (la voluntad): tegen mijn wil — contra mi voluntad.
• no es separable.
• expresion hecha — Waar een wil is, is een weg. — Querer es poder.
• cortesia — «querria / me gustaria» = zou graag … willen: Ik zou graag een afspraak willen maken.

🗣️ Cinco usos, alternando tiempo y persona:

| uso | frase | traduccion |
|---|---|---|
| [can.] | Ik wil naar huis. | Quiero irme a casa. |
| [imperf.] | Ik wilde je nog bellen. | Aun queria llamarte. |
| [perf. IPP] | Ze heeft willen afvallen. | Ha querido adelgazar. |
| [perf. solo] | Dat heb ik nooit gewild. | Eso nunca lo he querido. |
| [vraag] | Willen jullie allebei koffie? | ¿Quereis cafe los dos? |

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'querer' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'querer' AND word_type = 'WORD' LIMIT 1),
    'nl_NL', 'willen', 'uillen', '• [can.] Ik wil naar huis. — Quiero irme a casa.
• [imperf.] Ik wilde je nog bellen. — Aun queria llamarte.
• [perf. IPP] Ze heeft willen afvallen. — Ha querido adelgazar.
• [perf. solo] Dat heb ik nooit gewild. — Eso nunca lo he querido.
• [vraag] Willen jullie allebei koffie? — ¿Quereis cafe los dos?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'querer' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'querer' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- WORD: kunnen (poder (capacidad), saber hacer)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'poder (capacidad), saber hacer', 'WORD', 'modal: kunnen', 'kunnen = poder (capacidad, posibilidad) y saber (habilidad aprendida): Ik kan zwemmen — se nadar. Modal con infinitivo desnudo. El permiso NO es kunnen: es mogen.

📐 Conjugacion de kunnen (irregular, modal):

| persona | presente | imperfecto |
|---|---|---|
| ik | kan | kon |
| jij / je | kunt / kan | kon |
| u | kunt / kan | kon |
| hij / zij / het | kan | kon |
| wij | kunnen | konden |
| jullie | kunnen | konden |
| zij (plural) | kunnen | konden |

• participio — gekund, con hebben; solo cuando kunnen va solo (bloque del doble infinitivo).
• al invertir, jij pierde la -t: Kun je me helpen?; kan je es la variante coloquial.
• solape — el presente plural kunnen es identico al infinitivo; el imperfecto se reconoce por la o: kon/konden.
• preposicion — no rige ninguna: modal con infinitivo desnudo.
• antonimo — no tiene: se niega con niet kunnen, que vale para «no poder» y para «no saber hacer».
• sustantivo derivado — de kunde (el saber hacer, formal: wiskunde, natuurkunde) y het kunnen (la capacidad).
• no es separable.
• expresion hecha — Dat kan gebeuren. — Son cosas que pasan. / Dat kan! — ¡Se puede, vale!
• kunnen vs mogen — Je kunt hier parkeren (es posible, cabe) ≠ Je mag hier niet parkeren (no esta permitido).

🗣️ Cinco usos, alternando tiempo y persona:

| uso | frase | traduccion |
|---|---|---|
| [can.] | Ik kan morgen niet. | Manana no puedo. |
| [imperf.] | Ik kon het niet vinden. | No podia encontrarlo. |
| [perf. IPP] | Ik heb niet kunnen slapen. | No he podido dormir. |
| [perf. solo] | Sorry, ik heb het echt niet gekund. | Perdona, de verdad que no he podido. |
| [vraag] | Kun je me helpen? | ¿Puedes ayudarme? |

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'poder (capacidad), saber hacer' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'poder (capacidad), saber hacer' AND word_type = 'WORD' LIMIT 1),
    'nl_NL', 'kunnen', 'kunnen', '• [can.] Ik kan morgen niet. — Manana no puedo.
• [imperf.] Ik kon het niet vinden. — No podia encontrarlo.
• [perf. IPP] Ik heb niet kunnen slapen. — No he podido dormir.
• [perf. solo] Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• [vraag] Kun je me helpen? — ¿Puedes ayudarme?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'poder (capacidad), saber hacer' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'poder (capacidad), saber hacer' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- WORD: moeten (deber, tener que)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'deber, tener que', 'WORD', 'modal: moeten', 'moeten = deber, tener que (obligacion). Modal con infinitivo desnudo. Su negacion util no es «moeten niet» sino niet hoeven te: no hacer falta.

📐 Conjugacion de moeten (irregular, modal):

| persona | presente | imperfecto |
|---|---|---|
| ik | moet | moest |
| jij / je | moet | moest |
| u | moet | moest |
| hij / zij / het | moet | moest |
| wij | moeten | moesten |
| jullie | moeten | moesten |
| zij (plural) | moeten | moesten |

• participio — gemoeten, con hebben; rarisimo: casi siempre hay un infinitivo detras y entra el doble infinitivo (heb moeten wachten).
• la raiz ya acaba en -t: jij moet no anade otra, y en la inversion no cambia nada: Moet je morgen werken?
• solape — presente plural moeten = infinitivo; el imperfecto lleva -s-: moest/moesten.
• preposicion — no rige ninguna; con un destino, el infinitivo de ir se sobreentiende: Ik moet naar de dokter — tengo que ir al medico.
• antonimo — niet hoeven te: Je hoeft niet te komen — no hace falta que vengas. Ojo: Je moet niet liegen no es «no tienes que», es «no debes» (prohibicion).
• sustantivo derivado — no tiene uno usual: la obligacion es de plicht (otra raiz).
• no es separable.
• expresion hecha — Als het moet, dan moet het. — Si toca, toca.
• hoeven, el gemelo negativo, tambien hace doble infinitivo y ademas pierde su te: Dat had je niet hoeven doen.

🗣️ Cinco usos, alternando tiempo y persona:

| uso | frase | traduccion |
|---|---|---|
| [can.] | Ik moet nu echt gaan. | Ahora si que me tengo que ir. |
| [imperf.] | Ik moest gisteren werken. | Ayer tuve que trabajar. |
| [perf. IPP] | Ik heb lang moeten wachten. | He tenido que esperar mucho rato. |
| [bijzin] | Hij weet dat hij zal moeten kiezen. | Sabe que tendra que elegir. |
| [vraag] | Moet je morgen werken? | ¿Tienes que trabajar manana? |

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'deber, tener que' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'deber, tener que' AND word_type = 'WORD' LIMIT 1),
    'nl_NL', 'moeten', 'muten', '• [can.] Ik moet nu echt gaan. — Ahora si que me tengo que ir.
• [imperf.] Ik moest gisteren werken. — Ayer tuve que trabajar.
• [perf. IPP] Ik heb lang moeten wachten. — He tenido que esperar mucho rato.
• [bijzin] Hij weet dat hij zal moeten kiezen. — Sabe que tendra que elegir.
• [vraag] Moet je morgen werken? — ¿Tienes que trabajar manana?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'deber, tener que' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'deber, tener que' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- WORD: mogen (poder (permiso), estar permitido)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'poder (permiso), estar permitido', 'WORD', 'modal: mogen', 'mogen = poder en el sentido de PERMISO (estar permitido); el poder-capacidad es kunnen. Modal con infinitivo desnudo.

📐 Conjugacion de mogen (irregular, modal):

| persona | presente | imperfecto |
|---|---|---|
| ik | mag | mocht |
| jij / je | mag | mocht |
| u | mag | mocht |
| hij / zij / het | mag | mocht |
| wij | mogen | mochten |
| jullie | mogen | mochten |
| zij (plural) | mogen | mochten |

• participio — gemogen, con hebben; solo cuando mogen va solo: Dat had niet gemogen.
• mag es invariable en todo el singular, tambien con u: u mag, sin -t. En plural, mogen.
• preposicion — no rige ninguna; quien da el permiso entra con van: Dat mag niet van mijn moeder — mi madre no me deja.
• antonimo — verbieden (prohibir): verboden te roken; en el dia a dia basta niet mogen: Dat mag niet.
• sustantivo derivado — no tiene uno usual: el permiso es de toestemming o de vergunning (otras raices).
• no es separable.
• expresion hecha — Mag ik even? — ¿Me permites un momento? / Dat mag niet. — Eso no esta permitido.
• segundo significado — mogen tambien es «caer bien»: Ik mag hem wel. — Me cae bien.

🗣️ Cinco usos, alternando tiempo y persona:

| uso | frase | traduccion |
|---|---|---|
| [can.] | Je mag hier niet parkeren. | Aqui no puedes aparcar. |
| [imperf.] | Ik mocht gisteren niet mee. | Ayer no me dejaron ir. |
| [perf. IPP] | Hij heeft niet mogen blijven. | No le han dejado quedarse. |
| [perf. solo] | Dat had niet gemogen. | Eso no se deberia haber permitido. |
| [vraag] | Mag ik je iets vragen? | ¿Puedo preguntarte algo? |

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'poder (permiso), estar permitido' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'poder (permiso), estar permitido' AND word_type = 'WORD' LIMIT 1),
    'nl_NL', 'mogen', 'mojen', '• [can.] Je mag hier niet parkeren. — Aqui no puedes aparcar.
• [imperf.] Ik mocht gisteren niet mee. — Ayer no me dejaron ir.
• [perf. IPP] Hij heeft niet mogen blijven. — No le han dejado quedarse.
• [perf. solo] Dat had niet gemogen. — Eso no se deberia haber permitido.
• [vraag] Mag ik je iets vragen? — ¿Puedo preguntarte algo?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'poder (permiso), estar permitido' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'poder (permiso), estar permitido' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ------------------------------------------------------------------ Ze heeft willen afvallen.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ella ha querido adelgazar.', 'SENTENCE', 'Ejemplo de "willen" (perf. IPP)', 'Doble infinitivo: willen lleva afvallen detras, asi que no va en participio — heeft willen afvallen, nunca «heeft gewild afvallen».

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ella ha querido adelgazar.' AND notes = 'Ejemplo de "willen" (perf. IPP)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ella ha querido adelgazar.' AND notes = 'Ejemplo de "willen" (perf. IPP)' LIMIT 1),
    'nl_NL', 'Ze heeft willen afvallen.', 'Se heft uillen affallen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ella ha querido adelgazar.' AND notes = 'Ejemplo de "willen" (perf. IPP)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ella ha querido adelgazar.' AND notes = 'Ejemplo de "willen" (perf. IPP)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'querer' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Ella ha querido adelgazar.' AND notes = 'Ejemplo de "willen" (perf. IPP)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Dat heb ik nooit gewild.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Eso nunca lo he querido.', 'SENTENCE', 'Ejemplo de "willen" (perf. solo)', 'Aqui willen va solo, sin infinitivo detras → participio normal gewild, con hebben.

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Eso nunca lo he querido.' AND notes = 'Ejemplo de "willen" (perf. solo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso nunca lo he querido.' AND notes = 'Ejemplo de "willen" (perf. solo)' LIMIT 1),
    'nl_NL', 'Dat heb ik nooit gewild.', 'Dat hep ik noit jeuilt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso nunca lo he querido.' AND notes = 'Ejemplo de "willen" (perf. solo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso nunca lo he querido.' AND notes = 'Ejemplo de "willen" (perf. solo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'querer' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Eso nunca lo he querido.' AND notes = 'Ejemplo de "willen" (perf. solo)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Ik wilde je nog bellen.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Aún quería llamarte.', 'SENTENCE', 'Ejemplo de "willen" (imperf.)', 'Imperfecto wilde: la forma mas natural para el pasado de los modales; en el habla suena a menudo wou.

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Aún quería llamarte.' AND notes = 'Ejemplo de "willen" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Aún quería llamarte.' AND notes = 'Ejemplo de "willen" (imperf.)' LIMIT 1),
    'nl_NL', 'Ik wilde je nog bellen.', 'Ik uilde ye noj belen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aún quería llamarte.' AND notes = 'Ejemplo de "willen" (imperf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aún quería llamarte.' AND notes = 'Ejemplo de "willen" (imperf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'querer' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Aún quería llamarte.' AND notes = 'Ejemplo de "willen" (imperf.)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Ik zou graag een afspraak willen maken.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me gustaría concertar una cita.', 'SENTENCE', 'Ejemplo de "willen" (cortesia)', 'La formula de cortesia zou graag + … + willen + infinitivo: «querria / me gustaria».

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me gustaría concertar una cita.' AND notes = 'Ejemplo de "willen" (cortesia)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me gustaría concertar una cita.' AND notes = 'Ejemplo de "willen" (cortesia)' LIMIT 1),
    'nl_NL', 'Ik zou graag een afspraak willen maken.', 'Ik sau jraj en afsprak uillen maken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me gustaría concertar una cita.' AND notes = 'Ejemplo de "willen" (cortesia)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me gustaría concertar una cita.' AND notes = 'Ejemplo de "willen" (cortesia)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'querer' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me gustaría concertar una cita.' AND notes = 'Ejemplo de "willen" (cortesia)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Ik heb niet kunnen slapen.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No he podido dormir.', 'SENTENCE', 'Ejemplo de "kunnen" (perf. IPP)', 'Doble infinitivo: kunnen lleva slapen detras → heb kunnen slapen, nunca «heb gekund slapen».

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No he podido dormir.' AND notes = 'Ejemplo de "kunnen" (perf. IPP)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No he podido dormir.' AND notes = 'Ejemplo de "kunnen" (perf. IPP)' LIMIT 1),
    'nl_NL', 'Ik heb niet kunnen slapen.', 'Ik hep nit kunnen slapen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No he podido dormir.' AND notes = 'Ejemplo de "kunnen" (perf. IPP)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No he podido dormir.' AND notes = 'Ejemplo de "kunnen" (perf. IPP)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'poder (capacidad), saber hacer' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'No he podido dormir.' AND notes = 'Ejemplo de "kunnen" (perf. IPP)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Sorry, ik heb het echt niet gekund.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Perdona, de verdad que no he podido.', 'SENTENCE', 'Ejemplo de "kunnen" (perf. solo)', 'kunnen va solo, sin infinitivo detras → participio normal gekund, con hebben.

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Perdona, de verdad que no he podido.' AND notes = 'Ejemplo de "kunnen" (perf. solo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Perdona, de verdad que no he podido.' AND notes = 'Ejemplo de "kunnen" (perf. solo)' LIMIT 1),
    'nl_NL', 'Sorry, ik heb het echt niet gekund.', 'Sorri, ik hep et ejt nit jekunt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Perdona, de verdad que no he podido.' AND notes = 'Ejemplo de "kunnen" (perf. solo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Perdona, de verdad que no he podido.' AND notes = 'Ejemplo de "kunnen" (perf. solo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'poder (capacidad), saber hacer' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Perdona, de verdad que no he podido.' AND notes = 'Ejemplo de "kunnen" (perf. solo)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Ik kon het niet vinden.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No podía encontrarlo.', 'SENTENCE', 'Ejemplo de "kunnen" (imperf.)', 'Imperfecto kon/konden: en pasado, el neerlandes prefiere kon a heeft kunnen.

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No podía encontrarlo.' AND notes = 'Ejemplo de "kunnen" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No podía encontrarlo.' AND notes = 'Ejemplo de "kunnen" (imperf.)' LIMIT 1),
    'nl_NL', 'Ik kon het niet vinden.', 'Ik kon et nit finden.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No podía encontrarlo.' AND notes = 'Ejemplo de "kunnen" (imperf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No podía encontrarlo.' AND notes = 'Ejemplo de "kunnen" (imperf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'poder (capacidad), saber hacer' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'No podía encontrarlo.' AND notes = 'Ejemplo de "kunnen" (imperf.)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Kun je me helpen?
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Puedes ayudarme?', 'SENTENCE', 'Ejemplo de "kunnen" (vraag)', 'Al invertir, jij pierde la -t: kun je, no «kunt je»; kan je es la variante coloquial.

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Puedes ayudarme?' AND notes = 'Ejemplo de "kunnen" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Puedes ayudarme?' AND notes = 'Ejemplo de "kunnen" (vraag)' LIMIT 1),
    'nl_NL', 'Kun je me helpen?', 'Kun ye me elpen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Puedes ayudarme?' AND notes = 'Ejemplo de "kunnen" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Puedes ayudarme?' AND notes = 'Ejemplo de "kunnen" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'poder (capacidad), saber hacer' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Puedes ayudarme?' AND notes = 'Ejemplo de "kunnen" (vraag)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Ik heb lang moeten wachten.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'He tenido que esperar mucho rato.', 'SENTENCE', 'Ejemplo de "moeten" (perf. IPP)', 'Doble infinitivo: moeten lleva wachten detras → heb moeten wachten, nunca «heb gemoeten wachten».

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'He tenido que esperar mucho rato.' AND notes = 'Ejemplo de "moeten" (perf. IPP)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'He tenido que esperar mucho rato.' AND notes = 'Ejemplo de "moeten" (perf. IPP)' LIMIT 1),
    'nl_NL', 'Ik heb lang moeten wachten.', 'Ik hep lang muten uajten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He tenido que esperar mucho rato.' AND notes = 'Ejemplo de "moeten" (perf. IPP)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He tenido que esperar mucho rato.' AND notes = 'Ejemplo de "moeten" (perf. IPP)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'deber, tener que' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'He tenido que esperar mucho rato.' AND notes = 'Ejemplo de "moeten" (perf. IPP)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Ik moest gisteren werken.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ayer tuve que trabajar.', 'SENTENCE', 'Ejemplo de "moeten" (imperf.)', 'Imperfecto moest: la forma normal del pasado de moeten.

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ayer tuve que trabajar.' AND notes = 'Ejemplo de "moeten" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer tuve que trabajar.' AND notes = 'Ejemplo de "moeten" (imperf.)' LIMIT 1),
    'nl_NL', 'Ik moest gisteren werken.', 'Ik must jisteren uerken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer tuve que trabajar.' AND notes = 'Ejemplo de "moeten" (imperf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer tuve que trabajar.' AND notes = 'Ejemplo de "moeten" (imperf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'deber, tener que' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Ayer tuve que trabajar.' AND notes = 'Ejemplo de "moeten" (imperf.)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Ik moet nu echt gaan.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ahora sí que me tengo que ir.', 'SENTENCE', 'Ejemplo de "moeten" (can.)', 'Presente moet + infinitivo desnudo al final: la despedida mas oida del neerlandes.

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ahora sí que me tengo que ir.' AND notes = 'Ejemplo de "moeten" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ahora sí que me tengo que ir.' AND notes = 'Ejemplo de "moeten" (can.)' LIMIT 1),
    'nl_NL', 'Ik moet nu echt gaan.', 'Ik mut nu ejt jan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ahora sí que me tengo que ir.' AND notes = 'Ejemplo de "moeten" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ahora sí que me tengo que ir.' AND notes = 'Ejemplo de "moeten" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'deber, tener que' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Ahora sí que me tengo que ir.' AND notes = 'Ejemplo de "moeten" (can.)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Dat had je niet hoeven doen.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No hacía falta que lo hicieras.', 'SENTENCE', 'Ejemplo de "hoeven" (IPP sin te)', 'hoeven, el gemelo negativo de moeten, tambien hace doble infinitivo y ademas pierde su te: had hoeven doen, no «had hoeven te doen» ni «gehoeven».

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No hacía falta que lo hicieras.' AND notes = 'Ejemplo de "hoeven" (IPP sin te)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No hacía falta que lo hicieras.' AND notes = 'Ejemplo de "hoeven" (IPP sin te)' LIMIT 1),
    'nl_NL', 'Dat had je niet hoeven doen.', 'Dat hat ye nit hufen dun.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No hacía falta que lo hicieras.' AND notes = 'Ejemplo de "hoeven" (IPP sin te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No hacía falta que lo hicieras.' AND notes = 'Ejemplo de "hoeven" (IPP sin te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'deber, tener que' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'No hacía falta que lo hicieras.' AND notes = 'Ejemplo de "hoeven" (IPP sin te)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Hij heeft niet mogen blijven.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No le han dejado quedarse.', 'SENTENCE', 'Ejemplo de "mogen" (perf. IPP)', 'Doble infinitivo: mogen lleva blijven detras → heeft mogen blijven, nunca «heeft gemogen blijven».

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No le han dejado quedarse.' AND notes = 'Ejemplo de "mogen" (perf. IPP)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No le han dejado quedarse.' AND notes = 'Ejemplo de "mogen" (perf. IPP)' LIMIT 1),
    'nl_NL', 'Hij heeft niet mogen blijven.', 'Ei heft nit mojen bleifen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No le han dejado quedarse.' AND notes = 'Ejemplo de "mogen" (perf. IPP)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No le han dejado quedarse.' AND notes = 'Ejemplo de "mogen" (perf. IPP)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'poder (permiso), estar permitido' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'No le han dejado quedarse.' AND notes = 'Ejemplo de "mogen" (perf. IPP)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Dat had niet gemogen.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Eso no se debería haber permitido.', 'SENTENCE', 'Ejemplo de "mogen" (perf. solo)', 'mogen va solo → participio normal gemogen. Frase hecha de reproche: dat had niet gemogen.

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Eso no se debería haber permitido.' AND notes = 'Ejemplo de "mogen" (perf. solo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso no se debería haber permitido.' AND notes = 'Ejemplo de "mogen" (perf. solo)' LIMIT 1),
    'nl_NL', 'Dat had niet gemogen.', 'Dat hat nit jemojen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso no se debería haber permitido.' AND notes = 'Ejemplo de "mogen" (perf. solo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso no se debería haber permitido.' AND notes = 'Ejemplo de "mogen" (perf. solo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'poder (permiso), estar permitido' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Eso no se debería haber permitido.' AND notes = 'Ejemplo de "mogen" (perf. solo)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Je mag hier niet parkeren.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Aquí no puedes aparcar.', 'SENTENCE', 'Ejemplo de "mogen" (can.)', 'Permiso → mogen. «Je kunt hier niet parkeren» diria que es fisicamente imposible, no que este prohibido.

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Aquí no puedes aparcar.' AND notes = 'Ejemplo de "mogen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí no puedes aparcar.' AND notes = 'Ejemplo de "mogen" (can.)' LIMIT 1),
    'nl_NL', 'Je mag hier niet parkeren.', 'Ye maj hir nit parkeren.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí no puedes aparcar.' AND notes = 'Ejemplo de "mogen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí no puedes aparcar.' AND notes = 'Ejemplo de "mogen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'poder (permiso), estar permitido' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Aquí no puedes aparcar.' AND notes = 'Ejemplo de "mogen" (can.)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ Ik mocht gisteren niet mee.
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ayer no me dejaron ir.', 'SENTENCE', 'Ejemplo de "mogen" (imperf.)', 'Imperfecto mocht + mee sin verbo: el infinitivo de movimiento (gaan) se sobreentiende tras los modales — mocht niet mee(gaan).

🎭 El participio fantasma de los modales (infinitivus pro participio):

En el perfecto, si el modal lleva OTRO infinitivo detras, el modal no va en participio: se disfraza de infinitivo y quedan dos infinitivos seguidos (hebben + modal + infinitivo).
• Ze heeft willen afvallen. — Ha querido adelgazar. (nunca «heeft gewild afvallen»)
• Ik heb niet kunnen slapen. — No he podido dormir. (nunca «heb gekund slapen»)
• Ik heb lang moeten wachten. — He tenido que esperar mucho rato. (nunca «heb gemoeten wachten»)
• Hij heeft niet mogen blijven. — No le han dejado quedarse. (nunca «heeft gemogen blijven»)

Si el modal va SOLO, sin infinitivo detras, entonces si usa su participio normal, siempre con hebben:
• Dat heb ik nooit gewild. — Eso nunca lo he querido.
• Sorry, ik heb het echt niet gekund. — Perdona, de verdad que no he podido.
• Dat had niet gemogen. — Eso no se deberia haber permitido.

🔑 El truco que casi nunca falla: cuenta los verbos que quedan al final de la frase. ¿Son DOS? → los dos en infinitivo (heeft willen afvallen). ¿Es UNO, el modal solo? → participio normal (heb gewild).

📌 Regla de bolsillo:
• modal + infinitivo, en perfecto → hebben + infinitivo + infinitivo: Ze heeft willen afvallen.
• modal solo, en perfecto → hebben + participio: Dat heb ik nooit gewild.
• zullen no juega: no tiene participio; su pasado es zou/zouden.
• en el habla, el imperfecto del modal es mas comun que su perfecto: Ze wilde afvallen se oye mas que Ze heeft willen afvallen.

⚠️ El mismo doble infinitivo lo hacen laten, zien, horen, gaan, komen, blijven y helpen (Ik heb hem zien lopen — Le he visto caminar), y hoeven ademas pierde su te: Dat had je niet hoeven doen — No hacia falta que lo hicieras.

🏋️ Ejercicio: completa el perfecto.
• Ik heb je niet ___ bellen. (kunnen)
• Dat hebben we nooit ___. (gewild)
• Ze heeft vroeg ___ opstaan. (moeten)
• Dat had niet ___. (gemogen)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ayer no me dejaron ir.' AND notes = 'Ejemplo de "mogen" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer no me dejaron ir.' AND notes = 'Ejemplo de "mogen" (imperf.)' LIMIT 1),
    'nl_NL', 'Ik mocht gisteren niet mee.', 'Ik mojt jisteren nit me.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer no me dejaron ir.' AND notes = 'Ejemplo de "mogen" (imperf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos modales - modale werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer no me dejaron ir.' AND notes = 'Ejemplo de "mogen" (imperf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'poder (permiso), estar permitido' AND word_type = 'WORD' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Ayer no me dejaron ir.' AND notes = 'Ejemplo de "mogen" (imperf.)' LIMIT 1),
    'EXAMPLE');
