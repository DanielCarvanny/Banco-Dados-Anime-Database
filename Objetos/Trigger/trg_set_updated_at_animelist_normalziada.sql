CREATE OR REPLACE FUNCTION set_update_at_animelist_normalizada()
RETURNS TRIGGER AS $$
BEGIN
	NEW.updated_at = NOW();
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_set_update_at_animelist_normalizada
BEFORE UPDATE ON animelist_normalizada
FOR EACH ROW
EXECUTE FUNCTION set_update_at_animelist_normalizada();