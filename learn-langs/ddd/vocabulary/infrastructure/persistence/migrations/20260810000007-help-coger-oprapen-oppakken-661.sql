-- Learn Languages App - Ayuda: coger (oprapen/oppakken/pakken/nemen) vs opnemen (tarjeta 661)
-- Migration: 20260810000007-help-coger-oprapen-oppakken-661.sql
-- Description: Eduardo (661, opnemen) pregunta si opnemen sirve para coger algo del suelo.
--   NO. Bloque 🤲: opnemen no es agarrar un objeto fisico del suelo. Para eso: oprapen
--   (recoger del suelo, algo caido), oppakken (agarrar/levantar con la mano; tb detener),
--   pakken/nemen (coger/tomar general). opnemen se reserva a telefono/grabar/ingresar/sacar
--   dinero/contacto/temperatura/absorber. Mismo LOTE pendiente (version 1.1.1). Keyeada por
--   id, idempotente por emoji-guarda 🤲, solo UPDATE de rules_help.

PRAGMA foreign_keys = ON;

-- 661 · coger algo del suelo != opnemen
UPDATE words_es SET rules_help = rules_help || '

🤲 ¿"opnemen" sirve para coger algo del suelo? NO.
opnemen NO es coger/agarrar un objeto fisico (del suelo, de la mesa). Para eso el neerlandes usa otros verbos:
- oprapen = recoger algo del SUELO (algo caido/tirado): Raap het op = recogelo (del suelo). Ik raapte de pen op = recogi el boligrafo.
- oppakken = coger/AGARRAR y levantar con la mano (mas general): Pak de doos op = coge la caja. (oppakken tambien = detener/arrestar la policia, o asumir una tarea: een taak oppakken.)
- pakken / nemen = coger/tomar en general: Pak een stoel = coge una silla · Neem een koekje = coge una galleta (nemen tira mas a "tomar").
opnemen se reserva para otros sentidos: de telefoon opnemen (contestar), iets/een gesprek opnemen (grabar), iemand opnemen (ingresar en el hospital), geld opnemen (sacar dinero), contact opnemen (ponerse en contacto), de temperatuur opnemen (tomar la temperatura), water opnemen (absorber). En NINGUNO es "agarrar algo del suelo".
Regla: algo en el suelo -> oprapen · agarrar/levantar con la mano -> oppakken · coger/tomar general -> pakken/nemen · el telefono -> opnemen.'
WHERE id = 661 AND COALESCE(rules_help,'') NOT LIKE '%🤲%';
