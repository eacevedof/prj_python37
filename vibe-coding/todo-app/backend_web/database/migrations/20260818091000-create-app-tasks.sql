-- 20260818091000-create-app-tasks
--
-- Tarea. Pertenece SIEMPRE a una lista: `id_list` es NOT NULL y apunta a
-- app_lists. Esa regla se defiende en dos sitios a la vez, y hacen falta los dos:
--
--   1. Aqui, con la clave ajena (REFERENCES). Es la red de seguridad del motor.
--      OJO: solo actua si la conexion trae `PRAGMA foreign_keys = ON`, que se
--      aplica en create_connection(). Sin ese PRAGMA esta linea es decorativa.
--   2. En el caso de uso CreateTask, que pregunta si la lista existe ANTES de
--      insertar, para poder devolver un 404 con un mensaje util en vez de dejar
--      que reviente el motor con un error de integridad.
--
-- No hay ON DELETE CASCADE a proposito: el borrado es logico, la fila de
-- app_lists nunca desaparece de verdad.
--
-- SQLite no tiene tipo BOOLEAN. `is_done` es 0 o 1, y el CHECK impide que alguien
-- meta un 2 o la cadena "si".
CREATE TABLE IF NOT EXISTS app_tasks (
    id          INTEGER PRIMARY KEY,
    id_list     INTEGER NOT NULL REFERENCES app_lists(id),
    title       TEXT    NOT NULL,
    description TEXT    DEFAULT NULL,
    is_done     INTEGER NOT NULL DEFAULT 0 CHECK (is_done IN (0, 1)),
    due_date    TEXT    DEFAULT NULL,           -- ISO-8601 'YYYY-MM-DD'
    position    INTEGER NOT NULL DEFAULT 0,
    insert_date TEXT    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date TEXT    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    delete_date TEXT    DEFAULT NULL
);

-- "las tareas vivas de esta lista, en orden" es LA consulta de la aplicacion:
-- un indice compuesto por sus tres columnas de filtro y orden.
CREATE INDEX IF NOT EXISTS app_tasks_list_idx     ON app_tasks (id_list, delete_date, position);
CREATE INDEX IF NOT EXISTS app_tasks_is_done_idx  ON app_tasks (is_done);
CREATE INDEX IF NOT EXISTS app_tasks_due_date_idx ON app_tasks (due_date);
