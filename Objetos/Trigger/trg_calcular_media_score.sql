create or replace function calcular_media_score()
returns trigger as $$
declare
	total_votos int;
	total_pontos numeric;

begin
	-- Calcular total de votos e pontos
	total_votos := COALESCE(NEW.score_1, 0) + COALESCE(NEW.score_2, 0) + 
                   COALESCE(NEW.score_3, 0) + COALESCE(NEW.score_4, 0) + 
                   COALESCE(NEW.score_5, 0) + COALESCE(NEW.score_6, 0) + 
                   COALESCE(NEW.score_7, 0) + COALESCE(NEW.score_8, 0) + 
                   COALESCE(NEW.score_9, 0) + COALESCE(NEW.score_10, 0);
	
	total_pontos := COALESCE(NEW.score_1 * 1, 0) + COALESCE(NEW.score_2 * 2, 0) + 
                    COALESCE(NEW.score_3 * 3, 0) + COALESCE(NEW.score_4 * 4, 0) + 
                    COALESCE(NEW.score_5 * 5, 0) + COALESCE(NEW.score_6 * 6, 0) + 
                    COALESCE(NEW.score_7 * 7, 0) + COALESCE(NEW.score_8 * 8, 0) + 
                    COALESCE(NEW.score_9 * 9, 0) + COALESCE(NEW.score_10 * 10, 0);
	
	-- Calcular média
	if total_votos > 0 then
		new.average_score := round((total_pontos/total_votos)::numeric, 2);
	else
		new.average_score := null;
	end if;
	
	-- Atualizar o ranked 
	if new.average_score is not null then
		new.ranked := (
			select count(*)+1
			from Score
			where average_score > new.average_score
		);
	else
		new.ranked := null;
	
	end if;
	
	return new;
end;
$$ language plpgsql;

-- Trigger para INSERT
create trigger trg_calcular_media_insert
before insert on score
for each row
execute function calcular_media_score();

-- Trigger para UPDATE
create trigger trg_calcular_media_update
before update on score
for each row
execute function calcular_media_score();

-- teste: Atualizar score existente
UPDATE Score 
SET score_10 = score_10 + 10000
WHERE anime_id = 9999;

SELECT score_10, average_score FROM Score WHERE anime_id = 9999;
