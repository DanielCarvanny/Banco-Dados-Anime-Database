create or replace procedure pr_gerar_relatorio_basico_anual(p_ano int)
as $$
declare
	v_total_animes INT;
    v_media_episodios NUMERIC;
    v_melhor_anime TEXT;
    v_score_melhor_anime NUMERIC;
    v_rank_melhor_anime INT;
    v_top_genero TEXT;
    v_top_produtor TEXT;
    v_top_studio TEXT;
    v_ano_aired TEXT;
    v_ano_valido BOOLEAN;

begin 
	SELECT EXISTS (
        SELECT 1 FROM anime 
        WHERE aired LIKE '%' || p_ano::TEXT || '%'
    ) INTO v_ano_valido;

	IF NOT v_ano_valido THEN
        RAISE NOTICE 'Nenhum anime encontrado para o ano %', p_ano;
        RETURN;
    END IF;
   
	v_ano_aired := p_ano::TEXT; -- Formata o ano para busca
	
	-- Coleta estatísticas
    -- Total de animes lançados no ano
	select count(*) into v_total_animes from anime 
	WHERE aired LIKE '%' || v_ano_aired || '%';
	
    -- Média de episódios dos animes do ano
	select round(avg(episodes), 1 ) into v_media_episodios
	from anime 
	where aired LIKE '%' || v_ano_aired || '%' 
        AND episodes is not null;
	
    -- MELHOR ANIME DO ANO (maior score/membros)
	select 
        a.name,
        COALESCE(s.average_score, 0),
        COALESCE(s.ranked, 0)
    into 
        v_melhor_anime,
        v_score_melhor_anime,
        v_rank_melhor_anime
    from anime a
    left join score s on s.anime_id = a.mal_id
    where a.aired like '%' || v_ano_aired || '%'
        and s.average_score is not null
    order by s.average_score desc, a.members desc
    limit 1;
	
    -- Gênero mais comum no ano
	select g.name into v_top_genero
	from anime a
	join anime_genre ag on ag.anime_id = a.mal_id
	join genre g on ag.genre_id = g.id
	where a.aired like '%' || v_ano_aired || '%'
	group by g.name
	order by count(*) desc
	limit 1;

    -- Produtora mais ativa no ano
	select p.name into v_top_produtor
	from anime a
	join anime_producers ap on ap.anime_id = a.mal_id
	join producer p on p.id = ap.producers_id
	where a.aired like '%' || v_ano_aired || '%'
	group by p.name
	order by count(*) desc
	limit 1;

    -- Estúdio mais ativo no ano
	select st.name into v_top_studio
	from anime a
	join anime_studio "as" on "as".anime_id = a.mal_id
	join studio st on st.id = "as".studio_id
	where a.aired like '%' || v_ano_aired || '%'
	group by st.name
	order by count(*) desc
	limit 1;


	
	-- Exibe relatório
	RAISE NOTICE '';
    RAISE NOTICE '══════════════════════════════════════════════════════════════════';
    RAISE NOTICE '                     RELATÓRIO ANUAL - %', p_ano;
    RAISE NOTICE '══════════════════════════════════════════════════════════════════';
    RAISE NOTICE 'ESTATÍSTICAS GERAIS:';
    RAISE NOTICE '   • Total de Animes Lançados: %', v_total_animes;
    RAISE NOTICE '   • Média de Episódios: %', v_media_episodios;
    RAISE NOTICE '';
    RAISE NOTICE 'MELHOR ANIME DO ANO:';
    RAISE NOTICE '   • Nome: %', v_melhor_anime;
    RAISE NOTICE '   • Score: %', v_score_melhor_anime;
    RAISE NOTICE '   • Rank Global: #%', v_rank_melhor_anime;
    RAISE NOTICE '';
    RAISE NOTICE 'DESTAQUES:';
    RAISE NOTICE '   • Gênero mais Popular: %', v_top_genero;
    RAISE NOTICE '   • Estúdio mais Ativo: %', v_top_studio;
    RAISE NOTICE '   • Produtora mais Ativa: %', v_top_produtor;
    RAISE NOTICE '══════════════════════════════════════════════════════════════════';
    RAISE NOTICE '';

end;
$$language plpgsql;