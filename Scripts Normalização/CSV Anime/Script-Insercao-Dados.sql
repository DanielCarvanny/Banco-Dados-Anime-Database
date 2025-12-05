-- Insert dos dados
-- Tabela Anime
INSERT INTO Anime
(mal_id, "name", english_name, japanese_name, "type", episodes, aired, premiered, "source", duration, rating, popularity, members, favorites, watching, completed, "on-hold", dropped, plan_to_watch)
select
mal_id,
"name", 
english_name,
japanese_name, 
"type", 
episodes,
aired, 
premiered, 
"source", 
duration,
rating,
popularity, 
members, 
favorites, 
watching, 
completed, 
"on-hold", 
dropped, 
plan_to_watch
from anime_nao_normalizada;

-- Tabela Producer
INSERT INTO Producer(name)
SELECT DISTINCT trim(unnest(string_to_array(producers, ',')))
FROM anime_nao_normalizada
WHERE producers IS NOT NULL AND producers <> '';

-- Tabela Studio
INSERT INTO Studio(name)
SELECT DISTINCT trim(unnest(string_to_array(studios, ',')))
FROM anime_nao_normalizada
WHERE studios IS NOT NULL AND studios <> '';

-- Tabela Licensors
INSERT INTO Licensors(name)
SELECT DISTINCT trim(unnest(string_to_array(licensors, ',')))
FROM anime_nao_normalizada
WHERE licensors IS NOT NULL AND licensors <> '';

-- Tabela Genre
INSERT INTO Genre(name)
SELECT DISTINCT trim(unnest(string_to_array(genres, ',')))
FROM anime_nao_normalizada
WHERE genres IS NOT NULL AND genres <> '';

-- Tabela Anime_Producers
INSERT INTO Anime_Producers(anime_id, producers_id)
SELECT
    ann.mal_id,
    p.id
FROM anime_nao_normalizada ann
CROSS JOIN LATERAL unnest(string_to_array(ann.producers, ',')) AS prod(name)
JOIN Producer p ON p.name = trim(prod.name)
WHERE ann.producers IS NOT NULL AND ann.producers <> '';

select ap.anime_id, ap.producers_id, p."name" from Anime_Producers ap join producer p on p.id = ap.producers_id;

-- Tabela Anime_Studio
INSERT INTO Anime_Studio(anime_id, studio_id)
SELECT
    ann.mal_id,
    s.id
FROM anime_nao_normalizada ann
CROSS JOIN LATERAL unnest(string_to_array(ann.studios, ',')) AS st(name)
JOIN Studio s ON s.name = trim(st.name)
WHERE ann.studios IS NOT NULL AND ann.studios <> '';

select "as".anime_id, "as".studio_id, s."name" from Anime_Studio "as" join Studio s on s.id = "as".studio_id;

-- Tabela Anime_Licensors
INSERT INTO Anime_Licensors(anime_id, licensors_id)
SELECT
    ann.mal_id,
    l.id
FROM anime_nao_normalizada ann
CROSS JOIN LATERAL unnest(string_to_array(ann.licensors, ',')) AS lic(name)
JOIN Licensors l ON l.name = trim(lic.name)
WHERE ann.licensors IS NOT NULL AND ann.licensors <> '';

select al.anime_id, al.licensors_id, l."name" from Anime_Licensors al join Licensors l on l.id = al.licensors_id;

-- Tabela Anime_Genre
INSERT INTO Anime_Genre(anime_id, genre_id)
SELECT
    ann.mal_id,
    g.id
FROM anime_nao_normalizada ann
CROSS JOIN LATERAL unnest(string_to_array(ann.genres, ',')) AS gen(name)
JOIN Genre g ON g.name = trim(gen.name)
WHERE ann.genres IS NOT NULL AND ann.genres <> '';

select ag.anime_id, ag.genre_id, g."name" from Anime_Genre ag join Genre g on g.id = ag.genre_id where g."name" = 'Game';

-- Tabela Score
INSERT INTO Score(
    "score-1", "score-2", "score-3", "score-4", "score-5",
    "score-6", "score-7", "score-8", "score-9", "score-10",
    ranked, average_score, anime_id
)
SELECT
    "score-1", "score-2", "score-3", "score-4", "score-5",
    "score-6", "score-7", "score-8", "score-9", "score-10",
    ranked, score, mal_id
FROM anime_nao_normalizada;
