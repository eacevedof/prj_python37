-- Learn Languages App - Ayuda: vallen/omvallen vs neerzetten/neergaan (tarjeta 622)
-- Migration: 20260811000001-help-vallen-omvallen-vs-neerzetten-neergaan-622.sql
-- Description: Eduardo (622 "De vaas is gevallen") pregunta si vale "is neerzetten" o
--   "neer gegaan". No: son otros verbos. Bloque 🏺: para un objeto que SE CAE va vallen
--   (De vaas is gevallen) o mejor omvallen si estaba de pie y se VOLCO (De vaas is
--   omgevallen), ambos con ZIJN. Falsos amigos: neerzetten = COLOCAR/posar algo
--   (transitivo -> HEBBEN, neergezet; significado opuesto) y neergaan = BAJAR/hundirse
--   (el sol, un barco; descenso controlado, no un objeto que se cae). Card ya aplicada ->
--   migracion nueva. Keyeada por id, idempotente por 🏺, solo rules_help.

PRAGMA foreign_keys = ON;

-- 622 · vallen / omvallen vs neerzetten / neergaan
UPDATE words_es SET rules_help = rules_help || '

🏺 ¿"is neerzetten" o "neer gegaan"? No: para que un objeto SE CAIGA es otro verbo.
- vallen = CAER (general). El correcto aqui: De vaas is gevallen (jarron = sujeto que cambia de posicion, intransitivo -> ZIJN, participio gevallen).
- omvallen = VOLCARSE / caerse de lado algo que estaba DE PIE. Aun mas natural si el jarron estaba erguido y se volco: De vaas is omgevallen (om + vallen, separable, tambien ZIJN). Para una persona que se desploma -> neervallen (Hij is neergevallen = se desplomo).

Falsos amigos (NO valen aqui):
- neerzetten (neer + zetten) = COLOCAR / posar / dejar algo en una superficie. Es lo CONTRARIO (alguien lo pone a proposito). Es transitivo (colocas ALGO) -> va con HEBBEN, no zijn: Ik heb de vaas neergezet = coloque el jarron. Y el participio seria neergezet, no el infinitivo neerzetten.
- neergaan (neer + gaan) = BAJAR / descender / hundirse (el sol, un barco, bajar por una escalera). Es zijn e intransitivo, pero es un descenso controlado/gradual, no un objeto que se cae y se rompe. De vaas is neergegaan sonaria a que el jarron "bajo" suavemente = no es eso.

Resumen: vallen (caer, general) · omvallen (volcarse, de pie->tumbado) · neerzetten = colocar (HEBBEN) · neergaan = bajar/hundirse.'
WHERE id = 622 AND COALESCE(rules_help,'') NOT LIKE '%🏺%';
