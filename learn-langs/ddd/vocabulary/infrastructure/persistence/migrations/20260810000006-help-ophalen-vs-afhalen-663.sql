-- Learn Languages App - Ayuda: ophalen vs afhalen (tarjeta 663)
-- Migration: 20260810000006-help-ophalen-vs-afhalen-663.sql
-- Description: Eduardo (663 "Ik haal jullie om zes uur op" = os recojo a las seis)
--   pregunta por que ophalen y no afhalen. Bloque 🚕: ambos son ...+halen (halen = ir a
--   por/traer); ophalen = recoger a ALGUIEN (personas) o algo, ir a por ello; afhalen =
--   RETIRAR algo ya preparado en un mostrador/punto (comida para llevar, paquete). Para
--   personas -> ophalen (afhalen a personas suena belga/raro en NL estandar). Mismo LOTE
--   pendiente (version se mantiene 1.1.1). Keyeada por id, idempotente por 🚕, solo rules_help.

PRAGMA foreign_keys = ON;

-- 663 · ophalen vs afhalen
UPDATE words_es SET rules_help = rules_help || '

🚕 ¿Por que "ophalen" y no "afhalen"? (recoger)
Los dos son ... + halen (halen = ir a por / traer), pero se reparten asi:
- ophalen = recoger a ALGUIEN o algo, ir a por el/ello y llevartelo. Es el que se usa con PERSONAS: Ik haal jullie om zes uur op = os recojo a las seis. Ik haal de kinderen van school op = recojo a los ninos del cole. Tambien vale para cosas (un paquete: het pakket ophalen).
- afhalen = RETIRAR algo que ya esta LISTO/preparado en un mostrador o punto: comida para llevar (eten afhalen; afhaalchinees = chino para llevar), un paquete o entradas en un punto de recogida. El foco es "retirar lo que ya esta preparado alli".

Clave: para PERSONAS -> ophalen (afhalen con personas suena belga/raro en el NL estandar de Holanda). Para comida-para-llevar o retirar algo ya preparado -> afhalen.
Nota: halen a secas = ir a buscar / traer (Ik haal even een biertje = voy a por una cerveza). El prefijo op/af solo matiza: op = ir a por y llevarselo; af = retirar lo preparado.'
WHERE id = 663 AND COALESCE(rules_help,'') NOT LIKE '%🚕%';
