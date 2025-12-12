--Tabela temporária para importação de dados
begin;

CREATE TABLE "Projeto-Anime".csv_a_w_s (
	mal_id int4 NULL,
	"Name" text NULL,
	score text NULL,
	genres text NULL,
	sypnopsis text NULL
);

--Tabela nova para transferência
begin;

DROP TABLE IF EXISTS "Projeto-Anime".anime_with_sypnopsis;

create table "Projeto-Anime".anime_with_sypnopsis(
	MAL_ID int4 null,
	"name" text null,
	score decimal(3,2) null,
	genres text null,
	sypnopsis text null
);