-- Learn Languages App - Migration
-- Migration: 20261106000004-uit-de-brand-helpen
-- Description: Eduardo (2026-11-06): «duda la 1767 esa expresion existe en español pero no en neerlandes, la
--   traduces literal, quita todas las expresiones que no tengan equivalente en neerlandes las que has traducido
--   literal».
--
--   Repaso de las 100 frases hechas: la única calcada era la 51, sacar las castañas del fuego. de kastanjes uit
--   het vuur halen existe, pero significa hacer el trabajo arriesgado para que otro se beneficie y apenas se oye.
--   El equivalente vivo es iemand uit de brand helpen, así que la tarjeta se corrige en vez de borrarse:
--   PHRASE 1767 -> Deze keer help ik je niet uit de brand.
--   SENTENCE 1768 -> Ik help je niet steeds uit de brand.
--   Ayuda nueva: 🔤, 📖 (de brand ≠ het vuur), ficha del verbo helpen (§2), 🧩 con 4 formas, 🎯, ⚠️ con el falso
--   amigo y 🔑. El bloque 📚 compartido se conserva byte a byte (se corta por su ancla). Las otras 99 son modismos
--   neerlandeses reales y de uso actual.
--   El audio nl de la 1767 se borra a mano (data/audio/word-1767-nl-*.mp3): el texto cambia.

UPDATE words_lang SET text = 'Deze keer help ik je niet uit de brand.', pronunciation = 'dese keer help ik ie nit öit de brant', notes = '• [can.] Ik help je niet steeds uit de brand. — No voy a sacarte siempre las castañas del fuego.
• [perf.] Mijn collega heeft me uit de brand geholpen. — Mi compañero me ha sacado las castañas del fuego.
• [bijzin] Hij verwacht dat ik hem uit de brand help. — Espera que le saque las castañas del fuego.
• [vraag] Kun je me uit de brand helpen? — ¿Me puedes sacar del apuro?
• [imperf.] Mijn vader hielp ons altijd uit de brand. — Mi padre siempre nos sacaba las castañas del fuego.', audio_path = NULL
 WHERE lang_code = 'nl_NL' AND word_es_id = (SELECT id FROM words_es WHERE notes = 'frases hechas: de kastanjes uit het vuur halen' AND word_type = 'PHRASE' LIMIT 1);

UPDATE words_lang SET text = 'Ik help je niet steeds uit de brand.', pronunciation = 'ik help ie nit steets öit de brant', audio_path = NULL
 WHERE lang_code = 'nl_NL' AND word_es_id = (SELECT id FROM words_es WHERE notes = 'Ejemplo de "de kastanjes uit het vuur halen" (can.)' AND word_type = 'SENTENCE' LIMIT 1);

DELETE FROM word_es_media WHERE lang_code = 'nl_NL' AND word_es_id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: de kastanjes uit het vuur halen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM words_es WHERE notes = 'Ejemplo de "de kastanjes uit het vuur halen" (can.)' AND word_type = 'SENTENCE' LIMIT 1));

UPDATE words_es
   SET rules_help = 'IEMAND UIT DE BRAND HELPEN = sacarle a alguien las castañas del fuego, sacarlo de un apuro.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — sacarle a alguien las castañas del fuego = iemand uit de brand helpen.
• en esta tarjeta — la persona va entre el verbo y uit de brand, help ik JE niet uit de brand; tras deze keer invierte, help ik.

📖 Palabra a palabra:

• de brand — el incendio. Ojo, no es het vuur, el fuego: de brand es el fuego que se ha descontrolado, Er is brand! (¡fuego!, ¡hay un incendio!).
• uit — fuera de, desde dentro hacia fuera.
• helpen — ayudar. Ficha completa debajo.

📐 Conjugacion de helpen (fuerte · simple):

| persona | presente | imperfecto |
|---|---|---|
| ik | help | hielp |
| jij / je | helpt | hielp |
| u | helpt | hielp |
| hij / zij / het | helpt | hielp |
| wij | helpen | hielpen |
| jullie | helpen | hielpen |
| zij (plural) | helpen | hielpen |

• participio — geholpen, con hebben: Ze heeft me uit de brand geholpen.
• al invertir, jij pierde la -t: Help je me even? — no «helpt je».
• preposicion — iemand helpen met iets, ayudar a alguien con algo: Kun je me helpen met mijn huiswerk?
• antonimo — tegenwerken, poner trabas.
• sustantivo — de hulp, la ayuda: Hulp nodig? (¿necesitas ayuda?).
• separable — no, es un verbo simple.

🧩 Expresión fija — iemand uit de brand helpen:

• literal — ayudar a alguien a salir del incendio.
• significa — sacar a alguien de un apuro, resolverle el problema en el que se ha metido.
• piezas fijas — uit de brand; la persona va sin preposición, justo detrás del verbo o del sujeto invertido.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik help je niet steeds uit de brand. | No voy a sacarte siempre las castañas del fuego. |
| 2 | perfecto | Mijn collega heeft me uit de brand geholpen. | Mi compañero me ha sacado las castañas del fuego. |
| 3 | subordinada | Hij verwacht dat ik hem uit de brand help. | Espera que le saque las castañas del fuego. |
| 4 | pregunta | Kun je me uit de brand helpen? | ¿Me puedes sacar del apuro? |

🎯 En qué contexto se usa:

• un compañero que te cubre o arregla lo que rompiste
• pedir un favor urgente, Kun je me uit de brand helpen?
• quejarse de que siempre te toca a ti salvar a otro
• registro neutro, vale en casa y en el trabajo

⚠️ de kastanjes uit het vuur halen también existe, pero no es lo mismo: es hacer el trabajo arriesgado para que OTRO se lleve el beneficio. Además suena a libro y casi no se oye. Para «sacar de un apuro», uit de brand helpen.

🔑 El truco que casi nunca falla: en neerlandés no se sacan castañas, se apaga el incendio. Si alguien está en un apuro, está in de brand, y tú lo sacas, iemand uit de brand helpen.' || substr(rules_help, instr(rules_help, '

📚 Uitdrukking o spreekwoord')),
       notes = 'frases hechas: iemand uit de brand helpen', updated_at = datetime('now')
 WHERE notes = 'frases hechas: de kastanjes uit het vuur halen' AND word_type = 'PHRASE' AND instr(rules_help, '

📚 Uitdrukking o spreekwoord') > 0;

UPDATE words_es
   SET rules_help = 'IEMAND UIT DE BRAND HELPEN = sacarle a alguien las castañas del fuego, sacarlo de un apuro.

📖 Palabra a palabra:

• de brand — el incendio. Ojo, no es het vuur, el fuego: de brand es el fuego que se ha descontrolado, Er is brand! (¡fuego!, ¡hay un incendio!).
• uit — fuera de, desde dentro hacia fuera.
• helpen — ayudar. Ficha completa debajo.

📐 Conjugacion de helpen (fuerte · simple):

| persona | presente | imperfecto |
|---|---|---|
| ik | help | hielp |
| jij / je | helpt | hielp |
| u | helpt | hielp |
| hij / zij / het | helpt | hielp |
| wij | helpen | hielpen |
| jullie | helpen | hielpen |
| zij (plural) | helpen | hielpen |

• participio — geholpen, con hebben: Ze heeft me uit de brand geholpen.
• al invertir, jij pierde la -t: Help je me even? — no «helpt je».
• preposicion — iemand helpen met iets, ayudar a alguien con algo: Kun je me helpen met mijn huiswerk?
• antonimo — tegenwerken, poner trabas.
• sustantivo — de hulp, la ayuda: Hulp nodig? (¿necesitas ayuda?).
• separable — no, es un verbo simple.

🧩 Expresión fija — iemand uit de brand helpen:

• literal — ayudar a alguien a salir del incendio.
• significa — sacar a alguien de un apuro, resolverle el problema en el que se ha metido.
• piezas fijas — uit de brand; la persona va sin preposición, justo detrás del verbo o del sujeto invertido.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik help je niet steeds uit de brand. | No voy a sacarte siempre las castañas del fuego. |
| 2 | perfecto | Mijn collega heeft me uit de brand geholpen. | Mi compañero me ha sacado las castañas del fuego. |
| 3 | subordinada | Hij verwacht dat ik hem uit de brand help. | Espera que le saque las castañas del fuego. |
| 4 | pregunta | Kun je me uit de brand helpen? | ¿Me puedes sacar del apuro? |

🎯 En qué contexto se usa:

• un compañero que te cubre o arregla lo que rompiste
• pedir un favor urgente, Kun je me uit de brand helpen?
• quejarse de que siempre te toca a ti salvar a otro
• registro neutro, vale en casa y en el trabajo

⚠️ de kastanjes uit het vuur halen también existe, pero no es lo mismo: es hacer el trabajo arriesgado para que OTRO se lleve el beneficio. Además suena a libro y casi no se oye. Para «sacar de un apuro», uit de brand helpen.

🔑 El truco que casi nunca falla: en neerlandés no se sacan castañas, se apaga el incendio. Si alguien está en un apuro, está in de brand, y tú lo sacas, iemand uit de brand helpen.' || substr(rules_help, instr(rules_help, '

📚 Uitdrukking o spreekwoord')),
       notes = 'Ejemplo de "iemand uit de brand helpen" (can.)', updated_at = datetime('now')
 WHERE notes = 'Ejemplo de "de kastanjes uit het vuur halen" (can.)' AND word_type = 'SENTENCE' AND instr(rules_help, '

📚 Uitdrukking o spreekwoord') > 0;
