CREATE OR REPLACE PROCEDURE pr_atualizar_progresso_usuario(
	p_user_id INT, 
	p_anime_id INT,
	p_score INT,
	p_status INT,
	p_new_watched INT, 
	p_force BOOLEAN DEFAULT FALSE
)
AS $$
DECLARE
	-- validações:
	v_total_eps		INT;
	v_exists		BOOLEAN := FALSE;
	v_old_watched	INT;
	v_old_status	INT;

	-- insert/update:
	v_row 			animelist_normalizada%ROWTYPE;
BEGIN


	----------------------------------------------------------------
	-- BLOCO DE VALIDAÇÃO
	----------------------------------------------------------------

		-- VALIDAR PARÂMETRO --
	IF p_new_watched IS NULL THEN
		RAISE EXCEPTION 'p_new_watched não pode ser NULL';
	END IF;

		-- VALIDAR SE EPS É NEGATIVO -- 
	IF p_new_watched < 0 THEN 
		RAISE EXCEPTION 'Números de episódios assistidos não pode ser negativo: %', p_new_watched;
	END IF;

		-- VALIDAR USUÁRIO --
	PERFORM 1 FROM usuario WHERE id = p_user_id;
	IF NOT FOUND THEN 
		RAISE EXCEPTION 'Usuario % não encontrado', p_user_id;
	END IF;

		 -- VALIDAR ANIME --
	SELECT
		a.episodes
		INTO v_total_eps
	FROM anime a
	WHERE a.mal_id = p_anime_id;

	IF NOT FOUND THEN 
		RAISE EXCEPTION 'Anime (mal_id = %) não encontrado', p_anime_id;
	END IF;

		-- VALIDAR total_eps E new_watched -- 
	IF v_total_eps IS NOT NULL AND p_new_watched > v_total_eps THEN 
		RAISE EXCEPTION 'Registrando % episódios mas o anime tem % episódios', p_new_watched, v_total_eps;
	END IF;

		-- VALIDAR registro existente --  
	SELECT 
	*
	INTO v_row
	FROM animelist_normalizada
	WHERE user_id = p_user_id AND anime_id = p_anime_id;

	IF FOUND THEN -- trava a linha se existir -- 
		v_exists := TRUE;
		v_old_watched := v_row.watched_episodes;
		v_old_status  := v_row.status;
	ELSE
		v_exists := FALSE;
	END IF;

		-- INPEDIR redução -- 
	IF v_exists AND p_force = FALSE THEN	
		IF p_new_watched < COALESCE(v_old_watched, 0) THEN
			RAISE EXCEPTION 
				'Operação inválida: valor adicionado % é menor que o valor atual %
				(USE p_force = TRUE para forçar)', 
				p_new_watched, COALESCE(v_old_watched, 0);
		END IF;
	END IF;

		-- BLOQUEIA ATUALIZAÇÃO EM ON-HOLD --
	IF v_exists AND v_old_status = 3 THEN
		RAISE EXCEPTION 'Registro em ON-HOLD, atualização bloqueada pelo usuário';
	END IF;
	
	-- FINAL BLOCO VALIDAÇÕES.

	
	----------------------------------------------------------------
	-- BLOCO INSERT/UPDATE
	----------------------------------------------------------------
	
	IF v_exists THEN 
		UPDATE animelist_normalizada
		SET 
			score = p_score,
			status = p_status,
			watched_episodes = p_new_watched
		WHERE user_id = p_user_id AND anime_id = p_anime_id;
	ELSE 
		INSERT INTO animelist_normalizada(
			user_id,
			anime_id,
			score,
			status,
			watched_episodes
		) VALUES (
			p_user_id,
			p_anime_id,
			p_score,
			p_status,
			p_new_watched			
		);
	END IF;
	-- FINAL BLOCO INSERT/UPDATE.
END;
$$ LANGUAGE plpgsql;


