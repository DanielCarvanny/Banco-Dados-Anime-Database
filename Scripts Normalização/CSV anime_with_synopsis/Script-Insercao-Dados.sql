--inserção de dados
insert into "Projeto-Anime".anime_with_synopsis 
	(MAL_ID, synopsis)
select mal_id, synopsis 
	from "Projeto-Anime".csv_a_w_s csv_aws
	ON CONFLICT DO NOTHING;
