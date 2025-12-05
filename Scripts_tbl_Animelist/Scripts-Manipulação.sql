-- 1º Importar os dados para a tabela temporaria atraves do PSQL tool:
\copy animelist_temp FROM 'D:\\anime_list\animelist.csv\animelist.csv' CSV HEADER;

-- 2º Inserindo dados sem duplicatas para a tabela normalizada:
-- (Com nomes das colunas já alterados "score", "status", como feito no Script-Definição)
INSERT INTO 
    animelist_normalizada (
        user_id, 
        anime_id, 
        score, 
        status, 
        watched_episodes
    )
SELECT 
    user_id, 
    anime_id, 
    rating, 
    watching_status, 
    watched_episodes
FROM animelist_temp
ON CONFLICT (user_id, anime_id) DO NOTHING;