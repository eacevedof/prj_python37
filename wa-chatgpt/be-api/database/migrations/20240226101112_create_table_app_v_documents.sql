-- example of supabase:
-- https://supabase.com/docs/guides/ai/vector-columns?queryGroups=database-method&database-method=sql
DROP TABLE IF EXISTS app_v_documents;

CREATE EXTENSION IF NOT EXISTS vector;
CREATE TABLE app_v_documents (
  id serial primary key,
  title text not null,
  body text not null,
  embedding vector(384)
);

-- funcion seno que busca documentos similares
DROP FUNCTION IF EXISTS match_documents(vector(384), float, int);

CREATE OR REPLACE FUNCTION match_documents
(
  query_embedding vector(384),
  match_threshold float,
  match_count int
)
RETURNS TABLE (
  id bigint,
  title text,
  body text,
  similarity float
)
language sql stable
AS $$
    SELECT
        app_v_documents.id,
        app_v_documents.title,
        app_v_documents.body,
        1 - (app_v_documents.embedding <=> query_embedding) as similarity
    FROM app_v_documents
    WHERE 1 - (app_v_documents.embedding <=> query_embedding) > match_threshold
    ORDER BY (app_v_documents.embedding <=> query_embedding) ASC
    LIMIT match_count;
$$
;
