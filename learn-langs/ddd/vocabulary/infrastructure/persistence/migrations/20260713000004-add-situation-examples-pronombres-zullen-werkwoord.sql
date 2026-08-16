-- Learn Languages App - Ejemplos de situación (🧭) en pronombres, zullen-conjugation
--   y werkwoord-varianten (las 26 frases que aún no lo tenían)
-- Migration: 20260713000004-add-situation-examples-pronombres-zullen-werkwoord.sql
-- Description: Añade un bloque "🧭 Cuándo usarlo" (contexto real + ejemplo/mini-situación)
--   al rules_help de: pronombres - voornaamwoorden (18), zullen-conjugation (21) y las
--   26 frases de werkwoord-varianten que no eran de las ambiguas (esas 8 ya tenían 🧭).
--   100% aditiva e IDEMPOTENTE: solo UPDATE de words_es.rules_help (APPEND) con guarda
--   NOT LIKE '%🧭%'. NO toca words_lang (audio_path), imágenes, notes, text ni otra columna.
--   En pronombres los notes no son únicos (me/het salen 2x) -> se keyea por notes + text.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. PRONOMBRES - VOORNAAMWOORDEN (18)  [key: notes + text]
-- =============================================================================
UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: me = objeto átono de 1ª persona, lo normal en el día a día. Ej.: pisas a alguien sin querer → Sorry, het spijt me! (¡perdona, lo siento!).'
WHERE notes = 'Pronombre objeto: me' AND text = 'lo siento' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: me como objeto directo tras el verbo. Ej.: alguien pesado no para de molestarte → Laat me met rust! (¡déjame en paz!).'
WHERE notes = 'Pronombre objeto: me' AND text = 'déjame en paz' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: mij (forma tónica) cuando el pronombre lleva énfasis o contraste (a MÍ). Ej.: te preguntan qué prefieres y te da lo mismo → Dat maakt mij niet uit (a mí me da igual).'
WHERE notes = 'Pronombre objeto: mij (tónico)' AND text = 'a mí me da igual' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: je = te/a ti, átono, el objeto informal por defecto. Ej.: te despides de tu pareja → Ik hou van je (te quiero).'
WHERE notes = 'Pronombre objeto: je' AND text = 'te quiero' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: jou (tónico) para enfatizar o contrastar (a TI). Ej.: alguien se mete donde no le llaman → Dat gaat jou niets aan! (¡eso a ti no te importa!).'
WHERE notes = 'Pronombre objeto: jou (tónico)' AND text = 'eso a ti no te importa' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: u = le/lo, trato formal (clientes, desconocidos, mayores). Ej.: un dependiente al cliente → Kan ik u helpen? (¿puedo ayudarle?).'
WHERE notes = 'Pronombre objeto: u (formal)' AND text = '¿puedo ayudarle?' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: hem también sustituye a COSAS de-woord (de stoel, de auto → hem), no solo a él. Ej.: hablas de un objeto masculino → Mag ik hem al wel weggeven? (¿ahora sí puedo regalarlo/a?).'
WHERE notes = 'Pronombre objeto: hem (cosa de-woord)' AND text = '¿ahora sí puedo regalarla?' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: hem = lo/le referido a una persona (él). Ej.: te preguntan por un amigo común → Ja, ik ken hem goed (sí, lo conozco bien).'
WHERE notes = 'Pronombre objeto: hem (persona)' AND text = 'lo conozco bien' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: haar = la/le (ella); también su (posesivo). Ej.: sugieres llamar a una amiga → Bel haar maar even (llámala un momento, anda).'
WHERE notes = 'Pronombre objeto: haar' AND text = 'llámala un momento, anda' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: het = lo (neutro), sustituye a cosas het-woord o a una idea entera. Ej.: te preguntan algo que no sabes → Ik weet het niet (no lo sé).'
WHERE notes = 'Pronombre objeto: het' AND text = 'no lo sé' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: het en frases hechas de atención al público. Ej.: un camarero listo para tomar nota → Zegt u het maar / Zeg het maar (usted dirá / dime).'
WHERE notes = 'Pronombre objeto: het' AND text = 'tú dirás / dime' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: ons = nos/a nosotros (y nuestro). Ej.: cierras un email pidiendo respuesta → Laat het ons weten (háznoslo saber).'
WHERE notes = 'Pronombre objeto: ons' AND text = 'háznoslo saber' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: jullie = os/a vosotros (plural informal). Ej.: deseas suerte a un grupo antes de un examen → Ik wens jullie veel succes (os deseo mucho éxito).'
WHERE notes = 'Pronombre objeto: jullie' AND text = 'os deseo mucho éxito' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: ze = los/las para COSAS en plural. Ej.: hay papeles viejos que no sirven → Gooi ze maar weg (tíralos sin más).'
WHERE notes = 'Pronombre objeto: ze (cosas plural)' AND text = 'tíralos sin más' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: ze = los/las/les para PERSONAS en plural, forma neutra y coloquial. Ej.: te preguntan por unos amigos → Ik heb ze gisteren gezien (los vi ayer).'
WHERE notes = 'Pronombre objeto: ze (personas plural)' AND text = 'los vi ayer' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: hen = objeto DIRECTO de personas (registro cuidado/escrito); en el habla casi siempre se dice ze. Ej.: explicas por qué no vinieron → Ik heb hen niet uitgenodigd (no los invité).'
WHERE notes = 'Pronombre objeto: hen (directo)' AND text = 'no los invité' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: hun = objeto INDIRECTO de personas (a ellos/les), registro cuidado; coloquial → ze. Ej.: aclaras que guardaste un secreto → Ik heb hun niets verteld (no les conté nada).'
WHERE notes = 'Pronombre objeto: hun (indirecto)' AND text = 'no les conté nada' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: dos objetos juntos → primero el directo (het) y luego el indirecto (je). Ej.: alguien te pide algo y se lo darás enseguida → Ik geef het je zo (ahora te lo doy).'
WHERE notes = 'Pronombre objeto: het + je (doble)' AND text = 'ahora te lo doy' AND rules_help NOT LIKE '%🧭%';

-- =============================================================================
-- 2. ZULLEN-CONJUGATION (21)  [key: notes]
-- =============================================================================
UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: ik zal = promesa o compromiso (yo me encargo). Ej.: te ofreces voluntario → Maak je geen zorgen, ik zal het doen (tranquilo, lo haré yo).'
WHERE notes = 'Conjugación de zullen: ik zal' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: 2ª persona, predicción o promesa (ya verás). Ej.: animas a alguien inseguro → Jij zult het zien, het komt goed (ya lo verás, saldrá bien).'
WHERE notes = 'Conjugación de zullen: jij zult' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: forma formal (u). Ej.: un vendedor tranquiliza al cliente → U zult tevreden zijn met dit product (usted quedará satisfecho con este producto).'
WHERE notes = 'Conjugación de zullen: u zult' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: predicción sobre él. Ej.: informas de cuándo llega alguien → De monteur? Hij zal morgen komen (¿el técnico? vendrá mañana).'
WHERE notes = 'Conjugación de zullen: hij zal' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: predicción o suposición sobre ella. Ej.: preguntan por tu madre a esa hora → Om zes uur zal ze thuis zijn (a las seis estará en casa).'
WHERE notes = 'Conjugación de zullen: zij zal' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: compromiso en plural. Ej.: un equipo acepta un reto → We beloven niets, maar we zullen het proberen (no prometemos nada, pero lo intentaremos).'
WHERE notes = 'Conjugación de zullen: wij zullen' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: predicción dirigida a un grupo. Ej.: recomiendas una peli a unos amigos → Kijk deze film, jullie zullen het leuk vinden (ved esta peli, os gustará).'
WHERE notes = 'Conjugación de zullen: jullie zullen' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: predicción sobre ellos. Ej.: avisas de que unos invitados se retrasan → Zij zullen later aankomen (llegarán más tarde).'
WHERE notes = 'Conjugación de zullen: zij zullen' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: Zal ik…? = OFRECERSE a hacer algo (¿quieres que…?). Ej.: hay que hacer la cena y te ofreces → Zal ik koken? (¿cocino yo?).'
WHERE notes = 'Conjugación de zullen: zal ik? (pregunta)' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: pregunta en 2ª persona; el verbo pierde la -t (zul jij, no zult jij). Ej.: confirmas asistencia → Zul jij er vanavond zijn? (¿estarás esta noche?).'
WHERE notes = 'Conjugación de zullen: zul jij? (pregunta, pierde la -t)' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: Zullen we…? = PROPONER un plan conjunto. Ej.: la reunión puede arrancar → Zullen we beginnen? (¿empezamos?).'
WHERE notes = 'Conjugación de zullen: zullen we? (pregunta)' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: preguntar por una probabilidad (¿tú crees que…?). Ej.: dudáis si los invitados aparecerán → Zullen zij komen, denk je? (¿vendrán, tú crees?).'
WHERE notes = 'Conjugación de zullen: zullen zij? (pregunta)' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: zou = condicional o consejo (yo que tú…). Ej.: alguien duda y le aconsejas → Ik zou het niet doen (yo no lo haría).'
WHERE notes = 'Conjugación de zullen: ik zou' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: consejo suave (zou moeten = deberías). Ej.: tu amigo está agotado → Jij zou meer moeten slapen (deberías dormir más).'
WHERE notes = 'Conjugación de zullen: jij zou' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: sugerencia formal y cortés. Ej.: aconsejas una opción a un cliente → U zou het kunnen proberen (usted podría intentarlo).'
WHERE notes = 'Conjugación de zullen: u zou' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: suposición (seguro que ella…). Ej.: buscáis quién tiene la respuesta → Vraag het aan Anna, zij zou het weten (pregúntale a Anna, ella lo sabría).'
WHERE notes = 'Conjugación de zullen: zij zou' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: aceptar o desear con cortesía (zouden graag = nos encantaría). Ej.: respondes a una invitación → We zouden graag komen, bedankt! (nos encantaría venir, ¡gracias!).'
WHERE notes = 'Conjugación de zullen: wij zouden' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: hipótesis dirigida a un grupo. Ej.: cuentas un logro a la familia → Jullie zouden trots zijn op hem (estaríais orgullosos de él).'
WHERE notes = 'Conjugación de zullen: jullie zouden' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: hipótesis sobre ellos. Ej.: comentas que unos nunca reconocen un error → Zij zouden het nooit toegeven (ellos nunca lo admitirían).'
WHERE notes = 'Conjugación de zullen: zij zouden' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: pedir opinión o consejo (¿tú qué harías?). Ej.: dudas ante una decisión → Zou jij dat doen? (¿tú harías eso?).'
WHERE notes = 'Conjugación de zullen: zou jij? (pregunta)' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: propuesta más suave o tentativa que zullen we? (con matiz hipotético/cortés). Ej.: sugieres algo con cautela → Zouden we het toch proberen? (¿lo intentamos igualmente?).'
WHERE notes = 'Conjugación de zullen: zouden we? (pregunta)' AND rules_help NOT LIKE '%🧭%';

-- =============================================================================
-- 3. WERKWOORD-VARIANTEN (26 restantes, no ambiguas)  [key: notes]
-- =============================================================================
UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: hacerse cargo de alguien/algo de forma continua. Ej.: explicas tu rol en casa → Ik werk niet, ik zorg voor de kinderen (no trabajo, cuido de los niños).'
WHERE notes = 'Variante de zorgen: zorgen voor' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: comprometerte a que algo ocurra (trabajo, organización). Ej.: repartís tareas de un evento → Jij regelt de muziek, ik zorg ervoor dat alles klaar is (tú la música, yo me encargo de que todo esté listo).'
WHERE notes = 'Variante de zorgen: ervoor zorgen dat' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: entrega a domicilio (paquetes, comida). Ej.: compras online → Ze bezorgen het pakje morgen tussen 9 en 12 (entregan el paquete mañana entre 9 y 12).'
WHERE notes = 'Variante de zorgen: bezorgen' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: cuidar activamente (curas, aseo, alimentar) a personas, animales o plantas. Ej.: hablas de un cuidador → Zij verzorgt haar zieke moeder elke dag (cuida a su madre enferma cada día).'
WHERE notes = 'Variante de zorgen: verzorgen' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: tener a alguien/algo en la mente; también acuérdate de. Ej.: mensaje de ánimo a alguien lejos → Ik denk aan je (pienso en ti). Recordatorio: Denk aan de melk! (¡acuérdate de la leche!).'
WHERE notes = 'Variante de denken: denken aan' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: reflexionar antes de decidir. Ej.: te presionan por una respuesta → Laat me even nadenken (déjame pensarlo un momento).'
WHERE notes = 'Variante de denken: nadenken' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: idear u ocurrírsele una idea o solución. Ej.: encuentras un plan → Wacht, ik heb iets bedacht! (espera, ¡se me ha ocurrido algo!).'
WHERE notes = 'Variante de denken: bedenken' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: hablar de tallas en el probador. Ej.: te pruebas ropa en la tienda → Deze broek past niet, heb je een maat groter? (este pantalón no me queda, ¿tienes una talla más?).'
WHERE notes = 'Variante de passen: passen' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: combinar o encajar (ropa, colores, personas, planes). Ej.: opinas sobre una prenda → Die kleur past niet bij jou (ese color no te pega).'
WHERE notes = 'Variante de passen: passen bij' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: adaptarse a algo nuevo (país, trabajo, horario). Ej.: te acabas de mudar → Ik ben hier net, ik moet me nog aanpassen (acabo de llegar, aún me tengo que adaptar).'
WHERE notes = 'Variante de passen: zich aanpassen' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: examinar algo con detalle, sin prisa. Ej.: te mandan un documento largo → Ik bekijk het morgen rustig (lo miro mañana con calma).'
WHERE notes = 'Variante de kijken: bekijken' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: esperar algo con ilusión. Ej.: cierre de un email o charla de planes → Ik kijk uit naar het weekend! (¡tengo muchas ganas del fin de semana!).'
WHERE notes = 'Variante de kijken: uitkijken naar' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: llegar a un destino (tren, avión, visita). Ej.: vas a recoger a alguien a la estación → Hoe laat kom je aan? (¿a qué hora llegas?). Ojo: aankomen también = engordar.'
WHERE notes = 'Variante de komen: aankomen' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: cruzarte con alguien por azar (≠ quedar). Ej.: cuentas un encuentro casual → Raad eens wie ik gisteren ben tegengekomen! (¡a que no sabes con quién me crucé ayer!).'
WHERE notes = 'Variante de komen: tegenkomen' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: decir que algo ocurre o es frecuente. Ej.: quitas hierro a un problema común → Maak je niet druk, dat komt vaak voor (no te agobies, eso pasa a menudo).'
WHERE notes = 'Variante de komen: voorkomen' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: piropo sobre cómo sienta la ropa (estilo, no talla). Ej.: tu amigo se prueba algo → Die jas staat je goed! (¡esa chaqueta te queda genial!).'
WHERE notes = 'Variante de staan: staan (ropa)' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: no oír bien (ruido, mala línea), NO no comprender. Ej.: mala cobertura al teléfono → Sorry, ik versta je niet, het is hier lawaaierig (no te oigo, hay mucho ruido aquí).'
WHERE notes = 'Variante de staan: verstaan' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: levantarse de la cama (rutina). Ej.: te preguntan por tu horario → Ik sta om zeven uur op (me levanto a las siete).'
WHERE notes = 'Variante de staan: opstaan' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: pedir quedarte con algo, conservarlo. Ej.: te ofrecen algo prestado y quieres quedártelo → Mag ik het houden? (¿me lo puedo quedar?).'
WHERE notes = 'Variante de houden: houden' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: pedir comida o bebida para llevar. Ej.: en la cafetería te preguntan voor hier of om mee te nemen? → Om mee te nemen, alstublieft (para llevar, por favor).'
WHERE notes = 'Variante de nemen: meenemen' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: descolgar o contestar el teléfono; también grabar o sacar dinero. Ej.: llamas y nadie responde → Ze neemt de telefoon niet op (no coge el teléfono).'
WHERE notes = 'Variante de nemen: opnemen' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: dar algo por supuesto. Ej.: confirmas un plan que dabas por hecho → Ik neem aan dat je komt, of niet? (supongo que vienes, ¿no?).'
WHERE notes = 'Variante de nemen: aannemen' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: concertar una cita o quedada. Ej.: propones verte con alguien → Zullen we morgen afspreken voor een koffie? (¿quedamos mañana para un café?).'
WHERE notes = 'Variante de spreken: afspreken' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: preguntar por la pronunciación de una palabra. Ej.: no sabes decir un nombre → Hoe spreek je dit uit? (¿cómo se pronuncia esto?).'
WHERE notes = 'Variante de spreken: uitspreken' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: reconocer o admitir algo, a veces a regañadientes. Ej.: cedes en una discusión → Oké, ik moet toegeven dat je gelijk had (vale, tengo que admitir que tenías razón).'
WHERE notes = 'Variante de geven: toegeven' AND rules_help NOT LIKE '%🧭%';

UPDATE words_es SET rules_help = rules_help || '

🧭 Cuándo usarlo: gastar dinero (¡no dar!); también publicar. Ej.: comentas el gasto de alguien → Hij geeft veel geld uit aan kleren (gasta mucho dinero en ropa).'
WHERE notes = 'Variante de geven: uitgeven' AND rules_help NOT LIKE '%🧭%';
