-- 1º Criando tabela temporária a partir da normalizada
-- para a insersão de todos os dados:

DROP TABLE IF EXISTS animelist_temp;
CREATE TABLE IF NOT EXISTS animelist_temp
(
    user_id integer NOT NULL,
    anime_id integer NOT NULL,
    rating integer NOT NULL,
    watching_status integer,
    watched_episodes integer NOT NULL
)

TABLESPACE pg_default;
ALTER TABLE IF EXISTS animelist_temp
    OWNER to postgres;



-- 1.2 Modificação na tabela animelist_temp(temporária) para aceitar dados duplicados:
ALTER TABLE animelist_temp DROP CONSTRAINT animelist_temp_pkey;



-- 2º Alterando nomes da tabela normalizada para se tornar mais legível na tabela:
ALTER TABLE animelist RENAME COLUMN rating TO score;
ALTER TABLE animelist RENAME COLUMN watching_status TO status;



-- 3º Criando colunas created_at e updated_at  
--facilita auditoria e restreabilidade
ALTER TABLE animelist
	ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW(),
	ADD COLUMN updated_at TIMESTAMPTZ DEFAULT NOW();



-- 4º Criando tabela usuário: 
Table: usuario
DROP TABLE IF EXISTS usuario;

CREATE TABLE IF NOT EXISTS usuario
(
    id integer NOT NULL,
    CONSTRAINT usuario_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;
ALTER TABLE IF EXISTS usuario
    OWNER to postgres;