--rollback; commit;
begin;
drop table if exists "Projeto-Anime".watching_status;

--criação da tabela (já normalizada)

CREATE TABLE "Projeto-Anime".watching_status (
	id_status serial4 NOT NULL,
	description text NOT NULL,
	CONSTRAINT watching_status_description_key UNIQUE (description),
	CONSTRAINT watching_status_pk PRIMARY KEY (id_status)
);


--inserção de dados
insert into "Projeto-Anime".watching_status
select status, " description" from csv_w_stts 

select * from watching_status