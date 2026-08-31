-- Learn Languages App - Bloque compartido: la -e del adjetivo (duda de la 856)
-- Migration: 20260831000005-help-block-adjectief-e.sql
-- Description: Eduardo, sobre la 856 («Ze heeft naar het verkeerde document verwezen»):
--   «¿por que "het verkeerde document" si es "het"?». La media regla que tenia aprendida
--   («los het-woorden no llevan -e») solo vale con INDEFINIDO: la -e se cae unicamente
--   cuando se juntan las DOS condiciones, het-woord Y een/geen/veel/elk/nada. Con articulo
--   definido, posesivo o demostrativo, la -e se queda. Bloque 🔤 IDENTICO byte a byte con la
--   tabla de las cuatro casillas, las otras dos posiciones sin -e (predicado tras
--   zijn/worden/blijven/vinden, y los adjetivos en -en que no se flexionan nunca: open, eigen,
--   houten), la prueba del plural (todos los plurales llevan de, asi que het bestand ->
--   een oud bestand pero de oude bestanden) y el arbol de decision en dos preguntas.
--   Va a las 12 tarjetas del mazo donde el fenomeno es visible, incluidas las que lo muestran
--   por el lado contrario: 131 (een goed idee, la casilla sin -e), 128 (de open haard) y 873
--   (zijn eigen kastje) por los adjetivos en -en, 531 y 900 por el predicado, 832 por el plural.
--   Seis de ellas (35, 39, 128, 131, 832, 856) tenian rules_help a NULL — un || sobre NULL da
--   NULL y se quedarian fuera en silencio —, asi que se les crea la ayuda entera con
--   explicacion propia. 100% aditiva e idempotente (guard por marca y por rules_help IS NULL).

-- ==============================================================================
-- 1. Tarjetas que YA tienen ayuda: el bloque se anade al final
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🔤 La -e del adjetivo: cuatro casillas y solo UNA se salva
El adjetivo delante del sustantivo lleva -e casi siempre. La unica casilla que se queda sin -e es la de het-woord + indefinido:

| | de-woord | het-woord |
|---|---|---|
| **definido** (de/het, mijn, dit, dat) | de grote tafel | het verkeerde document |
| **indefinido** (een, geen, veel, elk, nada) | een grote tafel | een verkeerd document |

📌 Regla de bolsillo, la que hay que retener: la -e solo se cae cuando se juntan las DOS condiciones a la vez, het-woord Y indefinido. Con una sola de las dos, la -e se queda. Por eso «het verkeerde document» la lleva (het-woord, si, pero definido) y «een verkeerd document» no.

⚠️ Otras dos veces en que no aparece, que no son excepciones sino otro sitio distinto:
• En PREDICADO, detras de zijn, worden, blijven o vinden, el adjetivo no se flexiona nunca. Het document is verkeerd. · Jullie zullen het leuk vinden.
• Los adjetivos acabados en -en no se flexionan jamas: open, eigen, tevreden, houten, gouden. De open haard. · Elk kind heeft zijn eigen kastje.

🌿 El plural lo resuelve solo, y es la mejor prueba de la regla: todos los plurales llevan de, asi que en plural SIEMPRE hay -e. Por eso «het bestand» hace «een oud bestand» sin -e en singular indefinido, pero «de oude bestanden» con -e en cuanto pasa a plural.

🔁 Los antonimos de los adjetivos que salen en estas tarjetas, que es como mejor se fijan: groot ↔ klein · oud ↔ nieuw · open ↔ dicht (o gesloten) · goed ↔ slecht · verkeerd ↔ juist.

🌳 El arbol de decision, en dos preguntas:
1. ¿El adjetivo va delante del sustantivo? Si no va delante, no lleva -e (es predicado) y ya no hay nada que decidir.
2. Si va delante, ¿el sustantivo es het-woord Y el determinante es indefinido? Solo si las dos respuestas son que si, va sin -e. En cualquier otro caso, con -e.',
    updated_at = datetime('now')
WHERE id IN (490, 531, 718, 873, 900, 918)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🔤 La -e del adjetivo%';

-- ==============================================================================
-- 2. Tarjeta 35: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'de grote teen = el dedo gordo del pie, literalmente «el dedo grande». «teen» es de-woord (de teen) y ademas va con articulo definido, asi que grote lleva -e por partida doble. Ojo al reparto que el espanol no hace: de teen es solo el dedo DEL PIE y de vinger el de la mano — «dedo» a secas no existe en neerlandes. Antonimo del adjetivo: groot ↔ klein, que es justo la tarjeta de al lado (de kleine teen). El plural es de tenen y el pie entero es de voet.

🔤 La -e del adjetivo: cuatro casillas y solo UNA se salva
El adjetivo delante del sustantivo lleva -e casi siempre. La unica casilla que se queda sin -e es la de het-woord + indefinido:

| | de-woord | het-woord |
|---|---|---|
| **definido** (de/het, mijn, dit, dat) | de grote tafel | het verkeerde document |
| **indefinido** (een, geen, veel, elk, nada) | een grote tafel | een verkeerd document |

📌 Regla de bolsillo, la que hay que retener: la -e solo se cae cuando se juntan las DOS condiciones a la vez, het-woord Y indefinido. Con una sola de las dos, la -e se queda. Por eso «het verkeerde document» la lleva (het-woord, si, pero definido) y «een verkeerd document» no.

⚠️ Otras dos veces en que no aparece, que no son excepciones sino otro sitio distinto:
• En PREDICADO, detras de zijn, worden, blijven o vinden, el adjetivo no se flexiona nunca. Het document is verkeerd. · Jullie zullen het leuk vinden.
• Los adjetivos acabados en -en no se flexionan jamas: open, eigen, tevreden, houten, gouden. De open haard. · Elk kind heeft zijn eigen kastje.

🌿 El plural lo resuelve solo, y es la mejor prueba de la regla: todos los plurales llevan de, asi que en plural SIEMPRE hay -e. Por eso «het bestand» hace «een oud bestand» sin -e en singular indefinido, pero «de oude bestanden» con -e en cuanto pasa a plural.

🔁 Los antonimos de los adjetivos que salen en estas tarjetas, que es como mejor se fijan: groot ↔ klein · oud ↔ nieuw · open ↔ dicht (o gesloten) · goed ↔ slecht · verkeerd ↔ juist.

🌳 El arbol de decision, en dos preguntas:
1. ¿El adjetivo va delante del sustantivo? Si no va delante, no lleva -e (es predicado) y ya no hay nada que decidir.
2. Si va delante, ¿el sustantivo es het-woord Y el determinante es indefinido? Solo si las dos respuestas son que si, va sin -e. En cualquier otro caso, con -e.',
    updated_at = datetime('now')
WHERE id = 35
  AND rules_help IS NULL;

-- ==============================================================================
-- 3. Tarjeta 39: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'de kleine teen = el dedo pequeno del pie, el menique del pie. Mismo caso que su hermano el dedo gordo (de grote teen): de-woord con articulo definido, asi que kleine con -e. Antonimo del adjetivo: klein ↔ groot. El plural es de tenen, y el pie entero es de voet.

🔤 La -e del adjetivo: cuatro casillas y solo UNA se salva
El adjetivo delante del sustantivo lleva -e casi siempre. La unica casilla que se queda sin -e es la de het-woord + indefinido:

| | de-woord | het-woord |
|---|---|---|
| **definido** (de/het, mijn, dit, dat) | de grote tafel | het verkeerde document |
| **indefinido** (een, geen, veel, elk, nada) | een grote tafel | een verkeerd document |

📌 Regla de bolsillo, la que hay que retener: la -e solo se cae cuando se juntan las DOS condiciones a la vez, het-woord Y indefinido. Con una sola de las dos, la -e se queda. Por eso «het verkeerde document» la lleva (het-woord, si, pero definido) y «een verkeerd document» no.

⚠️ Otras dos veces en que no aparece, que no son excepciones sino otro sitio distinto:
• En PREDICADO, detras de zijn, worden, blijven o vinden, el adjetivo no se flexiona nunca. Het document is verkeerd. · Jullie zullen het leuk vinden.
• Los adjetivos acabados en -en no se flexionan jamas: open, eigen, tevreden, houten, gouden. De open haard. · Elk kind heeft zijn eigen kastje.

🌿 El plural lo resuelve solo, y es la mejor prueba de la regla: todos los plurales llevan de, asi que en plural SIEMPRE hay -e. Por eso «het bestand» hace «een oud bestand» sin -e en singular indefinido, pero «de oude bestanden» con -e en cuanto pasa a plural.

🔁 Los antonimos de los adjetivos que salen en estas tarjetas, que es como mejor se fijan: groot ↔ klein · oud ↔ nieuw · open ↔ dicht (o gesloten) · goed ↔ slecht · verkeerd ↔ juist.

🌳 El arbol de decision, en dos preguntas:
1. ¿El adjetivo va delante del sustantivo? Si no va delante, no lleva -e (es predicado) y ya no hay nada que decidir.
2. Si va delante, ¿el sustantivo es het-woord Y el determinante es indefinido? Solo si las dos respuestas son que si, va sin -e. En cualquier otro caso, con -e.',
    updated_at = datetime('now')
WHERE id = 39
  AND rules_help IS NULL;

-- ==============================================================================
-- 4. Tarjeta 128: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'de open haard = la chimenea de lena, la de hacer fuego en casa. Aqui «open» NO lleva -e, pero no por la regla de het/de: es que los adjetivos acabados en -en no se flexionan NUNCA. Y cuidado con el reparto: de haard es el hogar donde arde el fuego, mientras que de schoorsteen es el tubo que saca el humo, lo que se ve desde fuera. Antonimo de open: dicht, o gesloten en registro mas formal.

🔤 La -e del adjetivo: cuatro casillas y solo UNA se salva
El adjetivo delante del sustantivo lleva -e casi siempre. La unica casilla que se queda sin -e es la de het-woord + indefinido:

| | de-woord | het-woord |
|---|---|---|
| **definido** (de/het, mijn, dit, dat) | de grote tafel | het verkeerde document |
| **indefinido** (een, geen, veel, elk, nada) | een grote tafel | een verkeerd document |

📌 Regla de bolsillo, la que hay que retener: la -e solo se cae cuando se juntan las DOS condiciones a la vez, het-woord Y indefinido. Con una sola de las dos, la -e se queda. Por eso «het verkeerde document» la lleva (het-woord, si, pero definido) y «een verkeerd document» no.

⚠️ Otras dos veces en que no aparece, que no son excepciones sino otro sitio distinto:
• En PREDICADO, detras de zijn, worden, blijven o vinden, el adjetivo no se flexiona nunca. Het document is verkeerd. · Jullie zullen het leuk vinden.
• Los adjetivos acabados en -en no se flexionan jamas: open, eigen, tevreden, houten, gouden. De open haard. · Elk kind heeft zijn eigen kastje.

🌿 El plural lo resuelve solo, y es la mejor prueba de la regla: todos los plurales llevan de, asi que en plural SIEMPRE hay -e. Por eso «het bestand» hace «een oud bestand» sin -e en singular indefinido, pero «de oude bestanden» con -e en cuanto pasa a plural.

🔁 Los antonimos de los adjetivos que salen en estas tarjetas, que es como mejor se fijan: groot ↔ klein · oud ↔ nieuw · open ↔ dicht (o gesloten) · goed ↔ slecht · verkeerd ↔ juist.

🌳 El arbol de decision, en dos preguntas:
1. ¿El adjetivo va delante del sustantivo? Si no va delante, no lleva -e (es predicado) y ya no hay nada que decidir.
2. Si va delante, ¿el sustantivo es het-woord Y el determinante es indefinido? Solo si las dos respuestas son que si, va sin -e. En cualquier otro caso, con -e.',
    updated_at = datetime('now')
WHERE id = 128
  AND rules_help IS NULL;

-- ==============================================================================
-- 5. Tarjeta 131: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'een goed idee = una buena idea. Aqui esta la casilla rara, la unica sin -e: «het idee» es het-woord y «een» es indefinido, o sea las dos condiciones a la vez, asi que goed va pelado. Compara con la misma idea en definido, «het goede idee», que si la lleva. Antonimo: goed ↔ slecht, o sea een slecht idee, tambien sin -e por la misma razon.

🔤 La -e del adjetivo: cuatro casillas y solo UNA se salva
El adjetivo delante del sustantivo lleva -e casi siempre. La unica casilla que se queda sin -e es la de het-woord + indefinido:

| | de-woord | het-woord |
|---|---|---|
| **definido** (de/het, mijn, dit, dat) | de grote tafel | het verkeerde document |
| **indefinido** (een, geen, veel, elk, nada) | een grote tafel | een verkeerd document |

📌 Regla de bolsillo, la que hay que retener: la -e solo se cae cuando se juntan las DOS condiciones a la vez, het-woord Y indefinido. Con una sola de las dos, la -e se queda. Por eso «het verkeerde document» la lleva (het-woord, si, pero definido) y «een verkeerd document» no.

⚠️ Otras dos veces en que no aparece, que no son excepciones sino otro sitio distinto:
• En PREDICADO, detras de zijn, worden, blijven o vinden, el adjetivo no se flexiona nunca. Het document is verkeerd. · Jullie zullen het leuk vinden.
• Los adjetivos acabados en -en no se flexionan jamas: open, eigen, tevreden, houten, gouden. De open haard. · Elk kind heeft zijn eigen kastje.

🌿 El plural lo resuelve solo, y es la mejor prueba de la regla: todos los plurales llevan de, asi que en plural SIEMPRE hay -e. Por eso «het bestand» hace «een oud bestand» sin -e en singular indefinido, pero «de oude bestanden» con -e en cuanto pasa a plural.

🔁 Los antonimos de los adjetivos que salen en estas tarjetas, que es como mejor se fijan: groot ↔ klein · oud ↔ nieuw · open ↔ dicht (o gesloten) · goed ↔ slecht · verkeerd ↔ juist.

🌳 El arbol de decision, en dos preguntas:
1. ¿El adjetivo va delante del sustantivo? Si no va delante, no lleva -e (es predicado) y ya no hay nada que decidir.
2. Si va delante, ¿el sustantivo es het-woord Y el determinante es indefinido? Solo si las dos respuestas son que si, va sin -e. En cualquier otro caso, con -e.',
    updated_at = datetime('now')
WHERE id = 131
  AND rules_help IS NULL;

-- ==============================================================================
-- 6. Tarjeta 832: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'de oude bestanden = los archivos viejos. En plural SIEMPRE hay -e, porque todos los plurales llevan de. La gracia de esta tarjeta es el contraste consigo misma en singular: het bestand es het-woord, asi que «een oud bestand» va sin -e — y en cuanto pasa a plural, oude. De propina: verwijderen es borrar definitivamente, frente a wissen (borrar el contenido) y weggooien (tirar); su antonimo es bewaren (guardar, conservar) u opslaan (almacenar). Antonimo del adjetivo: oud ↔ nieuw.

🔤 La -e del adjetivo: cuatro casillas y solo UNA se salva
El adjetivo delante del sustantivo lleva -e casi siempre. La unica casilla que se queda sin -e es la de het-woord + indefinido:

| | de-woord | het-woord |
|---|---|---|
| **definido** (de/het, mijn, dit, dat) | de grote tafel | het verkeerde document |
| **indefinido** (een, geen, veel, elk, nada) | een grote tafel | een verkeerd document |

📌 Regla de bolsillo, la que hay que retener: la -e solo se cae cuando se juntan las DOS condiciones a la vez, het-woord Y indefinido. Con una sola de las dos, la -e se queda. Por eso «het verkeerde document» la lleva (het-woord, si, pero definido) y «een verkeerd document» no.

⚠️ Otras dos veces en que no aparece, que no son excepciones sino otro sitio distinto:
• En PREDICADO, detras de zijn, worden, blijven o vinden, el adjetivo no se flexiona nunca. Het document is verkeerd. · Jullie zullen het leuk vinden.
• Los adjetivos acabados en -en no se flexionan jamas: open, eigen, tevreden, houten, gouden. De open haard. · Elk kind heeft zijn eigen kastje.

🌿 El plural lo resuelve solo, y es la mejor prueba de la regla: todos los plurales llevan de, asi que en plural SIEMPRE hay -e. Por eso «het bestand» hace «een oud bestand» sin -e en singular indefinido, pero «de oude bestanden» con -e en cuanto pasa a plural.

🔁 Los antonimos de los adjetivos que salen en estas tarjetas, que es como mejor se fijan: groot ↔ klein · oud ↔ nieuw · open ↔ dicht (o gesloten) · goed ↔ slecht · verkeerd ↔ juist.

🌳 El arbol de decision, en dos preguntas:
1. ¿El adjetivo va delante del sustantivo? Si no va delante, no lleva -e (es predicado) y ya no hay nada que decidir.
2. Si va delante, ¿el sustantivo es het-woord Y el determinante es indefinido? Solo si las dos respuestas son que si, va sin -e. En cualquier otro caso, con -e.',
    updated_at = datetime('now')
WHERE id = 832
  AND rules_help IS NULL;

-- ==============================================================================
-- 7. Tarjeta 856: no tenia ayuda (NULL), se crea entera
-- ==============================================================================
UPDATE words_es
SET rules_help = 'het verkeerde document = el documento equivocado. La duda tipica es por que lleva -e si document es het-woord, y la respuesta es que la -e solo se cae con het-woord E indefinido: aqui el articulo es definido, asi que se queda. «Een verkeerd document» iria sin ella. Ademas, verwijzen naar es remitir a, hacer referencia a: verbo fuerte e inseparable (verwijzen - verwees - verwezen), con participio sin ge- por el prefijo ver-, y el grupo preposicional puede ir delante o detras del participio (…naar het verkeerde document verwezen o …verwezen naar het verkeerde document). Y sus rivales: verkeerd es el que no toca (de verkeerde trein), fout es mal hecho (een fout antwoord), onjuist es inexacto y formal, mis es fallido (dat ging mis). Antonimo de verkeerd: juist, o goed. Y el sustantivo de la familia es de verwijzing (la referencia, la remision).

🔤 La -e del adjetivo: cuatro casillas y solo UNA se salva
El adjetivo delante del sustantivo lleva -e casi siempre. La unica casilla que se queda sin -e es la de het-woord + indefinido:

| | de-woord | het-woord |
|---|---|---|
| **definido** (de/het, mijn, dit, dat) | de grote tafel | het verkeerde document |
| **indefinido** (een, geen, veel, elk, nada) | een grote tafel | een verkeerd document |

📌 Regla de bolsillo, la que hay que retener: la -e solo se cae cuando se juntan las DOS condiciones a la vez, het-woord Y indefinido. Con una sola de las dos, la -e se queda. Por eso «het verkeerde document» la lleva (het-woord, si, pero definido) y «een verkeerd document» no.

⚠️ Otras dos veces en que no aparece, que no son excepciones sino otro sitio distinto:
• En PREDICADO, detras de zijn, worden, blijven o vinden, el adjetivo no se flexiona nunca. Het document is verkeerd. · Jullie zullen het leuk vinden.
• Los adjetivos acabados en -en no se flexionan jamas: open, eigen, tevreden, houten, gouden. De open haard. · Elk kind heeft zijn eigen kastje.

🌿 El plural lo resuelve solo, y es la mejor prueba de la regla: todos los plurales llevan de, asi que en plural SIEMPRE hay -e. Por eso «het bestand» hace «een oud bestand» sin -e en singular indefinido, pero «de oude bestanden» con -e en cuanto pasa a plural.

🔁 Los antonimos de los adjetivos que salen en estas tarjetas, que es como mejor se fijan: groot ↔ klein · oud ↔ nieuw · open ↔ dicht (o gesloten) · goed ↔ slecht · verkeerd ↔ juist.

🌳 El arbol de decision, en dos preguntas:
1. ¿El adjetivo va delante del sustantivo? Si no va delante, no lleva -e (es predicado) y ya no hay nada que decidir.
2. Si va delante, ¿el sustantivo es het-woord Y el determinante es indefinido? Solo si las dos respuestas son que si, va sin -e. En cualquier otro caso, con -e.',
    updated_at = datetime('now')
WHERE id = 856
  AND rules_help IS NULL;
