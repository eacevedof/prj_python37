-- {{marca_de_tiempo}}-create-{{tabla}}
--
-- <que hace esta migracion y por que>
--
-- IF NOT EXISTS es OBLIGATORIO: el arranque recorre todas las migraciones cada
-- vez, y una que no se pueda ejecutar dos veces tumbaria la aplicacion.
CREATE TABLE IF NOT EXISTS {{tabla}} (
    id          INTEGER PRIMARY KEY,
    -- <tus columnas>
    -- SQLite no tiene BOOLEAN: usa INTEGER con CHECK (x IN (0, 1))
    -- SQLite no tiene DATE:    usa TEXT en formato ISO 'YYYY-MM-DD'
    insert_date TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    delete_date TEXT DEFAULT NULL      -- borrado logico
);

-- Un indice por cada columna por la que filtres a menudo.
CREATE INDEX IF NOT EXISTS {{tabla}}_delete_date_idx ON {{tabla}} (delete_date);
