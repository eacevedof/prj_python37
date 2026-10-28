-- Learn Languages App - 5 ejemplos por palabra, de simple a complejo
-- Migration: 20260706000004-expand-nl-examples-to-five.sql
-- Description: Reemplaza los 3 ejemplos de 20260706000002 por 5, siguiendo la
--   gramatica del neerlandes de menor a mayor dificultad:
--     [can.]   orden canonico: Sujeto + V2 + Tiempo + Manera + Lugar
--     [inv.]   inversion: tiempo/lugar delante -> verbo antes del sujeto
--     [perf.]  perfecto/modal: parentesis verbal (participio/infinitivo al final)
--     [vraag]/[geb.] pregunta o imperativo cotidiano
--     [bijzin]/[uitdr.] subordinada (verbo al final) o frase hecha
--   Formato por linea: "• [tipo] zin — traduccion". La tarjeta del slider parsea
--   la etiqueta; si falta (ejemplos a mano), simplemente no la muestra.
--   No toca ids ni borra filas (los audios word-<id>-*.mp3 no se ven afectados).

PRAGMA foreign_keys = ON;

-- 5: hola -> hoi
UPDATE words_lang SET notes = '• [can.] Hoi, alles goed? — Hola, ¿todo bien?
• [inv.] Elke ochtend zeg ik hoi tegen de buren. — Cada mañana saludo a los vecinos.
• [perf.] Hij heeft vrolijk hoi gezegd. — Ha dicho hola alegremente.
• [geb.] Zeg even hoi tegen oma! — ¡Dile hola a la abuela!
• [bijzin] Ze is zo verlegen dat ze amper hoi zegt. — Es tan tímida que apenas dice hola.', updated_at = datetime('now')
WHERE word_es_id = 5 AND lang_code = 'nl_NL';

-- 6: dia -> dag
UPDATE words_lang SET notes = '• [can.] Ik heb vandaag een drukke dag. — Hoy tengo un día ajetreado.
• [inv.] Morgen wordt het een mooie dag. — Mañana será un día bonito.
• [perf.] Ik heb de hele dag thuis gewerkt. — He trabajado en casa todo el día.
• [vraag] Hoe was je dag? — ¿Qué tal tu día?
• [uitdr.] Fijne dag nog! — ¡Que tengas buen día! (despedida en tiendas)', updated_at = datetime('now')
WHERE word_es_id = 6 AND lang_code = 'nl_NL';

-- 8: futbolista -> voetballer
UPDATE words_lang SET notes = '• [can.] Mijn zoon is voetballer. — Mi hijo es futbolista.
• [inv.] Later wil hij profvoetballer worden. — De mayor quiere ser futbolista profesional.
• [perf.] Die voetballer is vorig jaar geblesseerd geraakt. — Ese futbolista se lesionó el año pasado.
• [vraag] Wie is jouw favoriete voetballer? — ¿Quién es tu futbolista favorito?
• [bijzin] Iedereen weet dat die voetballer bij Ajax speelt. — Todos saben que ese futbolista juega en el Ajax.', updated_at = datetime('now')
WHERE word_es_id = 8 AND lang_code = 'nl_NL';

-- 9: mesa de noche -> nachtkastje
UPDATE words_lang SET notes = '• [can.] Mijn telefoon ligt op het nachtkastje. — Mi móvil está en la mesita de noche.
• [inv.] ''s Avonds leg ik mijn bril op het nachtkastje. — Por la noche dejo las gafas en la mesita.
• [perf.] Ik heb een nieuw nachtkastje bij IKEA gekocht. — He comprado una mesita nueva en IKEA.
• [vraag] Ligt de afstandsbediening op het nachtkastje? — ¿Está el mando en la mesita de noche?
• [bijzin] Ik snap niet waarom het nachtkastje altijd vol ligt. — No entiendo por qué la mesita siempre está llena.', updated_at = datetime('now')
WHERE word_es_id = 9 AND lang_code = 'nl_NL';

-- 10: la cabeza -> het hoofd
UPDATE words_lang SET notes = '• [can.] Mijn hoofd doet pijn. — Me duele la cabeza.
• [inv.] Vandaag heb ik de hele dag hoofdpijn. — Hoy llevo todo el día con dolor de cabeza.
• [perf.] Hij heeft zijn hoofd tegen de deur gestoten. — Se ha dado con la cabeza en la puerta.
• [geb.] Pas op je hoofd, de deur is laag! — ¡Cuidado con la cabeza, la puerta es baja!
• [uitdr.] De kinderen leren het liedje uit het hoofd. — Los niños se aprenden la canción de memoria (lit. de cabeza).', updated_at = datetime('now')
WHERE word_es_id = 10 AND lang_code = 'nl_NL';

-- 11: el cuello -> de nek
UPDATE words_lang SET notes = '• [can.] Mijn nek doet pijn. — Me duele el cuello.
• [inv.] Na het slapen is mijn nek vaak stijf. — Después de dormir suelo tener el cuello rígido.
• [perf.] Ik heb mijn nek bij het sporten verrekt. — Me estiré el cuello haciendo deporte.
• [vraag] Doet je nek nog pijn? — ¿Te sigue doliendo el cuello?
• [uitdr.] Hij kletst uit zijn nek. — Dice tonterías (frase hecha: habla por el cuello).', updated_at = datetime('now')
WHERE word_es_id = 11 AND lang_code = 'nl_NL';

-- 12: el hombro -> de schouder
UPDATE words_lang SET notes = '• [can.] Mijn schouder is stijf. — Tengo el hombro cargado.
• [inv.] Na het zwemmen doet mijn schouder pijn. — Después de nadar me duele el hombro.
• [perf.] Hij heeft me op de schouder geklopt. — Me ha dado una palmada en el hombro.
• [vraag] Kun je mijn schouders even masseren? — ¿Me masajeas los hombros?
• [uitdr.] Ze haalde haar schouders op. — Se encogió de hombros (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 12 AND lang_code = 'nl_NL';

-- 13: el pecho -> de borst
UPDATE words_lang SET notes = '• [can.] Ik heb pijn op de borst. — Tengo dolor en el pecho.
• [inv.] Bij het hardlopen voel ik druk op mijn borst. — Al correr noto presión en el pecho.
• [perf.] De dokter heeft naar mijn borst geluisterd. — El médico me ha auscultado el pecho.
• [vraag] Heb je nog pijn op je borst? — ¿Todavía te duele el pecho?
• [bijzin] Als de pijn op de borst terugkomt, bel je 112. — Si el dolor en el pecho vuelve, llamas al 112.', updated_at = datetime('now')
WHERE word_es_id = 13 AND lang_code = 'nl_NL';

-- 14: la espalda -> de rug
UPDATE words_lang SET notes = '• [can.] Mijn rug doet pijn. — Me duele la espalda.
• [inv.] Na het tillen heb ik last van mijn rug. — Después de cargar peso me molesta la espalda.
• [perf.] Ik heb mijn rug bij het verhuizen bezeerd. — Me hice daño en la espalda en la mudanza.
• [geb.] Ga even op je rug liggen. — Túmbate boca arriba.
• [uitdr.] Hij deed het achter mijn rug om. — Lo hizo a mis espaldas (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 14 AND lang_code = 'nl_NL';

-- 15: la zona lumbar -> de lendenen
UPDATE words_lang SET notes = '• [can.] Ik heb pijn in de lendenen. — Me duele la zona lumbar.
• [inv.] Na het tuinieren voel ik mijn lendenen. — Después del jardín noto la zona lumbar.
• [perf.] De fysio heeft mijn lendenen gemasseerd. — El fisio me ha masajeado la zona lumbar.
• [vraag] Heb je vaak last van je lendenen? — ¿Te molesta a menudo la zona lumbar?
• [bijzin] De dokter zegt dat mijn lendenen overbelast zijn. — El médico dice que tengo la lumbar sobrecargada ("onderrug" en el habla diaria).', updated_at = datetime('now')
WHERE word_es_id = 15 AND lang_code = 'nl_NL';

-- 16: el brazo -> de arm
UPDATE words_lang SET notes = '• [can.] Mijn arm is moe. — Tengo el brazo cansado.
• [inv.] Vorige winter brak hij zijn arm. — El invierno pasado se rompió el brazo.
• [perf.] Ik heb mijn arm bij het fietsen gebroken. — Me rompí el brazo montando en bici.
• [geb.] Til je arm even op. — Levanta el brazo.
• [uitdr.] Ze liepen arm in arm door het park. — Caminaban del brazo por el parque (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 16 AND lang_code = 'nl_NL';

-- 17: el antebrazo -> de onderarm
UPDATE words_lang SET notes = '• [can.] Ik heb een schaafwond op mijn onderarm. — Tengo un rasguño en el antebrazo.
• [inv.] Bij deze oefening steun je op je onderarmen. — En este ejercicio te apoyas en los antebrazos.
• [perf.] Hij heeft een tatoeage op zijn onderarm laten zetten. — Se ha hecho un tatuaje en el antebrazo.
• [vraag] Doet je onderarm pijn van het typen? — ¿Te duele el antebrazo de teclear?
• [bijzin] De dokter denkt dat mijn onderarm ontstoken is. — El médico cree que tengo el antebrazo inflamado.', updated_at = datetime('now')
WHERE word_es_id = 17 AND lang_code = 'nl_NL';

-- 18: el codo -> de elleboog
UPDATE words_lang SET notes = '• [can.] Mijn elleboog doet pijn. — Me duele el codo.
• [inv.] Gisteren stootte ik mijn elleboog. — Ayer me di un golpe en el codo.
• [perf.] Ik heb mijn elleboog hard gestoten. — Me he dado un buen golpe en el codo.
• [geb.] Hoest in je elleboog, alsjeblieft. — Tose en el codo, por favor.
• [uitdr.] Niet met je ellebogen op tafel! — ¡Sin codos en la mesa! (regla clásica de los padres)', updated_at = datetime('now')
WHERE word_es_id = 18 AND lang_code = 'nl_NL';

-- 19: la muneca -> de pols
UPDATE words_lang SET notes = '• [can.] Mijn pols doet pijn. — Me duele la muñeca.
• [inv.] Van het typen krijg ik pijn in mijn pols. — De teclear me duele la muñeca.
• [perf.] Ze heeft haar pols bij het schaatsen gebroken. — Se rompió la muñeca patinando.
• [vraag] Draag je je horloge om je linkerpols? — ¿Llevas el reloj en la muñeca izquierda?
• [bijzin] De dokter voelde mijn pols, omdat mijn hart snel klopte. — El médico me tomó el pulso porque el corazón me iba rápido ("pols" también es pulso).', updated_at = datetime('now')
WHERE word_es_id = 19 AND lang_code = 'nl_NL';

-- 20: la mano -> de hand
UPDATE words_lang SET notes = '• [can.] Ik was mijn handen voor het eten. — Me lavo las manos antes de comer.
• [inv.] In Nederland geef je bij een sollicitatie een hand. — En Países Bajos das la mano en una entrevista.
• [perf.] Hij heeft zijn hand aan de oven gebrand. — Se ha quemado la mano con el horno.
• [geb.] Was je handen even! — ¡Lávate las manos!
• [uitdr.] Kun je me een handje helpen? — ¿Me echas una mano? (frase hecha)', updated_at = datetime('now')
WHERE word_es_id = 20 AND lang_code = 'nl_NL';

-- 21: el dedo -> de vinger
UPDATE words_lang SET notes = '• [can.] Ik heb een pleister om mijn vinger. — Llevo una tirita en el dedo.
• [inv.] Bij het koken sneed ik in mijn vinger. — Cocinando me corté el dedo.
• [perf.] Ik heb in mijn vinger gesneden. — Me he cortado el dedo.
• [geb.] Steek je vinger op als je het weet! — ¡Levanta el dedo si lo sabes!
• [uitdr.] Ik kan er de vinger niet op leggen. — No consigo identificarlo (frase hecha: no puedo poner el dedo encima).', updated_at = datetime('now')
WHERE word_es_id = 21 AND lang_code = 'nl_NL';

-- 22: la pierna -> het been
UPDATE words_lang SET notes = '• [can.] Mijn benen zijn moe. — Tengo las piernas cansadas.
• [inv.] Na het fietsen voel ik mijn benen. — Después de la bici noto las piernas.
• [perf.] Hij heeft zijn been op wintersport gebroken. — Se rompió la pierna esquiando.
• [vraag] Doen je benen pijn van het lopen? — ¿Te duelen las piernas de andar?
• [uitdr.] Ze namen de benen. — Salieron pitando (frase hecha: poner pies en polvorosa).', updated_at = datetime('now')
WHERE word_es_id = 22 AND lang_code = 'nl_NL';

-- 23: el muslo -> de dij
UPDATE words_lang SET notes = '• [can.] Mijn dijen doen pijn. — Me duelen los muslos.
• [inv.] Na het hardlopen heb ik spierpijn in mijn dijen. — Después de correr tengo agujetas en los muslos.
• [perf.] Ik heb mijn dijen goed getraind. — He entrenado bien los muslos.
• [vraag] Voel je de oefening in je dijen? — ¿Notas el ejercicio en los muslos?
• [bijzin] De trainer zegt dat sterke dijen belangrijk zijn. — El entrenador dice que unos muslos fuertes son importantes.', updated_at = datetime('now')
WHERE word_es_id = 23 AND lang_code = 'nl_NL';

-- 24: la rodilla -> de knie
UPDATE words_lang SET notes = '• [can.] Mijn knie doet pijn. — Me duele la rodilla.
• [inv.] Bij het traplopen kraakt mijn knie. — Al subir escaleras me cruje la rodilla.
• [perf.] Ik ben op mijn knie gevallen. — Me he caído sobre la rodilla.
• [geb.] Ga even door je knieën. — Flexiona las rodillas.
• [uitdr.] Hij ging voor haar op de knieën. — Se puso de rodillas para pedirle matrimonio (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 24 AND lang_code = 'nl_NL';

-- 25: la pantorrilla -> de kuit
UPDATE words_lang SET notes = '• [can.] Ik heb kramp in mijn kuit. — Tengo un calambre en la pantorrilla.
• [inv.] ''s Nachts krijg ik soms kramp in mijn kuiten. — Por la noche a veces me dan calambres en las pantorrillas.
• [perf.] Ik heb mijn kuiten na het wandelen gerekt. — He estirado las pantorrillas tras la caminata.
• [vraag] Zijn je kuiten stijf van het fietsen? — ¿Tienes las pantorrillas cargadas de la bici?
• [bijzin] De fysio zegt dat ik mijn kuiten vaker moet rekken. — El fisio dice que debo estirar más las pantorrillas.', updated_at = datetime('now')
WHERE word_es_id = 25 AND lang_code = 'nl_NL';

-- 26: el tobillo -> de enkel
UPDATE words_lang SET notes = '• [can.] Mijn enkel is dik. — Tengo el tobillo hinchado.
• [inv.] Op de trap verzwikte ik mijn enkel. — En la escalera me torcí el tobillo.
• [perf.] Ik heb mijn enkel verzwikt. — Me he torcido el tobillo.
• [vraag] Kun je op je enkel staan? — ¿Puedes apoyar el tobillo?
• [bijzin] De dokter denkt dat mijn enkel gekneusd is. — El médico cree que el tobillo está contusionado.', updated_at = datetime('now')
WHERE word_es_id = 26 AND lang_code = 'nl_NL';

-- 27: el empeine -> de wreef
UPDATE words_lang SET notes = '• [can.] Deze schoenen knellen op de wreef. — Estos zapatos aprietan en el empeine.
• [inv.] Bij voetbal raak je de bal met de wreef. — En fútbol golpeas el balón con el empeine.
• [perf.] De bal heeft me vol op de wreef geraakt. — El balón me ha dado de lleno en el empeine.
• [vraag] Heb je een hoge wreef? — ¿Tienes el empeine alto?
• [bijzin] Ik koop deze schoenen niet, omdat ze op de wreef knellen. — No compro estos zapatos porque aprietan en el empeine.', updated_at = datetime('now')
WHERE word_es_id = 27 AND lang_code = 'nl_NL';

-- 28: el pie -> de voet
UPDATE words_lang SET notes = '• [can.] Mijn voeten doen pijn. — Me duelen los pies.
• [inv.] Elke dag ga ik te voet naar de supermarkt. — Cada día voy a pie al supermercado.
• [perf.] Ik heb de hele dag op mijn voeten gestaan. — He estado todo el día de pie.
• [geb.] Veeg je voeten bij de deur! — ¡Límpiate los pies en la puerta!
• [uitdr.] We staan op goede voet met de buren. — Nos llevamos bien con los vecinos (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 28 AND lang_code = 'nl_NL';

-- 29: el dedo del pie -> de teen
UPDATE words_lang SET notes = '• [can.] Mijn teen doet pijn. — Me duele el dedo del pie.
• [inv.] Vannacht stootte ik mijn teen tegen het bed. — Anoche me di con el dedo contra la cama.
• [perf.] Ik heb mijn teen gestoten. — Me he dado un golpe en el dedo del pie.
• [vraag] Staat er iemand op je tenen? — ¿Alguien te está pisando los dedos?
• [uitdr.] Hij is snel op zijn tenen getrapt. — Se ofende con facilidad (frase hecha: le pisan pronto los dedos).', updated_at = datetime('now')
WHERE word_es_id = 29 AND lang_code = 'nl_NL';

-- 30: el pulgar -> de duim
UPDATE words_lang SET notes = '• [can.] De baby zuigt op haar duim. — La bebé se chupa el pulgar.
• [inv.] Met de hamer sloeg ik op mijn duim. — Con el martillo me di en el pulgar.
• [perf.] Hij heeft zijn duim opgestoken. — Ha levantado el pulgar (¡ok!).
• [vraag] Doet je duim pijn van het appen? — ¿Te duele el pulgar de tanto wasapear?
• [uitdr.] Ik duim voor je! — ¡Cruzo los dedos por ti! (frase hecha holandesa: aprietan el pulgar)', updated_at = datetime('now')
WHERE word_es_id = 30 AND lang_code = 'nl_NL';

-- 31: el indice -> de wijsvinger
UPDATE words_lang SET notes = '• [can.] Ik druk met mijn wijsvinger op de bel. — Pulso el timbre con el índice.
• [inv.] Met haar wijsvinger wees ze naar de kaart. — Con el índice señaló el mapa.
• [perf.] Hij heeft met zijn wijsvinger naar mij gewezen. — Me ha señalado con el índice.
• [geb.] Niet wijzen met je wijsvinger! — ¡No señales con el dedo!
• [bijzin] Mama zegt dat wijzen met de wijsvinger onbeleefd is. — Mamá dice que señalar con el índice es de mala educación.', updated_at = datetime('now')
WHERE word_es_id = 31 AND lang_code = 'nl_NL';

-- 32: el dedo medio -> de middelvinger
UPDATE words_lang SET notes = '• [can.] De middelvinger is de langste vinger. — El dedo medio es el más largo.
• [inv.] Alleen om mijn middelvinger past deze ring. — Este anillo solo me cabe en el dedo medio.
• [perf.] Hij heeft zijn middelvinger bezeerd. — Se ha hecho daño en el dedo medio.
• [vraag] Past de ring om je middelvinger? — ¿Te cabe el anillo en el dedo medio?
• [bijzin] Je weet dat een middelvinger opsteken erg grof is. — Ya sabes que levantar el dedo medio es muy grosero.', updated_at = datetime('now')
WHERE word_es_id = 32 AND lang_code = 'nl_NL';

-- 33: el anular -> de ringvinger
UPDATE words_lang SET notes = '• [can.] De trouwring zit om mijn ringvinger. — La alianza va en mi anular.
• [inv.] In Nederland draag je de trouwring vaak rechts aan de ringvinger. — En Países Bajos la alianza suele ir en el anular derecho.
• [perf.] Mijn ringvinger is gezwollen. — Se me ha hinchado el anular.
• [vraag] Aan welke hand draag jij je ringvinger-ring? — ¿En qué mano llevas el anillo del anular?
• [bijzin] De ring zit zo vast dat mijn ringvinger blauw wordt. — El anillo está tan apretado que el anular se me pone morado.', updated_at = datetime('now')
WHERE word_es_id = 33 AND lang_code = 'nl_NL';

-- 34: el menique -> de pink
UPDATE words_lang SET notes = '• [can.] Mijn pink doet pijn. — Me duele el meñique.
• [inv.] Tegen de tafelpoot stootte ik mijn pink. — Contra la pata de la mesa me di el meñique.
• [perf.] Ik heb mijn pink gestoten. — Me he dado un golpe en el meñique.
• [vraag] Drink jij thee met je pink omhoog? — ¿Bebes el té con el meñique levantado?
• [uitdr.] Pink beloven! — ¡Prometido con el meñique! (promesa entre niños)', updated_at = datetime('now')
WHERE word_es_id = 34 AND lang_code = 'nl_NL';

-- 35: el dedo gordo del pie -> de grote teen
UPDATE words_lang SET notes = '• [can.] Mijn grote teen doet pijn. — Me duele el dedo gordo del pie.
• [inv.] Tegen het bed stootte ik mijn grote teen. — Contra la cama me di el dedo gordo.
• [perf.] Ik heb mijn grote teen tegen de deur gebroken. — Me rompí el dedo gordo contra la puerta.
• [geb.] Test het badwater met je grote teen. — Prueba el agua del baño con el dedo gordo.
• [bijzin] Er zit een gat in mijn sok, omdat mijn grote teen erdoorheen prikt. — Hay un agujero en el calcetín porque el dedo gordo lo atraviesa.', updated_at = datetime('now')
WHERE word_es_id = 35 AND lang_code = 'nl_NL';

-- 36: el segundo dedo del pie -> de tweede teen
UPDATE words_lang SET notes = '• [can.] Mijn tweede teen is langer dan mijn grote teen. — Mi segundo dedo es más largo que el gordo.
• [inv.] In deze smalle schoenen doet mijn tweede teen pijn. — Con estos zapatos estrechos me duele el segundo dedo.
• [perf.] Ik heb een blaar op mijn tweede teen gekregen. — Me ha salido una ampolla en el segundo dedo.
• [vraag] Is jouw tweede teen ook zo lang? — ¿Tu segundo dedo también es tan largo?
• [bijzin] De verkoper zegt dat de schoen ruimte voor de tweede teen moet laten. — El vendedor dice que el zapato debe dejar sitio al segundo dedo.', updated_at = datetime('now')
WHERE word_es_id = 36 AND lang_code = 'nl_NL';

-- 37: el tercer dedo del pie -> de derde teen
UPDATE words_lang SET notes = '• [can.] De pleister zit om mijn derde teen. — La tirita va en el tercer dedo del pie.
• [inv.] Na de wandeling is mijn derde teen gevoelig. — Tras la caminata el tercer dedo está sensible.
• [perf.] De podoloog heeft naar mijn derde teen gekeken. — El podólogo me ha mirado el tercer dedo.
• [vraag] Doet je derde teen nog pijn? — ¿Te sigue doliendo el tercer dedo?
• [bijzin] Ik loop raar, omdat mijn derde teen ontstoken is. — Ando raro porque el tercer dedo está inflamado.', updated_at = datetime('now')
WHERE word_es_id = 37 AND lang_code = 'nl_NL';

-- 38: el cuarto dedo del pie -> de vierde teen
UPDATE words_lang SET notes = '• [can.] Mijn vierde teen zit klem in deze schoen. — El cuarto dedo va apretado en este zapato.
• [inv.] Na de stoot is mijn vierde teen blauw. — Tras el golpe el cuarto dedo está morado.
• [perf.] Ik heb een likdoorn op mijn vierde teen gekregen. — Me ha salido un callo en el cuarto dedo.
• [vraag] Welke teen doet pijn, de vierde? — ¿Qué dedo te duele, el cuarto?
• [bijzin] De podoloog denkt dat mijn vierde teen scheef groeit. — El podólogo cree que el cuarto dedo crece torcido.', updated_at = datetime('now')
WHERE word_es_id = 38 AND lang_code = 'nl_NL';

-- 39: el dedo pequeno del pie -> de kleine teen
UPDATE words_lang SET notes = '• [can.] Mijn kleine teen is rood. — El dedo pequeño está rojo.
• [inv.] Tegen het bed stoot iedereen weleens zijn kleine teen. — Contra la cama todo el mundo se da alguna vez el meñique del pie.
• [perf.] Au, ik heb mijn kleine teen gestoten! — ¡Ay, me he dado en el dedo pequeño!
• [vraag] Past je kleine teen nog in die schoen? — ¿Te cabe aún el dedo pequeño en ese zapato?
• [bijzin] Het doet zo''n pijn, omdat de kleine teen vol zenuwen zit. — Duele tanto porque el dedo pequeño está lleno de nervios.', updated_at = datetime('now')
WHERE word_es_id = 39 AND lang_code = 'nl_NL';

-- 40: el cabello -> het haar
UPDATE words_lang SET notes = '• [can.] Ik was mijn haar elke dag. — Me lavo el pelo cada día.
• [inv.] Vandaag zit je haar leuk! — ¡Hoy te queda bien el pelo!
• [perf.] Ik heb mijn haar laten knippen. — Me he cortado el pelo (en la pelu).
• [vraag] Ga je naar de kapper voor je haar? — ¿Vas a la peluquería a por el pelo?
• [uitdr.] Ze zaten elkaar in de haren. — Estaban tirándose de los pelos, discutiendo (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 40 AND lang_code = 'nl_NL';

-- 41: la frente -> het voorhoofd
UPDATE words_lang SET notes = '• [can.] Hij heeft zweet op zijn voorhoofd. — Tiene sudor en la frente.
• [inv.] Bij koorts voel ik altijd even aan het voorhoofd. — Con fiebre siempre toco la frente.
• [perf.] Hij heeft zijn voorhoofd tegen het kastje gestoten. — Se ha dado con la frente en el armarito.
• [vraag] Voel je even aan mijn voorhoofd? — ¿Me tocas la frente? (¿tengo fiebre?)
• [bijzin] Ik denk dat je koorts hebt, omdat je voorhoofd gloeit. — Creo que tienes fiebre porque te arde la frente.', updated_at = datetime('now')
WHERE word_es_id = 41 AND lang_code = 'nl_NL';

-- 42: la ceja -> de wenkbrauw
UPDATE words_lang SET notes = '• [can.] Ze epileert haar wenkbrauwen. — Se depila las cejas.
• [inv.] Van verbazing trok hij een wenkbrauw op. — De asombro levantó una ceja.
• [perf.] Ik heb een wondje boven mijn wenkbrauw gekregen. — Me ha salido una heridita encima de la ceja.
• [vraag] Doe jij iets aan je wenkbrauwen? — ¿Te haces algo en las cejas?
• [bijzin] Ik zag aan zijn wenkbrauwen dat hij het niet geloofde. — Vi por sus cejas que no se lo creía.', updated_at = datetime('now')
WHERE word_es_id = 42 AND lang_code = 'nl_NL';

-- 44: la pestana -> de wimper
UPDATE words_lang SET notes = '• [can.] Er zit een wimper in mijn oog. — Tengo una pestaña en el ojo.
• [inv.] Met mascara lijken haar wimpers langer. — Con rímel sus pestañas parecen más largas.
• [perf.] Er is een wimper in mijn oog gekomen. — Se me ha metido una pestaña en el ojo.
• [geb.] Blaas de wimper weg en doe een wens! — ¡Sopla la pestaña y pide un deseo!
• [bijzin] Ze knippert zo vaak, omdat er een wimper in haar oog zit. — Parpadea tanto porque tiene una pestaña en el ojo.', updated_at = datetime('now')
WHERE word_es_id = 44 AND lang_code = 'nl_NL';

-- 45: el ojo -> het oog
UPDATE words_lang SET notes = '• [can.] Ik heb iets in mijn oog. — Tengo algo en el ojo.
• [inv.] Zonder bril zien mijn ogen niet veel. — Sin gafas mis ojos no ven mucho.
• [perf.] De opticien heeft mijn ogen getest. — El óptico me ha revisado los ojos.
• [geb.] Doe je ogen dicht, verrassing! — ¡Cierra los ojos, sorpresa!
• [uitdr.] Kun je een oogje op de kinderen houden? — ¿Puedes echar un ojo a los niños? (frase hecha)', updated_at = datetime('now')
WHERE word_es_id = 45 AND lang_code = 'nl_NL';

-- 46: la nariz -> de neus
UPDATE words_lang SET notes = '• [can.] Mijn neus loopt. — Me gotea la nariz.
• [inv.] Bij verkoudheid is mijn neus verstopt. — Con el resfriado tengo la nariz taponada.
• [perf.] Ik heb mijn neus gesnoten. — Me he sonado la nariz.
• [geb.] Snuit je neus even. — Suénate la nariz.
• [uitdr.] Hij loopt altijd achter zijn neus aan. — Va a donde le lleva la nariz (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 46 AND lang_code = 'nl_NL';

-- 47: la oreja -> het oor
UPDATE words_lang SET notes = '• [can.] Mijn oren doen pijn van de kou. — Me duelen las orejas por el frío.
• [inv.] In de winter draag ik een muts over mijn oren. — En invierno llevo gorro sobre las orejas.
• [perf.] De dokter heeft in mijn oor gekeken. — El médico me ha mirado el oído.
• [vraag] Heb je last van je oren in het vliegtuig? — ¿Te molestan los oídos en el avión?
• [uitdr.] Ik zit tot over mijn oren in het werk. — Estoy hasta arriba de trabajo (frase hecha: hasta las orejas).', updated_at = datetime('now')
WHERE word_es_id = 47 AND lang_code = 'nl_NL';

-- 48: la mejilla -> de wang
UPDATE words_lang SET notes = '• [can.] Haar wangen zijn rood van de kou. — Tiene las mejillas rojas por el frío.
• [inv.] In Nederland geef je drie kussen op de wang. — En Países Bajos se dan tres besos en la mejilla.
• [perf.] De baby heeft bolle wangetjes gekregen. — Al bebé le han salido mofletes.
• [vraag] Waarom zijn je wangen zo rood? — ¿Por qué tienes las mejillas tan rojas?
• [bijzin] Ze bloosde zo erg dat haar wangen gloeiden. — Se sonrojó tanto que le ardían las mejillas.', updated_at = datetime('now')
WHERE word_es_id = 48 AND lang_code = 'nl_NL';

-- 49: la boca -> de mond
UPDATE words_lang SET notes = '• [can.] Ik spoel mijn mond na het poetsen. — Me enjuago la boca tras el cepillado.
• [inv.] Bij de tandarts moet je je mond wijd opendoen. — En el dentista tienes que abrir bien la boca.
• [perf.] Hij heeft zijn mond gebrand aan de soep. — Se ha quemado la boca con la sopa.
• [geb.] Praat niet met volle mond! — ¡No hables con la boca llena!
• [uitdr.] Hou je mond! — ¡Cállate! (frase hecha, informal)', updated_at = datetime('now')
WHERE word_es_id = 49 AND lang_code = 'nl_NL';

-- 50: el labio -> de lip
UPDATE words_lang SET notes = '• [can.] Mijn lippen zijn droog. — Tengo los labios secos.
• [inv.] In de winter gebruik ik lippenbalsem voor mijn lippen. — En invierno uso bálsamo para los labios.
• [perf.] Ze heeft op haar lip gebeten. — Se ha mordido el labio.
• [vraag] Heb je een koortslip? — ¿Tienes un herpes labial?
• [uitdr.] Ze hangt aan zijn lippen. — Está pendiente de cada palabra suya (frase hecha: cuelga de sus labios).', updated_at = datetime('now')
WHERE word_es_id = 50 AND lang_code = 'nl_NL';

-- 51: el diente -> de tand
UPDATE words_lang SET notes = '• [can.] Ik poets mijn tanden twee keer per dag. — Me cepillo los dientes dos veces al día.
• [inv.] Voor het slapen poets je je tanden. — Antes de dormir te cepillas los dientes.
• [perf.] De tandarts heeft mijn tanden gecontroleerd. — El dentista me ha revisado los dientes.
• [geb.] Poets je tanden! — ¡Cepíllate los dientes!
• [uitdr.] Ik moet even doorbijten. — Tengo que apretar los dientes y aguantar (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 51 AND lang_code = 'nl_NL';

-- 52: la encia -> het tandvlees
UPDATE words_lang SET notes = '• [can.] Mijn tandvlees bloedt bij het poetsen. — Me sangran las encías al cepillarme.
• [inv.] Bij het flossen bloedt mijn tandvlees soms. — Al usar hilo dental a veces me sangra la encía.
• [perf.] De tandarts heeft mijn tandvlees behandeld. — El dentista me ha tratado la encía.
• [vraag] Is je tandvlees ontstoken? — ¿Tienes la encía inflamada?
• [bijzin] De mondhygiënist zegt dat gezond tandvlees roze is. — La higienista dice que la encía sana es rosada.', updated_at = datetime('now')
WHERE word_es_id = 52 AND lang_code = 'nl_NL';

-- 53: el paladar -> het gehemelte
UPDATE words_lang SET notes = '• [can.] Mijn gehemelte doet pijn. — Me duele el paladar.
• [inv.] Aan de hete thee verbrandde ik mijn gehemelte. — Con el té caliente me quemé el paladar.
• [perf.] Ik heb mijn gehemelte aan de pizza verbrand. — Me he quemado el paladar con la pizza.
• [vraag] Plakt de pindakaas aan je gehemelte? — ¿Se te pega la crema de cacahuete al paladar?
• [bijzin] Het is vervelend dat chips zo scherp tegen het gehemelte zijn. — Es molesto que las patatas fritas rasquen tanto el paladar.', updated_at = datetime('now')
WHERE word_es_id = 53 AND lang_code = 'nl_NL';

-- 54: la lengua -> de tong
UPDATE words_lang SET notes = '• [can.] Ik heb mijn tong gebrand. — Me he quemado la lengua.
• [inv.] Aan de hete soep brandde ik mijn tong. — Con la sopa caliente me quemé la lengua.
• [perf.] De dokter heeft naar mijn tong gekeken. — El médico me ha mirado la lengua.
• [geb.] Steek je tong eens uit. — Saca la lengua.
• [uitdr.] Het ligt op het puntje van mijn tong. — Lo tengo en la punta de la lengua (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 54 AND lang_code = 'nl_NL';

-- 55: la barbilla -> de kin
UPDATE words_lang SET notes = '• [can.] Hij steunt zijn kin op zijn hand. — Apoya la barbilla en la mano.
• [inv.] Onder mijn kin zit de helmband strak. — Bajo la barbilla la correa del casco va apretada.
• [perf.] Je hebt chocolade op je kin gekregen. — Se te ha quedado chocolate en la barbilla.
• [geb.] Kin omhoog! — ¡Barbilla arriba! (¡ánimo!)
• [bijzin] De trainer zegt dat je je kin omhoog moet houden. — El entrenador dice que mantengas la barbilla alta.', updated_at = datetime('now')
WHERE word_es_id = 55 AND lang_code = 'nl_NL';

-- 56: la barba -> de baard
UPDATE words_lang SET notes = '• [can.] Hij heeft een lange baard. — Tiene una barba larga.
• [inv.] Deze winter laat hij zijn baard staan. — Este invierno se deja la barba.
• [perf.] Ik heb mijn baard bijgewerkt. — Me he recortado la barba.
• [vraag] Staat een baard mij goed? — ¿Me queda bien la barba?
• [uitdr.] Die grap heeft een baard. — Ese chiste tiene barba: está muy visto (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 56 AND lang_code = 'nl_NL';

-- 57: el bigote -> de snor
UPDATE words_lang SET notes = '• [can.] Mijn opa draagt een snor. — Mi abuelo lleva bigote.
• [inv.] Na veertig jaar schoor hij zijn snor af. — Después de cuarenta años se afeitó el bigote.
• [perf.] Hij heeft zijn snor afgeschoren. — Se ha afeitado el bigote.
• [vraag] Zit er melkschuim aan mijn snor? — ¿Tengo espuma de leche en el bigote?
• [uitdr.] Dat zit wel snor. — Eso está controlado, va bien (frase hecha muy común).', updated_at = datetime('now')
WHERE word_es_id = 57 AND lang_code = 'nl_NL';

-- 58: el biceps -> de biceps
UPDATE words_lang SET notes = '• [can.] Hij traint zijn biceps in de sportschool. — Entrena los bíceps en el gimnasio.
• [inv.] Na de training heeft hij spierpijn in zijn biceps. — Tras el entreno tiene agujetas en el bíceps.
• [perf.] Ik heb mijn biceps zwaar getraind. — He entrenado fuerte el bíceps.
• [vraag] Hoe vaak train jij je biceps? — ¿Cada cuánto entrenas el bíceps?
• [bijzin] Hij is trots dat zijn biceps groter worden. — Está orgulloso de que sus bíceps crezcan.', updated_at = datetime('now')
WHERE word_es_id = 58 AND lang_code = 'nl_NL';

-- 59: el triceps -> de triceps
UPDATE words_lang SET notes = '• [can.] Deze oefening is goed voor de triceps. — Este ejercicio es bueno para el tríceps.
• [inv.] Bij push-ups gebruik je vooral je triceps. — En las flexiones usas sobre todo el tríceps.
• [perf.] Ik heb mijn triceps gisteren getraind. — Ayer entrené el tríceps.
• [geb.] Vergeet je triceps niet! — ¡No te olvides del tríceps!
• [bijzin] De trainer legt uit hoe je de triceps veilig traint. — El entrenador explica cómo entrenar el tríceps con seguridad.', updated_at = datetime('now')
WHERE word_es_id = 59 AND lang_code = 'nl_NL';

-- 60: los gluteos -> de billen
UPDATE words_lang SET notes = '• [can.] Squats zijn goed voor je billen. — Las sentadillas son buenas para los glúteos.
• [inv.] Van het fietszadel doen mijn billen pijn. — Por el sillín me duelen los glúteos.
• [perf.] De baby heeft rode billetjes gekregen. — Al bebé se le ha irritado el culito.
• [vraag] Voel je de oefening in je billen? — ¿Notas el ejercicio en los glúteos?
• [uitdr.] Hij moest met de billen bloot. — Tuvo que dar la cara y confesar (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 60 AND lang_code = 'nl_NL';

-- 61: el culo -> de kont
UPDATE words_lang SET notes = '• [can.] Ik viel op mijn kont. — Me caí de culo (informal).
• [inv.] Op het ijs viel ik op mijn kont. — En el hielo me caí de culo.
• [perf.] Hij heeft de hele dag op zijn kont gezeten. — Se ha pasado el día sentado sin hacer nada (lit. sobre el culo).
• [geb.] Kom van je kont en help even! — ¡Levanta el culo y ayuda! (muy coloquial)
• [uitdr.] Je kunt hier je kont niet keren. — Aquí no hay sitio ni para darse la vuelta (frase hecha, típica en casas pequeñas).', updated_at = datetime('now')
WHERE word_es_id = 61 AND lang_code = 'nl_NL';

-- 62: la una -> de nagel
UPDATE words_lang SET notes = '• [can.] Ik knip mijn nagels elke week. — Me corto las uñas cada semana.
• [inv.] Vanavond lakt ze haar nagels rood. — Esta noche se pinta las uñas de rojo.
• [perf.] Ik heb mijn nagels geknipt. — Me he cortado las uñas.
• [geb.] Niet op je nagels bijten! — ¡No te muerdas las uñas!
• [uitdr.] Die jongen is een nagel aan mijn doodskist. — Ese chico me saca de quicio (frase hecha: un clavo en mi ataúd).', updated_at = datetime('now')
WHERE word_es_id = 62 AND lang_code = 'nl_NL';

-- 63: la piel -> de huid
UPDATE words_lang SET notes = '• [can.] Mijn huid is droog in de winter. — Tengo la piel seca en invierno.
• [inv.] In de zomer smeer ik mijn huid goed in. — En verano me pongo bien de crema en la piel.
• [perf.] Ik heb mijn huid verbrand in de zon. — Me he quemado la piel al sol.
• [geb.] Smeer je huid in met factor 30! — ¡Ponte crema del factor 30!
• [uitdr.] Ik zou niet in zijn huid willen zitten. — No me gustaría estar en su pellejo (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 63 AND lang_code = 'nl_NL';

-- 64: el hueso -> het bot
UPDATE words_lang SET notes = '• [can.] De hond kauwt op een bot. — El perro mordisquea un hueso.
• [inv.] Gelukkig is er geen bot gebroken. — Por suerte no se ha roto ningún hueso.
• [perf.] Ik heb nog nooit een bot gebroken. — Nunca me he roto un hueso.
• [vraag] Is melk echt goed voor je botten? — ¿La leche es de verdad buena para los huesos?
• [uitdr.] Ik ben tot op het bot verkleumd. — Estoy helado hasta los huesos (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 64 AND lang_code = 'nl_NL';

-- 65: el musculo -> de spier
UPDATE words_lang SET notes = '• [can.] Ik heb spierpijn na het sporten. — Tengo agujetas después del deporte.
• [inv.] Zonder warming-up verrek je snel een spier. — Sin calentamiento te estiras un músculo enseguida.
• [perf.] Ik heb een spier verrekt met voetballen. — Me estiré un músculo jugando al fútbol.
• [geb.] Warm je spieren goed op! — ¡Calienta bien los músculos!
• [bijzin] De fysio zegt dat mijn spieren te gespannen zijn. — El fisio dice que mis músculos están demasiado tensos.', updated_at = datetime('now')
WHERE word_es_id = 65 AND lang_code = 'nl_NL';

-- 66: los genitales -> de geslachtsdelen
UPDATE words_lang SET notes = '• [can.] Het is een formeel, medisch woord. — Es una palabra formal, médica.
• [inv.] Bij het sporten bescherm je de geslachtsdelen met een tok. — En el deporte proteges los genitales con una coquilla.
• [perf.] De dokter heeft de geslachtsdelen onderzocht. — El médico ha examinado los genitales.
• [vraag] Waarom onderzoekt de dokter de geslachtsdelen? — ¿Por qué examina el médico los genitales?
• [bijzin] De arts legt uit dat het onderzoek van de geslachtsdelen nodig is. — El médico explica que el examen de los genitales es necesario.', updated_at = datetime('now')
WHERE word_es_id = 66 AND lang_code = 'nl_NL';

-- 67: el parpado -> het ooglid
UPDATE words_lang SET notes = '• [can.] Mijn ooglid trilt. — Me tiembla el párpado.
• [inv.] Van vermoeidheid trilt mijn ooglid. — Del cansancio me tiembla el párpado.
• [perf.] Er is een strontje op mijn ooglid gekomen. — Me ha salido un orzuelo en el párpado.
• [vraag] Trilt je ooglid ook weleens? — ¿A ti también te tiembla el párpado a veces?
• [bijzin] Ik ga slapen, omdat mijn oogleden zwaar worden. — Me voy a dormir porque se me cierran los párpados.', updated_at = datetime('now')
WHERE word_es_id = 67 AND lang_code = 'nl_NL';

-- 68: la habitacion -> de slaapkamer
UPDATE words_lang SET notes = '• [can.] Ik ruim mijn slaapkamer op. — Ordeno mi habitación.
• [inv.] Boven is de slaapkamer, naast de badkamer. — Arriba está el dormitorio, junto al baño.
• [perf.] We hebben de slaapkamer geverfd. — Hemos pintado el dormitorio.
• [geb.] Ruim eerst je slaapkamer op! — ¡Primero ordena tu habitación!
• [bijzin] We zoeken een huis dat drie slaapkamers heeft. — Buscamos una casa que tenga tres dormitorios.', updated_at = datetime('now')
WHERE word_es_id = 68 AND lang_code = 'nl_NL';

-- 69: la cama -> het bed
UPDATE words_lang SET notes = '• [can.] Ik ga om elf uur naar bed. — Me voy a la cama a las once.
• [inv.] ''s Ochtends maak ik meteen mijn bed op. — Por la mañana hago la cama enseguida.
• [perf.] Heb je je bed al opgemaakt? — ¿Ya has hecho la cama?
• [geb.] Ga naar bed, het is laat! — ¡Vete a la cama, es tarde!
• [uitdr.] Hij is met het verkeerde been uit bed gestapt. — Se ha levantado con el pie izquierdo (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 69 AND lang_code = 'nl_NL';

-- 70: la lampara -> de lamp
UPDATE words_lang SET notes = '• [can.] Ik doe de lamp aan. — Enciendo la lámpara.
• [inv.] Bij IKEA kochten we een nieuwe lamp. — En IKEA compramos una lámpara nueva.
• [perf.] De lamp is kapotgegaan. — La lámpara se ha roto.
• [geb.] Doe de lamp even uit. — Apaga la lámpara.
• [uitdr.] Daar komt hij tegen de lamp. — Ahí le van a pillar (frase hecha: chocar contra la lámpara).', updated_at = datetime('now')
WHERE word_es_id = 70 AND lang_code = 'nl_NL';

-- 71: la mesa de noche -> het nachtkastje
UPDATE words_lang SET notes = '• [can.] Mijn bril ligt op het nachtkastje. — Mis gafas están en la mesita de noche.
• [inv.] In de la van het nachtkastje ligt de oplader. — En el cajón de la mesita está el cargador.
• [perf.] Ik heb het glas water op het nachtkastje gezet. — He puesto el vaso de agua en la mesita.
• [geb.] Leg je telefoon op het nachtkastje. — Deja el móvil en la mesita de noche.
• [bijzin] Ik pak mijn boek, dat op het nachtkastje ligt. — Cojo mi libro, que está en la mesita de noche.', updated_at = datetime('now')
WHERE word_es_id = 71 AND lang_code = 'nl_NL';

-- 72: el edredon -> het dekbed
UPDATE words_lang SET notes = '• [can.] Ik kruip onder het dekbed. — Me meto bajo el edredón.
• [inv.] In de zomer gebruik ik een dun dekbed. — En verano uso un edredón fino.
• [perf.] Ik heb het dekbedovertrek gewassen. — He lavado la funda del edredón.
• [vraag] Heb jij een winter- en een zomerdekbed? — ¿Tienes edredón de invierno y de verano?
• [bijzin] Ik blijf liggen, omdat het onder het dekbed zo lekker warm is. — Me quedo tumbado porque bajo el edredón se está calentito.', updated_at = datetime('now')
WHERE word_es_id = 72 AND lang_code = 'nl_NL';

-- 73: la sabana -> het laken
UPDATE words_lang SET notes = '• [can.] Ik verschoon de lakens elke week. — Cambio las sábanas cada semana.
• [inv.] Op zaterdag verschoon ik altijd de lakens. — Los sábados siempre cambio las sábanas.
• [perf.] Ik heb schone lakens op het bed gelegd. — He puesto sábanas limpias en la cama.
• [vraag] Past dit hoeslaken om het matras? — ¿Esta bajera encaja en el colchón?
• [uitdr.] Zij deelt hier de lakens uit. — Aquí manda ella (frase hecha: reparte las sábanas).', updated_at = datetime('now')
WHERE word_es_id = 73 AND lang_code = 'nl_NL';

-- 74: la almohada -> het kussen
UPDATE words_lang SET notes = '• [can.] Mijn kussen is te hard. — Mi almohada es demasiado dura.
• [inv.] Zonder kussen kan ik niet slapen. — Sin almohada no puedo dormir.
• [perf.] Ik heb een nieuw kussen gekocht. — He comprado una almohada nueva.
• [vraag] Slaap jij met één of twee kussens? — ¿Duermes con una o dos almohadas?
• [uitdr.] Daar moet ik nog een nachtje over slapen. — Tengo que consultarlo con la almohada (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 74 AND lang_code = 'nl_NL';

-- 75: la frazada -> de deken
UPDATE words_lang SET notes = '• [can.] Ik pak een deken voor op de bank. — Cojo una manta para el sofá.
• [inv.] Vanavond is het koud, dus pak een deken. — Esta noche hace frío, así que coge una manta.
• [perf.] Ik heb de deken over de baby gelegd. — He puesto la manta sobre el bebé.
• [vraag] Wil je een extra deken? — ¿Quieres una manta extra?
• [bijzin] Ik neem een deken mee, omdat het in het park fris wordt. — Me llevo una manta porque en el parque refresca.', updated_at = datetime('now')
WHERE word_es_id = 75 AND lang_code = 'nl_NL';

-- 76: la manta -> de deken
UPDATE words_lang SET notes = '• [can.] De deken kriebelt een beetje. — La manta pica un poco.
• [inv.] Onder een dekentje kijken we film. — Bajo una mantita vemos una peli.
• [perf.] Ik heb de dekens uit de kast gepakt. — He sacado las mantas del armario.
• [geb.] Pak een deken, je rilt! — ¡Coge una manta, estás tiritando!
• [bijzin] De logeerkamer heeft een kast waar extra dekens liggen. — El cuarto de invitados tiene un armario donde hay mantas de sobra.', updated_at = datetime('now')
WHERE word_es_id = 76 AND lang_code = 'nl_NL';

-- 77: las cortinas -> de gordijnen
UPDATE words_lang SET notes = '• [can.] Ik doe de gordijnen dicht. — Cierro las cortinas.
• [inv.] In Nederland laten veel mensen de gordijnen open. — En Países Bajos mucha gente deja las cortinas abiertas.
• [perf.] We hebben nieuwe gordijnen opgehangen. — Hemos colgado cortinas nuevas.
• [geb.] Doe de gordijnen even open! — ¡Abre las cortinas!
• [bijzin] De zon schijnt zo fel dat ik de gordijnen dichtdoe. — El sol pega tan fuerte que cierro las cortinas.', updated_at = datetime('now')
WHERE word_es_id = 77 AND lang_code = 'nl_NL';

-- 78: la persiana -> het rolgordijn
UPDATE words_lang SET notes = '• [can.] Ik doe het rolgordijn naar beneden. — Bajo el estor.
• [inv.] ''s Avonds gaan de rolgordijnen omlaag. — Por la noche se bajan los estores.
• [perf.] Het rolgordijn is vast komen te zitten. — La persiana se ha atascado.
• [geb.] Trek het rolgordijn even omhoog. — Sube la persiana.
• [bijzin] Ik koop een verduisterend rolgordijn, zodat de kamer donker blijft. — Compro un estor opaco para que el cuarto quede oscuro.', updated_at = datetime('now')
WHERE word_es_id = 78 AND lang_code = 'nl_NL';

-- 79: el armario -> de kast
UPDATE words_lang SET notes = '• [can.] Ik hang mijn jas in de kast. — Cuelgo el abrigo en el armario.
• [inv.] In de kast liggen de handdoeken. — En el armario están las toallas.
• [perf.] Ik heb de kast opgeruimd. — He ordenado el armario.
• [geb.] Hang je kleren in de kast! — ¡Cuelga tu ropa en el armario!
• [uitdr.] Hij is uit de kast gekomen. — Ha salido del armario (frase hecha, igual que en español).', updated_at = datetime('now')
WHERE word_es_id = 79 AND lang_code = 'nl_NL';

-- 80: el colchon -> de matras
UPDATE words_lang SET notes = '• [can.] Dit matras ligt heerlijk. — Este colchón es comodísimo.
• [inv.] Om de paar maanden draai ik het matras om. — Cada pocos meses doy la vuelta al colchón.
• [perf.] We hebben een nieuw matras gekocht. — Hemos comprado un colchón nuevo.
• [vraag] Slaap je op een hard of zacht matras? — ¿Duermes en colchón duro o blando?
• [bijzin] Mijn rug doet pijn, omdat het matras te oud is. — Me duele la espalda porque el colchón es muy viejo.', updated_at = datetime('now')
WHERE word_es_id = 80 AND lang_code = 'nl_NL';

-- 81: la alfombra -> het tapijt
UPDATE words_lang SET notes = '• [can.] Het tapijt ligt in de woonkamer. — La alfombra está en el salón.
• [inv.] Elke week stofzuig ik het tapijt. — Cada semana aspiro la alfombra.
• [perf.] Ik heb koffie op het tapijt gemorst. — He derramado café en la alfombra.
• [geb.] Loop niet met schoenen over het tapijt! — ¡No pises la alfombra con zapatos!
• [uitdr.] Dat is onder het tapijt geveegd. — Eso lo han barrido bajo la alfombra (frase hecha, igual que en español).', updated_at = datetime('now')
WHERE word_es_id = 81 AND lang_code = 'nl_NL';

-- 82: el despertador -> de wekker
UPDATE words_lang SET notes = '• [can.] Ik zet de wekker op zeven uur. — Pongo el despertador a las siete.
• [inv.] Morgen gaat de wekker om zes uur. — Mañana suena el despertador a las seis.
• [perf.] De wekker is niet afgegaan! — ¡No ha sonado el despertador!
• [vraag] Hoe laat zet jij je wekker? — ¿A qué hora pones el despertador?
• [bijzin] Ik ben te laat, omdat de wekker niet is afgegaan. — Llego tarde porque el despertador no ha sonado.', updated_at = datetime('now')
WHERE word_es_id = 82 AND lang_code = 'nl_NL';

-- 83: la television -> de televisie
UPDATE words_lang SET notes = '• [can.] We kijken het nieuws op televisie. — Vemos las noticias en la televisión.
• [inv.] Vanavond is er voetbal op televisie. — Esta noche hay fútbol en la tele.
• [perf.] Ik heb de televisie uitgezet. — He apagado la televisión.
• [geb.] Zet de televisie uit tijdens het eten! — ¡Apaga la tele durante la comida!
• [bijzin] Ik weet niet wat er vanavond op televisie is. — No sé qué ponen esta noche en la tele.', updated_at = datetime('now')
WHERE word_es_id = 83 AND lang_code = 'nl_NL';

-- 84: el cargador -> de oplader
UPDATE words_lang SET notes = '• [can.] Mijn oplader zit in het stopcontact. — Mi cargador está enchufado.
• [inv.] Op het werk ben ik mijn oplader vergeten. — En el trabajo me dejé el cargador.
• [perf.] Ik heb mijn oplader op kantoor laten liggen. — Me he dejado el cargador en la oficina.
• [vraag] Heb je een oplader voor mij? — ¿Tienes un cargador para mí?
• [bijzin] Mijn telefoon is leeg, omdat ik de oplader kwijt ben. — El móvil está sin batería porque he perdido el cargador.', updated_at = datetime('now')
WHERE word_es_id = 84 AND lang_code = 'nl_NL';

-- 85: las chanclas -> de slippers
UPDATE words_lang SET notes = '• [can.] Ik loop op slippers naar het strand. — Voy en chanclas a la playa.
• [inv.] In het zwembad draag je slippers. — En la piscina llevas chanclas.
• [perf.] Mijn slipper is kapotgegaan. — Se me ha roto la chancla.
• [geb.] Doe je slippers aan! — ¡Ponte las chanclas!
• [bijzin] Ik neem slippers mee, omdat de tegels heet worden. — Me llevo chanclas porque las baldosas queman.', updated_at = datetime('now')
WHERE word_es_id = 85 AND lang_code = 'nl_NL';

-- 86: el pijama -> de pyjama
UPDATE words_lang SET notes = '• [can.] Ik doe mijn pyjama aan. — Me pongo el pijama.
• [inv.] Op zaterdagochtend blijf ik lekker in pyjama. — El sábado por la mañana me quedo a gusto en pijama.
• [perf.] De kinderen hebben hun pyjama al aangedaan. — Los niños ya se han puesto el pijama.
• [geb.] Trek je pyjama aan, het is bedtijd! — ¡Ponte el pijama, es hora de dormir!
• [bijzin] Ik werk thuis, dus soms zit ik tot twaalf uur in pyjama. — Trabajo en casa, así que a veces sigo en pijama hasta las doce.', updated_at = datetime('now')
WHERE word_es_id = 86 AND lang_code = 'nl_NL';

-- 87: los calcetines -> de sokken
UPDATE words_lang SET notes = '• [can.] Ik draag wollen sokken in de winter. — Llevo calcetines de lana en invierno.
• [inv.] In mijn sok zit een gat. — En mi calcetín hay un agujero.
• [perf.] Ik heb schone sokken aangetrokken. — Me he puesto calcetines limpios.
• [geb.] Trek warme sokken aan, het vriest! — ¡Ponte calcetines calientes, está helando!
• [uitdr.] Er de sokken in zetten. — Darse prisa, apretar el paso (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 87 AND lang_code = 'nl_NL';

-- 88: el cabecero de la cama -> het hoofdeinde
UPDATE words_lang SET notes = '• [can.] Het hoofdeinde staat tegen de muur. — El cabecero está contra la pared.
• [inv.] Tegen het hoofdeinde zet ik mijn kussen. — Contra el cabecero apoyo la almohada.
• [perf.] We hebben het hoofdeinde iets omhoog gezet. — Hemos subido un poco el cabecero.
• [vraag] Kun je het hoofdeinde verstellen? — ¿Se puede regular el cabecero?
• [bijzin] Ik lees graag, terwijl ik tegen het hoofdeinde leun. — Me gusta leer mientras me apoyo en el cabecero.', updated_at = datetime('now')
WHERE word_es_id = 88 AND lang_code = 'nl_NL';

-- 89: el somier -> de bedbodem
UPDATE words_lang SET notes = '• [can.] De bedbodem kraakt. — El somier cruje.
• [inv.] Bij het omdraaien kraakt de bedbodem. — Al darme la vuelta cruje el somier.
• [perf.] Er is een lat van de bedbodem gebroken. — Se ha roto una lama del somier.
• [vraag] Hoe oud is jullie bedbodem? — ¿Cuántos años tiene vuestro somier?
• [bijzin] De verkoper zegt dat de bedbodem net zo belangrijk is als het matras. — El vendedor dice que el somier es tan importante como el colchón.', updated_at = datetime('now')
WHERE word_es_id = 89 AND lang_code = 'nl_NL';

-- 90: el cuadro -> het schilderij
UPDATE words_lang SET notes = '• [can.] Het schilderij hangt boven de bank. — El cuadro cuelga encima del sofá.
• [inv.] Op de markt kochten we een schilderij. — En el mercadillo compramos un cuadro.
• [perf.] We hebben het schilderij opgehangen. — Hemos colgado el cuadro.
• [vraag] Hangt het schilderij recht? — ¿Está recto el cuadro?
• [bijzin] Ik vind dat het schilderij scheef hangt. — Me parece que el cuadro está torcido.', updated_at = datetime('now')
WHERE word_es_id = 90 AND lang_code = 'nl_NL';

-- 91: el marco de una foto -> de fotolijst
UPDATE words_lang SET notes = '• [can.] De trouwfoto staat in een fotolijst. — La foto de boda está en un marco.
• [inv.] Op het dressoir staan drie fotolijsten. — Sobre el aparador hay tres marcos de fotos.
• [perf.] De fotolijst is van de plank gevallen. — El marco se ha caído de la balda.
• [vraag] Heb je een fotolijst van 20 bij 30? — ¿Tienes un marco de 20 por 30?
• [bijzin] Ik zoek een fotolijst die bij de kast past. — Busco un marco que pegue con el armario.', updated_at = datetime('now')
WHERE word_es_id = 91 AND lang_code = 'nl_NL';

-- 92: el foco -> de gloeilamp
UPDATE words_lang SET notes = '• [can.] De gloeilamp is kapot. — La bombilla está fundida.
• [inv.] Tegenwoordig koop ik alleen ledlampen in plaats van gloeilampen. — Hoy en día solo compro led en vez de incandescentes.
• [perf.] Ik heb de gloeilamp vervangen. — He cambiado la bombilla.
• [geb.] Pas op, de gloeilamp is nog heet! — ¡Cuidado, la bombilla aún quema!
• [bijzin] Het licht doet het niet, omdat de gloeilamp stuk is. — La luz no funciona porque la bombilla está fundida.', updated_at = datetime('now')
WHERE word_es_id = 92 AND lang_code = 'nl_NL';

-- 93: la puerta -> de deur
UPDATE words_lang SET notes = '• [can.] Ik doe de deur dicht. — Cierro la puerta.
• [inv.] Voor de deur staat iemand. — Hay alguien en la puerta.
• [perf.] Heb je de deur op slot gedaan? — ¿Has cerrado la puerta con llave?
• [geb.] Doe de deur even dicht, het tocht! — ¡Cierra la puerta, hay corriente!
• [uitdr.] Dat doet de deur dicht! — ¡Es la gota que colma el vaso! (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 93 AND lang_code = 'nl_NL';

-- 94: la cerradura -> het slot
UPDATE words_lang SET notes = '• [can.] De sleutel past niet op het slot. — La llave no encaja en la cerradura.
• [inv.] In Nederland doe je je fiets altijd op slot. — En Países Bajos siempre pones el candado a la bici.
• [perf.] Het slot is geroest. — La cerradura se ha oxidado.
• [geb.] Doe de deur op slot! — ¡Cierra con llave!
• [uitdr.] Dat is een sprookje: en ze leefden nog lang en gelukkig, slot. — "Slot" también es final: tot slot = por último.', updated_at = datetime('now')
WHERE word_es_id = 94 AND lang_code = 'nl_NL';

-- 95: el marco de la puerta -> de deurkozijn
UPDATE words_lang SET notes = '• [can.] Hij leunt tegen het deurkozijn. — Está apoyado en el marco de la puerta.
• [inv.] Tegen het deurkozijn stootte ik mijn hoofd. — Contra el marco de la puerta me di en la cabeza.
• [perf.] We hebben het deurkozijn wit geschilderd. — Hemos pintado el marco de blanco.
• [vraag] Moet het deurkozijn ook geverfd worden? — ¿Hay que pintar también el marco de la puerta?
• [bijzin] Het deurkozijn is zo laag dat ik moet bukken. — El marco es tan bajo que tengo que agacharme.', updated_at = datetime('now')
WHERE word_es_id = 95 AND lang_code = 'nl_NL';

-- 96: las pantuflas -> de pantoffels
UPDATE words_lang SET notes = '• [can.] Ik loop op pantoffels door het huis. — Voy en pantuflas por la casa.
• [inv.] De hele dag loopt opa op pantoffels. — Todo el día va el abuelo en pantuflas.
• [perf.] Ik heb nieuwe pantoffels voor Sinterklaas gekregen. — Me regalaron pantuflas nuevas por Sinterklaas.
• [vraag] Waar zijn mijn pantoffels? — ¿Dónde están mis pantuflas?
• [bijzin] Ik doe mijn pantoffels aan, omdat mijn voeten koud zijn. — Me pongo las pantuflas porque tengo los pies fríos.', updated_at = datetime('now')
WHERE word_es_id = 96 AND lang_code = 'nl_NL';

-- 97: el borde de la cama -> de bedrand
UPDATE words_lang SET notes = '• [can.] Hij zit op de bedrand. — Está sentado en el borde de la cama.
• [inv.] Op de bedrand trek ik mijn sokken aan. — En el borde de la cama me pongo los calcetines.
• [perf.] Ik heb mijn scheen tegen de bedrand gestoten. — Me he dado en la espinilla con el borde de la cama.
• [vraag] Slaapt de kat weer op de bedrand? — ¿El gato duerme otra vez en el borde de la cama?
• [bijzin] Ga even op de bedrand zitten, terwijl ik de lakens verschoon. — Siéntate en el borde mientras cambio las sábanas.', updated_at = datetime('now')
WHERE word_es_id = 97 AND lang_code = 'nl_NL';

-- 98: el tomacorriente -> het stopcontact
UPDATE words_lang SET notes = '• [can.] De stekker zit in het stopcontact. — El enchufe está en la toma.
• [inv.] Bij het nachtkastje is geen stopcontact. — Junto a la mesita no hay toma de corriente.
• [perf.] De elektricien heeft een extra stopcontact geplaatst. — El electricista ha puesto una toma extra.
• [vraag] Zit de stekker wel in het stopcontact? — ¿Seguro que el enchufe está en la toma?
• [bijzin] We plaatsen kindveilige stopcontacten, omdat de baby gaat kruipen. — Ponemos tomas con protección infantil porque el bebé va a gatear.', updated_at = datetime('now')
WHERE word_es_id = 98 AND lang_code = 'nl_NL';

-- 99: el enchufe -> de stekker
UPDATE words_lang SET notes = '• [can.] Ik trek de stekker eruit. — Desenchufo (saco el enchufe).
• [inv.] Voor het schoonmaken trek je de stekker eruit. — Antes de limpiar, desenchufas.
• [perf.] Ik heb de stekker van de tv eruit getrokken. — He desenchufado la tele.
• [geb.] Trek de stekker eruit! — ¡Desenchúfalo!
• [uitdr.] Ze hebben de stekker uit het project getrokken. — Han cancelado el proyecto (frase hecha: sacar el enchufe).', updated_at = datetime('now')
WHERE word_es_id = 99 AND lang_code = 'nl_NL';

-- 100: el interruptor -> de schakelaar
UPDATE words_lang SET notes = '• [can.] De schakelaar zit naast de deur. — El interruptor está junto a la puerta.
• [inv.] Naast de deur zit de schakelaar van het licht. — Junto a la puerta está el interruptor de la luz.
• [perf.] De elektricien heeft de schakelaar vervangen. — El electricista ha cambiado el interruptor.
• [geb.] Druk op de schakelaar. — Pulsa el interruptor.
• [bijzin] Het licht blijft uit, omdat de schakelaar kapot is. — La luz no se enciende porque el interruptor está roto.', updated_at = datetime('now')
WHERE word_es_id = 100 AND lang_code = 'nl_NL';

-- 101: el reloj de pared -> de wandklok
UPDATE words_lang SET notes = '• [can.] De wandklok hangt in de keuken. — El reloj de pared está en la cocina.
• [inv.] Volgens de wandklok is het al vijf uur. — Según el reloj de pared ya son las cinco.
• [perf.] De batterij van de wandklok is leeggegaan. — La pila del reloj de pared se ha gastado.
• [vraag] Loopt de wandklok voor of achter? — ¿El reloj va adelantado o atrasado?
• [bijzin] Ik weet dat de wandklok vijf minuten voorloopt. — Sé que el reloj de pared va cinco minutos adelantado.', updated_at = datetime('now')
WHERE word_es_id = 101 AND lang_code = 'nl_NL';

-- 102: el rodapie -> de plint
UPDATE words_lang SET notes = '• [can.] De plinten zijn wit. — Los rodapiés son blancos.
• [inv.] Langs de plinten stofzuig ik ook even. — Por los rodapiés también paso la aspiradora.
• [perf.] De plint is losgelaten in de gang. — El rodapié se ha despegado en el pasillo.
• [geb.] Stofzuig ook langs de plinten! — ¡Aspira también los rodapiés!
• [bijzin] We schilderen de plinten, voordat de vloer erin gaat. — Pintamos los rodapiés antes de poner el suelo.', updated_at = datetime('now')
WHERE word_es_id = 102 AND lang_code = 'nl_NL';

-- 103: el salon -> de woonkamer
UPDATE words_lang SET notes = '• [can.] We zitten in de woonkamer. — Estamos en el salón.
• [inv.] In de woonkamer staat de bank. — En el salón está el sofá.
• [perf.] We hebben de woonkamer opnieuw ingericht. — Hemos redecorado el salón.
• [geb.] Kom naar de woonkamer, het eten is klaar! — ¡Ven al salón, la comida está lista!
• [bijzin] Dit is de woonkamer, waar we ''s avonds tv kijken. — Este es el salón, donde vemos la tele por la noche.', updated_at = datetime('now')
WHERE word_es_id = 103 AND lang_code = 'nl_NL';

-- 104: el sofa -> de bank
UPDATE words_lang SET notes = '• [can.] Ik lig op de bank. — Estoy tumbado en el sofá.
• [inv.] Na het werk plof ik op de bank. — Después del trabajo me dejo caer en el sofá.
• [perf.] We hebben een nieuwe bank besteld. — Hemos encargado un sofá nuevo.
• [vraag] Mag de kat op de bank? — ¿El gato puede subirse al sofá?
• [bijzin] Let op dat "de bank" ook het geldkantoor is. — Ojo: "de bank" también es el banco (de dinero).', updated_at = datetime('now')
WHERE word_es_id = 104 AND lang_code = 'nl_NL';

-- 105: el sillon -> de fauteuil
UPDATE words_lang SET notes = '• [can.] Opa zit in zijn fauteuil. — El abuelo está en su sillón.
• [inv.] In die fauteuil lees ik het lekkerst. — En ese sillón es donde mejor leo.
• [perf.] We hebben een tweedehands fauteuil gekocht. — Hemos comprado un sillón de segunda mano.
• [vraag] Zit die fauteuil lekker? — ¿Es cómodo ese sillón?
• [bijzin] Dit is de fauteuil waarin opa altijd in slaap valt. — Este es el sillón en el que el abuelo siempre se duerme.', updated_at = datetime('now')
WHERE word_es_id = 105 AND lang_code = 'nl_NL';

-- 106: la mesa de centro -> de salontafel
UPDATE words_lang SET notes = '• [can.] De koffie staat op de salontafel. — El café está en la mesa de centro.
• [inv.] Op de salontafel liggen tijdschriften. — Sobre la mesita hay revistas.
• [perf.] Ik heb de salontafel afgeruimd. — He recogido la mesa de centro.
• [geb.] Voeten van de salontafel! — ¡Pies fuera de la mesita!
• [bijzin] We zoeken een salontafel die bij de bank past. — Buscamos una mesa de centro que pegue con el sofá.', updated_at = datetime('now')
WHERE word_es_id = 106 AND lang_code = 'nl_NL';

-- 107: la estanteria -> de boekenkast
UPDATE words_lang SET notes = '• [can.] De boekenkast staat vol romans. — La estantería está llena de novelas.
• [inv.] In de boekenkast staan ook fotoalbums. — En la estantería también hay álbumes de fotos.
• [perf.] Ik heb de boekenkast in elkaar gezet. — He montado la estantería.
• [geb.] Zet het boek terug in de boekenkast! — ¡Devuelve el libro a la estantería!
• [bijzin] De boekenkast is zo vol dat er niets meer bij past. — La estantería está tan llena que ya no cabe nada.', updated_at = datetime('now')
WHERE word_es_id = 107 AND lang_code = 'nl_NL';

-- 108: el aparador -> het dressoir
UPDATE words_lang SET notes = '• [can.] Het servies staat in het dressoir. — La vajilla está en el aparador.
• [inv.] Op het dressoir staan familiefoto''s. — Sobre el aparador hay fotos de familia.
• [perf.] Ik heb de sleutels op het dressoir gelegd. — He dejado las llaves sobre el aparador.
• [vraag] Liggen de sleutels op het dressoir? — ¿Están las llaves en el aparador?
• [bijzin] Het dressoir is een meubel dat je bij de deur ziet staan. — El aparador es un mueble que ves junto a la puerta.', updated_at = datetime('now')
WHERE word_es_id = 108 AND lang_code = 'nl_NL';

-- 109: el control remoto -> de afstandsbediening
UPDATE words_lang SET notes = '• [can.] De afstandsbediening ligt op de bank. — El mando está en el sofá.
• [inv.] Alweer is de afstandsbediening kwijt! — ¡Otra vez se ha perdido el mando!
• [perf.] Ik heb de batterijen van de afstandsbediening vervangen. — He cambiado las pilas del mando.
• [geb.] Geef de afstandsbediening eens door! — ¡Pásame el mando!
• [bijzin] We zoeken altijd, omdat de afstandsbediening tussen de kussens valt. — Siempre buscamos porque el mando se cae entre los cojines.', updated_at = datetime('now')
WHERE word_es_id = 109 AND lang_code = 'nl_NL';

-- 110: el equipo de musica -> de stereo-installatie
UPDATE words_lang SET notes = '• [can.] De stereo-installatie staat in de woonkamer. — El equipo de música está en el salón.
• [inv.] Op feestjes zet hij de stereo-installatie keihard. — En las fiestas pone el equipo a todo volumen.
• [perf.] Hij heeft de stereo-installatie aangesloten. — Ha conectado el equipo de música.
• [geb.] Zet de stereo-installatie wat zachter! — ¡Baja un poco el equipo de música!
• [bijzin] Tegenwoordig zegt bijna iedereen "speaker", hoewel oma stereo-installatie zegt. — Hoy casi todos dicen "speaker", aunque la abuela dice equipo de música.', updated_at = datetime('now')
WHERE word_es_id = 110 AND lang_code = 'nl_NL';

-- 111: los altavoces -> de luidsprekers
UPDATE words_lang SET notes = '• [can.] De luidsprekers kraken een beetje. — Los altavoces chisporrotean un poco.
• [inv.] Via bluetooth verbind je je telefoon met de luidsprekers. — Por bluetooth conectas el móvil a los altavoces.
• [perf.] Ik heb nieuwe luidsprekers aangesloten. — He conectado altavoces nuevos.
• [vraag] Doen de luidsprekers het weer? — ¿Ya funcionan otra vez los altavoces?
• [bijzin] In de spreektaal zegt bijna iedereen "speakers", omdat het korter is. — Coloquialmente casi todos dicen "speakers" porque es más corto.', updated_at = datetime('now')
WHERE word_es_id = 111 AND lang_code = 'nl_NL';

-- 112: el espejo -> de spiegel
UPDATE words_lang SET notes = '• [can.] Ik kijk in de spiegel. — Me miro al espejo.
• [inv.] In de gang hangt een grote spiegel. — En el pasillo hay un espejo grande.
• [perf.] De spiegel is na het douchen beslagen. — El espejo se ha empañado tras la ducha.
• [vraag] Kun jij die spiegel recht hangen? — ¿Puedes colgar recto ese espejo?
• [uitdr.] Kijk eerst in de spiegel! — ¡Mírate primero al espejo! (antes de criticar; como en español)', updated_at = datetime('now')
WHERE word_es_id = 112 AND lang_code = 'nl_NL';

-- 113: el florero -> de vaas
UPDATE words_lang SET notes = '• [can.] De tulpen staan in de vaas. — Los tulipanes están en el florero.
• [inv.] Elke week zet ik verse bloemen in de vaas. — Cada semana pongo flores frescas en el jarrón.
• [perf.] De vaas is omgevallen en gebroken. — El jarrón se ha caído y se ha roto.
• [geb.] Doe even vers water in de vaas. — Cambia el agua del jarrón.
• [bijzin] Ik koop tulpen, omdat de vaas leeg staat. — Compro tulipanes porque el jarrón está vacío.', updated_at = datetime('now')
WHERE word_es_id = 113 AND lang_code = 'nl_NL';

-- 114: las velas -> de kaarsen
UPDATE words_lang SET notes = '• [can.] We steken kaarsen aan. — Encendemos velas.
• [inv.] ''s Avonds branden er kaarsen op tafel. — Por la noche arden velas en la mesa.
• [perf.] Ik heb de kaarsen uitgeblazen. — He apagado las velas (soplando).
• [geb.] Blaas de kaarsen uit voor je gaat slapen! — ¡Apaga las velas antes de dormir!
• [bijzin] Nederlanders steken kaarsen aan, omdat dat gezellig is. — Los holandeses encienden velas porque da ambiente "gezellig".', updated_at = datetime('now')
WHERE word_es_id = 114 AND lang_code = 'nl_NL';

-- 115: el candelabro -> de kandelaar
UPDATE words_lang SET notes = '• [can.] De kandelaar staat op tafel. — El candelabro está en la mesa.
• [inv.] Bij het kerstdiner staat de zilveren kandelaar op tafel. — En la cena de Navidad el candelabro de plata está en la mesa.
• [perf.] Ze heeft de kandelaar gepoetst. — Ha limpiado el candelabro.
• [vraag] Van wie was deze oude kandelaar? — ¿De quién era este candelabro antiguo?
• [bijzin] De kandelaar is een erfstuk dat van oma komt. — El candelabro es una herencia que viene de la abuela.', updated_at = datetime('now')
WHERE word_es_id = 115 AND lang_code = 'nl_NL';

-- 116: la planta -> de plant
UPDATE words_lang SET notes = '• [can.] Ik geef de planten water. — Riego las plantas.
• [inv.] Voor het raam staan veel planten. — Delante de la ventana hay muchas plantas.
• [perf.] De plant is doodgegaan. — La planta se ha muerto.
• [geb.] Vergeet de planten niet water te geven! — ¡No olvides regar las plantas!
• [bijzin] Nederlanders zetten planten voor het raam, zodat het gezellig oogt. — Los holandeses ponen plantas en la ventana para que se vea acogedor.', updated_at = datetime('now')
WHERE word_es_id = 116 AND lang_code = 'nl_NL';

-- 117: la lampara de pie -> de staande lamp
UPDATE words_lang SET notes = '• [can.] De staande lamp staat naast de bank. — La lámpara de pie está junto al sofá.
• [inv.] Naast de leesstoel staat een staande lamp. — Junto al sillón de lectura hay una lámpara de pie.
• [perf.] We hebben een staande lamp voor de leeshoek gekocht. — Hemos comprado una lámpara de pie para el rincón de lectura.
• [geb.] Doe de staande lamp aan, dat leest fijner. — Enciende la lámpara de pie, se lee mejor.
• [bijzin] Ik wil een staande lamp die warm licht geeft. — Quiero una lámpara de pie que dé luz cálida.', updated_at = datetime('now')
WHERE word_es_id = 117 AND lang_code = 'nl_NL';

-- 118: la lampara de techo -> de plafondlamp
UPDATE words_lang SET notes = '• [can.] De plafondlamp geeft veel licht. — La lámpara de techo da mucha luz.
• [inv.] In de keuken hangt een plafondlamp. — En la cocina hay una lámpara de techo.
• [perf.] We hebben de plafondlamp opgehangen. — Hemos colgado la lámpara de techo.
• [vraag] Kun je me helpen met de plafondlamp? — ¿Me ayudas con la lámpara de techo?
• [bijzin] De plafondlamp knippert, omdat er iets los zit. — La lámpara del techo parpadea porque algo está suelto.', updated_at = datetime('now')
WHERE word_es_id = 118 AND lang_code = 'nl_NL';

-- 119: el cojin -> het kussen
UPDATE words_lang SET notes = '• [can.] Er liggen vier kussens op de bank. — Hay cuatro cojines en el sofá.
• [inv.] Voor mijn rug pak ik een kussen. — Para la espalda cojo un cojín.
• [perf.] Ik heb de kussens opgeschud. — He ahuecado los cojines.
• [geb.] Gooi dat kussen eens hierheen! — ¡Lánzame ese cojín!
• [bijzin] Let op dat "het kussen" zowel cojín als almohada betekent. — Ojo: "het kussen" significa cojín y también almohada.', updated_at = datetime('now')
WHERE word_es_id = 119 AND lang_code = 'nl_NL';

-- 120: la ventana -> het raam
UPDATE words_lang SET notes = '• [can.] Ik doe het raam open. — Abro la ventana.
• [inv.] Door het raam kijk ik naar de regen. — Por la ventana miro la lluvia.
• [perf.] Ik heb de ramen gelapt. — He limpiado los cristales.
• [geb.] Doe het raam dicht, het regent in! — ¡Cierra la ventana, entra la lluvia!
• [bijzin] Ik zet het raam open, omdat het hier warm is. — Abro la ventana porque aquí hace calor.', updated_at = datetime('now')
WHERE word_es_id = 120 AND lang_code = 'nl_NL';

-- 121: el marco de la ventana -> het raamkozijn
UPDATE words_lang SET notes = '• [can.] De kat zit op het raamkozijn. — El gato está en el marco de la ventana.
• [inv.] Op het raamkozijn staan plantjes. — En el alféizar hay plantitas.
• [perf.] We hebben het raamkozijn geschilderd. — Hemos pintado el marco de la ventana.
• [vraag] Is het raamkozijn van hout of kunststof? — ¿El marco es de madera o de PVC?
• [bijzin] Het raamkozijn is rot, dus het moet vervangen worden. — El marco está podrido, así que hay que cambiarlo.', updated_at = datetime('now')
WHERE word_es_id = 121 AND lang_code = 'nl_NL';

-- 122: la repisa -> de plank
UPDATE words_lang SET notes = '• [can.] De foto staat op de plank. — La foto está en la repisa.
• [inv.] Op de bovenste plank staan de kookboeken. — En la balda de arriba están los libros de cocina.
• [perf.] Ik heb een plank aan de muur gehangen. — He colgado una balda en la pared.
• [vraag] Hangt die plank recht? — ¿Está recta esa balda?
• [uitdr.] Hij slaat de plank mis. — Se equivoca de lleno (frase hecha: falla la tabla).', updated_at = datetime('now')
WHERE word_es_id = 122 AND lang_code = 'nl_NL';

-- 123: la calefaccion -> de verwarming
UPDATE words_lang SET notes = '• [can.] Ik zet de verwarming hoger. — Subo la calefacción.
• [inv.] In oktober gaat in Nederland de verwarming pas aan. — En Países Bajos la calefacción no se enciende hasta octubre.
• [perf.] De monteur heeft de verwarming gerepareerd. — El técnico ha arreglado la calefacción.
• [geb.] Zet de verwarming wat lager, dat scheelt geld! — ¡Baja un poco la calefacción, se ahorra dinero!
• [bijzin] Ik heb het koud, omdat de verwarming het niet doet. — Tengo frío porque la calefacción no funciona.', updated_at = datetime('now')
WHERE word_es_id = 123 AND lang_code = 'nl_NL';

-- 124: el radiador -> de radiator
UPDATE words_lang SET notes = '• [can.] De radiator wordt warm. — El radiador se calienta.
• [inv.] Op de radiator drogen mijn handschoenen. — Sobre el radiador se secan mis guantes.
• [perf.] Ik heb de radiator ontlucht. — He purgado el radiador.
• [vraag] Wordt de radiator in de badkamer warm? — ¿El radiador del baño calienta?
• [bijzin] De radiator tikt, omdat er lucht in zit. — El radiador hace ruiditos porque tiene aire dentro.', updated_at = datetime('now')
WHERE word_es_id = 124 AND lang_code = 'nl_NL';

-- 125: el aire acondicionado -> de airconditioning
UPDATE words_lang SET notes = '• [can.] De airconditioning staat aan. — El aire acondicionado está puesto.
• [inv.] Bij een hittegolf wil iedereen airconditioning. — En una ola de calor todo el mundo quiere aire acondicionado.
• [perf.] We hebben airconditioning laten installeren. — Hemos hecho instalar aire acondicionado.
• [geb.] Zet de airco aan, het is bloedheet! — ¡Pon el aire, hace un calor horrible!
• [bijzin] Weinig huizen hebben airconditioning, omdat de zomers kort zijn. — Pocas casas tienen aire porque los veranos son cortos ("airco" en el habla diaria).', updated_at = datetime('now')
WHERE word_es_id = 125 AND lang_code = 'nl_NL';

-- 126: el ventilador -> de ventilator
UPDATE words_lang SET notes = '• [can.] De ventilator staat op de hoogste stand. — El ventilador está al máximo.
• [inv.] Bij warm weer zet ik de ventilator aan. — Con calor enciendo el ventilador.
• [perf.] Ik heb een ventilator voor de slaapkamer gekocht. — He comprado un ventilador para el dormitorio.
• [geb.] Zet de ventilator aan, dat koelt af! — ¡Enciende el ventilador, refresca!
• [bijzin] De ventilators zijn uitverkocht, omdat er een hittegolf is. — Los ventiladores están agotados porque hay ola de calor.', updated_at = datetime('now')
WHERE word_es_id = 126 AND lang_code = 'nl_NL';

-- 127: los libros -> de boeken
UPDATE words_lang SET notes = '• [can.] Ik lees elke avond een boek. — Leo un libro cada noche.
• [inv.] Bij de bibliotheek leen ik boeken. — En la biblioteca tomo libros prestados.
• [perf.] Ik heb dit boek in één weekend uitgelezen. — Me he terminado este libro en un fin de semana.
• [geb.] Breng de boeken terug naar de bieb! — ¡Devuelve los libros a la biblio!
• [uitdr.] Dat is voor mij een gesloten boek. — Eso para mí es un misterio (frase hecha: un libro cerrado).', updated_at = datetime('now')
WHERE word_es_id = 127 AND lang_code = 'nl_NL';

-- 128: la chimenea -> de open haard
UPDATE words_lang SET notes = '• [can.] De open haard brandt. — La chimenea está encendida.
• [inv.] In de winter steken we de open haard aan. — En invierno encendemos la chimenea.
• [perf.] We hebben de open haard laten vegen. — Hemos hecho deshollinar la chimenea.
• [vraag] Mag je hier nog een open haard stoken? — ¿Aquí todavía se puede encender chimenea?
• [bijzin] Bij de open haard zitten is zo gezellig dat iedereen blijft plakken. — Junto a la chimenea se está tan a gusto que todos se quedan.', updated_at = datetime('now')
WHERE word_es_id = 128 AND lang_code = 'nl_NL';

-- 129: regalar algo -> iets weggeven
UPDATE words_lang SET notes = '• [can.] Ik geef deze jas weg. — Regalo este abrigo.
• [inv.] Op Marktplaats geven mensen spullen gratis weg. — En Marktplaats la gente regala cosas gratis.
• [perf.] Ik heb mijn oude bank weggegeven. — He regalado mi sofá viejo.
• [vraag] Waarom zou je iets weggeven wat nog goed is? — ¿Por qué regalar algo que aún está bien?
• [bijzin] Hij geeft alles weg, omdat hij gaat verhuizen. — Lo regala todo porque se muda.', updated_at = datetime('now')
WHERE word_es_id = 129 AND lang_code = 'nl_NL';

-- 130: no siempre -> niet altijd
UPDATE words_lang SET notes = '• [can.] Het is niet altijd makkelijk. — No siempre es fácil.
• [inv.] Helaas is de trein niet altijd op tijd. — Por desgracia el tren no siempre es puntual.
• [perf.] Ik heb niet altijd zin gehad om te koken. — No siempre he tenido ganas de cocinar.
• [vraag] Ben je niet altijd thuis op vrijdag? — ¿No estás siempre en casa los viernes?
• [bijzin] Ik zeg niets, omdat eerlijk zijn niet altijd handig is. — No digo nada porque ser sincero no siempre conviene.', updated_at = datetime('now')
WHERE word_es_id = 130 AND lang_code = 'nl_NL';

-- 131: una buena idea -> een goed idee
UPDATE words_lang SET notes = '• [can.] Dat is een goed idee. — Esa es una buena idea.
• [inv.] Misschien is wachten een goed idee. — Quizá esperar sea una buena idea.
• [perf.] Dat is altijd een goed idee geweest. — Eso siempre ha sido una buena idea.
• [vraag] Zullen we pizza bestellen? Goed idee! — ¿Pedimos pizza? ¡Buena idea!
• [bijzin] Ik denk niet dat dat een goed idee is. — No creo que eso sea una buena idea.', updated_at = datetime('now')
WHERE word_es_id = 131 AND lang_code = 'nl_NL';

-- 132: el refugiado -> de vluchteling
UPDATE words_lang SET notes = '• [can.] De vluchteling leert Nederlands. — El refugiado aprende neerlandés.
• [inv.] In onze buurt wonen vluchtelingen. — En nuestro barrio viven refugiados.
• [perf.] De gemeente heeft woningen voor vluchtelingen geregeld. — El ayuntamiento ha gestionado viviendas para refugiados.
• [vraag] Hoeveel vluchtelingen vangt de stad op? — ¿A cuántos refugiados acoge la ciudad?
• [bijzin] Veel vluchtelingen vertellen dat de taal het moeilijkst is. — Muchos refugiados cuentan que el idioma es lo más difícil.', updated_at = datetime('now')
WHERE word_es_id = 132 AND lang_code = 'nl_NL';

-- 133: la refugiada -> de vluchteling
UPDATE words_lang SET notes = '• [can.] Zij is een vluchteling uit Syrië. — Ella es una refugiada de Siria.
• [inv.] Sinds kort woont de vluchteling en haar gezin hiernaast. — Desde hace poco la refugiada y su familia viven al lado.
• [perf.] Ze is drie jaar geleden als vluchteling gekomen. — Llegó como refugiada hace tres años.
• [vraag] Krijgt de vluchteling hulp bij de taal? — ¿La refugiada recibe ayuda con el idioma?
• [bijzin] Onthoud dat "vluchteling" hetzelfde is voor mannen en vrouwen. — Recuerda que "vluchteling" es igual para hombres y mujeres.', updated_at = datetime('now')
WHERE word_es_id = 133 AND lang_code = 'nl_NL';

-- 134: de donde? -> waarvandaan?
UPDATE words_lang SET notes = '• [can.] Waarvandaan kom je? — ¿De dónde vienes?
• [inv.] Waarvandaan vertrekt de trein naar Utrecht? — ¿De dónde sale el tren a Utrecht?
• [perf.] Waarvandaan ben je gisteren vertrokken? — ¿De dónde saliste ayer?
• [vraag] Waarvandaan ken jij hem? — ¿De qué lo conoces?
• [bijzin] Vertel eens waar je vandaan komt. — Cuéntame de dónde vienes (nota: separado "waar...vandaan" es lo más común).', updated_at = datetime('now')
WHERE word_es_id = 134 AND lang_code = 'nl_NL';

-- 135: que se yo -> weet ik veel
UPDATE words_lang SET notes = '• [can.] Weet ik veel! — ¡Y yo qué sé!
• [inv.] Hoe laat hij komt? Weet ik veel! — ¿Que a qué hora viene? ¡Yo qué sé!
• [perf.] Waarom het kapot is gegaan? Weet ik veel! — ¿Que por qué se ha roto? ¡Ni idea!
• [vraag] Waar is de sleutel? Weet ik veel... — ¿Dónde está la llave? Qué sé yo...
• [bijzin] Hij vroeg iets, maar weet ik veel wat hij bedoelde. — Preguntó algo, pero yo qué sé qué quería decir (informal; puede sonar borde).', updated_at = datetime('now')
WHERE word_es_id = 135 AND lang_code = 'nl_NL';

-- 136: en absoluto -> helemaal niet
UPDATE words_lang SET notes = '• [can.] Ik ben helemaal niet moe. — No estoy cansado en absoluto.
• [inv.] Gek genoeg vond ik het helemaal niet erg. — Curiosamente no me importó en absoluto.
• [perf.] Dat had ik helemaal niet verwacht. — Eso no me lo esperaba en absoluto.
• [vraag] Vind je het erg? Nee, helemaal niet! — ¿Te importa? ¡No, en absoluto!
• [bijzin] Hij zegt dat het helemaal niet nodig was. — Dice que no era necesario en absoluto.', updated_at = datetime('now')
WHERE word_es_id = 136 AND lang_code = 'nl_NL';

-- 137: parecerse a -> lijken op
UPDATE words_lang SET notes = '• [can.] Hij lijkt op zijn vader. — Se parece a su padre.
• [inv.] Qua karakter lijkt ze op haar moeder. — De carácter se parece a su madre.
• [perf.] Hij is steeds meer op zijn opa gaan lijken. — Cada vez se parece más a su abuelo.
• [vraag] Op wie lijk jij het meest? — ¿A quién te pareces más?
• [uitdr.] Dat lijkt nergens op! — ¡Eso es un desastre! (frase hecha: no se parece a nada)', updated_at = datetime('now')
WHERE word_es_id = 137 AND lang_code = 'nl_NL';

-- 138: el jersey -> de trui
UPDATE words_lang SET notes = '• [can.] Ik draag een warme trui. — Llevo un jersey calentito.
• [inv.] In de winter draag ik altijd truien. — En invierno siempre llevo jerséis.
• [perf.] Ik heb een nieuwe trui gekocht. — He comprado un jersey nuevo.
• [geb.] Trek een trui aan, het is fris! — ¡Ponte un jersey, hace fresco!
• [bijzin] Ik zoek een foute kersttrui, omdat we een kerstborrel hebben. — Busco un jersey navideño hortera porque tenemos fiesta de Navidad.', updated_at = datetime('now')
WHERE word_es_id = 138 AND lang_code = 'nl_NL';

-- 139: el hoverboard -> het hoverboard
UPDATE words_lang SET notes = '• [can.] De buurjongen rijdt op zijn hoverboard. — El chico del vecino va en su hoverboard.
• [inv.] Door de straat rijdt hij op zijn hoverboard. — Por la calle va en su hoverboard.
• [perf.] Hij is van zijn hoverboard gevallen. — Se ha caído del hoverboard.
• [vraag] Is je hoverboard al opgeladen? — ¿Ya está cargado tu hoverboard?
• [bijzin] Hij is blij, omdat hij een hoverboard voor zijn verjaardag kreeg. — Está contento porque le regalaron un hoverboard por su cumpleaños.', updated_at = datetime('now')
WHERE word_es_id = 139 AND lang_code = 'nl_NL';

-- 140: dejame en paz -> rot op
UPDATE words_lang SET notes = '• [can.] Rot op! — ¡Lárgate! (muy grosero)
• [inv.] Rot toch op met je smoesjes! — ¡Déjame en paz con tus excusas!
• [perf.] Hij is eindelijk opgerot. — Por fin se ha largado (vulgar).
• [vraag] Zei hij echt "rot op" tegen de leraar? — ¿De verdad le dijo "rot op" al profesor?
• [uitdr.] Rot op! Meen je dat? — ¡Venga ya! ¿En serio? (entre amigos expresa incredulidad)', updated_at = datetime('now')
WHERE word_es_id = 140 AND lang_code = 'nl_NL';

-- 141: han entrado a robar -> er is ingebroken
UPDATE words_lang SET notes = '• [can.] Er is bij de buren ingebroken. — Han entrado a robar en casa de los vecinos.
• [inv.] Vannacht is er in de sportschool ingebroken. — Anoche entraron a robar en el gimnasio.
• [perf.] Er is al twee keer ingebroken in die straat. — Ya han entrado a robar dos veces en esa calle.
• [vraag] Is er bij jullie weleens ingebroken? — ¿Alguna vez os han entrado a robar?
• [bijzin] Ik bel de politie, omdat er is ingebroken. — Llamo a la policía porque han entrado a robar (pasivo impersonal: siempre "is", sin sujeto).', updated_at = datetime('now')
WHERE word_es_id = 141 AND lang_code = 'nl_NL';

-- 142: han robado -> ze hebben gejat
UPDATE words_lang SET notes = '• [can.] Ze hebben mijn fiets gejat! — ¡Me han robado la bici!
• [inv.] Op de markt hebben ze mijn portemonnee gejat. — En el mercado me han robado la cartera.
• [perf.] Ze hebben alles uit de schuur gejat. — Han robado todo del cobertizo.
• [vraag] Hebben ze echt je telefoon gejat? — ¿En serio te han robado el móvil?
• [bijzin] Ik ben boos, omdat ze mijn fiets hebben gejat. — Estoy enfadado porque me han robado la bici ("jatten" es coloquial; formal: stelen).', updated_at = datetime('now')
WHERE word_es_id = 142 AND lang_code = 'nl_NL';

-- 143: lo regale -> heb ik weggegeven
UPDATE words_lang SET notes = '• [can.] Die oude bank heb ik weggegeven. — Ese sofá viejo lo regalé.
• [inv.] Gisteren heb ik mijn oude telefoon weggegeven. — Ayer regalé mi móvil viejo.
• [perf.] De dubbele boeken heb ik allemaal weggegeven. — Los libros repetidos los regalé todos.
• [vraag] Waar is je jas? Heb je die weggegeven? — ¿Dónde está tu abrigo? ¿Lo has regalado?
• [bijzin] Ze vroeg waarom ik de stoel heb weggegeven. — Preguntó por qué regalé la silla.', updated_at = datetime('now')
WHERE word_es_id = 143 AND lang_code = 'nl_NL';

-- 144: por caridad -> uit liefdadigheid
UPDATE words_lang SET notes = '• [can.] Ze doet dit werk uit liefdadigheid. — Hace este trabajo por caridad.
• [inv.] Uit liefdadigheid gaf hij zijn oude spullen weg. — Por caridad regaló sus cosas viejas.
• [perf.] Hij heeft het geld uit liefdadigheid gegeven. — Dio el dinero por caridad.
• [vraag] Doe je dit uit liefdadigheid of voor de aandacht? — ¿Lo haces por caridad o por llamar la atención?
• [bijzin] Doe het niet uit liefdadigheid, maar omdat je het wilt. — No lo hagas por caridad, sino porque quieres.', updated_at = datetime('now')
WHERE word_es_id = 144 AND lang_code = 'nl_NL';

-- 145: la caridad -> de liefdadigheid
UPDATE words_lang SET notes = '• [can.] De opbrengst gaat naar liefdadigheid. — La recaudación va a la beneficencia.
• [inv.] Elk jaar geeft hij geld aan liefdadigheid. — Cada año da dinero a obras benéficas.
• [perf.] We hebben een liefdadigheidsactie georganiseerd. — Hemos organizado una acción benéfica.
• [vraag] Geef jij weleens aan liefdadigheid? — ¿Tú das alguna vez a la beneficencia?
• [bijzin] De voedselbank is een vorm van liefdadigheid die veel mensen helpt. — El banco de alimentos es una forma de caridad que ayuda a mucha gente.', updated_at = datetime('now')
WHERE word_es_id = 145 AND lang_code = 'nl_NL';

-- 146: no tienes hambre? -> heb je geen honger?
UPDATE words_lang SET notes = '• [can.] Heb je geen honger? — ¿No tienes hambre?
• [inv.] Na zo''n lange dag heb je vast honger. — Después de un día tan largo seguro que tienes hambre.
• [perf.] Heb je vandaag nog niets gegeten? — ¿Hoy no has comido nada aún?
• [vraag] Heb je geen honger? We kunnen wat bestellen. — ¿No tienes hambre? Podemos pedir algo.
• [bijzin] Ze vraagt of je geen honger hebt. — Pregunta si no tienes hambre (en la subordinada el verbo va al final).', updated_at = datetime('now')
WHERE word_es_id = 146 AND lang_code = 'nl_NL';

-- 147: en serio, deberias comer algo. -> je moet echt even wat eten
UPDATE words_lang SET notes = '• [can.] Je moet echt even wat eten. — En serio, deberías comer algo.
• [inv.] Voor het tentamen moet je echt even wat eten. — Antes del examen de verdad tienes que comer algo.
• [perf.] Je hebt de hele dag nog niets gegeten! — ¡No has comido nada en todo el día!
• [vraag] Zullen we even wat eten? — ¿Comemos algo?
• [bijzin] Ik zeg dat je echt even wat moet eten. — Te digo que de verdad tienes que comer algo ("even" y "wat" suavizan; puro neerlandés hablado).', updated_at = datetime('now')
WHERE word_es_id = 147 AND lang_code = 'nl_NL';

-- 148: de vuelta -> terug
UPDATE words_lang SET notes = '• [can.] Ik ben om zes uur terug. — Estoy de vuelta a las seis.
• [inv.] Morgen kom ik terug uit Spanje. — Mañana vuelvo de España.
• [perf.] Ik heb de boeken teruggebracht. — He devuelto los libros.
• [vraag] Wanneer kom je terug? — ¿Cuándo vuelves?
• [uitdr.] Ik kom er nog op terug. — Ya volveré sobre el tema (frase hecha).', updated_at = datetime('now')
WHERE word_es_id = 148 AND lang_code = 'nl_NL';

-- 149: superalo -> zet je er overheen
UPDATE words_lang SET notes = '• [can.] Zet je er overheen. — Supéralo.
• [inv.] Na al die maanden moet je je er overheen zetten. — Después de tantos meses tienes que superarlo.
• [perf.] Ze heeft zich er eindelijk overheen gezet. — Por fin lo ha superado.
• [geb.] Kom op, zet je er overheen! — ¡Venga, supéralo!
• [bijzin] Ik weet dat het balen is, maar je moet je er overheen zetten. — Sé que es un rollo, pero tienes que superarlo.', updated_at = datetime('now')
WHERE word_es_id = 149 AND lang_code = 'nl_NL';

-- 150: acaban de llegar -> ze zijn hier pas nieuw
UPDATE words_lang SET notes = '• [can.] Ze zijn hier pas nieuw. — Acaban de llegar (son nuevos aquí).
• [inv.] Sinds vorige maand zijn ze hier pas nieuw. — Desde el mes pasado son nuevos aquí.
• [perf.] Ze zijn net verhuisd. — Se acaban de mudar.
• [geb.] Zeg eens gedag, ze zijn hier pas nieuw! — ¡Salúdalos, acaban de llegar!
• [bijzin] Ze kennen de buurt niet, omdat ze hier pas nieuw zijn. — No conocen el barrio porque acaban de llegar.', updated_at = datetime('now')
WHERE word_es_id = 150 AND lang_code = 'nl_NL';

-- 151: no tienen mucho -> hebben niet zoveel
UPDATE words_lang SET notes = '• [can.] Ze hebben niet zoveel. — No tienen mucho.
• [inv.] Vroeger hadden wij ook niet zoveel. — Antes nosotros tampoco teníamos mucho.
• [perf.] Ze hebben nooit zoveel gehad. — Nunca han tenido mucho.
• [vraag] Heb je vandaag niet zoveel tijd? — ¿Hoy no tienes mucho tiempo?
• [bijzin] Ze delen alles, hoewel ze niet zoveel hebben. — Lo comparten todo aunque no tienen mucho.', updated_at = datetime('now')
WHERE word_es_id = 151 AND lang_code = 'nl_NL';

-- 152: prescindir de -> kunnen missen
UPDATE words_lang SET notes = '• [can.] Ik kan mijn fiets niet missen. — No puedo prescindir de mi bici.
• [inv.] In de vakantie kan ik mijn laptop prima missen. — En vacaciones puedo prescindir perfectamente del portátil.
• [perf.] Die stoel hebben we nooit kunnen missen. — De esa silla nunca hemos podido prescindir.
• [vraag] Kun je die stoel missen? — ¿Puedes prescindir de esa silla? (¿me la das?)
• [bijzin] Geef alleen weg wat je echt kunt missen. — Regala solo aquello de lo que de verdad puedas prescindir.', updated_at = datetime('now')
WHERE word_es_id = 152 AND lang_code = 'nl_NL';

-- 153: algunas cosas -> iets
UPDATE words_lang SET notes = '• [can.] Ik wil iets drinken. — Quiero beber algo.
• [inv.] Voor morgen moet ik nog iets regelen. — Para mañana aún tengo que arreglar algo.
• [perf.] Heb je iets leuks gekocht? — ¿Has comprado algo bonito? (adjetivo con -s tras "iets")
• [vraag] Zoek je iets speciaals? — ¿Buscas algo en especial?
• [uitdr.] Dat is niet niks! — ¡No es poca cosa! (frase hecha con su contrario "niks")', updated_at = datetime('now')
WHERE word_es_id = 153 AND lang_code = 'nl_NL';

-- 154: consultado -> overlegd
UPDATE words_lang SET notes = '• [can.] Ik overleg alles met mijn vrouw. — Lo consulto todo con mi mujer.
• [inv.] Voor zo''n beslissing overleg je eerst. — Para una decisión así primero lo consultas.
• [perf.] We hebben overlegd en we doen het. — Lo hemos consultado y lo hacemos.
• [vraag] Heb je met je vrouw overlegd? — ¿Lo has consultado con tu mujer?
• [bijzin] Ze is boos, omdat hij de bank heeft weggegeven zonder te overleggen. — Está enfadada porque regaló el sofá sin consultarlo.', updated_at = datetime('now')
WHERE word_es_id = 154 AND lang_code = 'nl_NL';

-- 155: con buena intencion -> bedoelt het goed
UPDATE words_lang SET notes = '• [can.] Hij bedoelt het goed. — Tiene buena intención.
• [inv.] Met al dat eten bedoelt oma het goed. — Con tanta comida, la abuela lo hace con buena intención.
• [perf.] Ze heeft het altijd goed bedoeld. — Siempre lo ha hecho con buena intención.
• [vraag] Bedoelt hij het wel goed? — ¿Seguro que tiene buena intención?
• [bijzin] Hij bedoelt het goed, maar het komt verkeerd over. — Tiene buena intención, pero sienta mal.', updated_at = datetime('now')
WHERE word_es_id = 155 AND lang_code = 'nl_NL';

-- 156: ya nunca -> nooit meer
UPDATE words_lang SET notes = '• [can.] Ik rook nooit meer. — Ya nunca fumo.
• [inv.] Sinds de verhuizing zien we elkaar nooit meer. — Desde la mudanza ya nunca nos vemos.
• [perf.] Hij is nooit meer teruggekomen. — Nunca más volvió.
• [geb.] Doe dat nooit meer! — ¡No lo vuelvas a hacer nunca!
• [bijzin] Ze zegt dat ze nooit meer met hem praat. — Dice que ya nunca hablará con él.', updated_at = datetime('now')
WHERE word_es_id = 156 AND lang_code = 'nl_NL';

-- 157: muchisimo -> hartstikke vaak
UPDATE words_lang SET notes = '• [can.] Ik gebruik de fiets hartstikke vaak. — Uso la bici muchísimo.
• [inv.] Op zaterdag gaan we hartstikke vaak naar de markt. — Los sábados vamos muchísimo al mercado.
• [perf.] Dat heb ik hartstikke vaak gedaan. — Eso lo he hecho muchísimas veces.
• [vraag] Kom je hier hartstikke vaak? — ¿Vienes por aquí muy a menudo?
• [uitdr.] Hartstikke bedankt! — ¡Muchísimas gracias! ("hartstikke" intensifica todo: hartstikke leuk, hartstikke duur)', updated_at = datetime('now')
WHERE word_es_id = 157 AND lang_code = 'nl_NL';

-- 158: echar de menos -> missen
UPDATE words_lang SET notes = '• [can.] Ik mis mijn familie. — Echo de menos a mi familia.
• [inv.] In de winter mis ik de Spaanse zon. — En invierno echo de menos el sol español.
• [perf.] Ik heb je gemist! — ¡Te he echado de menos!
• [vraag] Mis je het strand? — ¿Echas de menos la playa?
• [bijzin] We gaan je missen, wanneer je weg bent. — Te echaremos de menos cuando no estés.', updated_at = datetime('now')
WHERE word_es_id = 158 AND lang_code = 'nl_NL';
