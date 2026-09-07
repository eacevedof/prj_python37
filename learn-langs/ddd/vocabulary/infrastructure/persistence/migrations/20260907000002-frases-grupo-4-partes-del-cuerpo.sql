-- Learn Languages App - Migration
-- Migration: 20260907000002-frases-grupo-4-partes-del-cuerpo
-- Description: Eduardo: "mejoremos esto, partes del cuerpo, esta bien pero si puedes
--   acompañar frases mas usadas con cada una de esas palabras siempre en distintos
--   tiempos pronombres posesisivos e incluyendo subordinadas" (grupos 4, 5 y 6).
--   Esta migracion cubre el GRUPO 4 (partes del cuerpo); los grupos 5 y 6 van en tandas
--   siguientes. Se reescriben las 5 frases de words_lang.notes de las 56 tarjetas que son
--   de verdad partes del cuerpo (la 8 de voetballer y la 9 het nachtkastje NO lo son y se
--   dejan intactas: van a un arreglo aparte de pertenencia de grupo).
--
--   Diagnostico que motivo el cambio, medido sobre el grupo antes de tocarlo:
--     - solo 29 de 58 tarjetas tenian subordinada [bijzin]; ahora la llevan las 56.
--     - los posesivos de plural no existian: ons/onze 1 aparicion, jullie 0, hun 0 y jouw
--       2 en todo el grupo. Todo giraba sobre mijn y je.
--   Criterio nuevo por tarjeta: siempre [can.] presente, [perf.] perfecto, [inv.]
--   inversion y [bijzin] subordinada, mas una quinta variable ([uitdr.] expresion hecha,
--   [vraag] o [geb.]). Los ocho posesivos rotan por el grupo. Las frases son las
--   colocaciones que se usan de verdad con cada parte del cuerpo (hoofdpijn, een stijve
--   nek, je enkel verzwikken, kramp in je kuit, spierpijn), no frases de relleno.
--
--   Solo se toca words_lang.notes: ni words_es.text ni words_lang.text, asi que NINGUN
--   audio queda desincronizado. El UPDATE es asignacion directa, luego es idempotente por
--   naturaleza (aplicarlo dos veces deja el mismo valor).

PRAGMA foreign_keys = ON;


UPDATE words_lang SET notes = '• [can.] Ik heb hoofdpijn. — Me duele la cabeza.
• [perf.] Hij heeft zijn hoofd gestoten tegen de kast. — Se ha dado en la cabeza con el armario.
• [inv.] Gisteren had ik de hele dag hoofdpijn. — Ayer me dolió la cabeza todo el día.
• [bijzin] Ze zegt dat ze het uit haar hoofd heeft geleerd. — Dice que se lo ha aprendido de memoria.
• [uitdr.] Hou het hoofd koel. — Mantén la cabeza fría.'
WHERE word_es_id = 10 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn haar is te lang. — Tengo el pelo demasiado largo.
• [perf.] Ze heeft haar haar laten knippen. — Se ha cortado el pelo.
• [inv.] Morgen laat ik mijn haar verven. — Mañana me tiño el pelo.
• [bijzin] Hij zegt dat zijn haar steeds sneller grijs wordt. — Dice que se le está poniendo gris cada vez más rápido.
• [uitdr.] Daar krijg ik grijze haren van. — Eso me saca canas.'
WHERE word_es_id = 40 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Je hebt iets op je voorhoofd. — Tienes algo en la frente.
• [perf.] De moeder heeft haar hand op zijn voorhoofd gelegd. — La madre le ha puesto la mano en la frente.
• [inv.] Met een hoge koorts voelt je voorhoofd warm aan. — Con fiebre alta la frente se nota caliente.
• [bijzin] Ik zie dat je voorhoofd helemaal bezweet is. — Veo que tienes la frente empapada de sudor.
• [vraag] Heb jij je voorhoofd gestoten? — ¿Te has dado en la frente?'
WHERE word_es_id = 41 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ze laat haar wenkbrauwen epileren. — Se depila las cejas.
• [perf.] Hij heeft zijn wenkbrauwen opgetrokken. — Ha levantado las cejas.
• [inv.] Bij die opmerking fronste ze haar wenkbrauwen. — Con ese comentario frunció el ceño.
• [bijzin] Iedereen zag dat hij zijn wenkbrauwen optrok. — Todos vieron que levantaba las cejas.
• [uitdr.] Dat doet menig wenkbrauw fronsen. — Eso hace fruncir más de un ceño.'
WHERE word_es_id = 42 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Er zit een wimper in mijn oog. — Tengo una pestaña en el ojo.
• [perf.] Ze heeft nieuwe wimpers laten zetten. — Se ha puesto pestañas nuevas.
• [inv.] Zonder mascara zijn haar wimpers heel licht. — Sin máscara tiene las pestañas muy claras.
• [bijzin] Ik merkte dat er een wimper op je wang lag. — Me di cuenta de que tenías una pestaña en la mejilla.
• [uitdr.] Hij deed het zonder met zijn ogen te knipperen. — Lo hizo sin pestañear.'
WHERE word_es_id = 44 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ze heeft blauwe ogen. — Tiene los ojos azules.
• [perf.] Ik heb de hele nacht geen oog dichtgedaan. — No he pegado ojo en toda la noche.
• [inv.] Vanochtend was mijn oog helemaal rood. — Esta mañana tenía el ojo completamente rojo.
• [bijzin] De dokter zei dat mijn ogen droog zijn. — El médico dijo que tengo los ojos secos.
• [uitdr.] Hou jij even een oogje op de kinderen? — ¿Les echas un ojo a los niños?'
WHERE word_es_id = 45 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn ooglid trilt de hele dag al. — Me tiembla el párpado desde por la mañana.
• [perf.] Ze heeft haar oogleden laten opereren. — Se ha operado los párpados.
• [inv.] Van de vermoeidheid werden zijn oogleden zwaar. — Del cansancio se le pusieron los párpados pesados.
• [bijzin] Ik voel dat mijn ooglid weer trilt. — Noto que me vuelve a temblar el párpado.
• [vraag] Doet je ooglid nog steeds pijn? — ¿Todavía te duele el párpado?'
WHERE word_es_id = 67 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn neus is verstopt. — Tengo la nariz taponada.
• [perf.] Hij heeft zijn neus gebroken bij het voetballen. — Se rompió la nariz jugando al fútbol.
• [inv.] In de winter loopt mijn neus altijd. — En invierno siempre me moquea la nariz.
• [bijzin] Ze klaagt dat haar neus al dagen verstopt zit. — Se queja de que lleva días con la nariz taponada.
• [uitdr.] Steek je neus niet in andermans zaken. — No metas las narices en asuntos ajenos.'
WHERE word_es_id = 46 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik heb pijn aan mijn oor. — Me duele el oído.
• [perf.] Ze heeft haar oren laten piercen. — Se ha hecho agujeros en las orejas.
• [inv.] Door het vliegen zaten mijn oren dicht. — Con el vuelo se me taponaron los oídos.
• [bijzin] Hij doet alsof hij het niet hoort, terwijl zijn oren prima werken. — Hace como que no oye, aunque sus oídos funcionan perfectamente.
• [uitdr.] Het gaat het ene oor in en het andere uit. — Le entra por un oído y le sale por el otro.'
WHERE word_es_id = 47 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ze geeft hem een kus op zijn wang. — Le da un beso en la mejilla.
• [perf.] Van de kou zijn onze wangen helemaal rood geworden. — Del frío se nos han puesto las mejillas rojas.
• [inv.] Bij de begroeting geven Nederlanders drie zoenen op de wang. — Al saludar, los neerlandeses dan tres besos en la mejilla.
• [bijzin] Ik zag dat er een traan over haar wang liep. — Vi que le caía una lágrima por la mejilla.
• [vraag] Waarom zijn jullie wangen zo rood? — ¿Por qué tenéis las mejillas tan rojas?'
WHERE word_es_id = 48 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik doe mijn mond open bij de tandarts. — Abro la boca en el dentista.
• [perf.] Hij heeft zijn mond de hele vergadering niet opengedaan. — No ha abierto la boca en toda la reunión.
• [inv.] Met volle mond praten doe je niet. — No se habla con la boca llena.
• [bijzin] Ze vroeg of ik mijn mond wilde houden. — Me pidió que me callara.
• [uitdr.] Hou je mond! — ¡Cierra la boca!'
WHERE word_es_id = 49 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn lippen zijn droog van de kou. — Tengo los labios secos del frío.
• [perf.] Ze heeft haar lippen gestift. — Se ha pintado los labios.
• [inv.] In de winter worden je lippen snel schraal. — En invierno los labios se agrietan enseguida.
• [bijzin] Hij beet op zijn lip zodat hij niets zou zeggen. — Se mordió el labio para no decir nada.
• [uitdr.] Mijn lippen zijn verzegeld. — De mi boca no sale nada.'
WHERE word_es_id = 50 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik poets mijn tanden twee keer per dag. — Me lavo los dientes dos veces al día.
• [perf.] Mijn dochter heeft haar eerste tand verloren. — A mi hija se le ha caído el primer diente.
• [inv.] Vannacht had ik vreselijke kiespijn. — Anoche tuve un dolor de muelas horrible.
• [bijzin] De tandarts zei dat er een gaatje in mijn tand zit. — El dentista dijo que tengo una caries en el diente.
• [uitdr.] Hij is door de zure appel heen gebeten. — Ha hecho de tripas corazón.'
WHERE word_es_id = 51 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn tandvlees bloedt bij het poetsen. — Me sangran las encías al cepillarme.
• [perf.] De tandarts heeft haar tandvlees behandeld. — El dentista le ha tratado las encías.
• [inv.] Bij een ontsteking is je tandvlees gezwollen. — Con una infección tienes la encía hinchada.
• [bijzin] Hij merkte dat zijn tandvlees pijn deed. — Notó que le dolían las encías.
• [vraag] Bloedt jouw tandvlees ook zo vaak? — ¿A ti también te sangran tanto las encías?'
WHERE word_es_id = 52 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Het gehemelte is het dak van je mond. — El paladar es el techo de la boca.
• [perf.] Ik heb mijn gehemelte gebrand aan de soep. — Me he quemado el paladar con la sopa.
• [inv.] Met zo hete thee brand je je gehemelte. — Con el té tan caliente te quemas el paladar.
• [bijzin] Ze klaagde dat haar gehemelte nog zeer deed. — Se quejó de que todavía le dolía el paladar.
• [uitdr.] Dat streelt het gehemelte. — Eso es un placer para el paladar.'
WHERE word_es_id = 53 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik bijt vaak op mijn tong. — Me muerdo la lengua a menudo.
• [perf.] Ik heb op mijn tong gebeten. — Me he mordido la lengua.
• [inv.] Bij de dokter moet je je tong uitsteken. — En el médico tienes que sacar la lengua.
• [bijzin] Ik weet dat het woord op het puntje van mijn tong ligt. — Sé que tengo la palabra en la punta de la lengua.
• [uitdr.] Hou je tong in bedwang. — Muérdete la lengua.'
WHERE word_es_id = 54 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Hij heeft een kuiltje in zijn kin. — Tiene un hoyuelo en la barbilla.
• [perf.] Ze heeft haar kin gestoten tegen de tafel. — Se ha dado con la barbilla en la mesa.
• [inv.] Bij het scheren snijdt hij zich vaak in zijn kin. — Al afeitarse se corta a menudo en la barbilla.
• [bijzin] De trainer zei dat we onze kin omhoog moesten houden. — El entrenador nos dijo que mantuviéramos la barbilla alta.
• [uitdr.] Kin omhoog! — ¡Arriba esa barbilla!'
WHERE word_es_id = 55 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Hij laat zijn baard staan. — Se está dejando barba.
• [perf.] Mijn broer heeft zijn baard afgeschoren. — Mi hermano se ha afeitado la barba.
• [inv.] Sinds de vakantie draagt hij een baard. — Desde las vacaciones lleva barba.
• [bijzin] Ze vindt dat zijn baard hem ouder maakt. — Le parece que la barba le hace más mayor.
• [uitdr.] Dat is een grap met een baard. — Ese chiste tiene más barba que un profeta.'
WHERE word_es_id = 56 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn opa heeft een grijze snor. — Mi abuelo tiene bigote gris.
• [perf.] Hij heeft zijn snor laten staan voor Movember. — Se ha dejado bigote por el Movember.
• [inv.] Vroeger droegen veel mannen een snor. — Antes muchos hombres llevaban bigote.
• [bijzin] Ik vind dat een snor niet bij hem past. — Me parece que el bigote no le pega.
• [uitdr.] Dat zit wel snor. — Eso está controlado.'
WHERE word_es_id = 57 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik heb een stijve nek. — Tengo tortícolis.
• [perf.] Heb je je nek verdraaid? — ¿Te has torcido el cuello?
• [inv.] Vanochtend werd ik wakker met pijn in mijn nek. — Esta mañana me desperté con dolor de cuello.
• [bijzin] De fysiotherapeut zei dat mijn nek te gespannen is. — El fisio dijo que tengo el cuello demasiado tenso.
• [uitdr.] Hij steekt zijn nek uit voor zijn collega. — Se la juega por su compañero.'
WHERE word_es_id = 11 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn schouder doet pijn na het sporten. — Me duele el hombro después de hacer deporte.
• [perf.] Hij heeft zijn schouder uit de kom gedraaid. — Se ha dislocado el hombro.
• [inv.] Met een zware tas belast je je schouder. — Con una bolsa pesada cargas el hombro.
• [bijzin] Ze legde haar hoofd op zijn schouder, omdat ze moe was. — Apoyó la cabeza en su hombro porque estaba cansada.
• [uitdr.] Hij haalde zijn schouders op. — Se encogió de hombros.'
WHERE word_es_id = 12 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik voel een druk op mijn borst. — Noto una presión en el pecho.
• [perf.] De dokter heeft zijn borst afgeluisterd. — El médico le ha auscultado el pecho.
• [inv.] Bij het hardlopen brandt mijn borst. — Al correr me arde el pecho.
• [bijzin] Hij zei dat hij pijn op de borst had. — Dijo que tenía dolor en el pecho.
• [uitdr.] Zij zet haar borst maar vast nat. — Que se vaya preparando.'
WHERE word_es_id = 13 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik heb rugpijn van het zitten. — Me duele la espalda de estar sentado.
• [perf.] Hij heeft zijn rug verrekt bij het tillen. — Se ha hecho daño en la espalda al levantar peso.
• [inv.] Na een lange dag doet mijn rug altijd zeer. — Después de un día largo siempre me duele la espalda.
• [bijzin] De dokter zei dat onze rug rust nodig heeft. — El médico dijo que nuestra espalda necesita reposo.
• [uitdr.] Ik heb het achter de rug. — Ya lo tengo superado.'
WHERE word_es_id = 14 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik voel het vooral in mijn lendenen. — Lo noto sobre todo en la zona lumbar.
• [perf.] De masseur heeft zijn lendenen behandeld. — El masajista le ha tratado la zona lumbar.
• [inv.] Bij het tillen moet je je lendenen sparen. — Al levantar peso tienes que cuidar la zona lumbar.
• [bijzin] Hij klaagt dat zijn lendenen stijf zijn. — Se queja de que tiene la zona lumbar rígida.
• [vraag] Doen jullie lendenen ook pijn na het tuinieren? — ¿A vosotros también os duele la zona lumbar después de la jardinería?'
WHERE word_es_id = 15 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik train mijn billen in de sportschool. — Entreno los glúteos en el gimnasio.
• [perf.] Ze is op haar billen gevallen. — Se ha caído de culo.
• [inv.] Na het fietsen doen mijn billen pijn. — Después de la bici me duelen los glúteos.
• [bijzin] De trainer zei dat je je billen moet aanspannen. — El entrenador dijo que hay que apretar los glúteos.
• [vraag] Trainen jullie ook je billen? — ¿Vosotros también entrenáis los glúteos?'
WHERE word_es_id = 60 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Hij zit de hele dag op zijn kont. — Se pasa el día sentado.
• [perf.] Ze heeft haar kont gestoten tegen de tafel. — Se ha dado con el culo en la mesa.
• [inv.] Op die harde stoel wordt je kont pijnlijk. — En esa silla dura se te queda el culo dolorido.
• [bijzin] Mijn moeder zei altijd dat we onze kont van de bank moesten halen. — Mi madre siempre nos decía que levantáramos el culo del sofá.
• [uitdr.] Kom van je luie kont! — ¡Levanta el culo de una vez!'
WHERE word_es_id = 61 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn arm zit in het gips. — Tengo el brazo escayolado.
• [perf.] Ik heb mijn arm gebroken. — Me he roto el brazo.
• [inv.] Met een gebroken arm kun je niet fietsen. — Con un brazo roto no puedes ir en bici.
• [bijzin] Hij vertelde dat zijn arm nog in het gips zit. — Contó que todavía tiene el brazo escayolado.
• [uitdr.] Zij nemen hem in de arm. — Recurren a él.'
WHERE word_es_id = 16 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Hij heeft een tatoeage op zijn onderarm. — Tiene un tatuaje en el antebrazo.
• [perf.] Ik heb mijn onderarm geschaafd tegen de muur. — Me he raspado el antebrazo con la pared.
• [inv.] Bij het typen rust je onderarm op tafel. — Al teclear el antebrazo descansa sobre la mesa.
• [bijzin] De arts zag dat haar onderarm gezwollen was. — El médico vio que tenía el antebrazo hinchado.
• [vraag] Doet jouw onderarm ook pijn van het tennissen? — ¿A ti también te duele el antebrazo de jugar al tenis?'
WHERE word_es_id = 17 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik stoot mijn elleboog tegen de deur. — Me doy con el codo en la puerta.
• [perf.] Hij heeft zijn elleboog geschaafd bij het vallen. — Se ha raspado el codo al caerse.
• [inv.] Op tafel leun je niet met je ellebogen. — En la mesa no se apoyan los codos.
• [bijzin] Ze merkte dat haar elleboog gevoelig was. — Notó que tenía el codo sensible.
• [uitdr.] Hij heeft zijn ellebogen goed kunnen gebruiken. — Ha sabido abrirse paso a codazos.'
WHERE word_es_id = 18 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik draag mijn horloge om mijn pols. — Llevo el reloj en la muñeca.
• [perf.] Ze heeft haar pols verstuikt bij het schaatsen. — Se ha torcido la muñeca patinando.
• [inv.] Van het muizen krijg je pijn in je pols. — Del ratón te duele la muñeca.
• [bijzin] De dokter voelde of onze polsslag normaal was. — El médico comprobó si nuestro pulso era normal.
• [vraag] Heb jij je pols bezeerd? — ¿Te has hecho daño en la muñeca?'
WHERE word_es_id = 19 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik was mijn handen voor het eten. — Me lavo las manos antes de comer.
• [perf.] Hij heeft haar hand vastgepakt. — Le ha cogido la mano.
• [inv.] In de winter worden mijn handen snel koud. — En invierno se me quedan las manos frías enseguida.
• [bijzin] Ze zei dat ze haar handen vol had aan de kinderen. — Dijo que tenía las manos llenas con los niños.
• [uitdr.] Steek de handen uit de mouwen! — ¡Manos a la obra!'
WHERE word_es_id = 20 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn vinger doet pijn. — Me duele el dedo.
• [perf.] Ik heb mijn vinger gesneden. — Me he cortado el dedo.
• [inv.] Met een gesneden vinger kun je slecht typen. — Con un dedo cortado se teclea mal.
• [bijzin] Hij zag dat er bloed van haar vinger droop. — Vio que le goteaba sangre del dedo.
• [uitdr.] Zij kijken hem door de vingers. — Le hacen la vista gorda.'
WHERE word_es_id = 21 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik steek mijn duim omhoog. — Levanto el pulgar.
• [perf.] De baby heeft de hele nacht op zijn duim gezogen. — El bebé se ha chupado el pulgar toda la noche.
• [inv.] Bij het liften steek je je duim uit. — Para hacer autostop sacas el pulgar.
• [bijzin] Ze belooft dat ze haar duimen voor ons zal drukken. — Promete que cruzará los dedos por nosotros.
• [uitdr.] Ik duim voor je! — ¡Te deseo suerte!'
WHERE word_es_id = 30 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Hij wijst met zijn wijsvinger naar de kaart. — Señala el mapa con el índice.
• [perf.] Ze heeft haar wijsvinger gebrand aan de pan. — Se ha quemado el índice con la sartén.
• [inv.] Met je wijsvinger wijzen is onbeleefd. — Señalar con el índice es de mala educación.
• [bijzin] De leraar merkte dat hun wijsvingers allemaal omhoog gingen. — El profesor vio que todos levantaban el índice.
• [vraag] Kun je je wijsvinger nog bewegen? — ¿Puedes mover todavía el índice?'
WHERE word_es_id = 31 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn middelvinger is de langste vinger. — El dedo medio es el más largo.
• [perf.] Hij heeft zijn middelvinger opgestoken in het verkeer. — Ha hecho una peineta en la carretera.
• [inv.] Bij het schrijven rust de pen op je middelvinger. — Al escribir el boli se apoya en el dedo medio.
• [bijzin] Ze zag dat zijn middelvinger dik was van de klap. — Vio que tenía el dedo medio hinchado del golpe.
• [vraag] Draag jij je ring om je middelvinger? — ¿Llevas el anillo en el dedo medio?'
WHERE word_es_id = 32 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ze draagt haar trouwring om haar ringvinger. — Lleva la alianza en el dedo anular.
• [perf.] Hij heeft de ring om haar ringvinger geschoven. — Le ha puesto el anillo en el anular.
• [inv.] In Nederland zit de trouwring vaak om de rechter ringvinger. — En Países Bajos la alianza suele ir en el anular derecho.
• [bijzin] Iedereen zag dat haar ringvinger leeg was. — Todos vieron que tenía el anular vacío.
• [vraag] Om welke ringvinger dragen jullie je ring? — ¿En qué anular lleváis el anillo?'
WHERE word_es_id = 33 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik stoot mijn pink tegen de tafelpoot. — Me doy con el meñique en la pata de la mesa.
• [perf.] Ze heeft haar pink gebroken bij het volleyballen. — Se ha roto el meñique jugando al voleibol.
• [inv.] Met een gebroken pink kun je nog gewoon typen. — Con el meñique roto todavía puedes teclear.
• [bijzin] Hij klaagde dat zijn pink blauw was geworden. — Se quejó de que se le había puesto el meñique morado.
• [uitdr.] Dat doe ik met mijn pink. — Eso lo hago con los ojos cerrados.'
WHERE word_es_id = 34 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Hij traint zijn biceps elke week. — Entrena el bíceps cada semana.
• [perf.] Ze heeft haar biceps verrekt in de sportschool. — Se ha hecho un tirón en el bíceps en el gimnasio.
• [inv.] Met die gewichten voel je je biceps meteen. — Con esas pesas notas el bíceps enseguida.
• [bijzin] De trainer zei dat onze biceps rust nodig heeft. — El entrenador dijo que nuestro bíceps necesita descanso.
• [vraag] Laat eens zien, hoe groot is jouw biceps? — A ver, ¿cómo tienes el bíceps?'
WHERE word_es_id = 58 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] De triceps zit aan de achterkant van je arm. — El tríceps está en la parte de atrás del brazo.
• [perf.] Hij heeft zijn triceps zwaar belast. — Ha cargado mucho el tríceps.
• [inv.] Na die oefening brandt mijn triceps. — Después de ese ejercicio me arde el tríceps.
• [bijzin] Ze legde uit dat je triceps groter is dan je biceps. — Explicó que el tríceps es más grande que el bíceps.
• [vraag] Trainen jullie jullie triceps ook op dinsdag? — ¿Vosotros también entrenáis el tríceps los martes?'
WHERE word_es_id = 59 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn benen zijn moe van het lopen. — Tengo las piernas cansadas de andar.
• [perf.] Hij heeft zijn been gebroken bij het skiën. — Se ha roto la pierna esquiando.
• [inv.] Na die wandeling deden onze benen pijn. — Después de esa caminata nos dolían las piernas.
• [bijzin] De dokter zei dat zijn been zes weken in het gips moet. — El médico dijo que su pierna tiene que estar seis semanas escayolada.
• [uitdr.] Hij is met het verkeerde been uit bed gestapt. — Se ha levantado con el pie izquierdo.'
WHERE word_es_id = 22 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik voel de training in mijn dijen. — Noto el entrenamiento en los muslos.
• [perf.] Ze heeft haar dij verrekt bij het hardlopen. — Se ha hecho un tirón en el muslo corriendo.
• [inv.] Bij het fietsen train je vooral je dijen. — Con la bici entrenas sobre todo los muslos.
• [bijzin] Hij merkte dat zijn dijen stijf waren. — Notó que tenía los muslos agarrotados.
• [vraag] Doen jullie dijen ook pijn na de les? — ¿A vosotros también os duelen los muslos después de la clase?'
WHERE word_es_id = 23 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn knie doet pijn bij het traplopen. — Me duele la rodilla al subir escaleras.
• [perf.] Hij heeft zijn knie geblesseerd tijdens de wedstrijd. — Se ha lesionado la rodilla en el partido.
• [inv.] Op je knieën zitten is niet goed voor je gewrichten. — Estar de rodillas no es bueno para las articulaciones.
• [bijzin] De arts zei dat haar knie geopereerd moet worden. — El médico dijo que hay que operarle la rodilla.
• [uitdr.] Hij ging door de knieën. — Se rindió.'
WHERE word_es_id = 24 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik heb kramp in mijn kuit. — Tengo un calambre en la pantorrilla.
• [perf.] Ze heeft haar kuit verrekt tijdens het rennen. — Se ha hecho un tirón en la pantorrilla corriendo.
• [inv.] Na de wandeling waren onze kuiten helemaal stijf. — Después de la caminata teníamos las pantorrillas agarrotadas.
• [bijzin] Hij vertelde dat zijn kuit nog steeds gevoelig is. — Contó que todavía tiene la pantorrilla sensible.
• [vraag] Heb jij vaak kramp in je kuiten? — ¿Te dan calambres a menudo en las pantorrillas?'
WHERE word_es_id = 25 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik verzwik vaak mijn enkel. — Me tuerzo el tobillo a menudo.
• [perf.] Ik heb mijn enkel verzwikt. — Me he torcido el tobillo.
• [inv.] Met een dikke enkel kun je niet lopen. — Con el tobillo hinchado no puedes andar.
• [bijzin] De dokter zei dat mijn enkel alleen verstuikt is. — El médico dijo que solo tengo el tobillo torcido.
• [vraag] Is jouw enkel al opgezwollen? — ¿Se te ha hinchado ya el tobillo?'
WHERE word_es_id = 26 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn schoen drukt op mijn wreef. — El zapato me aprieta el empeine.
• [perf.] Hij heeft de bal met zijn wreef geraakt. — Ha golpeado el balón con el empeine.
• [inv.] Met een hoge wreef zijn schoenen kopen is lastig. — Con el empeine alto es difícil comprar zapatos.
• [bijzin] Ze klaagde dat haar wreef pijn deed in die laarzen. — Se quejó de que le dolía el empeine con esas botas.
• [vraag] Hebben jullie ook zo een hoge wreef? — ¿Vosotros también tenéis el empeine tan alto?'
WHERE word_es_id = 27 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn voeten zijn koud. — Tengo los pies fríos.
• [perf.] Hij heeft zijn voet bezeerd bij het voetballen. — Se ha hecho daño en el pie jugando al fútbol.
• [inv.] Na een lange dag zijn mijn voeten gezwollen. — Después de un día largo tengo los pies hinchados.
• [bijzin] Ze zei dat haar voeten pijn deden in die schoenen. — Dijo que le dolían los pies con esos zapatos.
• [uitdr.] Zij staan op goede voet met elkaar. — Se llevan bien.'
WHERE word_es_id = 28 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik stoot mijn teen tegen de deur. — Me doy con el dedo del pie en la puerta.
• [perf.] Ik heb mijn teen gestoten tegen de deur. — Me he dado con el dedo del pie en la puerta.
• [inv.] Op blote voeten stoot je snel je tenen. — Descalzo te das enseguida en los dedos del pie.
• [bijzin] Hij merkte dat zijn teen blauw werd. — Notó que se le ponía morado el dedo del pie.
• [uitdr.] Hij is gauw op zijn teentjes getrapt. — Se ofende con mucha facilidad.'
WHERE word_es_id = 29 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn grote teen doet pijn in deze schoenen. — Me duele el dedo gordo con estos zapatos.
• [perf.] Hij heeft zijn grote teen gestoten tegen de tafelpoot. — Se ha dado con el dedo gordo en la pata de la mesa.
• [inv.] Met een gebroken grote teen loop je moeilijk. — Con el dedo gordo roto andas con dificultad.
• [bijzin] De dokter zag dat haar grote teen ontstoken was. — El médico vio que tenía el dedo gordo infectado.
• [vraag] Doet jouw grote teen ook zo zeer? — ¿A ti también te duele tanto el dedo gordo?'
WHERE word_es_id = 35 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn tweede teen is langer dan mijn grote teen. — Tengo el segundo dedo más largo que el gordo.
• [perf.] Ze heeft haar tweede teen bezeerd. — Se ha hecho daño en el segundo dedo.
• [inv.] Bij sommige mensen steekt de tweede teen uit. — A algunas personas les sobresale el segundo dedo.
• [bijzin] Hij vertelde dat zijn tweede teen krom staat. — Contó que tiene el segundo dedo torcido.
• [vraag] Is jullie tweede teen ook zo lang? — ¿A vosotros también os sobresale el segundo dedo?'
WHERE word_es_id = 36 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik voel mijn derde teen bijna niet. — Casi no noto el tercer dedo del pie.
• [perf.] De arts heeft zijn derde teen ingetapet. — El médico le ha vendado el tercer dedo.
• [inv.] In krappe schoenen klemt je derde teen. — Con zapatos estrechos se te aprieta el tercer dedo.
• [bijzin] Ze zei dat haar derde teen gevoelloos was. — Dijo que tenía el tercer dedo dormido.
• [vraag] Kun je je derde teen apart bewegen? — ¿Puedes mover el tercer dedo por separado?'
WHERE word_es_id = 37 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn vierde teen is de kleinste na mijn pink. — El cuarto dedo es el más pequeño después del meñique.
• [perf.] Hij heeft zijn vierde teen gestoten. — Se ha dado en el cuarto dedo del pie.
• [inv.] Tussen je vierde teen en je pink zit weinig ruimte. — Entre el cuarto dedo y el meñique hay poco espacio.
• [bijzin] De pedicure zag dat hun vierde tenen krom stonden. — La podóloga vio que tenían los cuartos dedos torcidos.
• [vraag] Doet je vierde teen ook pijn? — ¿Te duele también el cuarto dedo?'
WHERE word_es_id = 38 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik stoot altijd mijn kleine teen. — Siempre me doy con el dedo pequeño del pie.
• [perf.] Ze heeft haar kleine teen gebroken tegen de bank. — Se ha roto el dedo pequeño con el sofá.
• [inv.] In het donker stoot je makkelijk je kleine teen. — A oscuras te das fácilmente con el dedo pequeño.
• [bijzin] Hij vloekte omdat hij zijn kleine teen had gestoten. — Soltó un taco porque se había dado con el dedo pequeño.
• [uitdr.] Niets doet zo veel pijn als je kleine teen. — Nada duele tanto como el dedo pequeño del pie.'
WHERE word_es_id = 39 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik knip mijn nagels elke zondag. — Me corto las uñas todos los domingos.
• [perf.] Ze heeft haar nagels gelakt. — Se ha pintado las uñas.
• [inv.] Op je nagels bijten is een slechte gewoonte. — Morderse las uñas es una mala costumbre.
• [bijzin] Zijn moeder zei dat zijn nagels te lang waren. — Su madre dijo que tenía las uñas demasiado largas.
• [uitdr.] Hij spijkert het aan zijn nagel. — Se lo apunta bien.'
WHERE word_es_id = 62 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik heb een droge huid in de winter. — Tengo la piel seca en invierno.
• [perf.] De zon heeft haar huid verbrand. — El sol le ha quemado la piel.
• [inv.] Met een gevoelige huid gebruik je milde zeep. — Con la piel sensible se usa un jabón suave.
• [bijzin] De dermatoloog zei dat onze huid bescherming nodig heeft. — El dermatólogo dijo que nuestra piel necesita protección.
• [uitdr.] Hij verkoopt zijn huid duur. — Vende cara su piel.'
WHERE word_es_id = 63 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Mijn botten zijn sterk genoeg. — Tengo los huesos bastante fuertes.
• [perf.] Hij heeft een bot gebroken bij de val. — Se ha roto un hueso en la caída.
• [inv.] Met ouderdom worden je botten brozer. — Con la edad los huesos se vuelven más frágiles.
• [bijzin] De arts legde uit dat haar botten kalk missen. — El médico explicó que a sus huesos les falta calcio.
• [uitdr.] Ik voel het tot op het bot. — Lo siento hasta los huesos.'
WHERE word_es_id = 64 AND lang_code = 'nl_NL';

UPDATE words_lang SET notes = '• [can.] Ik heb spierpijn van gisteren. — Tengo agujetas de ayer.
• [perf.] Hij heeft een spier verrekt tijdens de training. — Se ha hecho un tirón en un músculo entrenando.
• [inv.] Na het sporten moet je je spieren rekken. — Después del deporte hay que estirar los músculos.
• [bijzin] De fysiotherapeut zei dat hun spieren te gespannen zijn. — El fisio dijo que tienen los músculos demasiado tensos.
• [uitdr.] Hij vertrok geen spier. — No movió ni un músculo.'
WHERE word_es_id = 65 AND lang_code = 'nl_NL';
