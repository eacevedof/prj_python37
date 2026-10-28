-- Learn Languages App - Migration
-- Migration: 20260908000008-te-koop-vs-wordt-verkocht
-- Description: Eduardo: "1067 het huis staat te koop vs het huis wordt verkocht" y, sobre
--   esa misma explicacion, "explaya mas cuando usar te koop (ojo no te kopen) te huur etc
--   con q verbos".
--
--   Las dos frases estan en el mazo y se explican la una a la otra: la 1067 (Het huis
--   staat te koop) y la 694 (Dit huis wordt verkocht). La diferencia es la misma que ya
--   recorre el grupo 23: ESTADO frente a PROCESO. staat te koop es que la casa esta
--   disponible, anunciada, con el cartel puesto; wordt verkocht es que la operacion esta
--   en marcha. Y el ciclo se cierra con is verkocht, el resultado.
--
--   El matiz que señala Eduardo es el importante y va destacado: es te KOOP y no «te
--   kopen», porque ahi va el SUSTANTIVO de koop y no el infinitivo. Eso separa dos
--   construcciones que se parecen mucho y que el mazo no distinguia:
--     A) te + SUSTANTIVO — grupo CERRADO de locuciones fijas: te koop, te huur, te leen,
--        te voet, te paard, te gast, te water. No se pueden fabricar nuevas.
--     B) te + INFINITIVO — productiva, con valor de se puede o hay que: te zien, te doen,
--        te krijgen, iets te eten, iets te drinken, niets te verbergen (que ya esta en la
--        781 del mazo).
--
--   Y los verbos con que se usan las del grupo A, que es la otra mitad de la pregunta:
--   staan (el estado, con el cartel puesto), zijn (el estado neutro), zetten (la accion de
--   ponerlo en venta) y aanbieden (ofrecerlo, formal). La pareja staan/zetten es la misma
--   del grupo 24 de variantes de poner.
--
--   Las dos tarjetas se llevan la explicacion, cruzada, para que se lean desde cualquiera.
--   No se toca ningun texto ni traduccion: ningun audio queda afectado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. La 1067: te koop, y todo lo que va con te
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

❓ La duda que trajo esta tarjeta: Het huis staat te koop frente a Het huis wordt verkocht.

🔑 La diferencia es ESTADO frente a PROCESO, la misma que recorre todo el grupo de worden. staat te koop dice que la casa esta disponible, anunciada, con el cartel puesto. wordt verkocht dice que la operacion esta en marcha.

| frase | que dice | fase |
|---|---|---|
| Het huis **staat te koop**. | Está en venta, se ofrece. | disponible |
| Ik **zet** mijn huis **te koop**. | Lo pongo en venta. | la accion de anunciarlo |
| Het huis **wordt verkocht**. | Se está vendiendo, se venderá. | operación en marcha |
| Het huis **is verkocht**. | Está vendida, ya se vendió. | resultado |

⚠️ Y el matiz que mas se falla: es te KOOP, nunca «te kopen». Ahi va el SUSTANTIVO de koop (la venta, la compra), no el infinitivo kopen. Lo mismo con te huur, que es de huur y no huren.

🎭 Porque hay DOS construcciones con te que se parecen y no son la misma:

| construccion | que es | ejemplos |
|---|---|---|
| **te + SUSTANTIVO** | grupo cerrado, locuciones fijas | **te koop**, **te huur**, **te leen**, **te voet** |
| **te + INFINITIVO** | productiva, vale se puede o hay que | **te zien**, **te doen**, **te krijgen** |

📋 Las de te + SUSTANTIVO son estas y no hay mas, asi que se aprenden de memoria:
• te koop — en venta. Het huis staat te koop.
• te huur — en alquiler. Het appartement is te huur.
• te leen — prestado, o para prestar. Dat boek is te leen.
• te voet — a pie. We gingen te voet.
• te paard — a caballo.
• te gast — de invitado. Hij was te gast bij ons.
• te water — al agua. De auto raakte te water.

📋 Las de te + INFINITIVO si son productivas, y significan que algo se puede o esta por hacer:
• Er is niets te zien. — No hay nada que ver.
• Dat is niet te doen. — Eso no se puede hacer.
• Het is niet te krijgen. — No se consigue.
• Wil je iets te drinken? — ¿Quieres algo de beber?
• Ik heb niets te verbergen. — No tengo nada que ocultar. (ya en la 781)

🔧 Y con que VERBOS van las del primer grupo, que es la otra mitad de la pregunta:

| verbo | que aporta | ejemplo |
|---|---|---|
| **staan** | el estado, con el cartel puesto | Het huis **staat** te koop. |
| **zijn** | el estado, neutro y general | Het huis **is** te koop. |
| **zetten** | la accion de ponerlo en venta | Ik **zet** het huis te koop. |
| **aanbieden** | ofrecerlo, formal y de anuncios | Het wordt te koop **aangeboden**. |
| **komen** | que saldra a la venta | Het **komt** binnenkort te koop. |

🪞 Fijate en que staan y zetten vuelven a repartirse como en el grupo de variantes de poner: staan es estar puesto y zetten es ponerlo. Het huis STAAT te koop (esta anunciado) frente a Ik ZET het huis te koop (lo anuncio yo).

🏘️ Y el vocabulario que veras en los carteles de cualquier calle holandesa: TE KOOP y TE HUUR en letras grandes, de makelaar (el agente inmobiliario), de vraagprijs (el precio de salida), de bezichtiging (la visita), onder bod (con oferta) y verkocht onder voorbehoud (vendido con reservas).

🏋️ Ejercicio: «pongo el coche en venta» y «el coche esta en venta» → Ik ___ de auto te koop. De auto ___ te koop. (Respuestas: zet · staat.)'
WHERE id = 1067
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%❓ La duda que trajo esta tarjeta%';

-- =============================================================================
-- 2. La 694, su pareja: se explica desde el otro lado
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🔁 Esta frase tiene una hermana en el mazo, y conviene leerlas juntas: la 1067, Het huis staat te koop.

🔑 La diferencia es ESTADO frente a PROCESO. staat te koop es que la casa esta disponible y anunciada; wordt verkocht, esta frase, es que la operacion esta en marcha o va a ocurrir. Y el ciclo cierra con is verkocht, el resultado.

| frase | que dice | fase |
|---|---|---|
| Het huis **staat te koop**. | Está en venta, se ofrece. | disponible |
| Ik **zet** het huis **te koop**. | Lo pongo en venta. | la accion de anunciarlo |
| Dit huis **wordt verkocht**. | Se está vendiendo, se venderá. | operación en marcha |
| Het huis **is verkocht**. | Está vendida, ya se vendió. | resultado |

⚠️ Ojo a la ultima fila, que es donde el neerlandes ahorra: el perfecto de la pasiva NO lleva geworden. Se dice Het huis is verkocht y no «is verkocht geworden». Por eso is verkocht sirve a la vez para esta vendida (estado) y para ha sido vendida (perfecto): el contexto los separa.

📐 Y el orden de la pasiva: worden se conjuga en su sitio de siempre, en segunda posicion, y el participio se va AL FINAL. Dit huis WORDT verkocht. Con complementos en medio: Dit huis wordt volgende maand verkocht.

🏘️ El detalle practico: en un cartel de la calle veras TE KOOP, no «wordt verkocht». El cartel anuncia un estado, no una operacion en curso.

🏋️ Ejercicio: «la casa ya se ha vendido» → Het huis ___ ___. (Respuesta: is verkocht, sin geworden.)'
WHERE id = 694
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🔁 Esta frase tiene una hermana%';
