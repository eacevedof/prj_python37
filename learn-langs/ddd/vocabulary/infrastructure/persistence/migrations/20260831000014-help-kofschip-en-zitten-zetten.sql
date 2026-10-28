-- Learn Languages App - 't kofschip y la pareja zitten/zetten (dudas de la 814)
-- Migration: 20260831000014-help-kofschip-en-zitten-zetten.sql
-- Description: Eduardo en la 814 («Hij zette de motor uit en stapte uit»), tres cosas:
--   (1) «¿la regla 't kofschip indica que a un regular se agrega te para hacer su pasado?» — casi,
--   pero hay que matizarlo: la regla NO dice que se anada «te», dice que en los verbos DEBILES el
--   pasado se hace con -te(n) O con -de(n) y ELIGE cual segun el ultimo sonido de la raiz; los
--   fuertes no entran (cambian la vocal). (2) «amplia con algun antonimo». (3) «¿existe la palabra
--   gezat como participio de algun verbo?» — NO existe, y el porque es justo lo que hacia falta.
--   Bloque ⚓ IDENTICO byte a byte con la regla en tres pasos, tabla de seis verbos, la trampa de
--   los verbos en -ven/-zen (leven → leefde, reizen → reisde: la raiz escrita acaba en f/s pero el
--   sonido es sonoro, asi que hay que mirar el INFINITIVO), la doble d de antwoordde, la t que no
--   se dobla en gezet, la version moderna 't fokschaap para prestamos (faxte, geracet) y el ge-
--   que no aparece tras prefijo atono. Va a los 7 verbos debiles del mazo (775, 782, 783, 784,
--   814, 836, 842).
--   Bloque 🪑 IDENTICO byte a byte sobre la pareja causativa: zitten (estado, FUERTE: zat,
--   gezeten) frente a zetten (accion, DEBIL: zette, gezet). «gezat» es el error de coger el
--   imperfecto zat y anadirle ge-, que es como se forman los participios debiles y no los fuertes
--   — el fuerte usa su propia forma en -en (gezeten), y ademas gezet ya esta ocupado por zetten.
--   Separa las tres palabras que se cruzan (zat imperfecto y adjetivo «borracho»/«harto» en iets
--   zat zijn · gezeten participio · gezet participio y adjetivo «corpulento») y generaliza la
--   pareja: el intransitivo de estado es fuerte y el transitivo es debil, igual en liggen/leggen y
--   staan/zetten. Antonimos: zitten ↔ staan · gaan zitten ↔ opstaan · uitzetten ↔ aanzetten ·
--   uitstappen ↔ instappen. Va a las 13 tarjetas de la familia zitten/zetten.
--   100% aditiva e idempotente: UPDATE con guard por marca.


-- ==============================================================================
-- 1. 't kofschip, en los 7 verbos debiles
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

⚓ ''t kofschip, la regla que decide entre -te y -de
Antes de nada, lo que la regla NO dice: no dice que el pasado se haga con «te». Dice que en los verbos DEBILES (los regulares) el pasado se hace con -te(n) O con -de(n), y ella elige cual de los dos. Los verbos FUERTES no entran aqui: esos no anaden nada, cambian la vocal (zitten - zat - gezeten).

📐 Como se aplica, en tres pasos:
1. Coge la RAIZ, que es la forma de ik (werken → werk, horen → hoor).
2. Mira su ULTIMO sonido. Si es una de las consonantes de ''t kofschip — t, k, f, s, ch, p — el verbo es sordo.
3. Sordo → -te en el imperfecto y -t en el participio. Cualquier otro sonido → -de y -d.

| verbo | raiz | acaba en | imperfecto | participio |
|---|---|---|---|---|
| **werken** | werk | k, esta en kofschip | werkte | gewerkt |
| **hopen** | hoop | p, esta | hoopte | gehoopt |
| **zetten** | zet | t, esta | zette | gezet |
| **horen** | hoor | r, no esta | hoorde | gehoord |
| **bellen** | bel | l, no esta | belde | gebeld |
| **bespeuren** | bespeur | r, no esta | bespeurde | bespeurd |

⚠️ La trampa que tumba a todo el mundo son los verbos en -ven y -zen. De leven la raiz escrita es leef, y de reizen es reis, asi que parecen kofschip. Pues NO lo son: el neerlandes no escribe v ni z a final de silaba, pero el sonido de verdad es sonoro, y van con -de. leven → leefde, geleefd · reizen → reisde, gereisd · geloven → geloofde · verhuizen → verhuisde. Regla practica para no fallar: mira el INFINITIVO y no la raiz. Si antes de -en hay una v o una z, es -de.

📌 Dos detalles de escritura que caen mucho: si la raiz ya acaba en -d, en el imperfecto se dobla (antwoorden → antwoordde), y si acaba en -t, el participio NO dobla (zetten → gezet, praten → gepraat).

🆕 La version moderna de la regla es ''t fokschaap, que anade la x y el sonido de race para los prestamos: faxen → faxte, gefaxt · racen → racete, geracet.

🔚 Y el participio siempre lleva ge-, salvo cuando el verbo empieza por prefijo atono (be-, ge-, er-, her-, ont-, ver-): bespeuren → bespeurd y verwijderen → verwijderd, los dos sin ge-.',
    updated_at = datetime('now')
WHERE id IN (775, 782, 783, 784, 814, 836, 842)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%⚓ ''t kofschip%';

-- ==============================================================================
-- 2. zitten vs zetten, en las 13 de la familia
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🪑 zitten o zetten, y por que «gezat» no existe
Son dos verbos distintos que se diferencian en una letra y forman una PAREJA CAUSATIVA: uno es el estado y el otro es la accion de provocarlo.

| verbo | que es | tipo | imperfecto | participio |
|---|---|---|---|---|
| **zitten** | estar sentado, estar metido en algo | fuerte | zat, zaten | **gezeten** |
| **zetten** | poner, colocar algo de pie | debil | zette, zetten | **gezet** |

📌 «gezat» NO EXISTE en neerlandes. Es el error de coger el imperfecto de zitten, que es zat, y ponerle un ge- delante — que es como se forman los participios DEBILES, no los fuertes. El participio de un verbo fuerte no se hace con la vocal del pasado, sino con su propia forma en -en: gezeten, gesproken, gelegen. Y ademas gezet, con e, ya esta ocupado: es el participio de zetten.

🎭 Las tres palabras que se cruzan, para tenerlas separadas de una vez:
• zat = imperfecto de zitten. Hij zat op de bank. Y de propina es adjetivo: zat zijn es estar borracho, e iets zat zijn es estar harto de algo. Ik ben het zat.
• gezeten = participio de zitten. Hij heeft de hele dag gezeten.
• gezet = participio de zetten, y tambien adjetivo, corpulento o entrado en carnes. Een gezette man.

🪞 La misma pareja se repite con otros verbos y funciona igual, asi que es una regla y no un capricho: el intransitivo, el del estado, es FUERTE, y el transitivo, el de la accion, es DEBIL.
• liggen, estar tumbado, fuerte (lag, gelegen) ↔ leggen, tumbar algo, debil (legde, gelegd).
• staan, estar de pie, fuerte (stond, gestaan) ↔ zetten o stellen, poner algo de pie, debiles.

↔️ Antonimos de la familia: zitten ↔ staan · gaan zitten (sentarse) ↔ opstaan (levantarse) · y en los separables, uitzetten (apagar) ↔ aanzetten (encender), uitstappen (bajarse) ↔ instappen (subirse). Los sustantivos, con su articulo: de stoel (la silla), de bank (el sofa y tambien el banco), de motor (el motor).',
    updated_at = datetime('now')
WHERE id IN (290, 518, 671, 700, 702, 708, 710, 711, 713, 730, 765, 814, 869)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🪑 zitten o zetten%';
