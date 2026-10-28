-- Learn Languages App - Migration
-- Migration: 20261019000002-marca-inv-en-toda-inversion
-- Description: Eduardo: "En todas las frases aplica (inv) si esperas que la traduccion tiene que
--   hacerse en el formato inverso. P.e: 886 lo traduje como Ik heb deze week weinig tijd y es
--   incorrecto pq se espera la inversion".
--
--   La 886 (Esta semana tengo poco tiempo → Deze week heb ik weinig tijd) caia en la fila 3 de
--   la norma (inv) (§3.9, 20260922000001): «el español abre con lo mismo, trasladando el orden
--   sale sola → sin marca». Falla: el orden neutro tambien es correcto y la app lo suspende.
--   Se elimina esa excepcion: toda frase cuya respuesta abre con un complemento o una
--   subordinada, y admite tambien el orden sujeto-verbo, lleva (inv).
--
--   Barrido: 425 frases no interrogativas que no abren con pronombre sujeto, revisadas a mano.
--   104 marcadas. Fuera: sujeto delante (Dat, Het, Mijn huis…), imperativos, deseos y
--   condicionales con el verbo delante (Had ik maar…, Mocht je…), er de relleno delante (Er is…),
--   concesivas sin inversion (Ook al…, Hoe … ook), frases que ya decian la inversion en su
--   anotacion (496, 499) y las que ya llevaban (inv) o (sin inv).
--
--   1. Marca (inv) en el texto ES, fundida en el parentesis si ya lo habia: (presente, inv).
--   2. Bloque «🔃 Cuando el enunciado lleva (inv) y abre con tiempo, lugar o subordinada» en las
--      que tienen ayuda (§5.4: las que no tienen se quedan solo con la marca).
--   3. AUDIO (§5.6.5): se borra el word_es_media es_ES de las marcadas para que se regenere. El
--      mp3 local data/audio/word-<id>-es-*.mp3 se borra aparte (cache por id).

PRAGMA foreign_keys = ON;

-- 1) La marca en el enunciado

UPDATE words_es SET text = 'Después del café nos vamos. (inv)', updated_at = datetime('now')
WHERE id = 287 AND text = 'Después del café nos vamos.';

UPDATE words_es SET text = 'Mañana lo haré de verdad. (inv)', updated_at = datetime('now')
WHERE id = 293 AND text = 'Mañana lo haré de verdad.';

UPDATE words_es SET text = 'A las ocho estaré allí. (inv)', updated_at = datetime('now')
WHERE id = 297 AND text = 'A las ocho estaré allí.';

UPDATE words_es SET text = 'Sin ti no saldría bien. (inv)', updated_at = datetime('now')
WHERE id = 318 AND text = 'Sin ti no saldría bien.';

UPDATE words_es SET text = 'Yo que tú, lo haría. (inv)', updated_at = datetime('now')
WHERE id = 320 AND text = 'Yo que tú, lo haría.';

UPDATE words_es SET text = 'Tras la mudanza lo regalé todo. (inv)', updated_at = datetime('now')
WHERE id = 334 AND text = 'Tras la mudanza lo regalé todo.';

UPDATE words_es SET text = 'De todo lo que comí, esto fue lo más rico. (inv)', updated_at = datetime('now')
WHERE id = 340 AND text = 'De todo lo que comí, esto fue lo más rico.';

UPDATE words_es SET text = 'Los libros los he leído todos. (inv)', updated_at = datetime('now')
WHERE id = 343 AND text = 'Los libros los he leído todos.';

UPDATE words_es SET text = 'Ayer los recogí todos. (inv)', updated_at = datetime('now')
WHERE id = 345 AND text = 'Ayer los recogí todos.';

UPDATE words_es SET text = 'Esta noche vienen todos. (inv)', updated_at = datetime('now')
WHERE id = 348 AND text = 'Esta noche vienen todos.';

UPDATE words_es SET text = 'En el cobertizo hay un montón de trastos viejos. (inv)', updated_at = datetime('now')
WHERE id = 353 AND text = 'En el cobertizo hay un montón de trastos viejos.';

UPDATE words_es SET text = 'En todas las tiendas hay gente. (inv)', updated_at = datetime('now')
WHERE id = 358 AND text = 'En todas las tiendas hay gente.';

UPDATE words_es SET text = 'En la fiesta todos se conocían. (inv)', updated_at = datetime('now')
WHERE id = 362 AND text = 'En la fiesta todos se conocían.';

UPDATE words_es SET text = 'En la foto sonríen ambos. (inv)', updated_at = datetime('now')
WHERE id = 369 AND text = 'En la foto sonríen ambos.';

UPDATE words_es SET text = 'A veces aquí llueve todo el día. (inv)', updated_at = datetime('now')
WHERE id = 381 AND text = 'A veces aquí llueve todo el día.';

UPDATE words_es SET text = 'Algún día iré a Japón. (inv)', updated_at = datetime('now')
WHERE id = 390 AND text = 'Algún día iré a Japón.';

UPDATE words_es SET text = 'Unas cuantas veces por semana hago deporte. (inv)', updated_at = datetime('now')
WHERE id = 397 AND text = 'Unas cuantas veces por semana hago deporte.';

UPDATE words_es SET text = 'Solo muy rara vez llega tarde. (inv)', updated_at = datetime('now')
WHERE id = 402 AND text = 'Solo muy rara vez llega tarde.';

UPDATE words_es SET text = 'De vez en cuando llamo a mi abuela. (inv)', updated_at = datetime('now')
WHERE id = 406 AND text = 'De vez en cuando llamo a mi abuela.';

UPDATE words_es SET text = 'De tanto en tanto echo una siesta ("zo nu en dan" = af en toe, inv).', updated_at = datetime('now')
WHERE id = 409 AND text = 'De tanto en tanto echo una siesta ("zo nu en dan" = af en toe).';

UPDATE words_es SET text = 'Esa peli quiero verla otra vez. (inv)', updated_at = datetime('now')
WHERE id = 413 AND text = 'Esa peli quiero verla otra vez.';

UPDATE words_es SET text = 'Esta noche hay fiesta en casa de los vecinos. (inv)', updated_at = datetime('now')
WHERE id = 423 AND text = 'Esta noche hay fiesta en casa de los vecinos.';

UPDATE words_es SET text = 'Fuera está pasando algo. (inv)', updated_at = datetime('now')
WHERE id = 431 AND text = 'Fuera está pasando algo.';

UPDATE words_es SET text = 'Antes vivía allí. (inv)', updated_at = datetime('now')
WHERE id = 438 AND text = 'Antes vivía allí.';

UPDATE words_es SET text = 'Por la noche llama mucha gente. (inv)', updated_at = datetime('now')
WHERE id = 462 AND text = 'Por la noche llama mucha gente.';

UPDATE words_es SET text = 'Si llueve, nos quedamos en casa. (inv)', updated_at = datetime('now')
WHERE id = 502 AND text = 'Si llueve, nos quedamos en casa.';

UPDATE words_es SET text = 'De niño vivía en Sevilla (als también = "de/como", inv).', updated_at = datetime('now')
WHERE id = 505 AND text = 'De niño vivía en Sevilla (als también = "de/como").';

UPDATE words_es SET text = 'Mientras esperaba, leía un libro. (inv)', updated_at = datetime('now')
WHERE id = 512 AND text = 'Mientras esperaba, leía un libro.';

UPDATE words_es SET text = 'Mientras dormías, hice la compra. (inv)', updated_at = datetime('now')
WHERE id = 514 AND text = 'Mientras dormías, hice la compra.';

UPDATE words_es SET text = 'Cuando era joven, vivía en Sevilla. (inv)', updated_at = datetime('now')
WHERE id = 521 AND text = 'Cuando era joven, vivía en Sevilla.';

UPDATE words_es SET text = 'Cuando llegó el tren, llovía. (inv)', updated_at = datetime('now')
WHERE id = 522 AND text = 'Cuando llegó el tren, llovía.';

UPDATE words_es SET text = 'esta mañana me he levantado tarde (inv)', updated_at = datetime('now')
WHERE id = 658 AND text = 'esta mañana me he levantado tarde';

UPDATE words_es SET text = 'te vas a resfriar (inv)', updated_at = datetime('now')
WHERE id = 691 AND text = 'te vas a resfriar';

UPDATE words_es SET text = 'aqui se habla neerlandes (inv)', updated_at = datetime('now')
WHERE id = 696 AND text = 'aqui se habla neerlandes';

UPDATE words_es SET text = 'aqui no se fuma (inv)', updated_at = datetime('now')
WHERE id = 697 AND text = 'aqui no se fuma';

UPDATE words_es SET text = 'por las mañanas desayuno a las siete (inv)', updated_at = datetime('now')
WHERE id = 767 AND text = 'por las mañanas desayuno a las siete';

UPDATE words_es SET text = 'por las mañanas salgo a correr (inv)', updated_at = datetime('now')
WHERE id = 768 AND text = 'por las mañanas salgo a correr';

UPDATE words_es SET text = 'por las tardes trabajo en casa (inv)', updated_at = datetime('now')
WHERE id = 769 AND text = 'por las tardes trabajo en casa';

UPDATE words_es SET text = 'por las noches veo la tele (inv)', updated_at = datetime('now')
WHERE id = 770 AND text = 'por las noches veo la tele';

UPDATE words_es SET text = 'de madrugada duermo mal (inv)', updated_at = datetime('now')
WHERE id = 771 AND text = 'de madrugada duermo mal';

UPDATE words_es SET text = 'hoy trabajo en la oficina (inv)', updated_at = datetime('now')
WHERE id = 790 AND text = 'hoy trabajo en la oficina';

UPDATE words_es SET text = 'asi no se hace, se hace asi (inv)', updated_at = datetime('now')
WHERE id = 806 AND text = 'asi no se hace, se hace asi';

UPDATE words_es SET text = 'En cuanto llegue a casa, te llamo. (inv)', updated_at = datetime('now')
WHERE id = 807 AND text = 'En cuanto llegue a casa, te llamo.';

UPDATE words_es SET text = 'En cuanto terminó, salió. (inv)', updated_at = datetime('now')
WHERE id = 808 AND text = 'En cuanto terminó, salió.';

UPDATE words_es SET text = 'Al fin y al cabo fue idea tuya, no mía. (inv)', updated_at = datetime('now')
WHERE id = 810 AND text = 'Al fin y al cabo fue idea tuya, no mía.';

UPDATE words_es SET text = 'Antes no salía nunca, a menos que hiciera sol. (inv)', updated_at = datetime('now')
WHERE id = 812 AND text = 'Antes no salía nunca, a menos que hiciera sol.';

UPDATE words_es SET text = 'Antes se creía que las penas duras eran la mejor disuasión. (inv)', updated_at = datetime('now')
WHERE id = 824 AND text = 'Antes se creía que las penas duras eran la mejor disuasión.';

UPDATE words_es SET text = 'En esta función asigno un valor a la variable x. (inv)', updated_at = datetime('now')
WHERE id = 834 AND text = 'En esta función asigno un valor a la variable x.';

UPDATE words_es SET text = 'Después del tercer rechazo, no se rindió. (inv)', updated_at = datetime('now')
WHERE id = 853 AND text = 'Después del tercer rechazo, no se rindió.';

UPDATE words_es SET text = 'El año pasado leíamos un libro cada mes. (inv)', updated_at = datetime('now')
WHERE id = 875 AND text = 'El año pasado leíamos un libro cada mes.';

UPDATE words_es SET text = 'Cada año visitamos a los abuelos. (inv)', updated_at = datetime('now')
WHERE id = 876 AND text = 'Cada año visitamos a los abuelos.';

UPDATE words_es SET text = 'Cada mañana bebo café. (inv)', updated_at = datetime('now')
WHERE id = 877 AND text = 'Cada mañana bebo café.';

UPDATE words_es SET text = 'En cada esquina hay una tienda. (inv)', updated_at = datetime('now')
WHERE id = 882 AND text = 'En cada esquina hay una tienda.';

UPDATE words_es SET text = 'Cada vez que la veo, sonríe. (inv)', updated_at = datetime('now')
WHERE id = 883 AND text = 'Cada vez que la veo, sonríe.';

UPDATE words_es SET text = 'Esta semana tengo poco tiempo. (inv)', updated_at = datetime('now')
WHERE id = 886 AND text = 'Esta semana tengo poco tiempo.';

UPDATE words_es SET text = 'Si todo va bien, mañana viene. (inv)', updated_at = datetime('now')
WHERE id = 909 AND text = 'Si todo va bien, mañana viene.';

UPDATE words_es SET text = 'En mi opinión es demasiado caro. (inv)', updated_at = datetime('now')
WHERE id = 920 AND text = 'En mi opinión es demasiado caro.';

UPDATE words_es SET text = 'mañana llegas tarde (inv)', updated_at = datetime('now')
WHERE id = 977 AND text = 'mañana llegas tarde';

UPDATE words_es SET text = 'ojalá venga mañana (él, inv)', updated_at = datetime('now')
WHERE id = 981 AND text = 'ojalá venga mañana (él)';

UPDATE words_es SET text = 'si hubiera sabido eso, no habría venido (inv)', updated_at = datetime('now')
WHERE id = 984 AND text = 'si hubiera sabido eso, no habría venido';

UPDATE words_es SET text = 'puede que llueva esta tarde (inv)', updated_at = datetime('now')
WHERE id = 991 AND text = 'puede que llueva esta tarde';

UPDATE words_es SET text = 'llueve, así que me quedo en casa (inv)', updated_at = datetime('now')
WHERE id = 998 AND text = 'llueve, así que me quedo en casa';

UPDATE words_es SET text = 'si llueve, entonces me quedo en casa (inv)', updated_at = datetime('now')
WHERE id = 999 AND text = 'si llueve, entonces me quedo en casa';

UPDATE words_es SET text = 'primero comemos y luego nos vamos (inv)', updated_at = datetime('now')
WHERE id = 1000 AND text = 'primero comemos y luego nos vamos';

UPDATE words_es SET text = 'entonces te veo mañana (inv)', updated_at = datetime('now')
WHERE id = 1001 AND text = 'entonces te veo mañana';

UPDATE words_es SET text = 'había atasco, por eso llegué tarde (inv)', updated_at = datetime('now')
WHERE id = 1004 AND text = 'había atasco, por eso llegué tarde';

UPDATE words_es SET text = 'como ya es tarde, lo dejamos (inv)', updated_at = datetime('now')
WHERE id = 1006 AND text = 'como ya es tarde, lo dejamos';

UPDATE words_es SET text = 'la carretera estaba resbaladiza porque había llovido (inv)', updated_at = datetime('now')
WHERE id = 1007 AND text = 'la carretera estaba resbaladiza porque había llovido';

UPDATE words_es SET text = 'al principio era difícil (inv)', updated_at = datetime('now')
WHERE id = 1035 AND text = 'al principio era difícil';

UPDATE words_es SET text = 'saliendo de casa vi a Jan (inv)', updated_at = datetime('now')
WHERE id = 1079 AND text = 'saliendo de casa vi a Jan';

UPDATE words_es SET text = 'a partir de mañana trabajo en casa (inv)', updated_at = datetime('now')
WHERE id = 1096 AND text = 'a partir de mañana trabajo en casa';

UPDATE words_es SET text = 'desde aquí son cinco minutos andando (inv)', updated_at = datetime('now')
WHERE id = 1097 AND text = 'desde aquí son cinco minutos andando';

UPDATE words_es SET text = 'ayer comí con mi hermana (inv)', updated_at = datetime('now')
WHERE id = 1108 AND text = 'ayer comí con mi hermana';

UPDATE words_es SET text = 'de pequeños siempre íbamos a la playa (inv)', updated_at = datetime('now')
WHERE id = 1110 AND text = 'de pequeños siempre íbamos a la playa';

UPDATE words_es SET text = 'desde que vivo aquí como mejor (inv)', updated_at = datetime('now')
WHERE id = 1113 AND text = 'desde que vivo aquí como mejor';

UPDATE words_es SET text = 'mañana voy al médico (inv)', updated_at = datetime('now')
WHERE id = 1114 AND text = 'mañana voy al médico';

UPDATE words_es SET text = 'hoy es 3 de septiembre (inv)', updated_at = datetime('now')
WHERE id = 1133 AND text = 'hoy es 3 de septiembre';

UPDATE words_es SET text = 'en verano hace calor aquí (inv)', updated_at = datetime('now')
WHERE id = 1134 AND text = 'en verano hace calor aquí';

UPDATE words_es SET text = 'el mes que viene empiezo un curso (inv)', updated_at = datetime('now')
WHERE id = 1136 AND text = 'el mes que viene empiezo un curso';

UPDATE words_es SET text = 'en diciembre celebramos Sinterklaas (inv)', updated_at = datetime('now')
WHERE id = 1137 AND text = 'en diciembre celebramos Sinterklaas';

UPDATE words_es SET text = 'en primavera florece todo (inv)', updated_at = datetime('now')
WHERE id = 1180 AND text = 'en primavera florece todo';

UPDATE words_es SET text = 'el verano pasado hizo mucho calor (inv)', updated_at = datetime('now')
WHERE id = 1181 AND text = 'el verano pasado hizo mucho calor';

UPDATE words_es SET text = 'en otoño llueve mucho aquí (inv)', updated_at = datetime('now')
WHERE id = 1182 AND text = 'en otoño llueve mucho aquí';

UPDATE words_es SET text = 'en invierno oscurece a las cinco (inv)', updated_at = datetime('now')
WHERE id = 1183 AND text = 'en invierno oscurece a las cinco';

UPDATE words_es SET text = 'Cuando vivía en Bruselas, tenía muchos amigos belgas. (inv)', updated_at = datetime('now')
WHERE id = 1239 AND text = 'Cuando vivía en Bruselas, tenía muchos amigos belgas.';

UPDATE words_es SET text = 'El verano que viene iremos a Francia con nuestros hijos. (inv)', updated_at = datetime('now')
WHERE id = 1243 AND text = 'El verano que viene iremos a Francia con nuestros hijos.';

UPDATE words_es SET text = 'En España cenamos muy tarde. (presente, inv)', updated_at = datetime('now')
WHERE id = 1246 AND text = 'En España cenamos muy tarde. (presente)';

UPDATE words_es SET text = 'Mañana viene un austriaco a la oficina. (inv)', updated_at = datetime('now')
WHERE id = 1256 AND text = 'Mañana viene un austriaco a la oficina.';

UPDATE words_es SET text = 'Cuando éramos niños, teníamos un vecino finlandés. (inv)', updated_at = datetime('now')
WHERE id = 1260 AND text = 'Cuando éramos niños, teníamos un vecino finlandés.';

UPDATE words_es SET text = 'Este verano vamos a Grecia con unos amigos griegos. (inv)', updated_at = datetime('now')
WHERE id = 1266 AND text = 'Este verano vamos a Grecia con unos amigos griegos.';

UPDATE words_es SET text = 'Los domingos comemos en un restaurante turco. (presente, inv)', updated_at = datetime('now')
WHERE id = 1271 AND text = 'Los domingos comemos en un restaurante turco. (presente)';

UPDATE words_es SET text = 'El año que viene celebraremos el carnaval con nuestra amiga brasileña. (inv)', updated_at = datetime('now')
WHERE id = 1282 AND text = 'El año que viene celebraremos el carnaval con nuestra amiga brasileña.';

UPDATE words_es SET text = 'Antes vivían muchos surinameses en este barrio. (inv)', updated_at = datetime('now')
WHERE id = 1284 AND text = 'Antes vivían muchos surinameses en este barrio.';

UPDATE words_es SET text = 'Esta noche cenamos en el chino. (presente, inv)', updated_at = datetime('now')
WHERE id = 1294 AND text = 'Esta noche cenamos en el chino. (presente)';

UPDATE words_es SET text = 'De pequeño vivía en un pueblo muy pequeño. (él, inv)', updated_at = datetime('now')
WHERE id = 1305 AND text = 'De pequeño vivía en un pueblo muy pequeño. (él)';

UPDATE words_es SET text = 'Hoy me siento mucho mejor que ayer. (inv)', updated_at = datetime('now')
WHERE id = 1307 AND text = 'Hoy me siento mucho mejor que ayer.';

UPDATE words_es SET text = 'En enero hace más frío que en diciembre. (inv)', updated_at = datetime('now')
WHERE id = 1329 AND text = 'En enero hace más frío que en diciembre.';

UPDATE words_es SET text = 'Mañana tengo que levantarme más temprano. (inv)', updated_at = datetime('now')
WHERE id = 1367 AND text = 'Mañana tengo que levantarme más temprano.';

UPDATE words_es SET text = 'Hoy estás más guapa que nunca. (inv)', updated_at = datetime('now')
WHERE id = 1375 AND text = 'Hoy estás más guapa que nunca.';

UPDATE words_es SET text = 'Esta semana estoy más liado que nunca. (inv)', updated_at = datetime('now')
WHERE id = 1387 AND text = 'Esta semana estoy más liado que nunca.';

UPDATE words_es SET text = 'Este mes he gastado menos que el anterior. (inv)', updated_at = datetime('now')
WHERE id = 1393 AND text = 'Este mes he gastado menos que el anterior.';

UPDATE words_es SET text = 'Algunos días no tengo ganas de nada. (inv)', updated_at = datetime('now')
WHERE id = 1396 AND text = 'Algunos días no tengo ganas de nada.';

UPDATE words_es SET text = 'En algunos casos no es posible. (inv)', updated_at = datetime('now')
WHERE id = 1398 AND text = 'En algunos casos no es posible.';

UPDATE words_es SET text = 'Después de algunos años volvió a Países Bajos. (ella, inv)', updated_at = datetime('now')
WHERE id = 1403 AND text = 'Después de algunos años volvió a Países Bajos. (ella)';

-- 2) Bloque compartido, solo donde ya hay ayuda

UPDATE words_es SET rules_help = rules_help || char(10) || char(10) || '🔃 Cuando el enunciado lleva (inv) y abre con tiempo, lugar o subordinada:

La tarjeta pide el neerlandés en el mismo orden que el español, con ese complemento delante. Como el verbo conjugado va SIEMPRE en 2ª posición, el sujeto salta detrás del verbo.

| # | delante va | con inversión, lo que pide la tarjeta | orden neutro, correcto pero no es el pedido |
|---|---|---|---|
| 1 | tiempo | **Deze week heb ik** weinig tijd. | Ik heb deze week weinig tijd. |
| 2 | lugar | **In Spanje eten we** heel laat. | We eten in Spanje heel laat. |
| 3 | conector | Het regent, **dus blijf ik** thuis. | Het regent, dus ik blijf thuis. |
| 4 | subordinada | Als het regent, **blijven we** thuis. | We blijven thuis als het regent. |

🔑 El truco que casi nunca falla: con (inv) copia el orden del español y cuenta hasta dos. Lo primero es el complemento, lo segundo el verbo conjugado y el sujeto va tercero.

⚠️ La gemela es (sin inv), que pide justo lo contrario aunque el español abra con un adverbio. Sin ninguna de las dos marcas, la frase solo admite un orden.', updated_at = datetime('now')
WHERE id IN (287, 293, 297, 318, 320, 334, 340, 343, 345, 348, 353, 358, 362, 369, 381, 390, 397, 402, 406, 409, 413, 423, 431, 438, 462, 502, 505, 512, 514, 521, 522, 658, 691, 696, 697, 767, 768, 769, 770, 771, 790, 806, 807, 808, 810, 812, 824, 834, 853, 875, 876, 877, 882, 883, 886, 909, 920, 977, 981, 984, 991, 998, 999, 1000, 1001, 1004, 1006, 1007, 1035, 1079, 1096, 1097, 1108, 1110, 1113, 1114, 1133, 1134, 1136, 1137, 1180, 1181, 1182, 1183, 1239, 1243, 1246, 1256, 1260, 1266, 1271, 1282, 1284, 1294, 1305, 1307, 1329, 1367, 1375, 1387, 1393, 1396, 1398, 1403) AND rules_help IS NOT NULL AND rules_help <> ''
  AND rules_help NOT LIKE '%🔃 Cuando el enunciado lleva (inv) y abre con tiempo, lugar o subordinada:%';

-- 3) Audio es_ES desincronizado

DELETE FROM word_es_media WHERE lang_code = 'es_ES' AND word_es_id IN (287, 293, 297, 318, 320, 334, 340, 343, 345, 348, 353, 358, 362, 369, 381, 390, 397, 402, 406, 409, 413, 423, 431, 438, 462, 502, 505, 512, 514, 521, 522, 658, 691, 696, 697, 767, 768, 769, 770, 771, 790, 806, 807, 808, 810, 812, 824, 834, 853, 875, 876, 877, 882, 883, 886, 909, 920, 977, 981, 984, 991, 998, 999, 1000, 1001, 1004, 1006, 1007, 1035, 1079, 1096, 1097, 1108, 1110, 1113, 1114, 1133, 1134, 1136, 1137, 1180, 1181, 1182, 1183, 1239, 1243, 1246, 1256, 1260, 1266, 1271, 1282, 1284, 1294, 1305, 1307, 1329, 1367, 1375, 1387, 1393, 1396, 1398, 1403);
