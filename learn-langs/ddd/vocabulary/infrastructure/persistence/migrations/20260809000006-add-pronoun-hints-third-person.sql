-- Learn Languages App - Pistas de pronombre en frases de 3a persona (barrido)
-- Migration: 20260809000006-add-pronoun-hints-third-person.sql
-- Description: El espanol omite el sujeto en 3a persona pero el neerlandes exige hij/zij/het.
--   Se anade el pronombre entre parentesis al final del texto_es. Para zij/ze (que en NL
--   distinguen tonica zij / atona ze, indistinguibles en "ella/ellos" espanol) se matiza la
--   forma: aqui todas las tarjetas usan la forma ATONA (ze). Para hij solo "(el)" (no tiene
--   forma atona escrita estandar). Excluidos: het impersonal (llueve, es una pena...) y las
--   que ya llevan el/ella/ellos. La 686 va en 20260809000005.
--   Idempotente: keyeado por id y solo si el texto no tiene ya un parentesis (2a ejecucion=0).

PRAGMA foreign_keys = ON;

-- 142: han robado  ->  (ellos, átona)
UPDATE words_es SET text = text || ' (ellos, átona)' WHERE id=142 AND text NOT LIKE '%(%';

-- 150: acaban de llegar  ->  (ellos, átona)
UPDATE words_es SET text = text || ' (ellos, átona)' WHERE id=150 AND text NOT LIKE '%(%';

-- 210: estará cansado  ->  (él)
UPDATE words_es SET text = text || ' (él)' WHERE id=210 AND text NOT LIKE '%(%';

-- 302: Seguro que llega tarde otra vez.  ->  (él)
UPDATE words_es SET text = text || ' (él)' WHERE id=302 AND text NOT LIKE '%(%';

-- 305: Estará en el atasco.  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=305 AND text NOT LIKE '%(%';

-- 328: Sabe que tendrá que elegir.  ->  (él)
UPDATE words_es SET text = text || ' (él)' WHERE id=328 AND text NOT LIKE '%(%';

-- 346: Preguntó si aún los tenía todos.  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=346 AND text NOT LIKE '%(%';

-- 365: Dice que todo el mundo es bienvenido.  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=365 AND text NOT LIKE '%(%';

-- 375: Preguntó si había estado alguna vez en España.  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=375 AND text NOT LIKE '%(%';

-- 394: Espera poder comprarse una casa algún día.  ->  (él)
UPDATE words_es SET text = text || ' (él)' WHERE id=394 AND text NOT LIKE '%(%';

-- 416: Es el único que lo sabe.  ->  (él)
UPDATE words_es SET text = text || ' (él)' WHERE id=416 AND text NOT LIKE '%(%';

-- 439: Dice que allí es bonito.  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=439 AND text NOT LIKE '%(%';

-- 443: Preguntó cuántos me quedaban.  ->  (él)
UPDATE words_es SET text = text || ' (él)' WHERE id=443 AND text NOT LIKE '%(%';

-- 451: Dijo que tenía muchísimas ganas.  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=451 AND text NOT LIKE '%(%';

-- 455: Dice que no es culpa suya.  ->  (él)
UPDATE words_es SET text = text || ' (él)' WHERE id=455 AND text NOT LIKE '%(%';

-- 459: Preguntó cómo iba todo.  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=459 AND text NOT LIKE '%(%';

-- 472: Dice que viene y que trae comida.  ->  (él)
UPDATE words_es SET text = text || ' (él)' WHERE id=472 AND text NOT LIKE '%(%';

-- 486: Está contento, pues ha conseguido el trabajo.  ->  (él)
UPDATE words_es SET text = text || ' (él)' WHERE id=486 AND text NOT LIKE '%(%';

-- 487: Está cansada, pues ha dormido mal.  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=487 AND text NOT LIKE '%(%';

-- 495: Aprende neerlandés porque vive en Países Bajos.  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=495 AND text NOT LIKE '%(%';

-- 500: Vino, aunque estaba enfermo.  ->  (él)
UPDATE words_es SET text = text || ' (él)' WHERE id=500 AND text NOT LIKE '%(%';

-- 507: Dice que está cansada.  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=507 AND text NOT LIKE '%(%';

-- 518: Pone el despertador para levantarse a tiempo.  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=518 AND text NOT LIKE '%(%';

-- 566: entregan el paquete mañana  ->  (ellos, átona)
UPDATE words_es SET text = text || ' (ellos, átona)' WHERE id=566 AND text NOT LIKE '%(%';

-- 590: no coge el teléfono  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=590 AND text NOT LIKE '%(%';

-- 597: gasta mucho dinero  ->  (él)
UPDATE words_es SET text = text || ' (él)' WHERE id=597 AND text NOT LIKE '%(%';

-- 617: han vendido su casa  ->  (ellos, átona)
UPDATE words_es SET text = text || ' (ellos, átona)' WHERE id=617 AND text NOT LIKE '%(%';

-- 620: se ha ido a casa  ->  (él)
UPDATE words_es SET text = text || ' (él)' WHERE id=620 AND text NOT LIKE '%(%';

-- 625: se ha hecho médica  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=625 AND text NOT LIKE '%(%';

-- 656: todavía sueña con él  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=656 AND text NOT LIKE '%(%';

-- 664: nos han invitado  ->  (ellos, átona)
UPDATE words_es SET text = text || ' (ellos, átona)' WHERE id=664 AND text NOT LIKE '%(%';

-- 667: ya se han ido  ->  (ellos, átona)
UPDATE words_es SET text = text || ' (ellos, átona)' WHERE id=667 AND text NOT LIKE '%(%';

-- 688: se enamoro de el  ->  (ella, átona)
UPDATE words_es SET text = text || ' (ella, átona)' WHERE id=688 AND text NOT LIKE '%(%';
