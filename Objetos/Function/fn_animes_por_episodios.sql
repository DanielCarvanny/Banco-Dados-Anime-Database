CREATE OR REPLACE FUNCTION fn_animes_por_episodios(
    p_min_ep INT DEFAULT 0,
    p_max_ep INT DEFAULT 1000
)
RETURNS TABLE (
    anime_id INT,
    nome TEXT,
    episodios INT,
    tipo VARCHAR(50)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        mal_id,
        name,
        episodes,
        type
    FROM Anime
    WHERE episodes BETWEEN p_min_ep AND p_max_ep
    ORDER BY episodes;
END;
$$ LANGUAGE plpgsql;