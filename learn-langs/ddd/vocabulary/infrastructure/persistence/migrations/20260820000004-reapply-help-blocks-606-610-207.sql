-- Learn Languages App - Reaplicacion: 606, 610, rescate 207 y el marcador @@REFLEX@@ de la 603
-- Migration: 20260820000004-reapply-help-blocks-606-610-207.sql
-- Description: la 20260820000002 se registro habiendo sido leida A MEDIO ESCRIBIR: el runner
--   arranco justo mientras se anadian los bloques al fichero, asi que a la BD solo llegaron el
--   600 entero y el 603 CON el marcador @@REFLEX@@ sin sustituir (el REPLACE final aun no
--   estaba en el fichero). Como una migracion registrada no se vuelve a ejecutar, el resto del
--   lote —606, el 🎭 de la 610 y los rescates 🧩 (610) y 🛠️ (207)— se reaplica aqui, con el
--   mismo texto y las mismas emoji-guardas, mas el REPLACE que limpia el marcador de la 603.
--   Leccion operativa: un .sql nuevo se escribe FUERA de la carpeta de migraciones y se mueve
--   ya terminado, para que el runner no pueda leerlo a medias. Ver [[migration-registered-never-reruns]].
--   Solo UPDATE de rules_help. IDEMPOTENTE.

-- ==============================================================================
-- 606 · conjugación de zich ontspannen + por qué «Ontspant u zich» lleva -t
-- ==============================================================================
UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '📐 Imperativo (forma de cortesía con u)',
    '🔤 Conjugación de zich ontspannen (prefijo ont- inseparable; participio SIN ge-):
• presente: ik ontspan me · jij ontspant je (invertido: ontspan jij je?) · u ontspant zich · hij/zij/het ontspant zich · wij ontspannen ons · jullie ontspannen je · zij ontspannen zich. Ojo a la raíz: ontspannen → ontspan, con una sola n.
• imperfecto: ik ontspande me · jij ontspande je · wij ontspanden ons.
• perfecto: ik heb me ontspannen. El participio es ontspannen, IGUAL que el infinitivo y sin ge-, porque ont- es prefijo átono inseparable (como ondertekend, begrepen, verlopen, ontvangen).
• imperativo: Ontspan je! (tuteo) · Ontspant u zich maar (cortesía, el de la tarjeta).
• con te: Ik probeer me te ontspannen.

❓ ¿Por qué «OntspanT u zich» y no «Ontspan u zich»? Porque la forma de cortesía NO es un imperativo. El imperativo neerlandés solo existe para el tuteo, y ahí sí es la raíz pelada: Ontspan je! · Kom! · Wacht!
Con u se usa el PRESENTE de u con el sujeto detrás: es la frase U ontspant zich puesta del revés → Ontspant u zich (maar). Esa -t es la desinencia de u, no del imperativo. Por eso van todas igual: Komt u binnen · Gaat u zitten · Neemt u plaats · Zegt u het maar · Legt u uw vingers op de scanner.
⚠️ Así que «Ontspan u zich maar» mezcla el imperativo de tuteo con el pronombre formal: se oye en habla descuidada o regional, pero no es la forma estándar.
🔍 El contraste que lo deja claro: al invertir, jij PIERDE la -t (jij ontspant je → ontspan jij je?), pero u NUNCA la pierde (u ontspant zich → ontspant u zich?). Si ves una -t delante de u, es presente, no imperativo.
🙏 Y la salida más natural hoy es convertirlo en pregunta: Wilt u zich even ontspannen? / Zou u zich willen ontspannen? — todavía más cortés que la forma con u.

👉 Preposición: zich ontspannen NO tiene preposición fija. Lo que lo acompaña: met (con qué te relajas: Ik ontspan me met muziek) · bij (durante: bij een goed boek) · na (después de: na het werk). Para «descansar DE algo» el verbo es otro: uitrusten VAN het werk.

🧘 También funciona sin reflexivo: hoy se dice mucho Ik wil even ontspannen (quiero relajarme un rato), como el relax inglés. Y transitivo, con objeto: je spieren ontspannen (relajar los músculos).

😌 Familia: ontspannen (adjetivo: relajado) ↔ gespannen (tenso) · de ontspanning (relajación, ocio) ↔ de inspanning (esfuerzo) · de spanning (tensión, y también suspense) · rustig aan doen (tomárselo con calma) · Rustig maar / Doe maar rustig aan (tranquilo).
@@REFLEX@@
📐 Imperativo (forma de cortesía con u)'
)
WHERE id = 606
  AND rules_help LIKE '%📐 Imperativo (forma de cortesía con u)%'
  AND rules_help NOT LIKE '%🔤%';

-- ==============================================================================
-- 610 · contexto de uso + un diálogo donde cae la frase
-- ==============================================================================
UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '📐 Imperativo:',
    '🎭 Un diálogo donde cae la frase (Anna y su hermano Rob, en la cocina de casa):
• Anna: Ik ga vanavond met Tim naar dat feest. — Esta noche voy con Tim a esa fiesta.
• Rob: Met Tim? Die jongen deugt niet, dat weet je toch? — ¿Con Tim? Ese chico no es trigo limpio, ¿no lo sabes?
• Anna: Bemoei je er niet mee! Het is mijn leven. — ¡No te metas! Es mi vida.
• Rob: Ik zeg alleen maar wat ik ervan vind. — Solo digo lo que me parece.
• Anna: Dat hoeft niet. Bemoei je met je eigen zaken. — No hace falta. Métete en tus asuntos.
• Rob: Rustig maar, ik bemoei me er al niet meer mee. — Tranquila, ya no me meto más.
Fíjate en la última línea: al meter al niet meer en medio, el compuesto se parte igual (er … mee) y la preposición se va al final del todo.

🧭 Contexto: con quién sí y con quién no:
• Registro coloquial y FUERTE, casi un corte. Entre hermanos, amigos o pareja pasa sin más; a un jefe, a un vecino o en una ventanilla, no.
• Para decir lo mismo sin cortar: Dat regel ik zelf wel (ya me encargo yo) · Laat mij dit maar doen · Ik red me wel (ya me apaño) · Bedankt, maar ik doe het op mijn manier.
• Para subir el tono: Waar bemoei jij je mee?! (¿y tú quién eres para meterte?) · Hou je erbuiten! (¡mantente al margen!) · Het gaat je niks aan (no es asunto tuyo).
• Y el que se mete: een bemoeial (un metomentodo) · bemoeizuchtig (entrometido) · zich overal mee bemoeien (meterse en todo).
⚠️ No lo confundas con zich bezighouden met (dedicarse a, ocuparse de), que es neutro y no tiene carga negativa: Ik hou me bezig met muziek = me dedico a la música.

📐 Imperativo:'
)
WHERE id = 610
  AND rules_help LIKE '%📐 Imperativo:%'
  AND rules_help NOT LIKE '%🎭%';

-- ==============================================================================
-- RESCATE · bloques de la migración 20260818000001 que nunca llegaron a la BD
-- (se añadieron al fichero después de que el runner ya lo hubiera registrado;
--  un fichero registrado no se vuelve a ejecutar). Copiados TAL CUAL de allí.
-- ==============================================================================

-- 610 · «er ... mee»: preposición fija del verbo y el pronombre adverbial partido
UPDATE words_es SET rules_help = rules_help || '

🧩 ¿Por qué «er … mee» y no «Bemoei je er niet» a secas?
Porque el verbo NO es bemoeien a secas, es zich bemoeien MET. Esa preposición es fija: forma parte del verbo, como en español entrometerse EN. Si la quitas, la frase queda coja: falta decir en qué no te metes.
🧭 Y entonces, ¿por qué «mee» y no «met»?
Porque cuando eso en lo que te metes es una COSA (no una persona), el neerlandés no dice met het / met dat: fusiona la preposición con er/daar/waar y forma una sola palabra, el llamado pronombre adverbial:
• met + het → ermee · met + dat → daarmee · met + wat → waarmee.
• Ojo a la forma: dentro de esos compuestos met se convierte en MEE y tot en TOE. Por eso es ermee, nunca «ermet». Igual: ertoe, daartoe.
⚠️ Aquí está tu segunda pregunta: «Bemoei je ermee niet» está MAL por el ORDEN. En cuanto hay algo en medio (niet, nooit, un adverbio), el compuesto SE PARTE: er va delante, pegado al reflexivo, y la preposición se marcha al final, detrás de la negación.
• Sin nada en medio, va junto: Hij bemoeit zich ermee (él se mete en eso).
• Con negación, partido: Ik bemoei me er niet mee · Bemoei je er niet mee! ← la de la tarjeta.
Este partido no es de este verbo, es de TODOS los que rigen preposición. Fíjate en el patrón er … [niet] … PREPOSICIÓN:
• denken aan → Hij denkt er niet aan (ni se le pasa por la cabeza).
• zin hebben in → We hebben er geen zin in (no nos apetece).
• Het gaat erom dat je het probeert (gaan om) = de lo que se trata es de que lo intentes.
• Het komt er niet van (komen van) = al final no se hace, no llega a pasar.
• Het zit er niet in = no es posible, no da para eso.
👥 Y con personas, sin er, la preposición vuelve a su sitio
• Hij denkt aan haar · perfectum: Hij heeft aan haar gedacht.
• Zij wacht op hem · We zijn blij met jullie · Ze bemoeien zich niet met ons.'
WHERE id = 610 AND COALESCE(rules_help,'') NOT LIKE '%🧩%';

-- 207 · el mapa de «hacer»: doen vs maken vs aandoen vs uitvoeren
UPDATE words_es SET rules_help = rules_help || '

🛠️ El mapa de «hacer» — doen, maken, aandoen y uitvoeren
El español tiene un «hacer» comodín; el neerlandés reparte por QUÉ tipo de hacer es. Los cuatro llevan hebben en perfectum: gedaan · gemaakt · aangedaan · uitgevoerd.
• doen = hacer una ACTIVIDAD o tarea, sin producto que quede. Es el comodín y el de esta tarjeta: Wat doe je? · Ik zal het morgen doen · de afwas doen (fregar) · boodschappen doen (la compra) · de was doen (la colada) · zijn best doen (esforzarse) · examen doen (examinarse) · aan sport doen (hacer deporte).
• maken = hacer algo que RESULTA en un objeto o un producto, y también arreglar: een taart maken · een foto maken · huiswerk maken (¡los deberes se maken, no doen!) · een afspraak maken (concertar una cita) · een fout maken (cometer un error) · ruzie maken (pelearse) · Kun je het maken? (¿puedes arreglarlo?).
• aandoen = NO significa hacer. Es separable y vale para tres cosas: encender (Doe het licht aan), ponerse ropa o calzado (Doe je jas aan) y causarle algo a alguien (iemand pijn aandoen = hacer daño a alguien). Su contrario es uitdoen: Doe het licht uit · Doe je jas uit.
• uitvoeren = EJECUTAR, llevar a cabo. Registro formal, de planes y encargos: een plan uitvoeren · een opdracht uitvoeren · werkzaamheden uitvoeren · een operatie uitvoeren. También interpretar una obra o pieza (uitvoering = actuación, representación). Nadie dice «de afwas uitvoeren».
🧭 La frontera doen / maken en una línea
¿Queda un producto al terminar (tarta, foto, error, cita, deberes)? → maken. ¿Es una actividad que haces y se acaba (fregar, la compra, deporte, un examen)? → doen.
⚠️ Trampas donde el español dice «hacer» y el neerlandés NO usa ni doen ni maken:
• hacer una pregunta → een vraag STELLEN (nunca doen/maken).
• hacer la cama → het bed OPMAKEN · hacer la comida → eten KOKEN of KLAARMAKEN.
• hacer una foto → een foto maken o NEMEN, las dos valen.
• hacer daño → pijn DOEN si duele (Het doet pijn, Doet het pijn?) pero iemand pijn AANDOEN si se lo haces a alguien.
• hacer como si → doen ALSOF (Hij doet alsof hij slaapt).
🌀 Dos usos de doen que no son «hacer» y te van a salir mucho
• Echar o meter algo, coloquial: Doe wat melk in de thee · Doe het in de koelkast.
• Con er...aan, la fórmula de la impotencia: Ik kan er niets aan doen (no puedo hacer nada, no es culpa mía) · Daar kan hij niets aan doen.
🔀 Ojo al falso amigo de uitvoeren: uitvoer significa EXPORTACIÓN (lo contrario de invoer, importación). Y en coloquial, Wat voer je uit? = ¿qué andas haciendo?, con puntito de curioseo.
Regla de bolsillo: actividad → doen · producto o arreglo → maken · encender, ponerse o causar → aandoen · ejecutar un plan (formal) → uitvoeren.'
WHERE id = 207 AND COALESCE(rules_help,'') NOT LIKE '%🛠️%';

-- ==============================================================================
-- BLOQUE COMPARTIDO (603 y 606): la construcción de frases con reflexivos
-- Se escribe una vez y se inyecta donde haya quedado el marcador. Idempotente.
-- ==============================================================================
UPDATE words_es
SET rules_help = REPLACE(rules_help, '@@REFLEX@@', '🔁 Dónde va el pronombre reflexivo (la regla que vale para TODOS):
El reflexivo neerlandés no se pega al verbo como el «-se» español: viaja suelto y busca su sitio detrás del verbo conjugado.
• Frase normal: sujeto + verbo conjugado + REFLEXIVO + resto. Ik ontspan me in bad · Ik schaam me dood.
• Con algo delante (inversión): verbo + sujeto + REFLEXIVO. Vanavond ontspan ik me met een boek.
• Pregunta y cortesía: verbo + sujeto + REFLEXIVO. Schaam jij je nooit? · Ontspant u zich maar.
• Imperativo de tuteo: verbo (raíz) + REFLEXIVO, sin sujeto. Ontspan je! · Schaam je!
• Subordinada (bijzin): sujeto + REFLEXIVO + resto + VERBOS al final. ... omdat ik me niet kan ontspannen.
• Con modal o infinitivo: el reflexivo se queda ARRIBA, junto al verbo conjugado, y el infinitivo se va al final. Ik kan me niet ontspannen — nunca «Ik kan niet me ontspannen».
• Perfecto: siempre con HEBBEN, y el reflexivo justo detrás del auxiliar. Ik heb me goed ontspannen · Ik heb me geschaamd.
• Negación: niet va DETRÁS del reflexivo (Ik ontspan me niet); si niegas un sustantivo, geen (Ik heb me geen zorgen gemaakt).
Tabla: ik→me · jij/je→je · u→zich (también u) · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich.
⚠️ zich vs zichzelf: con los verbos que SOLO existen en reflexivo (zich schamen, zich vergissen, zich haasten, zich bemoeien) va zich a secas. zichzelf es para enfatizar o cuando el verbo admite además otro objeto: Hij ziet zichzelf in de spiegel (se ve a sí mismo).
⚠️ Y al revés: muchos reflexivos españoles NO lo son en neerlandés — levantarse = opstaan · despertarse = wakker worden · caerse = vallen · mudarse = verhuizen · casarse = trouwen · resfriarse = verkouden worden. A esos no les pongas me/je/zich.')
WHERE rules_help LIKE '%@@REFLEX@@%';
