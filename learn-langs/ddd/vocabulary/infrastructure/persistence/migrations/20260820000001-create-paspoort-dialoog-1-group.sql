-- Learn Languages App - Grupo "paspoort dialoog 1"
-- Migration: 20260820000001-create-paspoort-dialoog-1-group.sql
-- Description: dialogo completo de ventanilla para renovar el pasaporte neerlandes en
--   Espana: 24 turnos alternos entre el solicitante (yo) y el baliemedewerker (empleado),
--   desde que se entra por la puerta (saludo + a que vienes) hasta la despedida, pasando
--   por afspraak, aanvraagformulier, adres, pasfoto, vingerafdrukken, handtekening,
--   levertijd, ophalen/opsturen y betalen. Los datos del tramite salen de
--   https://www.nederlandwereldwijd.nl/paspoort-id-kaart/buitenland/paspoort-spanje
--   (ambassade Madrid / VFS Global, afspraak online, 8-10 weken, ophalen binnen 3 maanden,
--   quien lo quiera por correo manda antes el paspoort viejo, toeslag 26,85 EUR en las
--   visitas itinerantes de Alicante y Canarias).
--   Eje gramatical: el registro formal en «u/uw» y el imperativo cortes (verbo + u).
--   Cada tarjeta: nota propia + el DIALOGO ENTERO en orden + el mapa de vocabulario de la
--   ventanilla + 📐 formula + ⚠️ trampa + 🏋️ ejercicio, y 5 variantes de uso en
--   words_lang.notes (las que pinta el slider). El dialogo va en TODAS las tarjetas porque
--   la sesion las baraja (ORDER BY ... RANDOM()): asi cualquier turno situa al resto.
--   Los dos bloques compartidos se escriben una sola vez, al final, con REPLACE sobre los
--   marcadores @@DIALOOG@@ y @@BALIE@@ (misma tecnica que las ayudas fusionadas).
--   100% aditiva e IDEMPOTENTE (INSERT ... WHERE NOT EXISTS / OR IGNORE / REPLACE guardado).
--   No toca audios ni imagenes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'paspoort dialoog 1',
    'Dialogo de ventanilla para renovar el pasaporte neerlandes: 24 turnos alternos (yo / el empleado del consulado) desde el saludo al entrar hasta la despedida. Registro formal en u/uw, imperativo cortes (Neemt u plaats), y el vocabulario oficial del tramite: afspraak, aanvraagformulier, pasfoto, vingerafdrukken, handtekening, levertijd, ophalen, opsturen, consulaire tarieven, pinnen. Con los plazos y condiciones reales de Nederland Wereldwijd para Espana',
    'Paspoort aanvragen in Spanje - Nederland Wereldwijd - https://www.nederlandwereldwijd.nl/paspoort-id-kaart/buitenland/paspoort-spanje'
);

-- ==============================================================================
-- 01) yo - saludo de entrada + tengo cita
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Buenos días, tengo cita a las diez. (01 · yo)', 'SENTENCE', 'paspoort dialoog 1: 01 yo - saludo y hora de la cita', 'Saludo formal + a que vienes, todo de una. La hora lleva OM (om tien uur) y va DELANTE del objeto: Ik heb om tien uur een afspraak.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: sujeto (Ik) + heb (2a posicion) + om tien uur (tiempo) + een afspraak (objeto). En neerlandes el TIEMPO va antes que el objeto indefinido.

⚠️ El saludo cambia con la hora: goedemorgen (hasta las 12), goedemiddag (12-18), goedenavond (a partir de las 18). En una ventanilla oficial nunca «hoi» ni «hallo» a secas.

🧭 Cuando usarlo: los primeros diez segundos, nada mas cruzar la puerta. Ej.: → Goedemorgen, ik heb om tien uur een afspraak (buenos dias, tengo cita a las diez).

🏋️ Ejercicio: «tengo cita a las nueve y media» → Ik heb ___ half tien een afspraak. (Respuesta: om. La hora siempre con om.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Buenos días, tengo cita a las diez. (01 · yo)' AND notes = 'paspoort dialoog 1: 01 yo - saludo y hora de la cita');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Buenos días, tengo cita a las diez. (01 · yo)' AND notes = 'paspoort dialoog 1: 01 yo - saludo y hora de la cita' LIMIT 1),
    'nl_NL', 'Goedemorgen, ik heb om tien uur een afspraak.', 'Judemorjen, ik eb om tin ur en afsprak.',
    '• [can.] Goedemiddag, ik heb een afspraak om half drie. — Buenas tardes, tengo cita a las dos y media.
• [can.] Ik heb een afspraak, mijn naam is Acevedo. — Tengo cita, me llamo Acevedo.
• [vraag] Goedemorgen, ben ik hier goed voor paspoorten? — Buenos días, ¿es aquí lo de los pasaportes?
• [can.] Ik ben iets te vroeg, mijn afspraak is pas om elf uur. — Vengo un poco pronto, mi cita no es hasta las once.
• [uitdr.] Sorry dat ik laat ben, er was file. — Perdón por llegar tarde, había atasco.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Buenos días, tengo cita a las diez. (01 · yo)' AND notes = 'paspoort dialoog 1: 01 yo - saludo y hora de la cita' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Buenos días, tengo cita a las diez. (01 · yo)' AND notes = 'paspoort dialoog 1: 01 yo - saludo y hora de la cita' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 02) empleado - pase, ¿a que viene?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Buenos días, pase. ¿A qué viene? (02 · empleado)', 'SENTENCE', 'paspoort dialoog 1: 02 empleado - pase y a que viene', 'El imperativo cortes neerlandes es VERBO + U: Komt u verder = pase usted. Y waarvoor = para que (waar + voor pegados: nunca «voor wat»).
@@DIALOOG@@
@@BALIE@@
📐 Estructura del imperativo formal: verbo en 1a posicion + u + resto (Komt u verder / Neemt u plaats / Zegt u het maar).

⚠️ Los «voornaamwoordelijke bijwoorden»: waarvoor (para que), waarom (por que), waarmee (con que), waarover (sobre que). La preposicion se pega detras de waar y nunca se dice «voor wat».

🧭 Cuando usarlo: es lo que TE van a decir al entrar; reconocerlo importa mas que producirlo. Ej.: → Goedemorgen, komt u verder. Waarvoor komt u? (buenos dias, pase. ¿a que viene?).

🏋️ Ejercicio: «¿en que puedo ayudarle?» → ___ kan ik u helpen? (Respuesta: Waarmee. Con que = waarmee.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Buenos días, pase. ¿A qué viene? (02 · empleado)' AND notes = 'paspoort dialoog 1: 02 empleado - pase y a que viene');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Buenos días, pase. ¿A qué viene? (02 · empleado)' AND notes = 'paspoort dialoog 1: 02 empleado - pase y a que viene' LIMIT 1),
    'nl_NL', 'Goedemorgen, komt u verder. Waarvoor komt u?', 'Judemorjen, komt u ferder. Uarfor komt u?',
    '• [vraag] Waarmee kan ik u helpen? — ¿En qué puedo ayudarle?
• [geb.] Komt u maar mee naar loket drie. — Acompáñeme a la ventanilla tres.
• [uitdr.] Zegt u het maar. — Usted dirá.
• [vraag] Heeft u een afspraak? — ¿Tiene cita?
• [geb.] Gaat u zitten, ik help u zo. — Siéntese, le atiendo enseguida.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Buenos días, pase. ¿A qué viene? (02 · empleado)' AND notes = 'paspoort dialoog 1: 02 empleado - pase y a que viene' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Buenos días, pase. ¿A qué viene? (02 · empleado)' AND notes = 'paspoort dialoog 1: 02 empleado - pase y a que viene' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 03) yo - vengo a solicitar un pasaporte nuevo
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Vengo a solicitar un pasaporte nuevo, el mío está caducado. (03 · yo)', 'SENTENCE', 'paspoort dialoog 1: 03 yo - vengo a solicitar pasaporte nuevo', 'Ik kom + infinitivo = vengo a + infinitivo, SIN «om te» y sin preposicion: Ik kom een nieuw paspoort aanvragen. Y ojo: en neerlandes el pasaporte no se prolonga, se SOLICITA uno nuevo.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: Ik + kom (2a posicion) + een nieuw paspoort (objeto) + aanvragen (infinitivo al final). Con verbos de movimiento (komen, gaan) el infinitivo va suelto, sin te.

⚠️ Falso amigo del tramite: «mijn paspoort verlengen» suena a traduccion del espanol. Un reisdocument se vernieuwt o se vraagt aan; verlengen es para un contrato, un visado o un permiso.

⚠️ het mijne = el mio (posesivo independiente): de mijne para de-woorden, het mijne para het-woorden. Het paspoort es het-woord → het mijne.

🏋️ Ejercicio: «vengo a recoger mi pasaporte» → Ik kom mijn paspoort ___. (Respuesta: ophalen. Infinitivo al final, sin te.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Vengo a solicitar un pasaporte nuevo, el mío está caducado. (03 · yo)' AND notes = 'paspoort dialoog 1: 03 yo - vengo a solicitar pasaporte nuevo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Vengo a solicitar un pasaporte nuevo, el mío está caducado. (03 · yo)' AND notes = 'paspoort dialoog 1: 03 yo - vengo a solicitar pasaporte nuevo' LIMIT 1),
    'nl_NL', 'Ik kom een nieuw paspoort aanvragen, het mijne is verlopen.', 'Ik kom en niuu pasport anfrajen, et meine is ferlopen.',
    '• [can.] Ik kom mijn paspoort vernieuwen. — Vengo a renovar el pasaporte.
• [can.] Mijn paspoort is vorige maand verlopen. — Mi pasaporte caducó el mes pasado.
• [can.] Ik wil een nieuwe ID-kaart aanvragen. — Quiero solicitar un DNI nuevo.
• [perf.] Ik ben mijn paspoort kwijtgeraakt. — He perdido el pasaporte.
• [can.] Mijn paspoort is nog een half jaar geldig. — Mi pasaporte vale todavía medio año.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vengo a solicitar un pasaporte nuevo, el mío está caducado. (03 · yo)' AND notes = 'paspoort dialoog 1: 03 yo - vengo a solicitar pasaporte nuevo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vengo a solicitar un pasaporte nuevo, el mío está caducado. (03 · yo)' AND notes = 'paspoort dialoog 1: 03 yo - vengo a solicitar pasaporte nuevo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 04) empleado - ¿me deja ver la confirmacion y el pasaporte antiguo?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Me deja ver la confirmación de la cita y su pasaporte antiguo? (04 · empleado)', 'SENTENCE', 'paspoort dialoog 1: 04 empleado - pide confirmacion y pasaporte viejo', 'Mag ik ... zien? es LA formula cortes para pedir algo: modal mag delante y el infinitivo (zien) al final, con todo lo pedido en medio.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: Mag + ik + uw afspraakbevestiging en uw oude paspoort (objeto largo) + zien (infinitivo al final). Cuanto mas largo el objeto, mas se nota que el infinitivo espera al final.

⚠️ u (usted, sujeto) / uw (su, posesivo) / jouw-je (tu, informal). En la ventanilla todo va en u y uw: uw naam, uw adres, uw handtekening. Mezclarlo con je suena a tuteo brusco.

🧭 Cuando usarlo: reconocerlo cuando te lo piden y devolverlo en la misma moneda: Mag ik uw pen even lenen? (¿me deja el boli un momento?).

🏋️ Ejercicio: «¿me deja ver su formulario?» → Mag ik ___ formulier zien? (Respuesta: uw. Posesivo formal.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Me deja ver la confirmación de la cita y su pasaporte antiguo? (04 · empleado)' AND notes = 'paspoort dialoog 1: 04 empleado - pide confirmacion y pasaporte viejo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me deja ver la confirmación de la cita y su pasaporte antiguo? (04 · empleado)' AND notes = 'paspoort dialoog 1: 04 empleado - pide confirmacion y pasaporte viejo' LIMIT 1),
    'nl_NL', 'Mag ik uw afspraakbevestiging en uw oude paspoort zien?', 'Maj ik uu afsprakbefestijinj en uu aude pasport sin?',
    '• [vraag] Mag ik uw legitimatie even zien? — ¿Me enseña su documento un momento?
• [vraag] Heeft u uw oude paspoort bij u? — ¿Trae consigo el pasaporte antiguo?
• [vraag] Mag ik uw checklist en het aanvraagformulier? — ¿Me da la checklist y el formulario de solicitud?
• [geb.] Legt u alles maar hier op de balie. — Póngalo todo aquí en el mostrador.
• [vraag] Heeft u ook een bewijs van uw adres? — ¿Trae también un justificante del domicilio?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me deja ver la confirmación de la cita y su pasaporte antiguo? (04 · empleado)' AND notes = 'paspoort dialoog 1: 04 empleado - pide confirmacion y pasaporte viejo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me deja ver la confirmación de la cita y su pasaporte antiguo? (04 · empleado)' AND notes = 'paspoort dialoog 1: 04 empleado - pide confirmacion y pasaporte viejo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 05) yo - claro, aqui tiene
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Claro, aquí tiene. (05 · yo)', 'SENTENCE', 'paspoort dialoog 1: 05 yo - claro, aqui tiene', 'alstublieft hace DOS papeles: «por favor» cuando pides y «aqui tiene» cuando entregas. En la ventanilla, al alargar un papel, es la palabra exacta.
@@DIALOOG@@
@@BALIE@@
📐 Formula fija, sin verbo: Natuurlijk, alstublieft. Si quieres el verbo: Hier heeft u het formulier.

⚠️ Escala de formalidad: alstublieft (usted) / alsjeblieft (tu) / alsjeblief en el habla rapida. Lo mismo con el gracias: dank u wel (usted) / dank je wel (tu) / bedankt (neutro).

🧭 Cuando usarlo: cada vez que le pasas un papel al funcionario; el silencio al entregar algo suena seco en NL.

🏋️ Ejercicio: le das el formulario a un desconocido mayor → ___ (Respuesta: Alstublieft. Con u, nunca alsjeblieft.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Claro, aquí tiene. (05 · yo)' AND notes = 'paspoort dialoog 1: 05 yo - claro, aqui tiene');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Claro, aquí tiene. (05 · yo)' AND notes = 'paspoort dialoog 1: 05 yo - claro, aqui tiene' LIMIT 1),
    'nl_NL', 'Natuurlijk, alstublieft.', 'Naturleik, alstublift.',
    '• [uitdr.] Alstublieft, hier is het formulier. — Aquí tiene, el formulario.
• [uitdr.] Momentje, ik pak het even. — Un momento, lo saco.
• [can.] Natuurlijk, alles zit in deze map. — Claro, está todo en esta carpeta.
• [uitdr.] Hier heeft u mijn oude paspoort. — Aquí tiene mi pasaporte antiguo.
• [can.] Ik heb ook een kopie meegenomen. — He traído también una copia.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Claro, aquí tiene. (05 · yo)' AND notes = 'paspoort dialoog 1: 05 yo - claro, aqui tiene' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Claro, aquí tiene. (05 · yo)' AND notes = 'paspoort dialoog 1: 05 yo - claro, aqui tiene' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 06) empleado - sientese, le llamo enseguida
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Siéntese, le llamo enseguida. (06 · empleado)', 'SENTENCE', 'paspoort dialoog 1: 06 empleado - sientese, le llamo enseguida', 'Neemt u plaats = sientese (literalmente «tome asiento»), otro imperativo cortes verbo+u. Y oproepen es separable: ik roep u zo OP.
@@DIALOOG@@
@@BALIE@@
📐 Estructura del separable: Ik + roep (2a posicion) + u + zo + op (particula al final). El «op» cierra siempre la frase.

⚠️ zo aqui NO es «asi», es «enseguida, dentro de nada». La escala: meteen / direct (ahora mismo) → zo (en un momento) → straks (luego, mas tarde) → later (mas adelante).

🧭 Cuando usarlo: lo oiras al terminar el primer filtro, antes de sentarte a esperar. Ej.: → Neemt u plaats, ik roep u zo op (sientese, le llamo enseguida).

🏋️ Ejercicio: «le llamo enseguida» → Ik ___ u zo ___. (Respuesta: roep ... op. Separable partido.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Siéntese, le llamo enseguida. (06 · empleado)' AND notes = 'paspoort dialoog 1: 06 empleado - sientese, le llamo enseguida');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Siéntese, le llamo enseguida. (06 · empleado)' AND notes = 'paspoort dialoog 1: 06 empleado - sientese, le llamo enseguida' LIMIT 1),
    'nl_NL', 'Neemt u plaats, ik roep u zo op.', 'Nemt u plats, ik rup u so op.',
    '• [geb.] Neemt u plaats in de wachtruimte. — Tome asiento en la sala de espera.
• [can.] U wordt zo opgeroepen. — Le llamarán enseguida.
• [geb.] Wacht u even, het duurt niet lang. — Espere un momento, no tarda.
• [can.] Er zijn nog twee mensen voor u. — Hay dos personas antes que usted.
• [geb.] Trekt u eerst een nummertje. — Coja primero un número.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Siéntese, le llamo enseguida. (06 · empleado)' AND notes = 'paspoort dialoog 1: 06 empleado - sientese, le llamo enseguida' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Siéntese, le llamo enseguida. (06 · empleado)' AND notes = 'paspoort dialoog 1: 06 empleado - sientese, le llamo enseguida' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 07) empleado - numero 24, ventanilla dos
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Número veinticuatro, ventanilla dos, por favor. (07 · empleado)', 'SENTENCE', 'paspoort dialoog 1: 07 empleado - numero y ventanilla', 'Los numeros de dos cifras van AL REVES: vierentwintig = cuatro-y-veinte (24). Si esperas «twintigvier» no reconoces tu turno.
@@DIALOOG@@
@@BALIE@@
📐 Formula: unidad + en + decena, todo en UNA palabra: eenentwintig (21), tweeentwintig (22, con dieresis: tweeëntwintig), drieentwintig (23), vierentwintig (24), vijfendertig (35), zesenveertig (46).

⚠️ het loket = la ventanilla (con cristal) · de balie = el mostrador · de wachtruimte = la sala de espera · het nummertje = el numerito de turno. En el consulado oiras loket y balie mezclados.

🧭 Cuando usarlo: es puro oido — el numero que sale por megafonia. Practicalo con los numeros del 20 al 99, que son los que se dicen del reves.

🏋️ Ejercicio: «numero treinta y cinco» → nummer ___. (Respuesta: vijfendertig. Primero el cinco.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Número veinticuatro, ventanilla dos, por favor. (07 · empleado)' AND notes = 'paspoort dialoog 1: 07 empleado - numero y ventanilla');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Número veinticuatro, ventanilla dos, por favor. (07 · empleado)' AND notes = 'paspoort dialoog 1: 07 empleado - numero y ventanilla' LIMIT 1),
    'nl_NL', 'Nummer vierentwintig, loket twee alstublieft.', 'Nummer firentuintij, loket tue alstublift.',
    '• [can.] Nummer eenentwintig, balie vier. — Número veintiuno, mostrador cuatro.
• [vraag] Bent u nummer drieëntwintig? — ¿Es usted el número veintitrés?
• [geb.] Komt u maar naar loket een. — Pase a la ventanilla uno.
• [can.] Het loket hiernaast is gesloten. — La ventanilla de al lado está cerrada.
• [vraag] Welk nummer heeft u? — ¿Qué número tiene?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Número veinticuatro, ventanilla dos, por favor. (07 · empleado)' AND notes = 'paspoort dialoog 1: 07 empleado - numero y ventanilla' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Número veinticuatro, ventanilla dos, por favor. (07 · empleado)' AND notes = 'paspoort dialoog 1: 07 empleado - numero y ventanilla' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 08) empleado - ¿ha rellenado y firmado el formulario?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Ha rellenado y firmado el formulario de solicitud? (08 · empleado)', 'SENTENCE', 'paspoort dialoog 1: 08 empleado - formulario relleno y firmado', 'Dos participios en la misma frase y cada uno de una familia: ingevuld (separable, lleva ge- DENTRO) y ondertekend (prefijo inseparable, NO lleva ge-).
@@DIALOOG@@
@@BALIE@@
📐 Estructura: Heeft + u + het aanvraagformulier + ingevuld en ondertekend (los dos participios juntos, al final).

⚠️ La regla del ge-: invullen es separable → in + GE + vuld = ingevuld. ondertekenen lleva el prefijo atono onder- pegado → ondertekend, SIN ge-. Igual: begrepen, verlopen, ontvangen, aangevraagd (separable, si lleva ge-).

🧭 Cuando usarlo: es la primera pregunta del loket. Respuesta corta y util: Ja, alles is ingevuld en ondertekend.

🏋️ Ejercicio: «¿lo ha firmado?» → Heeft u het ___? (Respuesta: ondertekend. Sin ge-, que onder- es inseparable.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Ha rellenado y firmado el formulario de solicitud? (08 · empleado)' AND notes = 'paspoort dialoog 1: 08 empleado - formulario relleno y firmado');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¿Ha rellenado y firmado el formulario de solicitud? (08 · empleado)' AND notes = 'paspoort dialoog 1: 08 empleado - formulario relleno y firmado' LIMIT 1),
    'nl_NL', 'Heeft u het aanvraagformulier ingevuld en ondertekend?', 'Eft u et anfrajformulir injefuld en ondertekend?',
    '• [vraag] Heeft u het formulier al ingevuld? — ¿Ha rellenado ya el formulario?
• [vraag] Heeft u onderaan getekend? — ¿Ha firmado abajo del todo?
• [geb.] Vult u dit vakje nog even in. — Rellene también esta casilla.
• [vraag] Kunt u hier uw telefoonnummer invullen? — ¿Puede poner aquí su número de teléfono?
• [can.] U bent een handtekening vergeten. — Se ha dejado una firma.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Ha rellenado y firmado el formulario de solicitud? (08 · empleado)' AND notes = 'paspoort dialoog 1: 08 empleado - formulario relleno y firmado' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Ha rellenado y firmado el formulario de solicitud? (08 · empleado)' AND notes = 'paspoort dialoog 1: 08 empleado - formulario relleno y firmado' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 09) yo - si, lo he rellenado en casa y lo he impreso
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Sí, lo he rellenado en casa y lo he impreso. (09 · yo)', 'SENTENCE', 'paspoort dialoog 1: 09 yo - relleno e impreso en casa', 'Perfecto de un separable: invullen → in + ge + vuld = ingevuld, y el participio se va al final con el otro (geprint). thuis = en casa, sin preposicion.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: Ik + heb (2a posicion) + het + thuis (lugar) + ingevuld en geprint (participios al final).

⚠️ thuis (en casa, estatico: Ik ben thuis) / naar huis (a casa, movimiento: Ik ga naar huis) / het huis (la casa, el edificio). El error tipico es «in mijn huis», que suena a descripcion del inmueble.

🧭 Cuando usarlo: para adelantarte a la pregunta y dejar claro que llevas los deberes hechos. Ej.: → Ja, ik heb het thuis ingevuld en geprint.

🏋️ Ejercicio: «lo he impreso en casa» → Ik heb het ___ geprint. (Respuesta: thuis.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Sí, lo he rellenado en casa y lo he impreso. (09 · yo)' AND notes = 'paspoort dialoog 1: 09 yo - relleno e impreso en casa');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Sí, lo he rellenado en casa y lo he impreso. (09 · yo)' AND notes = 'paspoort dialoog 1: 09 yo - relleno e impreso en casa' LIMIT 1),
    'nl_NL', 'Ja, ik heb het thuis ingevuld en geprint.', 'Ya, ik eb et taus injefuld en jeprint.',
    '• [perf.] Ik heb het formulier gisteren gedownload. — Descargué el formulario ayer.
• [perf.] Ik heb alles ingevuld, behalve dit vakje. — Lo he rellenado todo menos esta casilla.
• [can.] Ik heb het thuis geprint, hopelijk is het goed zo. — Lo he impreso en casa, espero que valga así.
• [vraag] Moet ik ook de achterkant invullen? — ¿Tengo que rellenar también el dorso?
• [can.] Ik heb het met blauwe pen ondertekend. — Lo he firmado con bolígrafo azul.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Sí, lo he rellenado en casa y lo he impreso. (09 · yo)' AND notes = 'paspoort dialoog 1: 09 yo - relleno e impreso en casa' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Sí, lo he rellenado en casa y lo he impreso. (09 · yo)' AND notes = 'paspoort dialoog 1: 09 yo - relleno e impreso en casa' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 10) empleado - ¿sigue siendo correcta su direccion?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Su dirección sigue siendo correcta? ¿Sigue viviendo en Madrid? (10 · empleado)', 'SENTENCE', 'paspoort dialoog 1: 10 empleado - comprueba direccion', 'kloppen = cuadrar, ser correcto. «Klopt uw adres nog?» es lo que en espanol es «¿su direccion sigue siendo correcta?». Y nog steeds = todavia, sigue siendo.
@@DIALOOG@@
@@BALIE@@
📐 Pregunta cerrada sin particula: verbo en 1a posicion + sujeto (Klopt uw adres nog? / Woont u nog steeds in Madrid?).

⚠️ La escala del «todavia»: nog (todavia, sin mas) · nog steeds (aun sigue, con insistencia) · al (ya) · niet meer (ya no) · nog niet (todavia no). Dat klopt = correcto; Dat klopt niet = eso no cuadra.

🧭 Cuando usarlo: es la comprobacion de datos de toda ventanilla. Responde con Dat klopt / Dat klopt niet meer, ik ben verhuisd.

🏋️ Ejercicio: «¿sigue viviendo aquí?» → Woont u hier ___ ___? (Respuesta: nog steeds.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Su dirección sigue siendo correcta? ¿Sigue viviendo en Madrid? (10 · empleado)' AND notes = 'paspoort dialoog 1: 10 empleado - comprueba direccion');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¿Su dirección sigue siendo correcta? ¿Sigue viviendo en Madrid? (10 · empleado)' AND notes = 'paspoort dialoog 1: 10 empleado - comprueba direccion' LIMIT 1),
    'nl_NL', 'Klopt uw adres nog? Woont u nog steeds in Madrid?', 'Klopt uu adres noj? Uont u noj steds in Madrid?',
    '• [vraag] Klopt dit telefoonnummer nog? — ¿Sigue siendo correcto este teléfono?
• [vraag] Bent u verhuisd sinds de vorige aanvraag? — ¿Se ha mudado desde la última solicitud?
• [vraag] Woont u nog steeds op hetzelfde adres? — ¿Sigue viviendo en la misma dirección?
• [can.] Uw gegevens moeten kloppen met uw inschrijving. — Sus datos tienen que coincidir con su registro.
• [vraag] Wat is uw huidige woonplaats? — ¿Cuál es su localidad actual?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Su dirección sigue siendo correcta? ¿Sigue viviendo en Madrid? (10 · empleado)' AND notes = 'paspoort dialoog 1: 10 empleado - comprueba direccion' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Su dirección sigue siendo correcta? ¿Sigue viviendo en Madrid? (10 · empleado)' AND notes = 'paspoort dialoog 1: 10 empleado - comprueba direccion' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 11) yo - correcto, aunque me mude el ano pasado
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Sí, correcto. Aunque el año pasado sí me mudé dentro de la ciudad. (11 · yo)', 'SENTENCE', 'paspoort dialoog 1: 11 yo - confirma y matiza la mudanza', 'Dat klopt = correcto, asi es. verhuizen (mudarse) hace el perfecto con ZIJN, no con hebben: Ik BEN verhuisd. Y wel es el matiz «si que», la respuesta a una negacion implicita.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: Ik + ben (2a posicion) + vorig jaar (tiempo) + wel (matiz) + verhuisd (participio al final).

⚠️ Perfecto con zijn: los verbos de cambio de lugar o de estado (verhuizen, gaan, komen, blijven, worden, vertrekken). Ik heb verhuisd es el error clasico del hispanohablante.

⚠️ wel no se traduce con una palabra: es el «si» que contradice. Ik ben wel verhuisd = mudarme si me mude (aunque la direccion siga valiendo).

🏋️ Ejercicio: «me mudé el año pasado» → Ik ___ vorig jaar verhuisd. (Respuesta: ben. Cambio de lugar → zijn.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Sí, correcto. Aunque el año pasado sí me mudé dentro de la ciudad. (11 · yo)' AND notes = 'paspoort dialoog 1: 11 yo - confirma y matiza la mudanza');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Sí, correcto. Aunque el año pasado sí me mudé dentro de la ciudad. (11 · yo)' AND notes = 'paspoort dialoog 1: 11 yo - confirma y matiza la mudanza' LIMIT 1),
    'nl_NL', 'Ja, dat klopt. Ik ben vorig jaar wel verhuisd binnen de stad.', 'Ya, dat klopt. Ik ben forij yar uel ferausd binnen de stad.',
    '• [can.] Dat klopt, dat is nog steeds mijn adres. — Correcto, sigue siendo mi dirección.
• [perf.] Ik ben in maart verhuisd naar een ander appartement. — Me mudé en marzo a otro piso.
• [can.] Mijn nieuwe adres staat op het formulier. — Mi dirección nueva está en el formulario.
• [can.] Nee, er is niets veranderd. — No, no ha cambiado nada.
• [vraag] Moet ik de verhuizing hier doorgeven? — ¿Tengo que comunicar aquí la mudanza?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Sí, correcto. Aunque el año pasado sí me mudé dentro de la ciudad. (11 · yo)' AND notes = 'paspoort dialoog 1: 11 yo - confirma y matiza la mudanza' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Sí, correcto. Aunque el año pasado sí me mudé dentro de la ciudad. (11 · yo)' AND notes = 'paspoort dialoog 1: 11 yo - confirma y matiza la mudanza' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 12) empleado - la foto tiene que cumplir los requisitos
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Me da su foto de carnet? Tiene que cumplir los requisitos. (12 · empleado)', 'SENTENCE', 'paspoort dialoog 1: 12 empleado - pide la pasfoto', 'voldoen AAN = cumplir (requisitos, condiciones): es un verbo con preposicion fija, y la preposicion no se negocia. De foto moet AAN de eisen voldoen.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: Die (demostrativo que retoma de pasfoto) + moet (modal, 2a posicion) + aan de eisen (complemento fijo) + voldoen (infinitivo al final).

⚠️ Verbo + preposicion fija: voldoen aan (cumplir), wachten op (esperar), denken aan (pensar en), vragen om (pedir), zorgen voor (encargarse de). «Voldoen de eisen» no existe.

⚠️ Vocabulario de la foto: de pasfoto (foto de carnet), de eisen (los requisitos), de achtergrond (el fondo), effen (liso), recent (reciente).

🏋️ Ejercicio: «la foto tiene que cumplir los requisitos» → De foto moet ___ de eisen ___. (Respuesta: aan ... voldoen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Me da su foto de carnet? Tiene que cumplir los requisitos. (12 · empleado)' AND notes = 'paspoort dialoog 1: 12 empleado - pide la pasfoto');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me da su foto de carnet? Tiene que cumplir los requisitos. (12 · empleado)' AND notes = 'paspoort dialoog 1: 12 empleado - pide la pasfoto' LIMIT 1),
    'nl_NL', 'Mag ik uw pasfoto? Die moet aan de eisen voldoen.', 'Maj ik uu pasfoto? Di mut an de eisen foldun.',
    '• [vraag] Heeft u een recente pasfoto bij u? — ¿Trae una foto reciente?
• [can.] De foto mag niet ouder zijn dan zes maanden. — La foto no puede tener más de seis meses.
• [can.] Op de foto mag u niet lachen. — En la foto no puede sonreír.
• [can.] De achtergrond moet effen en licht zijn. — El fondo tiene que ser liso y claro.
• [geb.] Doet u uw bril even af voor de foto. — Quítese las gafas para la foto.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me da su foto de carnet? Tiene que cumplir los requisitos. (12 · empleado)' AND notes = 'paspoort dialoog 1: 12 empleado - pide la pasfoto' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me da su foto de carnet? Tiene que cumplir los requisitos. (12 · empleado)' AND notes = 'paspoort dialoog 1: 12 empleado - pide la pasfoto' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 13) yo - ¿vale esta foto o me hago otra?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Vale esta foto o tengo que hacerme una nueva? (13 · yo)', 'SENTENCE', 'paspoort dialoog 1: 13 yo - pregunta si la foto vale', 'laten + infinitivo = mandar hacer, que te lo hagan. Een foto laten maken NO es hacerla tu: es ir al fotografo. Ese «laten» es el que le falta a casi todo hispanohablante.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: moet + ik + een nieuwe + laten maken (DOBLE infinitivo al final, en el orden laten + verbo).

⚠️ laten tiene tres vidas: (1) mandar hacer — Ik laat mijn haar knippen (me corto el pelo en la peluqueria); (2) dejar/permitir — Laat me met rust (dejame en paz); (3) laten we... = vamos a... En la ventanilla es siempre la primera.

⚠️ voldoen (cumplir) tambien vale solo: Voldoet deze foto? = ¿esta foto vale?

🏋️ Ejercicio: «voy a hacerme una foto nueva» → Ik ga een nieuwe foto ___ ___. (Respuesta: laten maken.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Vale esta foto o tengo que hacerme una nueva? (13 · yo)' AND notes = 'paspoort dialoog 1: 13 yo - pregunta si la foto vale');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¿Vale esta foto o tengo que hacerme una nueva? (13 · yo)' AND notes = 'paspoort dialoog 1: 13 yo - pregunta si la foto vale' LIMIT 1),
    'nl_NL', 'Voldoet deze foto, of moet ik een nieuwe laten maken?', 'Foldut dese foto, of mut ik en niuue laten maken?',
    '• [vraag] Is deze foto goed genoeg? — ¿Vale esta foto?
• [vraag] Waar kan ik hier in de buurt een pasfoto laten maken? — ¿Dónde puedo hacerme una foto de carnet por aquí cerca?
• [can.] Ik laat wel een nieuwe maken, geen probleem. — Me hago una nueva, sin problema.
• [vraag] Mag ik met een bril op de foto? — ¿Puedo salir con gafas en la foto?
• [perf.] Ik heb hem gisteren laten maken bij de fotograaf. — Me la hice ayer en el fotógrafo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Vale esta foto o tengo que hacerme una nueva? (13 · yo)' AND notes = 'paspoort dialoog 1: 13 yo - pregunta si la foto vale' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Vale esta foto o tengo que hacerme una nueva? (13 · yo)' AND notes = 'paspoort dialoog 1: 13 yo - pregunta si la foto vale' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 14) empleado - ponga los dedos en el escaner
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ponga los cuatro dedos en el escáner. Y ahora el pulgar. (14 · empleado)', 'SENTENCE', 'paspoort dialoog 1: 14 empleado - vingerafdrukken', 'Aqui «poner» es LEGGEN (plano, tumbado), no zetten ni doen: la mano queda apoyada. Legt u uw vier vingers op de scanner.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: Legt (imperativo formal) + u + uw vier vingers (objeto) + op de scanner (lugar).

⚠️ El mapa de «poner» decide el verbo por como queda la cosa: zetten (de pie) · leggen (tumbado, plano) · stoppen/steken in (dentro) · hangen (colgado) · doen (echar). La mano en un cristal queda plana → leggen. Ver el grupo «variantes de poner».

⚠️ Vocabulario biometrico: de vingerafdrukken (las huellas), de duim (el pulgar), de wijsvinger (indice), de rechterhand / linkerhand, drukken (apretar).

🏋️ Ejercicio: «ponga la mano en el escáner» → ___ u uw hand op de scanner. (Respuesta: Legt. Queda plana → leggen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ponga los cuatro dedos en el escáner. Y ahora el pulgar. (14 · empleado)' AND notes = 'paspoort dialoog 1: 14 empleado - vingerafdrukken');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Ponga los cuatro dedos en el escáner. Y ahora el pulgar. (14 · empleado)' AND notes = 'paspoort dialoog 1: 14 empleado - vingerafdrukken' LIMIT 1),
    'nl_NL', 'Legt u uw vier vingers op de scanner. En nu uw duim.', 'Lejt u uu fir finjers op de scanner. En nu uu daum.',
    '• [geb.] Legt u uw rechterhand op het glas. — Ponga la mano derecha en el cristal.
• [geb.] Drukt u niet te hard. — No apriete demasiado.
• [can.] We nemen nu uw vingerafdrukken. — Ahora le tomamos las huellas.
• [geb.] Kijkt u recht in de camera, niet lachen. — Mire de frente a la cámara, sin sonreír.
• [can.] Uw vingers zijn te droog, probeert u het nog eens. — Tiene los dedos muy secos, inténtelo otra vez.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ponga los cuatro dedos en el escáner. Y ahora el pulgar. (14 · empleado)' AND notes = 'paspoort dialoog 1: 14 empleado - vingerafdrukken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ponga los cuatro dedos en el escáner. Y ahora el pulgar. (14 · empleado)' AND notes = 'paspoort dialoog 1: 14 empleado - vingerafdrukken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 15) empleado - firme aqui dentro del recuadro
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Firme aquí, dentro del recuadro. (15 · empleado)', 'SENTENCE', 'paspoort dialoog 1: 15 empleado - handtekening', 'Firmar = een handtekening ZETTEN (la firma se «planta», con zetten; nunca doen ni maken). Alternativa: tekenen / ondertekenen.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: Zet + u + hier (lugar) + uw handtekening (objeto) + binnen het vakje. Cuando el objeto es «pesado» y ya sabido, el lugar corto se le adelanta.

⚠️ tekenen = firmar y tambien dibujar · ondertekenen = firmar un documento (formal) · de handtekening = la firma · de paraaf = la rubrica · het vakje / het kader = la casilla, el recuadro.

🧭 Cuando usarlo: reconocerlo y no dudar donde firmar. Si no lo pillas: Waar moet ik tekenen? (¿donde firmo?).

🏋️ Ejercicio: «firme aquí» → ___ u hier uw handtekening. (Respuesta: Zet. La firma se pone con zetten.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Firme aquí, dentro del recuadro. (15 · empleado)' AND notes = 'paspoort dialoog 1: 15 empleado - handtekening');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Firme aquí, dentro del recuadro. (15 · empleado)' AND notes = 'paspoort dialoog 1: 15 empleado - handtekening' LIMIT 1),
    'nl_NL', 'Zet u hier uw handtekening, binnen het vakje.', 'Set u ir uu andtekeninj, binnen et fakye.',
    '• [geb.] Zet u hier even uw paraaf. — Ponga aquí su rúbrica.
• [geb.] Tekent u onderaan de bladzijde. — Firme al pie de la página.
• [can.] Uw handtekening moet binnen het kader blijven. — La firma tiene que quedar dentro del recuadro.
• [vraag] Is dit uw handtekening? — ¿Es esta su firma?
• [geb.] Gebruikt u een zwarte pen, alstublieft. — Use bolígrafo negro, por favor.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Firme aquí, dentro del recuadro. (15 · empleado)' AND notes = 'paspoort dialoog 1: 15 empleado - handtekening' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Firme aquí, dentro del recuadro. (15 · empleado)' AND notes = 'paspoort dialoog 1: 15 empleado - handtekening' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 16) yo - ¿cuanto tarda en estar listo?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Cuánto tarda en estar listo el pasaporte? (16 · yo)', 'SENTENCE', 'paspoort dialoog 1: 16 yo - cuanto tarda', 'duren = tardar/durar algo (el sujeto es la COSA, no la persona): Hoe lang duurt het? Y voordat es subordinante → manda el verbo al final.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: Hoe lang + duurt (2a posicion) + het + [voordat + het paspoort + klaar is] (verbo al final de la subordinada).

⚠️ Tardar tiene dos verbos segun quien tarda: la COSA tarda → duren (Het duurt tien weken); la PERSONA tarda → er ... over doen (Ik doe er een uur over). Nunca «Ik duur».

⚠️ klaar = listo/terminado · af = acabado (un trabajo) · gereed (formal). «Het is klaar» = ya esta.

🏋️ Ejercicio: «¿cuánto tarda?» → Hoe lang ___ het? (Respuesta: duurt.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Cuánto tarda en estar listo el pasaporte? (16 · yo)' AND notes = 'paspoort dialoog 1: 16 yo - cuanto tarda');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cuánto tarda en estar listo el pasaporte? (16 · yo)' AND notes = 'paspoort dialoog 1: 16 yo - cuanto tarda' LIMIT 1),
    'nl_NL', 'Hoe lang duurt het voordat het paspoort klaar is?', 'U lanj durt et fordat et pasport klar is?',
    '• [vraag] Hoelang moet ik wachten? — ¿Cuánto tengo que esperar?
• [vraag] Wanneer kan ik hem ophalen? — ¿Cuándo puedo recogerlo?
• [vraag] Kan het ook sneller, met spoed? — ¿Se puede más rápido, con urgencia?
• [vraag] Krijg ik bericht als het klaar is? — ¿Me avisan cuando esté listo?
• [can.] Ik heb hem voor de zomer nodig. — Lo necesito para el verano.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cuánto tarda en estar listo el pasaporte? (16 · yo)' AND notes = 'paspoort dialoog 1: 16 yo - cuanto tarda' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cuánto tarda en estar listo el pasaporte? (16 · yo)' AND notes = 'paspoort dialoog 1: 16 yo - cuanto tarda' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 17) empleado - cuente con ocho a diez semanas
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Cuente con ocho a diez semanas. Le avisaremos. (17 · empleado)', 'SENTENCE', 'paspoort dialoog 1: 17 empleado - levertijd de 8 a 10 semanas', 'rekenen OP = contar con (otra preposicion fija). Reken op acht tot tien weken. Y bericht krijgen = recibir aviso, la formula estandar de la administracion.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: Reken (imperativo; formal: Rekent u) + op + el plazo. De X tot Y = de X a Y: acht tot tien weken.

⚠️ Dato real (Nederland Wereldwijd, Espana): la levertijd normal es de 8 a 10 semanas, y luego hay que ophalen binnen 3 maanden. No es un numero inventado: cuentalo asi.

⚠️ rekenen op (contar con algo previsible) / rekenen met (contar con una cifra) / erop rekenen dat... (dar por hecho que...).

🏋️ Ejercicio: «cuente con dos semanas» → ___ op twee weken. (Respuesta: Reken. rekenen siempre con op.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cuente con ocho a diez semanas. Le avisaremos. (17 · empleado)' AND notes = 'paspoort dialoog 1: 17 empleado - levertijd de 8 a 10 semanas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuente con ocho a diez semanas. Le avisaremos. (17 · empleado)' AND notes = 'paspoort dialoog 1: 17 empleado - levertijd de 8 a 10 semanas' LIMIT 1),
    'nl_NL', 'Reken op acht tot tien weken. U krijgt bericht van ons.', 'Reken op ajt tot tin ueken. U kreijt berijt fan ons.',
    '• [can.] Het duurt ongeveer acht weken. — Tarda unas ocho semanas.
• [can.] U krijgt een mail zodra het klaar is. — Recibirá un correo en cuanto esté listo.
• [can.] In drukke periodes kan het langer duren. — En épocas de mucha demanda puede tardar más.
• [geb.] Houdt u rekening met de zomervakantie. — Tenga en cuenta las vacaciones de verano.
• [vraag] Heeft u een spoedaanvraag nodig? — ¿Necesita una solicitud urgente?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuente con ocho a diez semanas. Le avisaremos. (17 · empleado)' AND notes = 'paspoort dialoog 1: 17 empleado - levertijd de 8 a 10 semanas' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuente con ocho a diez semanas. Le avisaremos. (17 · empleado)' AND notes = 'paspoort dialoog 1: 17 empleado - levertijd de 8 a 10 semanas' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 18) yo - ¿me lo envian o lo recojo?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Me lo pueden enviar o tengo que recogerlo? (18 · yo)', 'SENTENCE', 'paspoort dialoog 1: 18 yo - opsturen u ophalen', 'Las dos opciones del final del tramite: ophalen (ir a recogerlo) o het laten opsturen (que te lo manden). Otra vez laten + infinitivo: no lo mandas tu, lo mandan ellos.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: Kan + ik + het + laten opsturen (doble infinitivo al final) + of + moet ik het ophalen.

⚠️ ophalen (ir a por algo o alguien: ik haal mijn paspoort op) vs afhalen (recoger algo ya preparado, tipico de la comida para llevar: afhaalchinees) vs oppikken (recoger de paso, coloquial). Ver tambien la tarjeta de ophalen vs afhalen.

⚠️ opsturen = mandar por correo · versturen = enviar (general) · doorsturen = reenviar · de portokosten = los gastos de envio.

🏋️ Ejercicio: «¿me lo pueden enviar?» → Kan ik het ___ ___? (Respuesta: laten opsturen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Me lo pueden enviar o tengo que recogerlo? (18 · yo)' AND notes = 'paspoort dialoog 1: 18 yo - opsturen u ophalen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me lo pueden enviar o tengo que recogerlo? (18 · yo)' AND notes = 'paspoort dialoog 1: 18 yo - opsturen u ophalen' LIMIT 1),
    'nl_NL', 'Kan ik het laten opsturen of moet ik het ophalen?', 'Kan ik et laten opsturen of mut ik et opalen?',
    '• [vraag] Kunt u het naar mijn huisadres sturen? — ¿Pueden mandarlo a mi domicilio?
• [vraag] Moet ik het persoonlijk ophalen? — ¿Tengo que recogerlo en persona?
• [vraag] Kan iemand anders het voor mij ophalen? — ¿Puede recogerlo otra persona por mí?
• [can.] Ik haal het liever zelf op. — Prefiero recogerlo yo mismo.
• [vraag] Wat zijn de openingstijden om op te halen? — ¿Cuál es el horario de recogida?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me lo pueden enviar o tengo que recogerlo? (18 · yo)' AND notes = 'paspoort dialoog 1: 18 yo - opsturen u ophalen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me lo pueden enviar o tengo que recogerlo? (18 · yo)' AND notes = 'paspoort dialoog 1: 18 yo - opsturen u ophalen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 19) empleado - condicional sin «als» (verbo delante)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Las dos cosas. Si prefiere que se lo enviemos, antes nos manda el pasaporte antiguo. (19 · empleado)', 'SENTENCE', 'paspoort dialoog 1: 19 empleado - condicion sin als y pasaporte viejo', 'Condicional SIN «als»: basta con poner el verbo delante. «Laat u het opsturen, dan...» = si pide que se lo envien, entonces... Es corriente en la lengua hablada y en los avisos oficiales.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: [verbo + sujeto + resto], dan + verbo + sujeto + resto. Laat u het opsturen, dan stuurt u eerst uw oude paspoort op. Equivale a Als u het laat opsturen, dan...

⚠️ Dato real: quien pide que se lo envien por correo tiene que mandar ANTES su pasaporte antiguo al consulado; quien lo recoge en persona lo entrega alli mismo (inleveren).

⚠️ Allebei = los dos, ambos (de dos cosas ya nombradas) · beide (formal) · allebei kan = las dos opciones valen.

🏋️ Ejercicio: «si viene mañana, le ayudo» → ___ u morgen, dan help ik u. (Respuesta: Komt. Verbo delante = condicion.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Las dos cosas. Si prefiere que se lo enviemos, antes nos manda el pasaporte antiguo. (19 · empleado)' AND notes = 'paspoort dialoog 1: 19 empleado - condicion sin als y pasaporte viejo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Las dos cosas. Si prefiere que se lo enviemos, antes nos manda el pasaporte antiguo. (19 · empleado)' AND notes = 'paspoort dialoog 1: 19 empleado - condicion sin als y pasaporte viejo' LIMIT 1),
    'nl_NL', 'Allebei kan. Laat u het opsturen, dan stuurt u eerst uw oude paspoort naar ons op.', 'Allebei kan. Lat u et opsturen, dan sturt u erst uu aude pasport nar ons op.',
    '• [can.] Wilt u het opgestuurd hebben, dan betaalt u extra portokosten. — Si quiere que se lo envíen, paga gastos de envío.
• [can.] Haalt u het zelf op, dan hoeft u niets extra te betalen. — Si lo recoge usted, no paga nada más.
• [can.] U levert uw oude paspoort in bij het ophalen. — Entrega el pasaporte antiguo al recogerlo.
• [can.] Het oude paspoort wordt ongeldig gemaakt. — El pasaporte antiguo se anula.
• [vraag] Wilt u het laten opsturen? — ¿Quiere que se lo enviemos?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Las dos cosas. Si prefiere que se lo enviemos, antes nos manda el pasaporte antiguo. (19 · empleado)' AND notes = 'paspoort dialoog 1: 19 empleado - condicion sin als y pasaporte viejo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Las dos cosas. Si prefiere que se lo enviemos, antes nos manda el pasaporte antiguo. (19 · empleado)' AND notes = 'paspoort dialoog 1: 19 empleado - condicion sin als y pasaporte viejo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 20) yo - ¿cuanto cuesta y puedo pagar con tarjeta?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Cuánto cuesta y puedo pagar con tarjeta? (20 · yo)', 'SENTENCE', 'paspoort dialoog 1: 20 yo - precio y pago con tarjeta', 'Wat kost het? = ¿cuanto cuesta? (con WAT, no con hoeveel, aunque hoeveel kost het tambien vale). Y pagar con tarjeta de debito es PINNEN, el verbo mas holandes que hay.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: Wat + kost (2a posicion) + het. Y la segunda pregunta con modal: kan + ik + met pin + betalen (infinitivo al final).

⚠️ pinnen = pagar con tarjeta de debito (de pinpas, de pinautomaat = el cajero) · contant betalen = pagar en efectivo · met creditcard, que en Paises Bajos no siempre se acepta. En muchos sitios veras «alleen pinnen».

⚠️ Dato real: el precio esta en het overzicht van de consulaire tarieven, distinto por pais; en las visitas itinerantes (Alicante, Canarias) hay un recargo de 26,85 euros.

🏋️ Ejercicio: «¿cuánto cuesta?» → Wat ___ het? (Respuesta: kost.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Cuánto cuesta y puedo pagar con tarjeta? (20 · yo)' AND notes = 'paspoort dialoog 1: 20 yo - precio y pago con tarjeta');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cuánto cuesta y puedo pagar con tarjeta? (20 · yo)' AND notes = 'paspoort dialoog 1: 20 yo - precio y pago con tarjeta' LIMIT 1),
    'nl_NL', 'Wat kost het en kan ik met pin betalen?', 'Uat kost et en kan ik met pin betalen?',
    '• [vraag] Hoeveel kost een nieuw paspoort? — ¿Cuánto cuesta un pasaporte nuevo?
• [vraag] Kan ik contant betalen? — ¿Puedo pagar en efectivo?
• [vraag] Zitten er extra kosten bij? — ¿Hay costes adicionales?
• [vraag] Krijg ik een bewijs van betaling? — ¿Me dan justificante de pago?
• [can.] Ik betaal liever met pin. — Prefiero pagar con tarjeta.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cuánto cuesta y puedo pagar con tarjeta? (20 · yo)' AND notes = 'paspoort dialoog 1: 20 yo - precio y pago con tarjeta' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cuánto cuesta y puedo pagar con tarjeta? (20 · yo)' AND notes = 'paspoort dialoog 1: 20 yo - precio y pago con tarjeta' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 21) empleado - viene en la lista de tarifas consulares
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Viene en la lista de tarifas consulares. Aquí puede pagar con tarjeta. (21 · empleado)', 'SENTENCE', 'paspoort dialoog 1: 21 empleado - tarifas y pinnen', 'STAAN es el verbo de «lo que pone escrito»: het staat in het overzicht = viene en la lista. En espanol usamos «poner» o «venir»; en neerlandes, staan.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: Dat + staat (2a posicion) + in het overzicht van de consulaire tarieven. Con papeles y pantallas: op de website, in de brief, op het formulier.

⚠️ Wat staat er? = ¿que pone? · Er staat dat... = pone que... · Dat staat er niet = eso no lo pone. Nada de «Wat zegt het?» para un texto.

⚠️ het overzicht = el listado, el resumen · de consulaire tarieven = las tasas consulares · de toeslag = el recargo · het bonnetje = el recibo.

🏋️ Ejercicio: «pone en la web» → Dat ___ op de website. (Respuesta: staat.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Viene en la lista de tarifas consulares. Aquí puede pagar con tarjeta. (21 · empleado)' AND notes = 'paspoort dialoog 1: 21 empleado - tarifas y pinnen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Viene en la lista de tarifas consulares. Aquí puede pagar con tarjeta. (21 · empleado)' AND notes = 'paspoort dialoog 1: 21 empleado - tarifas y pinnen' LIMIT 1),
    'nl_NL', 'Dat staat in het overzicht van de consulaire tarieven. U kunt hier pinnen.', 'Dat stat in et ofersijt fan de consulaire tarifen. U kunt ir pinnen.',
    '• [can.] De tarieven staan op de website. — Las tarifas están en la web.
• [can.] Er komt nog een toeslag bij van 26,85 euro. — Se añade un recargo de 26,85 euros.
• [geb.] Pint u maar even. — Pase la tarjeta.
• [can.] U kunt alleen met pin betalen, geen contant geld. — Solo se puede con tarjeta, no en efectivo.
• [vraag] Wilt u een bonnetje? — ¿Quiere el recibo?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Viene en la lista de tarifas consulares. Aquí puede pagar con tarjeta. (21 · empleado)' AND notes = 'paspoort dialoog 1: 21 empleado - tarifas y pinnen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Viene en la lista de tarifas consulares. Aquí puede pagar con tarjeta. (21 · empleado)' AND notes = 'paspoort dialoog 1: 21 empleado - tarifas y pinnen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 22) empleado - recogida en tres meses o se anula
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Puede recogerlo en un plazo de tres meses; si no, se anula. (22 · empleado)', 'SENTENCE', 'paspoort dialoog 1: 22 empleado - plazo de recogida de 3 meses', 'BINNEN drie maanden = dentro de un plazo de tres meses (antes de que pasen). No es lo mismo que OVER drie maanden (dentro de tres meses, el momento). Confundirlos te cuesta el pasaporte.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: U + kunt (modal, 2a posicion) + uw paspoort (objeto) + binnen drie maanden (plazo) + ophalen (infinitivo al final).

⚠️ binnen een week = en menos de una semana (plazo) · over een week = dentro de una semana (el dia que se cumple) · in een week = en una semana (lo que dura hacerlo) · na een week = pasada una semana.

⚠️ Dato real: si no lo recoges en 3 meses, el documento se anula y se destruye (vervallen, vernietigd worden). La recogida en la embajada de Madrid es lunes y viernes de 9:00 a 9:30 y martes y jueves de 14:00 a 14:30.

🏋️ Ejercicio: «vuelvo dentro de tres semanas» → Ik kom ___ drie weken terug. (Respuesta: over. Momento, no plazo.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Puede recogerlo en un plazo de tres meses; si no, se anula. (22 · empleado)' AND notes = 'paspoort dialoog 1: 22 empleado - plazo de recogida de 3 meses');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Puede recogerlo en un plazo de tres meses; si no, se anula. (22 · empleado)' AND notes = 'paspoort dialoog 1: 22 empleado - plazo de recogida de 3 meses' LIMIT 1),
    'nl_NL', 'U kunt uw paspoort binnen drie maanden ophalen, anders vervalt het.', 'U kunt uu pasport binnen dri manden opalen, anders ferfalt et.',
    '• [can.] Na drie maanden wordt het paspoort vernietigd. — A los tres meses se destruye el pasaporte.
• [vraag] Neemt u uw oude paspoort mee als u het ophaalt? — ¿Trae el antiguo cuando venga a recogerlo?
• [can.] U kunt langskomen op maandag en vrijdag tussen negen en half tien. — Puede pasarse lunes y viernes entre las nueve y las nueve y media.
• [geb.] Neemt u deze bon mee bij het ophalen. — Traiga este resguardo al recogerlo.
• [can.] Zonder afspraak kunt u het niet ophalen. — Sin cita no puede recogerlo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Puede recogerlo en un plazo de tres meses; si no, se anula. (22 · empleado)' AND notes = 'paspoort dialoog 1: 22 empleado - plazo de recogida de 3 meses' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Puede recogerlo en un plazo de tres meses; si no, se anula. (22 · empleado)' AND notes = 'paspoort dialoog 1: 22 empleado - plazo de recogida de 3 meses' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 23) yo - entendido, muchas gracias
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Entendido. Muchas gracias por su ayuda. (23 · yo)', 'SENTENCE', 'paspoort dialoog 1: 23 yo - entendido y gracias', 'Duidelijk = claro, entendido (una sola palabra cierra el asunto). Y el agradecimiento formal: hartelijk dank / dank u wel VOOR + lo que agradeces.
@@DIALOOG@@
@@BALIE@@
📐 Estructura: Hartelijk dank + voor + uw hulp. El motivo del agradecimiento siempre con voor, nunca con om.

⚠️ La escala del gracias: bedankt (neutro, corto) · dank je wel (tu) · dank u wel (usted) · hartelijk dank (muy cortes) · heel erg bedankt (con enfasis). Con el funcionario: dank u wel o hartelijk dank.

⚠️ Duidelijk sirve de acuse de recibo. Si NO lo has entendido: Sorry, dat begreep ik niet helemaal. Kunt u het nogmaals uitleggen?

🏋️ Ejercicio: «gracias por su ayuda» → Dank u wel ___ uw hulp. (Respuesta: voor.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Entendido. Muchas gracias por su ayuda. (23 · yo)' AND notes = 'paspoort dialoog 1: 23 yo - entendido y gracias');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Entendido. Muchas gracias por su ayuda. (23 · yo)' AND notes = 'paspoort dialoog 1: 23 yo - entendido y gracias' LIMIT 1),
    'nl_NL', 'Duidelijk. Hartelijk dank voor uw hulp.', 'Daudeleik. Arteleik dank for uu ulp.',
    '• [uitdr.] Dank u wel voor de uitleg. — Gracias por la explicación.
• [can.] Dat is duidelijk, bedankt. — Queda claro, gracias.
• [vraag] Dus ik hoor het van u, klopt dat? — Entonces ya me avisan ustedes, ¿verdad?
• [uitdr.] Fijn, dan wacht ik op bericht. — Bien, entonces espero el aviso.
• [uitdr.] Nogmaals bedankt voor uw tijd. — Gracias de nuevo por su tiempo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Entendido. Muchas gracias por su ayuda. (23 · yo)' AND notes = 'paspoort dialoog 1: 23 yo - entendido y gracias' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Entendido. Muchas gracias por su ayuda. (23 · yo)' AND notes = 'paspoort dialoog 1: 23 yo - entendido y gracias' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 24) empleado - de nada, que tenga buen dia
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'De nada. Que tenga buen día, ¡hasta luego! (24 · empleado)', 'SENTENCE', 'paspoort dialoog 1: 24 empleado - de nada y despedida', 'Graag gedaan = de nada (literalmente «hecho con gusto»). Y la despedida completa de ventanilla: Een prettige dag verder, tot ziens.
@@DIALOOG@@
@@BALIE@@
📐 Formulas fijas, sin sujeto ni verbo conjugado: Graag gedaan · Geen dank · Tot ziens · Fijne dag verder.

⚠️ verder aqui no es «mas lejos»: es «de aqui en adelante», lo que queda de dia. Fijne dag verder = que le vaya bien el resto del dia.

⚠️ Despedidas por registro: tot ziens (formal, la de ventanilla) · dag! (neutra) · doei / doeg (informal) · tot straks (hasta luego, hoy mismo) · tot morgen (hasta manana).

🏋️ Ejercicio: te dan las gracias en el mostrador y respondes → ___ ___. (Respuesta: Graag gedaan.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'De nada. Que tenga buen día, ¡hasta luego! (24 · empleado)' AND notes = 'paspoort dialoog 1: 24 empleado - de nada y despedida');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'De nada. Que tenga buen día, ¡hasta luego! (24 · empleado)' AND notes = 'paspoort dialoog 1: 24 empleado - de nada y despedida' LIMIT 1),
    'nl_NL', 'Graag gedaan. Een prettige dag verder, tot ziens!', 'Jraj jedan. En prettije daj ferder, tot sins!',
    '• [uitdr.] Geen dank, fijne dag! — De nada, ¡buen día!
• [uitdr.] Tot ziens en veel succes. — Hasta luego y mucha suerte.
• [uitdr.] Prettige dag verder, meneer. — Que tenga buen día, señor.
• [uitdr.] Tot over acht weken dan maar. — Hasta dentro de ocho semanas, entonces.
• [geb.] Let u goed op de post. — Esté atento al correo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'De nada. Que tenga buen día, ¡hasta luego! (24 · empleado)' AND notes = 'paspoort dialoog 1: 24 empleado - de nada y despedida' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'De nada. Que tenga buen día, ¡hasta luego! (24 · empleado)' AND notes = 'paspoort dialoog 1: 24 empleado - de nada y despedida' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- BLOQUES COMPARTIDOS
-- Se escriben una sola vez y se inyectan en las 24 tarjetas sustituyendo los
-- marcadores. Idempotente: tras la primera pasada ya no queda ningun marcador,
-- asi que el REPLACE no encuentra nada que cambiar.
-- ==============================================================================

-- El dialogo entero, en orden: cada tarjeta lo lleva porque la sesion las baraja
UPDATE words_es
SET rules_help = REPLACE(rules_help, '@@DIALOOG@@', '🎭 El dialogo completo, en orden (👤 = tu · 🏛️ = el funcionario):
1. 👤 Goedemorgen, ik heb om tien uur een afspraak. — Buenos dias, tengo cita a las diez.
2. 🏛️ Goedemorgen, komt u verder. Waarvoor komt u? — Buenos dias, pase. ¿A que viene?
3. 👤 Ik kom een nieuw paspoort aanvragen, het mijne is verlopen. — Vengo a solicitar un pasaporte nuevo, el mio esta caducado.
4. 🏛️ Mag ik uw afspraakbevestiging en uw oude paspoort zien? — ¿Me deja ver la confirmacion de la cita y su pasaporte antiguo?
5. 👤 Natuurlijk, alstublieft. — Claro, aqui tiene.
6. 🏛️ Neemt u plaats, ik roep u zo op. — Sientese, le llamo enseguida.
7. 🏛️ Nummer vierentwintig, loket twee alstublieft. — Numero veinticuatro, ventanilla dos, por favor.
8. 🏛️ Heeft u het aanvraagformulier ingevuld en ondertekend? — ¿Ha rellenado y firmado el formulario de solicitud?
9. 👤 Ja, ik heb het thuis ingevuld en geprint. — Si, lo he rellenado en casa y lo he impreso.
10. 🏛️ Klopt uw adres nog? Woont u nog steeds in Madrid? — ¿Su direccion sigue siendo correcta? ¿Sigue viviendo en Madrid?
11. 👤 Ja, dat klopt. Ik ben vorig jaar wel verhuisd binnen de stad. — Si, correcto. Aunque el ano pasado si me mude dentro de la ciudad.
12. 🏛️ Mag ik uw pasfoto? Die moet aan de eisen voldoen. — ¿Me da su foto de carnet? Tiene que cumplir los requisitos.
13. 👤 Voldoet deze foto, of moet ik een nieuwe laten maken? — ¿Vale esta foto o tengo que hacerme una nueva?
14. 🏛️ Legt u uw vier vingers op de scanner. En nu uw duim. — Ponga los cuatro dedos en el escaner. Y ahora el pulgar.
15. 🏛️ Zet u hier uw handtekening, binnen het vakje. — Firme aqui, dentro del recuadro.
16. 👤 Hoe lang duurt het voordat het paspoort klaar is? — ¿Cuanto tarda en estar listo el pasaporte?
17. 🏛️ Reken op acht tot tien weken. U krijgt bericht van ons. — Cuente con ocho a diez semanas. Le avisaremos.
18. 👤 Kan ik het laten opsturen of moet ik het ophalen? — ¿Me lo pueden enviar o tengo que recogerlo?
19. 🏛️ Allebei kan. Laat u het opsturen, dan stuurt u eerst uw oude paspoort naar ons op. — Las dos cosas. Si prefiere que se lo enviemos, antes nos manda el pasaporte antiguo.
20. 👤 Wat kost het en kan ik met pin betalen? — ¿Cuanto cuesta y puedo pagar con tarjeta?
21. 🏛️ Dat staat in het overzicht van de consulaire tarieven. U kunt hier pinnen. — Viene en la lista de tarifas consulares. Aqui puede pagar con tarjeta.
22. 🏛️ U kunt uw paspoort binnen drie maanden ophalen, anders vervalt het. — Puede recogerlo en un plazo de tres meses; si no, se anula.
23. 👤 Duidelijk. Hartelijk dank voor uw hulp. — Entendido. Muchas gracias por su ayuda.
24. 🏛️ Graag gedaan. Een prettige dag verder, tot ziens! — De nada. Que tenga buen dia, ¡hasta luego!')
WHERE id IN (
    SELECT word_es_id FROM word_es_groups
    WHERE group_id = (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1')
)
AND rules_help LIKE '%@@DIALOOG@@%';

-- El mapa de vocabulario de la ventanilla + el registro formal + los datos reales
UPDATE words_es
SET rules_help = REPLACE(rules_help, '@@BALIE@@', '🗺️ El vocabulario de la ventanilla (el tramite entero):
• de afspraak = la cita → een afspraak maken (pedir cita), de afspraakbevestiging (la confirmacion), zonder afspraak (sin cita).
• de balie = el mostrador · het loket = la ventanilla · de baliemedewerker = quien atiende · de wachtruimte = la sala de espera.
• het aanvraagformulier = el formulario → invullen (rellenar), printen (imprimir), ondertekenen (firmar).
• de aanvraag = la solicitud · aanvragen = solicitar · vernieuwen = renovar · de spoedaanvraag = la solicitud urgente.
• het reisdocument = el documento de viaje (het paspoort of de ID-kaart).
• de pasfoto = la foto de carnet · de vingerafdrukken = las huellas · de handtekening = la firma · de eisen = los requisitos.
• geldig = valido · verlopen = caducado · kwijt = perdido · gestolen = robado · vervallen = anularse.
• ophalen = recoger en persona · laten opsturen = pedir que te lo manden · inleveren = entregar.
• de levertijd = el plazo de entrega · de consulaire tarieven = las tasas · pinnen = pagar con tarjeta · het bonnetje = el recibo.
⚠️ Un paspoort neerlandes NO se «verlengt»: se solicita uno nuevo (een nieuw paspoort aanvragen / vernieuwen). Verlengen es para un contrato o un permiso.
🎩 Todo el tramite va en «u»: u (usted) y uw (su), y el imperativo cortes pone el u DETRAS del verbo — Neemt u plaats, Komt u verder, Zegt u het maar, Legt u uw vingers op de scanner.
📍 Datos reales (nederlandwereldwijd.nl, Espana): se pide en la ambassade de Madrid o en VFS Global (Madrid y Barcelona), con afspraak online; hay visitas itinerantes a Alicante y Canarias con 26,85 EUR de recargo; la levertijd es de 8 a 10 weken; hay que ophalen binnen 3 maanden o el documento vervalt; quien lo quiera por correo manda antes su paspoort viejo.')
WHERE id IN (
    SELECT word_es_id FROM word_es_groups
    WHERE group_id = (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1')
)
AND rules_help LIKE '%@@BALIE@@%';
