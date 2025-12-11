--inserção de dados
insert into "Projeto-Anime".anime_with_sypnopsis 
	(MAL_ID, sypnopsis)
select mal_id, sypnopsis 
	from "Projeto-Anime".csv_a_w_s csv_aws
	ON CONFLICT DO NOTHING;