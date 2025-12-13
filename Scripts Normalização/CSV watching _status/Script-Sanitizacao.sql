--Tabela para imrpotação de dados
begin;
create table "Projeto-Anime".csv_w_stts(
	status int,
	description text
);


--criação da tabela já normalizada
begin;
drop table if exists "Projeto-Anime".watching_status;

CREATE TABLE "Projeto-Anime".watching_status (
	id_status int4 NOT NULL,
	description text NOT NULL,
	CONSTRAINT watching_status_description_key UNIQUE (description),
	CONSTRAINT watching_status_pk PRIMARY KEY (id_status)
);

