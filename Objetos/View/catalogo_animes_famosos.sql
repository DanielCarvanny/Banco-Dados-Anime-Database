CREATE OR REPLACE VIEW catalogo_animes_famosos AS
SELECT 
    a.name AS anime,
    string_agg(g.name, ', ') AS generos,
    a.episodes AS episodios,
    a.rating AS classificacao,
    s.average_score AS pontuacao,
    a.premiered AS estreia,
    aws.sypnopsis AS sinopse
FROM Anime a
JOIN Anime_Genre ag 
    ON a.MAL_ID = ag.MAL_ID
JOIN Genres g 
    ON ag.genre_id = g.genre_id
JOIN Score s 
    ON s.anime_id = a.MAL_ID
JOIN Anime_with_sypnopsis aws
    ON aws.MAL_ID = a.MAL_ID
WHERE a.popularity = 'Alta'
GROUP BY 
    a.MAL_ID, 
    a.name, 
    a.episodes, 
    a.rating, 
    s.average_score, 
    a.premiered, 
    aws.sypnopsis 
;
