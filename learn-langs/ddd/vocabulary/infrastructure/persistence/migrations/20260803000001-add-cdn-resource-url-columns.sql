-- Columnas para la sincronizacion de recursos al CDN (resources.theframework.es).
-- audio_url / file_url: URL publica del recurso ya subido (la lee el APK).
-- audio_synced_md5 / file_synced_md5: md5 del fichero local ya subido, para detectar
-- regeneraciones y no re-subir lo que no cambio (sync idempotente).
-- Audios: words_lang.audio_path (ruta local). Imagenes: word_es_images.file_path (nombre bajo data/images).
ALTER TABLE words_lang ADD COLUMN audio_url TEXT;
ALTER TABLE words_lang ADD COLUMN audio_synced_md5 TEXT;

ALTER TABLE word_es_images ADD COLUMN file_url TEXT;
ALTER TABLE word_es_images ADD COLUMN file_synced_md5 TEXT;
