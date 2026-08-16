-- Learn Languages App - Ayuda: gestaan (staan) vs geweest (zijn) (tarjeta 629)
-- Migration: 20260811000004-help-gestaan-vs-geweest-629.sql
-- Description: Eduardo (629 "We hebben uren in de file gestaan") pregunta por que gestaan
--   y no geweest. Clave: el espanol "estar" es UN verbo, pero el NL parte el "estar" de
--   ubicacion/postura en staan/liggen/zitten (+ zijn generico). En un atasco estas PARADO
--   -> staan; la colocacion fija es "in de file staan". geweest (de zijn) se entenderia
--   pero pierde el matiz de "detenido/parado" y no es lo idiomatico. Bloque 🚗. Card ya
--   aplicada -> migracion nueva. Keyeada por id, idempotente por 🚗, solo rules_help.

PRAGMA foreign_keys = ON;

-- 629 · staan vs zijn: por que gestaan y no geweest
UPDATE words_es SET rules_help = rules_help || '

🚗 ¿Por que gestaan (de staan) y no geweest (de zijn)? Porque el espanol "estar" es UN solo verbo, pero el neerlandes NO tiene un "estar" generico para la ubicacion: reparte el "estar en un sitio" segun la POSTURA/posicion del sujeto:
- staan = estar de pie / parado / detenido (vertical o inmovil).
- liggen = estar tumbado / en horizontal.
- zitten = estar sentado / metido dentro de algo.
- zijn = solo el "estar" abstracto o de simple presencia/existencia (estar cansado, estar aqui, haber estado en un sitio).

En un atasco el coche (y tu) estais PARADOS/detenidos -> staan. Ademas es una colocacion FIJA: in de file staan = estar en un atasco. Por eso el perfecto es "We hebben uren in de file gestaan" (participio gestaan, con HEBBEN por ser postura, ver arriba).

geweest (participio de zijn) NO es incorrecto gramaticalmente, pero:
- We zijn uren in de file geweest se entiende, pero suena a "hemos ESTADO (presentes) en el atasco" y pierde el matiz de "detenidos, sin avanzar" que da staan. El nativo dice gestaan.
- geweest se reserva para el "estar/haber estado" de presencia: Ik ben in Amsterdam geweest (he estado en Amsterdam), Ben je ooit in Japan geweest?

🅿️ staan tambien para cosas paradas/colocadas: De auto staat voor de deur (el coche esta aparcado en la puerta), Het staat in de krant (viene en el periodico), De vaas staat op tafel (el jarron esta -de pie- en la mesa). Regla mental para "estar en un sitio": de pie/parado -> staan · tumbado -> liggen · sentado/dentro -> zitten · solo presencia/abstracto -> zijn.'
WHERE id = 629 AND COALESCE(rules_help,'') NOT LIKE '%🚗%';
