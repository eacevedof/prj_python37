-- Learn Languages App - Voor (preposicion) vs voordat (conjuncion) en la ayuda de la tarjeta 837
-- Migration: 20260829000005-help-voor-vs-voordat-837.sql
-- Description: La tarjeta 837 usa "voordat ik het verstuur", no "voor ik het verstuur". Se
--   explica en su rules_help la diferencia entre voor (preposicion, delante de un sustantivo
--   o pronombre, sin verbo conjugado propio) y voordat (conjuncion, delante de una oracion
--   completa con su propio sujeto y verbo conjugado, que ademas se va al final).
--   100% aditiva e idempotente: solo UPDATE con guard (rules_help IS NULL).

UPDATE words_es
SET rules_help = '"Voordat ik het verstuur", no "voor ik het verstuur" — porque despues va una oracion COMPLETA (sujeto + verbo conjugado propio: ik verstuur), y eso pide voordat, no voor.

📐 La regla que separa las dos palabras:
• **voor** = PREPOSICION. Va delante de un sustantivo o un pronombre, SIN verbo conjugado propio detras. Su significado mas frecuente es "para"; solo en contexto temporal significa "antes de".
• **voordat** = CONJUNCION. Va delante de una oracion completa (sujeto + verbo conjugado), y esa oracion es subordinada (bijzin): el verbo conjugado se va al final. Siempre significa "antes de que" / "antes de".

🧪 La comprobacion de dos segundos: mira lo que viene justo despues.
• ¿Un sustantivo o un pronombre, sin verbo propio? → voor. Voor het weekend moet ik dit af hebben. — Antes del fin de semana tengo que terminar esto. Dit cadeau is voor jou. — Este regalo es para ti. (aqui "voor" = "para", el sentido mas comun, ni siquiera es temporal)
• ¿Un sujeto con su propio verbo conjugado (una oracion entera)? → voordat, y el verbo a la orden. Ik bewerk het bestand voordat ik het verstuur. — Edito el archivo antes de enviarlo. (esta frase) Was je handen voordat je eet. — Lavate las manos antes de comer.

⚠️ Por que confunde: en espanol "antes de" (+ sustantivo) y "antes de que" (+ oracion) se parecen mucho, y el neerlandes hablado a veces acorta voordat a voor de forma coloquial ("voor ik het verstuur", informal). Para no fallar, usa siempre voordat cuando detras haya un sujeto y un verbo conjugado propios — es la forma estandar, sin ambiguedad.',
    updated_at = datetime('now')
WHERE id = 837
  AND rules_help IS NULL;
