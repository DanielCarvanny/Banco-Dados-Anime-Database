CREATE OR REPLACE FUNCTION fn_atualizar_status()
RETURNS TRIGGER AS $$
DECLARE
	total_eps INT;
BEGIN
    -- A trigger não vai sobrescrever a opção 3 = "ON-HOLD"
	IF OLD.status IN (3) THEN 
		RETURN NEW;
	END IF;

	
	-- Puxando todos os episódios dos animes
	SELECT
		a.episodes
		INTO total_eps
	FROM anime a
	WHERE mal_id = NEW.anime_id;


	-- Atualizando status para completo (COMPLETED)
	IF NEW.watched_episodes = total_eps THEN
		NEW.status := 2;

	-- Atualizando status para assistindo (CURRENTLY WATCHING)
	ELSIF NEW.watched_episodes > 0 AND NEW.watched_episodes < total_eps THEN
		NEW.status := 1;

	-- Atualizando status para assistir futuramente (PLAN TO WATCH)
	ELSIF NEW.watched_episodes = 0 THEN
		NEW.status := 6;
	END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_atualizar_status
BEFORE UPDATE OF watched_episodes 
ON animelist
FOR EACH ROW 
EXECUTE FUNCTION fn_atualizar_status();
