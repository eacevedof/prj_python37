-- Learn Languages App - wisselen frente a verwisselen, con ejemplos de sobra (duda de la 866)
-- Migration: 20260831000020-help-wisselen-vs-verwisselen.sql
-- Description: Eduardo, en la 866: «agrega mas ejemplos de wisselen y verwisselen, que me cuesta
--   entender». La tabla de los cuatro «cambiar» ya estaba, pero resumia el par en una linea
--   («verwisselen anade la idea de sustitucion o de confundir») y con eso no basta para elegir en
--   caliente. Se anade un bloque 🔁 IDENTICO byte a byte en las DOS tarjetas del par (863
--   wisselen y 866 verwisselen) con: la idea de fondo — wisselen es INTERCAMBIAR (a proposito y
--   bien hecho) y verwisselen es SUSTITUIR, casi siempre por ERROR, con el mismo ver- de
--   vergissen, verkeerd y verslapen; una tabla de frases reales donde se ve cual pide cada
--   situacion; dos tandas de ejemplos, seis de wisselen y seis de verwisselen, con su traduccion;
--   el regimen, que es lo que de verdad los separa al hablar (wisselen VAN + sustantivo sin
--   articulo · wisselen VOOR para el dinero · verwisselen MET para confundir); los cuatro primos
--   que se cuelan en el mismo hueco (omwisselen en la tienda, inwisselen un vale, uitwisselen
--   informacion, afwisselen turnarse); los sustantivos con su articulo; el aviso de que
--   equivocarse UNO es zich vergissen y confundir COSAS es verwisselen; y un ejercicio con
--   respuestas.
--   100% aditiva e idempotente: UPDATE con guard por marca.

UPDATE words_es
SET rules_help = rules_help || '

🔁 wisselen o verwisselen — el par que mas cuesta
La idea de fondo cabe en una linea: wisselen es INTERCAMBIAR o alternar, a proposito y bien hecho; verwisselen es SUSTITUIR una cosa por otra, y casi siempre por ERROR — confundirlas. Ese ver- es el mismo de zich vergissen (equivocarse), verkeerd (equivocado) o zich verslapen (quedarse dormido): marca que la cosa ha salido torcida.

| la situacion | cual | por que |
|---|---|---|
| Te dan suelto de un billete de cincuenta | **wisselen** | das dinero y recibes dinero: intercambio querido. |
| Te llevas el abrigo de otro sin querer | **verwisselen** | sustitucion equivocada: te has confundido de abrigo. |
| Os cambiais de sitio en el cine | **wisselen** | los dos cambian a la vez, y a proposito. |
| Confundes a los gemelos | **verwisselen** | tomas uno por el otro: error de identificacion. |
| El mecanico te pone los neumaticos de invierno | **verwisselen** | quita unos y pone otros: sustitucion 1x1. |
| El cambio de guardia de las seis | **wisselen** | relevo regular, previsto, sin error. |

🔀 wisselen — intercambiar, alternar, cambiar de:
• Kun je dit briefje van vijftig wisselen? — ¿Me puedes cambiar este billete de cincuenta?
• Ik wissel mijn euro''s voor dollars op het vliegveld. — Cambio mis euros por dolares en el aeropuerto.
• Zullen we van plaats wisselen? — ¿Nos cambiamos de sitio?
• Hij wisselt vaak van baan. — Cambia de trabajo a menudo.
• De wacht wisselt om zes uur. — El cambio de guardia es a las seis.
• We wisselden een blik. — Intercambiamos una mirada.

🔃 verwisselen — sustituir una por otra, y sobre todo CONFUNDIR:
• Ik heb per ongeluk de sleutels verwisseld. — Sin querer me he llevado las llaves cambiadas.
• Sorry, ik verwissel je altijd met je broer. — Perdona, siempre te confundo con tu hermano.
• De monteur heeft de banden verwisseld. — El mecanico ha cambiado los neumaticos (unos por otros).
• Pas op, je hebt de etiketten verwisseld. — Cuidado, has puesto las etiquetas cambiadas.
• In het ziekenhuis werden twee baby''s verwisseld. — En el hospital confundieron a dos bebes.
• Ik verwissel links en rechts nog steeds. — Todavia confundo izquierda y derecha.

📌 El regimen, que es lo que de verdad los separa al hablar:
• wisselen VAN + sustantivo SIN articulo — cambias tu de algo: van plaats, van baan, van kleur, van gedachten wisselen.
• wisselen VOOR — das una cosa y recibes otra equivalente, sobre todo dinero: euro''s wisselen voor dollars.
• verwisselen MET — confundir A con B: Ik verwissel hem met zijn broer. Y para el intercambio de las dos, sin met: de etiketten verwisselen.

🧩 Los cuatro primos que se cuelan en el mismo hueco:
• omwisselen — devolver algo en la tienda y llevarte otro, o cambiar dinero en ventanilla: Kan ik deze trui omwisselen voor een andere maat?
• inwisselen — canjear un vale, unos puntos, un cupon: een bon inwisselen.
• uitwisselen — intercambiar entre dos partes algo que no se pierde: gegevens uitwisselen, ervaringen uitwisselen.
• afwisselen — turnarse o alternar: We wisselen elkaar af achter het stuur. — Nos turnamos al volante. Y el adjetivo afwisselend (variado, alterno).

🗂️ Los sustantivos, con su articulo: het wisselgeld (el cambio, las vueltas) · de wisseling (el relevo, el cambio de turno) · de wisselkoers (el tipo de cambio) · de verwisseling (la confusion, el trueque) · de afwisseling (la variedad — voor de afwisseling = para variar) · het wisselvallige weer (el tiempo inestable). Y el adjetivo verwisselbaar (intercambiable).

⚠️ No lo mezcles con zich vergissen: equivocarse lo hace UNA PERSONA (Ik heb me vergist — me he equivocado) y verwisselen lo hace con COSAS (Ik heb de sleutels verwisseld — he confundido las llaves). Si el sujeto se equivoca, vergissen; si son dos objetos los que se han cruzado, verwisselen.

🏋️ Ejercicio: (a) «¿Me cambias este billete?» → Kun je dit briefje ___? (b) «Siempre confundo a los gemelos» → Ik ___ de tweeling altijd. (c) «¿Nos cambiamos de sitio?» → Zullen we van plaats ___? (d) «¿Puedo cambiar este jersey por otra talla?» → Kan ik deze trui ___ voor een andere maat? (e) «Nos pasamos los datos» → We ___ onze gegevens ___. (Respuestas: wisselen · verwissel · wisselen · omwisselen · wisselen … uit.)',
    updated_at = datetime('now')
WHERE id IN (863, 866)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🔁 wisselen o verwisselen%';
