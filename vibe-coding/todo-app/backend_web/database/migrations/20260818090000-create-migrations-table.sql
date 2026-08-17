-- 20260818090000-create-migrations-table
--
-- Tabla de control. SIEMPRE es la primera migracion del proyecto: es el registro
-- que el migrador consulta para saber que ficheros .sql ya se aplicaron.
--
-- Se crea a si misma: en una base nueva el migrador ve que no existe, la aplica
-- como primera migracion y despues anota su propio nombre de fichero dentro.
--
-- IF NOT EXISTS es obligatorio en TODA migracion de este proyecto: el arranque
-- las recorre siempre, y una migracion que no se pueda ejecutar dos veces sin
-- danos tumbaria la app en el segundo arranque.
CREATE TABLE IF NOT EXISTS migrations (
    id         INTEGER PRIMARY KEY,
    file_name  TEXT NOT NULL UNIQUE,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
