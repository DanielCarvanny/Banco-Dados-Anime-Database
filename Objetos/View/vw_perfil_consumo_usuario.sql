BEGIN;

-- 1º filtro perfil usuário
SELECT
	user_id,
	COUNT(*) AS total_animes,
	SUM(an.watched_episodes) AS total_episodios,
	ROUND(AVG(an.score), 2) AS media_score,
	COUNT(CASE WHEN an.status = '2' THEN 1 END) AS total_animes_completos,
	COUNT(CASE WHEN an.status = '1' THEN 1 END) AS total_animes_assistindo
FROM animelist an
GROUP BY user_id

-- 2º total de eps por gênero
SELECT
	user_id,
	g.name AS genero,
	COUNT(DISTINCT an.anime_id) AS total_animes_genero,
	SUM(watched_episodes) AS total_eps_genero
FROM animelist an
JOIN anime a
	ON a.mal_id = an.anime_id
JOIN anime_genre ag 
	ON ag.anime_id = a.mal_id
JOIN genre g 
	ON g.id = a.mal_id
GROUP BY user_id, genero
ORDER BY user_id, total_animes_genero DESC

-- 3º base para fazer ranking
SELECT 
	user_id,
	anime_id,
	watched_episodes AS episodios_assistidos,
	ROW_NUMBER() OVER(
		PARTITION BY user_id
		ORDER BY watched_episodes DESC
	) AS ranking_episodios_usuarios
FROM animelist;




-- [VIEW CONCRETA]
CREATE OR REPLACE VIEW vw_perfil_consumo_usuario AS 
WITH 
-- SUBCONSULTA: perfil geral dos usuários
cte_perfil_usuario AS (
		SELECT
			user_id,
			COUNT(*) AS total_animes,
			SUM(an.watched_episodes) AS total_episodios,
			ROUND(AVG(an.score), 2) AS media_score,
			COUNT(CASE WHEN an.status = '2' THEN 1 END) AS total_animes_completos,
			COUNT(CASE WHEN an.status = '1' THEN 1 END) AS total_animes_assistindo
		FROM animelist an
		GROUP BY user_id
	),


-- SUBCONSULTA: base para ranking genero_favorito e anime_favorito
cte_genero AS (
		SELECT
			an.user_id,
			g.name AS genero,
			COUNT(DISTINCT an.anime_id) AS total_animes_genero,
			SUM(an.watched_episodes) AS total_eps_genero
		FROM animelist an
		JOIN anime a
			ON a.mal_id = an.anime_id
		JOIN anime_genre ag 
			ON ag.anime_id = a.mal_id
		JOIN genre g 
			ON g.id = ag.genre_id
		GROUP BY an.user_id, g.name
	),


-- SUBCONSULTA: ranking genêro favorito 
-- (ordenado pelos episodios mais assistido de cada gênero por usuário)
cte_genero_favorito AS (
		SELECT
			user_id,
			genero
		FROM(
			SELECT 
				user_id, 
				genero,
				ROW_NUMBER() OVER(
					PARTITION BY user_id
					ORDER BY total_eps_genero DESC
				) AS ranking_genero
			FROM cte_genero
		) x
		WHERE ranking_genero = 1
	),


-- SUBCONSULTA: ranking anime favorito 
-- (ordenado por usuário pelo score mais alto que ele deu para o anime na lista)
cte_anime_favorito AS (
		SELECT
			user_id,
			anime_id,
			score
		FROM(
			SELECT 
				user_id, 
				anime_id, 
				score,
				ROW_NUMBER() OVER(
					PARTITION BY user_id
					ORDER BY score DESC
				) AS ranking_anime
			FROM animelist_temp
		) y
		WHERE ranking_anime = 1
	)
SELECT
	pu.user_id,
	pu.total_animes,
	pu.total_episodios,
	pu.media_score,
	pu.total_animes_completos,
	pu.total_animes_assistindo,
	gf.genero AS genero_favorito,
	af.anime_id AS anime_favorito,
	af.score AS score_favorito
FROM cte_perfil_usuario pu
LEFT JOIN cte_genero_favorito gf
	ON gf.user_id = pu.user_id
LEFT JOIN cte_anime_favorito af
	ON af.user_id = pu.user_id;
	
SELECT * FROM vw_perfil_consumo_usuario;

