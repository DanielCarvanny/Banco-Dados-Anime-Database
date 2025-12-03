--DADOS

--tabela para importação de dados

CREATE TABLE "Projeto-Anime".csv_a_w_s (
	mal_id int4 NULL,
	"Name" text NULL,
	score text NULL,
	genres text NULL,
	sypnopsis text NULL
);

--tabela nova
DROP TABLE IF EXISTS "Projeto-Anime".anime_with_sypnopsis;

create table "Projeto-Anime".anime_with_sypnopsis(
	"MAL_ID" int4 null,
	"Name" text null,
	"Score" decimal(3,2) null,
	"Genres" text null,
	sypnopsis text null
);

--inserção de dados
insert into "Projeto-Anime".anime_with_sypnopsis ("MAL_ID", sypnopsis)
select mal_id, sypnopsis from "Projeto-Anime".csv_a_w_s csv_aws;

--normalização
begin;

alter table anime_with_sypnopsis alter column "MAL_ID" set not null;
alter table anime_with_sypnopsis add constraint fk_aws_mal_id foreign key("MAL_ID") references anime(mal_id);
alter table anime_with_sypnopsis drop column "Name";
alter table anime_with_sypnopsis drop column "Genres";
alter table anime_with_sypnopsis drop column "Score";