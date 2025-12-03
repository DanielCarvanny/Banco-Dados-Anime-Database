--tabela para importação de dado

CREATE TABLE "Projeto-Anime".csv_r_c (
	user_id int4 NULL,
	anime_id int4 NULL,
	rating int4 NULL
);

--tabela já normalizada
drop table if exists "Projeto-Anime".rating_complete 
create table "Projeto-Anime".rating_complete (
	user_id int4 null,
	anime_id int4 null,
	rating int4 not null,
	constraint fk_rc_user_id foreign key(user_id) references anime_list(user_id),
	constraint fk_rc_anime_id foreign key(anime_id) references anime(anime_id)
);

--transferencia de dados
insert into "Projeto-Anime".rating_complete 
select  (user_id, anime_id, rating) from "Projeto-Anime".csv_r_c;
