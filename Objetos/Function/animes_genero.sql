CREATE OR REPLACE FUNCTION animes_generos (input_gen text)
RETURNS TABLE(nome text, score numeric)
AS$$
Begin
    RETURN QUERY

    SELECT 
        a.name, 
        s.average_score 
    FROM Anime a
    JOIN Score s 
        ON s.anime_id = a.anime_id
    JOIN Anime_Genre ag 
        ON ag.anime_id = a.anime_id
    JOIN Genres g 
        ON g.id = ag.genre_id
    WHERE g.name ILIKE '%'||input_gen||'%'
    ORDER BY s.average_score DESC;

END;
$$LANGUAGE plpgsql;