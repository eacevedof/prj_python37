-- Learn Languages App - la 844: la ayuda mezclaba la familia de wijzen con wijzigen
-- Migration: 20260902000001-fix-844-solo-wijzigen.sql
-- Description: Eduardo: «en 844 estamos mezclando la ayuda, el verbo es wijzigen y metemos
--   variantes de wijzen. documentemos solo wijzigen, si me apuras comparalo con bewerken o algun
--   similar de modificar. Indica que es verbo regular etc, lo que tienes en howto.md». La ayuda
--   traia el bloque 🧲 de las preposiciones de la familia wijzen (que es OTRO verbo y ya vive en
--   sus tarjetas, p. ej. la 846): se sustituye entera por la ficha de wijzigen segun la normativa
--   (tabla de 7 personas, debil/regular con el porque del -de/-d, participio gewijzigd CON ge-,
--   transitivo + wijzigen in/naar, de wijziging con Wijzigingen voorbehouden, contrarios
--   practicos EN TABLA — norma nueva de antonimos — behouden/terugdraaien) y la comparativa de
--   los cuatro «modificar» (bewerken/wijzigen/aanpassen/veranderen, la duda de la 837) con su
--   regla de bolsillo. Idempotente: el WHERE exige el texto viejo (marca «familia de wijzen»),
--   que desaparece al aplicar.

PRAGMA foreign_keys = ON;

UPDATE words_es
SET rules_help = 'wijzigen = modificar: hacer UN cambio concreto y puntual (antes X, ahora Y). Verbo debil (regular) y transitivo directo: de regels wijzigen, sin preposicion.

📐 Conjugacion de wijzigen (debil/regular, no separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | wijzig | wijzigde |
| jij / je | wijzigt | wijzigde |
| u | wijzigt | wijzigde |
| hij / zij / het | wijzigt | wijzigde |
| wij | wijzigen | wijzigden |
| jullie | wijzigen | wijzigden |
| zij (plural) | wijzigen | wijzigden |

• participio — gewijzigd, con hebben y CON ge- (wijzigen no lleva prefijo atono; al reves que verwezen o besproken). Imperfecto en -de y participio en -d porque la raiz wijzig- acaba en sonora (fuera de ''''t kofschip).
• al invertir, jij pierde la -t: Wijzig jij de afspraak?
• preposicion — transitivo directo; el destino del cambio entra con in o naar: De afspraak wijzigen naar volgende week.
• sustantivo derivado — de wijziging (la modificacion): Wijzigingen voorbehouden — «sujeto a cambios», el letrero clasico.
• antonimo — no tiene uno lexico fijo; los contrarios practicos, cada uno con su matiz:

| contrario | matiz | ejemplo |
|---|---|---|
| behouden | conservar tal cual, no tocar | De oude regels behouden. |
| terugdraaien | revertir un cambio ya hecho | De wijziging terugdraaien. |

• registro — wijzigen es formal/administrativo (contratos, ajustes, apps); en el dia a dia se oye mas veranderen o aanpassen.
• sustantivos de la frase — de gemeente (el ayuntamiento) · de regel, plural de regels (la norma).

🗺️ Los cuatro «modificar» — no son intercambiables:

| verbo | que es | ejemplo |
|---|---|---|
| bewerken | editar: trabajar SOBRE el contenido, el proceso (el menu Bewerken) | Ik bewerk het bestand. |
| wijzigen | modificar: UN cambio concreto y puntual | Wachtwoord wijzigen. |
| aanpassen (aan) | ajustar, adaptar A algo | De tekst aanpassen aan het publiek. |
| veranderen | cambiar en general: algo se vuelve distinto | Het weer verandert. |

📌 Regla de bolsillo:
• ¿Es el proceso de editar (puedes pasarte una hora)? → bewerken.
• ¿Es un cambio puntual, antes X ahora Y? → wijzigen.
• ¿Ajustas algo A otra cosa? → aanpassen aan.
• ¿Algo se vuelve distinto, sin mas? → veranderen.'
WHERE id = 844 AND rules_help LIKE '%familia de wijzen%';
