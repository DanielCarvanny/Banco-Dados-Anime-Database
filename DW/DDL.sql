-- DROP SCHEMA dw;

CREATE SCHEMA dw AUTHORIZATION postgres;

CREATE TABLE dw.dim_anime (
	anime_id int4 NULL,
	nome text NULL,
	total_eps int4 NULL,
	duracao_ep int4 NULL
);

CREATE TABLE dw.dim_classificacao_etaria (
	classificacao varchar(50) NULL,
	classificacao_id int4 NOT NULL,
	CONSTRAINT dim_classificacao_etaria_pkey PRIMARY KEY (classificacao_id)
);

CREATE TABLE dw.dim_estacao (
	estacao_ano text NULL,
	ano int4 NULL,
	estacao_id int4 NOT NULL,
	CONSTRAINT dim_estacao_pkey PRIMARY KEY (estacao_id)
);

CREATE TABLE dw.dim_genero (
	nome text NULL,
	genero_id int4 NULL
);


CREATE TABLE dw.dim_tipo_reproducao (
	nome varchar(50) NULL,
	reproducao_id float8 NULL
);

CREATE TABLE dw.dim_user (
	user_id int4 NOT NULL,
	CONSTRAINT dim_user_pkey PRIMARY KEY (user_id)
);

CREATE TABLE dw.fato_avaliacao (
	ranking numeric(5, 2) NULL,
	estacao_id int4 NULL,
	anime_id int4 NULL,
	classificacao_id int4 NULL,
	reproducao_id int4 NULL,
	genero_id int4 NULL
);

CREATE TABLE dw.fato_episodio_assistido (
	episodios_assistidos int4 NULL,
	user_id int4 NULL,
	anime_id int4 NULL,
	estacao_id int4 NULL,
	reproducao_id int4 NULL,
	genero_id int4 NULL
);

-- dim_anime: anime_id como PK
ALTER TABLE dw.dim_anime 
ALTER COLUMN anime_id SET NOT NULL,
ADD CONSTRAINT dim_anime_pkey PRIMARY KEY (anime_id);

-- dim_genero: genero_id como PK
ALTER TABLE dw.dim_genero 
ALTER COLUMN genero_id SET NOT NULL,
ADD CONSTRAINT dim_genero_pkey PRIMARY KEY (genero_id);

-- dim_tipo_reproducao: reproducao_id como PK
ALTER TABLE dw.dim_tipo_reproducao 
ALTER COLUMN reproducao_id SET NOT NULL,
ALTER COLUMN reproducao_id TYPE INT USING reproducao_id::INT,
ADD CONSTRAINT dim_tipo_reproducao_pkey PRIMARY KEY (reproducao_id);

-- Para Fato Avaliacao
-- FK para dim_anime
ALTER TABLE dw.fato_avaliacao 
ADD CONSTRAINT fk_fato_avaliacao_anime 
FOREIGN KEY (anime_id) 
REFERENCES dw.dim_anime(anime_id);

-- FK para dim_estacao
ALTER TABLE dw.fato_avaliacao 
ADD CONSTRAINT fk_fato_avaliacao_estacao 
FOREIGN KEY (estacao_id) 
REFERENCES dw.dim_estacao(estacao_id);

-- FK para dim_classificacao_etaria
ALTER TABLE dw.fato_avaliacao 
ADD CONSTRAINT fk_fato_avaliacao_classificacao 
FOREIGN KEY (classificacao_id) 
REFERENCES dw.dim_classificacao_etaria(classificacao_id);

-- FK para dim_tipo_reproducao
ALTER TABLE dw.fato_avaliacao 
ADD CONSTRAINT fk_fato_avaliacao_reproducao 
FOREIGN KEY (reproducao_id) 
REFERENCES dw.dim_tipo_reproducao(reproducao_id);

-- FK para dim_genero
ALTER TABLE dw.fato_avaliacao 
ADD CONSTRAINT fk_fato_avaliacao_genero 
FOREIGN KEY (genero_id) 
REFERENCES dw.dim_genero(genero_id);


-- Para Fato Episodio Assistido
-- FK para dim_user
ALTER TABLE dw.fato_episodio_assistido 
ADD CONSTRAINT fk_fato_episodio_user 
FOREIGN KEY (user_id) 
REFERENCES dw.dim_user(user_id);

-- FK para dim_anime
ALTER TABLE dw.fato_episodio_assistido 
ADD CONSTRAINT fk_fato_episodio_anime 
FOREIGN KEY (anime_id) 
REFERENCES dw.dim_anime(anime_id);

-- FK para dim_estacao
ALTER TABLE dw.fato_episodio_assistido 
ADD CONSTRAINT fk_fato_episodio_estacao 
FOREIGN KEY (estacao_id) 
REFERENCES dw.dim_estacao(estacao_id);

-- FK para dim_tipo_reproducao
ALTER TABLE dw.fato_episodio_assistido 
ADD CONSTRAINT fk_fato_episodio_reproducao 
FOREIGN KEY (reproducao_id) 
REFERENCES dw.dim_tipo_reproducao(reproducao_id);

-- FK para dim_genero
ALTER TABLE dw.fato_episodio_assistido 
ADD CONSTRAINT fk_fato_episodio_genero 
FOREIGN KEY (genero_id) 
REFERENCES dw.dim_genero(genero_id);