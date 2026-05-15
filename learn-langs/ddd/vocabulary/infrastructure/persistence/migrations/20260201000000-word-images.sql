-- Learn Languages App - Word Images
-- Migration: 002_word_images.sql

PRAGMA foreign_keys = ON;

-- Imagenes asociadas a palabras (1:N)
-- Una palabra puede tener multiples imagenes de distintas fuentes
CREATE TABLE IF NOT EXISTS word_es_images (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    word_es_id INTEGER NOT NULL,

    -- Tipo de fuente de la imagen
    source_type TEXT NOT NULL,            -- SCREENSHOT, CLIPBOARD, CAMERA, URL, LOCAL, VECTORIAL

    -- Almacenamiento
    file_path TEXT NOT NULL,              -- Ruta relativa en data/images/
    original_url TEXT,                    -- URL original si source_type = URL
    original_filename TEXT,               -- Nombre original del archivo

    -- Metadatos de imagen
    mime_type TEXT NOT NULL,              -- image/png, image/jpeg, image/svg+xml, image/webp
    width INTEGER,                        -- Ancho en pixeles (NULL para SVG)
    height INTEGER,                       -- Alto en pixeles (NULL para SVG)
    file_size INTEGER,                    -- Tamano en bytes

    -- Contenido vectorial (para SVG inline)
    svg_content TEXT,                     -- Contenido SVG si es vectorial pequeno

    -- Metadatos descriptivos
    caption TEXT,                         -- Descripcion/pie de imagen
    alt_text TEXT,                        -- Texto alternativo para accesibilidad

    -- Ordenacion y estado
    sort_order INTEGER DEFAULT 0,         -- Orden de visualizacion
    is_primary INTEGER DEFAULT 0,         -- 1 = imagen principal de la palabra
    is_active INTEGER DEFAULT 1,          -- 0 = soft delete

    -- Timestamps
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),

    FOREIGN KEY (word_es_id) REFERENCES words_es(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_word_es_images_word_es_id ON word_es_images(word_es_id);
CREATE INDEX IF NOT EXISTS idx_word_es_images_source_type ON word_es_images(source_type);
CREATE INDEX IF NOT EXISTS idx_word_es_images_is_primary ON word_es_images(is_primary);

-- Trigger para asegurar solo una imagen primaria por palabra
CREATE TRIGGER IF NOT EXISTS trg_word_es_images_single_primary
AFTER INSERT ON word_es_images
WHEN NEW.is_primary = 1
BEGIN
    UPDATE word_es_images
    SET is_primary = 0, updated_at = datetime('now')
    WHERE word_es_id = NEW.word_es_id
      AND id != NEW.id
      AND is_primary = 1;
END;

CREATE TRIGGER IF NOT EXISTS trg_word_es_images_update_primary
AFTER UPDATE OF is_primary ON word_es_images
WHEN NEW.is_primary = 1
BEGIN
    UPDATE word_es_images
    SET is_primary = 0, updated_at = datetime('now')
    WHERE word_es_id = NEW.word_es_id
      AND id != NEW.id
      AND is_primary = 1;
END;
