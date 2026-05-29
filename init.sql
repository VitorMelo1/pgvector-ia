-- Script de inicialização do banco de dados
-- Executado automaticamente na primeira vez que o container sobe

-- Criar a extensão pgvector
CREATE EXTENSION IF NOT EXISTS vector;

-- Criar tabela exemplo para armazenar embeddings
CREATE TABLE IF NOT EXISTS documents (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    content TEXT,
    embedding vector(1536),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índice para buscas por similaridade de cosseno (recomendado para OpenAI embeddings)
CREATE INDEX IF NOT EXISTS idx_documents_embedding
    ON documents USING ivfflat (embedding vector_cosine_ops)
    WITH (lists = 100);

\echo 'Banco de dados inicializado com sucesso!'
\echo 'Extensão pgvector está ativa.'
