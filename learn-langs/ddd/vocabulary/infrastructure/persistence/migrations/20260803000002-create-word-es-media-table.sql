-- Tabla generica de MEDIA por palabra: audio ahora; video/pdf mas adelante.
-- file_ext identifica el tipo (mp3, mp4, mov, pdf, ...).
-- El audio va por convencion de fichero: word-{word_es_id}-{accent}.mp3
--   (2 por palabra: origen 'es_ES' + traduccion 'nl_NL').
-- lang_code SIN FK a languages: el origen 'es_ES' no es un idioma de aprendizaje
--   (no esta en la tabla languages); solo indica la lengua del contenido del media.
-- file_url / file_synced_md5: URL en resources.theframework.es + md5 del fichero
--   subido (sync idempotente; el APK lee file_url).
CREATE TABLE IF NOT EXISTS word_es_media (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    word_es_id      INTEGER NOT NULL,
    lang_code       TEXT NOT NULL,
    file_ext        TEXT NOT NULL,
    filename        TEXT NOT NULL,
    file_url        TEXT,
    file_synced_md5 TEXT,
    created_at      TEXT DEFAULT (datetime('now')),
    updated_at      TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (word_es_id) REFERENCES words_es(id) ON DELETE CASCADE,
    UNIQUE(word_es_id, lang_code, file_ext)
);
