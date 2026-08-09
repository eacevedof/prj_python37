-- Learn Languages App - Ampliar ayuda del imperativo "Word eens rustig!"
-- Migration: 20260809000007-help-imperative-word-eens-rustig.sql
-- Description: Actualiza el rules_help de la frase 'calmate' (grupo worden) para
--   incorporar la explicacion completa del IMPERATIVO neerlandes surgida en tutoria:
--   (1) por que es "Word" y no "Wordt" (imperativo = stam pura, sin -t; el -t es del
--   presente con jij: jij wordt); (2) una sola forma vale para singular Y plural;
--   (3) el plural arcaico con -t (Wordt/Weest) ya no se usa; (4) alternativa mas
--   idiomatica "Doe eens rustig!" y como marcar grupo con "jullie". Aditiva e
--   idempotente (solo UPDATE de una fila localizada por text+notes). No toca audios.

UPDATE words_es
SET rules_help = 'rustig worden = calmarse / tranquilizarse (cambio de estado). Imperativo: Word eens rustig! = calmate! eens suaviza (venga). Estado ya alcanzado: wees rustig = esta tranquilo.

⚠️ El imperativo: por que "Word" y NO "Wordt":
El imperativo neerlandes = la RAIZ del verbo (stam) sola, SIN terminacion. Por eso es Word! (no Wordt!). El -t que ves en "jij wordt" es del PRESENTE (stam + t con jij/hij), no de la orden. No confundas: jij wordt rustig = te calmas (afirmacion) ≠ Word rustig! = calmate! (orden).

👥 Singular y plural: UNA sola forma:
El imperativo moderno no distingue numero: Word eens rustig! vale igual para una persona o para un grupo. Si quieres marcar el grupo, no cambias el verbo: anades el pronombre → Worden jullie eens rustig! (coloquial, enfatico).
Nota historica: antes existia el plural con -t (Wordt rustig!, Weest welkom!). Hoy suena arcaico/biblico y NO se usa; el actual es Word / Wees.

💡 Mas natural en la calle: para "calmate!" lo mas idiomatico suele ser Doe eens rustig! o simplemente Rustig!

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO (te vuelves / se esta haciendo): Ik word moe = me estoy cansando · Het wordt koud = se esta enfriando.
• zijn = el RESULTADO/estado (ya es / esta): Ik ben moe = estoy cansado · Het is koud = esta frio.
Truco: si en espanol dices «me pongo / me vuelvo / cambio (-arse)» → worden; si dices «estoy / ya es» → zijn. «cansarse» = worden; «estar cansado» = zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Imperativo: Word (1a posicion, stam sin -t) + eens + rustig.

🧭 Cuando usarlo: pedir a alguien que se calme. Ej.: → Word eens rustig, we lossen het op (calmate, lo solucionamos).

🏋️ Ejercicio: «Calmate» (el cambio, orden) → ___ eens rustig! (Respuesta: Word, sin -t.) · «Estate tranquilo» → ___ rustig! (Respuesta: Wees.) · A un grupo, marcando jullie → ___ jullie eens rustig! (Respuesta: Worden.)'
WHERE text = 'calmate' AND notes = 'worden: rustig worden (calmarse, imperativo)';
