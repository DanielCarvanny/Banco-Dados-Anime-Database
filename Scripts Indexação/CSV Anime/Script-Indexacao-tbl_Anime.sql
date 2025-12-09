CREATE EXTENSION IF NOT EXISTS pg_trgm;

--Índice do Nome
create index idx_anime_name on "Projeto-Anime".anime using gin(name gin_trgm_ops);

--Índice do Nome em Inglês
create index idx_anime_english_name on "Projeto-Anime".anime using gin(english_name gin_trgm_ops);

--Índice do nome em Japonês
create index idx_anime_japanese_name on "Projeto-Anime".anime using gin(japanese_name gin_trgm_ops);

SELECT * FROM anime WHERE name ILIKE '%Boku%';
