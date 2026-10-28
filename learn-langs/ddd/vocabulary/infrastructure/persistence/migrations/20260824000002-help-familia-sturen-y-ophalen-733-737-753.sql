-- 733 — la familia completa de «enviar» (sturen / zenden + partícula).
-- 733 / 737 / 753 — la familia completa de «recoger», que en neerlandés son diez verbos distintos.
-- El bloque de recoger es el MISMO en las tres: se marca con @@OPHALEN@@ y se inyecta al final.
-- Idempotente: solo marca si el bloque todavía no está en la ayuda.

UPDATE words_es
SET rules_help = REPLACE(rules_help, '📐 Estructura:', '@@STUREN@@📐 Estructura:'),
    updated_at = datetime('now')
WHERE id = 733
  AND rules_help LIKE '%📐 Estructura:%'
  AND rules_help NOT LIKE '%📮 Enviar son dos verbos%';

UPDATE words_es
SET rules_help = REPLACE(rules_help, '📐 Estructura:', '@@OPHALEN@@📐 Estructura:'),
    updated_at = datetime('now')
WHERE id IN (733, 737, 753)
  AND rules_help LIKE '%📐 Estructura:%'
  AND rules_help NOT LIKE '%🚚 Recoger no es un verbo%';

UPDATE words_es
SET rules_help = REPLACE(
        rules_help,
        '@@STUREN@@',
        '📮 Enviar son dos verbos y unas cuantas partículas:
Raíces solo hay dos: sturen (la de diario) y zenden (la culta y antigua, hoy casi solo viva dentro de compuestos). Todo lo demás es una de esas dos con una partícula delante, y la partícula es la que dice ADÓNDE va la cosa.

| verbo | qué significa exactamente | cuándo se usa |
|---|---|---|
| **sturen** | mandar, a secas | el 90% de las veces: Ik stuur je een appje |
| **zenden** | enviar, culto y formal | suelto casi no se usa; vive en uitzenden, verzenden, de zender |
| **opsturen** | mandar por correo | papeles y paquetes: Ik stuur mijn oude paspoort op |
| **versturen** | cursar, dar salida a algo | el acto administrativo: de post, een e-mail versturen |
| **verzenden** | expedir | el gemelo formal y técnico: el botón del email pone Verzenden |
| **doorsturen** | reenviar | pasárselo a un tercero: Ik stuur je mail door naar Jan |
| **insturen** | enviar a una institución | formularios y concursos: je foto insturen |
| **toesturen** | remitir a alguien | lengua de ventanilla: Wij sturen u de factuur toe |
| **terugsturen** | devolver por correo | Stuur het pakket terug |
| **meesturen** | adjuntar, mandar junto con | Stuur een kopie mee |
| **rondsturen** | mandarlo a todo el mundo | een uitnodiging rondsturen |
| **nasturen** | reexpedir, mandar detrás | de post nasturen na de verhuizing |

🧭 La partícula lo dice todo: op = fuera, camino de un destino · door = más allá, a un tercero · in = hacia dentro de una institución · toe = hacia el destinatario · terug = de vuelta · mee = junto con · rond = en círculo · na = detrás, después.

⚠️ El par que de verdad se confunde: opsturen mira al CAMINO (lo meto en correos y viaja) y versturen o verzenden miran al ACTO de darle salida (ya está cursado). Por eso el paspoort se stuurt op y el e-mail se verstuurt.

🎭 zenden está vivo donde no lo esperas: uitzenden = emitir (radio y tele) · de uitzending = la emisión · het uitzendbureau = la ETT, literalmente la oficina que manda gente fuera · de zender = la emisora y también el emisor.

🗺️ Los sustantivos del envío: de verzending = el envío · de verzendkosten = los gastos de envío · de afzender = el remitente, lo que pones en el sobre · de geadresseerde = el destinatario · de bezorger = el repartidor · bezorgen y afleveren = entregar, que es el otro extremo del viaje.

🧪 Conjugación: sturen es débil y fácil (stuurde, gestuurd) pero zenden es fuerte (zond, zonden, gezonden) y arrastra a verzenden (verzond, verzonden).

'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%@@STUREN@@%';

UPDATE words_es
SET rules_help = REPLACE(
        rules_help,
        '@@OPHALEN@@',
        '🚚 Recoger no es un verbo, son diez:
«Recoger» no existe como palabra en neerlandés: existe ir a por ello, cogerlo del suelo, llevártelo, juntar lo de mucha gente y ordenar la casa, y cada una tiene su verbo. Se elige por la ACCIÓN, nunca por la traducción.

| verbo | la acción exacta | ejemplo |
|---|---|---|
| **ophalen** | ir a por algo o alguien y traerlo | Ik haal je op van het station |
| **afhalen** | recoger algo ya preparado en un mostrador | een afhaalmaaltijd, de afhaalchinees |
| **oppakken** | cogerlo con la mano de una superficie | Pak je jas op |
| **oprapen** | recogerlo del suelo, lo que se ha caído | Raap dat papiertje op |
| **meenemen** | llevártelo contigo cuando te vas | Neem je paraplu mee |
| **inzamelen** | juntar lo que aporta mucha gente | geld inzamelen, oud papier inzamelen |
| **verzamelen** | coleccionar, o reunirse en un sitio | postzegels verzamelen; we verzamelen om negen uur |
| **opruimen** | recoger el cuarto, ordenar | Ruim je kamer op |
| **afruimen** | recoger la mesa después de comer | de tafel afruimen |
| **plukken** | recoger fruta o flores | aardbeien plukken |

🧭 El árbol de decisión, en este orden: voy yo a por ello, ophalen · ya estaba preparado en un mostrador, afhalen · está en el suelo, oprapen · lo cojo con la mano, oppakken · me lo llevo al irme, meenemen · lo aporta mucha gente, inzamelen · es el cuarto o la mesa, opruimen o afruimen.

⚠️ El error típico es usar meenemen por ophalen: meenemen es llevárselo, no ir a buscarlo. Ik haal het paspoort op es voy a recogerlo; Ik neem het paspoort mee es me lo llevo puesto en la mochila.

💎 ophalen tiene tres vidas más que no huelen a recoger: je schouders ophalen = encogerse de hombros · herinneringen ophalen = recordar viejos tiempos, sacar batallitas · een cijfer ophalen = subir una nota.

🎭 Y oppakken tiene una segunda vida muy seria: de politie heeft hem opgepakt = la policía lo ha detenido. También vale por retomar algo: de draad weer oppakken.

🗺️ Los sustantivos de la recogida: het afhaalpunt = el punto de recogida · de ophaaldienst = el servicio de recogida · de inzameling = la colecta · de ophaalbrug = el puente levadizo, que también se levanta con ophalen.

🧪 Conjugación: los de diario son débiles (haalde op, opgehaald · pakte op, opgepakt · ruimde op, opgeruimd) pero meenemen es fuerte: nam mee, meegenomen.

'),
    updated_at = datetime('now')
WHERE rules_help LIKE '%@@OPHALEN@@%';
