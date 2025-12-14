-- 1º Criar uma tabela normalizada:

DROP TABLE IF EXISTS animelist;
CREATE TABLE IF NOT EXISTS animelist
(
    user_id integer NOT NULL,
    anime_id integer NOT NULL,
    rating integer,
    watching_status integer,
    watched_episodes integer,
    CONSTRAINT animelist_pkey PRIMARY KEY (user_id, anime_id),
    CONSTRAINT animelist_anime_id_fkey FOREIGN KEY (anime_id)
        REFERENCES anime (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT animelist_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES usuario (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)


TABLESPACE pg_default;
ALTER TABLE IF EXISTS animelist
    OWNER to postgres;
