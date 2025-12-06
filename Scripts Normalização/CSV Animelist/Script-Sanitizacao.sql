-- 1º Criar uma tabela normalizada:

DROP TABLE IF EXISTS public.animelist_normalizada;
CREATE TABLE IF NOT EXISTS public.animelist_normalizada
(
    user_id integer NOT NULL,
    anime_id integer NOT NULL,
    rating integer,
    watching_status integer,
    watched_episodes integer,
    CONSTRAINT animelist_pkey PRIMARY KEY (user_id, anime_id),
    CONSTRAINT animelist_normalizada_anime_id_fkey FOREIGN KEY (anime_id)
        REFERENCES public.anime (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT animelist_normalizada_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.usuario (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.animelist_normalizada
    OWNER to postgres;


-- 2º Criando tabela temporária a partir da normalizada
-- para a insersão de todos os dados:

DROP TABLE IF EXISTS public.animelist_temp;
CREATE TABLE IF NOT EXISTS public.animelist_temp
(
    user_id integer NOT NULL,
    anime_id integer NOT NULL,
    rating integer NOT NULL,
    watching_status integer,
    watched_episodes integer NOT NULL
)

TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.animelist_temp
    OWNER to postgres;

-- 2.2 Modificação na tabela animelist_temp(temporária) para aceitar dados duplicados:
ALTER TABLE animelist_temp DROP CONSTRAINT animelist_temp_pkey;

-- 3º Alterando nomes da tabela normalizada para se tornar mais legível na tabela:
ALTER TABLE animelist_normalizada RENAME COLUMN rating TO score;
ALTER TABLE animelist_normalizada RENAME COLUMN watching_status TO status;


