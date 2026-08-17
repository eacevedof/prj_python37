-- 20260818090500-create-app-lists
--
-- Lista de tareas.
--
-- CONVENCION DE NOMBRES: las tablas de la aplicacion llevan prefijo `app_`. Asi
-- se distinguen de un vistazo de las tablas de infraestructura (`migrations`) y
-- de las que pudiera crear una libreria de terceros.
--
-- COLUMNAS DE AUDITORIA: solo tres, y cada una se gana el sitio.
--   insert_date  la interfaz ordena "mas recientes primero"
--   update_date  la interfaz muestra "modificada hace X"
--   delete_date  BORRADO LOGICO. Es lo que permite borrar una lista sin romper
--                la clave ajena de sus tareas ni perder el historial. Una fila
--                con delete_date != NULL esta borrada para la aplicacion, pero
--                sigue existiendo en la base.
--
-- Toda consulta de lectura tiene que filtrar por `delete_date IS NULL`. Si se te
-- olvida, veras filas borradas.
--
-- La clave primaria es INTEGER PRIMARY KEY (sin AUTOINCREMENT): en SQLite eso ya
-- es un id autoincremental. AUTOINCREMENT solo anade coste y una tabla interna.
CREATE TABLE IF NOT EXISTS app_lists (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL,
    color       TEXT    DEFAULT NULL,           -- hex '#RRGGBB', decorativo
    position    INTEGER NOT NULL DEFAULT 0,     -- orden manual en la interfaz
    insert_date TEXT    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date TEXT    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    delete_date TEXT    DEFAULT NULL
);

-- Nombre unico, pero SOLO entre las listas vivas: es un indice PARCIAL (la
-- clausula WHERE del final). Sin esa clausula no podrias reutilizar el nombre de
-- una lista que borraste.
CREATE UNIQUE INDEX IF NOT EXISTS app_lists_name_uq
    ON app_lists (lower(name)) WHERE delete_date IS NULL;

CREATE INDEX IF NOT EXISTS app_lists_delete_date_idx ON app_lists (delete_date);
