-- Learn Languages App - Migration
-- Migration: 20260907000005-zullen-propuesta-y-openen
-- Description: Dos dudas de Eduardo seguidas, las dos sobre el mismo bloque de tarjetas.
--   (1) Sobre la 282 (Zullen we even pauze nemen? = ¿Hacemos una pausa?): "pq zullen no
--   se asume como haremos una pausa? sino en presente hacemos una pausa?". La respuesta:
--   zullen tiene tres vidas y solo una es futuro. En PREGUNTA y con we o ik deja de mirar
--   al futuro y se vuelve propuesta (Zullen we…? ¿hacemos…?) u ofrecimiento (Zal ik…?
--   ¿abro…?), igual que el Shall we…? del ingles frente a I will… Y la traduccion
--   española va en presente porque el español tambien propone en presente: ¿haremos una
--   pausa? ya no seria propuesta sino prediccion. De propina, el futuro de verdad en
--   neerlandes se dice casi siempre con presente mas marcador de tiempo (Ik ga morgen
--   naar Amsterdam), y zullen como futuro puro suele añadir promesa o suposicion.
--   El mazo tenia 17 tarjetas con Zullen we / Zal ik (204, 205, 206, 281, 282, 284, 285,
--   286, 288, 289, 290, 291, 292, 412, 533, 535, 592) y NINGUNA lo explicaba: todas
--   llevaban solo el bloque generico de la pregunta si/no. Se les inyecta el bloque.
--
--   (2) Sobre la 289 (Zal ik het raam opendoen? = ¿Abro la ventana?): "no puede ser
--   openen? tiene que ser opendoen?". Si se puede decir openen y no esta mal, pero suena
--   a registro escrito; con ventana o puerta, hablando, es opendoen. Se le escribe a la
--   289 el reparto de los cuatro: opendoen (puerta y ventana, dia a dia), openmaken (algo
--   envuelto o cerrado), openen (formal o abstracto: rekening, bestand, vergadering) y
--   opengaan (abrirse solo). Con la nota de que los tres primeros son separables y openen
--   no, y con los antonimos.
--
--   Todas las tarjetas afectadas tenian ya rules_help (ninguna a NULL), asi que se
--   concatena con guard por emoji-marca. No se toca ningun texto ni traduccion: ningun
--   audio queda afectado.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. Bloque compartido: zullen no siempre es futuro
--    A las 17 tarjetas construidas con Zullen we…? o Zal ik…?
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🎯 zullen no siempre es futuro, y aqui no lo es:

zullen tiene tres vidas, y lo que decide cual es la persona y si va en pregunta.

| forma | que es | ejemplo |
|---|---|---|
| **Zullen we…?** | propuesta, 1a plural en pregunta | **Zullen we** even pauze nemen? |
| **Zal ik…?** | ofrecimiento, 1a singular en pregunta | **Zal ik** het raam opendoen? |
| **Ik zal…** | promesa, o futuro con compromiso | **Ik zal** het doen. |
| **Het zal wel…** | suposicion | **Het zal wel** regenen. |

🔑 El truco que lo resuelve: En pregunta y con we o ik, zullen deja de mirar al futuro y se vuelve una propuesta sobre el momento. Es el mismo reparto que el ingles Shall we…? frente a I will… Por eso Zullen we pauze nemen? es ¿hacemos una pausa? y no ¿haremos una pausa?

⚠️ Y por eso la traduccion española va en PRESENTE: el español tambien propone en presente (¿hacemos?, ¿pedimos?, ¿vamos?, ¿quedamos?). Decir ¿haremos una pausa? ya no seria proponer, seria predecir o dudar. Las dos lenguas coinciden aqui, aunque el verbo neerlandes parezca de futuro.

📋 El reparto por persona, que es lo que hay que memorizar:
• Zullen we…? — ¿hacemos…?, ¿y si…? Propone algo para los dos.
• Zal ik…? — ¿quieres que…?, ¿…? Se ofrece uno mismo.
• Zal jij…? — apenas se usa. Para pedirle algo a otro se dice Kun je… of Wil je…
• Zullen jullie…? — tampoco. Para eso, Gaan jullie…?

🕐 Y el futuro de verdad, que es lo que mas descoloca: en neerlandes casi siempre se dice con PRESENTE mas un marcador de tiempo. Ik ga morgen naar Amsterdam es a la vez mañana voy y mañana ire. zullen como futuro puro es bastante menos frecuente de lo que un hispanohablante espera, y cuando aparece suele añadir promesa (Ik zal het doen, lo hare, te lo prometo) o suposicion (Hij zal wel ziek zijn, estara enfermo).'
WHERE id IN (204, 205, 206, 281, 282, 284, 285, 286, 288, 289, 290, 291, 292, 412, 533, 535, 592)
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🎯 zullen no siempre es futuro%';

-- =============================================================================
-- 2. La 289: openen, opendoen, openmaken o opengaan
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🚪 openen, opendoen, openmaken o opengaan:

Zal ik het raam openen? se puede decir y no esta mal, pero suena a acta de reunion. Para una ventana o una puerta, hablando, es opendoen.

| verbo | cuando | ejemplo |
|---|---|---|
| **opendoen** | puerta y ventana, dia a dia | **Doe** je even **open**? |
| **openmaken** | algo envuelto, cerrado o precintado | **Maak** het cadeau **open**. |
| **openen** | formal, escrito o abstracto | een rekening **openen** |
| **opengaan** | abrirse solo, sin que nadie lo abra | De deur **gaat open**. |

📌 Regla de bolsillo:
• ¿Puerta o ventana, y estas hablando? → opendoen.
• ¿Algo envuelto, cerrado o precintado, como un regalo o una lata? → openmaken.
• ¿Una cuenta, un archivo, una tienda o un acto? → openen.
• ¿Se abre solo? → opengaan.

⚠️ Los tres primeros son separables y se parten: Ik doe het raam open, Ik maak het pakje open, De deur gaat open. openen NO es separable: Ik open de vergadering, y su participio es geopend, sin nada metido dentro.

💬 Y la frase que oiras en cuanto llamen al timbre: Doe je even open? — ¿abres tu? Ahi nadie dice «open je even?».

🔁 Los antonimos, con el mismo reparto: dichtdoen (cerrar la puerta o la ventana), dichtmaken (cerrar algo que se abrio), sluiten (formal, y el de los comercios: De winkel sluit om zes uur) y dichtgaan (cerrarse solo).'
WHERE id = 289
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🚪 openen, opendoen, openmaken o opengaan%';
