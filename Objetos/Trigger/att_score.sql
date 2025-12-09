CREATE OR REPLACE FUNCTION func_att_score()
RETURNS TRIGGER
AS $$
BEGIN

    UPDATE Score SET 
        "score-1" = CASE WHEN NEW.rating = 1 
            THEN "score-1" + 1 ELSE "score-1" END,
        "score-2" = CASE WHEN NEW.rating = 2 
            THEN "score-2" + 1 ELSE "score-2" END,
        "score-3" = CASE WHEN NEW.rating = 3 
            THEN "score-3" + 1 ELSE "score-3" END,
        "score-4" = CASE WHEN NEW.rating = 4 
            THEN "score-4" + 1 ELSE "score-4" END,
        "score-5" = CASE WHEN NEW.rating = 5 
            THEN "score-5" + 1 ELSE "score-5" END,
        "score-6" = CASE WHEN NEW.rating = 6 
            THEN "score-6" + 1 ELSE "score-6" END,
        "score-7" = CASE WHEN NEW.rating = 7 
            THEN "score-7" + 1 ELSE "score-7" END,
        "score-8" = CASE WHEN NEW.rating = 8 
            THEN "score-8" + 1 ELSE "score-8" END,
        "score-9" = CASE WHEN NEW.rating = 9 
            THEN "score-9" + 1 ELSE "score-9" END,
        "score-10" = CASE WHEN NEW.rating = 10 
            THEN "score-10" + 1 ELSE "score-10" END
    WHERE Score.anime_id = NEW.anime_id;

    UPDATE Score s
    SET average_score = (
        ( 
        "score-1" * 1 +
        "score-2" * 2 +
        "score-3" * 3 +
        "score-4" * 4 +
        "score-5" * 5 +
        "score-6" * 6 +
        "score-7" * 7 +
        "score-8" * 8 +
        "score-9" * 9 +
        "score-10" * 10
        )
        ::float /
        ( 
        "score-1" +
        "score-2" +
        "score-3" +
        "score-4" +
        "score-5" +
        "score-6" +
        "score-7" +
        "score-8" +
        "score-9" +
        "score-10"
        )
    )
    WHERE s.anime_id = NEW.anime_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER att_score
AFTER INSERT ON animelist_normalizada
FOR EACH ROW
EXECUTE FUNCTION func_att_score();