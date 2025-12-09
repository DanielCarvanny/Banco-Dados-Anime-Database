CREATE OR REPLACE FUNCTION fn_atualizar_contadores_voto()
RETURNS TRIGGER
AS $$
BEGIN
    UPDATE Score SET 
        score_1 = CASE WHEN NEW.rating = 1 
            THEN score_1 + 1 ELSE score_1 END,
        score_2 = CASE WHEN NEW.rating = 2 
            THEN score_2 + 1 ELSE score_2 END,
        score_3 = CASE WHEN NEW.rating = 3 
            THEN score_3 + 1 ELSE score_3 END,
        score_4 = CASE WHEN NEW.rating = 4 
            THEN score_4 + 1 ELSE score_4 END,
        score_5 = CASE WHEN NEW.rating = 5 
            THEN score_5 + 1 ELSE score_5 END,
        score_6 = CASE WHEN NEW.rating = 6 
            THEN score_6 + 1 ELSE score_6 END,
        score_7 = CASE WHEN NEW.rating = 7 
            THEN score_7 + 1 ELSE score_7 END,
        score_8 = CASE WHEN NEW.rating = 8 
            THEN score_8 + 1 ELSE score_8 END,
        score_9 = CASE WHEN NEW.rating = 9 
            THEN score_9 + 1 ELSE score_9 END,
        score_10 = CASE WHEN NEW.rating = 10 
            THEN score_10 + 1 ELSE score_10 END
    WHERE Score.anime_id = NEW.anime_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_inserir_voto
AFTER INSERT ON animelist_normalizada
FOR EACH ROW
EXECUTE FUNCTION fn_atualizar_contadores_voto();