-- Learn Languages App - Reestructura la ayuda de la tarjeta 772 (zodra) con numeracion jerarquica
-- Migration: 20260829000010-restructure-772-numbered-sections.sql
-- Description: Aplica a la ayuda de zodra (772) la nueva norma de numeracion jerarquica del
--   vault (1 - titulo, 1.1, 1.2..., 2 - titulo) para poder senalar un punto por su numero.
--   Convierte la tabla de 5 ejemplos en 8 items numerados (3.1-3.8), anadiendo registro
--   formal con "u" (3.6), posesivo (3.7) y reflexivo (3.8), manteniendo el resto en frases
--   cotidianas del dia a dia. Los numeros van DETRAS del emoji de seccion (el formatter exige
--   el emoji como primer caracter para tratar la linea como encabezado) y los items van con
--   "• N.N termino — frase" para que el conversor los pinte como lista (no como tabla), y
--   auto-negrite el termino via el patron "termino = def" / "termino — resto" — sin ** manual,
--   que fuera de tablas se escapa literal (ver learn-langs-code.md, 2026-08-20).
--   100% aditiva e idempotente: solo UPDATE con guard (marca "1 - " al inicio, no reescribe
--   si ya esta migrada).

UPDATE words_es
SET rules_help = '1 - zodra = en cuanto, tan pronto como. Es conjuncion SUBORDINANTE: manda el verbo al final de su propia frase.

🗺️ 2 - Los rivales de «cuando»:
• 2.1 zodra = en cuanto: el momento justo en que pasa A empieza B. Subordinante.
• 2.2 als = cuando, y tambien si. Para el presente, el futuro y lo repetido.
• 2.3 wanneer = cuando (en pregunta) y cuando (formal o escrito).
• 2.4 toen = cuando, pero solo para un momento UNICO del pasado.
• 2.5 nadat = despues de que: A termina y luego empieza B; suele pedir perfecto.
• 2.6 meteen, direct = enseguida. Son adverbios, no conjunciones: no mandan el verbo al final.

🗣️ 3 - Ejemplos, alternando tiempo, persona y registro:
• 3.1 presente · ik — Zodra ik thuis ben, bel ik je. — En cuanto llegue a casa, te llamo.
• 3.2 imperfecto · hij — Zodra hij klaar was, ging hij naar buiten. — En cuanto terminó, salió.
• 3.3 imperativo · je — Bel me zodra je iets weet. — Llámame en cuanto sepas algo.
• 3.4 perfecto · we — Zodra we het pakket hebben ontvangen, sturen we een mail. — En cuanto recibamos el paquete, mandamos un correo.
• 3.5 imperfecto · ze — Ze ging weg zodra het begon te regenen. — Se marchó en cuanto empezó a llover.
• 3.6 presente formal · u — Zodra u er klaar voor bent, kunnen we beginnen. — En cuanto esté listo/a, podemos empezar.
• 3.7 presente + posesivo · ik — Zodra ik mijn huiswerk af heb, ga ik buiten spelen. — En cuanto termine mis deberes, salgo a jugar.
• 3.8 presente + reflexivo · hij — Zodra hij zich omkleedt, vertrekken we naar de wedstrijd. — En cuanto se cambie de ropa, nos vamos al partido.

📐 4 - Estructura: Zodra + sujeto + resto + VERBO (final), coma, y la principal con inversión: verbo + sujeto.

⚠️ 5 - Avisos:
• 5.1 El verbo se va al FINAL: «Zodra ik thuis ben», nunca «Zodra ik ben thuis».
• 5.2 Lo que en español es subjuntivo, aquí es PRESENTE: Zodra ik het weet, bel ik je (en cuanto lo sepa, te llamo). El neerlandés no tiene subjuntivo.

🏋️ 6 - Ejercicio: «en cuanto llegue, te aviso» → ___ ik aankom, laat ik het je weten. (Respuesta: Zodra.)',
    updated_at = datetime('now')
WHERE id = 772
  AND rules_help NOT LIKE '1 - zodra%';

UPDATE words_lang
SET notes = '• [inv.] Zodra ik thuis ben, bel ik je. — En cuanto llegue a casa, te llamo.
• [inv.] Zodra hij klaar was, ging hij naar buiten. — En cuanto terminó, salió.
• [geb.] Bel me zodra je iets weet. — Llámame en cuanto sepas algo.
• [inv.] Zodra we het pakket hebben ontvangen, sturen we een mail. — En cuanto recibamos el paquete, mandamos un correo.
• [can.] Ze ging weg zodra het begon te regenen. — Se marchó en cuanto empezó a llover.
• [inv.] Zodra u er klaar voor bent, kunnen we beginnen. — En cuanto esté listo/a, podemos empezar.
• [can.] Zodra ik mijn huiswerk af heb, ga ik buiten spelen. — En cuanto termine mis deberes, salgo a jugar.
• [can.] Zodra hij zich omkleedt, vertrekken we naar de wedstrijd. — En cuanto se cambie de ropa, nos vamos al partido.'
WHERE word_es_id = 772
  AND lang_code = 'nl_NL'
  AND notes NOT LIKE '%mijn huiswerk%';
