create or replace procedure "Projeto-Anime".pr_gerar_relatorio_basico()
AS $$
declare
	v_total_animes int;
	v_media_episodios numeric;
	v_anime_mais_popular text;
	v_top_genero text;
	v_score_top_anime numeric;
	v_rank_top_anime int;
	v_top_produtor text;
	v_top_studio text;

begin    
	-- Coleta estatísticas
	select count(*) into v_total_animes from anime;
	
	select round(avg(episodes), 1 ) into v_media_episodios
	from anime where episodes is not null;
	
	select a.name, s.average_score, s.ranked into v_anime_mais_popular, v_score_top_anime, v_rank_top_anime
	from anime a
	join score s on s.anime_id = a.mal_id
	order by members desc limit 1;
	
	select g.name into v_top_genero
	from anime_genre ag
	join genre g on ag.genre_id = g.id
	group by g.name
	order by count(*) desc
	limit 1;

	select p.name into v_top_produtor
	from anime_producers ap
	join producer p on p.id = ap.producers_id
	group by p.name
	order by count(*) desc
	limit 1;

	select st.name into v_top_studio
	from anime_studio "as"
	join studio st on st.id = "as".studio_id
	group by st.name
	order by count(*) desc
	limit 1;


	
	-- Exibe relatório
	raise notice '===== RELATÓRIO DO BANCO DE DADOS =====';
	raise notice 'Total de Animes: %', v_total_animes;
	raise notice 'Média de Episódios: %', v_media_episodios;
	raise notice 'Anime mais Popular: %', v_anime_mais_popular;
	raise notice 'Score do anime mais Popular: %', v_score_top_anime;
	raise notice 'Rank do anime mais Popular: %', v_rank_top_anime;
    raise notice 'Gênero mais Comum: %', v_top_genero;
    raise notice 'Estúdio mais popular: %', v_top_studio;
    raise notice 'Produtora mais popular: %', v_top_produtor;
    raise notice '=======================================';

end;
$$language plpgsql;