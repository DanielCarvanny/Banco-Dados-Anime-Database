-- 1º Importar os dados para a tabela temporaria atraves do PSQL tool:
\copy animelist_temp FROM 'D:\\anime_list\animelist.csv\animelist.csv' CSV HEADER;

-- 2º Inserindo dados sem duplicatas para a tabela normalizada:
-- (Com nomes das colunas já alterados "score", "status", como feito no Scripts-Sanitização)

-- Inicie essa etapa com o "begin" para analisar se terá confiltos
-- Caso tenha conflito de dados, utilize o comando rollback (que está comentado)
-- Repita o processo até os dados forem completamente para a tabela animelist sem problemas
-- Ao final da insersão dos dados utilize o comando "commit" (que está comentado também)


begin; 

INSERT INTO 
    animelist (
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

--commit;
--rollback;


-- Crie a tabela primeiro (Script-Sanitização)
-- 3º Inserindo dados tabela usuário:
INSERT INTO usuario (id)
SELECT DISTINCT user_id
FROM animelist_temp;