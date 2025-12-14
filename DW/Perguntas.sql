-- Qual gênero ocupa as melhores posições em cada estação de estreia?
SELECT
    genero,
    estacao,
    ano,
    rank_medio
FROM (
    SELECT
        g.nome        AS genero,
        e.estacao_ano AS estacao,
        e.ano         AS ano,
        ROUND(AVG(f.ranking), 2) AS rank_medio,
        ROW_NUMBER() OVER (
            PARTITION BY e.estacao_ano, e.ano
            ORDER BY AVG(f.ranking) ASC
        ) AS rn
    FROM fato_avaliacao f
    JOIN dim_genero g
        ON g.genero_id = f.genero_id
    JOIN dim_estacao e
        ON e.estacao_id = f.estacao_id
    GROUP BY
        g.nome,
        e.estacao_ano,
        e.ano
) t
WHERE rn = 1
ORDER BY
    ano,
    rank_medio DESC;


-- Qual classificação indicativa dos animes registra a maior 
-- popularidade entre os usuários em cada tipo de reprodução?
SELECT *
FROM (
    SELECT 
        cf.classificacao AS classificacao,
        r.nome AS tipo_reproducao,
        AVG(f.ranking) AS ranking_medio,
        RANK() OVER (
            PARTITION BY r.nome
            ORDER BY AVG(f.ranking) DESC
        ) AS posicao
    FROM dw.fato_avaliacao f
    JOIN dw.dim_classificacao_etaria cf
        ON cf.classificacao_id = f.classificacao_id
    JOIN dw.dim_tipo_reproducao r
        ON r.reproducao_id = f.reproducao_id
    GROUP BY cf.classificacao, r.nome
) sub
WHERE posicao = 1
ORDER BY tipo_reproducao; 

--Quantos episódios de animes do tipo de reprodução ‘TV’ foram assistidos no total?
SELECT
    a.nome AS anime,
    SUM(f.episodios_assistidos) AS total_eps_assistidos
FROM dw.fato_episodio_assistido f
JOIN dw.dim_tipo_reproducao r
    ON f.reproducao_id = r.reproducao_id
JOIN dw.dim_anime a
    ON f.anime_id = a.anime_id
WHERE r.nome = 'TV'
GROUP BY a.nome
ORDER BY total_eps_assistidos desc
limit 10;