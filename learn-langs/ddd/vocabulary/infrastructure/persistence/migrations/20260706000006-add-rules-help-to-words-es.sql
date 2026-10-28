-- Learn Languages App - Reglas de uso por palabra (ayuda gramatical)
-- Migration: 20260706000006-add-rules-help-to-words-es.sql
-- Description: Anade words_es.rules_help: explicacion de cuando y como se usa
--   la palabra/estructura. Se muestra en el Aprendizaje con el boton de ayuda
--   (modal). Rellena las reglas del grupo "zullen" y de las estructuras
--   gramaticales explicadas (pasivo impersonal, die/het/er, nog/meer, ooit,
--   suavizadores even/wat, hartstikke).

ALTER TABLE words_es ADD COLUMN rules_help TEXT;

-- ==============================================================================
-- GRUPO ZULLEN (localizadas por texto: ids nuevos no son estables en rebuilds)
-- ==============================================================================

UPDATE words_es SET rules_help = 'ZULLEN WE...? = fórmula fija para PROPONER planes (no es futuro).
El español propone con presente («¿comemos algo?»); el neerlandés, con zullen.
• Zullen we gaan? — ¿Nos vamos?
• Zullen we even pauze nemen? — ¿Hacemos una pausa?
Ojo: el presente neerlandés (Eten we wat?) NO propone: confirma un plan ya acordado. Para sugerir algo nuevo, siempre «Zullen we...?» (como el inglés shall we?).
Familia de zullen: ofrecimiento (Zal ik...?), promesa (Ik zal...), probabilidad (zal wel) y su pasado ZOU (cortesía/hipótesis/duda).' WHERE text = '¿comemos algo?';

UPDATE words_es SET rules_help = 'ZULLEN WE + infinitivo al final = propuesta.
Orden: Zullen we [tiempo] [manera] [lugar] + INFINITIVO?
• Zullen we morgen met de fiets naar het strand gaan?
El verbo principal (gaan, eten...) se va al FINAL: paréntesis verbal.
«Zullen we maar?» (con maar) = ¿empezamos entonces?, para ponerse en marcha.
Para el futuro neutro NO se usa zullen: presente + tiempo (Ik kom morgen).' WHERE text = '¿nos vamos?';

UPDATE words_es SET rules_help = 'ZAL IK...? = OFRECIMIENTO en 1ª persona (¿hago yo...?).
• Zal ik koffie zetten? — ¿Preparo café?
• Zal ik je ophalen? — ¿Te recojo?
Es la manera educada y natural de ofrecerse; el español usa presente.
Conjugación de zullen: ik zal, jij zult (¿zul je?), hij/zij zal, wij/jullie/zij zullen. Pasado: zou/zouden.
«Zal ik maar?» = ¿lo hago yo, entonces? (con resignación amable).' WHERE text = '¿te ayudo?';

UPDATE words_es SET rules_help = 'IK ZAL... = PROMESA o compromiso firme (más fuerte que el futuro normal).
• Ik zal het morgen doen. — Lo haré mañana (palabra dada).
• Ik zal eraan denken. — Me acordaré.
Para futuro neutro el neerlandés prefiere PRESENTE + tiempo: Ik doe het morgen.
Usa «ik zal» cuando prometes o te comprometes; si solo informas de un plan, presente.
En subordinada, zal se va al final con el resto: ...dat ik het morgen zal doen.' WHERE text = 'lo haré mañana';

UPDATE words_es SET rules_help = 'IK ZAL ER ZIJN = promesa clásica («cuenta conmigo»).
ER aquí = allí (locativo átono): estar presente en el sitio del que se habla.
• Om acht uur zal ik er zijn. — A las ocho estaré allí (inversión: tiempo delante → verbo antes del sujeto).
Compara: Ik ben er om acht uur (presente = plan neutro) vs Ik zal er zijn (compromiso).
Pregunta con promesa pedida: Zul je er echt zijn? — ¿De verdad estarás?' WHERE text = 'estaré allí';

UPDATE words_es SET rules_help = 'DAT ZAL WEL = probabilidad/resignación: «será eso, supongo».
ZAL + WEL suaviza a suposición; a secas y con tono seco es escéptico («ya, claro»).
• Het zal wel goedkomen. — Ya se arreglará.
• Het zal wel weer aan mij liggen. — Seguro que otra vez es culpa mía (irónico).
Muy usado como respuesta mínima: — Hij zei dat hij ziek was. — Dat zal wel...
No confundir con «dat zal» (raro solo): la pareja zal+wel es la que da el matiz.' WHERE text = 'será eso, supongo';

UPDATE words_es SET rules_help = 'ZAL WEL + adjetivo/frase = SUPOSICIÓN sobre el presente («estará...»).
El español usa futuro para suponer (estará cansado); el neerlandés zal wel.
• Ze zal wel in de file staan. — Estará en el atasco.
• Het zal wel duur zijn. — Será caro, imagino.
Estructura: sujeto + zal + wel + resto + INFINITIVO al final (zijn/staan...).
Sin «wel», zal suena a futuro/promesa; con «wel», a conjetura.' WHERE text = 'estará cansado';

UPDATE words_es SET rules_help = 'WE ZULLEN ZIEN = frase hecha: «ya veremos».
Variantes: We zullen wel zien (con wel, más resignado) · Dat zullen we nog weleens zien! (desafío: ¡eso ya lo veremos!) · Wie zal het zeggen? — ¿quién sabe?
Es de los pocos usos donde zullen sí suena a futuro puro, fosilizado en frase hecha.
Como respuesta evasiva es oro: — ¿Vendrás? — We zullen zien.' WHERE text = 'ya veremos';

UPDATE words_es SET rules_help = 'ZOU JE...? = CORTESÍA (condicional de zullen): ¿podrías...?
• Zou je me kunnen helpen? — ¿Podrías ayudarme?
• Zou je het raam dicht willen doen? — ¿Te importaría cerrar la ventana?
Escala de cortesía: Doe het raam dicht (orden) < Kun je...? (petición) < Zou je... kunnen/willen...? (muy educado).
Con «u» formal: Zou ik u iets mogen vragen? — ¿Podría preguntarle algo?
Estructura: Zou je + [petición] + kunnen/willen + INFINITIVO al final.' WHERE text = '¿podrías ayudarme?';

UPDATE words_es SET rules_help = 'ZOU = CONDICIONAL: «sería, haría...» (equivale a nuestro -ría).
• Dat zou leuk zijn! — ¡Sería genial!
• Wat zou jij doen? — ¿Tú qué harías?
• Als ik jou was, zou ik het doen. — Yo que tú, lo haría (condicional con als).
Plural: zouden (We zouden graag komen — nos encantaría venir).
«Ik zou graag... willen» = fórmula estrella para pedir con educación en tiendas y bares.' WHERE text = 'sería genial';

UPDATE words_es SET rules_help = 'ZOU + pregunta = DUDA/especulación: «¿vendrá? (me lo pregunto)».
• Zou het gaan regenen? — ¿Lloverá? (quién sabe)
• Zou ze het al weten? — ¿Lo sabrá ya?
No pide información al oyente: piensa en voz alta. Compara:
• Komt hij met Kerst? — pregunta real de información (presente + tiempo).
• Zal hij komen, denk je? — pide tu opinión/expectativa.
• Zou hij komen? — pura especulación.
«Het zou kunnen» = podría ser.' WHERE text = '¿vendrá?';

UPDATE words_es SET rules_help = 'JE ZULT WEL MOETEN = obligación resignada: «no te quedará otra».
zullen + moeten: el futuro convierte la obligación en inevitable.
• We zullen vroeg op moeten staan. — Tendremos que madrugar.
• Er zal iets moeten veranderen. — Algo tendrá que cambiar.
Jij admite zult o zal (je zult/je zal); invertido siempre sin -t: zul je?
Como réplica seca: — Moet dat echt? — Je zult wel moeten! (¡no queda otra!).' WHERE text = 'no te quedará otra';

-- ==============================================================================
-- ESTRUCTURAS EXPLICADAS EN SESIONES (ids estables, fijados por el snapshot)
-- ==============================================================================

-- 141: han entrado a robar -> er is ingebroken (pasivo impersonal)
UPDATE words_es SET rules_help = 'ER IS INGEBROKEN = pasivo IMPERSONAL: «se ha entrado a robar».
«Er» es un sujeto vacío (como el it de it rains): la frase omite a propósito quién lo hizo. Sin sujeto real, el verbo va SIEMPRE en singular: er IS ingebroken (nunca «er zijn»), aunque fueran cinco ladrones.
Mismo patrón: Er wordt gedanst (se baila) · Er wordt aangebeld (llaman a la puerta).
Si quieres nombrar a «ellos», voz activa: Ze hebben (bij ons) ingebroken.
Se usa el impersonal cuando no sabes quién fue (lo normal en un robo).' WHERE id = 141;

-- 143: lo regale -> heb ik weggegeven (die/het/er)
UPDATE words_es SET rules_help = 'RETOMAR UNA COSA YA MENCIONADA: depende del género de la palabra.
• palabra-DE (de jas) → DIE o HEM: Waar is je jas? Heb je die/hem weggegeven?
• palabra-HET (het boek) → HET o DAT: Heb je het/dat weggegeven?
• plural → DIE o ZE.
«Hem» para objetos-de es normalísimo en el habla (aunque sea una cosa).
Adelantar «die» es puro neerlandés: Die heb ik weggegeven — Ese lo regalé.
ER nunca es objeto directo solo; solo con cantidad: Heb je er een weggegeven? — ¿Has regalado uno (de ellos)?' WHERE id = 143;

-- 147: en serio, deberias comer algo -> je moet echt even wat eten (even/wat)
UPDATE words_es SET rules_help = 'EVEN y WAT = suavizadores estrella del neerlandés hablado.
• even = un momento, sin dramas: Kom even hier — ven un segundo.
• wat = algo, un poco (informal de iets): even wat eten — comer algo rápido.
Sin ellos la frase suena a orden seca: Je moet eten (¡tienes que comer!).
Con ellos, a consejo amable: Je moet echt even wat eten.
NOG añade «todavía»: Je hebt nog niets gegeten = aún no has comido nada (el día sigue y se espera que comas); sin nog es solo un hecho cerrado.' WHERE id = 147;

-- 150: acaban de llegar -> ze zijn hier pas nieuw (pas / ooit)
UPDATE words_es SET rules_help = 'PAS = recién / hace poco: ze zijn hier pas nieuw — acaban de llegar.
También «no antes de»: pas om negen uur — no hasta las nueve.
OOIT vs EEN KEER vs EENS (los tres se traducen «una vez»):
• ooit = momento indefinido (¿alguna vez? / algún día / en su día): Wij waren hier ook ooit pas nieuw. Ben je ooit in Spanje geweest?
• een keer = contando veces (1 vez, otra vez): Ik ben er maar één keer geweest.
• eens = ooit literario (Er was eens... érase una vez) o partícula suave (Kom eens hier).
Truco: si encaja «en su día/alguna vez» → ooit; si encaja «N veces» → een keer.' WHERE id = 150;

-- 156: ya nunca -> nooit meer (nog/meer)
UPDATE words_es SET rules_help = 'NOG y MEER son espejos: nog = todavía (pendiente), meer = ya no (se acabó).
• nog niet = todavía no ↔ niet meer = ya no: Hij rookt niet meer.
• nog niets = aún nada ↔ niets meer = ya nada: Ik wil niets meer.
• nog nooit = nunca hasta ahora ↔ NOOIT MEER = nunca más: Ik rook nooit meer.
Truco: si en español encaja «todavía/aún» → nog; si encaja «ya no/nunca más» → meer.
Ojo al nog de cantidad (otro más): Wil je nog een koffie? — ¿otro café?' WHERE id = 156;

-- 157: muchisimo -> hartstikke vaak (intensificador)
UPDATE words_es SET rules_help = 'HARTSTIKKE = intensificador coloquial universal («super-», «-ísimo»).
Se pega a casi cualquier adjetivo/adverbio: hartstikke leuk (superdivertido), hartstikke duur (carísimo), hartstikke vaak (muchísimas veces), hartstikke bedankt (¡mil gracias!).
Registro informal pero educado: se oye a diario en toda Holanda.
Alternativas: heel (neutro), erg (bastante formal), super (juvenil), ontzettend (enorme).
Curiosidad: viene de «hartstikke dood» (muerto del todo, con el corazón parado).' WHERE id = 157;
