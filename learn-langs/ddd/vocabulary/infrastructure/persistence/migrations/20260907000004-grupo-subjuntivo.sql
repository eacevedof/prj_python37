-- Learn Languages App - Migration
-- Migration: 20260907000004-grupo-subjuntivo
-- Description: Eduardo: "hay que crear un grupo de subjuntivo". Se corrige la premisa
--   antes de montarlo: el neerlandes NO tiene subjuntivo productivo. La aanvoegende wijs
--   solo sobrevive en media docena de formulas congeladas (Leve de koning, God zij dank,
--   Het ga je goed, Moge het lukken, Zo zij het, Men neme), y con ese molde no se pueden
--   fabricar frases nuevas. Un grupo de "subjuntivo neerlandes" tendria seis tarjetas y
--   ninguna serviria para hablar.
--
--   El problema real es el puente al reves: que hacer con los cientos de subjuntivos que
--   el español pide y el neerlandes no tiene. Ese es el grupo que se crea, y su hallazgo
--   central es que el 90% se traducen con INDICATIVO: lo unico que cambia es la
--   conjuncion (dat, als, voordat, totdat, zodat, ook al, alsof) y que el verbo se va al
--   final de la subordinada. La trampa mas cara para un hispanohablante, y la primera
--   tarjeta del grupo: Ik wil dat je KOMT, indicativo puro.
--
--   18 tarjetas PHRASE, una por estructura: dat + indicativo, infinitivo con mismo
--   sujeto, hopelijk, el molde Had ik maar / Was het maar, el irreal de pasado, mocht
--   (lo mas parecido a un subjuntivo vivo, y muy usado en correos), als + presente para
--   el "cuando" futuro, voordat, totdat, ook al, Ik denk niet dat, misschien, alsof, el
--   imperativo negativo, y los dos fosiles reales (Het ga je goed, Leve de koning).
--
--   No duplica lo que ya hay: zou esta cubierto por el grupo 8 (zullen) con 20+ tarjetas
--   y zodat por las 279 y 516-520, asi que aqui solo se referencian desde la tabla. El
--   mocht de permiso (pasado de mogen) ya esta en la 941 y la ayuda avisa de no
--   confundirlo con el mocht condicional.
--
--   Un bloque compartido, "🧬 El subjuntivo espanol", con la tabla de las 15
--   equivalencias, el truco del 90% y los fosiles, inyectado en las 18.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'subjuntivo espanol - dat, mocht, hopelijk, ook al',
       'El neerlandes no tiene subjuntivo productivo: lo que en español dispara la forma especial, aqui se resuelve cambiando la conjuncion y dejando el verbo en INDICATIVO. Quiero que vengas es Ik wil dat je komt, con komt normal y corriente. El grupo recorre las quince estructuras que un hispanohablante traduce mal: dat + indicativo frente al infinitivo de mismo sujeto, hopelijk y el molde Had ik maar para los dos ojala, mocht para la condicion cortes de los correos, als + presente para el cuando futuro, voordat, totdat, ook al, alsof, el imperativo negativo con niet, y los pocos fosiles que quedan de la aanvoegende wijs (Leve de koning, Het ga je goed), que se reconocen porque el verbo va sin su -t',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'subjuntivo espanol - dat, mocht, hopelijk, ook al');

-- =============================================================================
-- 2. Las 18 tarjetas
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'quiero que vengas', 'PHRASE', 'Subjuntivo: dat indicativo',
'Ik wil dat je komt = quiero que vengas. Y aqui esta la trampa mas cara para un hispanohablante: komt va en INDICATIVO puro. El neerlandes no tiene con que traducir tu subjuntivo, asi que no pone nada especial.

⚠️ El error tipico es buscar una forma rara para vengas y no encontrarla, o inventar «Ik wil dat je kome». No existe. Se conjuga como si dijeras je komt a secas.

📋 Los verbos que en español piden subjuntivo y en neerlandes NO piden nada:
• willen dat — Ik wil dat je komt. (quiero que vengas)
• hopen dat — Ik hoop dat het lukt. (espero que salga bien)
• vragen of — Ik vraag of je meegaat. (pregunto si vienes)
• het is beter dat — Het is beter dat je gaat. (es mejor que te vayas)
• het is jammer dat — Het is jammer dat je niet kunt. (es una pena que no puedas)
• liever hebben dat — Ik heb liever dat je belt. (prefiero que llames)

📐 Orden de la subordinada con dat: el verbo se va AL FINAL. Ik wil dat je morgen om acht uur komt. Por larga que sea, komt cierra.

🏋️ Ejercicio: «espero que llueva» → Ik hoop dat het ___. (Respuesta: regent. Indicativo, sin mas.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: dat indicativo');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'quiero venir', 'PHRASE', 'Subjuntivo: mismo sujeto infinitivo',
'Ik wil komen = quiero venir. Cuando el sujeto de los dos verbos es EL MISMO, no hay dat ni subordinada: infinitivo pelado al final. Es la otra mitad de la regla de Ik wil dat je komt.

🔑 El truco que decide entre las dos: Pregunta quien hace la segunda accion. Si la hace el mismo que quiere, infinitivo sin dat (Ik wil komen). Si la hace OTRO, dat + indicativo (Ik wil dat je komt). En español pasa igual: quiero venir frente a quiero que vengas.

📋 Los tres moldes, uno al lado del otro:
• Ik wil komen. — Quiero venir. (mismo sujeto, infinitivo)
• Ik wil dat je komt. — Quiero que vengas. (otro sujeto, dat)
• Ik vraag je om te komen. — Te pido que vengas. (otro sujeto, om te)

⚠️ Con willen, kunnen, moeten, mogen y zullen el infinitivo va SIN te: Ik wil komen. Con casi todo lo demas lleva te: Ik probeer te komen, Ik hoop te komen.

🏋️ Ejercicio: «quiero que me ayudes» → Ik wil dat je me ___. (Respuesta: helpt.) Y «quiero ayudar» → Ik wil ___. (Respuesta: helpen.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: mismo sujeto infinitivo');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ojalá venga mañana', 'PHRASE', 'Subjuntivo: hopelijk',
'Hopelijk komt hij morgen = ojalá venga mañana. El ojalá espanol se reparte en neerlandes segun sea posible o imposible, y este es el caso posible: hopelijk, que es literalmente esperanzadamente.

🎚️ Las cuatro maneras de decir ojalá, de lo posible a lo imposible:
• Hopelijk komt hij. — Ojala venga. (todavia puede pasar)
• Ik hoop dat hij komt. — Espero que venga. (lo mismo, con dat)
• Was het maar zomer. — Ojala fuera verano. (irreal, ahora no lo es)
• Had ik maar meer tijd. — Ojala tuviera mas tiempo. (irreal)

📐 Ojo al orden: hopelijk ocupa la PRIMERA posicion, asi que el verbo se va a la segunda y el sujeto detras. Hopelijk komt hij, nunca «Hopelijk hij komt». Es la inversion de siempre.

⚠️ Y no confundas hopelijk (ojala, adverbio) con hopen (esperar, verbo). Hopelijk komt hij frente a Ik hoop dat hij komt: dicen lo mismo, pero la segunda lleva dat y verbo al final.

🏋️ Ejercicio: «ojala no llueva» → Hopelijk ___ het niet. (Respuesta: regent.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: hopelijk');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ojalá tuviera más tiempo', 'PHRASE', 'Subjuntivo: had ik maar',
'Had ik maar meer tijd = ojala tuviera mas tiempo. Es el ojala IMPOSIBLE, el de lo que no es asi, y se construye con una figura preciosa: verbo en imperfecto en primera posicion, sin als, mas maar.

📐 El molde exacto: verbo en imperfecto + sujeto + MAAR + resto. Had ik maar meer tijd. Was het maar zomer. Wist ik het maar. Kon ik maar meegaan. Fijate en que no hay ni als ni ojala: la inversion sola ya marca el deseo imposible.

🔑 El truco: Es un si condicional al que le han quitado el als y le han puesto maar. Als ik meer tijd had (si tuviera mas tiempo) se convierte en Had ik maar meer tijd (ojala tuviera mas tiempo). Quitas als, subes el verbo y metes maar.

📋 Las que se oyen a diario:
• Wist ik het maar. — Ojala lo supiera.
• Kon ik maar meegaan. — Ojala pudiera ir.
• Was ik maar thuisgebleven. — Ojala me hubiera quedado en casa.
• Had ik dat maar eerder geweten. — Ojala lo hubiera sabido antes.

⚠️ maar aqui NO es pero: es una particula que anade el matiz de deseo. Sin ella la frase se vuelve una condicional a medias y suena rara.

🏋️ Ejercicio: «ojala fuera viernes» → ___ het maar vrijdag. (Respuesta: Was.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: had ik maar');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ojalá fuera verano', 'PHRASE', 'Subjuntivo: was het maar',
'Was het maar zomer = ojala fuera verano. Mismo molde que Had ik maar, pero con zijn: imperfecto en primera posicion, sujeto detras y maar.

📊 zijn en imperfecto, que es el que necesitas para este molde:

| persona | presente | imperfecto |
|---|---|---|
| ik | ben | was |
| jij / je | bent | was |
| u | bent / is | was |
| hij / zij / het | is | was |
| wij | zijn | waren |
| jullie | zijn | waren |
| zij (plural) | zijn | waren |

• al invertir, jij pierde la -t tambien aqui: Ben jij klaar?, no «Bent jij klaar?». Es la excepcion mas conocida del neerlandes.
• participio — geweest, con hebben o zijn segun el verbo principal.

⚠️ Cuidado con was y waren en este molde: se elige por el sujeto, no por lo irreal. Was het maar zomer (het, singular) frente a Waren we maar op vakantie (we, plural).

🏋️ Ejercicio: «ojala estuvieramos de vacaciones» → ___ we maar op vakantie. (Respuesta: Waren.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: was het maar');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'si hubiera sabido eso, no habría venido', 'PHRASE', 'Subjuntivo: irreal pasado',
'Als ik dat geweten had, was ik niet gekomen = si hubiera sabido eso, no habria venido. Es el irreal del PASADO, lo que ya no tiene arreglo, y es la unica zona donde el neerlandes si marca la irrealidad.

📐 El molde: als + sujeto + participio + auxiliar en imperfecto (had / was), y en la principal otra vez auxiliar en imperfecto + participio. Als ik dat geweten had, was ik niet gekomen.

📋 Las tres condicionales, para tenerlas separadas:
• Real, presente: Als het regent, blijf ik thuis. — Si llueve, me quedo en casa.
• Irreal, presente: Als ik geld had, zou ik een huis kopen. — Si tuviera dinero, compraria una casa.
• Irreal, pasado: Als ik dat geweten had, was ik niet gekomen. — Si lo hubiera sabido, no habria venido.

🔑 El truco: El neerlandes marca lo irreal retrasando un tiempo, igual que el ingles. Presente irreal, imperfecto (had). Pasado irreal, pluscuamperfecto (geweten had). No hay ninguna forma nueva que aprender.

⚠️ Tambien vale sin als, con inversion: Had ik dat geweten, dan was ik niet gekomen. Suena mas literario pero se usa.

🏋️ Ejercicio: «si lo hubiera sabido, te habria llamado» → Als ik het geweten ___, ___ ik je gebeld. (Respuesta: had … had.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: irreal pasado');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'si vinieras, avísame', 'PHRASE', 'Subjuntivo: mocht',
'Mocht je komen, laat het dan even weten = si vinieras, avisame. mocht es lo mas parecido a un subjuntivo VIVO que le queda al neerlandes: sirve para una condicion improbable o educada, y es habitual en correos y avisos.

🔑 El truco: mocht es el imperfecto de mogen usado como si condicional cortes. Traducelo por si acaso o por si llegara a: Mocht het regenen (si llegara a llover), Mocht u vragen hebben (si tuviera usted alguna duda).

📐 El molde: mocht abre la frase, el sujeto detras, el infinitivo al final, y la principal suele arrancar con dan. Mocht je komen, laat het dan even weten. Tambien vale con als: Als je zou komen…, pero mocht suena mas fino.

📋 Las formulas de correo que veras cada semana:
• Mocht u vragen hebben, neem dan contact met ons op. — Si tiene dudas, pongase en contacto.
• Mocht het niet lukken, laat het me weten. — Si no sale, avisame.
• Mocht je later komen, geen probleem. — Si vienes mas tarde, no pasa nada.
• Mocht het regenen, dan gaan we niet. — Si llegara a llover, no vamos.

⚠️ No lo confundas con el mocht de permiso, que es el pasado normal de mogen: Ik mocht gisteren niet mee (ayer no me dejaron ir). Ese esta en la tarjeta 941. El contexto los separa sin problema: al principio de frase y con condicion, es el condicional.

🏋️ Ejercicio: «si te apeteciera, llamame» → ___ je zin hebben, bel me dan. (Respuesta: Mocht.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: mocht');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cuando llegues, llámame', 'PHRASE', 'Subjuntivo: cuando presente',
'Als je aankomt, bel me even = cuando llegues, llamame. Tu cuando + subjuntivo se convierte aqui en als + PRESENTE de indicativo. No hay futuro ni forma especial: aankomt, tal cual.

⚠️ El error tipico es traducir cuando por wanneer siempre. wanneer sirve para preguntar (Wanneer kom je?) y para el cuando de tiempo en registro formal, pero el cuando de una condicion futura es ALS. Als je aankomt, no «Wanneer je aankomt».

🎭 als, wanneer y toen, que es el trio que se confunde:
• als — si, y tambien cuando para lo futuro o repetido. Als je aankomt, bel me.
• wanneer — cuando, sobre todo preguntando. Wanneer kom je aan?
• toen — cuando, SOLO para un momento concreto del pasado. Toen ik aankwam, regende het.

🔑 El truco: ¿Es pasado y concreto? toen. ¿Es pregunta? wanneer. Todo lo demas, als.

📐 Y ojo al orden: la subordinada va delante, asi que la principal empieza con el VERBO. Als je aankomt, BEL me even. Aqui es imperativo, pero con frase normal seria Als je aankomt, ga ik weg.

🏋️ Ejercicio: «cuando llegue a casa, te escribo» → ___ ik thuiskom, app ik je. (Respuesta: Als.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: cuando presente');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cómetelo antes de que se enfríe', 'PHRASE', 'Subjuntivo: voordat',
'Eet het op voordat het koud wordt = cometelo antes de que se enfrie. Otro subjuntivo espanol que en neerlandes es indicativo pelado: wordt, sin mas.

📐 voordat abre subordinada, asi que su verbo se va AL FINAL: voordat het koud wordt. Compara con el orden de la principal, Eet het op, donde op es la particula del separable opeten.

📋 Las conjunciones de tiempo que se llevan indicativo:
• voordat — antes de que. Bel me voordat je weggaat.
• nadat — despues de que. Nadat we gegeten hadden, gingen we weg.
• totdat — hasta que. Ik wacht totdat je klaar bent.
• zodra — en cuanto. Zodra ik het weet, bel ik je.
• terwijl — mientras. Terwijl jij kookt, dek ik de tafel.

⚠️ Si el sujeto es el MISMO en las dos partes, se prefiere voor + infinitivo con te: Ik poets mijn tanden voor het slapengaan, o Bel me voor je weggaat (voordat tambien vale). Con sujetos distintos, voordat siempre.

🏋️ Ejercicio: «cierra la ventana antes de que llueva» → Doe het raam dicht ___ het gaat regenen. (Respuesta: voordat.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: voordat');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me quedo hasta que vuelvas', 'PHRASE', 'Subjuntivo: totdat',
'Ik blijf hier totdat je terugkomt = me quedo hasta que vuelvas. Igual que voordat: totdat pide indicativo y manda el verbo al final.

📐 totdat o tot, que son la misma palabra: en lengua hablada se acorta a tot muy a menudo. Ik blijf hier tot je terugkomt suena natural; totdat es la forma completa y algo mas cuidada.

📋 Los usos de tot que conviene no mezclar:
• totdat / tot — conjuncion, hasta que + frase. Ik wacht tot je klaar bent.
• tot — preposicion, hasta + hora o sitio. Ik werk tot zes uur.
• tot ziens — hasta la vista, la despedida de manual.
• tot straks / tot zo — hasta luego, dentro de un rato.
• tot morgen — hasta mañana.

⚠️ terugkomen es separable, asi que en la subordinada se reune y se escribe junto: totdat je terugkomt. En principal se partiria: Je komt morgen terug.

🏋️ Ejercicio: «espera hasta que esté listo» → Wacht ___ het klaar is. (Respuesta: totdat, o tot.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: totdat');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'aunque llueva, voy en bici', 'PHRASE', 'Subjuntivo: ook al',
'Ook al regent het, ik ga op de fiets = aunque llueva, voy en bici. El aunque + subjuntivo espanol se dice con ook al + INDICATIVO, y la parte de ook al lleva el orden invertido.

📐 Fijate en el orden, que es raro: ook al REGENT het, con el verbo pegado detras de ook al y el sujeto despues. Y la principal puede empezar por el sujeto (ik ga) o invertida (dan ga ik). Las dos valen.

🎭 Las tres maneras de decir aunque, que no son iguales:
• ook al — aunque, dando por hecho que pasa. Ook al regent het, ik ga. (esta lloviendo)
• zelfs als — incluso si, como hipotesis. Zelfs als het regent, ga ik. (puede que llueva)
• hoewel — aunque, mas formal y de contraste. Hoewel het regende, gingen we door.

🔑 El truco: ¿Lo das por hecho? ook al. ¿Es una hipotesis? zelfs als. ¿Escribes formal? hoewel.

⚠️ hoewel manda el verbo al FINAL como toda subordinada normal (Hoewel het regende), pero ook al lo pone justo detras. Es la diferencia que mas se falla.

🏋️ Ejercicio: «aunque sea caro, lo compro» → ___ ___ is het duur, ik koop het. (Respuesta: Ook al.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: ook al');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no creo que venga', 'PHRASE', 'Subjuntivo: denk niet dat',
'Ik denk niet dat hij komt = no creo que venga. En español la negacion de creer dispara el subjuntivo; en neerlandes no dispara nada: komt, indicativo.

⚠️ Y ojo a donde va el niet: en neerlandes niega el verbo principal, denk niet, no la subordinada. Ik denk niet dat hij komt, nunca «Ik denk dat hij niet komt» si lo que quieres decir es no creo que venga. La segunda existe pero significa creo que no viene, que es una afirmacion mas fuerte.

🎭 La escala de la duda, de mas a menos seguro:
• Ik weet zeker dat hij komt. — Estoy seguro de que viene.
• Ik denk dat hij komt. — Creo que viene.
• Misschien komt hij. — A lo mejor viene.
• Ik denk niet dat hij komt. — No creo que venga.
• Ik weet zeker dat hij niet komt. — Seguro que no viene.

📋 Los verbos de opinion que se llevan dat + indicativo: denken (creer), vinden (parecerle a uno), geloven (creer), vermoeden (sospechar), hopen (esperar), zeggen (decir).

🏋️ Ejercicio: «no creo que funcione» → Ik denk niet dat het ___. (Respuesta: lukt.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: denk niet dat');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'puede que llueva esta tarde', 'PHRASE', 'Subjuntivo: misschien',
'Misschien regent het vanmiddag = puede que llueva esta tarde. El puede que + subjuntivo se resuelve con un adverbio, misschien, y el verbo en indicativo.

📐 misschien en primera posicion obliga a invertir: Misschien REGENT HET, no «Misschien het regent». Tambien puede ir en medio, y entonces no hay inversion: Het regent misschien vanmiddag.

🎚️ La escala de la probabilidad, que es muy util tenerla ordenada:
• zeker — seguro. Het gaat zeker regenen.
• waarschijnlijk — probablemente. Het gaat waarschijnlijk regenen.
• misschien — a lo mejor, quiza. Misschien regent het.
• wellicht — quiza, mas formal y escrito.
• vast — seguro que, pero con matiz de suposicion. Het gaat vast regenen.

📋 Otras maneras de decir lo mismo: Het kan zijn dat het regent (puede ser que llueva) · Het zou kunnen dat het regent (podria ser) · Er is een kans dat het regent (hay posibilidad de que).

⚠️ Cuidado con vast, que parece seguro y en realidad es una suposicion confiada: Hij komt vast is como decir seguro que viene, pero sin saberlo.

🏋️ Ejercicio: «puede que venga mañana» → Misschien ___ hij morgen. (Respuesta: komt.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: misschien');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'como si fuera fácil', 'PHRASE', 'Subjuntivo: alsof',
'Alsof het makkelijk is = como si fuera facil. El como si + subjuntivo se dice con alsof, y el verbo va en indicativo y AL FINAL, porque alsof abre subordinada.

📐 alsof manda el verbo al final: alsof het makkelijk IS. Con el pasado, alsof hij het niet WIST (como si no lo supiera).

💬 Y sola, Alsof! es una interjeccion de las buenas: significa ¡ya, claro! o ¡como no!, con todo el sarcasmo. Alsof ik dat ga doen. — Como si yo fuera a hacer eso.

📋 Los usos que se oyen:
• Hij doet alsof hij slaapt. — Hace como que duerme.
• Ze deed alsof ze me niet zag. — Hizo como que no me veia.
• Het klinkt alsof het regent. — Suena como si lloviera.
• Alsof dat helpt! — ¡Como si eso sirviera de algo!

🔑 El truco: doen alsof es la formula fija de hacer como que. Si en español dices hacer como que o hacerse el, en neerlandes es doen alsof.

🏋️ Ejercicio: «hace como que no me oye» → Hij doet ___ hij me niet ___. (Respuesta: alsof … hoort.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: alsof');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no llegues tarde', 'PHRASE', 'Subjuntivo: imperativo negativo',
'Kom niet te laat = no llegues tarde. En español el imperativo negativo se hace con subjuntivo (no llegues, no vengas, no lo hagas); en neerlandes es el imperativo normal con niet detras, sin cambiar nada.

📐 El molde: verbo en la raiz + niet + resto. Kom niet te laat. Vergeet het niet. Doe dat niet. El niet va DETRAS del verbo, no delante como en español.

📋 Los que diras a diario:
• Vergeet het niet. — No lo olvides.
• Maak je geen zorgen. — No te preocupes.
• Doe dat niet. — No hagas eso.
• Zeg het niet tegen hem. — No se lo digas a el.
• Wees niet bang. — No tengas miedo. (imperativo irregular de zijn)

⚠️ Con sustantivo se usa geen en vez de niet: Maak GEEN lawaai (no hagas ruido), no «Maak niet lawaai». La regla es la de siempre: geen delante de sustantivo sin articulo o con een, niet en todo lo demas.

💬 Para suavizarlo se cuela maar o even: Kom maar niet te laat suena menos a orden. Y con nou pasa al reproche: Doe dat nou niet.

🏋️ Ejercicio: «no te olvides de las llaves» → ___ je sleutels niet. (Respuesta: Vergeet.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: imperativo negativo');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'que te vaya bien', 'PHRASE', 'Subjuntivo: het ga je goed',
'Het ga je goed = que te vaya bien. ESTE si es un subjuntivo neerlandes de verdad: ga, y no gaat, es la aanvoegende wijs, la forma que sobrevive solo en formulas hechas.

🦴 Como se reconoce: el verbo va en la raiz pelada donde esperarias la -t. Het ga je goed (no gaat), God zij dank (no is), Leve de koning (no leeft). Si ves un verbo sin su -t en una formula solemne, es esto.

⚠️ Es un FOSIL, no un tiempo que puedas usar. No se pueden fabricar frases nuevas con este molde: solo existen las formulas que ya vienen hechas. Para todo lo demas, indicativo.

📋 Todas las que quedan vivas, y son practicamente estas:
• Het ga je goed. — Que te vaya bien. (despedida sentida, de las de largo plazo)
• God zij dank. — Gracias a Dios.
• Leve de koning! — ¡Viva el rey!
• Moge het lukken. — Que salga bien. (formal)
• Zo zij het. — Asi sea.
• Men neme… — Tomese… (recetas de libro antiguo)
• Dat zij zo. — Sea asi.

💬 En el dia a dia la despedida normal NO es esta: es Fijne dag nog (que tengas buen dia), Succes! (suerte) o Het beste (que te vaya bien, mas ligero). Het ga je goed se guarda para cuando alguien se va de verdad.

🏋️ Ejercicio: «que tengas un buen dia» en la version corriente → ___ dag nog! (Respuesta: Fijne.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: het ga je goed');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡viva el rey!', 'PHRASE', 'Subjuntivo: leve de koning',
'Leve de koning! = ¡viva el rey! El otro fosil vivo del subjuntivo neerlandes: leve, y no leeft, es la aanvoegende wijs de leven.

📐 El molde es leve + sujeto, y sirve para brindar y para vitorear. Leve de koning! Leve de bruid! Leve Nederland!

🇳🇱 Contexto que ayuda a que se quede: en Koningsdag, el 27 de abril, el pais entero se viste de naranja y esto se oye de verdad. El rey es Willem-Alexander y la formula completa de los brindis oficiales es Leve de koning, leve de koningin.

📋 Otros vitores y brindis, estos ya sin subjuntivo:
• Proost! — ¡Salud! (al brindar)
• Op jou! — ¡Por ti!
• Gefeliciteerd! — ¡Felicidades!
• Hiep hiep hoera! — ¡Hip hip hurra! (en los cumpleaños, tres veces)

⚠️ No intentes usar leve con otros verbos por tu cuenta: no se dice «kome de koning» ni «werke hij». El molde solo esta congelado en estas pocas formulas.

🏋️ Ejercicio: «¡viva la novia!» → ___ de bruid! (Respuesta: Leve.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: leve de koning');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'es mejor que te vayas', 'PHRASE', 'Subjuntivo: es mejor que',
'Het is beter dat je gaat = es mejor que te vayas. Otra estructura que en español pide subjuntivo y en neerlandes se resuelve con dat + indicativo: gaat, sin mas.

📋 Las formulas impersonales que funcionan igual, todas con dat + indicativo:
• Het is beter dat je gaat. — Es mejor que te vayas.
• Het is belangrijk dat je op tijd komt. — Es importante que llegues a tiempo.
• Het is jammer dat je niet kunt. — Es una pena que no puedas.
• Het is nodig dat we het bespreken. — Hace falta que lo hablemos.
• Het is logisch dat ze boos is. — Es normal que este enfadada.

🔑 El truco: Si en español dices es + adjetivo + que + subjuntivo, en neerlandes es het is + adjetivo + dat + indicativo. La unica pieza que hay que colocar bien es el verbo al final de la subordinada.

⚠️ Con el mismo sujeto se prefiere om te y desaparece el dat: Het is beter om te gaan (es mejor irse). Es la misma alternancia de Ik wil komen frente a Ik wil dat je komt.

🏋️ Ejercicio: «es importante que lo sepas» → Het is belangrijk dat je het ___. (Respuesta: weet.)

🧬 El subjuntivo espanol y lo que hace el neerlandes en su lugar:

El neerlandes NO tiene subjuntivo productivo. Lo que en español dispara la forma especial, aqui se resuelve cambiando la CONJUNCION y dejando el verbo en indicativo normal.

| en español | en neerlandes | ejemplo |
|---|---|---|
| quiero que **vengas** | **dat** + indicativo | Ik wil dat je **komt**. |
| quiero **venir** (mismo sujeto) | infinitivo, sin dat | Ik wil **komen**. |
| ojala **venga** | **hopelijk** + indicativo | **Hopelijk** komt hij. |
| ojala **tuviera** (imposible) | imperfecto + **maar** | **Had ik maar** meer tijd. |
| si **tuviera**, compraria | imperfecto + **zou** | Als ik geld **had**, **zou** ik… |
| si **vinieras** (cortes) | **mocht** | **Mocht** je komen, … |
| cuando **llegues** | **als** + presente | **Als** je **aankomt**, … |
| antes de que **llegue** | **voordat** + indicativo | **voordat** hij **aankomt** |
| hasta que **vuelvas** | **totdat** + indicativo | **totdat** je **terugkomt** |
| para que **sepas** | **zodat** + indicativo | **zodat** je het **weet** |
| aunque **llueva** | **ook al** + indicativo | **Ook al regent** het, … |
| no creo que **venga** | **Ik denk niet dat** + ind. | Ik denk niet dat hij **komt**. |
| puede que **llueva** | **misschien** + indicativo | **Misschien regent** het. |
| como si **fuera** | **alsof** + indicativo | **Alsof** het makkelijk **is**. |
| no **vengas** | imperativo + niet | **Kom niet** te laat. |

🔑 El truco que resuelve el 90%: Deja el verbo en indicativo y preocupate solo de la conjuncion. No busques una forma especial para vengas, llegues o vuelvas: no existe. Lo unico que cambia es la palabra que abre la subordinada, y que el verbo se va al final.

⚠️ La unica zona donde el neerlandes SI marca la irrealidad es la condicional, y lo hace retrasando un tiempo, igual que el ingles: presente irreal con imperfecto (Als ik geld had) y pasado irreal con pluscuamperfecto (Als ik dat geweten had). Ninguna forma nueva que aprender.

🦴 Y lo que queda del subjuntivo neerlandes de verdad, la aanvoegende wijs, son media docena de formulas congeladas: Leve de koning! · God zij dank · Het ga je goed · Moge het lukken · Zo zij het · Men neme… Se reconocen porque el verbo va sin su -t. No se pueden fabricar frases nuevas con ese molde.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Subjuntivo: es mejor que');

-- =============================================================================
-- 3. Traducciones
-- =============================================================================
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
SELECT we.id, 'nl_NL', v.nl, v.pron
FROM (
    SELECT 'Subjuntivo: dat indicativo' AS k, 'Ik wil dat je komt.' AS nl, 'ik vil dat ye komt' AS pron
    UNION ALL SELECT 'Subjuntivo: mismo sujeto infinitivo', 'Ik wil komen.', 'ik vil koomen'
    UNION ALL SELECT 'Subjuntivo: hopelijk', 'Hopelijk komt hij morgen.', 'hoopelek komt hai mórjen'
    UNION ALL SELECT 'Subjuntivo: had ik maar', 'Had ik maar meer tijd.', 'hat ik maar meer tait'
    UNION ALL SELECT 'Subjuntivo: was het maar', 'Was het maar zomer.', 'vas het maar zoomer'
    UNION ALL SELECT 'Subjuntivo: irreal pasado', 'Als ik dat geweten had, was ik niet gekomen.', 'als ik dat jeveeten hat, vas ik nit jekoomen'
    UNION ALL SELECT 'Subjuntivo: mocht', 'Mocht je komen, laat het dan even weten.', 'mojt ye koomen, laat het dan eefen veeten'
    UNION ALL SELECT 'Subjuntivo: cuando presente', 'Als je aankomt, bel me even.', 'als ye aankomt, bel me eefen'
    UNION ALL SELECT 'Subjuntivo: voordat', 'Eet het op voordat het koud wordt.', 'eet het op foordat het kaut vort'
    UNION ALL SELECT 'Subjuntivo: totdat', 'Ik blijf hier totdat je terugkomt.', 'ik blaif hiir totdat ye terújkomt'
    UNION ALL SELECT 'Subjuntivo: ook al', 'Ook al regent het, ik ga op de fiets.', 'ook al reejent het, ik ja op de fits'
    UNION ALL SELECT 'Subjuntivo: denk niet dat', 'Ik denk niet dat hij komt.', 'ik denk nit dat hai komt'
    UNION ALL SELECT 'Subjuntivo: misschien', 'Misschien regent het vanmiddag.', 'misjiin reejent het fanmídaj'
    UNION ALL SELECT 'Subjuntivo: alsof', 'Alsof het makkelijk is.', 'alsof het mákelek is'
    UNION ALL SELECT 'Subjuntivo: imperativo negativo', 'Kom niet te laat.', 'kom nit te laat'
    UNION ALL SELECT 'Subjuntivo: het ga je goed', 'Het ga je goed.', 'het ja ye jut'
    UNION ALL SELECT 'Subjuntivo: leve de koning', 'Leve de koning!', 'leefe de kóning'
    UNION ALL SELECT 'Subjuntivo: es mejor que', 'Het is beter dat je gaat.', 'het is beeter dat ye jaat'
) v
JOIN words_es we ON we.notes = v.k;

-- =============================================================================
-- 4. Al grupo nuevo y a generic
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Subjuntivo: %' AND g.title = 'subjuntivo espanol - dat, mocht, hopelijk, ook al';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Subjuntivo: %' AND g.title = 'generic';
