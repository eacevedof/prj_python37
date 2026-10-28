-- Learn Languages App - Ejemplos de uso cotidiano (Nederlands)
-- Migration: 20260706000002-fill-nl-examples-daily-usage.sql
-- Description: Rellena words_lang.notes (Ejemplos Nederlands) con 3 frases de
--   ejemplo por palabra/frase, en neerlandes coloquial de la vida diaria de
--   Paises Bajos (casa, medico, tienda, trabajo, charla informal).
--   Formato: una frase por linea -> "zin in het Nederlands — traduccion".
--   Solo escribe donde notes esta vacio: NO pisa ejemplos escritos a mano.
--   No toca ids, no borra filas (los audios word-<id>-*.mp3 no se ven afectados).

PRAGMA foreign_keys = ON;

-- ============================================================
-- SALUDOS Y BASICOS
-- ============================================================

-- 5: hola -> hoi
UPDATE words_lang SET notes = '• Hoi, alles goed? — Hola, ¿todo bien?
• Hoi hoi, tot morgen! — ¡Hola/adiós, hasta mañana! (también se usa al despedirse)
• Hoi, ik ben Eduardo, de nieuwe buurman. — Hola, soy Eduardo, el nuevo vecino.', updated_at = datetime('now')
WHERE word_es_id = 5 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 6: dia -> dag
UPDATE words_lang SET notes = '• Fijne dag nog! — ¡Que tengas buen día! (al despedirse en tiendas)
• Wat een mooie dag vandaag. — Qué día tan bonito hoy.
• Dag meneer, kan ik u helpen? — Buenos días señor, ¿le puedo ayudar? ("dag" también es saludo)', updated_at = datetime('now')
WHERE word_es_id = 6 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 8: futbolista -> voetballer
UPDATE words_lang SET notes = '• Mijn zoon wil voetballer worden. — Mi hijo quiere ser futbolista.
• Hij is een goede voetballer, hij speelt bij Ajax. — Es un buen futbolista, juega en el Ajax.
• Die voetballer is geblesseerd geraakt. — Ese futbolista se ha lesionado.', updated_at = datetime('now')
WHERE word_es_id = 8 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 9: mesa de noche -> nachtkastje
UPDATE words_lang SET notes = '• Mijn telefoon ligt op het nachtkastje. — Mi teléfono está en la mesita de noche.
• Leg je boek maar op het nachtkastje. — Deja el libro en la mesita de noche.
• Ik zoek een lampje voor op het nachtkastje. — Busco una lamparita para la mesita de noche.', updated_at = datetime('now')
WHERE word_es_id = 9 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- ============================================================
-- CUERPO HUMANO
-- ============================================================

-- 10: la cabeza -> het hoofd
UPDATE words_lang SET notes = '• Ik heb hoofdpijn, mijn hoofd bonkt. — Me duele la cabeza, me late fuerte.
• Pas op je hoofd, de deur is laag! — ¡Cuidado con la cabeza, la puerta es baja!
• Hij schudde zijn hoofd van nee. — Negó con la cabeza.', updated_at = datetime('now')
WHERE word_es_id = 10 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 11: el cuello -> de nek
UPDATE words_lang SET notes = '• Ik heb een stijve nek van het slapen. — Tengo el cuello rígido de dormir.
• Mijn nek doet pijn van het beeldscherm. — Me duele el cuello por la pantalla.
• Ze droeg een sjaal om haar nek. — Llevaba una bufanda al cuello.', updated_at = datetime('now')
WHERE word_es_id = 11 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 12: el hombro -> de schouder
UPDATE words_lang SET notes = '• Mijn schouder is stijf van het sporten. — Tengo el hombro cargado del deporte.
• Hij klopte me op de schouder. — Me dio una palmada en el hombro.
• De tas hangt over haar schouder. — El bolso le cuelga del hombro.', updated_at = datetime('now')
WHERE word_es_id = 12 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 13: el pecho -> de borst
UPDATE words_lang SET notes = '• Ik heb pijn op de borst, ik bel de huisarts. — Tengo dolor en el pecho, llamo al médico de cabecera.
• Hij sloeg zich trots op de borst. — Se golpeó el pecho con orgullo.
• Adem diep in en zet je borst vooruit. — Respira hondo y saca el pecho.', updated_at = datetime('now')
WHERE word_es_id = 13 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 14: la espalda -> de rug
UPDATE words_lang SET notes = '• Ik heb last van mijn rug van het tillen. — Me molesta la espalda de cargar peso.
• Ga even op je rug liggen. — Túmbate boca arriba (sobre la espalda).
• Hij deed het achter mijn rug om. — Lo hizo a mis espaldas (expresión muy común).', updated_at = datetime('now')
WHERE word_es_id = 14 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 15: la zona lumbar -> de lendenen
UPDATE words_lang SET notes = '• Ik heb pijn in de lendenen na het tuinieren. — Me duele la zona lumbar después de trabajar en el jardín.
• De fysio masseert mijn lendenen. — El fisio me masajea la zona lumbar.
• In de spreektaal zeggen we vaak "onderrug": ik heb last van mijn onderrug. — Coloquialmente se dice "onderrug": me molesta la parte baja de la espalda.', updated_at = datetime('now')
WHERE word_es_id = 15 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 16: el brazo -> de arm
UPDATE words_lang SET notes = '• Ik heb mijn arm gebroken met fietsen. — Me rompí el brazo montando en bici.
• Ze liepen arm in arm door het park. — Caminaban del brazo por el parque.
• Til je arm even op, zegt de dokter. — Levanta el brazo, dice el médico.', updated_at = datetime('now')
WHERE word_es_id = 16 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 17: el antebrazo -> de onderarm
UPDATE words_lang SET notes = '• Ik heb een schaafwond op mijn onderarm. — Tengo un rasguño en el antebrazo.
• Hij heeft een tatoeage op zijn onderarm. — Tiene un tatuaje en el antebrazo.
• Steun op je onderarmen bij deze oefening. — Apóyate en los antebrazos en este ejercicio.', updated_at = datetime('now')
WHERE word_es_id = 17 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 18: el codo -> de elleboog
UPDATE words_lang SET notes = '• Ik heb mijn elleboog gestoten, au! — ¡Me di un golpe en el codo, ay!
• Niet met je ellebogen op tafel! — ¡Sin codos en la mesa! (típico de padres)
• Hoest in je elleboog, alsjeblieft. — Tose en el codo, por favor.', updated_at = datetime('now')
WHERE word_es_id = 18 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 19: la muneca -> de pols
UPDATE words_lang SET notes = '• Mijn pols doet pijn van het typen. — Me duele la muñeca de teclear.
• Ze draagt een horloge om haar pols. — Lleva un reloj en la muñeca.
• De dokter voelde mijn pols. — El médico me tomó el pulso ("pols" también es pulso).', updated_at = datetime('now')
WHERE word_es_id = 19 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 20: la mano -> de hand
UPDATE words_lang SET notes = '• Was je handen voor het eten. — Lávate las manos antes de comer.
• Geef me even een hand, aangenaam! — Dame la mano, ¡encantado! (saludo formal)
• Kun je me een handje helpen? — ¿Me echas una mano? (expresión muy común)', updated_at = datetime('now')
WHERE word_es_id = 20 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 21: el dedo -> de vinger
UPDATE words_lang SET notes = '• Ik heb in mijn vinger gesneden. — Me corté el dedo.
• Steek je vinger op als je het weet. — Levanta el dedo si lo sabes (en clase).
• Niet met je vingers eten! — ¡No comas con los dedos!', updated_at = datetime('now')
WHERE word_es_id = 21 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 22: la pierna -> het been
UPDATE words_lang SET notes = '• Ik heb mijn been gebroken op wintersport. — Me rompí la pierna esquiando.
• Mijn benen zijn moe van het fietsen. — Tengo las piernas cansadas de ir en bici.
• Hij zit met zijn benen over elkaar. — Está sentado con las piernas cruzadas.', updated_at = datetime('now')
WHERE word_es_id = 22 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 23: el muslo -> de dij
UPDATE words_lang SET notes = '• Mijn dijen doen pijn na het hardlopen. — Me duelen los muslos después de correr.
• Ik heb spierpijn in mijn dijen van de squats. — Tengo agujetas en los muslos por las sentadillas.
• De kip met dijfilet is in de aanbieding. — Los muslos de pollo están de oferta (en el súper).', updated_at = datetime('now')
WHERE word_es_id = 23 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 24: la rodilla -> de knie
UPDATE words_lang SET notes = '• Ik ben op mijn knie gevallen met fietsen. — Me caí sobre la rodilla en la bici.
• Mijn knie kraakt als ik traploop. — La rodilla me cruje al subir escaleras.
• Hij ging door de knieën bij het tillen. — Flexionó las rodillas al levantar peso.', updated_at = datetime('now')
WHERE word_es_id = 24 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 25: la pantorrilla -> de kuit
UPDATE words_lang SET notes = '• Ik heb kramp in mijn kuit! — ¡Tengo un calambre en la pantorrilla!
• Mijn kuiten zijn stijf van het wandelen. — Tengo las pantorrillas cargadas de andar.
• Hij rekt zijn kuiten voor het hardlopen. — Estira las pantorrillas antes de correr.', updated_at = datetime('now')
WHERE word_es_id = 25 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 26: el tobillo -> de enkel
UPDATE words_lang SET notes = '• Ik heb mijn enkel verzwikt op de trap. — Me torcí el tobillo en la escalera.
• Mijn enkel is dik geworden. — Se me ha hinchado el tobillo.
• Het water kwam tot mijn enkels. — El agua me llegaba a los tobillos.', updated_at = datetime('now')
WHERE word_es_id = 26 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 27: el empeine -> de wreef
UPDATE words_lang SET notes = '• Deze schoenen knellen op de wreef. — Estos zapatos aprietan en el empeine.
• Ik heb een hoge wreef, dus veters moeten los. — Tengo el empeine alto, así que los cordones flojos.
• De bal raakte me vol op de wreef. — El balón me dio de lleno en el empeine.', updated_at = datetime('now')
WHERE word_es_id = 27 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 28: el pie -> de voet
UPDATE words_lang SET notes = '• Mijn voeten doen pijn van het lopen. — Me duelen los pies de andar.
• Ik ga te voet naar de supermarkt. — Voy a pie al supermercado.
• Pas op, je staat op mijn voet! — ¡Cuidado, me estás pisando el pie!', updated_at = datetime('now')
WHERE word_es_id = 28 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 29: el dedo del pie -> de teen
UPDATE words_lang SET notes = '• Ik heb mijn teen gestoten tegen het bed. — Me di con el dedo del pie contra la cama.
• Au, je staat op mijn tenen! — ¡Ay, me pisas los dedos!
• Hij liep op zijn tenen door de gang. — Caminó de puntillas por el pasillo.', updated_at = datetime('now')
WHERE word_es_id = 29 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 30: el pulgar -> de duim
UPDATE words_lang SET notes = '• Hij stak zijn duim op: prima! — Levantó el pulgar: ¡perfecto!
• Ik heb met de hamer op mijn duim geslagen. — Me di con el martillo en el pulgar.
• De baby zuigt op haar duim. — La bebé se chupa el pulgar.', updated_at = datetime('now')
WHERE word_es_id = 30 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 31: el indice -> de wijsvinger
UPDATE words_lang SET notes = '• Ze wees met haar wijsvinger naar de kaart. — Señaló el mapa con el índice.
• Niet wijzen met je wijsvinger, dat is onbeleefd. — No señales con el dedo, es de mala educación.
• Druk met je wijsvinger op de bel. — Pulsa el timbre con el índice.', updated_at = datetime('now')
WHERE word_es_id = 31 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 32: el dedo medio -> de middelvinger
UPDATE words_lang SET notes = '• De middelvinger is de langste vinger. — El dedo medio es el más largo.
• Mijn ring past alleen om mijn middelvinger. — El anillo solo me cabe en el dedo medio.
• Een middelvinger opsteken is erg grof. — Levantar el dedo medio es muy grosero.', updated_at = datetime('now')
WHERE word_es_id = 32 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 33: el anular -> de ringvinger
UPDATE words_lang SET notes = '• De trouwring draag je om je ringvinger. — La alianza se lleva en el anular.
• Mijn ringvinger is gezwollen, de ring zit vast. — Tengo el anular hinchado, el anillo no sale.
• In Nederland draag je de trouwring vaak rechts aan de ringvinger. — En Países Bajos la alianza suele llevarse en el anular derecho.', updated_at = datetime('now')
WHERE word_es_id = 33 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 34: el menique -> de pink
UPDATE words_lang SET notes = '• Ik heb mijn pink gestoten tegen de tafelpoot. — Me di el meñique contra la pata de la mesa.
• Ze drinkt thee met haar pink omhoog. — Bebe té con el meñique levantado.
• Pink beloven? — ¿Lo prometemos con el meñique? (promesa entre niños)', updated_at = datetime('now')
WHERE word_es_id = 34 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 35: el dedo gordo del pie -> de grote teen
UPDATE words_lang SET notes = '• Ik heb mijn grote teen gebroken tegen de deur. — Me rompí el dedo gordo contra la puerta.
• Er zit een gat in mijn sok bij de grote teen. — Tengo un agujero en el calcetín en el dedo gordo.
• Test het badwater even met je grote teen. — Prueba el agua del baño con el dedo gordo.', updated_at = datetime('now')
WHERE word_es_id = 35 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 36: el segundo dedo del pie -> de tweede teen
UPDATE words_lang SET notes = '• Mijn tweede teen is langer dan mijn grote teen. — Mi segundo dedo es más largo que el gordo.
• De tweede teen doet pijn in deze smalle schoenen. — El segundo dedo me duele con estos zapatos estrechos.
• Ik heb een blaar op mijn tweede teen. — Tengo una ampolla en el segundo dedo del pie.', updated_at = datetime('now')
WHERE word_es_id = 36 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 37: el tercer dedo del pie -> de derde teen
UPDATE words_lang SET notes = '• De pleister zit om mijn derde teen. — La tirita está en el tercer dedo del pie.
• Mijn derde teen is gevoelig na het wandelen. — El tercer dedo me molesta después de la caminata.
• De podoloog keek naar mijn derde teen. — El podólogo me miró el tercer dedo del pie.', updated_at = datetime('now')
WHERE word_es_id = 37 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 38: el cuarto dedo del pie -> de vierde teen
UPDATE words_lang SET notes = '• Ik voel een likdoorn op mijn vierde teen. — Noto un callo en el cuarto dedo del pie.
• De vierde teen zit klem in deze schoen. — El cuarto dedo va apretado en este zapato.
• Mijn vierde teen is blauw na de stoot. — El cuarto dedo está morado tras el golpe.', updated_at = datetime('now')
WHERE word_es_id = 38 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 39: el dedo pequeno del pie -> de kleine teen
UPDATE words_lang SET notes = '• Iedereen stoot weleens zijn kleine teen tegen het bed. — Todo el mundo se golpea alguna vez el meñique del pie con la cama.
• Mijn kleine teen is rood van de nieuwe schoenen. — El dedo pequeño está rojo por los zapatos nuevos.
• Au! Precies op mijn kleine teen! — ¡Ay! ¡Justo en el dedo pequeño!', updated_at = datetime('now')
WHERE word_es_id = 39 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 40: el cabello -> het haar
UPDATE words_lang SET notes = '• Ik ga mijn haar laten knippen. — Voy a cortarme el pelo.
• Je haar zit leuk vandaag! — ¡Qué bien te queda hoy el pelo!
• Mijn haar is nat van de regen. — Tengo el pelo mojado por la lluvia.', updated_at = datetime('now')
WHERE word_es_id = 40 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 41: la frente -> het voorhoofd
UPDATE words_lang SET notes = '• Hij heeft zweet op zijn voorhoofd. — Tiene sudor en la frente.
• Ik voelde aan haar voorhoofd of ze koorts had. — Le toqué la frente para ver si tenía fiebre.
• Hij stootte zijn voorhoofd tegen het keukenkastje. — Se dio con la frente en el armario de la cocina.', updated_at = datetime('now')
WHERE word_es_id = 41 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 42: la ceja -> de wenkbrauw
UPDATE words_lang SET notes = '• Ze laat haar wenkbrauwen epileren. — Se depila las cejas.
• Hij trok een wenkbrauw op van verbazing. — Levantó una ceja de asombro.
• Ik heb een wondje boven mijn wenkbrauw. — Tengo una heridita encima de la ceja.', updated_at = datetime('now')
WHERE word_es_id = 42 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 44: la pestana -> de wimper
UPDATE words_lang SET notes = '• Er zit een wimper in mijn oog. — Tengo una pestaña en el ojo.
• Ze heeft hele lange wimpers. — Tiene las pestañas muy largas.
• Blaas de wimper weg en doe een wens! — ¡Sopla la pestaña y pide un deseo!', updated_at = datetime('now')
WHERE word_es_id = 44 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 45: el ojo -> het oog
UPDATE words_lang SET notes = '• Ik heb iets in mijn oog. — Tengo algo en el ojo.
• Doe je ogen dicht, verrassing! — ¡Cierra los ojos, sorpresa!
• Kun je een oogje op de kinderen houden? — ¿Puedes echar un ojo a los niños? (expresión común)', updated_at = datetime('now')
WHERE word_es_id = 45 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 46: la nariz -> de neus
UPDATE words_lang SET notes = '• Mijn neus loopt, ik ben verkouden. — Me gotea la nariz, estoy resfriado.
• Snuit je neus even. — Suénate la nariz.
• Hij loopt altijd achter zijn neus aan. — Va siempre a donde le lleva la nariz (sin rumbo fijo).', updated_at = datetime('now')
WHERE word_es_id = 46 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 47: la oreja -> het oor
UPDATE words_lang SET notes = '• Mijn oren doen pijn van de koude wind. — Me duelen las orejas por el viento frío.
• Hij luistert muziek met oortjes in zijn oren. — Escucha música con auriculares en las orejas.
• Ik zit tot over mijn oren in het werk. — Estoy hasta arriba de trabajo (lit. hasta las orejas).', updated_at = datetime('now')
WHERE word_es_id = 47 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 48: la mejilla -> de wang
UPDATE words_lang SET notes = '• In Nederland geef je drie kussen op de wang. — En Países Bajos se dan tres besos en la mejilla.
• Haar wangen zijn rood van de kou. — Tiene las mejillas rojas por el frío.
• De baby heeft van die bolle wangetjes. — El bebé tiene esos mofletes redonditos.', updated_at = datetime('now')
WHERE word_es_id = 48 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 49: la boca -> de mond
UPDATE words_lang SET notes = '• Doe je mond open, zegt de tandarts. — Abre la boca, dice el dentista.
• Praat niet met volle mond! — ¡No hables con la boca llena!
• Hou je mond even, ik ben aan het bellen. — Cállate un momento, estoy al teléfono (informal).', updated_at = datetime('now')
WHERE word_es_id = 49 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 50: el labio -> de lip
UPDATE words_lang SET notes = '• Mijn lippen zijn droog van de kou. — Tengo los labios secos por el frío.
• Ze beet op haar lip van de zenuwen. — Se mordió el labio de los nervios.
• Ik heb een koortslip, wat vervelend. — Tengo un herpes labial, qué fastidio.', updated_at = datetime('now')
WHERE word_es_id = 50 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 51: el diente -> de tand
UPDATE words_lang SET notes = '• Poets je tanden voor het slapen. — Cepíllate los dientes antes de dormir.
• Ik heb kiespijn, ik moet naar de tandarts. — Me duele una muela, tengo que ir al dentista.
• De peuter krijgt zijn eerste tandjes. — Al niño le están saliendo los primeros dientes.', updated_at = datetime('now')
WHERE word_es_id = 51 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 52: la encia -> het tandvlees
UPDATE words_lang SET notes = '• Mijn tandvlees bloedt bij het poetsen. — Me sangran las encías al cepillarme.
• De tandarts zegt dat mijn tandvlees ontstoken is. — El dentista dice que tengo la encía inflamada.
• Flossen is goed voor je tandvlees. — Usar hilo dental es bueno para las encías.', updated_at = datetime('now')
WHERE word_es_id = 52 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 53: el paladar -> het gehemelte
UPDATE words_lang SET notes = '• Ik heb mijn gehemelte verbrand aan de hete thee. — Me quemé el paladar con el té caliente.
• De pindakaas plakt aan mijn gehemelte. — La crema de cacahuete se me pega al paladar.
• Chips kunnen scherp zijn tegen je gehemelte. — Las patatas fritas pueden raspar el paladar.', updated_at = datetime('now')
WHERE word_es_id = 53 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 54: la lengua -> de tong
UPDATE words_lang SET notes = '• Ik heb mijn tong gebrand aan de soep. — Me quemé la lengua con la sopa.
• Steek je tong eens uit, zegt de dokter. — Saca la lengua, dice el médico.
• Het ligt op het puntje van mijn tong. — Lo tengo en la punta de la lengua.', updated_at = datetime('now')
WHERE word_es_id = 54 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 55: la barbilla -> de kin
UPDATE words_lang SET notes = '• Hij steunde zijn kin op zijn hand. — Apoyaba la barbilla en la mano.
• Er zit chocolade op je kin. — Tienes chocolate en la barbilla.
• De helmband zit strak onder mijn kin. — La correa del casco va apretada bajo la barbilla.', updated_at = datetime('now')
WHERE word_es_id = 55 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 56: la barba -> de baard
UPDATE words_lang SET notes = '• Hij laat zijn baard staan deze winter. — Se está dejando barba este invierno.
• Mijn baard moet bijgewerkt worden. — Tengo que recortarme la barba.
• Sinterklaas heeft een lange witte baard. — Sinterklaas tiene una larga barba blanca.', updated_at = datetime('now')
WHERE word_es_id = 56 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 57: el bigote -> de snor
UPDATE words_lang SET notes = '• Hij heeft zijn snor afgeschoren. — Se ha afeitado el bigote.
• Er hangt melkschuim aan je snor. — Tienes espuma de leche en el bigote.
• Mijn opa draagt al veertig jaar een snor. — Mi abuelo lleva bigote desde hace cuarenta años.', updated_at = datetime('now')
WHERE word_es_id = 57 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 58: el biceps -> de biceps
UPDATE words_lang SET notes = '• Hij traint zijn biceps in de sportschool. — Entrena los bíceps en el gimnasio.
• Kijk, wat een biceps! — ¡Mira qué bíceps!
• Mijn biceps heeft spierpijn van gisteren. — Tengo agujetas en el bíceps de ayer.', updated_at = datetime('now')
WHERE word_es_id = 58 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 59: el triceps -> de triceps
UPDATE words_lang SET notes = '• Vergeet je triceps niet te trainen. — No olvides entrenar el tríceps.
• Deze oefening is goed voor de triceps. — Este ejercicio es bueno para el tríceps.
• Mijn triceps trilt na de push-ups. — El tríceps me tiembla tras las flexiones.', updated_at = datetime('now')
WHERE word_es_id = 59 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 60: los gluteos -> de billen
UPDATE words_lang SET notes = '• Squats zijn goed voor je billen. — Las sentadillas son buenas para los glúteos.
• De baby heeft een rode billetjes van de luier. — El bebé tiene el culito irritado por el pañal.
• Mijn billen doen zeer van het fietszadel. — Me duelen los glúteos por el sillín de la bici.', updated_at = datetime('now')
WHERE word_es_id = 60 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 61: el culo -> de kont
UPDATE words_lang SET notes = '• Ik viel op mijn kont op het ijs. — Me caí de culo en el hielo (informal).
• Kom van je kont en help even mee! — ¡Levanta el culo y ayuda! (muy coloquial)
• Die broek zit strak om de kont. — Ese pantalón queda ajustado en el culo.', updated_at = datetime('now')
WHERE word_es_id = 61 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 62: la una -> de nagel
UPDATE words_lang SET notes = '• Ik moet mijn nagels knippen. — Tengo que cortarme las uñas.
• Ze lakt haar nagels rood. — Se pinta las uñas de rojo.
• Niet op je nagels bijten! — ¡No te muerdas las uñas!', updated_at = datetime('now')
WHERE word_es_id = 62 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 63: la piel -> de huid
UPDATE words_lang SET notes = '• Mijn huid is droog in de winter. — Tengo la piel seca en invierno.
• Smeer je huid in met zonnebrand. — Ponte crema solar en la piel.
• Baby''s hebben een hele zachte huid. — Los bebés tienen la piel muy suave.', updated_at = datetime('now')
WHERE word_es_id = 63 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 64: el hueso -> het bot
UPDATE words_lang SET notes = '• Gelukkig is er geen bot gebroken. — Por suerte no hay ningún hueso roto.
• De hond kauwt op een bot. — El perro mordisquea un hueso.
• Melk is goed voor je botten. — La leche es buena para los huesos.', updated_at = datetime('now')
WHERE word_es_id = 64 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 65: el musculo -> de spier
UPDATE words_lang SET notes = '• Ik heb een spier verrekt met voetballen. — Me estiré un músculo jugando al fútbol.
• Spierpijn na het sporten is normaal. — Las agujetas después del deporte son normales.
• Warm je spieren goed op. — Calienta bien los músculos.', updated_at = datetime('now')
WHERE word_es_id = 65 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 66: los genitales -> de geslachtsdelen
UPDATE words_lang SET notes = '• De dokter onderzoekt de geslachtsdelen alleen als het nodig is. — El médico examina los genitales solo si es necesario.
• Het is een formeel/medisch woord voor de intieme delen. — Es la palabra formal/médica para las partes íntimas.
• Bescherm je geslachtsdelen met een tok bij het sporten. — Protege los genitales con una coquilla al hacer deporte.', updated_at = datetime('now')
WHERE word_es_id = 66 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 67: el parpado -> het ooglid
UPDATE words_lang SET notes = '• Mijn ooglid trilt van vermoeidheid. — Me tiembla el párpado del cansancio.
• Er zit een strontje op mijn ooglid. — Tengo un orzuelo en el párpado.
• Mijn oogleden worden zwaar, ik ga slapen. — Se me cierran los párpados, me voy a dormir.', updated_at = datetime('now')
WHERE word_es_id = 67 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- ============================================================
-- DORMITORIO
-- ============================================================

-- 68: la habitacion -> de slaapkamer
UPDATE words_lang SET notes = '• Ik ga mijn slaapkamer opruimen. — Voy a ordenar mi habitación.
• De slaapkamer is boven, naast de badkamer. — El dormitorio está arriba, junto al baño.
• We zoeken een huis met drie slaapkamers. — Buscamos una casa con tres dormitorios.', updated_at = datetime('now')
WHERE word_es_id = 68 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 69: la cama -> het bed
UPDATE words_lang SET notes = '• Ik ga naar bed, ik ben moe. — Me voy a la cama, estoy cansado.
• Heb je je bed al opgemaakt? — ¿Ya has hecho la cama?
• De kat ligt lekker op het bed. — El gato está a gusto en la cama.', updated_at = datetime('now')
WHERE word_es_id = 69 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 70: la lampara -> de lamp
UPDATE words_lang SET notes = '• Doe de lamp even aan, het is donker. — Enciende la lámpara, está oscuro.
• Deze lamp is stuk, het lampje moet vervangen. — Esta lámpara está rota, hay que cambiar la bombilla.
• We hebben een nieuwe lamp bij IKEA gekocht. — Compramos una lámpara nueva en IKEA.', updated_at = datetime('now')
WHERE word_es_id = 70 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 71: la mesa de noche -> het nachtkastje
UPDATE words_lang SET notes = '• Mijn bril ligt op het nachtkastje. — Mis gafas están en la mesita de noche.
• In de la van het nachtkastje ligt de oplader. — En el cajón de la mesita está el cargador.
• Zet het glas water op je nachtkastje. — Pon el vaso de agua en tu mesita de noche.', updated_at = datetime('now')
WHERE word_es_id = 71 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 72: el edredon -> het dekbed
UPDATE words_lang SET notes = '• Ik kruip lekker onder het dekbed. — Me meto a gustito bajo el edredón.
• Het dekbedovertrek moet in de was. — La funda del edredón tiene que lavarse.
• In de zomer gebruik ik een dun dekbed. — En verano uso un edredón fino.', updated_at = datetime('now')
WHERE word_es_id = 72 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 73: la sabana -> het laken
UPDATE words_lang SET notes = '• Ik verschoon de lakens elke week. — Cambio las sábanas cada semana.
• Het hoeslaken past niet om het matras. — La sábana bajera no encaja en el colchón.
• Er ligt een schoon laken op het bed. — Hay una sábana limpia en la cama.', updated_at = datetime('now')
WHERE word_es_id = 73 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 74: la almohada -> het kussen
UPDATE words_lang SET notes = '• Mijn kussen is te hard, ik slaap slecht. — Mi almohada es muy dura, duermo mal.
• Ik heb twee kussens op mijn bed. — Tengo dos almohadas en mi cama.
• Sla je arm om het kussen heen. — Abraza la almohada con el brazo.', updated_at = datetime('now')
WHERE word_es_id = 74 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 75: la frazada -> de deken
UPDATE words_lang SET notes = '• Pak een deken, het is koud vanavond. — Coge una manta, hace frío esta noche.
• De baby ligt onder een warm dekentje. — El bebé está bajo una mantita calentita.
• We zaten met een deken op de bank film te kijken. — Estábamos en el sofá con una manta viendo una peli.', updated_at = datetime('now')
WHERE word_es_id = 75 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 76: la manta -> de deken
UPDATE words_lang SET notes = '• Wil je een extra deken voor de logeerkamer? — ¿Quieres una manta extra para el cuarto de invitados?
• Ik neem een deken mee naar het park. — Me llevo una manta al parque.
• De deken kriebelt een beetje. — La manta pica un poco.', updated_at = datetime('now')
WHERE word_es_id = 76 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 77: las cortinas -> de gordijnen
UPDATE words_lang SET notes = '• Doe de gordijnen dicht, de zon schijnt fel. — Cierra las cortinas, el sol pega fuerte.
• In Nederland laten veel mensen de gordijnen open. — En Países Bajos mucha gente deja las cortinas abiertas.
• Deze gordijnen moeten gewassen worden. — Estas cortinas hay que lavarlas.', updated_at = datetime('now')
WHERE word_es_id = 77 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 78: la persiana -> het rolgordijn
UPDATE words_lang SET notes = '• Ik doe het rolgordijn naar beneden. — Bajo la persiana enrollable.
• Het rolgordijn houdt het licht goed tegen. — El estor bloquea bien la luz.
• Het rolgordijn zit vast, help even. — La persiana se ha atascado, ayúdame.', updated_at = datetime('now')
WHERE word_es_id = 78 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 79: el armario -> de kast
UPDATE words_lang SET notes = '• Hang je jas in de kast. — Cuelga tu abrigo en el armario.
• De kast puilt uit van de kleren. — El armario está a reventar de ropa.
• Ik heb de handdoeken in de kast gelegd. — He puesto las toallas en el armario.', updated_at = datetime('now')
WHERE word_es_id = 79 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 80: el colchon -> de matras
UPDATE words_lang SET notes = '• Dit matras ligt heerlijk. — Este colchón es comodísimo.
• We moeten een nieuw matras kopen. — Tenemos que comprar un colchón nuevo.
• Draai het matras af en toe om. — Dale la vuelta al colchón de vez en cuando.', updated_at = datetime('now')
WHERE word_es_id = 80 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 81: la alfombra -> het tapijt
UPDATE words_lang SET notes = '• Het tapijt moet gestofzuigd worden. — Hay que pasar la aspiradora a la alfombra.
• Ik heb koffie op het tapijt gemorst. — He derramado café en la alfombra.
• Een zacht tapijt is fijn voor koude voeten. — Una alfombra suave es agradable para los pies fríos.', updated_at = datetime('now')
WHERE word_es_id = 81 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 82: el despertador -> de wekker
UPDATE words_lang SET notes = '• Ik zet de wekker op zeven uur. — Pongo el despertador a las siete.
• De wekker ging niet af, ik ben te laat! — ¡No sonó el despertador, llego tarde!
• Ik druk altijd drie keer op de snooze van de wekker. — Siempre le doy tres veces al snooze del despertador.', updated_at = datetime('now')
WHERE word_es_id = 82 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 83: la television -> de televisie
UPDATE words_lang SET notes = '• Zet de televisie even uit tijdens het eten. — Apaga la tele durante la comida.
• Wat is er vanavond op televisie? — ¿Qué ponen esta noche en la tele?
• We kijken het nieuws op televisie. — Vemos las noticias en la televisión.', updated_at = datetime('now')
WHERE word_es_id = 83 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 84: el cargador -> de oplader
UPDATE words_lang SET notes = '• Heb je een oplader voor mijn telefoon? — ¿Tienes un cargador para mi móvil?
• Mijn oplader zit nog in het stopcontact. — Mi cargador sigue enchufado.
• Ik ben mijn oplader op het werk vergeten. — Me dejé el cargador en el trabajo.', updated_at = datetime('now')
WHERE word_es_id = 84 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 85: las chanclas -> de slippers
UPDATE words_lang SET notes = '• Ik loop op slippers naar het strand. — Voy en chanclas a la playa.
• Doe je slippers aan in het zwembad. — Ponte las chanclas en la piscina.
• Mijn slipper is kapot, de band is los. — Se me rompió la chancla, la tira está suelta.', updated_at = datetime('now')
WHERE word_es_id = 85 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 86: el pijama -> de pyjama
UPDATE words_lang SET notes = '• Ik doe mijn pyjama aan en ga bankhangen. — Me pongo el pijama y me tiro al sofá.
• De kinderen lopen nog in pyjama rond. — Los niños siguen en pijama.
• Zaterdagochtend blijf ik lekker in mijn pyjama. — El sábado por la mañana me quedo a gusto en pijama.', updated_at = datetime('now')
WHERE word_es_id = 86 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 87: los calcetines -> de sokken
UPDATE words_lang SET notes = '• Ik kan mijn sokken niet vinden. — No encuentro mis calcetines.
• Er zit een gat in mijn sok. — Tengo un agujero en el calcetín.
• Trek warme sokken aan, het vriest. — Ponte calcetines calientes, está helando.', updated_at = datetime('now')
WHERE word_es_id = 87 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 88: el cabecero de la cama -> het hoofdeinde
UPDATE words_lang SET notes = '• Ik zet mijn kussen tegen het hoofdeinde. — Apoyo la almohada contra el cabecero.
• Het hoofdeinde van het bed staat tegen de muur. — El cabecero de la cama está contra la pared.
• Kun je het hoofdeinde iets omhoog zetten? — ¿Puedes subir un poco el cabecero? (cama articulada)', updated_at = datetime('now')
WHERE word_es_id = 88 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 89: el somier -> de bedbodem
UPDATE words_lang SET notes = '• De bedbodem kraakt als ik me omdraai. — El somier cruje cuando me doy la vuelta.
• Een goede bedbodem is net zo belangrijk als het matras. — Un buen somier es tan importante como el colchón.
• Er is een lat van de bedbodem gebroken. — Se ha roto una lama del somier.', updated_at = datetime('now')
WHERE word_es_id = 89 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 90: el cuadro -> het schilderij
UPDATE words_lang SET notes = '• Er hangt een mooi schilderij boven de bank. — Hay un cuadro bonito encima del sofá.
• Hangt het schilderij recht zo? — ¿Está recto así el cuadro?
• We hebben dit schilderij op een markt gekocht. — Compramos este cuadro en un mercadillo.', updated_at = datetime('now')
WHERE word_es_id = 90 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 91: el marco de una foto -> de fotolijst
UPDATE words_lang SET notes = '• De trouwfoto staat in een zilveren fotolijst. — La foto de boda está en un marco plateado.
• Ik zoek een fotolijst van 20 bij 30. — Busco un marco de fotos de 20 por 30.
• De fotolijst viel van de plank. — El marco de fotos se cayó de la repisa.', updated_at = datetime('now')
WHERE word_es_id = 91 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 92: el foco -> de gloeilamp
UPDATE words_lang SET notes = '• De gloeilamp is kapot, kun jij hem vervangen? — La bombilla está fundida, ¿la cambias tú?
• Ik koop ledlampen in plaats van gloeilampen. — Compro bombillas led en vez de incandescentes.
• Pas op, de gloeilamp is nog heet. — Cuidado, la bombilla todavía quema.', updated_at = datetime('now')
WHERE word_es_id = 92 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 93: la puerta -> de deur
UPDATE words_lang SET notes = '• Doe de deur even dicht, het tocht. — Cierra la puerta, hay corriente.
• Er staat iemand voor de deur. — Hay alguien en la puerta.
• Vergeet niet de deur op slot te doen. — No olvides cerrar la puerta con llave.', updated_at = datetime('now')
WHERE word_es_id = 93 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 94: la cerradura -> het slot
UPDATE words_lang SET notes = '• De sleutel past niet op het slot. — La llave no encaja en la cerradura.
• Het slot van de schuur is geroest. — La cerradura del cobertizo está oxidada.
• Doe je fiets altijd op slot! — ¡Pon siempre el candado a la bici! (costumbre holandesa básica)', updated_at = datetime('now')
WHERE word_es_id = 94 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 95: el marco de la puerta -> de deurkozijn
UPDATE words_lang SET notes = '• Ik stootte mijn hoofd tegen het deurkozijn. — Me di con la cabeza en el marco de la puerta.
• Het deurkozijn moet geschilderd worden. — Hay que pintar el marco de la puerta.
• Hij leunde tegen het deurkozijn. — Estaba apoyado en el marco de la puerta.', updated_at = datetime('now')
WHERE word_es_id = 95 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 96: las pantuflas -> de pantoffels
UPDATE words_lang SET notes = '• Waar zijn mijn pantoffels? Mijn voeten zijn koud. — ¿Dónde están mis pantuflas? Tengo los pies fríos.
• Opa loopt de hele dag op pantoffels. — El abuelo va todo el día en zapatillas de casa.
• Ik kreeg nieuwe pantoffels voor Sinterklaas. — Me regalaron pantuflas nuevas por Sinterklaas.', updated_at = datetime('now')
WHERE word_es_id = 96 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 97: el borde de la cama -> de bedrand
UPDATE words_lang SET notes = '• Hij zat op de bedrand zijn sokken aan te trekken. — Estaba sentado en el borde de la cama poniéndose los calcetines.
• Ik stootte mijn scheen tegen de bedrand. — Me di en la espinilla con el borde de la cama.
• De kat slaapt graag op de bedrand. — Al gato le gusta dormir en el borde de la cama.', updated_at = datetime('now')
WHERE word_es_id = 97 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 98: el tomacorriente -> het stopcontact
UPDATE words_lang SET notes = '• Zit de stekker wel in het stopcontact? — ¿Está el enchufe metido en la toma?
• Er is geen stopcontact bij het nachtkastje. — No hay toma de corriente junto a la mesita.
• Kindveilige stopcontacten zijn belangrijk. — Las tomas con protección infantil son importantes.', updated_at = datetime('now')
WHERE word_es_id = 98 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 99: el enchufe -> de stekker
UPDATE words_lang SET notes = '• Trek de stekker eruit voor je hem schoonmaakt. — Desenchúfalo antes de limpiarlo.
• De stekker past niet in dit stopcontact. — El enchufe no encaja en esta toma.
• Ik heb de stekker van de tv eruit getrokken. — He desenchufado la tele.', updated_at = datetime('now')
WHERE word_es_id = 99 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 100: el interruptor -> de schakelaar
UPDATE words_lang SET notes = '• De schakelaar zit naast de deur. — El interruptor está junto a la puerta.
• Deze schakelaar doet het niet. — Este interruptor no funciona.
• Druk op de schakelaar voor het licht. — Pulsa el interruptor para la luz.', updated_at = datetime('now')
WHERE word_es_id = 100 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 101: el reloj de pared -> de wandklok
UPDATE words_lang SET notes = '• De wandklok in de keuken loopt vijf minuten voor. — El reloj de pared de la cocina va cinco minutos adelantado.
• De batterij van de wandklok is leeg. — La pila del reloj de pared se ha gastado.
• Kijk even op de wandklok hoe laat het is. — Mira en el reloj de pared qué hora es.', updated_at = datetime('now')
WHERE word_es_id = 101 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 102: el rodapie -> de plint
UPDATE words_lang SET notes = '• Stofzuig ook even langs de plinten. — Pasa la aspiradora también por los rodapiés.
• De plint laat los in de gang. — El rodapié se está despegando en el pasillo.
• We schilderen de plinten wit. — Pintamos los rodapiés de blanco.', updated_at = datetime('now')
WHERE word_es_id = 102 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- ============================================================
-- SALON
-- ============================================================

-- 103: el salon -> de woonkamer
UPDATE words_lang SET notes = '• We zitten gezellig in de woonkamer. — Estamos a gusto en el salón.
• De woonkamer is net geverfd. — El salón está recién pintado.
• Kom binnen, de woonkamer is deze kant op. — Pasa, el salón es por aquí.', updated_at = datetime('now')
WHERE word_es_id = 103 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 104: el sofa -> de bank
UPDATE words_lang SET notes = '• Ik lig op de bank een serie te kijken. — Estoy en el sofá viendo una serie.
• De kat mag niet op de bank. — El gato no puede subirse al sofá.
• Let op: "de bank" is ook het geldkantoor. — Ojo: "de bank" también es el banco (de dinero).', updated_at = datetime('now')
WHERE word_es_id = 104 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 105: el sillon -> de fauteuil
UPDATE words_lang SET notes = '• Opa zit altijd in zijn fauteuil. — El abuelo siempre se sienta en su sillón.
• Deze fauteuil zit heerlijk. — Este sillón es comodísimo.
• We hebben een tweedehands fauteuil op Marktplaats gekocht. — Compramos un sillón de segunda mano en Marktplaats.', updated_at = datetime('now')
WHERE word_es_id = 105 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 106: la mesa de centro -> de salontafel
UPDATE words_lang SET notes = '• Zet de koffie maar op de salontafel. — Deja el café en la mesa de centro.
• Er liggen tijdschriften op de salontafel. — Hay revistas en la mesa de centro.
• Voeten van de salontafel, alsjeblieft! — ¡Los pies fuera de la mesita, por favor!', updated_at = datetime('now')
WHERE word_es_id = 106 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 107: la estanteria -> de boekenkast
UPDATE words_lang SET notes = '• De boekenkast staat vol met romans. — La estantería está llena de novelas.
• Ik moet de boekenkast nog in elkaar zetten. — Todavía tengo que montar la estantería.
• Zet het boek terug in de boekenkast. — Devuelve el libro a la estantería.', updated_at = datetime('now')
WHERE word_es_id = 107 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 108: el aparador -> het dressoir
UPDATE words_lang SET notes = '• Het servies staat in het dressoir. — La vajilla está en el aparador.
• Op het dressoir staan familiefoto''s. — Sobre el aparador hay fotos de familia.
• De sleutels liggen op het dressoir bij de deur. — Las llaves están sobre el aparador junto a la puerta.', updated_at = datetime('now')
WHERE word_es_id = 108 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 109: el control remoto -> de afstandsbediening
UPDATE words_lang SET notes = '• Waar is de afstandsbediening nou weer? — ¿Dónde está otra vez el mando?
• De batterijen van de afstandsbediening zijn leeg. — Las pilas del mando se han gastado.
• Geef de afstandsbediening eens door. — Pásame el mando.', updated_at = datetime('now')
WHERE word_es_id = 109 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 110: el equipo de musica -> de stereo-installatie
UPDATE words_lang SET notes = '• Hij zet de stereo-installatie keihard aan. — Pone el equipo de música a todo volumen.
• De stereo-installatie is al twintig jaar oud. — El equipo de música tiene ya veinte años.
• Tegenwoordig zeggen veel mensen gewoon "speaker" of "geluidsinstallatie". — Hoy en día mucha gente dice simplemente "speaker" o "geluidsinstallatie".', updated_at = datetime('now')
WHERE word_es_id = 110 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 111: los altavoces -> de luidsprekers
UPDATE words_lang SET notes = '• De luidsprekers kraken een beetje. — Los altavoces chisporrotean un poco.
• Sluit je telefoon aan op de luidsprekers. — Conecta el móvil a los altavoces.
• In de spreektaal zegt bijna iedereen "speakers". — Coloquialmente casi todo el mundo dice "speakers".', updated_at = datetime('now')
WHERE word_es_id = 111 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 112: el espejo -> de spiegel
UPDATE words_lang SET notes = '• Ik kijk elke ochtend in de spiegel. — Me miro al espejo cada mañana.
• Er hangt een grote spiegel in de gang. — Hay un espejo grande en el pasillo.
• De spiegel beslaat na het douchen. — El espejo se empaña después de la ducha.', updated_at = datetime('now')
WHERE word_es_id = 112 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 113: el florero -> de vaas
UPDATE words_lang SET notes = '• Zet de tulpen in de vaas. — Pon los tulipanes en el florero.
• De vaas viel om en brak. — El jarrón se cayó y se rompió.
• Vers water in de vaas houdt bloemen langer goed. — Agua fresca en el jarrón conserva más las flores.', updated_at = datetime('now')
WHERE word_es_id = 113 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 114: las velas -> de kaarsen
UPDATE words_lang SET notes = '• We steken kaarsen aan, dat is gezellig. — Encendemos velas, da ambiente acogedor.
• Blaas de kaarsen uit voor je gaat slapen. — Apaga las velas antes de irte a dormir.
• Op de verjaardagstaart staan tien kaarsjes. — En la tarta de cumpleaños hay diez velitas.', updated_at = datetime('now')
WHERE word_es_id = 114 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 115: el candelabro -> de kandelaar
UPDATE words_lang SET notes = '• De kandelaar staat midden op tafel. — El candelabro está en el centro de la mesa.
• Ze poetst de zilveren kandelaar. — Está limpiando el candelabro de plata.
• Bij het kerstdiner stond er een kandelaar op tafel. — En la cena de Navidad había un candelabro en la mesa.', updated_at = datetime('now')
WHERE word_es_id = 115 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 116: la planta -> de plant
UPDATE words_lang SET notes = '• Vergeet niet de planten water te geven. — No olvides regar las plantas.
• Deze plant heeft veel licht nodig. — Esta planta necesita mucha luz.
• Nederlanders hebben vaak veel planten voor het raam. — Los holandeses suelen tener muchas plantas en la ventana.', updated_at = datetime('now')
WHERE word_es_id = 116 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 117: la lampara de pie -> de staande lamp
UPDATE words_lang SET notes = '• De staande lamp staat naast de bank. — La lámpara de pie está junto al sofá.
• Doe de staande lamp aan, dat leest fijner. — Enciende la lámpara de pie, se lee mejor.
• We zoeken een staande lamp voor de leeshoek. — Buscamos una lámpara de pie para el rincón de lectura.', updated_at = datetime('now')
WHERE word_es_id = 117 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 118: la lampara de techo -> de plafondlamp
UPDATE words_lang SET notes = '• De plafondlamp geeft veel licht. — La lámpara de techo da mucha luz.
• Kun je helpen de plafondlamp op te hangen? — ¿Me ayudas a colgar la lámpara de techo?
• De plafondlamp knippert, iets zit los. — La lámpara del techo parpadea, algo está suelto.', updated_at = datetime('now')
WHERE word_es_id = 118 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 119: el cojin -> het kussen
UPDATE words_lang SET notes = '• Er liggen vier kussens op de bank. — Hay cuatro cojines en el sofá.
• Pak een kussen voor je rug. — Coge un cojín para la espalda.
• Let op: "het kussen" is zowel cojín als almohada. — Ojo: "het kussen" vale para cojín y almohada.', updated_at = datetime('now')
WHERE word_es_id = 119 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 120: la ventana -> het raam
UPDATE words_lang SET notes = '• Doe het raam open, het is warm hier. — Abre la ventana, hace calor aquí.
• Ik kijk uit het raam naar de regen. — Miro por la ventana la lluvia.
• De ramen moeten gelapt worden. — Hay que limpiar los cristales.', updated_at = datetime('now')
WHERE word_es_id = 120 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 121: el marco de la ventana -> het raamkozijn
UPDATE words_lang SET notes = '• De kat zit graag op het raamkozijn. — Al gato le gusta sentarse en el marco de la ventana.
• Het raamkozijn is rot, het moet vervangen. — El marco de la ventana está podrido, hay que cambiarlo.
• Er staan plantjes op het raamkozijn. — Hay plantitas en el alféizar/marco de la ventana.', updated_at = datetime('now')
WHERE word_es_id = 121 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 122: la repisa -> de plank
UPDATE words_lang SET notes = '• Zet de foto op de plank. — Pon la foto en la repisa.
• De plank hangt scheef. — La balda está torcida.
• Op de bovenste plank staan de kookboeken. — En la balda de arriba están los libros de cocina.', updated_at = datetime('now')
WHERE word_es_id = 122 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 123: la calefaccion -> de verwarming
UPDATE words_lang SET notes = '• Zet de verwarming wat hoger, ik heb het koud. — Sube la calefacción, tengo frío.
• De verwarming doet het niet, bel de monteur. — La calefacción no funciona, llama al técnico.
• In Nederland gaat de verwarming vaak pas in oktober aan. — En Países Bajos la calefacción no suele encenderse hasta octubre.', updated_at = datetime('now')
WHERE word_es_id = 123 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 124: el radiador -> de radiator
UPDATE words_lang SET notes = '• De radiator in de badkamer wordt niet warm. — El radiador del baño no calienta.
• Hang je natte handschoenen op de radiator. — Pon los guantes mojados sobre el radiador.
• De radiator moet ontlucht worden. — Hay que purgar el radiador.', updated_at = datetime('now')
WHERE word_es_id = 124 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 125: el aire acondicionado -> de airconditioning
UPDATE words_lang SET notes = '• Zet de airconditioning aan, het is bloedheet. — Pon el aire acondicionado, hace un calor horrible.
• Weinig huizen in Nederland hebben airconditioning. — Pocas casas en Países Bajos tienen aire acondicionado.
• In de spreektaal zegt iedereen gewoon "airco". — Coloquialmente todo el mundo dice "airco".', updated_at = datetime('now')
WHERE word_es_id = 125 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 126: el ventilador -> de ventilator
UPDATE words_lang SET notes = '• Zet de ventilator aan, dat koelt lekker af. — Enciende el ventilador, refresca bien.
• De ventilator maakt veel lawaai op de hoogste stand. — El ventilador hace mucho ruido al máximo.
• Bij een hittegolf zijn ventilators overal uitverkocht. — En una ola de calor los ventiladores se agotan en todas partes.', updated_at = datetime('now')
WHERE word_es_id = 126 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 127: los libros -> de boeken
UPDATE words_lang SET notes = '• Ik leen boeken bij de bibliotheek. — Tomo libros prestados de la biblioteca.
• Zijn boeken liggen overal in huis. — Sus libros están por toda la casa.
• Ik lees elke avond een paar bladzijden uit mijn boek. — Cada noche leo unas páginas de mi libro.', updated_at = datetime('now')
WHERE word_es_id = 127 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 128: la chimenea -> de open haard
UPDATE words_lang SET notes = '• We steken de open haard aan, lekker warm. — Encendemos la chimenea, qué calentito.
• Bij de open haard zitten is echt gezellig. — Sentarse junto a la chimenea es muy acogedor.
• De open haard moet geveegd worden. — Hay que deshollinar la chimenea.', updated_at = datetime('now')
WHERE word_es_id = 128 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- ============================================================
-- FRASES Y EXPRESIONES COTIDIANAS (Floor - Regla 37)
-- ============================================================

-- 129: regalar algo -> iets weggeven
UPDATE words_lang SET notes = '• Ik ga deze jas weggeven, ik draag hem nooit. — Voy a regalar este abrigo, nunca me lo pongo.
• Waarom zou je iets weggeven wat nog goed is? Gewoon verkopen! — ¿Por qué regalar algo que aún está bien? ¡Véndelo!
• Op Marktplaats kun je spullen gratis weggeven. — En Marktplaats puedes regalar cosas gratis.', updated_at = datetime('now')
WHERE word_es_id = 129 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 130: no siempre -> niet altijd
UPDATE words_lang SET notes = '• Het is niet altijd makkelijk, maar het lukt wel. — No siempre es fácil, pero se consigue.
• Ik heb niet altijd zin om te koken. — No siempre tengo ganas de cocinar.
• De trein is niet altijd op tijd. — El tren no siempre llega puntual.', updated_at = datetime('now')
WHERE word_es_id = 130 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 131: una buena idea -> een goed idee
UPDATE words_lang SET notes = '• Zullen we pizza bestellen? Ja, goed idee! — ¿Pedimos pizza? ¡Sí, buena idea!
• Dat lijkt me geen goed idee. — Eso no me parece buena idea.
• Wat een goed idee om samen te gaan fietsen. — Qué buena idea ir juntos en bici.', updated_at = datetime('now')
WHERE word_es_id = 131 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 132: el refugiado -> de vluchteling
UPDATE words_lang SET notes = '• Er wonen vluchtelingen in de opvang bij ons in de buurt. — Viven refugiados en el centro de acogida de nuestro barrio.
• Veel vluchtelingen leren snel Nederlands. — Muchos refugiados aprenden neerlandés rápido.
• De gemeente zoekt woningen voor vluchtelingen. — El ayuntamiento busca viviendas para refugiados.', updated_at = datetime('now')
WHERE word_es_id = 132 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 133: la refugiada -> de vluchteling
UPDATE words_lang SET notes = '• Zij is een vluchteling uit Syrië. — Ella es una refugiada de Siria.
• De vluchteling en haar kinderen kregen een woning. — La refugiada y sus hijos recibieron una vivienda.
• "Vluchteling" is voor mannen en vrouwen hetzelfde woord. — "Vluchteling" es la misma palabra para hombres y mujeres.', updated_at = datetime('now')
WHERE word_es_id = 133 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 134: de donde? -> waarvandaan?
UPDATE words_lang SET notes = '• Waarvandaan kom je? Uit Spanje. — ¿De dónde vienes? De España.
• Waarvandaan vertrekt de trein? — ¿De dónde sale el tren?
• Je hoort ook vaak: waar kom je vandaan? — También se oye mucho: waar kom je vandaan?', updated_at = datetime('now')
WHERE word_es_id = 134 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 135: que se yo -> weet ik veel
UPDATE words_lang SET notes = '• Hoe laat komt hij? Weet ik veel! — ¿A qué hora viene? ¡Y yo qué sé!
• Waarom doet de wifi het niet? Weet ik veel... — ¿Por qué no va el wifi? Qué sé yo...
• Es informal y puede sonar borde si lo dices serio. — Informeel; kan bot klinken als je het serieus zegt.', updated_at = datetime('now')
WHERE word_es_id = 135 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 136: en absoluto -> helemaal niet
UPDATE words_lang SET notes = '• Vind je het erg? Nee, helemaal niet! — ¿Te importa? ¡No, en absoluto!
• Ik ben helemaal niet moe. — No estoy cansado en absoluto.
• Dat was helemaal niet nodig geweest. — Eso no habría sido necesario en absoluto.', updated_at = datetime('now')
WHERE word_es_id = 136 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 137: parecerse a -> lijken op
UPDATE words_lang SET notes = '• Hij lijkt op zijn vader. — Se parece a su padre.
• Dat huis lijkt op het onze. — Esa casa se parece a la nuestra.
• Waar lijkt het op? Op niets! — ¿A qué se parece? ¡A nada! (queja informal)', updated_at = datetime('now')
WHERE word_es_id = 137 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 138: el jersey -> de trui
UPDATE words_lang SET notes = '• Trek een warme trui aan, het is fris. — Ponte un jersey calentito, hace fresco.
• Deze trui kriebelt een beetje. — Este jersey pica un poco.
• Ik heb een foute kersttrui voor het kerstfeest. — Tengo un jersey navideño hortera para la fiesta.', updated_at = datetime('now')
WHERE word_es_id = 138 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 139: el hoverboard -> het hoverboard
UPDATE words_lang SET notes = '• De buurjongen rijdt op zijn hoverboard door de straat. — El niño del vecino va por la calle en su hoverboard.
• Hij is van zijn hoverboard gevallen. — Se ha caído del hoverboard.
• Het hoverboard moet nog opgeladen worden. — El hoverboard todavía tiene que cargarse.', updated_at = datetime('now')
WHERE word_es_id = 139 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 140: dejame en paz -> rot op
UPDATE words_lang SET notes = '• Rot op, ik wil je niet meer zien! — ¡Lárgate, no quiero verte más! (muy grosero)
• Rot toch op met je smoesjes. — Déjame en paz con tus excusas (enfadado).
• ¡Ojo! Es muy fuerte; entre amigos también expresa incredulidad: Rot op! ¿En serio? — Pas op: heel grof; onder vrienden ook ongeloof.', updated_at = datetime('now')
WHERE word_es_id = 140 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 141: han entrado a robar -> er is ingebroken
UPDATE words_lang SET notes = '• Er is bij de buren ingebroken. — Han entrado a robar en casa de los vecinos.
• Vannacht is er ingebroken in de sportschool. — Anoche entraron a robar en el gimnasio.
• Als er is ingebroken, bel je de politie via 0900-8844. — Si han entrado a robar, llamas a la policía al 0900-8844.', updated_at = datetime('now')
WHERE word_es_id = 141 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 142: han robado -> ze hebben gejat
UPDATE words_lang SET notes = '• Ze hebben mijn fiets gejat! — ¡Me han robado la bici! (queja holandesa clásica)
• Ze hebben mijn portemonnee gejat op de markt. — Me han robado la cartera en el mercado.
• "Jatten" is spreektaal voor stelen. — "Jatten" es coloquial para robar.', updated_at = datetime('now')
WHERE word_es_id = 142 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 143: lo regale -> heb ik weggegeven
UPDATE words_lang SET notes = '• Waar is je oude bank? Die heb ik weggegeven. — ¿Dónde está tu sofá viejo? Lo regalé.
• Mijn oude telefoon heb ik aan mijn zusje weggegeven. — Mi móvil viejo se lo regalé a mi hermana pequeña.
• De boeken die ik dubbel had, heb ik weggegeven. — Los libros que tenía repetidos los regalé.', updated_at = datetime('now')
WHERE word_es_id = 143 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 144: por caridad -> uit liefdadigheid
UPDATE words_lang SET notes = '• Ze werkt één dag per week uit liefdadigheid. — Trabaja un día a la semana por caridad.
• Hij gaf het geld uit liefdadigheid, niet voor de aandacht. — Dio el dinero por caridad, no por llamar la atención.
• Doe het niet uit liefdadigheid, doe het omdat je het wilt. — No lo hagas por caridad, hazlo porque quieres.', updated_at = datetime('now')
WHERE word_es_id = 144 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 145: la caridad -> de liefdadigheid
UPDATE words_lang SET notes = '• De opbrengst gaat naar liefdadigheid. — La recaudación va a la caridad/beneficencia.
• Hij doet veel aan liefdadigheid. — Colabora mucho con obras benéficas.
• Een liefdadigheidsactie voor de voedselbank. — Una acción benéfica para el banco de alimentos.', updated_at = datetime('now')
WHERE word_es_id = 145 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 146: no tienes hambre? -> heb je geen honger?
UPDATE words_lang SET notes = '• Heb je geen honger? Je hebt bijna niets gegeten. — ¿No tienes hambre? Casi no has comido.
• Heb je geen honger? We kunnen wat bestellen. — ¿No tienes hambre? Podemos pedir algo.
• Nee hoor, ik heb net geluncht. — No, es que acabo de comer. (respuesta típica)', updated_at = datetime('now')
WHERE word_es_id = 146 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 147: en serio, deberias comer algo. -> je moet echt even wat eten
UPDATE words_lang SET notes = '• Je ziet bleek, je moet echt even wat eten. — Estás pálido, en serio deberías comer algo.
• Voor het tentamen moet je echt even wat eten. — Antes del examen de verdad tienes que comer algo.
• "Even" y "wat" suavizan la frase, típico del neerlandés hablado. — "Even" en "wat" maken de zin zachter; heel typisch spreektaal.', updated_at = datetime('now')
WHERE word_es_id = 147 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 148: de vuelta -> terug
UPDATE words_lang SET notes = '• Ik ben om zes uur terug. — Estoy de vuelta a las seis.
• Wanneer kom je terug uit Spanje? — ¿Cuándo vuelves de España?
• Breng je de boeken terug naar de bieb? — ¿Devuelves los libros a la biblioteca?', updated_at = datetime('now')
WHERE word_es_id = 148 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 149: superalo -> zet je er overheen
UPDATE words_lang SET notes = '• Het is al maanden geleden, zet je er overheen. — Ya hace meses, supéralo.
• Ik weet dat het balen is, maar zet je er overheen. — Sé que es un rollo, pero supéralo.
• Ze kan zich er maar niet overheen zetten. — No consigue superarlo.', updated_at = datetime('now')
WHERE word_es_id = 149 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 150: acaban de llegar -> ze zijn hier pas nieuw
UPDATE words_lang SET notes = '• Ze zijn hier pas nieuw, ze kennen de buurt nog niet. — Acaban de llegar, todavía no conocen el barrio.
• De buren zijn hier pas nieuw, zeg eens gedag. — Los vecinos acaban de llegar, salúdalos.
• Wij waren hier ook ooit pas nieuw. — Nosotros también fuimos nuevos aquí una vez.', updated_at = datetime('now')
WHERE word_es_id = 150 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 151: no tienen mucho -> hebben niet zoveel
UPDATE words_lang SET notes = '• Ze hebben niet zoveel, maar ze delen alles. — No tienen mucho, pero lo comparten todo.
• Wij hadden vroeger ook niet zoveel. — Nosotros antes tampoco teníamos mucho.
• Ik heb niet zoveel tijd vandaag. — Hoy no tengo mucho tiempo.', updated_at = datetime('now')
WHERE word_es_id = 151 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 152: prescindir de -> kunnen missen
UPDATE words_lang SET notes = '• Kun je die stoel missen? — ¿Puedes prescindir de esa silla? (¿me la das/prestas?)
• Ik kan mijn fiets echt niet missen. — No puedo prescindir de mi bici para nada.
• Geef alleen wat je kunt missen. — Da solo lo que te sobre / de lo que puedas prescindir.', updated_at = datetime('now')
WHERE word_es_id = 152 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 153: algunas cosas -> iets
UPDATE words_lang SET notes = '• Wil je iets drinken? — ¿Quieres beber algo?
• Ik moet nog iets regelen voor morgen. — Aún tengo que arreglar algo para mañana.
• Zoek je iets speciaals? — ¿Buscas algo en especial? (en la tienda)', updated_at = datetime('now')
WHERE word_es_id = 153 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 154: consultado -> overlegd
UPDATE words_lang SET notes = '• Heb je met je vrouw overlegd? — ¿Lo has consultado con tu mujer?
• We hebben overlegd en we doen het. — Lo hemos consultado y lo hacemos.
• Zonder te overleggen heeft hij de bank weggegeven. — Sin consultarlo, regaló el sofá.', updated_at = datetime('now')
WHERE word_es_id = 154 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 155: con buena intencion -> bedoelt het goed
UPDATE words_lang SET notes = '• Hij bedoelt het goed, maar hij helpt niet echt. — Tiene buena intención, pero no ayuda de verdad.
• Oma bedoelt het goed met al dat eten. — La abuela lo hace con buena intención con tanta comida.
• Ze bedoelde het goed, maar het kwam verkeerd over. — Lo dijo con buena intención, pero sentó mal.', updated_at = datetime('now')
WHERE word_es_id = 155 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 156: ya nunca -> nooit meer
UPDATE words_lang SET notes = '• Ik rook nooit meer. — Ya nunca fumo / no vuelvo a fumar.
• We zien elkaar nooit meer sinds de verhuizing. — Ya nunca nos vemos desde la mudanza.
• Nooit meer doen! — ¡No lo vuelvas a hacer nunca!', updated_at = datetime('now')
WHERE word_es_id = 156 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 157: muchisimo -> hartstikke vaak
UPDATE words_lang SET notes = '• Ik gebruik de fiets hartstikke vaak. — Uso la bici muchísimo.
• We gaan hartstikke vaak naar de markt op zaterdag. — Vamos muchísimo al mercado los sábados.
• "Hartstikke" versterkt van alles: hartstikke leuk, hartstikke duur. — "Hartstikke" intensifica todo: superdivertido, carísimo.', updated_at = datetime('now')
WHERE word_es_id = 157 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');

-- 158: echar de menos -> missen
UPDATE words_lang SET notes = '• Ik mis mijn familie in Spanje. — Echo de menos a mi familia en España.
• Mis je het strand? Ja, heel erg. — ¿Echas de menos la playa? Sí, mucho.
• We gaan je missen op kantoor! — ¡Te vamos a echar de menos en la oficina!', updated_at = datetime('now')
WHERE word_es_id = 158 AND lang_code = 'nl_NL' AND (notes IS NULL OR TRIM(notes) = '');
