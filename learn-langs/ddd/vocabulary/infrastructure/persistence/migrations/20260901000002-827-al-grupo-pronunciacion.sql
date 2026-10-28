-- Learn Languages App - la 827 entra en el grupo de pronunciación
-- Migration: 20260901000002-827-al-grupo-pronunciacion.sql
-- Description: Eduardo pide añadir la 827 (El perro detecta el peligro antes que nosotros /
--   De hond bespeurt gevaar eerder dan wij) al grupo «pronunciacion - palabras que se pegan al
--   hablar». La tarjeta ya trae la pronunciación en el estilo del grupo (De hont bespeurt jefar
--   erder dan uei) y ya pertenece a generic y a palabras difíciles; aquí solo se añade la
--   membresía. 100% aditiva e idempotente (INSERT OR IGNORE).

PRAGMA foreign_keys = ON;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El perro detecta el peligro antes que nosotros.' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
