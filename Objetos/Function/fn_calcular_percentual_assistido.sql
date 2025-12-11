CREATE OR REPLACE FUNCTION fn_calcular_percentual_assistido(input_user_id INT, input_anime_id INT)
RETURNS NUMERIC(5,2)
AS $$
DECLARE
	eps_watched INT;
	eps_total INT;
BEGIN

	SELECT 
		watched_episodes
		INTO eps_watched
	FROM animelist_normalizada
	WHERE 
		user_id = input_user_id 
		AND anime_id = input_anime_id;
		
	IF eps_watched IS NULL THEN
		return NULL;
	END IF;

	SELECT 
		episodes
		INTO eps_total
	FROM anime
	WHERE mal_id = input_anime_id;

	IF eps_total = 0 OR eps_total IS NULL THEN
		return NULL;
	END IF;

	RETURN ROUND((eps_watched::NUMERIC / eps_total::NUMERIC) * 100, 2);
END;
$$ LANGUAGE plpgsql;
